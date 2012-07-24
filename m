From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [RFC 3/9] virtio-pci: check that event notification worked
Date: Tue, 24 Jul 2012 22:34:00 +0000
Message-ID: <1343169246-17636-4-git-send-email-nab__40114.0200360262$1343169467$gmane$org@linux-iscsi.org>
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

For sanity assert that event notification succeeds.

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 hw/virtio-pci.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 538eef4..0f0f766 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -261,8 +261,11 @@ static void virtio_pci_queue_notify(VirtIOPCIProxy *proxy, uint32_t n)
     vq = virtio_get_queue(proxy->vdev, n);
     notifier = virtio_queue_get_host_notifier(vq);
     if (event_notifier_valid(notifier)) {
+        int r;
+
         printf("notifying vq %u host notifier from userspace\n", n);
-        event_notifier_notify(notifier);
+        r = event_notifier_notify(notifier);
+        assert(r == 0);
     } else {
         virtio_queue_notify_vq(vq);
     }
-- 
1.7.2.5
