class ShapeBuilderGame extends GameEngine {
    init() {
        // Available shapes
        this.shapeTypes = ['square', 'circle', 'triangle', 'star', 'hexagon'];
        this.colors = ['#FF6B6B', '#4ECDC4', '#FFD93D', '#A8E6CF', '#FF9F43'];
        
        // Randomly select 3 target shapes for this round
        this.targets = [];
        this.draggables = [];
        this.particles = [];
        this.message = "";
        this.messageTimer = 0;
        
        // Pick 3 unique shapes
        let available = [...this.shapeTypes];
        available.sort(() => Math.random() - 0.5);
        let roundShapes = available.slice(0, 3);
        
        // Setup Targets (Slots)
        roundShapes.forEach((type, i) => {
            this.targets.push({
                type: type,
                x: 200 + i * 200,
                y: 400,
                width: 100,
                height: 100,
                filled: false,
                color: '#EEE' // Placeholder color
            });
            
            // Setup Draggables (Scattered)
            this.draggables.push({
                type: type,
                x: 100 + Math.random() * 600,
                y: 100 + Math.random() * 100,
                originalX: 0, // Set below
                originalY: 0,
                width: 80,
                height: 80,
                color: this.colors[Math.floor(Math.random() * this.colors.length)],
                isDragging: false,
                matched: false,
                face: Math.random() > 0.5 ? 'happy' : 'smile'
            });
        });
        
        // Organize draggables initial positions
        this.draggables.forEach((d, i) => {
            d.x = 150 + i * 250;
            d.y = 150;
            d.originalX = d.x;
            d.originalY = d.y;
        });
    }

    update() {
        // Particles
        for (let i = this.particles.length - 1; i >= 0; i--) {
            let p = this.particles[i];
            p.x += p.vx;
            p.y += p.vy;
            p.vy += 0.2;
            p.life--;
            if (p.life <= 0) this.particles.splice(i, 1);
        }

        // Message Timer
        if (this.messageTimer > 0) this.messageTimer--;
        
        // Check Win Condition
        if (this.draggables.every(d => d.matched) && this.messageTimer === 0) {
            this.message = "All Matched! 🎉";
            this.messageTimer = 60;
            setTimeout(() => this.init(), 1500);
        }
    }

    draw() {
        // 1. Draw Background (Wooden Board Table)
        this.ctx.fillStyle = "#D7CCC8"; // Light wood
        this.ctx.fillRect(0, 300, 800, 300);
        this.ctx.fillStyle = "#A1887F"; // Darker edge
        this.ctx.fillRect(0, 300, 800, 20);

        // 2. Draw Target Slots (Holes)
        this.targets.forEach(t => {
            this.ctx.save();
            this.ctx.translate(t.x, t.y);
            
            // Shadow/Inset effect
            this.ctx.shadowColor = "rgba(0,0,0,0.2)";
            this.ctx.shadowBlur = 0;
            this.ctx.shadowOffsetX = 0;
            this.ctx.shadowOffsetY = 0;
            
            this.ctx.fillStyle = "rgba(0,0,0,0.15)"; // Hole shadow
            this.drawShapePath(t.type, 0, 0, 100);
            this.ctx.fill();
            
            // Outline
            this.ctx.strokeStyle = "rgba(255,255,255,0.5)";
            this.ctx.lineWidth = 4;
            this.ctx.stroke();
            
            this.ctx.restore();
        });

        // 3. Draw Draggable Shapes
        this.draggables.forEach(d => {
            this.ctx.save();
            this.ctx.translate(d.x, d.y);
            
            if (d.isDragging) {
                this.ctx.shadowColor = "rgba(0,0,0,0.3)";
                this.ctx.shadowBlur = 10;
                this.ctx.shadowOffsetY = 10;
                this.ctx.scale(1.1, 1.1);
            }

            this.ctx.fillStyle = d.color;
            this.drawShapePath(d.type, 0, 0, 80);
            this.ctx.fill();
            
            // 3D Bevel Highlight
            this.ctx.strokeStyle = "rgba(255,255,255,0.4)";
            this.ctx.lineWidth = 4;
            this.ctx.stroke();

            // Face
            this.drawFace(0, 0, d.face);

            this.ctx.restore();
        });

        // 4. Particles
        this.particles.forEach(p => {
            this.ctx.fillStyle = p.color;
            this.ctx.beginPath();
            this.ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2);
            this.ctx.fill();
        });

        // 5. Instruction / Message
        this.ctx.fillStyle = "#5D4037";
        this.ctx.font = "bold 30px 'Fredoka One', Arial";
        this.ctx.textAlign = "center";
        
