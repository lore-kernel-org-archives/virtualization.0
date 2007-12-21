From: Dor Laor <dor.laor@gmail.com>
Subject: [Virtio-for-kvm] [PATCH 7/7] userspace virtio
Date: Fri, 21 Dec 2007 16:46:01 +0200
Message-ID: <476BD1A9.2040701__42281.9130392329$1198248468$gmane$org@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rus>
List-Id: virtualization@lists.linuxfoundation.org

 From f244bcad756c4f761627557bb7f315b1d8f22fb2 Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Thu, 20 Dec 2007 13:26:30 +0200
Subject: [PATCH] [VIRTIO-NET] Rx performance improvement
 The current performance are not good enough, the problem lies
 in qemu tap handling code that caused to pass packets one at
 a time and also to copy them to a temporal buffer.

This patch prevents qemu handlers from reading the tap and instead
it selects the tap descriptors for virtio devices.
This eliminates copies and also batch guest notifications (interrupts).

Using this patch the rx performance reaches 800Mbps.
The patch does not follow qemu's api since the intention is first to have
a better io in kvm and then to polish it correctly.

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 qemu/hw/pc.h         |    2 +-
 qemu/hw/virtio-net.c |  114 
+++++++++++++++++++++++++++++++++++--------------
 qemu/sysemu.h        |    3 +
 qemu/vl.c            |   23 ++++++++++-
 4 files changed, 107 insertions(+), 35 deletions(-)

diff --git a/qemu/hw/pc.h b/qemu/hw/pc.h
index 95471f3..5d4c747 100644
--- a/qemu/hw/pc.h
+++ b/qemu/hw/pc.h
@@ -145,7 +145,7 @@ void isa_ne2000_init(int base, qemu_irq irq, NICInfo 
*nd);
 /* virtio-net.c */
 
 void *virtio_net_init(PCIBus *bus, NICInfo *nd, int devfn);
-
+void virtio_net_poll(void);
 
 /* virtio-blk.h */
 void *virtio_blk_init(PCIBus *bus, uint16_t vendor, uint16_t device,
diff --git a/qemu/hw/virtio-net.c b/qemu/hw/virtio-net.c
index f6f1f28..b955a5e 100644
--- a/qemu/hw/virtio-net.c
+++ b/qemu/hw/virtio-net.c
@@ -60,8 +60,13 @@ typedef struct VirtIONet
     VirtQueue *tx_vq;
     VLANClientState *vc;
     int can_receive;
+    int tap_fd;
+    struct VirtIONet *next;
+    int do_notify;
 } VirtIONet;
 
+static VirtIONet *VirtIONetHead = NULL;
+
 static VirtIONet *to_virtio_net(VirtIODevice *vdev)
 {
     return (VirtIONet *)vdev;
@@ -96,42 +101,81 @@ static int virtio_net_can_receive(void *opaque)
     return (n->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK) && n->can_receive;
 }
 
-static void virtio_net_receive(void *opaque, const uint8_t *buf, int size)
+void virtio_net_poll(void)
 {
-    VirtIONet *n = opaque;
+    VirtIONet *vnet;
+    int len;
+    fd_set rfds;
+    struct timeval tv;
+    int max_fd = -1;
     VirtQueueElement elem;
     struct virtio_net_hdr *hdr;
-    int offset, i;
-
-    /* FIXME: the drivers really need to set their status better */
-    if (n->rx_vq->vring.avail == NULL) {
-    n->can_receive = 0;
-    return;
-    }
-
-    if (virtqueue_pop(n->rx_vq, &elem) == 0) {
-    /* wait until the guest adds some rx bufs */
-    n->can_receive = 0;
-    return;
-    }
-
-    hdr = (void *)elem.in_sg[0].iov_base;
-    hdr->flags = 0;
-    hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
-
-    /* copy in packet.  ugh */
-    offset = 0;
-    i = 1;
-    while (offset < size && i < elem.in_num) {
-    int len = MIN(elem.in_sg[i].iov_len, size - offset);
-    memcpy(elem.in_sg[i].iov_base, buf + offset, len);
-    offset += len;
-    i++;
-    }
+    int did_notify;
+
+    FD_ZERO(&rfds);
+    tv.tv_sec = 0;
+    tv.tv_usec = 0;
+
+    while (1) {
+
+         // Prepare the set of device to select from
+        for (vnet = VirtIONetHead; vnet; vnet = vnet->next) {
+
+             vnet->do_notify = 0;
+             //first check if the driver is ok
+             if (!virtio_net_can_receive(vnet))
+                 continue;
+
+             /* FIXME: the drivers really need to set their status 
better */
+             if (vnet->rx_vq->vring.avail == NULL) {
+                vnet->can_receive = 0;
+                continue;
+             }
+
+             FD_SET(vnet->tap_fd, &rfds);
+             if (max_fd < vnet->tap_fd) max_fd = vnet->tap_fd;
+        }
+       
+        if (select(max_fd + 1, &rfds, NULL, NULL, &tv) <= 0)
+            break;
+
+       // Now check who has data pending in the tap
+        for (vnet = VirtIONetHead; vnet; vnet = vnet->next) {
+
+             if (!FD_ISSET(vnet->tap_fd, &rfds))
+                 continue;
+   
+             if (virtqueue_pop(vnet->rx_vq, &elem) == 0) {
+                vnet->can_receive = 0;
+                 continue;
+             }
+
+             hdr = (void *)elem.in_sg[0].iov_base;
+             hdr->flags = 0;
+             hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
+again:
+             len = readv(vnet->tap_fd, &elem.in_sg[1], elem.in_num - 1);
+             if (len == -1)
+                 if (errno == EINTR || errno == EAGAIN)
+                     goto again;
+                 else
+                     fprintf(stderr, "reading network error %d", len);
+
+            virtqueue_push(vnet->rx_vq, &elem, sizeof(*hdr) + len);
+            vnet->do_notify = 1;
+        }
+
+        /* signal other side */
+        did_notify = 0;
+        for (vnet = VirtIONetHead; vnet; vnet = vnet->next)
+            if (vnet->do_notify) {
+                virtio_notify(&vnet->vdev, vnet->rx_vq);
+                did_notify++;
+            }
+        if (!did_notify)
+            break;
+     }
 
-    /* signal other side */
-    virtqueue_push(n->rx_vq, &elem, sizeof(*hdr) + offset);
-    virtio_notify(&n->vdev, n->rx_vq);
 }
 
 /* TX */
