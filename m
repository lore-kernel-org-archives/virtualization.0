From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 3/5] virtio-console: in-qemu api for open/read/write/close
	ports
Date: Wed,  9 Sep 2009 13:42:03 +0530
Message-ID: <1252483925-26336-5-git-send-email-amit.shah__25502.4923397743$1252484074$gmane$org@redhat.com>
References: <1252483925-26336-1-git-send-email-amit.shah@redhat.com>
	<1252483925-26336-2-git-send-email-amit.shah@redhat.com>
	<1252483925-26336-3-git-send-email-amit.shah@redhat.com>
	<1252483925-26336-4-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1252483925-26336-4-git-send-email-amit.shah@redhat.com>
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

This is a simple-to-use api for opening a port, registering
a callback for reading stuff, writing to a port and closing
it.

Another api for hot-adding a port can be provided.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 hw/virtio-console.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/virtio-console.h |    5 ++++
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/hw/virtio-console.c b/hw/virtio-console.c
index 135fdbb..9e78a9e 100644
--- a/hw/virtio-console.c
+++ b/hw/virtio-console.c
@@ -52,6 +52,11 @@ struct VirtIOConsolePort {
 
     TAILQ_HEAD(, VirtIOConsolePortBuffer) unflushed_buffer_head;
 
+    /* Callback that's invoked when we have a buffer that can be consumed
+     * by an in-qemu user of this port
+     */
+    size_t (*read_callback)(const uint8_t *buf, const size_t len);
+
     bool guest_connected;
     bool host_connected;
 };
@@ -150,10 +155,15 @@ static bool has_complete_data(VirtIOConsolePort *port)
 
 static size_t flush_buf(VirtIOConsolePort *port, const uint8_t *buf, size_t len)
 {
-    if (!port->hd) {
-        return 0;
+    int ret;
+
+    ret = 0;
+    if (port->read_callback) {
+        ret = port->read_callback(buf, len);
+    } else if (port->hd) {
+        ret = qemu_chr_write(port->hd, buf, len);
     }
-    return qemu_chr_write(port->hd, buf, len);
+    return ret;
 }
 
 static void flush_queue(VirtIOConsolePort *port)
@@ -431,6 +441,51 @@ static void vcon_event(void *opaque, int event)
     send_control_event(port, &cpkt);
 }
 
+/* Functions for use inside qemu to open and read from/write to ports */
+VirtIOConsolePort *virtio_console_open(uint32_t id,
+                                       size_t(*read_callback)(const uint8_t*buf,
+                                                              const size_t len))
+{
+    VirtIOConsolePort *port = get_port_from_id(id);
+    struct virtio_console_control cpkt;
+
+    if (port == NULL) {
+        return NULL;
+    }
+    /* Don't allow opening an already-open port */
+    if (port->host_connected) {
+        return NULL;
+    }
+    /* Send port open notification to the guest */
+    port->host_connected = true;
+    port->read_callback = read_callback;
+    cpkt.event = VIRTIO_CONSOLE_PORT_OPEN;
+    cpkt.value = 1;
+    send_control_event(port, &cpkt);
+    return port;
+}
+
+void virtio_console_close(VirtIOConsolePort *port)
+{
+    struct virtio_console_control cpkt;
+
+    if (!port)
+        return;
+
+    port->read_callback = NULL;
+
+    cpkt.event = VIRTIO_CONSOLE_PORT_OPEN;
+    cpkt.value = 0;
+    send_control_event(port, &cpkt);
+}
+
+size_t virtio_console_write(VirtIOConsolePort *port, uint8_t *buf, size_t size)
+{
+    if (!port || !port->host_connected) {
+        return 0;
+    }
+    return write_to_port(port, buf, size, false);
+}
 static void virtio_console_set_port_active(uint32_t idx)
 {
     int i;
diff --git a/hw/virtio-console.h b/hw/virtio-console.h
index 56448a9..62d0c4b 100644
--- a/hw/virtio-console.h
+++ b/hw/virtio-console.h
@@ -68,5 +68,10 @@ struct virtio_console_header {
 typedef struct VirtIOConsolePort VirtIOConsolePort;
 void virtio_console_monitor_command(Monitor *mon,
                                     const char *command, const char *param);
+VirtIOConsolePort *virtio_console_open(uint32_t id,
+                                       size_t(*read_callback)(const uint8_t*buf,
+                                                              const size_t len));
+void virtio_console_close(VirtIOConsolePort *port);
+size_t virtio_console_write(VirtIOConsolePort *port, uint8_t *buf, size_t size);
 
 #endif
-- 
1.6.2.5
