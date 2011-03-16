From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH] virtio: Decrement avail idx on buffer detach
Date: Wed, 16 Mar 2011 19:12:10 +0530
Message-ID: <a2fe5813ccecf1e762670702cba8ccb2a4cb8cfc.1300282928.git.amit.shah__49606.6326195889$1300283092$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, stable@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

When detaching a buffer from a vq, the avail.idx value should be
decremented as well.

This was noticed by hot-unplugging a virtio console port and then
plugging in a new one on the same number (re-using the vqs which were
just 'disowned').  qemu reported

   'Guest moved used index from 0 to 256'

when any IO was attempted on the new port.

CC: stable@kernel.org
Reported-by: juzhang <juzhang@redhat.com>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/virtio/virtio_ring.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cc2f73e..b0043fb 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -371,6 +371,7 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->data[i];
 		detach_buf(vq, i);
+		vq->vring.avail->idx--;
 		END_USE(vq);
 		return buf;
 	}
-- 
1.7.4
