From: davidriley@chromium.org
Subject: [PATCH v2 1/4] drm/virtio: Ensure cached capset entries are valid
	before copying.
Date: Mon, 10 Jun 2019 14:18:07 -0700
Message-ID: <20190610211810.253227-2-davidriley__28624.6138204419$1560201516$gmane$org@chromium.org>
References: <20190605234423.11348-1-davidriley@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190605234423.11348-1-davidriley@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
List-Id: virtualization@lists.linuxfoundation.org

From: David Riley <davidriley@chromium.org>

virtio_gpu_get_caps_ioctl could return success with invalid data if a
second caller to the function occurred after the entry was created in
virtio_gpu_cmd_get_capset but prior to the virtio_gpu_cmd_capset_cb
callback being called.  This could leak contents of memory as well
since the caps_cache allocation is done without zeroing.

Signed-off-by: David Riley <davidriley@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 949a264985fc..88c1ed57a3c5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -526,7 +526,6 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 	list_for_each_entry(cache_ent, &vgdev->cap_cache, head) {
 		if (cache_ent->id == args->cap_set_id &&
 		    cache_ent->version == args->cap_set_ver) {
-			ptr = cache_ent->caps_cache;
 			spin_unlock(&vgdev->display_info_lock);
 			goto copy_exit;
 		}
@@ -537,6 +536,7 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 	virtio_gpu_cmd_get_capset(vgdev, found_valid, args->cap_set_ver,
 				  &cache_ent);
 
+copy_exit:
 	ret = wait_event_timeout(vgdev->resp_wq,
 				 atomic_read(&cache_ent->is_valid), 5 * HZ);
 	if (!ret)
@@ -544,7 +544,6 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 
 	ptr = cache_ent->caps_cache;
 
-copy_exit:
 	if (copy_to_user((void __user *)(unsigned long)args->addr, ptr, size))
 		return -EFAULT;
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
