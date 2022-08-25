type t

val create :
  start_location:int * int ->
  frame_dimensions:int * int ->
  chars_in_order:string ->
  num_cols:int ->
  t

val rect_of_char : t -> char -> Sdl.Rect.t
