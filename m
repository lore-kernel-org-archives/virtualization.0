From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/9] virtio-serial-bus: save/load: Ensure target has enough
	ports
Date: Fri, 19 Mar 2010 17:28:38 +0530
Message-ID: <1268999926-29560-2-git-send-email-amit.shah@redhat.com>
References: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
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

The target could be started with max_nr_ports for a virtio-serial device
lesser than what was available on the source machine. Fail the migration
in such a case.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
Reported-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio-serial-bus.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/hw/virtio-serial-bus.c b/hw/virtio-serial-bus.c
index 17c1ec1..36985a1 100644
--- a/hw/virtio-serial-bus.c
+++ b/hw/virtio-serial-bus.c
@@ -374,6 +374,8 @@ static void virtio_serial_save(QEMUFile *f, void *opaque)
 
     /* Items in struct VirtIOSerial */
 
+    qemu_put_be32s(f, &s->bus->max_nr_ports);
+
     /* Do this because we might have hot-unplugged some ports */
     nr_active_ports = 0;
     QTAILQ_FOREACH(port, &s->ports, next)
@@ -399,7 +401,7 @@ static int virtio_serial_load(QEMUFile *f, void *opaque, int version_id)
 {
     VirtIOSerial *s = opaque;
     VirtIOSerialPort *port;
-    uint32_t nr_active_ports;
+    uint32_t max_nr_ports, nr_active_ports;
     unsigned int i;
 
     if (version_id > 2) {
@@ -420,6 +422,12 @@ static int virtio_serial_load(QEMUFile *f, void *opaque, int version_id)
 
     /* Items in struct VirtIOSerial */
 
+    qemu_get_be32s(f, &max_nr_ports);
+    if (max_nr_ports > s->bus->max_nr_ports) {
+        /* Source could have more ports than us. Fail migration. */
+        return -EINVAL;
+    }
+
     qemu_get_be32s(f, &nr_active_ports);
 
     /* Items in struct VirtIOSerialPort */
-- 
1.6.2.5
