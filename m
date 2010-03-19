From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/9] virtio-serial-bus: save/load: Ensure nr_ports on src and
	dest are same.
Date: Fri, 19 Mar 2010 17:28:39 +0530
Message-ID: <1268999926-29560-3-git-send-email-amit.shah@redhat.com>
References: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1268999926-29560-2-git-send-email-amit.shah@redhat.com>
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

The number of ports on the source as well as the destination machines
should match. If they don't, it means some ports that got hotplugged on
the source aren't instantiated on the destination. Or that ports that
were hot-unplugged on the source are created on the destination.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
Reported-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio-serial-bus.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/virtio-serial-bus.c b/hw/virtio-serial-bus.c
index 36985a1..f43d1fc 100644
--- a/hw/virtio-serial-bus.c
+++ b/hw/virtio-serial-bus.c
@@ -401,7 +401,7 @@ static int virtio_serial_load(QEMUFile *f, void *opaque, int version_id)
 {
     VirtIOSerial *s = opaque;
     VirtIOSerialPort *port;
-    uint32_t max_nr_ports, nr_active_ports;
+    uint32_t max_nr_ports, nr_active_ports, nr_ports;
     unsigned int i;
 
     if (version_id > 2) {
@@ -418,7 +418,21 @@ static int virtio_serial_load(QEMUFile *f, void *opaque, int version_id)
     /* The config space */
     qemu_get_be16s(f, &s->config.cols);
     qemu_get_be16s(f, &s->config.rows);
-    s->config.nr_ports = qemu_get_be32(f);
+    nr_ports = qemu_get_be32(f);
+
+    if (nr_ports != s->config.nr_ports) {
+        /*
+         * Source hot-plugged/unplugged ports and we don't have all of
+         * them here.
+         *
+         * Note: This condition cannot check for all hotplug/unplug
+         * events: eg, if one port was hot-plugged and one was
+         * unplugged, the nr_ports remains the same but the port id's
+         * would have changed and we won't catch it here. A later
+         * check for !find_port_by_id() will confirm if this happened.
+         */
+        return -EINVAL;
+    }
 
     /* Items in struct VirtIOSerial */
 
-- 
1.6.2.5
