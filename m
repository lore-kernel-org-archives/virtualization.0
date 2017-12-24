From: "=?UTF-8?B?5aS35YiZKENhc3Bhcik=?=" <jinli.zjl@alibaba-inc.com>
Subject: [PATCH] vhost: remove unused lock check flag in vhost_dev_cleanup()
Date: Mon, 25 Dec 2017 00:08:58 +0800
Message-ID: <57a32eb1fd105b2aacc96b7caae0d8336c010fe0.1514130393.git.jinli.zjl__11695.5723301091$1515606579$gmane$org@alibaba-inc.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?B?5aS35YiZKENhc3Bhcik=?= <jinli.zjl@alibaba-inc.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

In commit ea5d404655ba ("vhost: fix release path lockdep checks"),
Michael added a flag to check whether we should hold a lock in
vhost_dev_cleanup(), however, in commit 47283bef7ed3 ("vhost: move
memory pointer to VQs"), RCU operations have been replaced by
mutex, we can remove the no-longer-used `locked' parameter now.

Signed-off-by: Caspar Zhang <jinli.zjl@alibaba-inc.com>
---
 drivers/vhost/net.c   | 2 +-
 drivers/vhost/scsi.c  | 2 +-
 drivers/vhost/test.c  | 2 +-
 drivers/vhost/vhost.c | 5 ++---
 drivers/vhost/vhost.h | 2 +-
 drivers/vhost/vsock.c | 2 +-
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c7bdeb655646..a354d8d731e3 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -996,7 +996,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
 	vhost_dev_stop(&n->dev);
-	vhost_dev_cleanup(&n->dev, false);
+	vhost_dev_cleanup(&n->dev);
 	vhost_net_vq_reset(n);
 	if (tx_sock)
 		sockfd_put(tx_sock);
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 71517b3c5558..797d08916553 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1420,7 +1420,7 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
 	mutex_unlock(&vs->dev.mutex);
 	vhost_scsi_clear_endpoint(vs, &t);
 	vhost_dev_stop(&vs->dev);
-	vhost_dev_cleanup(&vs->dev, false);
+	vhost_dev_cleanup(&vs->dev);
 	/* Jobs can re-queue themselves in evt kick handler. Do extra flush. */
 	vhost_scsi_flush(vs);
 	kfree(vs->dev.vqs);
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 3cc98c07dcd3..906b8f0f19f7 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -157,7 +157,7 @@ static int vhost_test_release(struct inode *inode, struct file *f)
 
 	vhost_test_stop(n, &private);
 	vhost_test_flush(n);
-	vhost_dev_cleanup(&n->dev, false);
+	vhost_dev_cleanup(&n->dev);
 	/* We do an extra flush before freeing memory,
 	 * since jobs can re-queue themselves. */
 	vhost_test_flush(n);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 33ac2b186b85..014675c3d569 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -544,7 +544,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_umem *umem)
 {
 	int i;
 
-	vhost_dev_cleanup(dev, true);
+	vhost_dev_cleanup(dev);
 
 	/* Restore memory to default empty mapping. */
 	INIT_LIST_HEAD(&umem->umem_list);
@@ -611,8 +611,7 @@ static void vhost_clear_msg(struct vhost_dev *dev)
 	spin_unlock(&dev->iotlb_lock);
 }
 
-/* Caller should have device mutex if and only if locked is set */
-void vhost_dev_cleanup(struct vhost_dev *dev, bool locked)
+void vhost_dev_cleanup(struct vhost_dev *dev)
 {
 	int i;
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 79c6e7a60a5e..ff4d918e3e0a 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -181,7 +181,7 @@ bool vhost_dev_has_owner(struct vhost_dev *dev);
 long vhost_dev_check_owner(struct vhost_dev *);
 struct vhost_umem *vhost_dev_reset_owner_prepare(void);
 void vhost_dev_reset_owner(struct vhost_dev *, struct vhost_umem *);
-void vhost_dev_cleanup(struct vhost_dev *, bool locked);
+void vhost_dev_cleanup(struct vhost_dev *);
 void vhost_dev_stop(struct vhost_dev *);
 long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
 long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp);
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 5a5e981bd8e4..0d14e2ff19f1 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -599,7 +599,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	}
 	spin_unlock_bh(&vsock->send_pkt_list_lock);
 
-	vhost_dev_cleanup(&vsock->dev, false);
+	vhost_dev_cleanup(&vsock->dev);
 	kfree(vsock->dev.vqs);
 	vhost_vsock_free(vsock);
 	return 0;
-- 
2.15.1
