class NumberJumpGame extends GameEngine {
    init() {
        // Player (Frog)
        this.player = { 
            x: 100, 
            y: 350, 
            width: 60, 
            height: 60, 
            vx: 0,
            vy: 0, 
            isJumping: false,
            targetX: null, // Where we are jumping to
            faceDirection: 1 // 1 = right, -1 = left
        };
        
        this.gravity = 0.6;
        this.platforms = [];
        this.particles = [];
        this.cameraX = 0; // For scrolling
        
        // Game State
        this.score = 0;
        this.targetNumber = Math.floor(Math.random() * 10) + 1;
        this.message = "Jump on " + this.targetNumber + "!";
        this.messageTimer = 0;
        
        // Generate initial platforms
        this.createStartPlatforms();
    }

    createStartPlatforms() {
        // Start platform (safe zone)
        this.platforms.push({
            x: 50,
            y: 400,
            width: 150,
            height: 40,
            number: null, // No number on start
            color: '#8BC34A'
        });

        // Generate 3 numbered platforms
        for(let i=0; i<3; i++) {
            this.addPlatform(300 + i * 250);
        }
        
        // Ensure one matches target
        this.ensureTargetExists();
    }

    addPlatform(x) {
        this.platforms.push({
            x: x,
            y: 350 + Math.random() * 100, // Varying height
            width: 120,
            height: 40,
            number: Math.floor(Math.random() * 10) + 1,
            color: '#4CAF50'
        });
    }

    ensureTargetExists() {
        // Check if target number exists in upcoming platforms (excluding the first safe one)
        let found = false;
        // Only check platforms ahead of player
        let upcoming = this.platforms.filter(p => p.x > this.player.x + 50 && p.number !== null);
        
        upcoming.forEach(p => {
            if(p.number === this.targetNumber) found = true;
        });

        if(!found && upcoming.length > 0) {
            // Force one to be the target
            upcoming[Math.floor(Math.random() * upcoming.length)].number = this.targetNumber;
        }
    }

    update() {
        // 1. Physics (Jump Arc)
        if (this.player.isJumping) {
            this.player.x += this.player.vx;
            this.player.y += this.player.vy;
            this.player.vy += this.gravity;

            // Check landing on target
            if (this.player.vy > 0 && this.player.targetPlatform) {
                const p = this.player.targetPlatform;
                // Simple proximity check for "landing"
                if (Math.abs(this.player.x - (p.x + p.width/2 - 30)) < 10 && this.player.y >= p.y - 50) {
                    this.landOn(p);
                }
            }
        } else {
            // Idle bobbing
            this.player.y = this.player.y + Math.sin(Date.now() * 0.005) * 0.5;
        }

        // 2. Camera Scroll (Keep player on left side)
        let targetCamX = this.player.x - 150;
        if (targetCamX < 0) targetCamX = 0;
        // Smooth follow
        this.cameraX += (targetCamX - this.cameraX) * 0.1;

        // 3. Platform Management (Infinite Runner)
        // Remove platforms too far left
        if (this.platforms[0].x + this.platforms[0].width < this.cameraX - 100) {
            this.platforms.shift();
            // Add new one far right
            let lastX = this.platforms[this.platforms.length-1].x;
            this.addPlatform(lastX + 250 + Math.random() * 50);
            this.ensureTargetExists();
        }

        // 4. Particles
        for (let i = this.particles.length - 1; i >= 0; i--) {
            let p = this.particles[i];
            p.x += p.vx;
            p.y += p.vy;
            p.vy += 0.2;
            p.life--;
            if (p.life <= 0) this.particles.splice(i, 1);
        }

        // 5. Message Timer
        if (this.messageTimer > 0) this.messageTimer--;
    }

    landOn(platform) {
        this.player.isJumping = false;
        this.player.vx = 0;
        this.player.vy = 0;
        this.player.y = platform.y - 50; // Sit on top
        this.createParticles(this.player.x + 30, this.player.y + 60, '#FFF'); // Dust

        // Check Logic
        if (platform.number === this.targetNumber) {
            // Correct!
            this.addScore(10);
            this.message = "Great Job! 🎉";
            this.messageTimer = 60;
            this.targetNumber = Math.floor(Math.random() * 10) + 1; // New Target
            this.ensureTargetExists();
        } else if (platform.number !== null) {
            // Wrong
            this.message = "Oops! Find " + this.targetNumber;
            this.messageTimer = 60;
            // Penalty? Maybe shake
        }
    }

    jumpTo(platform) {
        if (this.player.isJumping) return;

        this.player.isJumping = true;
        this.player.targetPlatform = platform;
        
        // Calculate physics to hit target
        // Distance
        let dx = (platform.x + platform.width/2 - 30) - this.player.x;
        let dy = (platform.y - 50) - this.player.y;

        // Arbitrary flight time based on distance
        let time = 40; 
        
        this.player.vx = dx / time;
        // y = vy*t + 0.5*g*t^2  => vy = (y - 0.5*g*t^2) / t
        this.player.vy = (dy - 0.5 * this.gravity * time * time) / time;
        
        // Face direction
        this.player.faceDirection = (dx > 0) ? 1 : -1;
    }

