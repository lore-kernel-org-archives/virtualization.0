From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/virtio: move drm_connector_update_edid_property() call
Date: Fri,  5 Apr 2019 06:46:02 +0200
Message-ID: <20190405044602.2334-1-kraxel__48149.5744477556$1554439602$gmane$org@redhat.com>
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
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, jcmvbkbc@gmail.com, Daniel Vetter <daniel@ffwll.ch>
List-Id: virtualization@lists.linuxfoundation.org

drm_connector_update_edid_property can sleep, we must not
call it while holding a spinlock.  Move the callsize.

Reported-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index e62fe24b1a2e..5bb0f0a084e9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -619,11 +619,11 @@ static void virtio_gpu_cmd_get_edid_cb(struct virtio_gpu_device *vgdev,
 	output = vgdev->outputs + scanout;
 
 	new_edid = drm_do_get_edid(&output->conn, virtio_get_edid_block, resp);
+	drm_connector_update_edid_property(&output->conn, new_edid);
 
 	spin_lock(&vgdev->display_info_lock);
 	old_edid = output->edid;
 	output->edid = new_edid;
-	drm_connector_update_edid_property(&output->conn, output->edid);
 	spin_unlock(&vgdev->display_info_lock);
 
 	kfree(old_edid);
-- 
2.18.1
