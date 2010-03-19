From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 8/9] virtio-serial-bus: Use a bitmap in virtio config space
	for active ports
Date: Fri, 19 Mar 2010 17:28:45 +0530
Message-ID: <1268999926-29560-9-git-send-email-amit.shah@redhat.com>
References: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-2-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-3-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-4-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-5-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-6-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-7-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-8-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1268999926-29560-8-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: Amit Shah <amit.shah@redhat.com>, quintela@redhat.com, mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Allow the port 'id's to be set by a user on the command line. This is
needed by management apps that will want a stable port numbering scheme
for hot-plug/unplug and migration.

Since the port numbers are shared with the guest (to identify ports in
control messages), the config space now maintains a bitmap for active
ports instead of a number indicating active ports.

This also means we can just update the config for port hot-plug and
hot-unplug.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 hw/virtio-console.c    |    2 +
 hw/virtio-serial-bus.c |  141 +++++++++++++++++++++++++++---------------------
 hw/virtio-serial.h     |    6 ++-
 3 files changed, 86 insertions(+), 63 deletions(-)

diff --git a/hw/virtio-console.c b/hw/virtio-console.c
index e915491..bbbb6b8 100644
--- a/hw/virtio-console.c
+++ b/hw/virtio-console.c
@@ -99,6 +99,7 @@ static VirtIOSerialPortInfo virtconsole_info = {
     .exit          = virtconsole_exitfn,
     .qdev.props = (Property[]) {
         DEFINE_PROP_UINT8("is_console", VirtConsole, port.is_console, 1),
+        DEFINE_PROP_UINT32("nr", VirtConsole, port.id, VIRTIO_CONSOLE_BAD_ID),
         DEFINE_PROP_CHR("chardev", VirtConsole, chr),
         DEFINE_PROP_STRING("name", VirtConsole, port.name),
         DEFINE_PROP_END_OF_LIST(),
@@ -133,6 +134,7 @@ static VirtIOSerialPortInfo virtserialport_info = {
     .init          = virtserialport_initfn,
     .exit          = virtconsole_exitfn,
     .qdev.props = (Property[]) {
+        DEFINE_PROP_UINT32("nr", VirtConsole, port.id, VIRTIO_CONSOLE_BAD_ID),
         DEFINE_PROP_CHR("chardev", VirtConsole, chr),
         DEFINE_PROP_STRING("name", VirtConsole, port.name),
         DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/virtio-serial-bus.c b/hw/virtio-serial-bus.c
index b682b77..2242edf 100644
--- a/hw/virtio-serial-bus.c
+++ b/hw/virtio-serial-bus.c
@@ -48,6 +48,10 @@ static VirtIOSerialPort *find_port_by_id(VirtIOSerial *vser, uint32_t id)
 {
     VirtIOSerialPort *port;
 
+    if (id == VIRTIO_CONSOLE_BAD_ID) {
+        return NULL;
+    }
+
     QTAILQ_FOREACH(port, &vser->ports, next) {
         if (port->id == id)
             return port;
@@ -412,13 +416,13 @@ static void virtio_serial_save(QEMUFile *f, void *opaque)
     /* The config space */
     qemu_put_be16s(f, &s->config.cols);
     qemu_put_be16s(f, &s->config.rows);
-    qemu_put_be32s(f, &s->config.nr_ports);
 
-    /* Items in struct VirtIOSerial */
+    qemu_put_be32s(f, &s->config.max_nr_ports);
+    qemu_put_buffer(f, (uint8_t *)s->config.ports_map,
+                    sizeof(uint32_t) * (s->config.max_nr_ports + 31) / 32);
 
-    qemu_put_be32s(f, &s->bus->max_nr_ports);
+    /* Ports */
 
-    /* Do this because we might have hot-unplugged some ports */
     nr_active_ports = 0;
     QTAILQ_FOREACH(port, &s->ports, next)
         nr_active_ports++;
@@ -429,11 +433,6 @@ static void virtio_serial_save(QEMUFile *f, void *opaque)
      * Items in struct VirtIOSerialPort.
      */
     QTAILQ_FOREACH(port, &s->ports, next) {
-        /*
-         * We put the port number because we may not have an active
-         * port at id 0 that's reserved for a console port, or in case
-         * of ports that might have gotten unplugged
-         */
         qemu_put_be32s(f, &port->id);
         qemu_put_byte(f, port->guest_connected);
     }
@@ -443,7 +442,8 @@ static int virtio_serial_load(QEMUFile *f, void *opaque, int version_id)
 {
     VirtIOSerial *s = opaque;
     VirtIOSerialPort *port;
-    uint32_t max_nr_ports, nr_active_ports, nr_ports;
+    size_t ports_map_size;
+    uint32_t max_nr_ports, nr_active_ports, *ports_map;
     unsigned int i;
 
     if (version_id > 2) {
@@ -460,29 +460,28 @@ static int virtio_serial_load(QEMUFile *f, void *opaque, int version_id)
     /* The config space */
     qemu_get_be16s(f, &s->config.cols);
     qemu_get_be16s(f, &s->config.rows);
-    nr_ports = qemu_get_be32(f);
 
-    if (nr_ports != s->config.nr_ports) {
-        /*
-         * Source hot-plugged/unplugged ports and we don't have all of
-         * them here.
-         *
-         * Note: This condition cannot check for all hotplug/unplug
-         * events: eg, if one port was hot-plugged and one was
-         * unplugged, the nr_ports remains the same but the port id's
-         * would have changed and we won't catch it here. A later
-         * check for !find_port_by_id() will confirm if this happened.
-         */
+    qemu_get_be32s(f, &max_nr_ports);
+    if (max_nr_ports > s->config.max_nr_ports) {
+        /* Source could have had more ports than us. Fail migration. */
         return -EINVAL;
     }
 
-    /* Items in struct VirtIOSerial */
+    ports_map_size = sizeof(uint32_t) * (max_nr_ports + 31) / 32;
+    ports_map = qemu_malloc(ports_map_size);
+    qemu_get_buffer(f, (uint8_t *)ports_map, ports_map_size);
 
-    qemu_get_be32s(f, &max_nr_ports);
-    if (max_nr_ports > s->bus->max_nr_ports) {
-        /* Source could have more ports than us. Fail migration. */
-        return -EINVAL;
+    for (i = 0; i < (max_nr_ports + 31) / 32; i++) {
+        if (ports_map[i] != s->config.ports_map[i]) {
+            /*
+             * Ports active on source and destination don't
+             * match. Fail migration.
+             */
+            qemu_free(ports_map);
+            return -EINVAL;
+        }
     }
+    qemu_free(ports_map);
 
     qemu_get_be32s(f, &nr_active_ports);
 
@@ -492,20 +491,11 @@ static int virtio_serial_load(QEMUFile *f, void *opaque, int version_id)
 
         id = qemu_get_be32(f);
         port = find_port_by_id(s, id);
-        if (!port) {
-            /*
-             * The requested port was hot-plugged on the source but we
-             * don't have it
-             */
-            return -EINVAL;
-        }
 
         port->guest_connected = qemu_get_byte(f);
     }
-
     return 0;
 }
-
 static void virtser_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
 
 static struct BusInfo virtser_bus_info = {
@@ -537,6 +527,39 @@ static void virtser_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent)
                    indent, "", port->host_connected);
 }
 
+/* This function is only used if a port id is not provided by the user */
+static uint32_t find_free_port_id(VirtIOSerial *vser)
+{
+    unsigned int i;
+
+    for (i = 0; i < (vser->config.max_nr_ports + 31) / 32; i++) {
+        uint32_t map, bit;
+
+        map = vser->config.ports_map[i];
+        bit = ffs(~map);
+        if (bit) {
+            return (bit - 1) + i * 32;
+        }
+    }
+    return VIRTIO_CONSOLE_BAD_ID;
+}
+
+static void mark_port_added(VirtIOSerial *vser, uint32_t port_id)
+{
+    unsigned int i;
+
+    i = port_id / 32;
+    vser->config.ports_map[i] |= 1U << (port_id % 32);
+}
+
+static void mark_port_removed(VirtIOSerial *vser, uint32_t port_id)
+{
+    unsigned int i;
+
+    i = port_id / 32;
+    vser->config.ports_map[i] &= ~(1U << (port_id % 32));
+}
+
 static int virtser_port_qdev_init(DeviceState *qdev, DeviceInfo *base)
 {
     VirtIOSerialDevice *dev = DO_UPCAST(VirtIOSerialDevice, qdev, qdev);
@@ -555,19 +578,30 @@ static int virtser_port_qdev_init(DeviceState *qdev, DeviceInfo *base)
      */
     plugging_port0 = port->is_console && !find_port_by_id(port->vser, 0);
 
-    if (port->vser->config.nr_ports == bus->max_nr_ports && !plugging_port0) {
-        error_report("virtio-serial-bus: Maximum device limit reached");
+    if (find_port_by_id(port->vser, port->id)) {
+        error_report("virtio-serial-bus: A port already exists at id %u\n",
+                     port->id);
         return -1;
     }
-    dev->info = info;
 
+    if (plugging_port0) {
+        port->id = 0;
+    }
+
+    if (port->id == VIRTIO_CONSOLE_BAD_ID) {
+        port->id = find_free_port_id(port->vser);
+        if (port->id == VIRTIO_CONSOLE_BAD_ID) {
+            error_report("virtio-serial-bus: Maximum device limit reached\n");
+            return -1;
+        }
+    }
+
+    dev->info = info;
     ret = info->init(dev);
     if (ret) {
         return ret;
     }
 
-    port->id = plugging_port0 ? 0 : port->vser->config.nr_ports++;
-
     if (!use_multiport(port->vser)) {
         /*
          * Allow writes to guest in this case; we have no way of
@@ -580,6 +614,8 @@ static int virtser_port_qdev_init(DeviceState *qdev, DeviceInfo *base)
     port->ivq = port->vser->ivqs[port->id];
     port->ovq = port->vser->ovqs[port->id];
 
+    mark_port_added(port->vser, port->id);
+
     /* Send an update to the guest about this new port added */
     virtio_notify_config(&port->vser->vdev);
 
@@ -592,26 +628,9 @@ static int virtser_port_qdev_exit(DeviceState *qdev)
     VirtIOSerialPort *port = DO_UPCAST(VirtIOSerialPort, dev, &dev->qdev);
     VirtIOSerial *vser = port->vser;
 
-    send_control_event(port, VIRTIO_CONSOLE_PORT_REMOVE, 1);
+    mark_port_removed(port->vser, port->id);
+    virtio_notify_config(&port->vser->vdev);
 
-    /*
-     * Don't decrement nr_ports here; thus we keep a linearly
-     * increasing port id. Not utilising an id again saves us a couple
-     * of complications:
-     *
-     * - Not having to bother about sending the port id to the guest
-     *   kernel on hotplug or on addition of new ports; the guest can
-     *   also linearly increment the port number. This is preferable
-     *   because the config space won't have the need to store a
-     *   ports_map.
-     *
-     * - Extra state to be stored for all the "holes" that got created
-     *   so that we keep filling in the ids from the least available
-     *   index.
-     *
-     * When such a functionality is desired, a control message to add
-     * a port can be introduced.
-     */
     QTAILQ_REMOVE(&vser->ports, port, next);
 
     if (port->info->exit)
@@ -675,7 +694,7 @@ VirtIODevice *virtio_serial_init(DeviceState *dev, uint32_t max_nr_ports)
      * Reserve location 0 for a console port for backward compat
      * (old kernel, new qemu)
      */
-    vser->config.nr_ports = 1;
+    mark_port_added(vser, 0);
 
     vser->vdev.get_features = get_features;
     vser->vdev.get_config = get_config;
diff --git a/hw/virtio-serial.h b/hw/virtio-serial.h
index 632d31b..5f1d458 100644
--- a/hw/virtio-serial.h
+++ b/hw/virtio-serial.h
@@ -27,6 +27,9 @@
 /* Features supported */
 #define VIRTIO_CONSOLE_F_MULTIPORT	1
 
+#define VIRTIO_CONSOLE_BAD_ID           (~(uint32_t)0)
+#define MAX_VIRTIO_CONSOLE_PORTS	((VIRTIO_PCI_QUEUE_MAX / 2) - 1)
+
 struct virtio_console_config {
     /*
      * These two fields are used by VIRTIO_CONSOLE_F_SIZE which
@@ -36,7 +39,7 @@ struct virtio_console_config {
     uint16_t rows;
 
     uint32_t max_nr_ports;
-    uint32_t nr_ports;
+    uint32_t ports_map[(MAX_VIRTIO_CONSOLE_PORTS + 31) / 32];
 } __attribute__((packed));
 
 struct virtio_console_control {
@@ -51,7 +54,6 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_RESIZE		2
 #define VIRTIO_CONSOLE_PORT_OPEN	3
 #define VIRTIO_CONSOLE_PORT_NAME	4
-#define VIRTIO_CONSOLE_PORT_REMOVE	5
 
 /* == In-qemu interface == */
 
-- 
1.6.2.5
