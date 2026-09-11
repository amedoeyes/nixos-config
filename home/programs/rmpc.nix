{
  lib,
  config,
  ...
}:
let
  cfg = config.programs.rmpc;
in
{
  config = lib.mkIf cfg.enable {
    services = {
      mpd = {
        enable = true;
        extraConfig = ''
          audio_output {
             type "fifo"
             name "my_fifo"
             path "/tmp/mpd.fifo"
             format "44100:16:2"
          }
        '';
      };
      mpd-mpris.enable = true;
      mpdscribble.enable = true;
    };

    xdg.configFile."rmpc/themes/eyes.ron".text =
      with config.theme.colors;
      # ron
      ''
        #![enable(implicit_some)]
        #![enable(unwrap_newtypes)]
        #![enable(unwrap_variant_newtypes)]
        (
            browser_column_widths: [0, 50, 50],
            background_color: "#${c00.hex}",
            scrollbar: None,
            text_color: "#${c10.hex}",
            header_background_color: "#${c00.hex}",
            modal_background_color: "#${c00.hex}",
            preview_label_style: (fg: "#${c10.hex}"),
            preview_metadata_group_style: (fg: "#${c10.hex}"),
            highlighted_item_style: (fg: "#${c06.hex}"),
            highlight_border_style: (fg: "#${c04.hex}"),
            current_item_style: (bg: "#${c01.hex}"),
            borders_style: (fg: "#${c04.hex}"),
            cava: (
                bg_color: "#${c00.hex}",
                bar_color: Single("#${c10.hex}"),
            ),
            symbols: (
                song: "",
                dir: "",
                playlist: "",
                marker: "█",
                ellipsis: "…",
            ),
            level_styles: (
                info: (fg: "#${c10.hex}"),
                warn: (fg: "#${c10.hex}"),
                error: (fg: "#${c10.hex}"),
                debug: (fg: "#${c10.hex}"),
                trace: (fg: "#${c10.hex}"),
            ),
            progress_bar: (
                symbols: ["━", "━", "━", "━", "━"],
                track_style: (fg: "#${c01.hex}"),
                elapsed_style: (fg: "#${c10.hex}"),
                thumb_style: (fg: "#${c10.hex}"),
            ),
            song_table_format: [
                (prop: (kind: Property(Artist), default: (kind: Text("Unknown"))), width: "20%"),
                (prop: (kind: Property(Title), default: (kind: Text("Unknown"))), width: "35%"),
                (prop: (kind: Property(Album), default: (kind: Text("Unknown"))), width: "35%"),
                (prop: (kind: Property(Duration), default: (kind: Text("-"))), width: "10%", alignment: Right),
            ],
            layout: Split(
                direction: Vertical,
                panes: [
                    (size: "100%", pane: Pane(TabContent)),
                    (
                        size:"6",
                        borders: "TOP",
                        pane: Split(
                            direction: Horizontal,
                            panes: [
                                (
                                    size: "25%",
                                    pane: Split(
                                        direction: Horizontal,
                                        panes: [
                                            (size: "1", pane: Pane(Empty())),
                                            (size: "11", pane: Pane(AlbumArt)),
                                            (size: "1", pane: Pane(Empty())),
                                            (
                                                size: "100%",
                                                pane: Split(
                                                    direction: Vertical,
                                                    panes: [
                                                        (size: "1", pane: Pane(Empty())),
                                                        (
                                                            size: "1",
                                                            pane: Pane(Property(
                                                                scroll_speed: 1,
                                                                content: [(kind: Property(Song(Title)), style: (modifiers: "Bold"), default: (kind: Text("No Song"), style: (modifiers: "Bold")))],
                                                            )),
                                                        ),
                                                        (
                                                            size: "1",
                                                            pane: Pane(Property(
                                                                scroll_speed: 1,
                                                                content: [(kind: Property(Song(Artist)), default: (kind: Text("Unknown")))],
                                                            ))
                                                        ),
                                                        (
                                                            size: "1",
                                                            pane: Pane(Property(
                                                                scroll_speed: 1,
                                                                content: [(kind: Property(Song(Album)), default: (kind: Text("Unknown")))],
                                                            ))
                                                        ),
                                                        (size: "1", pane: Pane(Empty())),
                                                    ]
                                                ),
                                            ),
                                        ]
                                    )
                                ),
                                (
                                    size: "50%",
                                    pane: Split(
                                        direction: Vertical,
                                        panes: [
                                            (size: "1", pane: Pane(Empty())),
                                            (
                                                size: "1",
                                                pane: Split(
                                                    direction: Horizontal,
                                                    panes: [
                                                        (
                                                            size: "100%",
                                                            pane: Pane(Property(
                                                                align: Center,
                                                                content: [(kind: Property(Status(StateV2(playing_label: "", paused_label: "", stopped_label: ""))))],
                                                            ))
                                                        ),
                                                    ],
                                                ),
                                            ),
                                            (size: "1", pane: Pane(Empty())),
                                            (
                                                size: "1",
                                                pane: Split(
                                                    direction: Horizontal,
                                                    panes: [
                                                        (size: "1", pane: Pane(Empty())),
                                                        (size: "10", pane: Pane(Property(content: [(kind: Property(Status(Elapsed)))], align: Right))),
                                                        (size: "1", pane: Pane(Empty())),
                                                        (size: "100%", pane: Pane(ProgressBar)),
                                                        (size: "1", pane: Pane(Empty())),
                                                        (size: "10", pane: Pane(Property(content: [(kind: Property(Status(Duration)))], align: Left))),
                                                        (size: "1", pane: Pane(Empty())),
                                                    ],
                                                ),
                                            ),
                                        ]
                                    ),
                                ),
                                (
                                    size: "25%",
                                    pane: Split(
                                        direction: Vertical,
                                        panes: [
                                            (size: "1", pane: Pane(Empty())),
                                            (
                                                size: "1",
                                                pane: Split(
                                                    direction: Horizontal,
                                                    panes: [
                                                        (size: "1", pane: Pane(Empty())),
                                                        (
                                                            size: "25%",
                                                            pane: Pane(Property(
                                                                align: Center,
                                                                content: [
                                                                    (
                                                                        kind: Property(Status(RepeatV2(
                                                                            on_label: "",
                                                                            off_label: "",
                                                                            off_style: (fg: "#${c06.hex}"),
                                                                            on_style: (fg: "#${c10.hex}"),
                                                                        )))
                                                                    ),
                                                                ],
                                                            ))
                                                        ),
                                                        (
                                                            size: "25%",
                                                            pane: Pane(Property(
                                                                align: Center,
                                                                content: [
                                                                    (
                                                                        kind: Property(Status(RandomV2(
                                                                            on_label: "",
                                                                            off_label: "",
                                                                            off_style: (fg: "#${c06.hex}"),
                                                                            on_style: (fg: "#${c10.hex}"),
                                                                        )))
                                                                    ),
                                                                ],
                                                            ))
                                                        ),
                                                        (
                                                            size: "25%",
                                                            pane: Pane(Property(
                                                                align: Center,
                                                                content: [
                                                                    (
                                                                        kind: Property(Status(ConsumeV2(
                                                                            on_label: "",
                                                                            off_label: "",
                                                                            oneshot_label: "",
                                                                            off_style: (fg: "#${c06.hex}"),
                                                                            oneshot_style: (fg: "#${c08.hex}"),
                                                                            on_style: (fg: "#${c10.hex}"),
                                                                        )))
                                                                    ),
                                                                ],
                                                            ))
                                                        ),
                                                        (
                                                            size: "25%",
                                                            pane: Pane(Property(
                                                                align: Center,
                                                                content: [
                                                                    (
                                                                        kind: Property(Status(SingleV2(
                                                                            on_label: "",
                                                                            off_label: "",
                                                                            oneshot_label: "",
                                                                            off_style: (fg: "#${c06.hex}"),
                                                                            oneshot_style: (fg: "#${c08.hex}"),
                                                                            on_style: (fg: "#${c10.hex}"),
                                                                        )))
                                                                    ),
                                                                ],
                                                            ))
                                                        ),
                                                        (size: "1", pane: Pane(Empty())),
                                                    ]
                                                )
                                            ),
                                            (size: "1", pane: Pane(Empty())),
                                            (
                                                size: "1",
                                                pane: Split(
                                                    direction: Horizontal,
                                                    panes: [
                                                        (size: "1", pane: Pane(Empty())),
                                                        (
                                                            size: "100%",
                                                            pane: Pane(Volume(
                                                                kind: Slider(
                                                                    symbols: (filled: "━", thumb: "━", track: "━"),
                                                                    filled_style: (fg: "#${c10.hex}"),
                                                                    thumb_style: (fg: "#${c10.hex}"),
                                                                    track_style: (fg: "#${c01.hex}"),
                                                                )
                                                            ))
                                                        ),
                                                        (size: "1", pane: Pane(Empty())),
                                                        (size: "4", pane: Pane(Property(content: [(kind: Property(Status(Volume))), (kind: Text("%"))], align: Right))),
                                                        (size: "1", pane: Pane(Empty())),
                                                    ]
                                                )
                                            ),
                                        ],
                                    ),
                                ),
                            ],
                        ),
                    ),
                ],
            ),
        )
      '';

    programs = {
      cava.enable = true;
      rmpc = {
        config =
          #ron
          ''
            #![enable(implicit_some)]
            #![enable(unwrap_newtypes)]
            #![enable(unwrap_variant_newtypes)]
            (
                theme: "eyes",
                lyrics_dir: "${config.xdg.userDirs.music}",
                cava: (
                    input: (
                        method: Fifo,
                        source: "/tmp/mpd.fifo",
                        sample_rate: 44100,
                        channels: 2,
                        sample_bits: 16,
                    ),
                ),
                keybinds: (
                    global: {
                        "1": SwitchToTab("Main"),
                        "2": SwitchToTab("Queue"),
                        "3": SwitchToTab("Directories"),
                        "4": SwitchToTab("Artists"),
                        "5": SwitchToTab("Album Artists"),
                        "6": SwitchToTab("Albums"),
                        "7": SwitchToTab("Playlists"),
                        "8": SwitchToTab("Search"),
                    },
                ),
                tabs: [
                    (
                        name: "Main",
                        pane: Split(
                            direction: Vertical,
                            panes: [
                                (
                                    size: "25%",
                                    borders: "BOTTOM",
                                    pane: Split(
                                        direction: Horizontal,
                                        panes: [
                                            (size: "1", pane: Pane(Empty())),
                                            (size: "100%", pane: Pane(Cava)),
                                            (size: "1", pane: Pane(Empty())),
                                        ]
                                    ),
                                ),
                                (
                                    size: "75%",
                                    pane: Split(
                                        direction: Horizontal,
                                        panes: [
                                            (size: "1", pane: Pane(Empty())),
                                            (size: "75%", pane: Pane(Queue)),
                                            (
                                                size: "25%",
                                                borders: "LEFT",
                                                pane: Split(
                                                    direction: Horizontal,
                                                    panes: [
                                                        (size: "1", pane: Pane(Empty())),
                                                        (size: "100%", pane: Pane(Lyrics)),
                                                    ]
                                                ),
                                            ),
                                            (size: "1", pane: Pane(Empty())),
                                        ]
                                    ),
                                ),
                            ],
                        ),
                    ),
                    (name: "Queue", pane: Pane(Queue)),
                    (name: "Directories", pane: Pane(Directories)),
                    (name: "Artists", pane: Pane(Artists)),
                    (name: "Album Artists", pane: Pane(AlbumArtists)),
                    (name: "Albums", pane: Pane(Albums)),
                    (name: "Playlists", pane: Pane(Playlists)),
                    (name: "Search", pane: Pane(Search)),
                ],
            )
          '';
      };
    };
  };
}
