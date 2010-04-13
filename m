From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio-rng: use virtqueue_xxx wrappers
Date: Tue, 13 Apr 2010 16:11:42 +0300
Message-ID: <20100413131142.GA25649@redhat.com>
References: <20100413130604.GA25574@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100413130604.GA25574@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Switch virtio-rng to new virtqueue_xxx wrappers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 64fe0a7..75f1cbd 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -32,7 +32,7 @@ static bool busy;
 static void random_recv_done(struct virtqueue *vq)
 {
 	/* We can get spurious callbacks, e.g. shared IRQs + virtio_pci. */
-	if (!vq->vq_ops->get_buf(vq, &data_avail))
+	if (!virtqueue_get_buf(vq, &data_avail))
 		return;
 
 	complete(&have_data);
@@ -46,10 +46,10 @@ static void register_buffer(u8 *buf, size_t size)
 	sg_init_one(&sg, buf, size);
 
 	/* There should always be room for one buffer. */
-	if (vq->vq_ops->add_buf(vq, &sg, 0, 1, buf) < 0)
+	if (virtqueue_add_buf(vq, &sg, 0, 1, buf) < 0)
 		BUG();
 
-	vq->vq_ops->kick(vq);
+	virtqueue_kick(vq);
 }
 
 static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
-- 
1.7.0.2.280.gc6f05
