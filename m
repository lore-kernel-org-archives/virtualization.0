From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 3/3] virtio-console: Add interface for generic guest-host
	communication
Date: Tue, 25 Aug 2009 13:46:41 +0530
Message-ID: <1251188201-6157-1-git-send-email-amit.shah__30269.5727711127$1251188363$gmane$org@redhat.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
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

This interface extends the virtio-console device to handle
multiple ports that present a char device from which bits can
be sent and read.

Sample uses for such a device can be obtaining info from the
guest like the file systems used, apps installed, etc. for
offline usage and logged-in users, clipboard copy-paste, etc.
for online usage.

Each port is to be assigned a unique function, for example, the
first 4 ports may be reserved for libvirt usage, the next 4 for
generic streaming data and so on. This port-function mapping
isn't finalised yet.

For requirements, use-cases and some history see

    http://www.linux-kvm.org/page/VMchannel_Requirements

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 hw/pc.c             |   16 ++-
 hw/virtio-console.c |  423 +++++++++++++++++++++++++++++++++++++++++++++------
 hw/virtio-console.h |   47 ++++++
 monitor.c           |    7 +
 qemu-monitor.hx     |   10 ++
 qemu-options.hx     |    2 +-
 sysemu.h            |   10 +-
 vl.c                |   41 +++---
 8 files changed, 479 insertions(+), 77 deletions(-)

diff --git a/hw/pc.c b/hw/pc.c
index ca681b8..96eb7ac 100644
--- a/hw/pc.c
+++ b/hw/pc.c
@@ -1453,11 +1453,17 @@ static void pc_init1(ram_addr_t ram_size,
     }
 
     /* Add virtio console devices */
