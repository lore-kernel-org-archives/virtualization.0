From: Pawel Moll <pawel.moll@arm.com>
Subject: [PATCH 1/2] virtio_mmio: fix off by one error allocating queue
Date: Mon, 24 Sep 2012 14:33:41 +0100
Message-ID: <1348493622-26091-2-git-send-email-pawel.moll@arm.com>
References: <1348493622-26091-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1348493622-26091-1-git-send-email-pawel.moll@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Brian Foley <brian.foley@arm.com>, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Brian Foley <brian.foley@arm.com>

vm_setup_vq fails to allow VirtQueues needing only 2 pages of
storage, as it should. Found with a kernel using 64kB pages, but
can be provoked if a virtio device reports QueueNumMax where the
descriptor table and available ring fit in one page, and the used
ring on the second (<= 227 descriptors with 4kB pages and <= 3640
with 64kB pages.)

Signed-off-by: Brian Foley <brian.foley@arm.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/virtio/virtio_mmio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 453db0c..58e2d78 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -335,8 +335,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 	while (1) {
 		size = PAGE_ALIGN(vring_size(info->num,
 				VIRTIO_MMIO_VRING_ALIGN));
-		/* Already smallest possible allocation? */
-		if (size <= VIRTIO_MMIO_VRING_ALIGN * 2) {
+		/* Did the last iter shrink the queue below minimum size? */
+		if (size < VIRTIO_MMIO_VRING_ALIGN * 2) {
 			err = -ENOMEM;
 			goto error_alloc_pages;
 		}
-- 
1.7.9.5
