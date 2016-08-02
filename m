From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0213/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:50:15 +0800
Message-ID: <20160802105015.27957-1-baolex.ni@intel.com>
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
To: airlied@linux.ie, kraxel@redhat.com, kyungmin.park@samsung.com, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, baolex.ni@intel.com, alexander.deucher@amd.com, chuansheng.liu@intel.com, ville.syrjala@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 3cc7afa..d40bc45 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -38,7 +38,7 @@ static struct drm_driver driver;
 static int virtio_gpu_modeset = -1;
 
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
-module_param_named(modeset, virtio_gpu_modeset, int, 0400);
+module_param_named(modeset, virtio_gpu_modeset, int, S_IRUSR);
 
 static int virtio_gpu_probe(struct virtio_device *vdev)
 {
-- 
2.9.2
