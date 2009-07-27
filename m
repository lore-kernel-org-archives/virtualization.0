From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 3/3] virtio-serial: vnc: support for sending / receiving guest
	clipboard
Date: Mon, 27 Jul 2009 23:34:36 +0530
Message-ID: <1248717876-17630-5-git-send-email-amit.shah__15646.3839732625$1248718037$gmane$org@redhat.com>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<1248717876-17630-2-git-send-email-amit.shah@redhat.com>
	<1248717876-17630-3-git-send-email-amit.shah@redhat.com>
	<1248717876-17630-4-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1248717876-17630-4-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

- Send ServerCutText message over to the vnc client from qemu
  on every write to the clipboard port via virtio-serial

- On receiving ClientCutText message send over the data to the
  guest via virtio-serial.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 hw/virtio-serial.c |   15 +++++++++++++++
 hw/virtio-serial.h |    4 ++++
 vnc.c              |   24 ++++++++++++++++++++++++
 vnc.h              |    2 ++
 4 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/hw/virtio-serial.c b/hw/virtio-serial.c
index d77af9b..95c715f 100644
--- a/hw/virtio-serial.c
+++ b/hw/virtio-serial.c
@@ -20,6 +20,7 @@
 #include "pci.h"
 #include "monitor.h"
 #include "qemu-char.h"
+#include "vnc.h"
 #include "virtio.h"
 #include "virtio-serial.h"
 
@@ -118,6 +119,10 @@ static size_t flush_buf(uint32_t id, const uint8_t *buf, size_t len)
     VirtIOSerialPort *port;
     size_t write_len = 0;
 
+    if (id == VIRTIO_SERIAL_CLIPBOARD_PORT && is_vnc_active()) {
+        vnc_clipboard_data_from_guest(buf, len);
+        return len;
+    }
     port = get_port_from_id(id);
     if (port && port->hd) {
         write_len = qemu_chr_write(port->hd, buf, len);
@@ -211,6 +216,16 @@ static void write_to_port(VirtIOSerialPort *port,
     virtio_notify(port->virtserial->vdev, vq);
 }
 
+void virtio_serial_send_clipboard_to_guest(const uint8_t *buf, size_t len)
+{
+    VirtIOSerialPort *port = get_port_from_id(VIRTIO_SERIAL_CLIPBOARD_PORT);
+
+    if (!port) {
+        return;
+    }
+    write_to_port(port, buf, len);
+}
+
 /* Readiness of the guest to accept data on a port */
 static int cons_can_read(void *opaque)
 {
diff --git a/hw/virtio-serial.h b/hw/virtio-serial.h
index 08c4b51..44238f6 100644
--- a/hw/virtio-serial.h
+++ b/hw/virtio-serial.h
@@ -18,6 +18,9 @@
 #define VIRTIO_ID_SERIAL		7
 #define VIRTIO_SERIAL_BAD_ID		(~(uint32_t)0)
 
+/* Port number to function mapping */
+#define VIRTIO_SERIAL_CLIPBOARD_PORT	3
+
 struct virtio_serial_config
 {
     uint32_t max_nr_ports;
@@ -32,5 +35,6 @@ struct virtio_serial_config
 void *virtio_serial_new_port(PCIDevice *dev, int idx);
 void virtio_serial_monitor_command(Monitor *mon,
                                    const char *command, const char *param);
+void virtio_serial_send_clipboard_to_guest(const uint8_t *buf, size_t len);
 
 #endif
diff --git a/vnc.c b/vnc.c
index e4e78dc..271b64e 100644
--- a/vnc.c
+++ b/vnc.c
@@ -29,6 +29,7 @@
 #include "qemu_socket.h"
 #include "qemu-timer.h"
 #include "acl.h"
+#include "hw/virtio-serial.h"
 
 #define VNC_REFRESH_INTERVAL (1000 / 30)
 
@@ -671,6 +672,28 @@ static void vnc_copy(VncState *vs, int src_x, int src_y, int dst_x, int dst_y, i
     vnc_flush(vs);
 }
 
+void vnc_clipboard_data_from_guest(const uint8_t *buf, size_t len)
+{
+    VncState *vs;
+    VncDisplay *vd;
+    DisplayState *ds;
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
+}
+
 static void vnc_dpy_copy(DisplayState *ds, int src_x, int src_y, int dst_x, int dst_y, int w, int h)
 {
     VncDisplay *vd = ds->opaque;
@@ -1239,6 +1262,7 @@ uint32_t read_u32(uint8_t *data, size_t offset)
 
 static void client_cut_text(VncState *vs, size_t len, uint8_t *text)
 {
+    virtio_serial_send_clipboard_to_guest(text, len);
 }
 
 static void check_pointer_type_change(VncState *vs, int absolute)
diff --git a/vnc.h b/vnc.h
index 9739c35..00afdbb 100644
--- a/vnc.h
+++ b/vnc.h
@@ -303,6 +303,8 @@ int vnc_client_io_error(VncState *vs, int ret, int last_errno);
 void start_client_init(VncState *vs);
 void start_auth_vnc(VncState *vs);
 
+void vnc_clipboard_data_from_guest(const uint8_t *buf, size_t len);
+
 /* Buffer management */
 void buffer_reserve(Buffer *buffer, size_t len);
 int buffer_empty(Buffer *buffer);
-- 
1.6.2.5
