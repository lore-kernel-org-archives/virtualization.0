From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 01/10] drm/virtio: log error responses
Date: Wed, 19 Dec 2018 13:26:59 +0100
Message-ID: <20181219122708.4586-2-kraxel__12413.0893651911$1545222349$gmane$org@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181219122708.4586-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

If we got an error response code from the host, print it to the log.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index e27c4aedb8..6bc2008b0d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -192,8 +192,16 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 
 	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
 		resp = (struct virtio_gpu_ctrl_hdr *)entry->resp_buf;
-		if (resp->type != cpu_to_le32(VIRTIO_GPU_RESP_OK_NODATA))
-			DRM_DEBUG("response 0x%x\n", le32_to_cpu(resp->type));
+		if (resp->type != cpu_to_le32(VIRTIO_GPU_RESP_OK_NODATA)) {
+			if (resp->type >= cpu_to_le32(VIRTIO_GPU_RESP_ERR_UNSPEC)) {
+				struct virtio_gpu_ctrl_hdr *cmd;
+				cmd = (struct virtio_gpu_ctrl_hdr *)entry->buf;
+				DRM_ERROR("response 0x%x (command 0x%x)\n",
+					  le32_to_cpu(resp->type),
+					  le32_to_cpu(cmd->type));
+			} else
+				DRM_DEBUG("response 0x%x\n", le32_to_cpu(resp->type));
+		}
 		if (resp->flags & cpu_to_le32(VIRTIO_GPU_FLAG_FENCE)) {
 			u64 f = le64_to_cpu(resp->fence_id);
 
-- 
2.9.3
