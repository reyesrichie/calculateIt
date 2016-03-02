Label panel;
Button[][] buttons;
String[] operands = new String[2];
String operation = "";

void setup()
{
  size(500, 720);
  background(255);
  
  clearPanel();
  
  panel = new Label(70, 108, width - 100, 16, "");
  
  String[][] labels = {{"1","2","3","+"},{"4","5","6", "-"},{"7","8","9", "*"},{"C",".","=","/"}};
  buttons = new Button[4][4];
  
  for (int row = 0; row < 4; row ++)
  {
    for (int column = 0; column < 4; column++)
    {
      buttons[row][column] = new Button(60 + (column * 100), 175 + (row * 100), 75, 75, new Colour(250, 250, 250), labels[row][column]);
    }
  }
}

void clearPanel()
{
  fill(250,250,250);
  rect(50, 50, width - 100, 100);
}

void draw()
{
  
}

void mouseClicked()
{
  String selected = "";
  
  for (int row = 0; row < 4; row ++)
  {
    for (int column = 0; column < 4; column++)
    {
      Button button = buttons[row][column];
      
      if (button.hitTest())
      {
        selected = button.label.text;
      }
      
      if (selected.length() > 0)
      {
        break;
      }
    }
    
    if (selected.length() > 0)
    {
      break;
    }
  }
  
  switch(selected)
  {
    case "C":
      panel.text = "";
      operands[0] = null;
      operands[1] = null;
      operation = "";
      break;
    case "+":
    case "-":
    case "*":
    case "/":
      if (operands[0] == null)
        {
          operands[0] = panel.text;
        }
        else if (operands[1] == null)
        {
          operands[1] = panel.text;
          operands[0] = calculate();
        }
        
        operation = selected;
        panel.text = "";
      break;
    case "=":
      if (operands[0] == null)
      {
        operands[0] = panel.text;
      }
      else if (operands[1] == null)
      {
        operands[1] = panel.text;
      }
    
      if (operands[0] != null && operands[1] != null)
      {
        panel.text = calculate();
      }
      else if (operands[0] != null)
      {
        panel.text = operands[0];
      }
      else
      {
        panel.text = "0";
      }
      break;
    default:
      panel.text += selected;
      break;
  }
  
  println(operands[0] + " " + operation + " " + operands[1]);
  
  clearPanel();
  panel.drawText();
}

String calculate()
{
  String result = "";
  
  switch (operation)
  {
    case "+":
      result = Float.toString(Float.parseFloat(operands[0]) + Float.parseFloat(operands[1]));
      break;
    case "-":
      result = Float.toString(Float.parseFloat(operands[0]) - Float.parseFloat(operands[1]));
      break;
    case "*":
      result = Float.toString(Float.parseFloat(operands[0]) * Float.parseFloat(operands[1]));
      break;
    case "/":
      result = Float.toString(Float.parseFloat(operands[0]) / Float.parseFloat(operands[1]));
      break;
  }
  
  operands[0] = null;
  operands[1] = null;
  operation = "";
  
  return result;
}

class Button
{
  Frame frame;
  Label label;
  Colour colour;
  
  Button(int x, int y, int width, int height, Colour colour, String text)
  {
    fill(colour.red, colour.green, colour.blue);
    ellipse(x + width / 2, y + height / 2, width, height);
    
    this.frame = new Frame(new Point(x, y), new Size(width, height));
    this.label = new Label(x + width / 2 - (text.length() * 8/2) , y + height / 2 + (text.length() * 8/2), text.length() * 8, text.length() * 8, text);   
    this.colour = colour;
  }
  
  boolean hitTest()
  {
    return (mouseX > this.frame.origin.x && mouseX < this.frame.maxX() && mouseY > this.frame.origin.y && mouseY < this.frame.maxY());
  }
}

class Colour
{
  int red;
  int green;
  int blue;
  
  Colour(int red, int green, int blue)
  {
    this.red = red;
    this.green = green;
    this.blue = blue;
  }
}

class Label
{
  Frame frame;
  String text;
  
  Label(int x, int y, int width, int height, String text)
  {
    this.frame = new Frame(new Point(x, y), new Size(width, height));
    this.text = text;
    this.drawText();
  }
  
  void drawText()
  {
    PFont font = createFont("Futura", 16, true);
    textFont(font, 16);
    fill(0);
    text(this.text, frame.origin.x, frame.origin.y);
  }
}

class Frame
{
  Point origin;
  Size size;
  
  Frame(Point origin, Size size)
  {
    this.origin = origin;
    this.size = size;
  }
  
  int maxY()
  {
    return this.origin.y + this.size.height;
  }
  
  int maxX()
  {
    return this.origin.x + this.size.width;
  }
}

class Size
{
  int width;
  int height;
  
  Size(int width, int height)
  {
    this.width = width;
    this.height = height;
  }
}

class Point
{
  int x;
  int y;
  
  Point(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
}