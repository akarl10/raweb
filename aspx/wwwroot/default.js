function loadWebFeed(url, dst) {
    let req = new XMLHttpRequest();
    req.x_dst = dst;
    req.open("GET",url);
    req.overrideMimeType("text/xml");
    req.onreadystatechange=function() {
        if(this.readyState == XMLHttpRequest.DONE) {
            let parser = new DOMParser();
            let xmlDoc = parser.parseFromString(this.responseText, "text/xml");
            window.currentWorkspace = xmlDoc;
            if(xmlDoc && xmlDoc.activeElement) {
                let resources = xmlDoc.activeElement.getElementsByTagName("Resource");
                for(let i=0;i<resources.length;i++) {
                    let conn = document.createElement("div");
                    conn.id="apptile";
                    let link = document.createElement("a");
                    let img = document.createElement("img");
                    if(resources[i].getElementsByTagName("Icon32").length>0) {
                        img.src=resources[i].getElementsByTagName("Icon32")[0].getAttribute("FileURL");
                    }
                    else img.src="rdpicon.png";
                    img.setAttribute("width","64");
                    img.setAttribute("height","64");
                    link.href=resources[i].getElementsByTagName("ResourceFile")[0].getAttribute("URL");
                    let nl = document.createElement("br");
                    let text = document.createTextNode(resources[i].getAttribute("Title"));
                    link.appendChild(img);
                    link.appendChild(nl);
                    link.appendChild(text);
                    conn.appendChild(link);
                    this.x_dst.appendChild(conn);
                }
            }
        }
    }
    req.send();
}

