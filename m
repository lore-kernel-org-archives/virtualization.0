From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH-v2 1/3] virtio: add API to check that ring is setup
Date: Mon,  1 Apr 2013 23:58:22 +0000
Message-ID: <1364860704-11896-2-git-send-email-nab@linux-iscsi.org>
References: <1364860704-11896-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1364860704-11896-1-git-send-email-nab@linux-iscsi.org>
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
Cc: kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Michael S. Tsirkin <mst@redhat.com>

virtio scsi makes it legal to only setup a subset of rings.  The only
way to detect the ring is setup seems to be to check whether PA was
written to.  Add API to do this, and teach code to use it instead of
checking hardware queue size.

(nab: use .vring.desc instead of .vring.pa)

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Cc: Asias He <asias@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 hw/virtio.c |    5 +++++
 hw/virtio.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/hw/virtio.c b/hw/virtio.c
index 26fbc79..65ba253 100644
--- a/hw/virtio.c
+++ b/hw/virtio.c
@@ -651,6 +651,11 @@ int virtio_queue_get_num(VirtIODevice *vdev, int n)
     return vdev->vq[n].vring.num;
 }
 
+bool virtio_queue_valid(VirtIODevice *vdev, int n)
+{
+    return vdev->vq[n].vring.num && vdev->vq[n].vring.desc;
+}
+
 int virtio_queue_get_id(VirtQueue *vq)
 {
     VirtIODevice *vdev = vq->vdev;
diff --git a/hw/virtio.h b/hw/virtio.h
index fdbe931..3086798 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -227,6 +227,7 @@ void virtio_config_writel(VirtIODevice *vdev, uint32_t addr, uint32_t data);
 void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr);
 hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n);
 int virtio_queue_get_num(VirtIODevice *vdev, int n);
+bool virtio_queue_valid(VirtIODevice *vdev, int n);
 void virtio_queue_notify(VirtIODevice *vdev, int n);
 uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
 void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector);
-- 
1.7.2.5