@@ -174,8 +218,12 @@ void *virtio_net_init(PCIBus *bus, NICInfo *nd, int 
devfn)
     n->tx_vq = virtio_add_queue(&n->vdev, 128, virtio_net_handle_tx);
     n->can_receive = 0;
     memcpy(n->mac, nd->macaddr, 6);
-    n->vc = qemu_new_vlan_client(nd->vlan, virtio_net_receive,
+    n->vc = qemu_new_vlan_client(nd->vlan, NULL,
                  virtio_net_can_receive, n);
+    n->tap_fd = get_tap_fd(n->vc->vlan->first_client->opaque);
+    n->next = VirtIONetHead;
+    //push the device on top of the list
+    VirtIONetHead = n;
 
     return &n->vdev;
 }
diff --git a/qemu/sysemu.h b/qemu/sysemu.h
index e20159d..4bedd11 100644
--- a/qemu/sysemu.h
+++ b/qemu/sysemu.h
@@ -66,6 +66,9 @@ void qemu_del_wait_object(HANDLE handle, 
WaitObjectFunc *func, void *opaque);
 /* TAP win32 */
 int tap_win32_init(VLANState *vlan, const char *ifname);
 
+/* virtio hack for zero copy receive */
+int get_tap_fd(void *opaque);
+
 /* SLIRP */
 void do_info_slirp(void);
 
diff --git a/qemu/vl.c b/qemu/vl.c
index 26055a4..eef602a 100644
--- a/qemu/vl.c
+++ b/qemu/vl.c
@@ -3885,8 +3885,26 @@ typedef struct TAPState {
     VLANClientState *vc;
     int fd;
     char down_script[1024];
+    int no_poll;
 } TAPState;
 
+int get_tap_fd(void *opaque)
+{
+    TAPState *s = opaque;
+
+    if (s) {
+       s->no_poll = 1;
+       return s->fd;
+    }
+    return -1;
+}
+
+static int tap_read_poll(void *opaque)
+{
+   TAPState *s = opaque;
+    return (!s->no_poll);
+}
+
 static void tap_receive(void *opaque, const uint8_t *buf, int size)
 {
     TAPState *s = opaque;
@@ -3930,9 +3948,10 @@ static TAPState *net_tap_fd_init(VLANState *vlan, 
int fd)
     if (!s)
         return NULL;
     s->fd = fd;
+    s->no_poll = 0;
     enable_sigio_timer(fd);
     s->vc = qemu_new_vlan_client(vlan, tap_receive, NULL, s);
-    qemu_set_fd_handler(s->fd, tap_send, NULL, s);
+    qemu_set_fd_handler2(s->fd, tap_read_poll, tap_send, NULL, s);
     snprintf(s->vc->info_str, sizeof(s->vc->info_str), "tap: fd=%d", fd);
     return s;
 }
@@ -7717,6 +7736,8 @@ void main_loop_wait(int timeout)
         slirp_select_poll(&rfds, &wfds, &xfds);
     }
 #endif
+    virtio_net_poll();
+
     qemu_aio_poll();
 
     if (vm_running) {
-- 
1.5.3.3
