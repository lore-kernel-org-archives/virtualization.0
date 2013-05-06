From: Asias He <asias@redhat.com>
Subject: [PATCH 2/2] vhost-net: Free ubuf when vhost_dev_set_owner fails
Date: Mon,  6 May 2013 11:16:00 +0800
Message-ID: <1367810160-28178-3-git-send-email-asias__21481.9365567111$1367810193$gmane$org@redhat.com>
References: <1367810160-28178-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367810160-28178-1-git-send-email-asias@redhat.com>
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

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/net.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index a3645bd..354665a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -146,6 +146,19 @@ void vhost_ubuf_put_and_wait(struct vhost_ubuf_ref *ubufs)
 	kfree(ubufs);
 }
 
+static void vhost_net_clear_ubuf_info(struct vhost_net *n)
+{
+
+	bool zcopy;
+	int i;
+
+	for (i = 0; i < n->dev.nvqs; ++i) {
+		zcopy = vhost_zcopy_mask & (0x1 << i);
+		if (zcopy)
+			kfree(n->vqs[i].ubuf_info);
+	}
+}
+
 int vhost_net_set_ubuf_info(struct vhost_net *n)
 {
 	bool zcopy;
@@ -1027,6 +1040,23 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 	return 0;
 }
 
+static long vhost_net_set_owner(struct vhost_net *n)
+{
+	int r;
+
+	mutex_lock(&n->dev.mutex);
+	r = vhost_net_set_ubuf_info(n);
+	if (r)
+		goto out;
+	r = vhost_dev_set_owner(&n->dev);
+	if (r)
+		vhost_net_clear_ubuf_info(n);
+	vhost_net_flush(n);
+out:
+	mutex_unlock(&n->dev.mutex);
+	return r;
+}
+
 static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			    unsigned long arg)
 {
@@ -1055,19 +1085,15 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 		return vhost_net_set_features(n, features);
 	case VHOST_RESET_OWNER:
 		return vhost_net_reset_owner(n);
+	case VHOST_SET_OWNER:
+		return vhost_net_set_owner(n);
 	default:
 		mutex_lock(&n->dev.mutex);
-		if (ioctl == VHOST_SET_OWNER) {
-			r = vhost_net_set_ubuf_info(n);
-			if (r)
-				goto out;
-		}
 		r = vhost_dev_ioctl(&n->dev, ioctl, argp);
 		if (r == -ENOIOCTLCMD)
 			r = vhost_vring_ioctl(&n->dev, ioctl, argp);
 		else
 			vhost_net_flush(n);
-out:
 		mutex_unlock(&n->dev.mutex);
 		return r;
 	}
-- 
1.8.1.4
