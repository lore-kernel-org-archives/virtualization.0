From: Pankaj Gupta <pagupta@redhat.com>
Subject: [PATCH v2 2/2] virtio_ring: packed ring: fix
	virtqueue_detach_unused_buf
Date: Thu,  8 Aug 2019 17:06:06 +0530
Message-ID: <20190808113606.19504-3-pagupta__7395.64516568265$1565264198$gmane$org@redhat.com>
References: <20190808113606.19504-1-pagupta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190808113606.19504-1-pagupta@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: amit@kernel.org, mst@redhat.com
Cc: pagupta@redhat.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch makes packed ring code compatible with split ring in function
'virtqueue_detach_unused_buf_*'.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/virtio/virtio_ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c8be1c4f5b55..1b98a6777b7e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1534,6 +1534,11 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
 	for (i = 0; i < vq->packed.vring.num; i++) {
 		if (!vq->packed.desc_state[i].data)
 			continue;
+		vq->packed.next_avail_idx--;
+		if (vq->packed.next_avail_idx < 0) {
+			vq->packed.next_avail_idx = vq->packed.vring.num - 1;
+			vq->packed.avail_wrap_counter ^= 1;
+		}
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->packed.desc_state[i].data;
 		detach_buf_packed(vq, i, NULL);
-- 
2.21.0
