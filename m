From: Gustavo Padovan <gustavo@padovan.org>
Subject: [RFC 2/5] drm/virtio: add uapi for in and out explicit fences
Date: Mon, 12 Dec 2016 18:48:26 -0200
Message-ID: <1481575710-12535-2-git-send-email-gustavo@padovan.org>
References: <1481575710-12535-1-git-send-email-gustavo@padovan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481575710-12535-1-git-send-email-gustavo@padovan.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, robdclark@gmail.com, Gustavo Padovan <gustavo.padovan@collabora.co.uk>
List-Id: virtualization@lists.linuxfoundation.org

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Add a new field called fence_fd that will be used by userspace to send
in-fences to the kernel and receive out-fences created by the kernel.

This uapi enables virtio to take advantage of explicit synchronization of
dma-bufs.

There are two new flags:

* VIRTGPU_EXECBUF_FENCE_FD_IN to be used when passing an in-fence fd.
* VIRTGPU_EXECBUF_FENCE_FD_OUT to be used when requesting an out-fence fd

The execbuffer IOCTL is now read-write to allow the userspace to read the
out-fence.

On error -1 should be returned in the fence_fd field.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  2 ++
 include/uapi/drm/virtgpu_drm.h         | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index da281103..d164b54 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -113,6 +113,8 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	struct ww_acquire_ctx ticket;
 	void *buf;
 
+	exbuf->fence_fd = -1;
+
 	if (vgdev->has_virgl_3d == false)
 		return -ENOSYS;
 
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 91a31ff..d1d69be 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -47,6 +47,13 @@ extern "C" {
 #define DRM_VIRTGPU_WAIT     0x08
 #define DRM_VIRTGPU_GET_CAPS  0x09
 
+#define VIRTGPU_EXECBUF_FENCE_FD_IN	0x01
+#define VIRTGPU_EXECBUF_FENCE_FD_OUT	0x02
+#define VIRTGPU_EXECBUF_FLAGS  (\
+		VIRTGPU_EXECBUF_FENCE_FD_IN |\
+		VIRTGPU_EXECBUF_FENCE_FD_OUT |\
+		0)
+
 struct drm_virtgpu_map {
 	__u64 offset; /* use for mmap system call */
 	__u32 handle;
@@ -54,12 +61,12 @@ struct drm_virtgpu_map {
 };
 
 struct drm_virtgpu_execbuffer {
-	__u32		flags;		/* for future use */
+	__u32 flags;
 	__u32 size;
 	__u64 command; /* void* */
 	__u64 bo_handles;
 	__u32 num_bo_handles;
-	__u32 pad;
+	__s32 fence_fd;
 };
 
 #define VIRTGPU_PARAM_3D_FEATURES 1 /* do we have 3D features in the hw */
@@ -136,7 +143,7 @@ struct drm_virtgpu_get_caps {
 	DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_MAP, struct drm_virtgpu_map)
 
 #define DRM_IOCTL_VIRTGPU_EXECBUFFER \
-	DRM_IOW(DRM_COMMAND_BASE + DRM_VIRTGPU_EXECBUFFER,\
+	DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_EXECBUFFER,\
 		struct drm_virtgpu_execbuffer)
 
 #define DRM_IOCTL_VIRTGPU_GETPARAM \
-- 
2.5.5
