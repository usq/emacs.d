
(defun os-mvg-mobile ()
  (interactive)
  (let ((from (completing-read "from: " (os-y-stations)))
        (to (completing-read "to: " (os-y-stations))))

    (browse-url (concat  "http://efa.mvv-muenchen.de/mvv/XSLT_TRIP_REQUEST2?"

                         "target_url=%2Fde%2Ffahrplanauskunft%2Findex.html"
                         "&sessionID=0&language=de"
                         "&ptOptionsActive=0"
                         "&execInst=normal"
                         "&anyObjFilter_origin=0&anySigWhenPerfectNoOtherMatches=1&stateless=1&placeState_origin=empty&type_origin=any"
                         "&nameInfo_origin=invalid&placeInfo_origin=invalid&typeInfo_origin=invalid"
                         "&nameState_origin=empty&useHouseNumberList_origin=1"
                         "&itdLPxx_odv_origin=&nameX_origin=&nameY_origin=&mapName_origin=&nameInfo_destination=invalid&placeInfo_destination=invalid"
                         "&typeInfo_destination=invalid"
                         "&nameState_destination=empty&useHouseNumberList_destination=1"
                         "&itdLPxx_odv_destination=&nameX_destination=&nameY_destination=&mapName_destination=&placeState_destination=empty"
                         "&type_destination=any&anyObjFilter_destination=0&requestID=0&command=&itdLPxx_help="
                         "&itOptionsActive=&hiddendate=&locationServerActive=1&Session=0&SpEncId=0&imageFormat=png%7Cpdf&imageHeight=575&imageOnly=1&imageWidth=575"
                         "&name_origin="
                         from
                         "&name_destination="
                         to))))


(defun os-y-stations ()
  '("Garching (b München), Garching, Forschungszentrum [Haltestelle]" "Moosach" "Goetheplatz" "Goethe-Institut [Haltestelle]"))



(defun os-campus ()
  (interactive)
  (browse-url "https://campus.tum.de/tumonline/webnav.ini?pUrl=wbanmeldung.durchfuehren%3Fctxid%3Dcheck%26cusergroup%3D%26cinframe%3D%26pLogonMask%3D%26curl%3D"))


(provide 'online-services)

