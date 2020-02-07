From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/6] drm: Move initialization of encoder into an internal
 function
Date: Fri,  7 Feb 2020 09:41:30 +0100
Message-ID: <20200207084135.4524-2-tzimmermann@suse.de>
References: <20200207084135.4524-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200207084135.4524-1-tzimmermann@suse.de>
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

Moving encoder init code into an internal function, so it can be reused.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_encoder.c | 78 +++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
index e555281f43d4..ffe691a1bf34 100644
--- a/drivers/gpu/drm/drm_encoder.c
+++ b/drivers/gpu/drm/drm_encoder.c
@@ -91,6 +91,47 @@ void drm_encoder_unregister_all(struct drm_device *dev)
 	}
 }
 
+static int __drm_encoder_init(struct drm_device *dev,
+			      struct drm_encoder *encoder,
+			      const struct drm_encoder_funcs *funcs,
+			      int encoder_type, char *name)
+{
+	int ret;
+
+	/* encoder index is used with 32-bit bitmasks */
+	if (WARN_ON(dev->mode_config.num_encoder >= 32))
+		return -EINVAL;
+
+	ret = drm_mode_object_add(dev, &encoder->base, DRM_MODE_OBJECT_ENCODER);
+	if (ret)
+		return ret;
+
+	encoder->dev = dev;
+	encoder->encoder_type = encoder_type;
+	encoder->funcs = funcs;
+	if (name) {
+		encoder->name = name;
+	} else {
+		encoder->name = kasprintf(GFP_KERNEL, "%s-%d",
+					  drm_encoder_enum_list[encoder_type].name,
+					  encoder->base.id);
+		if (!encoder->name) {
+			ret = -ENOMEM;
+			goto out_put;
+		}
+	}
+
+	INIT_LIST_HEAD(&encoder->bridge_chain);
+	list_add_tail(&encoder->head, &dev->mode_config.encoder_list);
+	encoder->index = dev->mode_config.num_encoder++;
+
+out_put:
+	if (ret)
+		drm_mode_object_unregister(dev, &encoder->base);
+
+	return ret;
+}
+
 /**
  * drm_encoder_init - Init a preallocated encoder
  * @dev: drm device
@@ -111,43 +152,28 @@ int drm_encoder_init(struct drm_device *dev,
 		     const struct drm_encoder_funcs *funcs,
 		     int encoder_type, const char *name, ...)
 {
+	char *namestr = NULL;
 	int ret;
 
-	/* encoder index is used with 32bit bitmasks */
-	if (WARN_ON(dev->mode_config.num_encoder >= 32))
-		return -EINVAL;
-
-	ret = drm_mode_object_add(dev, &encoder->base, DRM_MODE_OBJECT_ENCODER);
-	if (ret)
-		return ret;
-
-	encoder->dev = dev;
-	encoder->encoder_type = encoder_type;
-	encoder->funcs = funcs;
 	if (name) {
 		va_list ap;
 
 		va_start(ap, name);
-		encoder->name = kvasprintf(GFP_KERNEL, name, ap);
+		namestr = kvasprintf(GFP_KERNEL, name, ap);
 		va_end(ap);
-	} else {
-		encoder->name = kasprintf(GFP_KERNEL, "%s-%d",
-					  drm_encoder_enum_list[encoder_type].name,
-					  encoder->base.id);
-	}
-	if (!encoder->name) {
-		ret = -ENOMEM;
-		goto out_put;
+		if (!namestr)
+			return -ENOMEM;
 	}
 
-	INIT_LIST_HEAD(&encoder->bridge_chain);
-	list_add_tail(&encoder->head, &dev->mode_config.encoder_list);
-	encoder->index = dev->mode_config.num_encoder++;
-
-out_put:
+	ret = __drm_encoder_init(dev, encoder, funcs, encoder_type, namestr);
 	if (ret)
-		drm_mode_object_unregister(dev, &encoder->base);
+		goto err_kfree;
+
+	return 0;
 
+err_kfree:
+	if (name)
+		kfree(namestr);
 	return ret;
 }
 EXPORT_SYMBOL(drm_encoder_init);
-- 
2.25.0
