From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] virtio: Silence uninitialized variable warning
Date: Fri, 15 Apr 2016 17:45:10 +0300
Message-ID: <20160415144510.GB8953@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Smatch complains that we might not initialize "queue".  The issue is
callers like setup_vq() from virtio_pci_modern.c where "num" could be
something like 2 and "vring_align" is 64.  In that case, vring_size() is
less than PAGE_SIZE.  It won't happen in real life, but we're getting
the value of "num" from a register so it's not really possible to tell
what value it holds with static analysis.

Let's just silence the warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5c802d4..ca6bfdd 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1006,7 +1006,7 @@ struct virtqueue *vring_create_virtqueue(
 	const char *name)
 {
 	struct virtqueue *vq;
-	void *queue;
+	void *queue = NULL;
 	dma_addr_t dma_addr;
 	size_t queue_size_in_bytes;
 	struct vring vring;
