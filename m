From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] virtio: fix possible memory leak in virtqueue_add()
Date: Tue,  2 Aug 2016 13:59:05 +0000
Message-ID: <1470146345-19531-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

desc may malloced in virtqueue_add() and should be freed before
leaving from the error handling cases, otherwise it will cause
memory leak.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/virtio/virtio_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 114a0c8..bda71ef 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -328,6 +328,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 		if (out_sgs)
 			vq->notify(&vq->vq);
 		END_USE(vq);
+		kfree(desc);
 		return -ENOSPC;
 	}
