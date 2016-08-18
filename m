From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] virtio-gpu: Use memdup_user() rather than duplicating its
	implementation
Date: Thu, 18 Aug 2016 22:42:06 +0200
Message-ID: <401e68fc-5515-7a7a-be2e-503dee676b34__15075.44081328$1471553299$gmane$org@users.sourceforge.net>
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
To: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 18 Aug 2016 22:35:14 +0200

Reuse existing functionality from memdup_user() instead of keeping
duplicate source code.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index c046903..512e7cd 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -152,15 +152,10 @@ static int virtio_gpu_execbuffer(struct drm_device *dev,
 	if (ret)
 		goto out_free;
 
-	buf = kmalloc(exbuf->size, GFP_KERNEL);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto out_unresv;
-	}
-	if (copy_from_user(buf, (void __user *)(uintptr_t)exbuf->command,
-			   exbuf->size)) {
-		kfree(buf);
-		ret = -EFAULT;
+	buf = memdup_user((void __user *)(uintptr_t)exbuf->command,
+			  exbuf->size);
+	if (IS_ERR(buf)) {
+		ret = PTR_ERR(buf);
 		goto out_unresv;
 	}
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
-- 
2.9.3