    draw() {
        this.ctx.save();
        this.ctx.translate(-this.cameraX, 0);

        // 1. Draw Background (Sky & Hills)
        // Since we translate, we need to draw background relative to camera or fixed
        // Let's draw a fixed sky by untranslating briefly? No, let's just draw big rects
        // Actually, simple gradient sky
        let grad = this.ctx.createLinearGradient(0, 0, 0, 600);
        grad.addColorStop(0, "#87CEEB"); // Sky Blue
        grad.addColorStop(1, "#E0F7FA");
        this.ctx.fillStyle = grad;
        this.ctx.fillRect(this.cameraX, 0, 800, 600); // Fill visible screen

        // 2. Draw Platforms (Lily Pads)
        this.platforms.forEach(p => {
            // Lily Pad Shape (Green Ellipse)
            this.ctx.fillStyle = p.color;
            this.ctx.beginPath();
            this.ctx.ellipse(p.x + p.width/2, p.y + 10, p.width/2, p.height/2, 0, 0, Math.PI*2);
            this.ctx.fill();
            
            // Darker green outline
            this.ctx.strokeStyle = "#2E7D32";
            this.ctx.lineWidth = 3;
            this.ctx.stroke();

            // Number
            if (p.number !== null) {
                this.ctx.fillStyle = "white";
                this.ctx.font = "bold 30px 'Fredoka One', Arial";
                this.ctx.textAlign = "center";
                this.ctx.shadowColor = "rgba(0,0,0,0.3)";
                this.ctx.shadowBlur = 4;
                this.ctx.fillText(p.number, p.x + p.width/2, p.y + 18);
                this.ctx.shadowBlur = 0; // Reset
            }
        });

        // 3. Draw Player (Frog)
        this.drawFrog(this.player.x, this.player.y, this.player.faceDirection);

        // 4. Particles
        this.particles.forEach(p => {
            this.ctx.fillStyle = p.color;
            this.ctx.beginPath();
            this.ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2);
            this.ctx.fill();
        });

        this.ctx.restore();

        // 5. UI Overlay (Fixed position)
        // Target Instruction
        this.ctx.fillStyle = "rgba(255, 255, 255, 0.9)";
        this.ctx.roundRect(200, 20, 400, 60, 30);
        this.ctx.fill();
        this.ctx.strokeStyle = "#FF9800";
        this.ctx.lineWidth = 4;
        this.ctx.strokeRect(200, 20, 400, 60);

        this.ctx.fillStyle = "#E65100";
        this.ctx.font = "bold 30px 'Fredoka One', Arial";
        this.ctx.textAlign = "center";
        this.ctx.fillText("Jump on number: " + this.targetNumber, 400, 60);

        // Message Overlay
        if (this.messageTimer > 0) {
            this.ctx.save();
            this.ctx.translate(400, 300);
            let scale = 1 + Math.sin(Date.now() * 0.01) * 0.1;
            this.ctx.scale(scale, scale);
            
            this.ctx.fillStyle = "rgba(0,0,0,0.7)";
            this.ctx.roundRect(-150, -40, 300, 80, 20);
            this.ctx.fill();
            
            this.ctx.fillStyle = "#FFF";
            this.ctx.font = "bold 30px 'Fredoka One', Arial";
            this.ctx.textAlign = "center";
            this.ctx.fillText(this.message, 0, 10);
            
            this.ctx.restore();
        }
    }

    drawFrog(x, y, dir) {
        const ctx = this.ctx;
        ctx.save();
        ctx.translate(x + 30, y + 30); // Center pivot
        ctx.scale(dir, 1); // Flip if facing left

        // Body
        ctx.fillStyle = "#66BB6A"; // Frog Green
        ctx.beginPath();
        ctx.arc(0, 10, 25, 0, Math.PI * 2); // Main body
        ctx.fill();

        // Eyes
        ctx.fillStyle = "white";
        ctx.beginPath();
        ctx.arc(-12, -10, 10, 0, Math.PI * 2); // Left Eye
        ctx.arc(12, -10, 10, 0, Math.PI * 2); // Right Eye
        ctx.fill();
        
        // Pupils
        ctx.fillStyle = "black";
        ctx.beginPath();
        ctx.arc(-12, -10, 4, 0, Math.PI * 2);
        ctx.arc(12, -10, 4, 0, Math.PI * 2);
        ctx.fill();

        // Smile
        ctx.strokeStyle = "#1B5E20";
        ctx.lineWidth = 2;
        ctx.beginPath();
        ctx.arc(0, 10, 10, 0, Math.PI, false);
        ctx.stroke();

        // Legs (Simple lines)
        if (this.player.isJumping) {
            // Stretched legs
            ctx.strokeStyle = "#66BB6A";
            ctx.lineWidth = 8;
            ctx.lineCap = "round";
            ctx.beginPath();
            ctx.moveTo(-15, 25); ctx.lineTo(-25, 40); // Back Leg
            ctx.moveTo(15, 25); ctx.lineTo(25, 40); // Front Leg
            ctx.stroke();
        } else {
            // Sitting legs
            ctx.fillStyle = "#43A047";
            ctx.beginPath();
            ctx.ellipse(-20, 25, 10, 5, Math.PI/4, 0, Math.PI*2);
            ctx.ellipse(20, 25, 10, 5, -Math.PI/4, 0, Math.PI*2);
            ctx.fill();
        }

        ctx.restore();
    }

    createParticles(x, y, color) {
        for(let i=0; i<10; i++) {
            this.particles.push({
                x: x,
                y: y,
                vx: (Math.random() - 0.5) * 5,
                vy: (Math.random() - 0.5) * 5,
                life: 20 + Math.random() * 10,
                color: color,
                size: Math.random() * 4 + 2
            });
        }
    }

    handleInput(e) {
        if(e.type === 'mousedown' || e.type === 'touchstart') {
            const pos = this.getPos(e);
            // Adjust click pos for camera
            const worldX = pos.x + this.cameraX;
            const worldY = pos.y;

            // Check if clicked a platform
            this.platforms.forEach(p => {
                if(worldX > p.x && worldX < p.x + p.width && worldY > p.y && worldY < p.y + p.height) {
                    // Only jump if not already jumping
                    if(!this.player.isJumping) {
                        this.jumpTo(p);
                    }
                }
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

const game = new NumberJumpGame('gameCanvas');
