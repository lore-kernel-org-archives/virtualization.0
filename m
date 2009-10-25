From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2] virtio: order used ring after used index read
Date: Sun, 25 Oct 2009 15:28:53 +0200
Message-ID: <20091025132853.GA21301__583.39402680776$1256477555$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On SMP guests, reads from the ring might bypass
used index reads. This causes guest crashes
because host writes to used index to signal ring data
readiness.
Fix this by inserting rmb before used ring reads.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Change from v1: indent with TAB and not spaces. sorry about the noise.

Rusty, I see guest crashes with virtio net on vhost sometimes,
and the following seems to help.
This seems an obviously correct thing to do, anyway.
If you think so, too, can this be queued for 2.6.32 please?
Thanks,



 drivers/virtio/virtio_ring.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f536005..fbd2ecd 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -285,6 +285,9 @@ static void *vring_get_buf(struct virtqueue *_vq, unsigned int *len)
 		return NULL;
 	}
 
+	/* Only get used array entries after they have been exposed by host. */
+	rmb();
+
 	i = vq->vring.used->ring[vq->last_used_idx%vq->vring.num].id;
 	*len = vq->vring.used->ring[vq->last_used_idx%vq->vring.num].len;
 
-- 
1.6.5.rc2
