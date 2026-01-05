class MathHeroGame extends GameEngine {
    init() {
        // Game State
        this.level = this.level || 1; 
        this.maxHealth = 100;
        this.turnState = 'INPUT'; // INPUT, ATTACKING, HIT, ENEMY_TURN, ENEMY_ATTACKING
        
        this.hero = { 
            x: 100, y: 320, 
            baseX: 100, baseY: 320,
            health: this.maxHealth, 
            maxHealth: this.maxHealth,
            color: '#3498db',
            state: 'IDLE', // IDLE, DASH, ATTACK, RETURN, HIT
            animTimer: 0
        };
        
        this.enemy = { 
            x: 600, y: 320, 
            baseX: 600, baseY: 320,
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
        this.flashColor = null; // Screen flash

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
            x: 150 + i * 180,
            y: 480,
            width: 140,
            height: 70,
            value: opt,
            color: '#FFB74D',
            baseY: 480
        }));
    }

    update() {
        // --- TURN LOGIC & ANIMATION STATE MACHINE ---
        
        // Hero Animation Logic
        if(this.hero.state === 'DASH') {
            // Move towards enemy
            this.hero.x = this.lerp(this.hero.x, this.enemy.x - 80, 0.2);
            if(Math.abs(this.hero.x - (this.enemy.x - 80)) < 10) {
                this.hero.state = 'ATTACK';
                this.hero.animTimer = 10;
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
            this.enemy.x = this.lerp(this.enemy.x, this.hero.x + 80, 0.2);
            if(Math.abs(this.enemy.x - (this.hero.x + 80)) < 10) {
                this.enemy.state = 'ATTACK';
                this.enemy.animTimer = 10;
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
                this.turnState = 'INPUT'; // Back to player
            }
        }

        // Floating Texts
        for(let i = this.floatingTexts.length - 1; i >= 0; i--) {
            let t = this.floatingTexts[i];
            t.y -= 1.5; // Float up
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
        let shakeX = (this.shakeTimer > 0) ? (Math.random() - 0.5) * 15 : 0;
        let shakeY = (this.shakeTimer > 0) ? (Math.random() - 0.5) * 15 : 0;
        
        this.ctx.save();
        this.ctx.translate(shakeX, shakeY);

        // --- BACKGROUND ---
        // Sky
        let grad = this.ctx.createLinearGradient(0, 0, 0, 600);
        grad.addColorStop(0, "#4FC3F7");
        grad.addColorStop(1, "#E1F5FE");
        this.ctx.fillStyle = grad;
        this.ctx.fillRect(0, 0, 800, 600);

        // Clouds (Simple circles)
        this.ctx.fillStyle = "rgba(255,255,255,0.6)";
        this.ctx.beginPath(); this.ctx.arc(100, 100, 40, 0, Math.PI*2); this.ctx.fill();
        this.ctx.beginPath(); this.ctx.arc(150, 120, 50, 0, Math.PI*2); this.ctx.fill();
        this.ctx.beginPath(); this.ctx.arc(600, 80, 60, 0, Math.PI*2); this.ctx.fill();

        // Mountains
        this.ctx.fillStyle = "#90A4AE";
        this.ctx.beginPath();
        this.ctx.moveTo(0, 400);
        this.ctx.lineTo(200, 200);
        this.ctx.lineTo(400, 400);
        this.ctx.fill();
        this.ctx.fillStyle = "#78909C";
        this.ctx.beginPath();
        this.ctx.moveTo(300, 400);
        this.ctx.lineTo(550, 150);
        this.ctx.lineTo(800, 400);
        this.ctx.fill();

        // Ground
        this.ctx.fillStyle = "#81C784";
        this.ctx.fillRect(0, 400, 800, 200);
        // Grass Details
        this.ctx.fillStyle = "#66BB6A";
        for(let i=0; i<800; i+=20) {
            this.ctx.beginPath();
            this.ctx.moveTo(i, 400);
            this.ctx.lineTo(i+10, 390);
            this.ctx.lineTo(i+20, 400);
            this.ctx.fill();
        }

        // --- HUD ---
        // Question Board (Glassmorphism)
        this.ctx.save();
        this.ctx.shadowColor = "rgba(0,0,0,0.2)";
        this.ctx.shadowBlur = 15;
        this.ctx.shadowOffsetY = 10;
        this.ctx.fillStyle = "rgba(255, 255, 255, 0.9)";
        this.ctx.roundRect(200, 30, 400, 100, 25);
        this.ctx.fill();
        this.ctx.restore();

        this.ctx.fillStyle = "#37474F";
        this.ctx.font = "bold 55px 'Fredoka One', Arial";
        this.ctx.textAlign = "center";
        this.ctx.textBaseline = "middle";
        this.ctx.fillText(`${this.num1} ${this.operator} ${this.num2} = ?`, 400, 85);

        // --- CHARACTERS ---
        this.drawHero(this.hero.x, this.hero.y);
        this.drawEnemy(this.enemy.x, this.enemy.y);

        // --- HEALTH BARS ---
        this.drawHealthBar(this.hero.x, this.hero.y - 50, this.hero.health, this.hero.maxHealth, "#4CAF50", "Hero");
        this.drawHealthBar(this.enemy.x, this.enemy.y - 50, this.enemy.health, this.enemy.maxHealth, "#F44336", "Enemy");

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
            this.ctx.font = "bold 30px 'Fredoka One'";
            this.ctx.fillStyle = t.color;
            this.ctx.strokeStyle = "white";
            this.ctx.lineWidth = 3;
            this.ctx.strokeText(t.text, t.x, t.y);
            this.ctx.fillText(t.text, t.x, t.y);
            this.ctx.restore();
        });

        // --- OPTIONS (Buttons) ---
        if(this.turnState === 'INPUT') {
            this.optionBoxes.forEach(opt => {
                // Hover effect logic could go here if tracking mouse move
                
                // Shadow
                this.ctx.fillStyle = "#EF6C00";
                this.ctx.beginPath();
                this.ctx.roundRect(opt.x, opt.y + 8, opt.width, opt.height, 15);
                this.ctx.fill();

                // Button Body
                this.ctx.fillStyle = opt.color;
                this.ctx.beginPath();
                this.ctx.roundRect(opt.x, opt.y, opt.width, opt.height, 15);
                this.ctx.fill();

                // Highlight
                this.ctx.fillStyle = "rgba(255,255,255,0.3)";
                this.ctx.beginPath();
                this.ctx.roundRect(opt.x, opt.y, opt.width, opt.height/2, 15);
                this.ctx.fill();

                this.ctx.fillStyle = "white";
                this.ctx.font = "bold 35px 'Fredoka One', Arial";
                this.ctx.textAlign = "center";
                this.ctx.textBaseline = "middle";
                this.ctx.fillText(opt.value, opt.x + opt.width/2, opt.y + opt.height/2 + 2);
            });
        }

        // --- MESSAGES ---
        if(this.message) {
            this.ctx.fillStyle = "rgba(0,0,0,0.7)";
            this.ctx.roundRect(150, 200, 500, 100, 20);
            this.ctx.fill();
            
            this.ctx.fillStyle = "#FFEB3B";
            this.ctx.font = "bold 40px 'Fredoka One', Arial";
            this.ctx.textAlign = "center";
            this.ctx.fillText(this.message, 400, 260);
        }

        // Flash Effect
        if(this.flashColor) {
            this.ctx.fillStyle = this.flashColor;
            this.ctx.globalAlpha = 0.3;
            this.ctx.fillRect(0,0,800,600);
            this.ctx.globalAlpha = 1.0;
            this.flashColor = null;
        }

        this.ctx.restore();
    }

    drawHealthBar(x, y, current, max, color, label) {
        let width = 100;
        let height = 15;
        // Label
        this.ctx.fillStyle = "white";
        this.ctx.font = "bold 14px Arial";
        this.ctx.textAlign = "center";
        this.ctx.fillText(label, x + width/2, y - 5);
        
        // Border
        this.ctx.fillStyle = "#263238";
        this.ctx.roundRect(x - 2, y - 2, width + 4, height + 4, 8);
        this.ctx.fill();
        
        // Background
        this.ctx.fillStyle = "#455A64";
        this.ctx.roundRect(x, y, width, height, 6);
        this.ctx.fill();

        // Fill
        let fillWidth = (current / max) * width;
        if(fillWidth < 0) fillWidth = 0;
        this.ctx.fillStyle = color;
        this.ctx.roundRect(x, y, fillWidth, height, 6);
        this.ctx.fill();
        
        // Glint
        this.ctx.fillStyle = "rgba(255,255,255,0.3)";
        this.ctx.roundRect(x, y, fillWidth, height/2, 6);
        this.ctx.fill();
    }

    drawHero(x, y) {
        const ctx = this.ctx;
        ctx.save();
        ctx.translate(x, y);
        
        // Idle Animation
        let breathe = (this.hero.state === 'IDLE') ? Math.sin(Date.now() * 0.005) * 2 : 0;
        ctx.translate(0, breathe);

        if(this.hero.state === 'HIT') ctx.filter = 'brightness(50%) sepia(100%) hue-rotate(-50deg) saturate(600%) contrast(0.8)'; 

        // Shadow
        ctx.fillStyle = "rgba(0,0,0,0.2)";
        ctx.beginPath(); ctx.ellipse(20, 90, 30, 10, 0, 0, Math.PI*2); ctx.fill();

        // Cape
        ctx.fillStyle = "#E53935";
        ctx.beginPath();
        ctx.moveTo(10, 20);
        ctx.quadraticCurveTo(-30 + (Math.sin(Date.now()*0.01)*5), 60, 0, 80);
        ctx.lineTo(40, 80);
        ctx.quadraticCurveTo(70, 60, 30, 20);
        ctx.fill();

        // Body
        ctx.fillStyle = "#1976D2";
        ctx.beginPath(); ctx.roundRect(0, 20, 45, 55, 8); ctx.fill();

        // Head
        ctx.fillStyle = "#FFCCBC";
        ctx.beginPath(); ctx.arc(22, 10, 22, 0, Math.PI*2); ctx.fill();

        // Mask
        ctx.fillStyle = "#1565C0";
        ctx.beginPath(); ctx.roundRect(2, 0, 40, 15, 5); ctx.fill();
        
        // Eyes
        ctx.fillStyle = "white";
        ctx.beginPath();
        ctx.ellipse(15, 10, 5, 3, 0.2, 0, Math.PI*2);
        ctx.ellipse(30, 10, 5, 3, -0.2, 0, Math.PI*2);
        ctx.fill();

        // Symbol (Lightning)
        ctx.fillStyle = "#FFEB3B";
        ctx.beginPath();
        ctx.moveTo(25, 35); ctx.lineTo(30, 45); ctx.lineTo(20, 45); ctx.lineTo(25, 55); ctx.lineTo(15, 45); ctx.lineTo(25, 45);
        ctx.fill();

        // Weapon/Fist
        if(this.hero.state === 'ATTACK') {
             // Punch effect
             ctx.fillStyle = "#FFF";
             ctx.globalAlpha = 0.5;
             ctx.beginPath(); ctx.arc(60, 40, 30, 0, Math.PI*2); ctx.fill();
             ctx.globalAlpha = 1.0;
        }

        ctx.restore();
    }

    drawEnemy(x, y) {
        const ctx = this.ctx;
        ctx.save();
        ctx.translate(x, y);
        
        let breathe = (this.enemy.state === 'IDLE') ? Math.sin(Date.now() * 0.004 + 1) * 2 : 0;
        ctx.translate(0, breathe);

        if(this.enemy.state === 'HIT') ctx.filter = 'brightness(200%)';

        // Shadow
        ctx.fillStyle = "rgba(0,0,0,0.2)";
        ctx.beginPath(); ctx.ellipse(40, 90, 30, 10, 0, 0, Math.PI*2); ctx.fill();

        if(this.enemy.type === 0) { // Slime
            ctx.fillStyle = "#66BB6A";
            ctx.beginPath();
            ctx.moveTo(10, 80);
            ctx.quadraticCurveTo(10, 20, 40, 20); 
            ctx.quadraticCurveTo(70, 20, 70, 80); 
            ctx.fill();
            // Face
            ctx.fillStyle = "black";
            ctx.beginPath(); ctx.arc(30, 45, 4, 0, Math.PI*2); ctx.fill();
            ctx.beginPath(); ctx.arc(50, 45, 4, 0, Math.PI*2); ctx.fill();
        } else if (this.enemy.type === 1) { // Bat
            ctx.fillStyle = "#5D4037";
            ctx.beginPath(); ctx.arc(40, 40, 25, 0, Math.PI*2); ctx.fill();
            // Wings
            ctx.fillStyle = "#3E2723";
            ctx.beginPath();
            ctx.moveTo(15, 40); ctx.quadraticCurveTo(-20, 20, 15, 60);
            ctx.moveTo(65, 40); ctx.quadraticCurveTo(100, 20, 65, 60);
            ctx.fill();
        } else { // Goblin
            ctx.fillStyle = "#8BC34A";
            ctx.beginPath(); ctx.roundRect(20, 30, 40, 50, 5); ctx.fill();
            ctx.beginPath(); ctx.arc(40, 20, 25, 0, Math.PI*2); ctx.fill();
            // Club
            ctx.fillStyle = "#795548";
            ctx.beginPath(); ctx.rect(60, 30, 10, 40); ctx.fill();
            ctx.beginPath(); ctx.arc(65, 30, 15, 0, Math.PI*2); ctx.fill();
        }
        ctx.restore();
    }

    hitEnemy(damage) {
        this.enemy.health -= damage;
        this.enemy.state = 'HIT';
        this.flashColor = "white";
        setTimeout(() => this.enemy.state = 'IDLE', 300);
        
        this.createParticles(this.enemy.x + 40, this.enemy.y + 40, "#F44336");
        this.showFloatingText("-" + damage, this.enemy.x + 40, this.enemy.y, "#F44336");

        if(this.enemy.health <= 0) {
            this.addScore(50);
            this.message = "Victory! 🏆";
            this.messageTimer = 100;
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
        this.flashColor = "red";
        setTimeout(() => this.hero.state = 'IDLE', 300);

        this.createParticles(this.hero.x + 20, this.hero.y + 40, "#FFEB3B");
        this.showFloatingText("-" + damage, this.hero.x + 20, this.hero.y, "#FFEB3B");

        if(this.hero.health <= 0) {
            this.message = "Defeated... 😢";
            setTimeout(() => {
                this.stop(); 
                window.location.href = 'games.php';
            }, 1500);
        }
    }

    createParticles(x, y, color) {
        for(let i=0; i<15; i++) {
            this.particles.push({
                x: x,
                y: y,
                vx: (Math.random() - 0.5) * 12,
                vy: (Math.random() - 0.5) * 12,
                life: 30 + Math.random() * 10,
                color: color,
                size: Math.random() * 6 + 3
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
                        this.showFloatingText("Miss!", this.hero.x + 20, this.hero.y - 20, "white");
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
