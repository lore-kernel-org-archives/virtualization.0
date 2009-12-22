From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] vhost: fix high 32 bit in FEATURES ioctls
Date: Tue, 22 Dec 2009 13:39:33 +0200
Message-ID: <20091222113933.GA16103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Stevens <dlstevens@us.ibm.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: David Stevens <dlstevens@us.ibm.com>
Subject: vhost: fix high 32 bit in FEATURES ioctls

VHOST_GET_FEATURES fails to initialize high-order 32 bits
in the returned value, and VHOST_SET_FEATURES fails to check them.
This patch fixes it to use 64 bits throughout.

Signed-off-by: David L Stevens <dlstevens@us.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

Rusty, can you queue this for 2.6.33 as well please?

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 22d5fef..d6db10c 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -563,7 +563,7 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 {
 	struct vhost_net *n = f->private_data;
 	void __user *argp = (void __user *)arg;
-	u32 __user *featurep = argp;
+	u64 __user *featurep = argp;
 	struct vhost_vring_file backend;
 	u64 features;
 	int r;
@@ -575,10 +575,9 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 		return vhost_net_set_backend(n, backend.index, backend.fd);
 	case VHOST_GET_FEATURES:
 		features = VHOST_FEATURES;
-		return put_user(features, featurep);
+		return copy_to_user(featurep, &features, sizeof features);
 	case VHOST_SET_FEATURES:
-		r = get_user(features, featurep);
-		/* No features for now */
+		r = copy_from_user(&features, featurep, sizeof features);
 		if (r < 0)
 			return r;
 		if (features & ~VHOST_FEATURES)
-- 
MST
