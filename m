From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 7/7] drm/vram: fix Kconfig
Date: Wed,  4 Sep 2019 07:47:40 +0200
Message-ID: <20190904054740.20817-8-kraxel__43807.2565406159$1567576087$gmane$org@redhat.com>
References: <20190904054740.20817-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190904054740.20817-1-kraxel@redhat.com>
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
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen Feng <puck.chen@hisilicon.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Xinliang Liu <z.liuxinliang@hisilicon.com>, David Airlie <airlied@linux.ie>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Daniel Vetter <daniel@ffwll.ch>, Rongrong Zou <zourongrong@gmail.com>, Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

select isn't recursive, so we can't turn on DRM_TTM + DRM_TTM_HELPER
in config DRM_VRAM_HELPER, we have to select them on the vram users
instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/Kconfig                 | 2 --
 drivers/gpu/drm/ast/Kconfig             | 2 ++
 drivers/gpu/drm/bochs/Kconfig           | 2 ++
 drivers/gpu/drm/hisilicon/hibmc/Kconfig | 3 ++-
 drivers/gpu/drm/mgag200/Kconfig         | 2 ++
 drivers/gpu/drm/vboxvideo/Kconfig       | 2 ++
 6 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 1be8ad30d8fe..cd11a3bde19c 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -168,8 +168,6 @@ config DRM_TTM
 config DRM_VRAM_HELPER
 	tristate
 	depends on DRM
-	select DRM_TTM
-	select DRM_TTM_HELPER
 	help
 	  Helpers for VRAM memory management
 
diff --git a/drivers/gpu/drm/ast/Kconfig b/drivers/gpu/drm/ast/Kconfig
index 829620d5326c..fbcf2f45cef5 100644
--- a/drivers/gpu/drm/ast/Kconfig
+++ b/drivers/gpu/drm/ast/Kconfig
@@ -4,6 +4,8 @@ config DRM_AST
 	depends on DRM && PCI && MMU
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
+	select DRM_TTM
+	select DRM_TTM_HELPER
 	help
 	 Say yes for experimental AST GPU driver. Do not enable
 	 this driver without having a working -modesetting,
diff --git a/drivers/gpu/drm/bochs/Kconfig b/drivers/gpu/drm/bochs/Kconfig
index 32b043abb668..7bcdf294fed8 100644
--- a/drivers/gpu/drm/bochs/Kconfig
+++ b/drivers/gpu/drm/bochs/Kconfig
@@ -4,6 +4,8 @@ config DRM_BOCHS
 	depends on DRM && PCI && MMU
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
+	select DRM_TTM
+	select DRM_TTM_HELPER
 	help
 	  Choose this option for qemu.
 	  If M is selected the module will be called bochs-drm.
diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
index f20eedf0073a..8ad9a5b12e40 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
+++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
@@ -4,7 +4,8 @@ config DRM_HISI_HIBMC
 	depends on DRM && PCI && MMU
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
-
+	select DRM_TTM
+	select DRM_TTM_HELPER
 	help
 	  Choose this option if you have a Hisilicon Hibmc soc chipset.
 	  If M is selected the module will be called hibmc-drm.
diff --git a/drivers/gpu/drm/mgag200/Kconfig b/drivers/gpu/drm/mgag200/Kconfig
index 76fee0fbdcae..aed11f4f4c55 100644
--- a/drivers/gpu/drm/mgag200/Kconfig
+++ b/drivers/gpu/drm/mgag200/Kconfig
@@ -4,6 +4,8 @@ config DRM_MGAG200
 	depends on DRM && PCI && MMU
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
+	select DRM_TTM
+	select DRM_TTM_HELPER
 	help
 	 This is a KMS driver for the MGA G200 server chips, it
          does not support the original MGA G200 or any of the desktop
diff --git a/drivers/gpu/drm/vboxvideo/Kconfig b/drivers/gpu/drm/vboxvideo/Kconfig
index 56ba510f21a2..45fe135d6e43 100644
--- a/drivers/gpu/drm/vboxvideo/Kconfig
+++ b/drivers/gpu/drm/vboxvideo/Kconfig
@@ -4,6 +4,8 @@ config DRM_VBOXVIDEO
 	depends on DRM && X86 && PCI
 	select DRM_KMS_HELPER
 	select DRM_VRAM_HELPER
+	select DRM_TTM
+	select DRM_TTM_HELPER
 	select GENERIC_ALLOCATOR
 	help
 	  This is a KMS driver for the virtual Graphics Card used in
-- 
2.18.1
