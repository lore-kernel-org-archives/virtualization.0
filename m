From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 9/9] virtio-serial-bus: Let the guest know of host connection
	changes after migration
Date: Fri, 19 Mar 2010 17:28:46 +0530
Message-ID: <1268999926-29560-10-git-send-email-amit.shah@redhat.com>
References: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-2-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-3-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-4-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-5-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-6-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-7-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-8-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-9-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1268999926-29560-9-git-send-email-amit.shah@redhat.com>
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

If the host connection to a port is closed on the destination machine
after migration, when the connection was open on the source, the host
has to be informed of that.

Similar for a host connection open on the destination.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 hw/virtio-serial-bus.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/hw/virtio-serial-bus.c b/hw/virtio-serial-bus.c
index 2242edf..f5ea37e 100644
--- a/hw/virtio-serial-bus.c
+++ b/hw/virtio-serial-bus.c
@@ -435,6 +435,7 @@ static void virtio_serial_save(QEMUFile *f, void *opaque)
     QTAILQ_FOREACH(port, &s->ports, next) {
         qemu_put_be32s(f, &port->id);
         qemu_put_byte(f, port->guest_connected);
+        qemu_put_byte(f, port->host_connected);
     }
 }
 
@@ -488,11 +489,21 @@ static int virtio_serial_load(QEMUFile *f, void *opaque, int version_id)
     /* Items in struct VirtIOSerialPort */
     for (i = 0; i < nr_active_ports; i++) {
         uint32_t id;
+        bool host_connected;
 
         id = qemu_get_be32(f);
         port = find_port_by_id(s, id);
 
         port->guest_connected = qemu_get_byte(f);
+        host_connected = qemu_get_byte(f);
+        if (host_connected != port->host_connected) {
+            /*
+             * We have to let the guest know of the host connection
+             * status change
+             */
+            send_control_event(port, VIRTIO_CONSOLE_PORT_OPEN,
+                               port->host_connected);
+        }
     }
     return 0;
 }
-- 
1.6.2.5
