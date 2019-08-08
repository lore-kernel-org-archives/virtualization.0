From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 07/17] drm/shmem: drop DEFINE_DRM_GEM_SHMEM_FOPS
Date: Thu,  8 Aug 2019 15:44:07 +0200
Message-ID: <20190808134417.10610-8-kraxel@redhat.com>
References: <20190808134417.10610-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190808134417.10610-1-kraxel@redhat.com>
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
Cc: Rob Herring <robh@kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, tzimmermann@suse.de, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Eric Anholt <eric@anholt.net>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

DEFINE_DRM_GEM_SHMEM_FOPS is identical to DEFINE_DRM_GEM_FOPS now,
drop it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_shmem_helper.h      | 26 -------------------------
 drivers/gpu/drm/cirrus/cirrus.c         |  2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
 drivers/gpu/drm/v3d/v3d_drv.c           |  2 +-
 4 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 0f7b77cdc26b..813240dcfe17 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -85,32 +85,6 @@ struct drm_gem_shmem_object {
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
index 36a69aec8a4b..9438af468331 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -510,7 +510,7 @@ static void cirrus_mode_config_init(struct cirrus_device *cirrus)
 
 /* ------------------------------------------------------------------ */
 
-DEFINE_DRM_GEM_SHMEM_FOPS(cirrus_fops);
+DEFINE_DRM_GEM_FOPS(cirrus_fops);
 
 static struct drm_driver cirrus_driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index b187daa4da85..1c07e1c3386e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -386,7 +386,7 @@ static const struct drm_ioctl_desc panfrost_drm_driver_ioctls[] = {
 	PANFROST_IOCTL(PERFCNT_DUMP,	perfcnt_dump,	DRM_RENDER_ALLOW),
 };
 
-DEFINE_DRM_GEM_SHMEM_FOPS(panfrost_drm_driver_fops);
+DEFINE_DRM_GEM_FOPS(panfrost_drm_driver_fops);
 
 static struct drm_driver panfrost_drm_driver = {
 	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 3506ae2723ae..03e4fbe1b92b 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -169,7 +169,7 @@ v3d_postclose(struct drm_device *dev, struct drm_file *file)
 	kfree(v3d_priv);
 }
 
-DEFINE_DRM_GEM_SHMEM_FOPS(v3d_drm_fops);
+DEFINE_DRM_GEM_FOPS(v3d_drm_fops);
 
 /* DRM_AUTH is required on SUBMIT_CL for now, while we don't have GMP
  * protection between clients.  Note that render nodes would be be
-- 
2.18.1
