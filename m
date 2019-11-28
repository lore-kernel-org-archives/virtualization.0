From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 3/3] vhost/vsock: use netns of process that opens the
 vhost-vsock device
Date: Thu, 28 Nov 2019 18:15:19 +0100
Message-ID: <20191128171519.203979-4-sgarzare__49906.9674102188$1574961358$gmane$org@redhat.com>
References: <20191128171519.203979-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191128171519.203979-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: netdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch assigns the network namespace of the process that opened
vhost-vsock device (e.g. VMM) to the packets coming from the guest,
allowing only host sockets in the same network namespace to
communicate with the guest.

This patch also allows to have different VMs, running in different
network namespace, with the same CID.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vsock.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 31b0f3608752..e162b3604302 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -40,6 +40,7 @@ static DEFINE_READ_MOSTLY_HASHTABLE(vhost_vsock_hash, 8);
 struct vhost_vsock {
 	struct vhost_dev dev;
 	struct vhost_virtqueue vqs[2];
+	struct net *net;
 
 	/* Link to global vhost_vsock_hash, writes use vhost_vsock_mutex */
 	struct hlist_node hash;
@@ -61,7 +62,7 @@ static u32 vhost_transport_get_local_cid(void)
 /* Callers that dereference the return value must hold vhost_vsock_mutex or the
  * RCU read lock.
  */
-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
 {
 	struct vhost_vsock *vsock;
 
@@ -72,7 +73,7 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 		if (other_cid == 0)
 			continue;
 
-		if (other_cid == guest_cid)
+		if (other_cid == guest_cid && net_eq(net, vsock->net))
 			return vsock;
 
 	}
@@ -245,7 +246,7 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt *pkt)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(le64_to_cpu(pkt->hdr.dst_cid));
+	vsock = vhost_vsock_get(le64_to_cpu(pkt->hdr.dst_cid), pkt->net);
 	if (!vsock) {
 		rcu_read_unlock();
 		virtio_transport_free_pkt(pkt);
@@ -277,7 +278,8 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid,
+				sock_net(sk_vsock(vsk)));
 	if (!vsock)
 		goto out;
 
@@ -474,7 +476,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			continue;
 		}
 
-		pkt->net = vsock_default_net();
+		pkt->net = vsock->net;
 		len = pkt->len;
 
 		/* Deliver to monitoring devices all received packets */
@@ -606,7 +608,14 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	vqs = kmalloc_array(ARRAY_SIZE(vsock->vqs), sizeof(*vqs), GFP_KERNEL);
 	if (!vqs) {
 		ret = -ENOMEM;
-		goto out;
+		goto out_vsock;
+	}
+
+	/* Derive the network namespace from the pid opening the device */
+	vsock->net = get_net_ns_by_pid(current->pid);
+	if (IS_ERR(vsock->net)) {
+		ret = PTR_ERR(vsock->net);
+		goto out_vqs;
 	}
 
 	vsock->guest_cid = 0; /* no CID assigned yet */
@@ -628,7 +637,9 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	vhost_work_init(&vsock->send_pkt_work, vhost_transport_send_pkt_work);
 	return 0;
 
-out:
+out_vqs:
+	kfree(vqs);
+out_vsock:
 	vhost_vsock_free(vsock);
 	return ret;
 }
@@ -653,7 +664,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 */
 
 	/* If the peer is still valid, no need to reset connection */
-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk)))
 		return;
 
 	/* If the close timeout is pending, let it expire.  This avoids races
@@ -701,6 +712,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	spin_unlock_bh(&vsock->send_pkt_list_lock);
 
 	vhost_dev_cleanup(&vsock->dev);
+	put_net(vsock->net);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
 	return 0;
@@ -727,7 +739,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 
 	/* Refuse if CID is already in use */
 	mutex_lock(&vhost_vsock_mutex);
-	other = vhost_vsock_get(guest_cid);
+	other = vhost_vsock_get(guest_cid, vsock->net);
 	if (other && other != vsock) {
 		mutex_unlock(&vhost_vsock_mutex);
 		return -EADDRINUSE;
-- 
2.23.0
