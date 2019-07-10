From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 03/11] drm/virtio: move
	drm_connector_update_edid_property() call
Date: Wed, 10 Jul 2019 11:02:30 -0400
Message-ID: <20190710150240.6984-3-sashal__41590.8251468622$1562771551$gmane$org@kernel.org>
References: <20190710150240.6984-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190710150240.6984-1-sashal@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Cornelia Huck <cohuck@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Max Filippov <jcmvbkbc@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Gerd Hoffmann <kraxel@redhat.com>

[ Upstream commit 41de4be6f6efa4132b29af51158cd672d93f2543 ]

drm_connector_update_edid_property can sleep, we must not
call it while holding a spinlock.  Move the callsite.

Fixes: b4b01b4995fb ("drm/virtio: add edid support")
Reported-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20190405044602.2334-1-kraxel@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 6bc2008b0d0d..3ef24f89ef93 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -620,11 +620,11 @@ static void virtio_gpu_cmd_get_edid_cb(struct virtio_gpu_device *vgdev,
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
2.20.1
