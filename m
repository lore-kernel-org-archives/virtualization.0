From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 5/9] virtio-serial: Handle scatter/gather input from the guest
Date: Fri, 19 Mar 2010 17:28:42 +0530
Message-ID: <1268999926-29560-6-git-send-email-amit.shah@redhat.com>
References: <1268999926-29560-1-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-2-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-3-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-4-git-send-email-amit.shah@redhat.com>
	<1268999926-29560-5-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1268999926-29560-5-git-send-email-amit.shah@redhat.com>
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
Cc: quintela@redhat.com, mst@redhat.com, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Current guests don't send more than one iov but it can change later.
Ensure we handle that case.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
CC: Avi Kivity <avi@redhat.com>
---
 hw/virtio-serial-bus.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/virtio-serial-bus.c b/hw/virtio-serial-bus.c
index d5887ab..19e8c59 100644
--- a/hw/virtio-serial-bus.c
+++ b/hw/virtio-serial-bus.c
@@ -338,11 +338,12 @@ static void handle_output(VirtIODevice *vdev, VirtQueue *vq)
 
     while (virtqueue_pop(vq, &elem)) {
         VirtIOSerialPort *port;
-        size_t ret;
+        size_t len;
+        unsigned int i;
 
+        len = 0;
         port = find_port_by_vq(vser, vq);
         if (!port) {
-            ret = 0;
             goto next_buf;
         }
 
@@ -352,16 +353,23 @@ static void handle_output(VirtIODevice *vdev, VirtQueue *vq)
          * with it. Just ignore the data in that case.
          */
         if (!port->info->have_data) {
-            ret = 0;
             goto next_buf;
         }
 
-        /* The guest always sends only one sg */
-        ret = port->info->have_data(port, elem.out_sg[0].iov_base,
-                                    elem.out_sg[0].iov_len);
+        for (i = 0; i < elem.out_num; i++) {
+            size_t ret;
+
+            ret = port->info->have_data(port, elem.out_sg[0].iov_base,
+                                        elem.out_sg[0].iov_len);
+            if (ret < elem.out_sg[0].iov_len) {
+                /* We couldn't write the entire iov; stop processing now */
+                break;
+            }
+            len += ret;
+        }
 
     next_buf:
-        virtqueue_push(vq, &elem, ret);
+        virtqueue_push(vq, &elem, len);
     }
     virtio_notify(vdev, vq);
 }
-- 
1.6.2.5
