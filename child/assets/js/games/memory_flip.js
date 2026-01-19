class MemoryFlipGame extends GameEngine {
    init() {
        this.cards = ['🍎','🍎','🍌','🍌','🍇','🍇','🍒','🍒'];
        this.cards.sort(() => Math.random() - 0.5);
        this.grid = [];
        this.flipped = [];
        this.matches = 0;

        for(let i=0; i<8; i++) {
            this.grid.push({
                val: this.cards[i],
                x: 100 + (i%4)*150,
                y: 100 + Math.floor(i/4)*200,
                w: 100, h: 150,
                isFlipped: false,
                isMatched: false
            });
        }
    }

    draw() {
        this.grid.forEach(c => {
            if(c.isFlipped || c.isMatched) {
                this.ctx.fillStyle = "white";
                this.ctx.fillRect(c.x, c.y, c.w, c.h);
                this.ctx.strokeRect(c.x, c.y, c.w, c.h);
                this.ctx.font = "50px Arial";
                this.ctx.fillText(c.val, c.x + 25, c.y + 90);
            } else {
                this.ctx.fillStyle = "#4ECDC4";
                this.ctx.fillRect(c.x, c.y, c.w, c.h);
                this.ctx.fillStyle = "white";
                this.ctx.font = "30px Arial";
                this.ctx.fillText("?", c.x + 40, c.y + 90);
            }
        });
    }

    handleInput(e) {
        if(e.type === 'mousedown' || e.type === 'touchstart') {
            const pos = this.getPos(e);
            if(this.flipped.length >= 2) return;

            this.grid.forEach(c => {
                if(!c.isMatched && !c.isFlipped && pos.x > c.x && pos.x < c.x+c.w && pos.y > c.y && pos.y < c.y+c.h) {
                    c.isFlipped = true;
                    this.flipped.push(c);
                    
                    if(this.flipped.length === 2) {
                        setTimeout(() => this.checkMatch(), 1000);
                    }
                }
            });
        }
    }

    checkMatch() {
        const [c1, c2] = this.flipped;
        if(c1.val === c2.val) {
            c1.isMatched = true;
            c2.isMatched = true;
            this.addScore(10);
            this.matches++;
            if(this.matches === 4) {
                alert("You won! 🧠");
                this.init();
            }
        } else {
            c1.isFlipped = false;
            c2.isFlipped = false;
        }
        this.flipped = [];
    }
}
const game = new MemoryFlipGame('gameCanvas');
