From: Caspar Zhang <caspar@casparzhang.com>
Subject: [PATCH] Revert "vhost: fix release path lockdep checks"
Date: Fri, 17 Apr 2015 15:51:14 +0800
Message-ID: <ea63ebfa465bca23dc3d2c3261464ffd7360703c.1429256980.git.jinli.zjl__25844.733688473$1429284452$gmane$org@alibaba-inc.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Caspar Zhang <jinli.zjl@alibaba-inc.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This reverts commit ea5d404655ba3b356d0c06d6a3c4f24112124522.

In commit 47283bef7ed356629467d1fac61687756e48f254(vhost: move memory
pointer to VQs), rcu_ operation has been replaced by mutex, and original
issue fixed in sea5d404655 has gone as well, we need to remove the
no-longer-used `locked' var by reverting the orignal patch.

Signed-off-by: Caspar Zhang <jinli.zjl@alibaba-inc.com>

Conflicts:
	drivers/vhost/net.c
	drivers/vhost/vhost.c
	drivers/vhost/vhost.h

Signed-off-by: Caspar Zhang <jinli.zjl@alibaba-inc.com>
---
 drivers/vhost/net.c   | 2 +-
 drivers/vhost/vhost.c | 6 +++---
 drivers/vhost/vhost.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 7d137a4..26c4837 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -793,7 +793,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
 	vhost_dev_stop(&n->dev);
-	vhost_dev_cleanup(&n->dev, false);
+	vhost_dev_cleanup(&n->dev);
 	vhost_net_vq_reset(n);
 	if (tx_sock)
 		sockfd_put(tx_sock);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2ee2826..c6640d3 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -418,7 +418,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_memory *memory)
 {
 	int i;
 
-	vhost_dev_cleanup(dev, true);
+	vhost_dev_cleanup(dev);
 
 	/* Restore memory to default empty mapping. */
 	memory->nregions = 0;
@@ -444,8 +444,8 @@ void vhost_dev_stop(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_stop);
 
-/* Caller should have device mutex if and only if locked is set */
-void vhost_dev_cleanup(struct vhost_dev *dev, bool locked)
+/* Caller should have device mutex */
+void vhost_dev_cleanup(struct vhost_dev *dev)
 {
 	int i;
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 8c1c792..cc9a742 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -127,7 +127,7 @@ bool vhost_dev_has_owner(struct vhost_dev *dev);
 long vhost_dev_check_owner(struct vhost_dev *);
 struct vhost_memory *vhost_dev_reset_owner_prepare(void);
 void vhost_dev_reset_owner(struct vhost_dev *, struct vhost_memory *);
-void vhost_dev_cleanup(struct vhost_dev *, bool locked);
+void vhost_dev_cleanup(struct vhost_dev *);
 void vhost_dev_stop(struct vhost_dev *);
 long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
 long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp);
-- 
2.2.2
