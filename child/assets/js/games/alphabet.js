class AlphabetGame extends GameEngine {
    init() {
        this.letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        this.targetLetter = this.letters[Math.floor(Math.random() * this.letters.length)];
        this.objects = [];
        this.draggables = [];
        this.draggedItem = null;
        this.particles = [];
        this.message = "";
        this.messageTimer = 0;
        this.streak = 0;
        
        // Colors for bubbles
        this.colors = ['#FF6B6B', '#4ECDC4', '#FFD93D', '#FF9F43', '#A8E6CF'];
        
        // Spawn 3 random letters
        for(let i=0; i<3; i++) {
            let l = (i===0) ? this.targetLetter : this.letters[Math.floor(Math.random() * this.letters.length)];
            
            // Random start position but kept in top half
            let startX = 150 + i * 200;
            let startY = 150;

            this.draggables.push({
                char: l,
                x: startX,
                y: startY,
                originalX: startX,
                originalY: startY,
                radius: 40,
                color: this.colors[Math.floor(Math.random() * this.colors.length)],
                isDragging: false,
                floatOffset: Math.random() * 100, // For animation
                floatSpeed: 0.02 + Math.random() * 0.02
            });
        }
        
        // Shuffle positions
        this.draggables.sort(() => Math.random() - 0.5);
        
        // Target Box (Basket Style)
        this.targetBox = {
            x: 250,
            y: 400,
            width: 300,
            height: 150,
            label: "Drag '" + this.targetLetter + "' here!"
        };
    }

    update() {
        // Floating Animation for bubbles
        this.draggables.forEach(d => {
            if (!d.isDragging) {
                // Gentle sine wave motion
                d.y = d.originalY + Math.sin(Date.now() * 0.002 + d.floatOffset) * 10;
            }
        });

        // Update Particles (Confetti)
        for (let i = this.particles.length - 1; i >= 0; i--) {
            let p = this.particles[i];
            p.x += p.vx;
            p.y += p.vy;
            p.vy += 0.2; // Gravity
            p.life--;
            if (p.life <= 0) this.particles.splice(i, 1);
        }

        // Message Timer
        if (this.messageTimer > 0) this.messageTimer--;
        else this.message = "";
    }

    draw() {
        // 1. Draw Target Box (Basket/Toy Box Look)
        this.ctx.fillStyle = "rgba(255, 255, 255, 0.8)";
        this.ctx.roundRect(this.targetBox.x, this.targetBox.y, this.targetBox.width, this.targetBox.height, 20);
        this.ctx.fill();
        
        // Dashed Border
        this.ctx.strokeStyle = "#FF9F43";
        this.ctx.lineWidth = 4;
        this.ctx.setLineDash([10, 10]);
        this.ctx.strokeRect(this.targetBox.x, this.targetBox.y, this.targetBox.width, this.targetBox.height);
        this.ctx.setLineDash([]); // Reset

        // Target Label
        this.ctx.fillStyle = "#5D4037";
        this.ctx.font = "bold 24px 'Fredoka One', Arial";
        this.ctx.textAlign = "center";
        this.ctx.fillText(this.targetBox.label, this.targetBox.x + this.targetBox.width/2, this.targetBox.y + this.targetBox.height/2 + 10);

        // 2. Draw Connection Lines (if dragging)
        if (this.draggedItem) {
            this.ctx.beginPath();
            this.ctx.moveTo(this.draggedItem.x, this.draggedItem.y);
            this.ctx.lineTo(this.draggedItem.originalX, this.draggedItem.originalY);
            this.ctx.strokeStyle = "rgba(0,0,0,0.1)";
            this.ctx.lineWidth = 2;
            this.ctx.stroke();
        }

        // 3. Draw Letters (Bubbles)
        this.draggables.forEach(d => {
            // Shadow
            this.ctx.beginPath();
            this.ctx.arc(d.x + 3, d.y + 3, d.radius, 0, Math.PI * 2);
            this.ctx.fillStyle = "rgba(0,0,0,0.2)";
            this.ctx.fill();

            // Bubble Body
            this.ctx.beginPath();
            this.ctx.arc(d.x, d.y, d.radius, 0, Math.PI * 2);
            this.ctx.fillStyle = d.color;
            this.ctx.fill();
            
            // Shine/Reflection (Top Left)
            this.ctx.beginPath();
            this.ctx.arc(d.x - 10, d.y - 10, 8, 0, Math.PI * 2);
            this.ctx.fillStyle = "rgba(255,255,255,0.4)";
            this.ctx.fill();

            // Border
            this.ctx.strokeStyle = "white";
            this.ctx.lineWidth = 3;
            this.ctx.stroke();

            // Text
            this.ctx.fillStyle = "white";
            this.ctx.font = "bold 40px 'Fredoka One', Arial";
            this.ctx.textAlign = "center";
            this.ctx.textBaseline = "middle";
            this.ctx.fillText(d.char, d.x, d.y + 2);
        });

        // 4. Draw Particles
        this.particles.forEach(p => {
            this.ctx.fillStyle = p.color;
            this.ctx.beginPath();
            this.ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2);
            this.ctx.fill();
        });

        // 5. Draw Message Overlay
        if (this.message) {
            this.ctx.fillStyle = "rgba(0,0,0,0.7)";
            this.ctx.roundRect(this.canvas.width/2 - 150, this.canvas.height/2 - 40, 300, 80, 20);
            this.ctx.fill();
            
            this.ctx.fillStyle = "#FFF";
            this.ctx.font = "bold 30px 'Fredoka One', Arial";
            this.ctx.textAlign = "center";
            this.ctx.fillText(this.message, this.canvas.width/2, this.canvas.height/2 + 10);
        }
    }

    handleInput(e) {
        const pos = this.getPos(e);
        
        if(e.type === 'mousedown' || e.type === 'touchstart') {
            // Reverse loop to check top items first
            for (let i = this.draggables.length - 1; i >= 0; i--) {
                let d = this.draggables[i];
                // Circle collision detection
                let dx = pos.x - d.x;
                let dy = pos.y - d.y;
                if (Math.sqrt(dx*dx + dy*dy) < d.radius) {
                    this.draggedItem = d;
                    d.isDragging = true;
                    
                    // Add mousemove/up listeners
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
                    return; // Only drag one at a time
                }
            }
        }
    }

    handleDrag(e) {
        if(this.draggedItem) {
            e.preventDefault();
            const pos = this.getPos(e);
            this.draggedItem.x = pos.x;
            this.draggedItem.y = pos.y;
        }
    }

    handleDrop(e) {
        if(this.draggedItem) {
            const d = this.draggedItem;
            const t = this.targetBox;
            
            // Simple box collision check for drop
            if (d.x > t.x && d.x < t.x + t.width &&
                d.y > t.y && d.y < t.y + t.height) {
                
                if(d.char === this.targetLetter) {
                    this.handleSuccess(d);
                } else {
                    this.handleFail(d);
                }
            } else {
                // Dropped outside, return to start
                d.isDragging = false;
                d.x = d.originalX;
                d.y = d.originalY;
            }
            
            this.draggedItem.isDragging = false;
            this.draggedItem = null;
        }
    }

    handleSuccess(item) {
        this.addScore(10);
        this.createParticles(item.x, item.y);
        this.message = "Correct! 🎉";
        this.messageTimer = 60; // 1 second
        
        setTimeout(() => {
            this.init(); // Next round
        }, 1000);
    }

    handleFail(item) {
        this.message = "Try Again! 😅";
        this.messageTimer = 40;
        
        // Shake/Return animation could go here, for now just snap back
        item.x = item.originalX;
        item.y = item.originalY;
    }

    createParticles(x, y) {
        for(let i=0; i<20; i++) {
            this.particles.push({
                x: x,
                y: y,
                vx: (Math.random() - 0.5) * 10,
                vy: (Math.random() - 0.5) * 10,
                life: 30 + Math.random() * 20,
                color: this.colors[Math.floor(Math.random() * this.colors.length)],
                size: Math.random() * 5 + 2
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

// Start Game
const game = new AlphabetGame('gameCanvas');
