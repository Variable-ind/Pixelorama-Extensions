GDPC                                                                               D   res://.import/PlaceHolder.png-9ac8ce407c63c0424579abf0f82b6144.stex �]      �       S�9���d���;���Y0   res://addons/BugReporter/TranslatedReporter.tscn`	            ��%�Aӿ8��B�Za�E,   res://addons/BugReporter/config_example.cfg p      �       ��,�p@�,!Xx��V$   res://addons/BugReporter/plugin.cfg       �       $�5�\�$=/2��,   res://addons/BugReporter/reporter.gd.remap  0�      6       �����_���7��"t(   res://addons/BugReporter/reporter.gdc   �      �      F!�����%���ﰗ(   res://addons/BugReporter/reporter.tscn  @#      �      ��|�y���M kǾ�$   res://addons/BugReporter/webhook.cfg0,      �       �4�~�Qm����=�M   res://export_presets.cfg-      �      �"ę�t�/��xl�   res://project.binary�      �      �\�А��?+i��0   res://src/Extensions/VariableStore/Main.gd.remapp�      <       ѪKt�('-O����@_,   res://src/Extensions/VariableStore/Main.gdc  1      s      �V0o�aX�S�q��T,   res://src/Extensions/VariableStore/Main.tscn�6      �       &����TRx�&GV@   res://src/Extensions/VariableStore/Store/Entry/Entry.gd.remap   ��      I       ��>��r�n6�!��8   res://src/Extensions/VariableStore/Store/Entry/Entry.gdc07      L      �K�8���_`�"_�<   res://src/Extensions/VariableStore/Store/Entry/Entry.tscn   �N      F      �����&!<ڇ�:5H   res://src/Extensions/VariableStore/Store/Entry/PlaceHolder.png.import   �^      �      �[��=zJ�1�ݚ��/8   res://src/Extensions/VariableStore/Store/Store.gd.remap  �      C       VO��rǉ�pl�@1�B64   res://src/Extensions/VariableStore/Store/Store.gdc  �a      i      T0��	Y�]�JE=�>J%4   res://src/Extensions/VariableStore/Store/Store.tscn �{      �8      �~��<D>A#��B��<   res://src/Extensions/VariableStore/Store/StoreButton.tscn   �      |      FU@q�$����6��KQP   res://src/Extensions/VariableStore/Store/Sub Scripts/CustomStoreLinks.gd.remap  P�      Z       2<7�����q�26^�L   res://src/Extensions/VariableStore/Store/Sub Scripts/CustomStoreLinks.gdc   `�            �r�x.s�bj���L   res://src/Extensions/VariableStore/Store/Sub Scripts/SearchManager.gd.remap ��      W       ���&��+��6�
��,�H   res://src/Extensions/VariableStore/Store/Sub Scripts/SearchManager.gdc  ��      �      ە&h���T=^~�44   res://src/Extensions/VariableStore/extension.json   0�      �       *}��pdD��}-�_�a            [gd_scene load_steps=2 format=2]

[ext_resource path="res://addons/BugReporter/reporter.tscn" type="PackedScene" id=1]

[node name="Reporter" instance=ExtResource( 1 )]

[node name="Label" parent="VBox" index="0"]
text = "T_FEEDBACK"

[node name="OptionButton" parent="VBox" index="1"]
text = "T_BUGREPORT"
items = [ "T_BUGREPORT", null, false, 0, null, "T_FEEDBACK", null, false, 1, null, "T_FEATURE_REQUEST", null, false, 2, null ]

[node name="Label2" parent="VBox" index="2"]
text = "T_MESSAGE_LABEL"

[node name="Label" parent="VBox/Mail" index="0"]
margin_right = 118.0
text = "T_CONTACT_LABEL"

[node name="LineEdit" parent="VBox/Mail" index="1"]
margin_left = 122.0
placeholder_text = "T_CONTACT_HINT"

[node name="SendButton" parent="VBox" index="7"]
text = "T_SEND"
        [webhook]

url="https://discord.com/api/webhooks/<webhook.id>/<webhook.token>"
game_name="BugReporter"
tts=false
color=15258703
anonymous_players=false

       [plugin]

name="BugReporter"
description="Sends a Bugreport using a discord webhook."
author="ASecondGuy"
version="1.0"
script="plugin.gd"
     GDSC   R   /   �   +     �������������Ķ�   �������޶���   ��������������Ҷ   ���������������Ҷ���   ���Ѷ���   ���������Ӷ�   ����������¶   ���ζ���   ����������¶   ����������������ݶ��   �������ζ���   ����ڶ��   �������¶���   ���ڶ���   ����ƶ��   ����������¶   �����������ض���   ���������ض�   �����϶�   ����   ��Ķ   ����   ���������������������Ҷ�   ���������������������Ŷ�   ���������¶�   �������������������   ����������Ӷ   �Ķ�   �����������ض���   ���¶���   ������Ӷ   ������Ӷ   ������Ӷ   ��������Ҷ��   ��������������Ҷ   ��������Ӷ��   �����������ٶ���   �����¶�   �����������϶���   �����������Ҷ���   �������������Ӷ�   ����Ҷ��   �����Ŷ�   ����϶��   ��������ݶ��   ������Ҷ   ������Ӷ   ���������¶�   ������Ҷ   ������������������׶   ������¶   �����������   �������Ҷ���$   ��������������������������������Ҷ��   �����¶�   ������������Ӷ��   ������Ŷ   ���϶���   ���Ӷ���   ����Ķ��   �嶶   �������Ӷ���   ������������Ҷ��   ��������������������Ŷ��   ������Ӷ   �������Ӷ���   ��Ѷ   �������׶���   ����Ŷ��   �����������������Ķ�   ���Ӷ���   �����Ӷ�   ��������޶��   ���������¶�   ����϶��   �����������Ķ���   �����¶�   ������¶   ��������Ŷ��   ����������Ӏ����   �������������������Ҷ���   ���������ض�   $   res://addons/BugReporter/webhook.cfg                ,   Bugreporter couldn't load config. Reason: %s      ```              playerid: %s      webhook       anonymous_players      	   anonymous         username      %s:       tts       title         %s by %s      color      O��       name      Contact Info:         value         Message:   
   ```
%s
```        image         url       attachment://screenshot0.png      fields        embeds        connection: keep-alive     4   Content-type: multipart/form-data; boundary=boundary      HTML5         Webuser       |      	   game_name         unnamed_game    z                    --boundary
    T   Content-Disposition: form-data; name="payload_json"
Content-Type: application/json

      
      *   Content-Type: image/png; name="files[%s]"
     =   Content-Disposition: attachment; filename="screenshot%s.png"
      X   Content-Transfer-Encoding: base64