-    if (pci_enabled) {
-        for(i = 0; i < MAX_VIRTIO_CONSOLES; i++) {
-            if (virtcon_hds[i]) {
-                pci_create_simple(pci_bus, -1, "virtio-console-pci");
-            }
+    if (pci_enabled && virtcon_nr_ports) {
+        void *dev;
+
+        dev = pci_create_simple(pci_bus, -1, "virtio-console-pci");
+        if (!dev) {
+            fprintf(stderr, "qemu: could not create virtio console pci device\n");
+            exit(1);
+        }
+
+        for (i = 0; i < virtcon_nr_ports; i++) {
+                virtio_console_new_port(dev, virtcon_idx[i]);
         }
     }
 
diff --git a/hw/virtio-console.c b/hw/virtio-console.c
index 92c953c..f8f9866 100644
--- a/hw/virtio-console.c
+++ b/hw/virtio-console.c
@@ -2,9 +2,11 @@
  * Virtio Console Device
  *
  * Copyright IBM, Corp. 2008
+ * Copyright Red Hat, Inc. 2009
  *
  * Authors:
  *  Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
+ *  Amit Shah <amit.shah@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
@@ -12,39 +14,158 @@
  */
 
 #include "hw.h"
+#include "pci.h"
+#include "monitor.h"
 #include "qemu-char.h"
 #include "virtio.h"
 #include "virtio-console.h"
 
-
 typedef struct VirtIOConsole
 {
     VirtIODevice vdev;
+    PCIDevice *dev;
     VirtQueue *ivq, *ovq;
-    CharDriverState *chr;
+    struct VirtIOConsolePort *ports;
+    struct virtio_console_config *config;
+    uint32_t guest_features;
 } VirtIOConsole;
 
-static VirtIOConsole *to_virtio_console(VirtIODevice *vdev)
+typedef struct VirtIOConsolePort {
+    VirtIOConsole *vcon;
+    CharDriverState *hd;
+    bool guest_connected;
+} VirtIOConsolePort;
+
+static VirtIOConsole *virtio_console;
+static struct virtio_console_config virtcon_config;
+
+static VirtIOConsolePort *get_port_from_id(uint32_t id)
+{
+    if (id > MAX_VIRTIO_CONSOLE_PORTS)
+        return NULL;
+
+    return &virtio_console->ports[id];
+}
+
+static int get_id_from_port(VirtIOConsolePort *port)
 {
-    return (VirtIOConsole *)vdev;
+    uint32_t i;
+
+    for (i = 0; i < MAX_VIRTIO_CONSOLE_PORTS; i++) {
+        if (port == &virtio_console->ports[i]) {
+            return i;
+        }
+    }
+    return VIRTIO_CONSOLE_BAD_ID;
+}
+
+static bool use_multiport(void)
+{
+    return virtio_console->guest_features & (1 << VIRTIO_CONSOLE_F_MULTIPORT);
+}
+
+void virtio_console_monitor_command(Monitor *mon,
+                                    const char *command, const char *param)
+{
+    int ret;
+
+    if(!strncmp(command, "add_port", 8)) {
+        if (!param) {
+            monitor_printf(mon, "Error: need port id to add new port\n");
+            return;
+        }
+        ret = init_virtio_console_port(virtcon_nr_ports, param);
+        if (ret < 0) {
+            monitor_printf(mon, "Error: cannot add new port: %s\n",
+                           strerror(-ret));
+            return;
+        }
+        virtio_console_new_port(NULL, virtcon_idx[virtcon_nr_ports]);
+        virtcon_nr_ports++;
+        virtio_console->config->nr_active_ports = cpu_to_le32(virtcon_nr_ports);
+        return;
+    }
+}
+
+static size_t flush_buf(uint32_t id, VirtIOConsolePort *port,
+                        const uint8_t *buf, size_t len)
+{
+    size_t write_len = 0;
+
+    if (port->hd) {
+        write_len = qemu_chr_write(port->hd, buf, len);
+        return write_len;
+    }
+    return 0;
+}
+
+/* Guest wants to notify us of some event */
+static void handle_control_message(VirtIOConsolePort *port,
+                                   struct virtio_console_control *cpkt)
+{
+    switch(cpkt->event) {
+    case VIRTIO_CONSOLE_PORT_OPEN:
+        port->guest_connected = cpkt->value;
+        break;
+    }
 }
 
+/* Guest wrote something to some port.
+ *
+ * Flush the data in the entire chunk that we received rather than
+ * splitting it into multiple buffers. VNC clients don't consume split
+ * buffers
+ */
 static void virtio_console_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
-    VirtIOConsole *s = to_virtio_console(vdev);
     VirtQueueElement elem;
 
     while (virtqueue_pop(vq, &elem)) {
-        ssize_t len = 0;
-        int d;
+        VirtIOConsolePort *port;
+        uint8_t *buf;
+        size_t totlen, buf_offset;
+        struct virtio_console_header header;
+        int header_len, i;
+
+        if (use_multiport()) {
+            header_len = sizeof(header);
+
+            memcpy(&header, elem.out_sg[0].iov_base, header_len);
+            port = get_port_from_id(header.id);
+            if (!port) {
+                continue;
+            }
+        } else {
+            header_len = 0;
+            port = get_port_from_id(0);
+        }
+        totlen = 0;
+        for (i = 0; i < elem.out_num; i++) {
+            totlen += elem.out_sg[i].iov_len;
+        }
+        buf = qemu_mallocz(totlen - header_len);
+        buf_offset = 0;
+        for (i = 0; i < elem.out_num; i++) {
+            size_t out_len = elem.out_sg[i].iov_len - header_len;
+
+            memcpy(buf + buf_offset, elem.out_sg[i].iov_base + header_len,
+                   out_len);
+
+            buf_offset += out_len;
+            /* header is only sent with the first packet in each sg */
+            header_len = 0;
+        }
+        header_len = use_multiport() ? sizeof(header) : 0;
 
-        for (d = 0; d < elem.out_num; d++) {
-            len += qemu_chr_write(s->chr, (uint8_t *)elem.out_sg[d].iov_base,
-                                  elem.out_sg[d].iov_len);
+        if (use_multiport() && header.internal_message) {
+            handle_control_message(port, (struct virtio_console_control *)buf);
+        } else {
+            flush_buf(header.id, port, buf, totlen - header_len);
         }
-        virtqueue_push(vq, &elem, len);
-        virtio_notify(vdev, vq);
+        virtqueue_push(vq, &elem, totlen);
+        qemu_free(buf);
     }
+    virtio_notify(vdev, vq);
 }
 
 static void virtio_console_handle_input(VirtIODevice *vdev, VirtQueue *vq)
@@ -53,56 +174,251 @@ static void virtio_console_handle_input(VirtIODevice *vdev, VirtQueue *vq)
 
 static uint32_t virtio_console_get_features(VirtIODevice *vdev)
 {
-    return 0;
+    return 1 << VIRTIO_CONSOLE_F_MULTIPORT;
 }
 
-static int vcon_can_read(void *opaque)
+static void virtio_console_set_features(VirtIODevice *vdev, uint32_t features)
 {
-    VirtIOConsole *s = (VirtIOConsole *) opaque;
+    virtio_console->guest_features = features;
+}
 
-    if (!virtio_queue_ready(s->ivq) ||
-        !(s->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK) ||
-        virtio_queue_empty(s->ivq))
-        return 0;
+/* Guest requested config info */
+static void virtio_console_get_config(VirtIODevice *vdev, uint8_t *config_data)
+{
+    memcpy(config_data, &virtcon_config, sizeof(struct virtio_console_config));
+}
 
-    /* current implementations have a page sized buffer.
-     * We fall back to a one byte per read if there is not enough room.
-     * It would be cool to have a function that returns the available byte
-     * instead of checking for a limit */
-    if (virtqueue_avail_bytes(s->ivq, TARGET_PAGE_SIZE, 0))
-        return TARGET_PAGE_SIZE;
-    if (virtqueue_avail_bytes(s->ivq, 1, 0))
-        return 1;
-    return 0;
+static void virtio_console_set_config(VirtIODevice *vdev,
+                                      const uint8_t *config_data)
+{
+    struct virtio_console_config config;
+
+    memcpy(&config, config_data, sizeof(config));
 }
 
-static void vcon_read(void *opaque, const uint8_t *buf, int size)
+static void write_to_port(VirtIOConsolePort *port,
+			  const uint8_t *buf, size_t size, bool internal)
 {
-    VirtIOConsole *s = (VirtIOConsole *) opaque;
+    VirtQueue *vq = port->vcon->ivq;
     VirtQueueElement elem;
-    int offset = 0;
+    size_t offset = 0;
+    size_t len = 0;
+
+    if (!virtio_queue_ready(vq)) {
+        return;
+    }
+
+    if (!use_multiport() && internal) {
+        return;
+    }
 
-    /* The current kernel implementation has only one outstanding input
-     * buffer of PAGE_SIZE. Nevertheless, this function is prepared to
-     * handle multiple buffers with multiple sg element for input */
     while (offset < size) {
-        int i = 0;
-        if (!virtqueue_pop(s->ivq, &elem))
-                break;
-        while (offset < size && i < elem.in_num) {
-            int len = MIN(elem.in_sg[i].iov_len, size - offset);
-            memcpy(elem.in_sg[i].iov_base, buf + offset, len);
+        struct virtio_console_header header;
+        int i, header_len;
+
+        header_len = use_multiport() ? sizeof(header) : 0;
+
+        if (!virtqueue_pop(vq, &elem)) {
+            break;
+        }
+        if (elem.in_sg[0].iov_len < header_len) {
+            /* We can't even store our port number in this buffer. Bug? */
+            fprintf(stderr, "virtio-console: size %zd less than expected\n",
+                    elem.in_sg[0].iov_len);
+            exit(1);
+        }
+        header.id = cpu_to_le32(get_id_from_port(port));
+        header.internal_message = internal;
+        memcpy(elem.in_sg[0].iov_base, &header, header_len);
+
+        for (i = 0; offset < size && i < elem.in_num; i++) {
+            len = MIN(elem.in_sg[i].iov_len - header_len, size - offset);
+
+            memcpy(elem.in_sg[i].iov_base + header_len, buf + offset, len);
             offset += len;
-            i++;
+            header_len = 0;
         }
-        virtqueue_push(s->ivq, &elem, size);
+        header_len = use_multiport() ? sizeof(header) : 0;
+        virtqueue_push(vq, &elem, len + header_len);
+    }
+    virtio_notify(&port->vcon->vdev, vq);
+}
+
+static void send_control_event(VirtIOConsolePort *port,
+                               struct virtio_console_control *cpkt)
+{
+    write_to_port(port, (uint8_t *)cpkt, sizeof(*cpkt), true);
+}
+
+/* Readiness of the guest to accept data on a port */
+static int vcon_can_read(void *opaque)
+{
+    VirtIOConsolePort *port = (VirtIOConsolePort *) opaque;
+    VirtQueue *vq = port->vcon->ivq;
+    int size, header_len;
+
+    if (use_multiport()) {
+        header_len = sizeof(struct virtio_console_header);
+    } else {
+        header_len = 0;
+    }
+
+    if (!virtio_queue_ready(vq) ||
+        !(port->vcon->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK) ||
+        virtio_queue_empty(vq)) {
+        return 0;
+    }
+    if (!port->guest_connected) {
+        return 0;
     }
-    virtio_notify(&s->vdev, s->ivq);
+    size = TARGET_PAGE_SIZE;
+    if (virtqueue_avail_bytes(vq, size, 0)) {
+        return size - header_len;
+    }
+    size = header_len + 1;
+    if (virtqueue_avail_bytes(vq, size, 0)) {
+        return size - header_len;
+    }
+    return 0;
+}
+
+/* Send data from a char device over to the guest */
+static void vcon_read(void *opaque, const uint8_t *buf, int size)
+{
+    VirtIOConsolePort *port = (VirtIOConsolePort *) opaque;
+
+    write_to_port(port, buf, size, false);
 }
 
 static void vcon_event(void *opaque, int event)
 {
-    /* we will ignore any event for the time being */
+    VirtIOConsolePort *port = (VirtIOConsolePort *) opaque;
+    struct virtio_console_control cpkt;
+    bool update_needed;
+
+    cpkt.event = VIRTIO_CONSOLE_PORT_OPEN;
+
+    update_needed = false;
+    switch (event) {
+    case CHR_EVENT_RESET:
+        cpkt.value = 1;
+        update_needed = true;
+        break;
+    case CHR_EVENT_CLOSED:
+        cpkt.value = 0;
+        update_needed = true;
+        break;
+    default:
+        break;
+    }
+
+    if (!update_needed) {
+        return;
+    }
+    send_control_event(port, &cpkt);
+}
+
+static void virtio_console_set_port_active(uint32_t idx)
+{
+    int i = 0;
+
+    while (idx / 32) {
+        i++;
+        idx -= 32;
+    }
+    virtcon_config.ports_map[i] |= 1U << idx;
+}
+
+static bool virtio_console_is_port_active(uint32_t idx)
+{
+    int i = 0;
+
+    while (idx / 32) {
+        i++;
+        idx -= 32;
+    }
+    return virtcon_config.ports_map[i] & (1U << idx);
+}
+
+/* This function gets called from vl.c during initial options
+ * parsing as well as from the monitor to parse the options.
+ * So it's a good idea to not print out anything and just
+ * return values which can become meaningful.
+ */
+int init_virtio_console_port(int port, const char *opts)
+{
+    char dev[256];
+    const char *prot;
+    const char *idx;
+    uint32_t port_nr;
+    int j, k;
+
+    memset(dev, 0, sizeof(dev));
+    prot = strstr(opts, ",protocol=");
+    idx  = strstr(opts, ",port=");
+
+    port_nr = 0;
+    if (idx) {
+        port_nr = atol(idx + 6); /* skip ',port=' */
+    }
+    if (port_nr >= MAX_VIRTIO_CONSOLE_PORTS) {
+        return -ENOSPC;
+    }
+    if (virtio_console_is_port_active(port_nr)) {
+        return -EEXIST;
+    }
+
+    /* Just to maintain compatibility with other qemu options,
+     * we have the format of
+     *
+     * -virtioconsole unix:/tmp/foo,protocol=bar,port=3
+     *
+     * so to parse the 'unix:', we have to do the following
+     */
+    j = k = 0;
+    while (opts[j] && &opts[j] != prot && &opts[j] != idx) {
+        dev[k++] = opts[j++];
+    }
+
+    if (dev[0] && strncmp(dev, "none", 4)) {
+        char label[32];
+        snprintf(label, sizeof(label), "virtcon%u", port_nr);
+        virtcon_hds[port] = qemu_chr_open(label, dev, NULL);
+        if (!virtcon_hds[port]) {
+            return -EIO;
+        }
+    }
+    virtcon_idx[port] = port_nr;
+    virtio_console_set_port_active(port_nr);
+
+    return 0;
+}
+
+void *virtio_console_new_port(PCIDevice *dev, uint32_t idx)
+{
+    VirtIOConsolePort *port;
+
+    port = get_port_from_id(idx);
+    port->vcon = virtio_console;
+
+    if (!port->vcon->dev && !dev) {
+        return NULL;
+    }
+    if (!port->vcon->dev) {
+        port->vcon->dev = dev;
+    }
+    /* Hot-adding ports to existing device */
+    if (!dev) {
+        dev = port->vcon->dev;
+    }
+    port->hd = qdev_init_chardev(&dev->qdev);
+    if (port->hd) {
+        qemu_chr_add_handlers(port->hd, vcon_can_read, vcon_read, vcon_event,
+                              port);
+    }
+    /* Send an update to the guest about this new port added */
+    virtio_notify_config(&port->vcon->vdev);
+    return port;
 }
 
 static void virtio_console_save(QEMUFile *f, void *opaque)
@@ -128,19 +444,30 @@ VirtIODevice *virtio_console_init(DeviceState *dev)
     VirtIOConsole *s;
     s = (VirtIOConsole *)virtio_common_init("virtio-console",
                                             VIRTIO_ID_CONSOLE,
-                                            0, sizeof(VirtIOConsole));
+                                            sizeof(struct virtio_console_config),
+                                            sizeof(VirtIOConsole));
     if (s == NULL)
         return NULL;
 
+    virtio_console = s;
     s->vdev.get_features = virtio_console_get_features;
+    s->vdev.set_features = virtio_console_set_features;
+    s->vdev.get_config = virtio_console_get_config;
+    s->vdev.set_config = virtio_console_set_config;
 
+    /* Add queue for host to guest transfers */
     s->ivq = virtio_add_queue(&s->vdev, 128, virtio_console_handle_input);
+    /* Add queue for guest to host transfers */
     s->ovq = virtio_add_queue(&s->vdev, 128, virtio_console_handle_output);
 
-    s->chr = qdev_init_chardev(dev);
-    qemu_chr_add_handlers(s->chr, vcon_can_read, vcon_read, vcon_event, s);
+    /* Allocate space for the max. number of serial ports supported */
+    s->ports = qemu_mallocz(sizeof(VirtIOConsolePort) * MAX_VIRTIO_CONSOLE_PORTS);
+    s->config = &virtcon_config;
+
+    register_savevm("virtio-console", -1, 2, virtio_console_save, virtio_console_load, s);
 
-    register_savevm("virtio-console", -1, 1, virtio_console_save, virtio_console_load, s);
+    virtcon_config.max_nr_ports = cpu_to_le32(MAX_VIRTIO_CONSOLE_PORTS);
+    virtcon_config.nr_active_ports = cpu_to_le32(virtcon_nr_ports);
 
     return &s->vdev;
 }
diff --git a/hw/virtio-console.h b/hw/virtio-console.h
index 84d0717..1b418b3 100644
--- a/hw/virtio-console.h
+++ b/hw/virtio-console.h
@@ -2,9 +2,11 @@
  * Virtio Console Support
  *
  * Copyright IBM, Corp. 2008
+ * Copyright Red Hat, Inc. 2009
  *
  * Authors:
  *  Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
+ *  Amit Shah <amit.shah@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
@@ -13,7 +15,52 @@
 #ifndef _QEMU_VIRTIO_CONSOLE_H
 #define _QEMU_VIRTIO_CONSOLE_H
 
+#include "sysemu.h"
+
+/* Interface shared between the guest kernel and qemu */
+
 /* The ID for virtio console */
 #define VIRTIO_ID_CONSOLE 3
 
+/* Invalid port number */
+#define VIRTIO_CONSOLE_BAD_ID		(~(uint32_t)0)
+
+/* Port number at which the console is spawned */
+#define VIRTIO_CONSOLE_CONSOLE_PORT	0
+
+/* Features supported */
+#define VIRTIO_CONSOLE_F_MULTIPORT	1
+
+struct virtio_console_config
+{
+    /* These two fields are used by VIRTIO_CONSOLE_F_SIZE which
+     * isn't implemented here yet
+     */
+    uint16_t cols;
+    uint16_t rows;
+
+    uint32_t max_nr_ports;
+    uint32_t nr_active_ports;
+    uint32_t ports_map[(MAX_VIRTIO_CONSOLE_PORTS + 31) / 32];
+};
+
+struct virtio_console_control
+{
+    uint16_t event;
+    uint16_t value;
+};
+
+struct virtio_console_header {
+    uint32_t id; /* Port id */
+    bool     internal_message; /* Some message between host and guest */
+} __attribute__((packed));
+
+/* Some events for the control channel */
+#define VIRTIO_CONSOLE_PORT_OPEN	0
+
+
+/* In-qemu interface */
+void virtio_console_monitor_command(Monitor *mon,
+				    const char *command, const char *param);
+
 #endif
diff --git a/monitor.c b/monitor.c
index 50a3cd2..9679de7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -45,6 +45,7 @@
 #include "kvm.h"
 #include "acl.h"
 #include "exec-all.h"
+#include "hw/virtio-console.h"
 
 #include "qemu-kvm.h"
 
@@ -1824,6 +1825,12 @@ int monitor_get_fd(Monitor *mon, const char *fdname)
     return -1;
 }
 
