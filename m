From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 05/11] drm/shmem: drop DEFINE_DRM_GEM_SHMEM_FOPS
Date: Wed, 16 Oct 2019 13:51:57 +0200
Message-ID: <20191016115203.20095-6-kraxel@redhat.com>
References: <20191016115203.20095-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191016115203.20095-1-kraxel@redhat.com>
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
Cc: Rob Herring <robh@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>, Steven Price <steven.price@arm.com>, Hans de Goede <hdegoede@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Sean Paul <sean@poorly.run>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

DEFINE_DRM_GEM_SHMEM_FOPS is identical
to DEFINE_DRM_GEM_FOPS now, drop it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/drm/drm_gem_shmem_helper.h      | 26 -------------------------
 drivers/gpu/drm/cirrus/cirrus.c         |  2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
 drivers/gpu/drm/tiny/gm12u320.c         |  2 +-
 drivers/gpu/drm/v3d/v3d_drv.c           |  2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c    |  2 +-
 6 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index d89f2116c8ab..6748379a0b44 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -88,32 +88,6 @@ struct drm_gem_shmem_object {
 #define to_drm_gem_shmem_obj(obj) \
 	container_of(obj, struct drm_gem_shmem_object, base)
 
-/**
- * DEFINE_DRM_GEM_SHMEM_FOPS() - Macro to generate file operations for shmem drivers
- * @name: name for the generated structure
- *
- * This macro autogenerates a suitable &struct file_operations for shmem based
- * drivers, which can be assigned to &drm_driver.fops. Note that this structure
- * cannot be shared between drivers, because it contains a reference to the
- * current module using THIS_MODULE.
- *
- * Note that the declaration is already marked as static - if you need a
- * non-static version of this you're probably doing it wrong and will break the
- * THIS_MODULE reference by accident.
- */
-#define DEFINE_DRM_GEM_SHMEM_FOPS(name) \
-	static const struct file_operations name = {\
-		.owner		= THIS_MODULE,\
-		.open		= drm_open,\
-		.release	= drm_release,\
-		.unlocked_ioctl	= drm_ioctl,\
-		.compat_ioctl	= drm_compat_ioctl,\
-		.poll		= drm_poll,\
-		.read		= drm_read,\
-		.llseek		= noop_llseek,\
-		.mmap		= drm_gem_mmap, \
-	}
-
 struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
 void drm_gem_shmem_free_object(struct drm_gem_object *obj);
 
diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index 89d9e6fdeb8c..7d08d067e1a4 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -510,7 +510,7 @@ static void cirrus_mode_config_init(struct cirrus_device *cirrus)
 
 /* ------------------------------------------------------------------ */
 
-DEFINE_DRM_GEM_SHMEM_FOPS(cirrus_fops);
+DEFINE_DRM_GEM_FOPS(cirrus_fops);
 
 static struct drm_driver cirrus_driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index bc2ddeb55f5d..9d086133a84e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -470,7 +470,7 @@ static const struct drm_ioctl_desc panfrost_drm_driver_ioctls[] = {
 	PANFROST_IOCTL(MADVISE,		madvise,	DRM_RENDER_ALLOW),
 };
 
-DEFINE_DRM_GEM_SHMEM_FOPS(panfrost_drm_driver_fops);
+DEFINE_DRM_GEM_FOPS(panfrost_drm_driver_fops);
 
 /*
  * Panfrost driver version:
diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index 03d0e2df6774..94fb1f593564 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -649,7 +649,7 @@ static void gm12u320_driver_release(struct drm_device *dev)
 	kfree(gm12u320);
 }
 
-DEFINE_DRM_GEM_SHMEM_FOPS(gm12u320_fops);
+DEFINE_DRM_GEM_FOPS(gm12u320_fops);
 
 static struct drm_driver gm12u320_drm_driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index e94bf75368be..1a07462b4528 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -172,7 +172,7 @@ v3d_postclose(struct drm_device *dev, struct drm_file *file)
 	kfree(v3d_priv);
 }
 
-DEFINE_DRM_GEM_SHMEM_FOPS(v3d_drm_fops);
+DEFINE_DRM_GEM_FOPS(v3d_drm_fops);
 
 /* DRM_AUTH is required on SUBMIT_CL for now, while we don't have GMP
  * protection between clients.  Note that render nodes would be be
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index a5cb58754f7d..8dee698c90ff 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -184,7 +184,7 @@ MODULE_AUTHOR("Dave Airlie <airlied@redhat.com>");
 MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
 MODULE_AUTHOR("Alon Levy");
 
-DEFINE_DRM_GEM_SHMEM_FOPS(virtio_gpu_driver_fops);
+DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);
 
 static struct drm_driver driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC,
-- 
2.18.1
