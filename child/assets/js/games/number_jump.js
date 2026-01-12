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
            targetX: null, 
            faceDirection: 1, // 1 = right, -1 = left
            frame: 0
        };
        
        this.gravity = 0.6;
        this.platforms = [];
        this.particles = [];
        this.cameraX = 0; 
        
        // Background Layers for Parallax
        this.bgLayers = [
            { x: 0, speed: 0.2, color: "#81C784" }, // Far hills
            { x: 0, speed: 0.5, color: "#4CAF50" }  // Near bushes
        ];
        
        // Game State
        this.score = 0;
        this.targetNumber = Math.floor(Math.random() * 10) + 1;
        this.message = "Jump on " + this.targetNumber + "!";
        this.messageTimer = 0;
        
        // Generate initial platforms
        this.createStartPlatforms();
    }

    createStartPlatforms() {
        // Start platform
        this.platforms.push({
            x: 50, y: 400, width: 150, height: 40,
            number: null, color: '#8D6E63' // Wood log color
        });

        // Generate 3 numbered platforms
        for(let i=0; i<3; i++) {
            this.addPlatform(300 + i * 280);
        }
        this.ensureTargetExists();
    }

    addPlatform(x) {
        this.platforms.push({
            x: x,
            y: 350 + Math.random() * 100,
            width: 130,
            height: 45,
            number: Math.floor(Math.random() * 10) + 1,
            color: '#8D6E63' // Wood
        });
    }

    ensureTargetExists() {
        let found = false;
        let upcoming = this.platforms.filter(p => p.x > this.player.x + 50 && p.number !== null);
        
        upcoming.forEach(p => { if(p.number === this.targetNumber) found = true; });

        if(!found && upcoming.length > 0) {
            upcoming[Math.floor(Math.random() * upcoming.length)].number = this.targetNumber;
        }
    }

    update() {
        // 1. Physics
        if (this.player.isJumping) {
            this.player.x += this.player.vx;
            this.player.y += this.player.vy;
            this.player.vy += this.gravity;

            // Landing Logic
            if (this.player.vy > 0 && this.player.targetPlatform) {
                const p = this.player.targetPlatform;
                if (Math.abs(this.player.x - (p.x + p.width/2 - 30)) < 15 && this.player.y >= p.y - 55) {
                    this.landOn(p);
                }
            }
        } else {
            // Idle bobbing
            this.player.y = this.player.y + Math.sin(Date.now() * 0.005) * 0.3;
        }

        // 2. Camera Scroll
        let targetCamX = this.player.x - 200;
        if (targetCamX < 0) targetCamX = 0;
        this.cameraX += (targetCamX - this.cameraX) * 0.1;

        // 3. Platform Management
        if (this.platforms[0].x + this.platforms[0].width < this.cameraX - 100) {
            this.platforms.shift();
            let lastX = this.platforms[this.platforms.length-1].x;
            this.addPlatform(lastX + 280 + Math.random() * 50);
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

        if (this.messageTimer > 0) this.messageTimer--;
    }

    landOn(platform) {
        this.player.isJumping = false;
        this.player.vx = 0;
        this.player.vy = 0;
        this.player.y = platform.y - 55;
        this.createWaterSplash(this.player.x + 30, platform.y + 20);

        if (platform.number === this.targetNumber) {
            this.addScore(10);
            this.message = "Awesome! 🎉";
            this.messageTimer = 60;
            this.targetNumber = Math.floor(Math.random() * 10) + 1;
            this.ensureTargetExists();
            this.createConfetti(this.player.x, this.player.y);
        } else if (platform.number !== null) {
            this.message = "Oops! Find " + this.targetNumber;
            this.messageTimer = 60;
        }
    }

    jumpTo(platform) {
        if (this.player.isJumping) return;

        this.player.isJumping = true;
        this.player.targetPlatform = platform;
        
        let dx = (platform.x + platform.width/2 - 30) - this.player.x;
        let dy = (platform.y - 55) - this.player.y;
        let time = 45; 
        
        this.player.vx = dx / time;
        this.player.vy = (dy - 0.5 * this.gravity * time * time) / time;
        this.player.faceDirection = (dx > 0) ? 1 : -1;
    }

    draw() {
        this.ctx.save();
        
        // --- BACKGROUND ---
        // Sky
        let grad = this.ctx.createLinearGradient(0, 0, 0, 600);
        grad.addColorStop(0, "#4FC3F7"); 
        grad.addColorStop(1, "#E1F5FE");
        this.ctx.fillStyle = grad;
        this.ctx.fillRect(0, 0, 800, 600);

        // Parallax Hills
        this.ctx.save();
        this.ctx.translate(-this.cameraX * 0.2, 0); // Slow scroll
        this.ctx.fillStyle = "#AED581";
        this.ctx.beginPath();
        this.ctx.moveTo(0, 600);
        for(let i=0; i<10000; i+=200) {
            this.ctx.bezierCurveTo(i+50, 400, i+150, 400, i+200, 600);
        }
        this.ctx.lineTo(0, 600);
        this.ctx.fill();
        this.ctx.restore();

        // Water
        this.ctx.fillStyle = "rgba(41, 182, 246, 0.6)";
        this.ctx.fillRect(0, 500, 800, 100);
        
        // Apply Camera
        this.ctx.translate(-this.cameraX, 0);

        // --- PLATFORMS ---
        this.platforms.forEach(p => {
            // Log Shadow
            this.ctx.fillStyle = "rgba(0,0,0,0.2)";
            this.ctx.beginPath();
            this.ctx.roundRect(p.x + 5, p.y + 5, p.width, p.height, 10);
            this.ctx.fill();

            // Log
            this.ctx.fillStyle = "#795548";
            this.ctx.beginPath();
            this.ctx.roundRect(p.x, p.y, p.width, p.height, 10);
            this.ctx.fill();
            
            // Wood Grain
            this.ctx.strokeStyle = "#5D4037";
            this.ctx.lineWidth = 2;
            this.ctx.beginPath();
            this.ctx.moveTo(p.x + 10, p.y + 10); this.ctx.lineTo(p.x + p.width - 10, p.y + 10);
            this.ctx.moveTo(p.x + 20, p.y + 30); this.ctx.lineTo(p.x + p.width - 20, p.y + 30);
            this.ctx.stroke();

            // Number
            if (p.number !== null) {
                this.ctx.fillStyle = "#FFF";
                this.ctx.font = "bold 32px 'Fredoka One', Arial";
                this.ctx.textAlign = "center";
                this.ctx.fillText(p.number, p.x + p.width/2, p.y + 34);
            }
        });

        // --- PLAYER ---
        this.drawFrog(this.player.x, this.player.y, this.player.faceDirection);

        // --- PARTICLES ---
        this.particles.forEach(p => {
            this.ctx.fillStyle = p.color;
            this.ctx.beginPath();
            this.ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2);
            this.ctx.fill();
        });

        this.ctx.restore();

        // --- HUD ---
        this.ctx.fillStyle = "#FFF";
        this.ctx.roundRect(200, 20, 400, 70, 20);
        this.ctx.fill();
        this.ctx.strokeStyle = "#43A047";
        this.ctx.lineWidth = 4;
        this.ctx.strokeRect(200, 20, 400, 70);

        this.ctx.fillStyle = "#2E7D32";
        this.ctx.font = "bold 35px 'Fredoka One', Arial";
        this.ctx.textAlign = "center";
        this.ctx.fillText("Find Number: " + this.targetNumber, 400, 68);

        // Message
        if (this.messageTimer > 0) {
            this.ctx.save();
            this.ctx.translate(400, 250);
            let scale = 1 + Math.sin(Date.now() * 0.01) * 0.1;
            this.ctx.scale(scale, scale);
            
            this.ctx.shadowColor="black"; this.ctx.shadowBlur=10;
            this.ctx.fillStyle = "#FFCA28";
            this.ctx.font = "bold 50px 'Fredoka One', Arial";
            this.ctx.textAlign = "center";
            this.ctx.fillText(this.message, 0, 0);
            this.ctx.restore();
        }
        
        this.ctx.restore();
    }

    drawFrog(x, y, dir) {
        const ctx = this.ctx;
        ctx.save();
        ctx.translate(x + 30, y + 30);
        ctx.scale(dir, 1);

        // Shadow
        if(!this.player.isJumping) {
            ctx.fillStyle = "rgba(0,0,0,0.2)";
            ctx.beginPath(); ctx.ellipse(0, 25, 20, 5, 0, 0, Math.PI*2); ctx.fill();
        }

        // Body
        ctx.fillStyle = "#66BB6A";
        ctx.beginPath();
        ctx.ellipse(0, 5, 25, 20, 0, 0, Math.PI*2);
        ctx.fill();

        // Belly
        ctx.fillStyle = "#C8E6C9";
        ctx.beginPath();
        ctx.ellipse(0, 8, 15, 12, 0, 0, Math.PI*2);
        ctx.fill();

        // Eyes
        ctx.fillStyle = "#FFF";
        ctx.beginPath(); ctx.arc(-12, -10, 8, 0, Math.PI*2); ctx.fill();
        ctx.beginPath(); ctx.arc(12, -10, 8, 0, Math.PI*2); ctx.fill();
        
        ctx.fillStyle = "#000";
        ctx.beginPath(); ctx.arc(-12, -10, 3, 0, Math.PI*2); ctx.fill();
        ctx.beginPath(); ctx.arc(12, -10, 3, 0, Math.PI*2); ctx.fill();

        // Legs
        ctx.strokeStyle = "#43A047";
        ctx.lineWidth = 6;
        ctx.lineCap = "round";
        if (this.player.isJumping) {
            ctx.beginPath();
            ctx.moveTo(-15, 15); ctx.lineTo(-25, 35);
            ctx.moveTo(15, 15); ctx.lineTo(25, 35);
            ctx.stroke();
        } else {
            ctx.beginPath();
            ctx.moveTo(-15, 15); ctx.lineTo(-25, 25); ctx.lineTo(-15, 25);
            ctx.moveTo(15, 15); ctx.lineTo(25, 25); ctx.lineTo(15, 25);
            ctx.stroke();
        }

        ctx.restore();
    }

    createWaterSplash(x, y) {
        for(let i=0; i<10; i++) {
            this.particles.push({
                x: x, y: y,
                vx: (Math.random() - 0.5) * 8,
                vy: -Math.random() * 5,
                life: 30,
                color: "rgba(255, 255, 255, 0.8)",
                size: Math.random() * 5
            });
        }
    }

    createConfetti(x, y) {
        const colors = ['#F44336', '#2196F3', '#FFEB3B', '#4CAF50'];
        for(let i=0; i<20; i++) {
            this.particles.push({
                x: x, y: y - 50,
                vx: (Math.random() - 0.5) * 10,
                vy: (Math.random() - 0.5) * 10,
                life: 60,
                color: colors[Math.floor(Math.random() * colors.length)],
                size: Math.random() * 6 + 2
            });
        }
    }

    handleInput(e) {
        if(e.type === 'mousedown' || e.type === 'touchstart') {
            const pos = this.getPos(e);
            const worldX = pos.x + this.cameraX;
            const worldY = pos.y;
            this.platforms.forEach(p => {
                if(worldX > p.x && worldX < p.x + p.width && worldY > p.y && worldY < p.y + p.height) {
                    if(!this.player.isJumping) this.jumpTo(p);
                }
            });
        }
    }
}

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