+static void do_virtio_console_action(Monitor *mon,
+                                     const char *command, const char *param)
+{
+    virtio_console_monitor_command(mon, command, param);
+}
+
 static const mon_cmd_t mon_cmds[] = {
 #include "qemu-monitor.h"
     { NULL, NULL, },
diff --git a/qemu-monitor.hx b/qemu-monitor.hx
index 0dc2ad7..3db5513 100644
--- a/qemu-monitor.hx
+++ b/qemu-monitor.hx
@@ -574,6 +574,16 @@ STEXI
 Change watchdog action.
 ETEXI
 
+    { "virtio-console", "ss?", do_virtio_console_action,
+      "<command> [<parameters>]\n",
+      "virtio-serial write port=3,key=get,value=clipboard\n"
+      "virtio-serial add_port\n"
+      "virtio-serial add_port port=6,name=foo,protocol=keyvalue\n" },
+STEXI
+@item virtio-console
+Hot-add ports or send data to virtio-console port
+ETEXI
+
     { "acl_show", "s", do_acl_show, "aclname",
       "list rules in the access control list" },
 STEXI
diff --git a/qemu-options.hx b/qemu-options.hx
index 0267496..8f83233 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1613,7 +1613,7 @@ ETEXI
 
 DEF("virtioconsole", HAS_ARG, QEMU_OPTION_virtiocon, \
     "-virtioconsole c\n" \
-    "                set virtio console\n")
+    "                define virtio console\n")
 STEXI
 @item -virtioconsole @var{c}
 Set virtio console.
