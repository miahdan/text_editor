type t = {
  char_map : int array;
  num_cols : int;
  start_location : int * int;
  frame_dimensions : int * int;
}

let max_chars = 128

let construct_char_map chars_in_order =
  let arr = Array.make max_chars 0 in
  let len = String.length chars_in_order in
  let rec loop i =
    if i >= len then ()
    else
      let idx = i |> String.get chars_in_order |> int_of_char in
      Array.set arr idx i;
      loop (i + 1)
  in
  loop 0;
  arr

let create ~start_location ~frame_dimensions ~chars_in_order ~num_cols =
  {
    char_map = construct_char_map chars_in_order;
    start_location;
    frame_dimensions;
    num_cols;
  }

let rect_of_char self c =
  let w, h = self.frame_dimensions in
  let start_x, start_y = self.start_location in
  let idx = c |> int_of_char |> Array.get self.char_map in
  let x = start_x + w * (idx mod self.num_cols) in
  let y = start_y + (h * (idx / self.num_cols)) in
  Sdl.Rect.make4 x y w h
