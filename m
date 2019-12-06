From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost/vsock: accept only packets with the right dst_cid
Date: Fri,  6 Dec 2019 15:39:12 +0100
Message-ID: <20191206143912.153583-1-sgarzare__1103.58329709328$1575643177$gmane$org@redhat.com>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

When we receive a new packet from the guest, we check if the
src_cid is correct, but we forgot to check the dst_cid.

The host should accept only packets where dst_cid is
equal to the host CID.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 50de0642dea6..c2d7d57e98cf 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -480,7 +480,9 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 		virtio_transport_deliver_tap_pkt(pkt);
 
 		/* Only accept correctly addressed packets */
-		if (le64_to_cpu(pkt->hdr.src_cid) == vsock->guest_cid)
+		if (le64_to_cpu(pkt->hdr.src_cid) == vsock->guest_cid &&
+		    le64_to_cpu(pkt->hdr.dst_cid) ==
+		    vhost_transport_get_local_cid())
 			virtio_transport_recv_pkt(&vhost_transport, pkt);
 		else
 			virtio_transport_free_pkt(pkt);
-- 
2.23.0
