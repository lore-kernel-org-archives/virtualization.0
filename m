From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 1/4] drm/simple-kms: Add drm_simple_encoder_{init, create}()
Date: Tue, 18 Feb 2020 09:48:12 +0100
Message-ID: <20200218084815.2137-2-tzimmermann@suse.de>
References: <20200218084815.2137-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200218084815.2137-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, kraxel@redhat.com, noralf@tronnes.org, sam@ravnborg.org, alexander.deucher@amd.com, emil.velikov@collabora.com
Cc: spice-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch makes the internal encoder implementation of the simple
KMS helpers available to drivers.

These simple-encoder helpers initialize an encoder with an empty
implementation. This covers the requirements of most of the existing
DRM drivers. A call to drm_simple_encoder_create() allocates and
initializes an encoder instance, a call to drm_simple_encoder_init()
initializes a pre-allocated instance.

v2:
	* move simple encoder to KMS helpers
	* remove name argument; simplifies implementation
	* don't allocate with devm_ interfaces; unsafe with DRM

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 83 ++++++++++++++++++++++++-
 include/drm/drm_simple_kms_helper.h     |  7 +++
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 15fb516ae2d8..745c2f34c42b 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -26,12 +26,90 @@
  * entity. Some flexibility for code reuse is provided through a separately
  * allocated &drm_connector object and supporting optional &drm_bridge
  * encoder drivers.
+ *
+ * Many drivers use an encoder with an empty implementation. Such encoders
+ * fulfill the minimum requirements of the display pipeline, but don't add
+ * additional functionality. The simple-encoder functions
+ * drm_simple_encoder_init() and drm_simple_encoder_create() provide an
+ * appropriate implementation.
  */
 
-static const struct drm_encoder_funcs drm_simple_kms_encoder_funcs = {
+static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup = {
 	.destroy = drm_encoder_cleanup,
 };
 
+/**
+ * drm_simple_encoder_init - Initialize a preallocated encoder
+ * @dev: drm device
+ * @funcs: callbacks for this encoder
+ * @encoder_type: user visible type of the encoder
+ *
+ * Initialises a preallocated encoder that has no further functionality. The
+ * encoder will be released automatically. Settings for possible CRTC and
+ * clones are left to their initial values. The encoder will be cleaned up
+ * automatically as part of the mode-setting cleanup.
+ *
+ * Also see drm_simple_encoder_create().
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int drm_simple_encoder_init(struct drm_device *dev,
+			    struct drm_encoder *encoder,
+			    int encoder_type)
+{
+	return drm_encoder_init(dev, encoder,
+				&drm_simple_encoder_funcs_cleanup,
+				encoder_type, NULL);
+}
+EXPORT_SYMBOL(drm_simple_encoder_init);
+
+static void drm_encoder_destroy(struct drm_encoder *encoder)
+{
+	drm_encoder_cleanup(encoder);
+	kfree(encoder);
+}
+
+static const struct drm_encoder_funcs drm_simple_encoder_funcs_destroy = {
+	.destroy = drm_encoder_destroy,
+};
+
+/**
+ * drm_simple_encoder_create - Allocate and initialize an encoder
+ * @dev: drm device
+ * @encoder_type: user visible type of the encoder
+ *
+ * Allocates and initialises an encoder that has no further functionality. The
+ * encoder will be destroyed automatically as part of the mode-setting cleanup.
+ *
+ * See drm_simple_encoder_init() for more information.
+ *
+ * Returns:
+ * The encoder on success, a pointer-encoder error code on failure.
+ */
+struct drm_encoder *drm_simple_encoder_create(struct drm_device *dev,
+					      int encoder_type)
+{
+	struct drm_encoder *encoder;
+	int ret;
+
+	encoder = kzalloc(sizeof(*encoder), GFP_KERNEL);
+	if (!encoder)
+		return ERR_PTR(-ENOMEM);
+	ret = drm_encoder_init(dev, encoder,
+			       &drm_simple_encoder_funcs_destroy,
+			       encoder_type, NULL);
+	if (ret)
+		goto err_kfree;
+
+	return encoder;
+
+err_kfree:
+	kfree(encoder);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(drm_simple_encoder_create);
+
 static enum drm_mode_status
 drm_simple_kms_crtc_mode_valid(struct drm_crtc *crtc,
 			       const struct drm_display_mode *mode)
@@ -288,8 +366,7 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
 		return ret;
 
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
-	ret = drm_encoder_init(dev, encoder, &drm_simple_kms_encoder_funcs,
-			       DRM_MODE_ENCODER_NONE, NULL);
+	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_NONE);
 	if (ret || !connector)
 		return ret;
 
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index e253ba7bea9d..54d5066d90c7 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -181,4 +181,11 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
 			const uint64_t *format_modifiers,
 			struct drm_connector *connector);
 
+int drm_simple_encoder_init(struct drm_device *dev,
+			    struct drm_encoder *encoder,
+			    int encoder_type);
+
+struct drm_encoder *drm_simple_encoder_create(struct drm_device *dev,
+					      int encoder_type);
+
 #endif /* __LINUX_DRM_SIMPLE_KMS_HELPER_H */
-- 
2.25.0
