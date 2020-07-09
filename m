From: "Alexander A. Klimov" <grandmaster-ecYmzcxolEDucvZx32VAuQ@public.gmane.org>
Subject: [PATCH] VIRTIO CORE AND NET DRIVERS: Replace HTTP links with HTTPS ones
Date: Thu,  9 Jul 2020 08:47:55 +0200
Message-ID: <20200709064755.24051-1-grandmaster@al2klimov.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Alexander A. Klimov" <grandmaster-ecYmzcxolEDucvZx32VAuQ@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster-ecYmzcxolEDucvZx32VAuQ@public.gmane.org>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster-ecYmzcxolEDucvZx32VAuQ@public.gmane.org>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 Documentation/devicetree/bindings/virtio/mmio.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/virtio/mmio.txt b/Documentation/devicetree/bindings/virtio/mmio.txt
index 21af30fbb81f..0a575f329f6e 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.txt
+++ b/Documentation/devicetree/bindings/virtio/mmio.txt
@@ -1,6 +1,6 @@
 * virtio memory mapped device
 
-See http://ozlabs.org/~rusty/virtio-spec/ for more details.
+See https://ozlabs.org/~rusty/virtio-spec/ for more details.
 
 Required properties:
 
-- 
2.27.0
