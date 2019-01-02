From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 4/4] virtio: use dependent_ptr_mb
Date: Wed, 2 Jan 2019 15:58:03 -0500
Message-ID: <20190102205715.14054-5-mst__29921.7333471917$1546462577$gmane$org@redhat.com>
References: <20190102205715.14054-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190102205715.14054-1-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Daniel Lustig <dlustig@nvidia.com>, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, Nicholas Piggin <npiggin@gmail.com>, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, netdev@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Jade Alglave <j.alglave@ucl.ac.uk>, Boqun Feng <boqun.feng@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Use dependent_ptr_mb which is - on some architectures -
more light-weight than an rmb.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 814b395007b2..2d320396eff8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -702,6 +702,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
 	void *ret;
 	unsigned int i;
 	u16 last_used;
+	bool more;
 
 	START_USE(vq);
 
@@ -710,14 +711,15 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
 		return NULL;
 	}
 
-	if (!more_used(vq)) {
+	more = more_used(vq);
+	if (!more) {
 		pr_debug("No more buffers in queue\n");
 		END_USE(vq);
 		return NULL;
 	}
 
 	/* Only get used array entries after they have been exposed by host. */
-	virtio_rmb(vq->weak_barriers);
+	vq = dependent_ptr_mb(vq, more);
 
 	last_used = (vq->last_used_idx & (vq->vring.num - 1));
 	i = virtio32_to_cpu(_vq->vdev, vq->vring.used->ring[last_used].id);
-- 
MST
