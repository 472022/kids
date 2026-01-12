class SpaceAdventureGame extends GameEngine {
    init() {
        // Player Ship
        this.player = {
            x: 400,
            y: 500,
            width: 60,
            height: 80,
            speed: 5,
            health: 100,
            maxHealth: 100
        };

        // Game State
        this.stars = [];
        this.asteroids = [];
        this.bullets = [];
        this.particles = [];
        this.score = 0;
        this.level = 1;
        this.question = null;
        this.message = "Tap/Click to Shoot!";
        this.messageTimer = 100;

        // Background Stars (Parallax)
        for(let i=0; i<100; i++) {
            this.stars.push({
                x: Math.random() * 800,
                y: Math.random() * 600,
                size: Math.random() * 2 + 1,
                speed: Math.random() * 2 + 0.5,
                alpha: Math.random()
            });
        }

        this.generateQuestion();
    }

    generateQuestion() {
        let maxNum = 5 + (this.level * 2);
        let n1 = Math.floor(Math.random() * maxNum) + 1;
        let n2 = Math.floor(Math.random() * maxNum) + 1;
        
        // Ensure no asteroids yet to avoid clutter
        this.asteroids = [];
        
        this.question = {
            text: `${n1} + ${n2}`,
            answer: n1 + n2
        };

        // Spawn 3 asteroids (1 correct, 2 wrong)
        let answers = [this.question.answer];
        while(answers.length < 3) {
            let wrong = this.question.answer + Math.floor(Math.random() * 6) - 3;
            if(wrong !== this.question.answer && wrong >= 0 && !answers.includes(wrong)) {
                answers.push(wrong);
            }
        }
        answers.sort(() => Math.random() - 0.5);

        answers.forEach((ans, i) => {
            this.asteroids.push({
                x: 150 + i * 250,
                y: -100 - Math.random() * 100, // Start above screen
                size: 50,
                value: ans,
                speed: 1 + (this.level * 0.2),
                rotation: 0,
                rotSpeed: (Math.random() - 0.5) * 0.05,
                active: true
            });
        });
    }

    update() {
        // 1. Move Stars
        this.stars.forEach(s => {
            s.y += s.speed;
            if(s.y > 600) { s.y = 0; s.x = Math.random() * 800; }
            s.alpha += (Math.random() - 0.5) * 0.1;
            if(s.alpha < 0.2) s.alpha = 0.2;
            if(s.alpha > 1) s.alpha = 1;
        });

        // 2. Move Player (Mouse Follow with easing)
        if(this.mousePos) {
            this.player.x += (this.mousePos.x - this.player.x) * 0.1;
        }

        // Bounds Checking
        if(this.player.x < 20) this.player.x = 20;
        if(this.player.x > 780) this.player.x = 780;

        // 3. Move Bullets
        for(let i = this.bullets.length - 1; i >= 0; i--) {
            let b = this.bullets[i];
            b.y -= 10;
            // Particles trail
            this.particles.push({x: b.x, y: b.y, vx: (Math.random()-0.5), vy: 2, life: 10, color: '#03A9F4', size: 2});
            
            if(b.y < -20) this.bullets.splice(i, 1);
        }

        // 4. Move Asteroids & Collisions
        this.asteroids.forEach(a => {
            if(!a.active) return;
            a.y += a.speed;
            a.rotation += a.rotSpeed;

            // Check Collision with Bullets
            for(let i = this.bullets.length - 1; i >= 0; i--) {
                let b = this.bullets[i];
                let dx = b.x - a.x;
                let dy = b.y - a.y;
                let dist = Math.sqrt(dx*dx + dy*dy);
                
                if(dist < a.size + 10) { // Hit!
                    this.bullets.splice(i, 1);
                    this.checkAnswer(a);
                    break;
                }
            }

            // Check if passed player
            if(a.y > 650) {
                a.y = -100; // Loop back? No, penalty?
                // For simplicity, just loop back if not answered
                if(this.asteroids.every(ast => ast.y > 600)) {
                    // Missed all? Regenerate positions
                    this.asteroids.forEach(ast => ast.y = -100 - Math.random() * 200);
                }
            }
        });

        // 5. Particles
        for(let i = this.particles.length - 1; i >= 0; i--) {
            let p = this.particles[i];
            p.x += p.vx;
            p.y += p.vy;
            p.life--;
            if(p.life <= 0) this.particles.splice(i, 1);
        }

        if(this.messageTimer > 0) this.messageTimer--;
    }

    checkAnswer(asteroid) {
        if(asteroid.value === this.question.answer) {
            // Correct!
            this.createExplosion(asteroid.x, asteroid.y, '#4CAF50');
            this.score += 100;
            this.message = "Correct! +100";
            this.messageTimer = 60;
            this.level++;
            
            // Clear all asteroids
            this.asteroids.forEach(a => a.active = false);
            
            setTimeout(() => this.generateQuestion(), 1000);
        } else {
            // Wrong
            this.createExplosion(asteroid.x, asteroid.y, '#F44336');
            asteroid.active = false; // Destroy it
            this.score -= 20;
            this.message = "Wrong! Try again!";
            this.messageTimer = 60;
        }
    }

    createExplosion(x, y, color) {
        for(let i=0; i<30; i++) {
            this.particles.push({
                x: x,
                y: y,
                vx: (Math.random() - 0.5) * 10,
                vy: (Math.random() - 0.5) * 10,
                life: 40,
                color: color,
                size: Math.random() * 5 + 2
            });
        }
    }

    handleInput(e) {
        // Auto-shoot on click/tap
        if(e.type === 'mousedown' || e.type === 'touchstart') {
            this.bullets.push({x: this.player.x, y: this.player.y - 40});
        }
        
        // Track mouse/touch for movement
        if(e.type === 'mousemove' || e.type === 'touchmove') {
            this.mousePos = this.getPos(e);
        }
    }

    draw() {
        this.ctx.save();
        
        // Background
        this.ctx.fillStyle = "#0D0D20";
        this.ctx.fillRect(0, 0, 800, 600);

        // Stars
        this.stars.forEach(s => {
            this.ctx.globalAlpha = s.alpha;
            this.ctx.fillStyle = "white";
            this.ctx.beginPath(); this.ctx.arc(s.x, s.y, s.size, 0, Math.PI*2); this.ctx.fill();
        });
        this.ctx.globalAlpha = 1.0;

        // Player Ship
        this.drawShip(this.player.x, this.player.y);

        // Asteroids
        this.asteroids.forEach(a => {
            if(!a.active) return;
            this.drawAsteroid(a);
        });

        // Bullets
        this.ctx.fillStyle = "#00E5FF";
        this.ctx.shadowColor = "#00E5FF";
        this.ctx.shadowBlur = 10;
        this.bullets.forEach(b => {
            this.ctx.beginPath();
            this.ctx.roundRect(b.x - 3, b.y - 10, 6, 20, 3);
            this.ctx.fill();
        });
        this.ctx.shadowBlur = 0;

        // Particles
        this.particles.forEach(p => {
            this.ctx.fillStyle = p.color;
            this.ctx.globalAlpha = p.life / 40;
            this.ctx.beginPath(); this.ctx.arc(p.x, p.y, p.size, 0, Math.PI*2); this.ctx.fill();
        });
        this.ctx.globalAlpha = 1.0;

        // HUD
        this.ctx.fillStyle = "rgba(255, 255, 255, 0.1)";
        this.ctx.fillRect(0, 0, 800, 80);
        
        this.ctx.fillStyle = "#FFEB3B";
        this.ctx.font = "bold 40px 'Fredoka One', Arial";
        this.ctx.textAlign = "center";
        this.ctx.shadowColor = "#FFEB3B"; this.ctx.shadowBlur = 10;
        this.ctx.fillText(`Question: ${this.question.text} = ?`, 400, 50);
        this.ctx.shadowBlur = 0;

        // Score
        this.ctx.fillStyle = "white";
        this.ctx.font = "20px Arial";
        this.ctx.textAlign = "left";
        this.ctx.fillText(`Score: ${this.score}`, 20, 40);

        // Message
        if(this.messageTimer > 0) {
            this.ctx.fillStyle = "white";
            this.ctx.font = "bold 30px 'Fredoka One'";
            this.ctx.textAlign = "center";
            this.ctx.fillText(this.message, 400, 300);
        }

        this.ctx.restore();
    }

    drawShip(x, y) {
        const ctx = this.ctx;
        ctx.save();
        ctx.translate(x, y);
        
        // Flame
        let flicker = Math.random() * 0.5 + 0.5;
        ctx.fillStyle = `rgba(255, 100, 0, ${flicker})`;
        ctx.beginPath();
        ctx.moveTo(-10, 40); ctx.lineTo(0, 70); ctx.lineTo(10, 40);
        ctx.fill();

        // Wings
        ctx.fillStyle = "#D32F2F";
        ctx.beginPath();
        ctx.moveTo(0, -40); ctx.lineTo(-30, 40); ctx.lineTo(30, 40);
        ctx.fill();

        // Body
        ctx.fillStyle = "#ECEFF1";
        ctx.beginPath();
        ctx.ellipse(0, 0, 15, 40, 0, 0, Math.PI*2);
        ctx.fill();

        // Cockpit
        ctx.fillStyle = "#03A9F4";
        ctx.beginPath();
        ctx.ellipse(0, -10, 8, 15, 0, 0, Math.PI*2);
        ctx.fill();

        ctx.restore();
    }

    drawAsteroid(a) {
        const ctx = this.ctx;
        ctx.save();
        ctx.translate(a.x, a.y);
        ctx.rotate(a.rotation);

        // Rock shape
        ctx.fillStyle = "#795548";
        ctx.beginPath();
        // Irregular shape simulation
        ctx.moveTo(a.size, 0);
        for(let i=0; i<7; i++) {
            let angle = (i/6) * Math.PI*2;
            let r = a.size * (0.8 + Math.random()*0.4);
            ctx.lineTo(Math.cos(angle)*r, Math.sin(angle)*r);
        }
        ctx.fill();

        // Craters
        ctx.fillStyle = "#5D4037";
        ctx.beginPath(); ctx.arc(-10, -10, 8, 0, Math.PI*2); ctx.fill();
        ctx.beginPath(); ctx.arc(15, 5, 12, 0, Math.PI*2); ctx.fill();

        // Number (Fixed rotation so it's readable)
        ctx.rotate(-a.rotation);
        ctx.fillStyle = "white";
        ctx.font = "bold 30px 'Fredoka One'";
        ctx.textAlign = "center";
        ctx.textBaseline = "middle";
        ctx.shadowColor = "black"; ctx.shadowBlur = 5;
        ctx.fillText(a.value, 0, 0);

        ctx.restore();
    }
}

const game = new SpaceAdventureGame('gameCanvas');