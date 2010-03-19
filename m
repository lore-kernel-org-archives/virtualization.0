From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 3/9] virtio-serial: save/load: Ensure we have hot-plugged
	ports instantiated
Date: Fri, 19 Mar 2010 17:28:40 +0530
Message-ID: <1268999926-29560-4-git-send-email-amit.shah@redhat.com>
References: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-2-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-3-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1268999926-29560-3-git-send-email-amit.shah@redhat.com>
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

If some ports that were hot-plugged on the source are not available on
the destination, fail migration instead of trying to deref a NULL
pointer.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
Reported-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio-serial-bus.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/hw/virtio-serial-bus.c b/hw/virtio-serial-bus.c
index f43d1fc..830eb75 100644
--- a/hw/virtio-serial-bus.c
+++ b/hw/virtio-serial-bus.c
@@ -450,6 +450,13 @@ static int virtio_serial_load(QEMUFile *f, void *opaque, int version_id)
 
         id = qemu_get_be32(f);
         port = find_port_by_id(s, id);
+        if (!port) {
+            /*
+             * The requested port was hot-plugged on the source but we
+             * don't have it
+             */
+            return -EINVAL;
+        }
 
         port->guest_connected = qemu_get_byte(f);
     }
-- 
1.6.2.5
