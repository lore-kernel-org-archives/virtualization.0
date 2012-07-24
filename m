From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [RFC 2/9] virtio-pci: support host notifiers in TCG mode
Date: Tue, 24 Jul 2012 22:33:59 +0000
Message-ID: <1343169246-17636-3-git-send-email-nab__700.562625616108$1343169462$gmane$org@linux-iscsi.org>
References: <1343169246-17636-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1343169246-17636-1-git-send-email-nab@linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: target-devel <target-devel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Anthony Liguori <aliguori@us.ibm.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

Normally host notifiers are only used together with vhost-net in KVM
mode.  It is occassionally useful to use vhost with TCG mode, mainly for
testing and development.  This isn't hard to achieve, simply fall back
to notifying the host notifier manually from qemu if KVM mode is
disabled.

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 hw/virtio-pci.c |   23 ++++++++++++++++++++---
 hw/virtio.c     |    7 +++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 4e03f0b..538eef4 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -249,6 +249,25 @@ void virtio_pci_reset(DeviceState *d)
     proxy->flags &= ~VIRTIO_PCI_FLAG_BUS_MASTER_BUG;
 }
 
+static void virtio_pci_queue_notify(VirtIOPCIProxy *proxy, uint32_t n)
+{
+    VirtQueue *vq;
+    EventNotifier *notifier;
+
+    if (n >= VIRTIO_PCI_QUEUE_MAX) {
+        return;
+    }
+
+    vq = virtio_get_queue(proxy->vdev, n);
+    notifier = virtio_queue_get_host_notifier(vq);
+    if (event_notifier_valid(notifier)) {
+        printf("notifying vq %u host notifier from userspace\n", n);
+        event_notifier_notify(notifier);
+    } else {
+        virtio_queue_notify_vq(vq);
+    }
+}
+
 static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
 {
     VirtIOPCIProxy *proxy = opaque;
@@ -278,9 +297,7 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
             vdev->queue_sel = val;
         break;
     case VIRTIO_PCI_QUEUE_NOTIFY:
-        if (val < VIRTIO_PCI_QUEUE_MAX) {
-            virtio_queue_notify(vdev, val);
-        }
+        virtio_pci_queue_notify(proxy, val);
         break;
     case VIRTIO_PCI_STATUS:
         if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
diff --git a/hw/virtio.c b/hw/virtio.c
index d146f86..36a18b5 100644
--- a/hw/virtio.c
+++ b/hw/virtio.c
@@ -536,6 +536,11 @@ void virtio_reset(void *opaque)
         vdev->vq[i].signalled_used = 0;
         vdev->vq[i].signalled_used_valid = false;
         vdev->vq[i].notification = true;
+
+        assert(!event_notifier_valid(&vdev->vq[i].guest_notifier));
+        assert(!event_notifier_valid(&vdev->vq[i].host_notifier));
+        vdev->vq[i].guest_notifier = EVENT_NOTIFIER_INITIALIZER;
+        vdev->vq[i].host_notifier = EVENT_NOTIFIER_INITIALIZER;
     }
 }
 
@@ -905,6 +910,8 @@ VirtIODevice *virtio_common_init(const char *name, uint16_t device_id,
     for(i = 0; i < VIRTIO_PCI_QUEUE_MAX; i++) {
         vdev->vq[i].vector = VIRTIO_NO_VECTOR;
         vdev->vq[i].vdev = vdev;
+        vdev->vq[i].guest_notifier = EVENT_NOTIFIER_INITIALIZER;
+        vdev->vq[i].host_notifier = EVENT_NOTIFIER_INITIALIZER;
     }
 
     vdev->name = name;
-- 
1.7.2.5