diff --git a/sysemu.h b/sysemu.h
index c9f8a5a..53b82cb 100644
--- a/sysemu.h
+++ b/sysemu.h
@@ -2,6 +2,7 @@
 #define SYSEMU_H
 /* Misc. things related to the system emulator.  */
 
+#include <stdbool.h>
 #include "qemu-common.h"
 #include "qemu-option.h"
 #include "sys-queue.h"
@@ -227,9 +228,14 @@ extern CharDriverState *parallel_hds[MAX_PARALLEL_PORTS];
 
 /* virtio consoles */
 
-#define MAX_VIRTIO_CONSOLES 1
+#define MAX_VIRTIO_CONSOLE_PORTS 64
+#define VIRTIO_CONSOLE_PROTO_MAX_LEN 30
 
-extern CharDriverState *virtcon_hds[MAX_VIRTIO_CONSOLES];
+extern CharDriverState *virtcon_hds[MAX_VIRTIO_CONSOLE_PORTS];
+extern uint32_t virtcon_idx[MAX_VIRTIO_CONSOLE_PORTS];
+extern int virtcon_nr_ports;
+extern int init_virtio_console_port(int port, const char *opts);
+extern void *virtio_console_new_port(PCIDevice *dev, uint32_t idx);
 
 #define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)
 
