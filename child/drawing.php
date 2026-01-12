<?php
require_once '../config/db.php';
require_once 'includes/auth_check.php';

include 'includes/header.php';
?>

<div class="glass-panel" style="max-width: 1100px; margin: 0 auto; padding: 20px;">
    
    <!-- Top Toolbar -->
    <div style="display: flex; justify-content: space-between; align-items: center; background: white; padding: 15px 25px; border-radius: 20px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); margin-bottom: 20px;">
        <div style="font-family: 'Fredoka One'; font-size: 1.8rem; color: #2C3E50;">🎨 My Drawing Board</div>
        <div style="display:flex; gap:10px;">
            <a href="my_drawings.php" class="btn-back" style="background: #FFC107; color: #333; margin-bottom: 0;">📂 My Gallery</a>
            <button id="clearBtn" class="btn-back" style="background: #F44336; margin-bottom: 0; border: none; cursor: pointer;">🗑 Clear</button>
            <button id="saveBtn" class="btn-back" style="background: #4CAF50; margin-bottom: 0; border: none; cursor: pointer;">💾 Save</button>
        </div>
    </div>

    <div style="display: flex; gap: 20px; flex-wrap: wrap;">
        
        <!-- Left Tools -->
        <div style="background: white; padding: 20px; border-radius: 20px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); width: 120px; display: flex; flex-direction: column; gap: 20px; align-items: center;">
            <!-- Shapes/Brushes -->
            <div style="display: flex; flex-direction: column; gap: 10px; width: 100%;">
                <button class="tool-btn active" data-tool="brush" title="Brush" style="font-size: 1.5rem; padding: 10px; border: 2px solid #eee; border-radius: 10px; background: white; cursor: pointer;">🖌</button>
                <button class="tool-btn" data-tool="pencil" title="Pencil" style="font-size: 1.5rem; padding: 10px; border: 2px solid #eee; border-radius: 10px; background: white; cursor: pointer;">✏</button>
                <button class="tool-btn" data-tool="eraser" title="Eraser" style="font-size: 1.5rem; padding: 10px; border: 2px solid #eee; border-radius: 10px; background: white; cursor: pointer;">🧽</button>
                <button class="tool-btn" data-tool="fill" title="Fill Color" style="font-size: 1.5rem; padding: 10px; border: 2px solid #eee; border-radius: 10px; background: white; cursor: pointer;">🪣</button>
                <button class="tool-btn" data-tool="rect" title="Rectangle" style="font-size: 1.5rem; padding: 10px; border: 2px solid #eee; border-radius: 10px; background: white; cursor: pointer;">▭</button>
                <button class="tool-btn" data-tool="circle" title="Circle" style="font-size: 1.5rem; padding: 10px; border: 2px solid #eee; border-radius: 10px; background: white; cursor: pointer;">◯</button>
                <button class="tool-btn" data-tool="line" title="Line" style="font-size: 1.5rem; padding: 10px; border: 2px solid #eee; border-radius: 10px; background: white; cursor: pointer;">▱</button>
            </div>
            
            <hr style="width:100%; border:1px solid #eee;">
            
            <!-- Colors -->
            <div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: center; gap: 5px;">
                <div class="color-btn active" style="width: 30px; height: 30px; border-radius: 50%; background:black; cursor: pointer; border: 2px solid white; box-shadow: 0 0 0 1px #ccc;" data-color="black"></div>
                <div class="color-btn" style="width: 30px; height: 30px; border-radius: 50%; background:red; cursor: pointer; border: 2px solid white; box-shadow: 0 0 0 1px #ccc;" data-color="red"></div>
                <div class="color-btn" style="width: 30px; height: 30px; border-radius: 50%; background:blue; cursor: pointer; border: 2px solid white; box-shadow: 0 0 0 1px #ccc;" data-color="blue"></div>
                <div class="color-btn" style="width: 30px; height: 30px; border-radius: 50%; background:green; cursor: pointer; border: 2px solid white; box-shadow: 0 0 0 1px #ccc;" data-color="green"></div>
                <div class="color-btn" style="width: 30px; height: 30px; border-radius: 50%; background:orange; cursor: pointer; border: 2px solid white; box-shadow: 0 0 0 1px #ccc;" data-color="orange"></div>
                <div class="color-btn" style="width: 30px; height: 30px; border-radius: 50%; background:purple; cursor: pointer; border: 2px solid white; box-shadow: 0 0 0 1px #ccc;" data-color="purple"></div>
                <div class="color-btn" style="width: 30px; height: 30px; border-radius: 50%; background:pink; cursor: pointer; border: 2px solid white; box-shadow: 0 0 0 1px #ccc;" data-color="pink"></div>
                <div class="color-btn" style="width: 30px; height: 30px; border-radius: 50%; background:yellow; cursor: pointer; border: 2px solid white; box-shadow: 0 0 0 1px #ccc;" data-color="yellow"></div>
            </div>
            
            <hr style="width:100%; border:1px solid #eee;">
            
            <!-- Size -->
            <div style="width: 100%;">
                <label style="font-size:0.8rem; text-align:center; display: block; margin-bottom: 5px;">Size</label>
                <input type="range" min="1" max="20" value="5" id="sizeSlider" style="width: 100%;">
            </div>
        </div>

        <!-- Canvas -->
        <div id="canvasContainer" style="flex: 1; background: white; border-radius: 20px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); padding: 10px; overflow: hidden; height: 600px;">
            <canvas id="drawingCanvas" style="width: 100%; height: 100%; display: block; background: white; border-radius: 10px;"></canvas>
        </div>
    </div>
</div>

<script src="assets/js/drawing.js"></script>
<script src="assets/js/flood_fill.js"></script>
<script>
    // Simple script to handle tool activation UI (logic is in drawing.js)
    document.querySelectorAll('.tool-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.tool-btn').forEach(b => {
                b.classList.remove('active');
                b.style.background = 'white';
                b.style.borderColor = '#eee';
            });
            btn.classList.add('active');
            btn.style.background = '#e0f7fa';
            btn.style.borderColor = '#00bcd4';
        });
    });

    document.querySelectorAll('.color-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.color-btn').forEach(b => {
                b.classList.remove('active');
                b.style.transform = 'scale(1)';
            });
            btn.classList.add('active');
            btn.style.transform = 'scale(1.2)';
        });
    });
</script>

</div> <!-- End Dashboard Container -->
</body>
</html>
