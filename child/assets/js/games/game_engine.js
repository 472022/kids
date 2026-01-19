class GameEngine {
    constructor(canvasId) {
        this.canvas = document.getElementById(canvasId);
        this.ctx = this.canvas.getContext('2d');
        this.width = this.canvas.width;
        this.height = this.canvas.height;
        
        this.score = 0;
        this.stars = 0;
        this.level = 1;
        this.isPlaying = false;
        this.animationId = null;
        
        // UI Elements
        this.scoreDisplay = document.getElementById('scoreDisplay');
        this.starDisplay = document.getElementById('starDisplay');
        this.levelDisplay = document.getElementById('levelDisplay');
        
        // Event Listeners
        this.canvas.addEventListener('mousedown', (e) => this.handleInput(e));
        
        // Touch Support with preventDefault to stop scrolling
        this.canvas.addEventListener('touchstart', (e) => {
            if(e.cancelable) e.preventDefault(); 
            this.handleInput(e);
        }, { passive: false });
        
        this.canvas.addEventListener('touchmove', (e) => {
            if(e.cancelable) e.preventDefault();
            // Optional: Handle drag if needed globally
        }, { passive: false });
        
        // Keyboard Support
        window.addEventListener('keydown', (e) => this.handleInput(e));
        window.addEventListener('keyup', (e) => this.handleInput(e));

        document.getElementById('startGameBtn').addEventListener('click', () => this.start());
    }

    // Add Exit Game Button Logic
    createExitButton() {
        if (document.getElementById('exitGameBtn')) return;
        
        const btn = document.createElement('button');
        btn.id = 'exitGameBtn';
        btn.innerHTML = '❌ Stop';
        btn.style.position = 'absolute';
        btn.style.top = '10px';
        btn.style.right = '10px';
        btn.style.background = '#FF5252';
        btn.style.color = 'white';
        btn.style.border = 'none';
        btn.style.padding = '8px 15px';
        btn.style.borderRadius = '20px';
        btn.style.cursor = 'pointer';
        btn.style.fontFamily = 'Fredoka One, Arial';
        btn.style.zIndex = '1000';
        
        btn.onclick = () => {
            if(confirm("Do you want to stop playing? Progress will be saved.")) {
                this.stop(true); // Treat as "success" to save progress
                window.location.href = 'games.php'; // Go back to dashboard
            }
        };
        
        // Append to game container (parent of canvas)
        this.canvas.parentElement.style.position = 'relative';
        this.canvas.parentElement.appendChild(btn);
    }

    start() {
        if(this.isPlaying) return;
        this.isPlaying = true;
        // this.score = 0; // Don't reset score if restarting level? Maybe keep. Reset for now.
        // this.stars = 0;
        this.updateUI();
        this.createExitButton();
        this.init(); // Game specific init
        this.loop();
        document.getElementById('startGameBtn').style.display = 'none';
    }

    loop() {
        if (!this.isPlaying) return;
        this.ctx.clearRect(0, 0, this.width, this.height);
        this.update();
        this.draw();
        this.animationId = requestAnimationFrame(() => this.loop());
    }

    stop(success = false) {
        this.isPlaying = false;
        cancelAnimationFrame(this.animationId);
        document.getElementById('startGameBtn').style.display = 'inline-block';
        document.getElementById('startGameBtn').innerText = success ? 'Play Next Level ▶' : 'Try Again ↺';
        
        if (success) {
            this.saveProgress();
            this.drawWinScreen();
        } else {
            this.drawGameOverScreen();
        }
    }

    addScore(points) {
        this.score += points;
        if (this.score % 50 === 0) { // Every 50 points = 1 star (example rule)
            this.stars++;
        }
        this.updateUI();
    }

    updateUI() {
        if(this.scoreDisplay) this.scoreDisplay.innerText = this.score;
        if(this.starDisplay) this.starDisplay.innerText = this.stars;
        if(this.levelDisplay) this.levelDisplay.innerText = this.level;
    }

    saveProgress() {
        fetch('save_game_progress.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                game_id: GAME_ID,
                score: this.score,
                stars: this.stars,
                level: this.level
            })
        }).then(res => res.json()).then(data => {
            console.log('Progress Saved', data);
        });
    }

    // Placeholders for child classes
    init() {}
    update() {}
    draw() {}
    handleInput(e) {}

    getPos(e) {
        const rect = this.canvas.getBoundingClientRect();
        const clientX = e.touches ? e.touches[0].clientX : e.clientX;
        const clientY = e.touches ? e.touches[0].clientY : e.clientY;
        return {
            x: clientX - rect.left,
            y: clientY - rect.top
        };
    }

    drawWinScreen() {
        this.ctx.fillStyle = "rgba(0, 0, 0, 0.7)";
        this.ctx.fillRect(0, 0, this.width, this.height);
        this.ctx.fillStyle = "#fff";
        this.ctx.font = "40px 'Comic Neue'";
        this.ctx.textAlign = "center";
        this.ctx.fillText("Level Complete! 🎉", this.width/2, this.height/2 - 20);
        this.ctx.font = "20px 'Comic Neue'";
        this.ctx.fillText(`Score: ${this.score} | Stars: ${this.stars}`, this.width/2, this.height/2 + 30);
    }
    
    drawGameOverScreen() {
        this.ctx.fillStyle = "rgba(0, 0, 0, 0.7)";
        this.ctx.fillRect(0, 0, this.width, this.height);
        this.ctx.fillStyle = "#fff";
        this.ctx.font = "40px 'Comic Neue'";
        this.ctx.textAlign = "center";
        this.ctx.fillText("Game Over 😢", this.width/2, this.height/2);
    }
}