        if (this.message) {
             // Message Overlay
            this.ctx.fillStyle = "rgba(0,0,0,0.7)";
            this.ctx.roundRect(this.canvas.width/2 - 150, this.canvas.height/2 - 40, 300, 80, 20);
            this.ctx.fill();
            
            this.ctx.fillStyle = "#FFF";
            this.ctx.fillText(this.message, this.canvas.width/2, this.canvas.height/2 + 10);
        } else {
            this.ctx.fillText("Match the shapes!", 400, 50);
        }
    }

    drawShapePath(type, x, y, size) {
        const ctx = this.ctx;
        const s = size / 2;
        ctx.beginPath();
        
        if (type === 'square') {
            ctx.roundRect(x - s, y - s, size, size, 10);
        } else if (type === 'circle') {
            ctx.arc(x, y, s, 0, Math.PI * 2);
        } else if (type === 'triangle') {
            ctx.moveTo(x, y - s);
            ctx.lineTo(x + s, y + s);
            ctx.lineTo(x - s, y + s);
            ctx.closePath();
        } else if (type === 'hexagon') {
            for (let i = 0; i < 6; i++) {
                ctx.lineTo(x + s * Math.cos(i * 2 * Math.PI / 6), y + s * Math.sin(i * 2 * Math.PI / 6));
            }
            ctx.closePath();
        } else if (type === 'star') {
            let spikes = 5;
            let outerRadius = s;
            let innerRadius = s / 2;
            let rot = Math.PI / 2 * 3;
            let cx = x;
            let cy = y;
            let step = Math.PI / spikes;

            ctx.moveTo(cx, cy - outerRadius);
            for (let i = 0; i < spikes; i++) {
                ctx.lineTo(cx + Math.cos(rot) * outerRadius, cy + Math.sin(rot) * outerRadius);
                rot += step;
                ctx.lineTo(cx + Math.cos(rot) * innerRadius, cy + Math.sin(rot) * innerRadius);
                rot += step;
            }
            ctx.lineTo(cx, cy - outerRadius);
            ctx.closePath();
        }
    }

    drawFace(x, y, type) {
        const ctx = this.ctx;
        ctx.fillStyle = "rgba(0,0,0,0.6)"; // Dark eyes
        
        // Eyes
        ctx.beginPath();
        ctx.arc(x - 15, y - 10, 4, 0, Math.PI * 2);
        ctx.arc(x + 15, y - 10, 4, 0, Math.PI * 2);
        ctx.fill();
        
        // Mouth
        ctx.beginPath();
        ctx.strokeStyle = "rgba(0,0,0,0.6)";
        ctx.lineWidth = 3;
        ctx.arc(x, y + 5, 10, 0, Math.PI, false); // Smile
        ctx.stroke();
    }

    handleInput(e) {
        const pos = this.getPos(e);
        
        if(e.type === 'mousedown' || e.type === 'touchstart') {
            // Check draggables (reverse order)
            for (let i = this.draggables.length - 1; i >= 0; i--) {
                let d = this.draggables[i];
                if (d.matched) continue; // Skip already matched

                // Simple collision box (approximate for all shapes)
                if (Math.abs(pos.x - d.x) < 40 && Math.abs(pos.y - d.y) < 40) {
                    this.draggedShape = d;
                    d.isDragging = true;
                    
                    const moveHandler = (ev) => this.handleDrag(ev);
                    const upHandler = (ev) => {
                        this.handleDrop(ev);
                        this.canvas.removeEventListener('mousemove', moveHandler);
                        this.canvas.removeEventListener('touchmove', moveHandler);
                        this.canvas.removeEventListener('mouseup', upHandler);
                        this.canvas.removeEventListener('touchend', upHandler);
                    };
                    
                    this.canvas.addEventListener('mousemove', moveHandler);
                    this.canvas.addEventListener('touchmove', moveHandler);
                    this.canvas.addEventListener('mouseup', upHandler);
                    this.canvas.addEventListener('touchend', upHandler);
                    return;
                }
            }
        }
    }

    handleDrag(e) {
        if(this.draggedShape) {
            e.preventDefault();
            const pos = this.getPos(e);
            this.draggedShape.x = pos.x;
            this.draggedShape.y = pos.y;
        }
    }

    handleDrop(e) {
        if(this.draggedShape) {
            const d = this.draggedShape;
            let matched = false;
            
            // Check all targets
            this.targets.forEach(t => {
                if (Math.abs(d.x - t.x) < 50 && Math.abs(d.y - t.y) < 50) {
                    if (d.type === t.type) {
                        // Correct Match
                        matched = true;
                        d.matched = true;
                        d.x = t.x; // Snap
                        d.y = t.y;
                        this.addScore(20);
                        this.createParticles(d.x, d.y, d.color);
                    }
                }
            });

            if (!matched) {
                // Return to start
                d.x = d.originalX;
                d.y = d.originalY;
            }
            
            this.draggedShape.isDragging = false;
            this.draggedShape = null;
        }
    }

    createParticles(x, y, color) {
        for(let i=0; i<15; i++) {
            this.particles.push({
                x: x,
                y: y,
                vx: (Math.random() - 0.5) * 8,
                vy: (Math.random() - 0.5) * 8,
                life: 20 + Math.random() * 10,
                color: color,
                size: Math.random() * 4 + 2
            });
        }
    }
}

// Helper for rounded rectangles if not supported
if (!CanvasRenderingContext2D.prototype.roundRect) {
    CanvasRenderingContext2D.prototype.roundRect = function (x, y, w, h, r) {
        if (w < 2 * r) r = w / 2;
        if (h < 2 * r) r = h / 2;
        this.beginPath();
        this.moveTo(x + r, y);
        this.arcTo(x + w, y, x + w, y + h, r);
        this.arcTo(x + w, y + h, x, y + h, r);
        this.arcTo(x, y + h, x, y, r);
        this.arcTo(x, y, x + w, y, r);
        this.closePath();
        return this;
    };
}

const game = new ShapeBuilderGame('gameCanvas');
