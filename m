From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 5/5] vnc: Send / receive guest clipboard if virtio-console
	connected to clipboard port
Date: Wed,  9 Sep 2009 13:42:05 +0530
Message-ID: <1252483925-26336-7-git-send-email-amit.shah__16524.7727804401$1252484082$gmane$org@redhat.com>
References: <1252483925-26336-1-git-send-email-amit.shah@redhat.com>
	<1252483925-26336-2-git-send-email-amit.shah@redhat.com>
	<1252483925-26336-3-git-send-email-amit.shah@redhat.com>
	<1252483925-26336-4-git-send-email-amit.shah@redhat.com>
	<1252483925-26336-5-git-send-email-amit.shah@redhat.com>
	<1252483925-26336-6-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1252483925-26336-6-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

If a connection to the guest clipboard is open, send the host
clipboard to the guest and guest clipboard to the host on any
change

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 hw/virtio-console.h |    1 +
 vnc.c               |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/hw/virtio-console.h b/hw/virtio-console.h
index 62d0c4b..bd4c5cb 100644
--- a/hw/virtio-console.h
+++ b/hw/virtio-console.h
@@ -28,6 +28,7 @@
 /* Port number to function mapping */
 #define VIRTIO_CONSOLE_CONSOLE_PORT	0
 #define VIRTIO_CONSOLE_CONSOLE2_PORT	1
+#define VIRTIO_CONSOLE_CLIPBOARD_PORT	3
 
 /* Features supported */
 #define VIRTIO_CONSOLE_F_MULTIPORT	1
diff --git a/vnc.c b/vnc.c
index ff2d4a8..19a4cca 100644
--- a/vnc.c
+++ b/vnc.c
@@ -29,6 +29,7 @@
 #include "qemu_socket.h"
 #include "qemu-timer.h"
 #include "acl.h"
+#include "hw/virtio-console.h"
 
 #define VNC_REFRESH_INTERVAL_BASE 30
 #define VNC_REFRESH_INTERVAL_INC  50
@@ -47,6 +48,7 @@
 
 static VncDisplay *vnc_display; /* needed for info vnc */
 static DisplayChangeListener *dcl;
+static VirtIOConsolePort *virtcon_port;
 
 static char *addr_to_string(const char *format,
                             struct sockaddr_storage *sa,
@@ -671,6 +673,32 @@ static void vnc_copy(VncState *vs, int src_x, int src_y, int dst_x, int dst_y, i
     vnc_flush(vs);
 }
 
+static size_t vnc_clipboard_data_from_guest(const uint8_t *buf, size_t len)
+{
+    VncState *vs;
+    VncDisplay *vd;
+    DisplayState *ds;
+
+    if (!is_vnc_active())
+        return 0;
+
+    ds = vnc_display->ds;
+    vd = ds->opaque;
+
+    for (vs = vd->clients; vs; vs = vs->next) {
+        vnc_write_u8(vs, 3);  /* ServerCutText */
+        vnc_write_u8(vs, 0);  /* Padding */
+        vnc_write_u8(vs, 0);  /* Padding */
+        vnc_write_u8(vs, 0);  /* Padding */
+        vnc_write_u32(vs, len);
+        while (len--) {
+            vnc_write_u8(vs, *(buf++));
+        }
+        vnc_flush(vs);
+    }
+    return len;
+}
+
 static void vnc_dpy_copy(DisplayState *ds, int src_x, int src_y, int dst_x, int dst_y, int w, int h)
 {
     VncDisplay *vd = ds->opaque;
@@ -1240,6 +1268,7 @@ uint32_t read_u32(uint8_t *data, size_t offset)
 
 static void client_cut_text(VncState *vs, size_t len, uint8_t *text)
 {
+    virtio_console_write(virtcon_port, text, len);
 }
 
 static void check_pointer_type_change(VncState *vs, int absolute)
@@ -2265,6 +2294,7 @@ void vnc_display_close(DisplayState *ds)
     vs->subauth = VNC_AUTH_INVALID;
     vs->tls.x509verify = 0;
 #endif
+    virtio_console_close(virtcon_port);
 }
 
 int vnc_display_password(DisplayState *ds, const char *password)
@@ -2514,5 +2544,8 @@ int vnc_display_open(DisplayState *ds, const char *display)
             vs->display = dpy;
         }
     }
+
+    virtcon_port = virtio_console_open(VIRTIO_CONSOLE_CLIPBOARD_PORT,
+                                       vnc_clipboard_data_from_guest);
     return qemu_set_fd_handler2(vs->lsock, NULL, vnc_listen_read, NULL, vs);
 }
-- 
1.6.2.5
