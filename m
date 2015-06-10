From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] drm/virtio: remove some dead code
Date: Wed, 10 Jun 2015 22:27:51 +0300
Message-ID: <20150610192751.GB10145__48740.8559689813$1433964499$gmane$org@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@linux.ie>
Cc: kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The goto is correct, and we never reach the return statement so just
delete the dead code.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index e0e74c6..b092d7b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -443,14 +443,12 @@ int virtio_gpu_ttm_init(struct virtio_gpu_device *vgdev)
 	if (r) {
 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
 		goto err_dev_init;
-		return r;
 	}
 
 	r = ttm_bo_init_mm(&vgdev->mman.bdev, TTM_PL_TT, 0);
 	if (r) {
 		DRM_ERROR("Failed initializing GTT heap.\n");
 		goto err_mm_init;
-		return r;
 	}
 	return 0;
