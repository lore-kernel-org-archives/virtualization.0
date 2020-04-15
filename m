From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 26/59] drm/qxl: Use devm_drm_dev_alloc
Date: Wed, 15 Apr 2020 09:40:01 +0200
Message-ID: <20200415074034.175360-27-daniel.vetter@ffwll.ch>
References: <20200415074034.175360-1-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200415074034.175360-1-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc: spice-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel.vetter@intel.com>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Also need to remove the drm_dev_put from the remove hook.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: spice-devel@lists.freedesktop.org
---
 drivers/gpu/drm/qxl/qxl_drv.c | 15 ++++++++-------
 drivers/gpu/drm/qxl/qxl_drv.h |  3 +--
 drivers/gpu/drm/qxl/qxl_kms.c | 12 +-----------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 09102e2efabc..6b4ae4c5fb76 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -81,13 +81,16 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -EINVAL; /* TODO: ENODEV ? */
 	}
 
-	qdev = kzalloc(sizeof(struct qxl_device), GFP_KERNEL);
-	if (!qdev)
+	qdev = devm_drm_dev_alloc(&pdev->dev, &qxl_driver,
+				  struct qxl_device, ddev);
+	if (IS_ERR(qdev)) {
+		pr_err("Unable to init drm dev");
 		return -ENOMEM;
+	}
 
 	ret = pci_enable_device(pdev);
 	if (ret)
-		goto free_dev;
+		return ret;
 
 	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, "qxl");
 	if (ret)
@@ -101,7 +104,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	ret = qxl_device_init(qdev, &qxl_driver, pdev);
+	ret = qxl_device_init(qdev, pdev);
 	if (ret)
 		goto put_vga;
 
@@ -128,8 +131,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		vga_put(pdev, VGA_RSRC_LEGACY_IO);
 disable_pci:
 	pci_disable_device(pdev);
-free_dev:
-	kfree(qdev);
+
 	return ret;
 }
 
@@ -155,7 +157,6 @@ qxl_pci_remove(struct pci_dev *pdev)
 	drm_atomic_helper_shutdown(dev);
 	if (is_vga(pdev))
 		vga_put(pdev, VGA_RSRC_LEGACY_IO);
-	drm_dev_put(dev);
 }
 
 DEFINE_DRM_GEM_FOPS(qxl_fops);
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 435126facc9b..86ac191d9205 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -276,8 +276,7 @@ struct qxl_device {
 extern const struct drm_ioctl_desc qxl_ioctls[];
 extern int qxl_max_ioctl;
 
-int qxl_device_init(struct qxl_device *qdev, struct drm_driver *drv,
-		    struct pci_dev *pdev);
+int qxl_device_init(struct qxl_device *qdev, struct pci_dev *pdev);
 void qxl_device_fini(struct qxl_device *qdev);
 
 int qxl_modeset_init(struct qxl_device *qdev);
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 9eed1a375f24..91a34dd835d7 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -108,21 +108,13 @@ static void qxl_gc_work(struct work_struct *work)
 }
 
 int qxl_device_init(struct qxl_device *qdev,
-		    struct drm_driver *drv,
 		    struct pci_dev *pdev)
 {
 	int r, sb;
 
-	r = drm_dev_init(&qdev->ddev, drv, &pdev->dev);
-	if (r) {
-		pr_err("Unable to init drm dev");
-		goto error;
-	}
-
 	qdev->ddev.pdev = pdev;
 	pci_set_drvdata(pdev, &qdev->ddev);
 	qdev->ddev.dev_private = qdev;
-	drmm_add_final_kfree(&qdev->ddev, qdev);
 
 	mutex_init(&qdev->gem.mutex);
 	mutex_init(&qdev->update_area_mutex);
@@ -138,8 +130,7 @@ int qxl_device_init(struct qxl_device *qdev,
 	qdev->vram_mapping = io_mapping_create_wc(qdev->vram_base, pci_resource_len(pdev, 0));
 	if (!qdev->vram_mapping) {
 		pr_err("Unable to create vram_mapping");
-		r = -ENOMEM;
-		goto error;
+		return -ENOMEM;
 	}
 
 	if (pci_resource_len(pdev, 4) > 0) {
@@ -293,7 +284,6 @@ int qxl_device_init(struct qxl_device *qdev,
 	io_mapping_free(qdev->surface_mapping);
 vram_mapping_free:
 	io_mapping_free(qdev->vram_mapping);
-error:
 	return r;
 }
 
-- 
2.25.1
