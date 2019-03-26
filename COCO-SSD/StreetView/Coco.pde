class Coco {

    Table cocoTable;
    TableRow lookup;
    TableRow current;

    int maxIdx;

    Coco(int maxIdx_) {
        // Coco SSD data
        cocoTable = loadTable("coco_ssd.csv", "header, csv");
        maxIdx = maxIdx_;
    }

    void display(float playhead) {
        // find current time marker on the table
        for( TableRow row : cocoTable.rows() ) {
            if(row.getFloat("time") >= playhead) {
                current = row;
                break;
            }
        }

        // parse table and draw bounding boxes
        for(int i = 0; i < maxIdx; i++) {
            if(!Float.isNaN(current.getFloat("results."+i+".bbox.0"))) {
                float boxX = current.getFloat("results."+i+".bbox.0");
                float boxY = current.getFloat("results."+i+".bbox.1");
                float boxW = current.getFloat("results."+i+".bbox.2");
                float boxH = current.getFloat("results."+i+".bbox.3");
                String boxLabel = current.getString("results."+i+".class");
                float boxScore = current.getFloat("results."+i+".score");

                // draw bbox with table data
                drawBBox(boxX, boxY, boxW, boxH, boxLabel, boxScore);
            }
        }
    }

    // drawing bbox function
    void drawBBox(float x, float y, float w, float h, String label, float score) {
        strokeWeight(5);
        stroke(96, 255, 255, 200);
        fill(96, 255, 255, 32);
        rect(x*movieScale, y*movieScale, w*movieScale, h*movieScale, 5);

        textSize(14);
        float textW = textWidth(label);
        fill(96, 255, 255);
        rect(x*movieScale, y*movieScale-g.textSize, textW, g.textSize);

        fill(0, 64, 64);
        text(label, x*movieScale, y*movieScale-2);
    }

}