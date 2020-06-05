From: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH RESEND 4/5] vhost: replace -1 with VHOST_FILE_UNBIND in iotcls
Date: Fri,  5 Jun 2020 18:27:14 +0800
Message-ID: <1591352835-22441-5-git-send-email-lingshan.zhu@intel.com>
References: <1591352835-22441-1-git-send-email-lingshan.zhu@intel.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1591352835-22441-1-git-send-email-lingshan.zhu@intel.com>
Sender: netdev-owner@vger.kernel.org
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jasowang@redhat.com
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com, Zhu Lingshan <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This commit replaces -1 with VHOST_FILE_UNBIND in ioctls since
we have added such a macro in the uapi header for vdpa_host.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d450e16..8ba3ed2 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1574,7 +1574,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 			r = -EFAULT;
 			break;
 		}
-		eventfp = f.fd == -1 ? NULL : eventfd_fget(f.fd);
+		eventfp = f.fd == VHOST_FILE_UNBIND ? NULL : eventfd_fget(f.fd);
 		if (IS_ERR(eventfp)) {
 			r = PTR_ERR(eventfp);
 			break;
@@ -1590,7 +1590,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 			r = -EFAULT;
 			break;
 		}
-		ctx = f.fd == -1 ? NULL : eventfd_ctx_fdget(f.fd);
+		ctx = f.fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(f.fd);
 		if (IS_ERR(ctx)) {
 			r = PTR_ERR(ctx);
 			break;
@@ -1602,7 +1602,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 			r = -EFAULT;
 			break;
 		}
-		ctx = f.fd == -1 ? NULL : eventfd_ctx_fdget(f.fd);
+		ctx = f.fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(f.fd);
 		if (IS_ERR(ctx)) {
 			r = PTR_ERR(ctx);
 			break;
@@ -1727,7 +1727,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		r = get_user(fd, (int __user *)argp);
 		if (r < 0)
 			break;
-		ctx = fd == -1 ? NULL : eventfd_ctx_fdget(fd);
+		ctx = fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
 		if (IS_ERR(ctx)) {
 			r = PTR_ERR(ctx);
 			break;
-- 
1.8.3.1
