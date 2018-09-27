From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net V2] vhost-vsock: fix use after free
Date: Thu, 27 Sep 2018 20:22:04 +0800
Message-ID: <20180927122204.4188-1-jasowang__11616.5016116158$1538050814$gmane$org@redhat.com>
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
To: stefanha@redhat.com, mst@redhat.com
Cc: kvm@vger.kernel.org, sergei.shtylyov@cogentembedded.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The access of vsock is not protected by vhost_vsock_lock. This may
lead to use after free since vhost_vsock_dev_release() may free the
pointer at the same time.

Fix this by holding the lock during the access.

Reported-by: syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com
Fixes: 16320f363ae1 ("vhost-vsock: add pkt cancel capability")
Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
- V2: fix typos
- The patch is needed for -stable.
---
 drivers/vhost/vsock.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 34bc3ab40c6d..7d0b292867fd 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -210,21 +210,27 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt *pkt)
 	struct vhost_vsock *vsock;
 	int len = pkt->len;
 
+	spin_lock_bh(&vhost_vsock_lock);
+
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(le64_to_cpu(pkt->hdr.dst_cid));
+	vsock = __vhost_vsock_get(le64_to_cpu(pkt->hdr.dst_cid));
 	if (!vsock) {
 		virtio_transport_free_pkt(pkt);
+		spin_unlock_bh(&vhost_vsock_lock);
 		return -ENODEV;
 	}
 
 	if (pkt->reply)
 		atomic_inc(&vsock->queued_replies);
 
-	spin_lock_bh(&vsock->send_pkt_list_lock);
+	spin_lock(&vsock->send_pkt_list_lock);
 	list_add_tail(&pkt->list, &vsock->send_pkt_list);
-	spin_unlock_bh(&vsock->send_pkt_list_lock);
+	spin_unlock(&vsock->send_pkt_list_lock);
 
 	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
+
+	spin_unlock_bh(&vhost_vsock_lock);
+
 	return len;
 }
 
@@ -236,18 +242,22 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	int cnt = 0;
 	LIST_HEAD(freeme);
 
+	spin_lock_bh(&vhost_vsock_lock);
+
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
-	if (!vsock)
+	vsock = __vhost_vsock_get(vsk->remote_addr.svm_cid);
+	if (!vsock) {
+		spin_unlock_bh(&vhost_vsock_lock);
 		return -ENODEV;
+	}
 
-	spin_lock_bh(&vsock->send_pkt_list_lock);
+	spin_lock(&vsock->send_pkt_list_lock);
 	list_for_each_entry_safe(pkt, n, &vsock->send_pkt_list, list) {
 		if (pkt->vsk != vsk)
 			continue;
 		list_move(&pkt->list, &freeme);
 	}
-	spin_unlock_bh(&vsock->send_pkt_list_lock);
+	spin_unlock(&vsock->send_pkt_list_lock);
 
 	list_for_each_entry_safe(pkt, n, &freeme, list) {
 		if (pkt->reply)
@@ -265,6 +275,8 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 			vhost_poll_queue(&tx_vq->poll);
 	}
 
+	spin_unlock_bh(&vhost_vsock_lock);
+
 	return 0;
 }
 
-- 
2.17.1
