From: Asias He <asias@redhat.com>
Subject: [PATCH 4/4] vhost: Remove custom vhost rcu usage
Date: Tue,  7 May 2013 14:54:36 +0800
Message-ID: <1367909676-11788-5-git-send-email-asias__20160.3952482857$1367909717$gmane$org@redhat.com>
References: <1367909676-11788-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367909676-11788-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Now, vq->private_data is always accessed under vq mutex. No need to play
the vhost rcu trick.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/net.c   | 16 ++++++----------
 drivers/vhost/scsi.c  |  6 ++----
 drivers/vhost/test.c  | 11 ++++-------
 drivers/vhost/vhost.h | 10 ++--------
 4 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b616d9a..05bdc3c 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -15,7 +15,6 @@
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
-#include <linux/rcupdate.h>
 #include <linux/file.h>
 #include <linux/slab.h>
 
@@ -751,8 +750,7 @@ static int vhost_net_enable_vq(struct vhost_net *n,
 	struct vhost_poll *poll = n->poll + (nvq - n->vqs);
 	struct socket *sock;
 
-	sock = rcu_dereference_protected(vq->private_data,
-					 lockdep_is_held(&vq->mutex));
+	sock = vq->private_data;
 	if (!sock)
 		return 0;
 
@@ -765,10 +763,9 @@ static struct socket *vhost_net_stop_vq(struct vhost_net *n,
 	struct socket *sock;
 
 	mutex_lock(&vq->mutex);
-	sock = rcu_dereference_protected(vq->private_data,
-					 lockdep_is_held(&vq->mutex));
+	sock = vq->private_data;
 	vhost_net_disable_vq(n, vq);
-	rcu_assign_pointer(vq->private_data, NULL);
+	vq->private_data = NULL;
 	mutex_unlock(&vq->mutex);
 	return sock;
 }
@@ -924,8 +921,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	}
 
 	/* start polling new socket */
-	oldsock = rcu_dereference_protected(vq->private_data,
-					    lockdep_is_held(&vq->mutex));
+	oldsock = vq->private_data;
 	if (sock != oldsock) {
 		ubufs = vhost_net_ubuf_alloc(vq,
 					     sock && vhost_sock_zcopy(sock));
@@ -935,7 +931,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 		}
 
 		vhost_net_disable_vq(n, vq);
-		rcu_assign_pointer(vq->private_data, sock);
+		vq->private_data = sock;
 		r = vhost_init_used(vq);
 		if (r)
 			goto err_used;
@@ -969,7 +965,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	return 0;
 
 err_used:
-	rcu_assign_pointer(vq->private_data, oldsock);
+	vq->private_data = oldsock;
 	vhost_net_enable_vq(n, vq);
 	if (ubufs)
 		vhost_net_ubuf_put_and_wait(ubufs);
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index d78768b..de6d817 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1223,9 +1223,8 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 		       sizeof(vs->vs_vhost_wwpn));
 		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
 			vq = &vs->vqs[i].vq;
-			/* Flushing the vhost_work acts as synchronize_rcu */
 			mutex_lock(&vq->mutex);
-			rcu_assign_pointer(vq->private_data, vs_tpg);
+			vq->private_data = vs_tpg;
 			vhost_init_used(vq);
 			mutex_unlock(&vq->mutex);
 		}
@@ -1304,9 +1303,8 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
 	if (match) {
 		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
 			vq = &vs->vqs[i].vq;
-			/* Flushing the vhost_work acts as synchronize_rcu */
 			mutex_lock(&vq->mutex);
-			rcu_assign_pointer(vq->private_data, NULL);
+			vq->private_data = NULL;
 			mutex_unlock(&vq->mutex);
 		}
 	}
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 435b911..5f23477 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
-#include <linux/rcupdate.h>
 #include <linux/file.h>
 #include <linux/slab.h>
 
@@ -139,9 +138,8 @@ static void *vhost_test_stop_vq(struct vhost_test *n,
 	void *private;
 
 	mutex_lock(&vq->mutex);
-	private = rcu_dereference_protected(vq->private_data,
-					 lockdep_is_held(&vq->mutex));
-	rcu_assign_pointer(vq->private_data, NULL);
+	private = vq->private_data;
+	vq->private_data = NULL;
 	mutex_unlock(&vq->mutex);
 	return private;
 }
@@ -205,9 +203,8 @@ static long vhost_test_run(struct vhost_test *n, int test)
 		priv = test ? n : NULL;
 
 		/* start polling new socket */
-		oldpriv = rcu_dereference_protected(vq->private_data,
-						    lockdep_is_held(&vq->mutex));
-		rcu_assign_pointer(vq->private_data, priv);
+		oldpriv = vq->private_data;
+		vq->private_data = priv;
 
 		r = vhost_init_used(&n->vqs[index].vq);
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 51aeb5f..2a8c655 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -103,14 +103,8 @@ struct vhost_virtqueue {
 	struct iovec iov[UIO_MAXIOV];
 	struct iovec *indirect;
 	struct vring_used_elem *heads;
-	/* We use a kind of RCU to access private pointer.
-	 * All readers access it from worker, which makes it possible to
-	 * flush the vhost_work instead of synchronize_rcu. Therefore readers do
-	 * not need to call rcu_read_lock/rcu_read_unlock: the beginning of
-	 * vhost_work execution acts instead of rcu_read_lock() and the end of
-	 * vhost_work execution acts instead of rcu_read_unlock().
-	 * Writers use virtqueue mutex. */
-	void __rcu *private_data;
+	/* Protected by virtqueue mutex. */
+	void *private_data;
 	/* Log write descriptors */
 	void __user *log_base;
 	struct vhost_log *log;
-- 
1.8.1.4
