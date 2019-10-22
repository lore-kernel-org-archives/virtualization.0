From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/5] drm/virtio: fix byteorder handling in
	virtio_gpu_cmd_transfer_{from, to}_host_3d functions
Date: Tue, 22 Oct 2019 10:05:44 +0200
Message-ID: <20191022080546.19769-4-kraxel__40160.0447062933$1571731581$gmane$org@redhat.com>
References: <20191022080546.19769-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191022080546.19769-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

Be consistent with the rest of the code base.
No functional change.

In theory this change is incompatible on bigendian machines,
but in practice 3d acceleration is supported only on little
endian machines, so the affected code paths never run on
bigendian machines.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 74ad3bc3ebe8..0bf60914ece2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -987,7 +987,12 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D);
 	cmd_p->hdr.ctx_id = cpu_to_le32(ctx_id);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
-	cmd_p->box = *box;
+	cmd_p->box.x = cpu_to_le32(box->x);
+	cmd_p->box.y = cpu_to_le32(box->y);
+	cmd_p->box.z = cpu_to_le32(box->z);
+	cmd_p->box.w = cpu_to_le32(box->w);
+	cmd_p->box.h = cpu_to_le32(box->h);
+	cmd_p->box.d = cpu_to_le32(box->d);
 	cmd_p->offset = cpu_to_le64(offset);
 	cmd_p->level = cpu_to_le32(level);
 
@@ -1013,7 +1018,12 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D);
 	cmd_p->hdr.ctx_id = cpu_to_le32(ctx_id);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
-	cmd_p->box = *box;
+	cmd_p->box.x = cpu_to_le32(box->x);
+	cmd_p->box.y = cpu_to_le32(box->y);
+	cmd_p->box.z = cpu_to_le32(box->z);
+	cmd_p->box.w = cpu_to_le32(box->w);
+	cmd_p->box.h = cpu_to_le32(box->h);
+	cmd_p->box.d = cpu_to_le32(box->d);
 	cmd_p->offset = cpu_to_le64(offset);
 	cmd_p->level = cpu_to_le32(level);
 
-- 
2.18.1
