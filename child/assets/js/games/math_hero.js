class MathHeroGame extends GameEngine {
    init() {
        // Game State
        this.level = this.level || 1; 
        this.maxHealth = 100;
        this.turnState = 'INPUT'; // INPUT, ATTACKING, HIT, ENEMY_TURN, ENEMY_ATTACKING
        
        this.hero = { 
            x: 150, y: 340, 
            baseX: 150, baseY: 340,
            health: this.maxHealth, 
            maxHealth: this.maxHealth,
            color: '#3498db',
            state: 'IDLE', // IDLE, DASH, ATTACK, RETURN, HIT
            animTimer: 0
        };
        
        this.enemy = { 
            x: 600, y: 340, 
            baseX: 600, baseY: 340,
            health: this.maxHealth, 
            maxHealth: this.maxHealth,
            color: '#e74c3c',
            type: Math.floor(Math.random() * 3), 
            state: 'IDLE',
            animTimer: 0
        };
        
        this.floatingTexts = [];
        this.particles = [];
        this.message = "";
        this.messageTimer = 0;
        this.shakeTimer = 0;
        this.flashColor = null; 
        
        // Background elements (clouds)
        this.clouds = [
            {x: 100, y: 80, speed: 0.2},
            {x: 400, y: 120, speed: 0.3},
            {x: 700, y: 60, speed: 0.15}
        ];

        this.generateProblem();
    }

    generateProblem() {
        let maxNum = 5 + (this.level * 2);
        let isSubtraction = (this.level > 2 && Math.random() > 0.5);

        if(isSubtraction) {
            this.num1 = Math.floor(Math.random() * maxNum) + 2;
            this.num2 = Math.floor(Math.random() * (this.num1 - 1)) + 1; 
            this.operator = "-";
            this.correctAnswer = this.num1 - this.num2;
        } else {
            this.num1 = Math.floor(Math.random() * maxNum) + 1;
            this.num2 = Math.floor(Math.random() * maxNum) + 1;
            this.operator = "+";
            this.correctAnswer = this.num1 + this.num2;
        }
        
        let wrong1 = this.correctAnswer + Math.floor(Math.random() * 3) + 1;
        let wrong2 = this.correctAnswer - Math.floor(Math.random() * 3) - 1;
        if(wrong2 < 0) wrong2 = this.correctAnswer + 2; 
        
        this.options = [this.correctAnswer, wrong1, wrong2];
        this.options.sort(() => Math.random() - 0.5);

        this.optionBoxes = this.options.map((opt, i) => ({
            x: 130 + i * 200,
            y: 480,
            width: 160,
            height: 80,
            value: opt,
            color: '#FF9800',
            baseY: 480
        }));
    }

    update() {
        // --- TURN LOGIC & ANIMATION STATE MACHINE ---
        
        // Hero Animation Logic
        if(this.hero.state === 'DASH') {
            this.hero.x = this.lerp(this.hero.x, this.enemy.x - 100, 0.25);
            if(Math.abs(this.hero.x - (this.enemy.x - 100)) < 10) {
                this.hero.state = 'ATTACK';
                this.hero.animTimer = 15;
                // Deal Damage
                this.hitEnemy(25);
            }
        } else if(this.hero.state === 'ATTACK') {
            this.hero.animTimer--;
            if(this.hero.animTimer <= 0) this.hero.state = 'RETURN';
        } else if(this.hero.state === 'RETURN') {
            this.hero.x = this.lerp(this.hero.x, this.hero.baseX, 0.15);
            if(Math.abs(this.hero.x - this.hero.baseX) < 5) {
                this.hero.x = this.hero.baseX;
                this.hero.state = 'IDLE';
                this.turnState = 'INPUT';
                this.generateProblem(); // Next Question
            }
        }

        // Enemy Animation Logic
        if(this.enemy.state === 'DASH') {
            this.enemy.x = this.lerp(this.enemy.x, this.hero.x + 100, 0.25);
            if(Math.abs(this.enemy.x - (this.hero.x + 100)) < 10) {
                this.enemy.state = 'ATTACK';
                this.enemy.animTimer = 15;
                this.hitHero(20);
            }
        } else if(this.enemy.state === 'ATTACK') {
            this.enemy.animTimer--;
            if(this.enemy.animTimer <= 0) this.enemy.state = 'RETURN';
        } else if(this.enemy.state === 'RETURN') {
            this.enemy.x = this.lerp(this.enemy.x, this.enemy.baseX, 0.15);
            if(Math.abs(this.enemy.x - this.enemy.baseX) < 5) {
                this.enemy.x = this.enemy.baseX;
                this.enemy.state = 'IDLE';
                this.turnState = 'INPUT'; 
            }
        }

        // Background Cloud Movement
        this.clouds.forEach(c => {
            c.x += c.speed;
            if(c.x > 850) c.x = -100;
        });

        // Floating Texts
        for(let i = this.floatingTexts.length - 1; i >= 0; i--) {
            let t = this.floatingTexts[i];
            t.y -= 2; 
            t.life--;
            if(t.life <= 0) this.floatingTexts.splice(i, 1);
        }

        // Particles
        for(let i = this.particles.length - 1; i >= 0; i--) {
            let p = this.particles[i];
            p.x += p.vx;
            p.y += p.vy;
            p.life--;
            if(p.life <= 0) this.particles.splice(i, 1);
        }

        if(this.messageTimer > 0) this.messageTimer--;
        if(this.shakeTimer > 0) this.shakeTimer--;
    }

    draw() {
        // Screen Shake
        let shakeX = (this.shakeTimer > 0) ? (Math.random() - 0.5) * 20 : 0;
        let shakeY = (this.shakeTimer > 0) ? (Math.random() - 0.5) * 20 : 0;
        
        this.ctx.save();
        this.ctx.translate(shakeX, shakeY);

        // --- BACKGROUND ---
        // Sky Gradient
        let grad = this.ctx.createLinearGradient(0, 0, 0, 600);
        grad.addColorStop(0, "#2980b9");
        grad.addColorStop(1, "#6dd5fa");
        this.ctx.fillStyle = grad;
        this.ctx.fillRect(0, 0, 800, 600);

        // Sun
        this.ctx.fillStyle = "#f1c40f";
        this.ctx.beginPath(); this.ctx.arc(700, 80, 50, 0, Math.PI*2); this.ctx.fill();
        this.ctx.fillStyle = "rgba(241, 196, 15, 0.3)";
        this.ctx.beginPath(); this.ctx.arc(700, 80, 70, 0, Math.PI*2); this.ctx.fill();

        // Moving Clouds
        this.ctx.fillStyle = "rgba(255,255,255,0.8)";
        this.clouds.forEach(c => {
            this.drawCloud(c.x, c.y);
        });

        // Mountains (Parallax-ish)
        this.ctx.fillStyle = "#5D4037";
        this.ctx.beginPath(); this.ctx.moveTo(0, 450); this.ctx.lineTo(200, 250); this.ctx.lineTo(400, 450); this.ctx.fill();
        this.ctx.fillStyle = "#795548";
        this.ctx.beginPath(); this.ctx.moveTo(300, 450); this.ctx.lineTo(550, 200); this.ctx.lineTo(800, 450); this.ctx.fill();

        // Ground
        this.ctx.fillStyle = "#4CAF50";
        this.ctx.fillRect(0, 450, 800, 150);
        this.ctx.fillStyle = "#388E3C";
        this.ctx.fillRect(0, 450, 800, 20); // Grass top

        // --- HUD ---
        // Question Board
        this.ctx.save();
        this.ctx.shadowColor = "rgba(0,0,0,0.3)";
        this.ctx.shadowBlur = 10;
        this.ctx.shadowOffsetY = 5;
        this.ctx.fillStyle = "#fff";
        this.ctx.roundRect(200, 30, 400, 100, 20);
        this.ctx.fill();
        this.ctx.restore();

        this.ctx.fillStyle = "#2c3e50";
        this.ctx.font = "bold 60px 'Fredoka One', Arial";
        this.ctx.textAlign = "center";
        this.ctx.textBaseline = "middle";
        this.ctx.fillText(`${this.num1} ${this.operator} ${this.num2} = ?`, 400, 85);

        // --- CHARACTERS ---
        this.drawHero(this.hero.x, this.hero.y);
        this.drawEnemy(this.enemy.x, this.enemy.y);

        // --- HEALTH BARS ---
        this.drawHealthBar(this.hero.x, this.hero.y - 80, this.hero.health, this.hero.maxHealth, "#2ecc71", "HERO");
        this.drawHealthBar(this.enemy.x, this.enemy.y - 80, this.enemy.health, this.enemy.maxHealth, "#e74c3c", "VILLAIN");

        // --- PARTICLES ---
        this.particles.forEach(p => {
            this.ctx.fillStyle = p.color;
            this.ctx.beginPath();
            this.ctx.arc(p.x, p.y, p.size, 0, Math.PI*2);
            this.ctx.fill();
        });

        // --- FLOATING TEXT ---
        this.floatingTexts.forEach(t => {
            this.ctx.save();
            this.ctx.font = "bold 40px 'Fredoka One'";
            this.ctx.fillStyle = t.color;
            this.ctx.strokeStyle = "white";
            this.ctx.lineWidth = 4;
            this.ctx.strokeText(t.text, t.x, t.y);
            this.ctx.fillText(t.text, t.x, t.y);
            this.ctx.restore();
        });

        // --- OPTIONS (Buttons) ---
        if(this.turnState === 'INPUT') {
            this.optionBoxes.forEach(opt => {
                // Button 3D effect
                this.ctx.fillStyle = "#E65100"; // Shadow
                this.ctx.beginPath();
                this.ctx.roundRect(opt.x, opt.y + 10, opt.width, opt.height, 15);
                this.ctx.fill();

                this.ctx.fillStyle = opt.color; // Main
                this.ctx.beginPath();
                this.ctx.roundRect(opt.x, opt.y, opt.width, opt.height, 15);
                this.ctx.fill();

                // Gloss
                this.ctx.fillStyle = "rgba(255,255,255,0.2)";
                this.ctx.beginPath();
                this.ctx.roundRect(opt.x, opt.y, opt.width, opt.height/2, 15);
                this.ctx.fill();

                this.ctx.fillStyle = "white";
                this.ctx.font = "bold 40px 'Fredoka One', Arial";
                this.ctx.textAlign = "center";
                this.ctx.textBaseline = "middle";
                this.ctx.fillText(opt.value, opt.x + opt.width/2, opt.y + opt.height/2 + 5);
            });
        }

        // --- MESSAGES ---
        if(this.message) {
            this.ctx.fillStyle = "rgba(0,0,0,0.8)";
            this.ctx.roundRect(100, 200, 600, 120, 20);
            this.ctx.fill();
            
            this.ctx.fillStyle = "#f1c40f";
            this.ctx.font = "bold 50px 'Fredoka One', Arial";
            this.ctx.textAlign = "center";
            this.ctx.fillText(this.message, 400, 275);
        }

        // Flash Effect
        if(this.flashColor) {
            this.ctx.fillStyle = this.flashColor;
            this.ctx.globalAlpha = 0.4;
            this.ctx.fillRect(0,0,800,600);
            this.ctx.globalAlpha = 1.0;
            this.flashColor = null;
        }

        this.ctx.restore();
    }

    drawCloud(x, y) {
        this.ctx.beginPath();
        this.ctx.arc(x, y, 30, 0, Math.PI*2);
        this.ctx.arc(x+40, y-10, 40, 0, Math.PI*2);
        this.ctx.arc(x+80, y, 30, 0, Math.PI*2);
        this.ctx.fill();
    }

    drawHealthBar(x, y, current, max, color, label) {
        let width = 120;
        let height = 20;
        
        // Label
        this.ctx.fillStyle = "white";
        this.ctx.font = "bold 16px Arial";
        this.ctx.textAlign = "center";
        this.ctx.shadowColor="black"; this.ctx.shadowBlur=2;
        this.ctx.fillText(label, x + width/2, y - 5);
        this.ctx.shadowBlur=0;

        // Container
        this.ctx.fillStyle = "#222";
        this.ctx.roundRect(x - 4, y - 4, width + 8, height + 8, 10);
        this.ctx.fill();
        
        // Background
        this.ctx.fillStyle = "#444";
        this.ctx.roundRect(x, y, width, height, 6);
        this.ctx.fill();

        // Fill
        let fillWidth = (current / max) * width;
        if(fillWidth < 0) fillWidth = 0;
        this.ctx.fillStyle = color;
        this.ctx.roundRect(x, y, fillWidth, height, 6);
        this.ctx.fill();
    }

    drawHero(x, y) {
        if(this.hero.state === 'DEFEATED') return; // Don't draw if defeated

        const ctx = this.ctx;
        ctx.save();
        ctx.translate(x, y);
        
        // Bobbing
        if(this.hero.state === 'IDLE') ctx.translate(0, Math.sin(Date.now() * 0.005) * 5);

        // Shadow
        ctx.fillStyle = "rgba(0,0,0,0.3)";
        ctx.beginPath(); ctx.ellipse(0, 70, 40, 10, 0, 0, Math.PI*2); ctx.fill();

        // Cape
        ctx.fillStyle = "#e74c3c";
        ctx.beginPath();
        ctx.moveTo(-20, -30);
        ctx.quadraticCurveTo(-60, 20, -40, 60);
        ctx.lineTo(20, 60);
        ctx.quadraticCurveTo(60, 20, 20, -30);
        ctx.fill();

        // Body
        ctx.fillStyle = "#3498db";
        ctx.beginPath(); ctx.roundRect(-25, -30, 50, 80, 15); ctx.fill();

        // Head
        ctx.fillStyle = "#ffccbc"; // Skin
        ctx.beginPath(); ctx.arc(0, -45, 30, 0, Math.PI*2); ctx.fill();

        // Mask
        ctx.fillStyle = "#2980b9";
        ctx.beginPath(); ctx.roundRect(-28, -55, 56, 20, 5); ctx.fill();
        
        // Eyes
        ctx.fillStyle = "white";
        ctx.beginPath(); ctx.ellipse(-12, -45, 8, 5, 0, 0, Math.PI*2); ctx.fill();
        ctx.beginPath(); ctx.ellipse(12, -45, 8, 5, 0, 0, Math.PI*2); ctx.fill();

        // Emblem
        ctx.fillStyle = "#f1c40f";
        ctx.beginPath(); ctx.moveTo(0, -10); ctx.lineTo(-10, 5); ctx.lineTo(10, 5); ctx.fill();

        // Arms (Attack Animation)
        if(this.hero.state === 'ATTACK') {
             ctx.fillStyle = "#3498db";
             ctx.beginPath(); ctx.arc(40, -10, 15, 0, Math.PI*2); ctx.fill(); // Punching fist
             // Effect
             ctx.fillStyle = "rgba(255,255,255,0.7)";
             ctx.beginPath(); ctx.arc(60, -10, 30, 0, Math.PI*2); ctx.fill();
        } else {
             ctx.fillStyle = "#3498db";
             ctx.beginPath(); ctx.arc(-30, 0, 10, 0, Math.PI*2); ctx.fill(); 
             ctx.beginPath(); ctx.arc(30, 0, 10, 0, Math.PI*2); ctx.fill(); 
        }

        ctx.restore();
    }

    drawEnemy(x, y) {
        if(this.enemy.state === 'DEFEATED') {
            // Draw crush effect or nothing
            return; 
        }

        const ctx = this.ctx;
        ctx.save();
        ctx.translate(x, y);
        
        if(this.enemy.state === 'IDLE') ctx.translate(0, Math.sin(Date.now() * 0.004) * 5);
        if(this.enemy.state === 'HIT') ctx.filter = 'brightness(200%) hue-rotate(90deg)';

        // Shadow
        ctx.fillStyle = "rgba(0,0,0,0.3)";
        ctx.beginPath(); ctx.ellipse(0, 70, 40, 10, 0, 0, Math.PI*2); ctx.fill();

        if(this.enemy.type === 0) { // Slime Monster
            ctx.fillStyle = "#8e44ad";
            ctx.beginPath();
            ctx.moveTo(-40, 60);
            ctx.bezierCurveTo(-50, -20, 50, -20, 40, 60);
            ctx.fill();
            // Eyes
            ctx.fillStyle = "#f1c40f";
            ctx.beginPath(); ctx.arc(-15, 10, 10, 0, Math.PI*2); ctx.fill();
            ctx.beginPath(); ctx.arc(15, 10, 10, 0, Math.PI*2); ctx.fill();
            ctx.fillStyle = "black";
            ctx.beginPath(); ctx.arc(-15, 10, 3, 0, Math.PI*2); ctx.fill();
            ctx.beginPath(); ctx.arc(15, 10, 3, 0, Math.PI*2); ctx.fill();

        } else if (this.enemy.type === 1) { // Floating Eye
            ctx.fillStyle = "#e74c3c";
            ctx.beginPath(); ctx.arc(0, 0, 40, 0, Math.PI*2); ctx.fill();
            // Big Eye
            ctx.fillStyle = "white";
            ctx.beginPath(); ctx.arc(0, 0, 25, 0, Math.PI*2); ctx.fill();
            ctx.fillStyle = "black";
            ctx.beginPath(); ctx.arc(0, 0, 10, 0, Math.PI*2); ctx.fill();
            // Wings
            ctx.fillStyle = "#c0392b";
            ctx.beginPath(); ctx.moveTo(-40, 0); ctx.lineTo(-80, -30); ctx.lineTo(-50, 20); ctx.fill();
            ctx.beginPath(); ctx.moveTo(40, 0); ctx.lineTo(80, -30); ctx.lineTo(50, 20); ctx.fill();

        } else { // Robot
            ctx.fillStyle = "#7f8c8d";
            ctx.roundRect(-30, -40, 60, 80, 5);
            ctx.fill();
            // Screen
            ctx.fillStyle = "#34495e";
            ctx.fillRect(-20, -30, 40, 30);
            // Eyes
            ctx.fillStyle = "red";
            ctx.fillRect(-10, -20, 5, 5);
            ctx.fillRect(5, -20, 5, 5);
            // Antenna
            ctx.strokeStyle = "#7f8c8d"; ctx.lineWidth=4;
            ctx.beginPath(); ctx.moveTo(0, -40); ctx.lineTo(0, -60); ctx.stroke();
            ctx.fillStyle = "red"; ctx.beginPath(); ctx.arc(0, -65, 5, 0, Math.PI*2); ctx.fill();
        }

        ctx.restore();
    }

    hitEnemy(damage) {
        this.enemy.health -= damage;
        this.enemy.state = 'HIT';
        this.flashColor = "white";
        setTimeout(() => this.enemy.state = 'IDLE', 300);
        
        this.createParticles(this.enemy.x, this.enemy.y, "#e74c3c");
        this.showFloatingText("-" + damage, this.enemy.x, this.enemy.y - 50, "#e74c3c");

        if(this.enemy.health <= 0) {
            this.addScore(50);
            this.message = "Victory! 🏆";
            this.messageTimer = 100;
            
            // Animation: Crush/Vanish
            this.enemy.state = 'DEFEATED'; 
            
            setTimeout(() => {
                this.level++;
                this.init(); 
            }, 1500);
        }
    }

    hitHero(damage) {
        this.hero.health -= damage;
        this.hero.state = 'HIT';
        this.shakeTimer = 20;
        this.flashColor = "#e74c3c";
        setTimeout(() => this.hero.state = 'IDLE', 300);

        this.createParticles(this.hero.x, this.hero.y, "#f1c40f");
        this.showFloatingText("-" + damage, this.hero.x, this.hero.y - 50, "#e74c3c");

        if(this.hero.health <= 0) {
            this.message = "Defeated... 😢";
            this.hero.state = 'DEFEATED'; // Vanish hero too
            
            setTimeout(() => {
                this.stop(); 
                window.location.href = 'games.php';
            }, 1500);
        }
    }

    createParticles(x, y, color) {
        for(let i=0; i<20; i++) {
            this.particles.push({
                x: x,
                y: y,
                vx: (Math.random() - 0.5) * 15,
                vy: (Math.random() - 0.5) * 15,
                life: 30 + Math.random() * 10,
                color: color,
                size: Math.random() * 8 + 2
            });
        }
    }

    showFloatingText(text, x, y, color) {
        this.floatingTexts.push({
            text: text,
            x: x,
            y: y,
            color: color,
            life: 60
        });
    }

    lerp(start, end, t) {
        return start * (1 - t) + end * t;
    }

    handleInput(e) {
        if(this.turnState !== 'INPUT') return;

        if(e.type === 'mousedown' || e.type === 'touchstart') {
            const pos = this.getPos(e);
            
            this.optionBoxes.forEach(opt => {
                if(pos.x > opt.x && pos.x < opt.x + opt.width && pos.y > opt.y && pos.y < opt.y + opt.height) {
                    this.turnState = 'ANIMATING';
                    
                    if(opt.value === this.correctAnswer) {
                        this.addScore(10);
                        this.hero.state = 'DASH'; // Start attack sequence
                    } else {
                        // Wrong! Enemy attacks
                        this.enemy.state = 'DASH';
                        this.showFloatingText("Miss!", this.hero.x, this.hero.y - 60, "white");
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

const game = new MathHeroGame('gameCanvas');