X-Attachment-Id: f_ljiz6nfz0
Content-ID: <f_ljiz6nfz0>      

              --boundary--   )   https://github.com/ASecondGuy/BugReporter                                                       	       
   !      "      ,      5      B      J      S      T      U      [      c      n      t      {      |      }      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )     *     +     ,     -   !  .   (  /   )  0   2  1   8  2   =  3   A  4   D  5   E  6   N  7   T  8   Y  9   `  :   b  ;   d  <   e  =   f  >   l  ?   s  @   x  A   z  B   {  C   �  D   �  E   �  F   �  G   �  H   �  I   �  J   �  K   �  L   �  M   �  N   �  O   �  P   �  Q   �  R   �  S   �  T   �  U   �  V   �  W   �  X   �  Y   �  Z   �  [   �  \     ]     ^     _     `     a   "  b   %  c   ;  d   <  e   B  f   N  g   O  h   _  i   i  j   t  k   u  l     m   �  n   �  o   �  p   �  q   �  r   �  s   �  t   �  u   �  v   �  w   �  x   �  y   �  z   �  {   �  |   �  }   �  ~   �     �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �     �     �     �     �     �     �     �   "  �   )  �   3YYY8;�  VY8;�  V�  Y8;�  V�  YYY;�  V�  YYY5;�  VW�  �  Y5;�	  W�  �
  Y5;�  V�  W�  �  �  Y5;�  VW�  Y5;�  W�  �  YYY0�  PQV�  �  �  T�  PQ�  ;�  V�  T�L  P�  Q�  &�  �  V�  �E  P�  �  QYYY0�  PQV�  &�  T�  PQ�  T�  V�  .Y�  ;�  V�  PW�  �  T�  Q�  ;�  V�  W�  �  T�  T�   P�  R�  Q�  ;�!  V�  �"  PQ�  &�  T�#  P�  R�  R�  QV�  �!  �	  �  ;�$  V�  T�  T�%  PQY�  ;�&  VLM�  ;�'  VN�  �
  V�  �(  PQR�  �  V�  T�#  P�  R�  R�  QR�  O�  ;�)  N�  �  V�  L�  R�!  MR�  �  V�  T�#  P�  R�  R�  QR�  O�  ;�*  VLMY�  &�$  T�+  PQV�  �*  T�,  PN�  �  V�  R�  �  V�$  �  OQY�  &�  T�+  PQV�  �*  T�,  PN�  �  V�  R�  �  V�  �  R�  O�  QYY�  &�	  T�-  V�  �)  L�  MN�  �  V�  R�  OY�  �&  T�,  P�  T�.  QY�  �)  L�  M�*  �  �'  L�  ML�)  MY�  �&  T�/  P�'  Q�  ;�0  V�1  P�&  QY�  &�*  T�+  PQV�  .Y�  �  T�2  P�  T�#  P�  R�  R�  QR�  �  PL�  R�  MQR�  �  R�  �  T�3  R�  �0  �  Q�  �  T�4  �  YYY0�5  P�6  R�7  R�8  R�9  QV�  �  T�4  �  �  &�  V�  �:  PQ�  &�  V�  �  T�;  PQ�  W�  �  T�  �  YYY0�"  PQX�  V�  &�<  T�=  PQ�  V�  .�  �  .�>  P�R  P�>  P�<  T�>  PQR�  R�(  PQQQQYY0�(  PQV�  .�  T�#  P�  R�   R�!  QYY0�?  P�.  V�@  R�A  V�"  QX�  V�  ;�B  V�.  T�C  PQ�  ;�D  V�  �B  T�E  PQY�  *�D  T�F  PQ�A  V�  �B  T�G  P�B  T�H  PQ�#  R�B  T�I  PQ�#  Q�  �D  �B  T�E  PQY�  .�D  YYY0�1  P�J  V�  QX�  V�  YYYYYYYYYY�  ;�K  V�$  �  ;�L  �  YY�  )�M  �J  V�  �L  �%  Y�  &�M  4�  V�  �L  �&  �  �L  �Q  P�M  Q�'  Y�  '�M  4�@  V�  �L  �(  �K  �  �L  �)  �K  �  �L  �*  �  �L  �+  �  �L  �N  T�O  P�?  P�M  QQ�'  �  �K  �,  Y�  �L  �-  �  .�L  YYY0�P  PQX=V�  �<  T�Q  P�.  QY`          [gd_scene load_steps=2 format=2]

[ext_resource path="res://addons/BugReporter/reporter.gd" type="Script" id=1]

[node name="Reporter" type="PanelContainer"]
margin_right = 387.0
margin_bottom = 488.0
script = ExtResource( 1 )

[node name="VBox" type="VBoxContainer" parent="."]
margin_left = 7.0
margin_top = 7.0
margin_right = 380.0
margin_bottom = 481.0

[node name="Label" type="Label" parent="VBox"]
margin_right = 373.0
margin_bottom = 14.0
text = "Made by \"ASecondGuy\""
align = 1

[node name="OptionButton" type="OptionButton" parent="VBox"]
margin_top = 18.0
margin_right = 373.0
margin_bottom = 38.0
text = "Bugreport"
items = [ "Bugreport", null, false, 0, null, "Feedback", null, false, 1, null, "Feature Request", null, false, 2, null ]
selected = 0

[node name="Label2" type="Label" parent="VBox"]
margin_top = 42.0
margin_right = 373.0
margin_bottom = 56.0
text = "Message:"

[node name="Message" type="TextEdit" parent="VBox"]
margin_top = 60.0
margin_right = 373.0
margin_bottom = 160.0
rect_min_size = Vector2( 0, 100 )
wrap_enabled = true

[node name="Mail" type="HBoxContainer" parent="VBox"]
margin_top = 164.0
margin_right = 373.0
margin_bottom = 188.0

[node name="Label" type="Label" parent="VBox/Mail"]
margin_top = 5.0
margin_right = 148.0
margin_bottom = 19.0
text = "Contact Info (Optional):"

[node name="LineEdit" type="LineEdit" parent="VBox/Mail"]
margin_left = 152.0
margin_right = 373.0
margin_bottom = 24.0
size_flags_horizontal = 3
placeholder_text = "e-mail or Discord Username"

[node name="CheckBox" type="CheckBox" parent="VBox"]
visible = false
margin_top = 192.0
margin_right = 373.0
margin_bottom = 216.0
disabled = true
text = "attach last screenshot"

[node name="TextureRect" type="TextureRect" parent="VBox"]
margin_top = 192.0
margin_right = 373.0
margin_bottom = 331.0
size_flags_vertical = 3
expand = true
stretch_mode = 6

[node name="SendButton" type="Button" parent="VBox"]
margin_top = 454.0
margin_right = 373.0
margin_bottom = 474.0
size_flags_vertical = 10
text = "Send"

[node name="HTTPRequest" type="HTTPRequest" parent="."]

[connection signal="pressed" from="VBox/SendButton" to="." method="_on_SendButton_pressed"]
[connection signal="request_completed" from="HTTPRequest" to="." method="_on_HTTPRequest_request_completed"]
[webhook]

url="https://discord.com/api/webhooks/1134569956554592307/S6Vfn4gL2FT-sYEZTe2TAJvu59I65Dfpnu5d9gqC8uoBf1h_9bCGTkSbz4_QAHGmseEF"
game_name="VariableStore"
tts=false
color=15258703
anonymous_players=false
          [preset.0]

name="Windows Desktop"
platform="Windows Desktop"
runnable=true
custom_features=""
export_filter="all_resources"
include_filter="*.json, *.cfg"
exclude_filter=""
export_path=""
script_export_mode=1
script_encryption_key=""

[preset.0.options]

custom_template/debug=""
custom_template/release=""
binary_format/64_bits=true
binary_format/embed_pck=false
texture_format/bptc=false
texture_format/s3tc=true
texture_format/etc=false
texture_format/etc2=false
texture_format/no_bptc_fallbacks=true
codesign/enable=false
codesign/identity_type=0
codesign/identity=""
codesign/password=""
codesign/timestamp=true
codesign/timestamp_server_url=""
codesign/digest_algorithm=1
codesign/description=""
codesign/custom_options=PoolStringArray(  )
application/modify_resources=true
application/icon=""
application/file_version=""
application/product_version=""
application/company_name=""
application/product_name=""
application/file_description=""
application/copyright=""
application/trademarks=""
         GDSC         2   �      ���Ӷ���   ������������   ��������������   �����������ض���   �����ض�   ����������Ӷ   �����ڶ�   ���������������ڶ���   ������������������Ķ   ������ڶ   ��������Ӷ��   �������Ӷ���   ��������Ҷ��   ���������Ӷ�   ���������ݶ�   ���¶���   �����¶�   �������Ӷ���   ��������Ҷ��   ���������Ӷ�   ���������Ӷ�   [   https://raw.githubusercontent.com/Variable-Interactive/Variable-Store/master/store_info.txt       VariableStore         /root/Global   
   Extensions     .   res://src/Extensions/%s/Store/StoreButton.tscn               Open %s       HBoxContainer                                                       	      
                                                                !      "      #      $      %      &      '      (      )      *      +      ,       1   !   2   "   :   #   B   $   F   %   R   &   V   '   c   (   n   )   y   *   �   +   �   ,   �   -   �   .   �   /   �   0   �   1   �   2   3YYYYYY:�  V�  Y:�  V�  �  YYYYYYYYYYYYYYYYYYYYYYYY;�  V�  YY0�  PQX=V�  ;�  �  P�  Q�  &�  V�  ;�  �  T�	  T�
  P�  Q�  &�  V�  �  �L  P�  �  QT�  PQ�  �  T�  P�  QT�  �  �  �  T�  P�  QT�  �  �  �  T�  P�  QT�  �  �  �  T�  �  �  �  ;�  �  T�  P�  Q�  �  T�  P�  QYYY0�  PQX=V�  �  T�  PQY`             [gd_scene load_steps=2 format=2]

[ext_resource path="res://src/Extensions/VariableStore/Main.gd" type="Script" id=1]

[node name="Main" type="Node"]
script = ExtResource( 1 )
GDSC   q      �        ����ڶ��   ������������������Ķ   ������������Ķ��   ��������ڶ��   ������������ݶ��   ������������޶��   ���Ŷ���   ��������Ӷ��   �������Ӷ���   ������������Ķ��   ���Ӷ���   ��������������ض   ����������ض   ����������Ӷ   ������Ӷ   ����������ض   �������Ҷ���   �������������������Ķ���   ��������������¶   ������������Ҷ��   �������ٶ���   ���ٶ���   �������������޶�   ���¶���   �������������������������Ӷ�   �����������ƶ���   ���۶���   ���������ﶶ   ���������Ķ�   ��������¶��   �����������϶���   ����������ڶ   ��Ķ   ��������϶��   ����   �����Ķ�   �����������������Ӷ�   �����������϶���   ��������Ӷ��   ����¶��   �����������������������¶���   ���������Ӷ�   �����������¶���   ������¶$   ���������������������������������Ҷ�   ������¶   �������������Ӷ�   �������Ŷ���   ���϶���   ����Ӷ��   ����Ӷ��   �������������������Ķ���   ����   ���ć���   �������������������Ķ���   ���Ą���   ��������������������Ķ��   ���ą���   �������������������Ķ���   ���Ă���   �������������������Ķ���   ������Ӷ   �����������Ӷ���   ����������������Ӷ��   �������������ڶ�   ������¶   �������������������Ҷ���   �������Ҷ���   ������������Ӷ��   ���������������Ŷ���(   ������������������������������������Ҷ��   �����¶�   ����϶��   ����������¶   �������������嶶   ����������������ض��   ������������Ӷ��   ����¶��   ���¶���   ���������Ӷ�   �������������Ҷ�   �����Ӷ�   ������Ŷ   �������������Ŷ�   ���Ӷ���   ������Ӷ   ��������϶��   ���������޶�   ��������϶��   ���Ӷ���   ��Ѷ   ���Ӷ���   ����������ض   ��������ض��   ���������Ŷ�   ���Ŷ���   ��������Ӷ��   ����������ض   ������ض   ������������   ����������������ڶ��   ���������¶�   ��������������������¶��   ����������Ķ   ����Ӷ��   ������������Ķ��   ��������������Ŷ   ���ض���   �������������������Ŷ���   ����ڶ��   ������������Ӷ��   ���ƶ���   ������������������������¶��                           -v                    Tags      tags_detected      	   Download/         .pck      pressed       enlarge_thumbnail            +   Unable to Download extension...
Http Code (       )         Re-Download       Update     	   %Enlarged        �B                                                    	      
               '      ,      -      :      G      R      _      f      g      j      k      z      �      �      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   
  -     .     /   &  0   -  1   .  2   /  3   7  4   >  5   I  6   J  7   K  8   \  9   ]  :   d  ;   m  <   w  =   }  >   �  ?   �  @   �  A   �  B   �  C   �  D   �  E   �  F   �  G   �  H   �  I   �  J   �  K   �  L   �  M   �  N   �  O   �  P   �  Q   �  R      S     T     U     V     W   "  X   &  Y   *  Z   /  [   2  \   F  ]   M  ^   R  _   \  `   f  a   g  b   h  c   i  d   r  e   v  f   |  g   �  h   �  i   �  j   �  k   �  l   �  m   �  n   �  o   �  p   �  q   �  r   �  s   �  t   �  u   �  v   �  w   �  x   �  y   �  z   �  {   �  |   �  }   �  ~          �     �   #  �   '  �   -  �   3  �   4  �   5  �   6  �   ?  �   F  �   Q  �   R  �   S  �   T  �   \  �   i  �   j  �   k  �   l  �   r  �     �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �     �   3YYYYYYY;�  V�  Y;�  VY;�  VY;�  VY;�  V�  PQY;�  �  YY5;�  W�	  �  �
  Y5;�  W�	  �  �  Y5;�  W�	  �  Y5;�  W�	  �  �  Y5;�  W�  YYB�  YY0�  P�  V�  R�  V�  QX=V�  �  T�  �>  P�  L�  MR�  R�  L�  MQ�  �  P�  L�  MR�  L�  MQ�  �  T�  �  L�  M�  �  T�  �  T�  �  �  �  L�  M�  �  �  L�  MY�  �  )�  �  V�  &�:  P�  Q�  V�  �  ;�  �  T�  PQ�  &�  V�  �  &�  �  V�  �  T�  P�  Q�  �  P�  R�  QYY�  ;�   V�!  T�"  PQ�  ;�#  �   T�$  P�>  P�  R�  QQ�  �  �>  P�  R�  R�  L�  MR�	  QY�  W�%  T�&  �'  PQ�  �  W�%  T�'  PQYYY0�(  PQX=V�  W�%  T�)  PQ�  ;�#  W�*  T�+  P�  QYYY0�,  P�-  R�.  R�/  R�0  V�  QX=V�  �  W�*  T�)  PQ�  ;�1  �2  T�"  PQ�  ;�#  �1  T�3  P�0  Q�  &�#  �4  V�  ;�5  �1  T�6  P�0  Q�  &�5  �4  V�  ;�7  �1  T�8  P�0  Q�  &�7  �4  V�  ;�9  �1  T�:  P�0  Q�  &�9  �4  V�  ;�;  �1  T�<  P�0  Q�  ;�=  �>  T�"  PQ�  �=  T�?  P�1  Q�  �  T�@  �=  �  �  T�A  P�
  RR�  RL�=  MQYYY0�B  PQX=V�  �  �  T�C  �  �  �  T�D  �  �  �  T�+  P�  Q�  �E  PQYYYY0�F  P�G  V�  R�.  R�/  R�H  QX=V�  &�G  �I  T�J  V�  �  �  T�K  P�  Q�  &�  V�  �  �  �  �L  P�  Q�  (V�  W�M  �N  T�  �>  P�  R�G  R�  QT�O  PQ�  W�M  T�P  PQ�  �L  P�  Q�  ;�   V�!  T�"  PQ�  ;�#  �   T�Q  P�  QYYYY0�L  P�R  V�  QV�  �S  PQ�  �  T�C  �  �  &�R  V�  W�	  �  �T  T�U  �  �  �  T�  �  �  W�V  T�'  PQYYYY0�W  P�X  V�  QV�  &�  T�Y  PQ�  V�  )�Z  �X  V�  &�Z  �  V�  .�  �  .�  �  (V�  &�X  T�Y  PQ�  V�  .�  �  .�  YYYY0�  P�[  V�  R�\  V�  QV�  )�]  �  T�^  T�_  PQV�  &�  T�^  L�]  MT�`  �[  V�  ;�a  �H  P�  T�^  L�]  MT�b  Q�  &�:  P�a  Q�c  V�  &�\  �a  V�  �  T�  �  �  �  �  �  '�\  �a  V�  �  T�  �  YYYY0�d  P�=  V�>  QV�  W�  T�=  �=  �  W�  T�e  PQT�P  PQYYYY0�f  PQX=V�  W�	  �  �T  T�U  �  YYYY0�E  PQV�  W�	  �  �g  T�U  �  �  W�	  �  �g  T�h  �  �  W�	  �  �g  �i  T�'  PQYYYY0�j  PQV�  ;�k  �  T�l  PQ�  ;�m  �  T�n  PQ�  W�	  �  �g  T�h  P�  P�k  Q�  P�m  QQ�  YYYY0�S  PQV�  W�	  �  �g  T�U  �  �  W�	  �  �g  �i  T�o  PQYYYY0�p  PQV�  �j  PQY`    [gd_scene load_steps=3 format=2]

[ext_resource path="res://src/Extensions/VariableStore/Store/Entry/Entry.gd" type="Script" id=1]
[ext_resource path="res://src/Extensions/VariableStore/Store/Entry/PlaceHolder.png" type="Texture" id=2]

[node name="Entry" type="Panel"]
self_modulate = Color( 0.411765, 0.411765, 0.411765, 1 )
margin_right = 399.0
margin_bottom = 140.0
rect_min_size = Vector2( 250, 140 )
size_flags_horizontal = 3
script = ExtResource( 1 )

[node name="Panel" type="Panel" parent="."]
self_modulate = Color( 0.701961, 0.701961, 0.701961, 1 )
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 3.0
margin_top = 4.0
margin_right = -3.0
margin_bottom = -4.0
mouse_filter = 1
__meta__ = {
"_editor_description_": ""
}

[node name="HBoxContainer" type="HBoxContainer" parent="Panel"]
anchor_right = 1.0
anchor_bottom = 1.0
margin_right = -6.0
margin_bottom = -8.0

[node name="Picture" type="TextureButton" parent="Panel/HBoxContainer"]
margin_right = 100.0
margin_bottom = 124.0
rect_min_size = Vector2( 100, 0 )
mouse_default_cursor_shape = 2
texture_normal = ExtResource( 2 )
expand = true
stretch_mode = 5

[node name="VBoxContainer" type="VBoxContainer" parent="Panel/HBoxContainer"]
margin_left = 104.0
margin_right = 387.0
margin_bottom = 124.0
size_flags_horizontal = 3

[node name="Name" type="Label" parent="Panel/HBoxContainer/VBoxContainer"]
margin_right = 283.0
margin_bottom = 14.0
text = "Extension Name..."

[node name="Description" type="TextEdit" parent="Panel/HBoxContainer/VBoxContainer"]
margin_top = 18.0
margin_right = 283.0
margin_bottom = 100.0
size_flags_vertical = 3
text = "Description"
readonly = true
wrap_enabled = true

[node name="Done" type="Label" parent="Panel/HBoxContainer/VBoxContainer"]
visible = false
self_modulate = Color( 0.337255, 1, 0, 1 )
margin_top = 46.0
margin_right = 283.0
margin_bottom = 60.0
text = "Done!!!"
align = 1

[node name="ProgressBar" type="ProgressBar" parent="Panel/HBoxContainer/VBoxContainer"]
visible = false
margin_top = 80.0
margin_right = 283.0
margin_bottom = 100.0
rect_min_size = Vector2( 0, 20 )

[node name="ProgressTimer" type="Timer" parent="Panel/HBoxContainer/VBoxContainer/ProgressBar"]
wait_time = 0.1

[node name="Download" type="Button" parent="Panel/HBoxContainer/VBoxContainer"]
margin_top = 104.0
margin_right = 283.0
margin_bottom = 124.0
text = "Download"

[node name="RequestDelay" type="Timer" parent="."]
one_shot = true
autostart = true

[node name="ImageRequest" type="HTTPRequest" parent="."]

[node name="DownloadRequest" type="HTTPRequest" parent="."]

[node name="DoneDelay" type="Timer" parent="."]
wait_time = 2.0

[node name="Alert" type="AcceptDialog" parent="."]
margin_right = 242.0
margin_bottom = 84.0

[node name="Text" type="Label" parent="Alert"]
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 8.0
margin_top = 8.0
margin_right = -8.0
margin_bottom = -36.0
align = 1
valign = 1

[node name="EnlardedThumbnail" type="WindowDialog" parent="."]
margin_right = 349.0
margin_bottom = 303.0
window_title = "Thumbnai"

[node name="Enlarged" type="TextureRect" parent="EnlardedThumbnail"]
unique_name_in_owner = true
margin_left = 7.0
margin_top = 7.0
margin_right = 342.0
margin_bottom = 296.0
expand = true
stretch_mode = 6

[connection signal="timeout" from="Panel/HBoxContainer/VBoxContainer/ProgressBar/ProgressTimer" to="." method="_on_ProgressTimer_timeout"]
[connection signal="pressed" from="Panel/HBoxContainer/VBoxContainer/Download" to="." method="_on_Download_pressed"]
[connection signal="timeout" from="RequestDelay" to="." method="_on_RequestDelay_timeout"]
[connection signal="request_completed" from="ImageRequest" to="." method="_on_ImageRequest_request_completed"]
[connection signal="request_completed" from="DownloadRequest" to="." method="_on_DownloadRequest_request_completed"]
[connection signal="timeout" from="DoneDelay" to="." method="_on_DoneDelay_timeout"]
          GDST               �   WEBPRIFF�   WEBPVP8L�   /��?G���$h?��;��:��Q�F
��D)nn|�,�j���>-��"�G �}]�1v �����V**X�
V��`����D��i�f��q1�����/��Y�~���]1��;u��q���u�-��5}�`V�q�m|����M�ĵ�   [remap]

importer="texture"
type="StreamTexture"
path="res://.import/PlaceHolder.png-9ac8ce407c63c0424579abf0f82b6144.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://src/Extensions/VariableStore/Store/Entry/PlaceHolder.png"
dest_files=[ "res://.import/PlaceHolder.png-9ac8ce407c63c0424579abf0f82b6144.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
GDSC   m      �   G     �����������Ѷ���   ���������ݶ�   ���������Ӷ�   ������������������Ķ   ������������Ķ��   �������������޶�   ���������������������Ӷ�   ���������������������Ѷ�   ������������������Ŷ   ������¶   ��������������������Ķ��   �������������������������Ķ�   �����϶�   ���¶���   �����������Ӷ���   ���������������������ٶ�   �����ڶ�   ���Ӷ���   ���������������ڶ���   ��������������Ŷ   �������������޶�   ����������������   ������������Ӷ��   ��������Ӷ��   ������������������������   �������������Ŷ�   ��Ѷ   �������¶���   �����������ض���   ���������Ӷ�   ����϶��   ����Ķ��   �����������Ŷ���   ���Ӷ���   ���������ٶ�   ���ݶ���   ����Ķ��   ������¶   ����   ���������������Ŷ���   �����������������ٶ�(   �������������������������������������Ҷ�   �����¶�   �������������Ӷ�   �������Ŷ���   ����϶��   ����������¶   �������������嶶   ���Ӷ���   ���Ӷ���   ����   �����Ķ�   ���ض���   ���򶶶�   �������������ض�   ��������������������ض��   ���������������������Ӷ�   ����������Ҷ   ���ٶ���   �������Ӷ���   ������������   ���������ﶶ   ����ڶ��   ����ڶ��   ��������Ҷ��   ��������϶��   �����������   ����������Ŷ   ����������޶   ��������Ҷ��   ����Ӷ��   ��Ķ   ��������϶��   �����Ӷ�   �������������Ŷ�   ����������������������Ҷ   �������������Ҷ�   ����������������������Ҷ   �嶶   ��������Ҷ��   �������������������������Ҷ�   ���������ض�   �������Ӷ���   ������¶   �������ٶ���   ����Ķ��   �����Ҷ�   ���������������������޶�   ����������������Ӷ��   ��Ķ   ��������ض��   ����������¶   ��Ŷ   ������ض   ������������ڶ��   ������Ӷ   ����������Ķ   ����Ӷ��   ����������Ķ   ����¶��   ��������������Ŷ   ���ض���   �������������������Ŷ���   ����ڶ��   ������������Ӷ��   ���ƶ���   ��������ݶ��   ����������۶   ����������������������¶      %Content      %VariableStore        .txt       (        )         /root/Global      %SearchManager        %CustomStoreLinks             ,   Unable to Get info from remote repository...                   Version        is Available                #            F   sudo flatpak override com.orama_interactive.Pixelorama --share=network     :   https://variable-interactive.itch.io/pixelorama-extensions     .   res://src/Extensions/%s/Store/Entry/Entry.tscn        tags_detected         add_new_tags   &   res://src/Extensions/%s/extension.json        Error loading config file:        No JSON data found.       version      �B      %FaultyLinks      
                                                       	      
                           #      (      -      .      /      8      ?      @      A      I      J      Q      Z      i      j      t      x      |       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .   �   /   �   0   �   1   �   2   �   3   �   4   �   5   �   6      7     8   
  9     :     ;     <     =     >     ?   0  @   8  A   9  B   :  C   C  D   V  E   [  F   b  G   h  H   i  I   r  J   ~  K     L   �  M   �  N   �  O   �  P   �  Q   �  R   �  S   �  T   �  U   �  V   �  W   �  X   �  Y   �  Z   �  [   �  \   �  ]   �  ^     _     `     a     b     c   (  d   6  e   :  f   =  g   B  h   F  i   G  j   H  k   I  l   J  m   K  n   S  o   W  p   X  q   Y  r   Z  s   `  t   f  u   g  v   h  w   i  x   o  y   p  z   w  {   x  |   y  }   z  ~   �     �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �     �     �     �   "  �   (  �   .  �   /  �   ;  �   A  �   B  �   G  �   L  �   R  �   S  �   \  �   g  �   p  �   s  �   v  �   y  �   |  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �     �   
  �     �     �     �   $  �   0  �   7  �   8  �   9  �   :  �   ;  �   A  �   E  �   3YYYYYYY;�  V�  Y;�  V�  Y;�  V�  YYY;�  V�  Y;�  V�  Y;�  V�  Y;�  V�  YYY5;�	  V�  WY5;�
  W�  YYY0�  PQX=V�  �  W�  T�  �  �  �  �>  P�  R�  Q�  �  �>  P�  R�  R�  PQR�  Q�  �  ;�  V�  �  P�  Q�  &�  V�  &�  V�  �  �  T�  P�  T�  Q�  �  �
  T�  �  T�  P�  QYYY0�  PQX=V�  �  W�  T�  �  PQ�  )�  W�  T�  T�  PQV�  �  T�  PQ�  �  )�  �	  T�  PQV�  �  T�  PQ�  �  T�  PQ�  �  W�  T�   T�!  PQ�  �"  P�  QYYY0�"  P�#  V�  QX=V�  &�  �  V�  �  �  ;�$  �
  T�%  P�#  Q�  &�$  �&  V�  �'  PQ�  (V�  �B  P�	  Q�  �(  PQYYYY0�)  P�*  V�  R�+  V�  R�,  V�  R�-  V�  QX=V�  &�*  �.  T�/  V�  Y�  ;�0  �1  T�2  PQ�  ;�3  �0  T�4  P�  T�  P�  QR�1  T�5  Q�  ;�6  V�  �  ;�7  �  PQ�  ;�8  V�
  Y�  *�0  T�9  PQV�  ;�:  �H  P�0  T�;  PQQ�  �  &�:  P�:  Q�<  V�  �  �6  �:  �  &�6  �7  �8  V�  �8  �  �  '�:  P�:  Q�=  V�  &�8  V�  ;�>  V�?  T�2  PQ�  �>  T�  �>  P�  R�6  R�  Q�  �	  T�@  P�>  Q�  �A  P�:  Q�  +�  (V�  &�:  L�  M�  V�  �A  P�:  Q�  '�:  P�:  Q�B  V�  ;�#  V�  �:  T�C  PQ�  &�#  T�D  P�  Q�#  �  V�  �  �  �  &�:  W�  T�   V�  W�  T�   T�E  P�:  QY�  �0  T�F  PQ�  ;�G  V�H  T�2  PQ�  �3  �G  T�I  P�  T�  P�  QQ�  �J  PQ�  (V�  �B  P�	  Q�  �(  PQYYYYYY0�K  PQX=V�  �L  PQYYYY0�M  PQV�  �N  T�O  �  YYYY0�P  PQV�  �  �N  T�Q  P�  QYYYY0�A  P�:  V�  QX=V�  ;�  �L  P�  �  QT�R  PQ�  �  T�S  P�  RW�  R�  Q�  �  T�  �  �  �	  T�@  P�  Q�  �  T�T  P�:  R�  QYYYY0�(  PQV�  �  �  &�  W�  T�   T�!  PQV�  W�U  T�L  PQ�  (V�  �  T�V  PW�  T�   L�  MQ�  �J  PQYYYY0�  PQX�  V�  ;�W  V�  �  �  �  ;�X  V�1  T�2  PQ�  ;�Y  V�X  T�4  P�W  R�1  T�5  Q�  &�Y  �&  V�  �B  P�  R�Y  Q�  �X  T�F  PQ�  .�  P�  QY�  ;�Z  �P  P�X  T�[  PQQ�  �X  T�F  PQY�  &�Z  V�  �B  P�  Q�  .�  P�  QY�  &�Z  T�\  P�  QV�  ;�]  �H  P�Z  L�  MQ�  &�:  P�]  Q�<  V�  .�]  �  (V�  .�]  �  (V�  .�  P�  QYYYY0�'  PQV�  W�^  T�_  �  �  W�^  �  �`  T�a  �  �  W�^  �b  T�c  PQYYYY0�d  PQV�  ;�e  �
  T�f  PQ�  ;�g  �
  T�h  PQ�  W�^  �  �`  T�a  P�  P�e  Q�  P�g  QQ�  YYY0�J  PQV�  W�^  T�_  �
  �  W�^  �b  T�i  PQ�  �  �  �  &�  �  V�  ;�j  W�  T�   L�  M�  �"  P�j  Q�  (V�  &�  T�!  PQ�  V�  W�  T�  �  �  )�#  �  V�  W�  T�  �>  P�#  R�  Q�  W�k  T�L  PQYYYYY0�l  PQV�  �d  PQY`       [gd_scene load_steps=5 format=2]

[ext_resource path="res://src/Extensions/VariableStore/Store/Store.gd" type="Script" id=1]
[ext_resource path="res://src/Extensions/VariableStore/Store/Sub Scripts/SearchManager.gd" type="Script" id=2]
[ext_resource path="res://src/Extensions/VariableStore/Store/Sub Scripts/CustomStoreLinks.gd" type="Script" id=3]
[ext_resource path="res://addons/BugReporter/reporter.tscn" type="PackedScene" id=4]

[node name="Store" type="WindowDialog"]
margin_right = 638.0
margin_bottom = 415.0
rect_min_size = Vector2( 150, 150 )
window_title = "Variable Store"
resizable = true
script = ExtResource( 1 )

[node name="TabContainer" type="TabContainer" parent="."]
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 7.0
margin_top = 8.0
margin_right = -7.0
margin_bottom = -8.0
rect_clip_content = true
tab_align = 0
__meta__ = {
"_editor_description_": ""
}

[node name="Store" type="HBoxContainer" parent="TabContainer"]
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 4.0
margin_top = 32.0
margin_right = -4.0
margin_bottom = -4.0

[node name="Parameters" type="VBoxContainer" parent="TabContainer/Store"]
margin_right = 150.0
margin_bottom = 363.0
rect_min_size = Vector2( 150, 0 )

[node name="SearchManager" type="LineEdit" parent="TabContainer/Store/Parameters"]
unique_name_in_owner = true
margin_right = 150.0
margin_bottom = 24.0
placeholder_text = "Search..."
script = ExtResource( 2 )

[node name="Heading" type="HBoxContainer" parent="TabContainer/Store/Parameters"]
margin_top = 28.0
margin_right = 150.0
margin_bottom = 42.0

[node name="Label" type="Label" parent="TabContainer/Store/Parameters/Heading"]
margin_right = 32.0
margin_bottom = 14.0
theme_type_variation = "Header"
text = "Tags:"

[node name="HSeparator" type="HSeparator" parent="TabContainer/Store/Parameters/Heading"]
margin_left = 36.0
margin_right = 150.0
margin_bottom = 14.0
size_flags_horizontal = 3

[node name="ScrollContainer" type="ScrollContainer" parent="TabContainer/Store/Parameters"]
margin_top = 46.0
margin_right = 150.0
margin_bottom = 363.0
size_flags_vertical = 3
scroll_horizontal_enabled = false

[node name="TagList" type="VBoxContainer" parent="TabContainer/Store/Parameters/ScrollContainer"]
unique_name_in_owner = true
margin_right = 64.0
margin_bottom = 24.0

[node name="CheckBox" type="CheckBox" parent="TabContainer/Store/Parameters/ScrollContainer/TagList"]
margin_right = 64.0
margin_bottom = 24.0
text = "ssdas"

[node name="VSeparator" type="VSeparator" parent="TabContainer/Store"]
margin_left = 154.0
margin_right = 158.0
margin_bottom = 363.0

[node name="ContentScrollContainer" type="ScrollContainer" parent="TabContainer/Store"]
margin_left = 162.0
margin_right = 616.0
margin_bottom = 363.0
size_flags_horizontal = 3

[node name="Content" type="VBoxContainer" parent="TabContainer/Store/ContentScrollContainer"]
unique_name_in_owner = true
margin_right = 454.0
size_flags_horizontal = 3

[node name="Options" type="PanelContainer" parent="TabContainer"]
visible = false
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 4.0
margin_top = 32.0
margin_right = -4.0
margin_bottom = -4.0

[node name="ScrollContainer" type="ScrollContainer" parent="TabContainer/Options"]
margin_left = 7.0
margin_top = 7.0
margin_right = 609.0
margin_bottom = 356.0

[node name="CustomStoreLinks" type="VBoxContainer" parent="TabContainer/Options/ScrollContainer"]
unique_name_in_owner = true
margin_right = 602.0
margin_bottom = 76.0
size_flags_horizontal = 3
script = ExtResource( 3 )

[node name="Heading" type="HBoxContainer" parent="TabContainer/Options/ScrollContainer/CustomStoreLinks"]
margin_right = 602.0
margin_bottom = 20.0

[node name="Label" type="Label" parent="TabContainer/Options/ScrollContainer/CustomStoreLinks/Heading"]
margin_top = 3.0
margin_right = 74.0
margin_bottom = 17.0
theme_type_variation = "Header"
text = "Store Links:"

[node name="HSeparator" type="HSeparator" parent="TabContainer/Options/ScrollContainer/CustomStoreLinks/Heading"]
margin_left = 78.0
margin_right = 406.0
margin_bottom = 20.0
size_flags_horizontal = 3

[node name="Guide" type="Button" parent="TabContainer/Options/ScrollContainer/CustomStoreLinks/Heading"]
margin_left = 410.0
margin_right = 602.0
margin_bottom = 20.0
text = "Guide to making a Store File"

[node name="VariableStore" type="LineEdit" parent="TabContainer/Options/ScrollContainer/CustomStoreLinks"]
unique_name_in_owner = true
margin_top = 24.0
margin_right = 602.0
margin_bottom = 48.0
editable = false

[node name="Links" type="VBoxContainer" parent="TabContainer/Options/ScrollContainer/CustomStoreLinks"]
margin_top = 52.0
margin_right = 602.0
margin_bottom = 52.0

[node name="NewLink" type="Button" parent="TabContainer/Options/ScrollContainer/CustomStoreLinks"]
margin_left = 582.0
margin_top = 56.0
margin_right = 602.0
margin_bottom = 76.0
rect_min_size = Vector2( 20, 0 )
size_flags_horizontal = 8
text = "+"

[node name="Speak Your Mind" type="Control" parent="TabContainer"]
visible = false
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 4.0
margin_top = 32.0
margin_right = -4.0
margin_bottom = -4.0

[node name="VBoxContainer" type="VBoxContainer" parent="TabContainer/Speak Your Mind"]
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 31.0
margin_right = -31.0

[node name="SeeAddon" type="Button" parent="TabContainer/Speak Your Mind/VBoxContainer"]
margin_left = 175.0
margin_right = 378.0
margin_bottom = 20.0
size_flags_horizontal = 4
text = "Get this (Bug Reporter) Addon"

[node name="Reporter" parent="TabContainer/Speak Your Mind/VBoxContainer" instance=ExtResource( 4 )]
margin_top = 24.0
margin_right = 554.0
margin_bottom = 254.0

[node name="What\'s new\?" type="PanelContainer" parent="TabContainer"]
visible = false
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 4.0
margin_top = 32.0
margin_right = -4.0
margin_bottom = -4.0

[node name="VBoxContainer" type="VBoxContainer" parent="TabContainer/What\'s new\?"]
margin_left = 7.0
margin_top = 7.0
margin_right = 609.0
margin_bottom = 356.0

[node name="Heading" type="HBoxContainer" parent="TabContainer/What\'s new\?/VBoxContainer"]
margin_right = 602.0
margin_bottom = 14.0

[node name="Label" type="Label" parent="TabContainer/What\'s new\?/VBoxContainer/Heading"]
margin_right = 77.0
margin_bottom = 14.0
theme_type_variation = "Header"
text = "What's new:"

[node name="HSeparator" type="HSeparator" parent="TabContainer/What\'s new\?/VBoxContainer/Heading"]
margin_left = 81.0
margin_right = 602.0
margin_bottom = 14.0
size_flags_horizontal = 3

[node name="NewThings" type="RichTextLabel" parent="TabContainer/What\'s new\?/VBoxContainer"]
margin_top = 18.0
margin_right = 602.0
margin_bottom = 108.0
text = "- Redesigned the UI (Added Tabs).
- Tags are now available!!!
- Easy Bug reporting is now possible
- Exposed store link (and the ability to add your own).
- Added a search system.
- Clicking on thumbnails will enlarge them
- Hovering over descriptions will show them as a tool tip"
fit_content_height = true

[node name="ProgressPanel" type="Panel" parent="."]
visible = false
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 7.0
margin_top = 8.0
margin_right = -7.0
margin_bottom = -8.0
rect_clip_content = true
__meta__ = {
"_editor_description_": ""
}

[node name="VBoxContainer" type="VBoxContainer" parent="ProgressPanel"]
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 44.0
margin_top = 13.0
margin_right = -44.0
margin_bottom = -13.0
alignment = 1

[node name="ProgressBar" type="ProgressBar" parent="ProgressPanel/VBoxContainer"]
margin_top = 130.0
margin_right = 326.0
margin_bottom = 150.0
rect_min_size = Vector2( 0, 20 )

[node name="Label" type="Label" parent="ProgressPanel/VBoxContainer"]
margin_top = 154.0
margin_right = 326.0
margin_bottom = 185.0
text = "Fetching data from Remote Repository
Please Wait"
align = 1
valign = 1

[node name="UpdateTimer" type="Timer" parent="ProgressPanel"]
wait_time = 0.1

[node name="StoreInformationDownloader" type="HTTPRequest" parent="."]

[node name="Error" type="AcceptDialog" parent="."]
margin_right = 428.0
margin_bottom = 356.0
window_title = "Error"
resizable = true

[node name="Panel" type="Panel" parent="Error"]
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 8.0
margin_top = 8.0
margin_right = -8.0
margin_bottom = -36.0

[node name="Content" type="VBoxContainer" parent="Error/Panel"]
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 4.0
margin_top = 4.0
margin_right = -4.0
margin_bottom = -4.0

[node name="Label" type="Label" parent="Error/Panel/Content"]
modulate = Color( 1, 0, 0, 1 )
margin_right = 404.0
margin_bottom = 14.0
text = "Unable to Get info from remote repository..."
autowrap = true

[node name="Reason" type="GridContainer" parent="Error/Panel/Content"]
margin_top = 18.0
margin_right = 404.0
margin_bottom = 32.0
columns = 2

[node name="Number" type="Label" parent="Error/Panel/Content/Reason"]
modulate = Color( 0.968627, 0, 1, 1 )
margin_right = 12.0
margin_bottom = 14.0
size_flags_vertical = 5
text = "1)"

[node name="Label" type="Label" parent="Error/Panel/Content/Reason"]
modulate = Color( 0.968627, 1, 0, 1 )
margin_left = 16.0
margin_right = 404.0
margin_bottom = 14.0
size_flags_horizontal = 3
text = "Check you internet connection."
autowrap = true

[node name="HSeparator" type="HSeparator" parent="Error/Panel/Content"]
margin_top = 36.0
margin_right = 404.0
margin_bottom = 40.0

[node name="Reason2" type="GridContainer" parent="Error/Panel/Content"]
margin_top = 44.0
margin_right = 404.0
margin_bottom = 155.0
columns = 2

[node name="Number" type="Label" parent="Error/Panel/Content/Reason2"]
modulate = Color( 0.968627, 0, 1, 1 )
margin_right = 12.0
margin_bottom = 48.0
size_flags_vertical = 5
text = "2)"

[node name="Label" type="Label" parent="Error/Panel/Content/Reason2"]
margin_left = 16.0
margin_right = 404.0
margin_bottom = 48.0
size_flags_horizontal = 3
text = "You may be using the \"Flatpak\" Version of Pixelorama which does not have Internet Permission
Run it from terminal using command:"
autowrap = true

[node name="Empty" type="Control" parent="Error/Panel/Content/Reason2"]
margin_top = 52.0
margin_right = 12.0
margin_bottom = 76.0

[node name="HBoxContainer" type="HBoxContainer" parent="Error/Panel/Content/Reason2"]
margin_left = 16.0
margin_top = 52.0
margin_right = 404.0
margin_bottom = 76.0

[node name="LineEdit" type="LineEdit" parent="Error/Panel/Content/Reason2/HBoxContainer"]
margin_right = 341.0
margin_bottom = 24.0
size_flags_horizontal = 3
text = "sudo flatpak override com.orama_interactive.Pixelorama --share=network"
editable = false

[node name="CopyCommand" type="Button" parent="Error/Panel/Content/Reason2/HBoxContainer"]
margin_left = 345.0
margin_right = 388.0
margin_bottom = 24.0
text = "Copy"

[node name="Empty2" type="Control" parent="Error/Panel/Content/Reason2"]
margin_top = 80.0
margin_right = 12.0
margin_bottom = 111.0

[node name="Label2" type="Label" parent="Error/Panel/Content/Reason2"]
margin_left = 16.0
margin_top = 80.0
margin_right = 404.0
margin_bottom = 111.0
size_flags_horizontal = 3
text = "Or download \"Flatseal\" from your linux package manager and set permissions for Flatpak apps there"
autowrap = true

[node name="HSeparator2" type="HSeparator" parent="Error/Panel/Content"]
margin_top = 159.0
margin_right = 404.0
margin_bottom = 163.0

[node name="Reason3" type="GridContainer" parent="Error/Panel/Content"]
margin_top = 167.0
margin_right = 404.0
margin_bottom = 239.0
columns = 2

[node name="Number" type="Label" parent="Error/Panel/Content/Reason3"]
modulate = Color( 0.968627, 0, 1, 1 )
margin_right = 12.0
margin_bottom = 48.0
size_flags_vertical = 5
text = "3)"

[node name="Label" type="Label" parent="Error/Panel/Content/Reason3"]
modulate = Color( 0.376471, 1, 0.192157, 1 )
margin_left = 16.0
margin_right = 404.0
margin_bottom = 48.0
size_flags_horizontal = 3
text = "Re-download VariableStore manually from the Itch.io (It's possible an update might be available that requires Manual Download)..."
autowrap = true

[node name="Empty" type="Control" parent="Error/Panel/Content/Reason3"]
margin_top = 52.0
margin_right = 12.0
margin_bottom = 72.0

[node name="ManualDownload" type="Button" parent="Error/Panel/Content/Reason3"]
margin_left = 16.0
margin_top = 52.0
margin_right = 404.0
margin_bottom = 72.0
text = "Manual download from Itch.io Page"

[node name="ErrorCustom" type="AcceptDialog" parent="."]
margin_right = 345.0
margin_bottom = 118.0
window_title = "Error"
resizable = true

[node name="Content" type="VBoxContainer" parent="ErrorCustom"]
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = 8.0
margin_top = 8.0
margin_right = -8.0
margin_bottom = -36.0

[node name="Label" type="Label" parent="ErrorCustom/Content"]
modulate = Color( 1, 0, 0, 1 )
margin_right = 329.0
margin_bottom = 14.0
text = "Unable to Get info from remote repository..."
autowrap = true

[node name="FaultyLinks" type="Label" parent="ErrorCustom/Content"]
unique_name_in_owner = true
margin_top = 18.0
margin_right = 329.0
margin_bottom = 32.0
autowrap = true

[connection signal="about_to_show" from="." to="." method="_on_Store_about_to_show"]
[connection signal="text_changed" from="TabContainer/Store/Parameters/SearchManager" to="TabContainer/Store/Parameters/SearchManager" method="_on_SearchManager_text_changed"]
[connection signal="visibility_changed" from="TabContainer/Options" to="TabContainer/Options/ScrollContainer/CustomStoreLinks" method="_on_Options_visibility_changed"]
[connection signal="pressed" from="TabContainer/Options/ScrollContainer/CustomStoreLinks/Heading/Guide" to="TabContainer/Options/ScrollContainer/CustomStoreLinks" method="_on_Guide_pressed"]
[connection signal="pressed" from="TabContainer/Options/ScrollContainer/CustomStoreLinks/NewLink" to="TabContainer/Options/ScrollContainer/CustomStoreLinks" method="_on_NewLink_pressed"]
[connection signal="pressed" from="TabContainer/Speak Your Mind/VBoxContainer/SeeAddon" to="TabContainer/Speak Your Mind/VBoxContainer/Reporter" method="_on_SeeAddon_pressed"]
[connection signal="timeout" from="ProgressPanel/UpdateTimer" to="." method="_on_UpdateTimer_timeout"]
[connection signal="request_completed" from="StoreInformationDownloader" to="." method="_on_StoreInformation_request_completed"]
[connection signal="pressed" from="Error/Panel/Content/Reason2/HBoxContainer/CopyCommand" to="." method="_on_CopyCommand_pressed"]
[connection signal="pressed" from="Error/Panel/Content/Reason3/ManualDownload" to="." method="_on_ManualDownload_pressed"]
               [gd_scene load_steps=2 format=2]

[ext_resource path="res://src/Extensions/VariableStore/Store/Store.tscn" type="PackedScene" id=1]

[node name="StoreButton" type="Button"]
margin_right = 12.0
margin_bottom = 20.0
text = "Variable Store"

[node name="Store" parent="." instance=ExtResource( 1 )]

[connection signal="pressed" from="." to="Store" method="_on_StoreButton_pressed"]
    GDSC          0   	     ������������Ķ��   �����ڶ�   ���Ӷ���   �����������Ŷ���   �����϶�   ���������������ڶ���   �����������Ӷ���   ��������Ӷ��   ���ݶ���   ��������Ҷ��   �����������Ŷ���   ����Ķ��   ����Ҷ��   ����Ŷ��   �����������ض���   ���¶���   �����Ҷ�   ��������Ӷ��   ������������������Ҷ   ���������Ҷ�   �������¶���   ����   ���������������¶���   ��������Ҷ��   ������¶   �����������������Ҷ�   ����¶��    �����������������������������Ҷ�   ���������Ӷ�   ����������������Ҷ��   �嶶   ���������ض�      /root/Global      VariableStore         custom_links          A   Leave it empty and it will automatically remove itself on restart         text_changed      field_text_changed     f   https://github.com/Variable-Interactive/Variable-Store/tree/master#rules-for-writing-a-store_info-file                                                   !   	   %   
   5      ;      @      A      B      J      P      [      c      l      p      }      ~            �      �      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .      /     0   3YY;�  V�  Y;�  V�  LMYYY0�  PQX=V�  �  �  PQ�  &�  V�  �  �  T�  T�  P�  R�  RLMQ�  )�  �  V�  �	  P�  QYYY0�
  PQX=V�  �  T�  PQ�  )�  W�  T�  PQV�  &�  T�  �  V�  �  T�  P�  T�  Q�  &�  V�  �  T�  T�  P�  R�  R�  QYYY0�  PQX=V�  �	  PQYYY0�	  P�  V�  �  QX=V�  ;�  �  T�  PQ�  �  T�  �  �  �  T�  �  �  W�  T�  P�  Q�  �  T�  P�  RR�  QYYY0�  P�  V�  QX=V�  �
  PQYYY0�  PQX=V�  )�  W�  T�  PQV�  &�  T�  �  V�  �  T�  PQYYY0�  PQX=V�  �  T�  P�  QY`              GDSC          2         �������¶���   �������¶���   ������������Ķ��   �������������Ŷ�    �����������������������������Ҷ�   �������¶���   ��������������޶   �����¶�   ����������޶   ���¶���   ���Ŷ���   ��Ѷ   �����������ض���   ������Ҷ   �����Ҷ�   ����϶��   ���������޶�   ������Ӷ   ���������϶�   �������������Ӷ�   �������Ӷ���   ��������������������ض��   ��������������ض   �����������Ŷ���   ��������϶��   �����������ζ���   �������ζ���   ����   ��������Ҷ��   ������¶   ���������������޶���   �������Ҷ���      %TagList             %Content                   toggled       start_tag_search                                            $      %   	   &   
   .      6      <      F      L      U      V      \      f      l      m      n      y            �      �      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,     -     .     /     0     1     2   3YY5;�  V�  WY;�  V�  PQYY0�  P�  V�  QX=V�  �  PQYYY0�  PQX=V�  ;�  �  P�	  Q�  ;�
  LM�  )�  �  T�  PQV�  &�  T�  V�  �
  T�  P�  T�	  QY�  )�  �  V�  &�  T�  P�
  QV�  �  T�  �  YYY0�  P�	  V�  QX�  V�  ;�  LM�  )�  W�  T�  PQV�  ;�  �  �  &�	  �  V�  ;�  �  T�  T�	  �  ;�  �  T�  T�	  �  &�	  �  V�  &�	  �  V�  �  �  �  &�  �  V�  �  T�  P�  Q�  �  T�  �  �  .�  YYY0�  P�  V�  QV�  )�  �  V�  &�  �  V�  �  T�  P�  Q�  ;�  �  T�  PQ�  �  T�	  �  �  �  T�  P�  Q�  �  T�  P�  RR�  QYYY0�  P�  QX=V�  �  PQY`     {
    "name": "VariableStore",
    "display_name": "Extension store by Variable-ind",
    "description": "Store for Downloading extensions",
    "author": "Variable",
    "version": "0.6",
    "license": "MIT",
    "nodes": [
        "Main.tscn"
    ]
}
  [remap]

path="res://addons/BugReporter/reporter.gdc"
          [remap]

path="res://src/Extensions/VariableStore/Main.gdc"
    [remap]

path="res://src/Extensions/VariableStore/Store/Entry/Entry.gdc"
       [remap]

path="res://src/Extensions/VariableStore/Store/Store.gdc"
             [remap]

path="res://src/Extensions/VariableStore/Store/Sub Scripts/CustomStoreLinks.gdc"
      [remap]

path="res://src/Extensions/VariableStore/Store/Sub Scripts/SearchManager.gdc"
         ECFG      application/config/name         VariableStore      application/run/main_sceneD      9   res://src/Extensions/VariableStore/Store/StoreButton.tscn   )   physics/common/enable_pause_aware_picking         $   rendering/quality/driver/driver_name         GLES2   %   rendering/vram_compression/import_etc         &   rendering/vram_compression/import_etc2                     