document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('drawingCanvas');
    const ctx = canvas.getContext('2d');
    const container = document.getElementById('canvasContainer');
    
    // State
    let isDrawing = false;
    let currentTool = 'brush';
    let currentColor = 'black';
    let currentSize = 5;
    let startX, startY;
    let snapshot; // To save canvas state for shapes

    // Setup Canvas Resolution
    function resizeCanvas() {
        canvas.width = container.clientWidth;
        canvas.height = container.clientHeight; // Or fixed 500
        ctx.fillStyle = "white";
        ctx.fillRect(0, 0, canvas.width, canvas.height);
    }
    resizeCanvas();
    // Ideally handle window resize, but skipping for simplicity as it clears canvas

    // --- TOOL SELECTION ---
    document.querySelectorAll('.tool-btn').forEach(btn => {
        btn.addEventListener('click', (e) => {
            document.querySelectorAll('.tool-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentTool = btn.dataset.tool;
        });
    });

    // --- COLOR SELECTION ---
    document.querySelectorAll('.color-btn').forEach(btn => {
        btn.addEventListener('click', (e) => {
            document.querySelectorAll('.color-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentColor = btn.dataset.color;
        });
    });

    // --- SIZE SELECTION ---
    document.getElementById('sizeSlider').addEventListener('input', (e) => {
        currentSize = e.target.value;
    });

    // --- UTILS ---
    const getPos = (e) => {
        const rect = canvas.getBoundingClientRect();
        // Support touch
        if(e.touches) {
            return {
                x: e.touches[0].clientX - rect.left,
                y: e.touches[0].clientY - rect.top
            };
        }
        return {
            x: e.clientX - rect.left,
            y: e.clientY - rect.top
        };
    };

    const startDraw = (e) => {
        isDrawing = true;
        ctx.beginPath(); // Start new path
        const pos = getPos(e);
        startX = pos.x;
        startY = pos.y;
        
        ctx.lineWidth = currentSize;
        ctx.lineCap = 'round';
        ctx.lineJoin = 'round';
        ctx.strokeStyle = currentColor;

        if (currentTool === 'eraser') {
            ctx.strokeStyle = 'white';
        }

        // Fill Tool Logic
        if (currentTool === 'fill') {
            floodFill(startX, startY, currentColor);
            isDrawing = false; // Fill is one-time action
            return;
        }

        // Snapshot for shapes
        if (['rect', 'circle', 'line'].includes(currentTool)) {
            snapshot = ctx.getImageData(0, 0, canvas.width, canvas.height);
        } else {
            // For brush/pencil, start drawing immediately
            ctx.beginPath();
            ctx.moveTo(startX, startY);
            
            // Brush vs Pencil Style
            if (currentTool === 'brush') {
                ctx.shadowBlur = 2;
                ctx.shadowColor = currentColor;
            } else {
                ctx.shadowBlur = 0;
            }
            ctx.lineTo(startX, startY); // Initial dot
            ctx.stroke();
        }
    };

    const draw = (e) => {
        if (!isDrawing) return;
        e.preventDefault(); // Prevent scrolling on touch
        
        const pos = getPos(e);

        if (['brush', 'pencil', 'eraser'].includes(currentTool)) {
            ctx.lineTo(pos.x, pos.y);
            ctx.stroke();
        } else if (currentTool === 'rect') {
            ctx.putImageData(snapshot, 0, 0); // Restore old canvas
            ctx.strokeRect(startX, startY, pos.x - startX, pos.y - startY);
        } else if (currentTool === 'circle') {
            ctx.putImageData(snapshot, 0, 0);
            ctx.beginPath();
            let radius = Math.sqrt(Math.pow(pos.x - startX, 2) + Math.pow(pos.y - startY, 2));
            ctx.arc(startX, startY, radius, 0, 2 * Math.PI);
            ctx.stroke();
        } else if (currentTool === 'line') {
            ctx.putImageData(snapshot, 0, 0);
            ctx.beginPath();
            ctx.moveTo(startX, startY);
            ctx.lineTo(pos.x, pos.y);
            ctx.stroke();
        }
    };

    const stopDraw = () => {
        isDrawing = false;
        ctx.beginPath(); // Reset path
    };

    // --- EVENTS ---
    canvas.addEventListener('mousedown', startDraw);
    canvas.addEventListener('mousemove', draw);
    canvas.addEventListener('mouseup', stopDraw);
    canvas.addEventListener('mouseout', stopDraw);
    
    // Touch support
    canvas.addEventListener('touchstart', startDraw);
    canvas.addEventListener('touchmove', draw);
    canvas.addEventListener('touchend', stopDraw);

    // --- ACTIONS ---
    document.getElementById('clearBtn').addEventListener('click', () => {
        if(confirm('Are you sure you want to clear your beautiful drawing?')) {
            ctx.fillStyle = "white";
            ctx.fillRect(0, 0, canvas.width, canvas.height);
        }
    });

    document.getElementById('saveBtn').addEventListener('click', () => {
        const dataURL = canvas.toDataURL('image/png');
        
        // Simple AJAX
        const btn = document.getElementById('saveBtn');
        const originalText = btn.innerText;
        btn.innerText = 'Saving...';
        btn.disabled = true;

        fetch('save_drawing.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ image: dataURL })
        })
        .then(res => res.json())
        .then(data => {
            if(data.success) {
                alert('Drawing Saved! 🎉');
            } else {
                alert('Error saving: ' + data.message);
            }
        })
        .catch(err => alert('Network Error'))
        .finally(() => {
            btn.innerText = originalText;
            btn.disabled = false;
        });
    });
});