diff --git a/vl.c b/vl.c
index dc1a820..677834e 100644
--- a/vl.c
+++ b/vl.c
@@ -214,7 +214,10 @@ static int no_frame = 0;
 int no_quit = 0;
 CharDriverState *serial_hds[MAX_SERIAL_PORTS];
 CharDriverState *parallel_hds[MAX_PARALLEL_PORTS];
-CharDriverState *virtcon_hds[MAX_VIRTIO_CONSOLES];
+CharDriverState *virtcon_hds[MAX_VIRTIO_CONSOLE_PORTS];
+char virtcon_prot[MAX_VIRTIO_CONSOLE_PORTS][VIRTIO_CONSOLE_PROTO_MAX_LEN];
+uint32_t virtcon_idx[MAX_VIRTIO_CONSOLE_PORTS];
+int virtcon_nr_ports;
 #ifdef TARGET_I386
 int win2k_install_hack = 0;
 int rtc_td_hack = 0;
@@ -4858,8 +4861,7 @@ int main(int argc, char **argv, char **envp)
     int serial_device_index;
     const char *parallel_devices[MAX_PARALLEL_PORTS];
     int parallel_device_index;
-    const char *virtio_consoles[MAX_VIRTIO_CONSOLES];
-    int virtio_console_index;
+    const char *virtio_consoles[MAX_VIRTIO_CONSOLE_PORTS];
     const char *loadvm = NULL;
     QEMUMachine *machine;
     const char *cpu_model;
