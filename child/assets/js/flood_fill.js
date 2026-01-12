    // --- FLOOD FILL ALGORITHM ---
    const floodFill = (startX, startY, fillColor) => {
        // Convert hex/name to RGB
        const tempCtx = document.createElement('canvas').getContext('2d');
        tempCtx.fillStyle = fillColor;
        tempCtx.fillRect(0,0,1,1);
        const fillData = tempCtx.getImageData(0,0,1,1).data;
        const fillR = fillData[0], fillG = fillData[1], fillB = fillData[2];

        const imgData = ctx.getImageData(0, 0, canvas.width, canvas.height);
        const data = imgData.data;
        const width = canvas.width;
        const height = canvas.height;

        // Get starting color
        const startPos = (Math.floor(startY) * width + Math.floor(startX)) * 4;
        const startR = data[startPos], startG = data[startPos+1], startB = data[startPos+2], startA = data[startPos+3];

        // If trying to fill same color, return
        if (startR === fillR && startG === fillG && startB === fillB) return;

        const stack = [[Math.floor(startX), Math.floor(startY)]];

        while(stack.length) {
            const [x, y] = stack.pop();
            const pos = (y * width + x) * 4;

            // Check if current pixel matches start color
            if (x < 0 || x >= width || y < 0 || y >= height) continue;
            if (data[pos] !== startR || data[pos+1] !== startG || data[pos+2] !== startB) continue;

            // Color it
            data[pos] = fillR;
            data[pos+1] = fillG;
            data[pos+2] = fillB;
            data[pos+3] = 255; // Force alpha to 255

            // Push neighbors
            stack.push([x+1, y], [x-1, y], [x, y+1], [x, y-1]);
        }

        ctx.putImageData(imgData, 0, 0);
    };