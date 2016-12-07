From: Peng Tao <bergwolf@gmail.com>
Subject: [PATCH 1/2] vhost-vsock: remove unused vq variable
Date: Wed,  7 Dec 2016 17:52:18 +0800
Message-ID: <1481104340-77035-1-git-send-email-bergwolf__37008.3416150466$1481136621$gmane$org@gmail.com>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, Peng Tao <bergwolf@gmail.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Peng Tao <bergwolf@gmail.com>
---
 drivers/vhost/vsock.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0c23b55..3e01d58 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -195,7 +195,6 @@ static int
 vhost_transport_send_pkt(struct virtio_vsock_pkt *pkt)
 {
 	struct vhost_vsock *vsock;
-	struct vhost_virtqueue *vq;
 	int len = pkt->len;
 
 	/* Find the vhost_vsock according to guest context id  */
@@ -205,8 +204,6 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt *pkt)
 		return -ENODEV;
 	}
 
-	vq = &vsock->vqs[VSOCK_VQ_RX];
-
 	if (pkt->reply)
 		atomic_inc(&vsock->queued_replies);
 
-- 
2.7.4
