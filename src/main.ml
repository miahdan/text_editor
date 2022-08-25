open Sdl

let handle_event = function Event.Quit _ -> true | _ -> false

let rec poll_events () =
  match Event.poll_event () with
  | None -> false
  | Some event -> handle_event event || poll_events ()

let () =
  let width, height = (1000, 800) in
  Sdl.init [ `VIDEO ];
  let _, renderer =
    Render.create_window_and_renderer ~width ~height ~flags:[]
  in
  (* BEGIN: font *)
  let font = Font.create (0, 17) (11, 17) " ABCD" 6 in
  let font_surface = Surface.load_bmp "data/tom_vii_font.bmp" in
  let font_tex = Texture.create_from_surface renderer font_surface in
  (* END: font *)
  let draw () =
    Render.set_draw_color renderer (0, 0, 255) 255;
    Render.clear renderer;
    (* BEGIN: DRAW FONT *)
    let src_rect = Font.rect_of_char font 'A' in
    let dst_rect = Rect.make4 100 100 100 100 in
    Render.copy renderer ~texture:font_tex ~src_rect ~dst_rect ();
    (* END: DRAW FONT *)
    Render.render_present renderer
  in
  (* Could put draw in loop, but currently no changes happen so it's 
   * better performance to not draw every single frame. In future: dirty
   * bit determines if we draw. *)
  draw ();
  let rec loop () =
    let should_quit = poll_events () in
    if should_quit then Sdl.quit () else loop ()
  in
  loop ()
