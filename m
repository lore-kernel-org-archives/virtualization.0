From: Asias He <asias@redhat.com>
Subject: [PATCH 3/4] vhost-net: Free ubuf when vhost_dev_ioctl fails
Date: Fri,  3 May 2013 14:25:17 +0800
Message-ID: <1367562318-11989-4-git-send-email-asias@redhat.com>
References: <1367562318-11989-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367562318-11989-1-git-send-email-asias@redhat.com>
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

Free ubuf when vhost_dev_ioctl for VHOST_SET_OWNER fails.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/net.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b2f6b41..eb73217 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -152,6 +152,19 @@ void vhost_ubuf_put_and_wait(struct vhost_ubuf_ref *ubufs)
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
@@ -1069,10 +1082,13 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 				goto out;
 		}
 		r = vhost_dev_ioctl(&n->dev, ioctl, argp);
-		if (r == -ENOIOCTLCMD)
+		if (r == -ENOIOCTLCMD) {
 			r = vhost_vring_ioctl(&n->dev, ioctl, argp);
-		else
+		} else {
+			if (r < 0 && ioctl == VHOST_SET_OWNER)
+				vhost_net_clear_ubuf_info(n);
 			vhost_net_flush(n);
+		}
 out:
 		mutex_unlock(&n->dev.mutex);
 		return r;
-- 
1.8.1.4