@@ -4933,9 +4935,9 @@ int main(int argc, char **argv, char **envp)
         parallel_devices[i] = NULL;
     parallel_device_index = 0;
 
-    for(i = 0; i < MAX_VIRTIO_CONSOLES; i++)
+    for(i = 0; i < MAX_VIRTIO_CONSOLE_PORTS; i++)
         virtio_consoles[i] = NULL;
-    virtio_console_index = 0;
+    virtcon_nr_ports = 0;
 
     for (i = 0; i < MAX_NODES; i++) {
         node_mem[i] = 0;
@@ -5379,12 +5381,12 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_virtiocon:
-                if (virtio_console_index >= MAX_VIRTIO_CONSOLES) {
+                if (virtcon_nr_ports >= MAX_VIRTIO_CONSOLE_PORTS) {
                     fprintf(stderr, "qemu: too many virtio consoles\n");
                     exit(1);
                 }
-                virtio_consoles[virtio_console_index] = optarg;
-                virtio_console_index++;
+                virtio_consoles[virtcon_nr_ports] = optarg;
+                virtcon_nr_ports++;
                 break;
             case QEMU_OPTION_parallel:
                 if (parallel_device_index >= MAX_PARALLEL_PORTS) {
@@ -6015,17 +6017,13 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
-    for(i = 0; i < MAX_VIRTIO_CONSOLES; i++) {
-        const char *devname = virtio_consoles[i];
-        if (devname && strcmp(devname, "none")) {
-            char label[32];
-            snprintf(label, sizeof(label), "virtcon%d", i);
-            virtcon_hds[i] = qemu_chr_open(label, devname, NULL);
-            if (!virtcon_hds[i]) {
-                fprintf(stderr, "qemu: could not open virtio console '%s'\n",
-                        devname);
-                exit(1);
-            }
+    for (i = 0; i < virtcon_nr_ports; i++) {
+        int ret;
+
+        ret = init_virtio_console_port(i, virtio_consoles[i]);
+        if (ret < 0) {
+            fprintf(stderr, "qemu: could not init virtio console port at \"%s\"\n", virtio_consoles[i]);
+            exit(1);
         }
     }
 
@@ -6140,11 +6138,12 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
-    for(i = 0; i < MAX_VIRTIO_CONSOLES; i++) {
+    for(i = 0; i < MAX_VIRTIO_CONSOLE_PORTS; i++) {
         const char *devname = virtio_consoles[i];
         if (virtcon_hds[i] && devname) {
             if (strstart(devname, "vc", 0))
-                qemu_chr_printf(virtcon_hds[i], "virtio console%d\r\n", i);
+                qemu_chr_printf(virtcon_hds[i], "virtio console%d\r\n",
+                                virtcon_idx[i]);
         }
     }
 
-- 
1.6.2.5
