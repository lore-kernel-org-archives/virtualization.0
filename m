Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9E35C687;
	Fri, 14 Aug 2026 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719460; cv=none; b=OjCqG2tQurzmFmBgmt9y7t7drhb+/O1xTLhFH4AOFR7pOwegC/9Vs8y51CnRxpl84ZBV6vN6HjU8X2gS9j+glLU1fAU9jee3lpGogBWX1R5xnKunUjFoMW5tG3KaPYKYNta0QaytFGC9QIPiVlRv3+qs4dKFJY0u4txfZJtHOgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719460; c=relaxed/simple;
	bh=VJPKLZAERv57LU6ZWlnm/FbV5fCc6NLCWv56VYxLhBU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bRhiVbbbenKH2gAlW/DYKwmxO9UhO+ZY0CgxPl0qphXsW3TsevR/wU/QA+lfLBi6tmYG26vMxG40fKGiREAboypWc7i3aSA+BDjlkGnS3cUoa96eBr57u7kfYFQmwYso8CziGZx8ALtUPXdoxEXcyS7fBcp752P+rxDGxIlyKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUGSZSzM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUGSZSzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88A31F000E9;
	Fri, 14 Aug 2026 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719458;
	bh=oRHsc21NPHRRTL5TCXKm1vpU6KJAiAdM4KGx4fHfbPM=;
	h=From:Subject:Date:To:Cc;
	b=KUGSZSzMNBGgEbZ5Oo19cwy5OO7XpvFKIqR4u+Q/uLSgBrSE90y4IB5hkgsOFBnSJ
	 smkV7tH2KkJ4/Uv+tHHF1fA/A6BYPuT4jPOHSNOYhaOpwSpc4Bdse1LxeG0VJVCWL7
	 j0y0PN81fA6pSUJxlcQbSip45VS2QfaOManc9uAZMh4FREFqEWT9Zyr0HnxllJdB6Y
	 SEdJweF9UW3/8m34t59n2UeL3ys2ujpz1kIMQVOLRlF06q6FuHJiiJrnD2zM5eTCiQ
	 kHZ15qJK0sT4P9TLHMp2vcvggwXfVgIHCag07PA3FTuRUDCqR5J/Z+aiRlja/zYLXP
	 w+/4+pP3rqgSQ==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 00/61] drm/plane: Convert all drivers to
 atomic_create_state and remove reset
Date: Fri, 14 Aug 2026 16:56:49 +0200
Message-Id: <20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0Jm7ZihQhFW3sOwIDKFRmjJlDQaw
 t2tuHb5XvLf3yCwWA7QZBsIRxusdwnUKYPH2LmB0faJQZHSpFWNvczoPM5eGJepc4zCgVekoi7
 JFIqpMpDWi7Cxr6N8bxOPNqxe3sdRzL/216zofzPmSHgh1ddXbbg0dHuyOJ7OXgZo933/AP0Ol
 yu/AAAA
X-Change-ID: 20260629-drm-no-more-plane-reset-04950f42e07f
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 javierm@redhat.com, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Aditya Garg <gargaditya08@proton.me>, admin@kodeit.net, 
 hamohammed.sa@gmail.com, louis.chauvet@bootlin.com, melissa.srw@gmail.com, 
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, Liviu Dudau <liviu.dudau@arm.com>, 
 alison.wang@nxp.com, stefan@agner.ch, jstultz@google.com, 
 sumit.semwal@linaro.org, xinliang.liu@linaro.org, yongqin.liu@linaro.org, 
 Frank.Li@nxp.com, Sascha Hauer <s.hauer@pengutronix.de>, festevam@gmail.com, 
 imx@lists.linux.dev, kernel@pengutronix.de, victor.liu@nxp.com, 
 l.stach@pengutronix.de, laurentiu.palcu@oss.nxp.com, 
 Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org, 
 anitha.chrisanthus@intel.com, paulk@sys-base.io, chenhuacai@kernel.org, 
 jeffbai@aosc.io, lvjianmin@loongson.cn, wuqianhai@loongson.cn, 
 xry111@xry111.site, zhengxingda@iscas.ac.cn, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 jbrunet@baylibre.com, khilman@baylibre.com, 
 linux-amlogic@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 abhinav.kumar@linux.dev, freedreno@lists.freedesktop.org, 
 jesszhan0024@gmail.com, linux-arm-msm@vger.kernel.org, lumag@kernel.org, 
 marijn.suijten@somainline.org, robin.clark@oss.qualcomm.com, 
 sean@poorly.run, marex@denx.de, airlied@redhat.com, kraxel@redhat.com, 
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 andy.yan@rock-chips.com, heiko@sntech.de, hjc@rock-chips.com, 
 linux-rockchip@lists.infradead.org, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, orsonzhai@gmail.com, 
 zhang.lyra@gmail.com, alain.volmat@foss.st.com, rgallaispou@gmail.com, 
 alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com, 
 philippe.cornu@foss.st.com, raphael.gallais-pou@foss.st.com, 
 yannick.fertre@foss.st.com, linux-sunxi@lists.linux.dev, 
 samuel@sholland.org, wens@kernel.org, jyri.sarha@iki.fi, 
 tomi.valkeinen@ideasonboard.com, hansg@kernel.org, 
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org, 
 olvaffe@gmail.com, michal.simek@amd.com, harry.wentland@amd.com, 
 siqueira@igalia.com, sunpeng.li@amd.com, linux@armlinux.org.uk, 
 Dharma Balasubiramani <dharma.b@microchip.com>, 
 Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
 nicolas.ferre@microchip.com, alim.akhtar@samsung.com, inki.dae@samsung.com, 
 krzk@kernel.org, kyungmin.park@samsung.com, 
 linux-samsung-soc@vger.kernel.org, sw0312.kim@samsung.com, 
 p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com, 
 chunkuang.hu@kernel.org, matthias.bgg@gmail.com, dakr@kernel.org, 
 lyude@redhat.com, nouveau@lists.freedesktop.org, geert+renesas@glider.be, 
 kieran.bingham+renesas@ideasonboard.com, 
 laurent.pinchart+renesas@ideasonboard.com, 
 linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, 
 tomi.valkeinen+renesas@ideasonboard.com, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 dave.stevenson@raspberrypi.com, kernel-list@raspberrypi.com, 
 bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com, 
 Mikko Perttunen <mperttunen@nvidia.com>, jonathanh@nvidia.com, 
 linux-tegra@vger.kernel.org, thierry.reding@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9816; i=mripard@kernel.org;
 h=from:subject:message-id; bh=VJPKLZAERv57LU6ZWlnm/FbV5fCc6NLCWv56VYxLhBU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFn1Okd4jeNl+X7syqqbY/cw1tCm+4K+vPySv7ffRjMlP
 95gKxbTMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACayYxpjfeGuW6d2Cid9skic
 XnUw2HXGCmPJg5Nr1x3Q9Gd/Jvuwfu/ra3bOtgm3eByXSe3b8dOmirFOre7X1j0XI2KFw/tl704
 9Fr7Ql4Wlr9zT5H/pCUb7a2dvrqxxuza/Pehf6JagnKI0rp8A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

This is a follow-up to the bridge reset removal series, and part of a
larger effort to remove the reset hook from all KMS objects.

The plane reset hook is overloaded: it is called both at probe time
to create the initial software state and during suspend/resume to
reset hardware and software state. These two roles have different
requirements, and the reset hook is not fallible, making error
handling difficult for the initial state allocation path.

While reset has the semantics to reset both the software and hardware
state, the vast majority of implementations and all the helpers only
reset the software state, making them equivalent to
atomic_create_state in practice. The atomic_create_state hook makes
this explicit: it only allocates and initializes a pristine state
without any side effect, and returns the state pointer or an ERR_PTR
on failure.

This series first adds the necessary infrastructure in the simple-kms
and GEM atomic helpers, then converts all 51 plane drivers tree-wide
from the reset hook to atomic_create_state. The conversions were done
using a combination of Coccinelle semantic patches and manual
adjustments. Once all drivers are converted, the old helpers and the
reset hook itself are removed from struct drm_plane_funcs.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v2:
- Rebase on latest drm-misc-next tag
- Fix sashiko reviews
- Fix atmel-hlcdc breakage
- Link to v1: https://lore.kernel.org/r/20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org

---
Maxime Ripard (61):
      drm/simple-kms: Add create_plane_state hook
      drm/gem-atomic-helper: Create drm_gem_create_shadow_plane_state()
      drm/gem-atomic-helper: Convert simple-kms shadow helpers to create_plane_state
      drm/gem-atomic-helper: Switch DRM_GEM_SHADOW_PLANE_FUNCS to atomic_create_state
      drm/gem-atomic-helper: Remove drm_gem_reset_shadow_plane()
      drm/sysfb: Convert to atomic_create_state
      drm/simple-kms: Switch to atomic_create_state
      drm/ssd130x: Convert to atomic_create_state
      drm/st7920: Convert to atomic_create_state
      drm/appletbdrm: Convert to atomic_create_state
      drm/vkms: Convert to atomic_create_state
      drm/gem-atomic-helper: Remove __drm_gem_reset_shadow_plane()
      drm/amdgpu: Convert to atomic_create_state
      drm/hdlcd: Convert to atomic_create_state
      drm/fsl-dcu: Convert to atomic_create_state
      drm/hisilicon/kirin: Convert to atomic_create_state
      drm/imx/dc: Convert to atomic_create_state
      drm/imx/dcss: Convert to atomic_create_state
      drm/ingenic: Convert to atomic_create_state
      drm/kmb: Convert to atomic_create_state
      drm/logicvc: Convert to atomic_create_state
      drm/loongson: Convert to atomic_create_state
      drm/meson: Convert to atomic_create_state
      drm/msm/mdp4: Convert to atomic_create_state
      drm/lcdif: Convert to atomic_create_state
      drm/mxsfb: Convert to atomic_create_state
      drm/qxl: Convert to atomic_create_state
      drm/rockchip: Convert to atomic_create_state
      drm/sprd: Convert to atomic_create_state
      drm/sti: Convert to atomic_create_state
      drm/stm: Convert to atomic_create_state
      drm/sun4i: sun8i: Convert to atomic_create_state
      drm/tests: kunit: Convert to atomic_create_state
      drm/tilcdc: Convert to atomic_create_state
      drm/vboxvideo: Convert to atomic_create_state
      drm/verisilicon: Convert to atomic_create_state
      drm/virtio: Convert to atomic_create_state
      drm/xlnx: Convert to atomic_create_state
      drm/atomic-state-helper: Remove drm_atomic_helper_plane_reset()
      drm/amdgpu_dm: Convert to atomic_create_state
      drm/komeda: Convert to atomic_create_state
      drm/malidp: Convert to atomic_create_state
      drm/armada: Convert to atomic_create_state
      drm/atmel-hlcdc: Drop spurious csc_init call from reset
      drm/atmel-hlcdc: Convert to atomic_create_state
      drm/exynos: Convert to atomic_create_state
      drm/imx/ipuv3: Convert to atomic_create_state
      drm/mediatek: Convert to atomic_create_state
      drm/msm/dpu1: Convert to atomic_create_state
      drm/msm/mdp5: Convert to atomic_create_state
      drm/nouveau: Convert to atomic_create_state
      drm/omap: Convert to atomic_create_state
      drm/rcar-du: Convert to atomic_create_state
      drm/rz-du: Convert to atomic_create_state
      drm/shmobile: Convert to atomic_create_state
      drm/sun4i: layer: Convert to atomic_create_state
      drm/vc4: Convert to atomic_create_state
      drm/vmwgfx: Convert to atomic_create_state
      drm/atomic-state-helper: Remove __drm_atomic_helper_plane_reset()
      drm/tegra: Convert to atomic_create_state
      drm/plane: Remove reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  26 +++---
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |  18 ++--
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |   2 +-
 drivers/gpu/drm/arm/malidp_planes.c                |  18 ++--
 drivers/gpu/drm/armada/armada_overlay.c            |  39 ++++----
 drivers/gpu/drm/armada/armada_plane.c              |  15 ++--
 drivers/gpu/drm/armada/armada_plane.h              |   2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |  33 +++----
 drivers/gpu/drm/drm_atomic_state_helper.c          |  41 ---------
 drivers/gpu/drm/drm_gem_atomic_helper.c            | 100 +++++++++++----------
 drivers/gpu/drm/drm_mode_config.c                  |   4 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |  11 +--
 drivers/gpu/drm/exynos/exynos_drm_plane.c          |  22 ++---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        |   2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |   2 +-
 drivers/gpu/drm/imx/dc/dc-plane.c                  |   2 +-
 drivers/gpu/drm/imx/dcss/dcss-plane.c              |   2 +-
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c            |  19 ++--
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |   2 +-
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |   2 +-
 drivers/gpu/drm/kmb/kmb_plane.c                    |   2 +-
 drivers/gpu/drm/logicvc/logicvc_layer.c            |   2 +-
 drivers/gpu/drm/loongson/lsdc_plane.c              |   2 +-
 drivers/gpu/drm/mediatek/mtk_plane.c               |  22 ++---
 drivers/gpu/drm/meson/meson_overlay.c              |   2 +-
 drivers/gpu/drm/meson/meson_plane.c                |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  18 ++--
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |  16 ++--
 drivers/gpu/drm/mxsfb/lcdif_kms.c                  |   2 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |  15 ++--
 drivers/gpu/drm/omapdrm/omap_plane.c               |  13 ++-
 drivers/gpu/drm/qxl/qxl_display.c                  |   4 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c    |  15 ++--
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c      |  15 ++--
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c       |  15 ++--
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c |  15 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |   2 +-
 drivers/gpu/drm/sitronix/st7920.c                  |  12 +--
 drivers/gpu/drm/solomon/ssd130x.c                  |  12 +--
 drivers/gpu/drm/sprd/sprd_dpu.c                    |   2 +-
 drivers/gpu/drm/sti/sti_cursor.c                   |   2 +-
 drivers/gpu/drm/sti/sti_gdp.c                      |   2 +-
 drivers/gpu/drm/sti/sti_hqvdp.c                    |   2 +-
 drivers/gpu/drm/stm/ltdc.c                         |   2 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c                |  12 ++-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |   2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |   2 +-
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h           |   4 +-
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c          |  30 +++++--
 drivers/gpu/drm/tegra/plane.c                      |  28 +++---
 drivers/gpu/drm/tests/drm_kunit_helpers.c          |   2 +-
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              |   2 +-
 drivers/gpu/drm/tiny/appletbdrm.c                  |  12 +--
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |   2 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |  15 ++--
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c      |   2 +-
 drivers/gpu/drm/verisilicon/vs_plane.c             |  14 ++-
 drivers/gpu/drm/verisilicon/vs_plane.h             |   2 +-
 drivers/gpu/drm/verisilicon/vs_primary_plane.c     |   2 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c             |   2 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |  15 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  17 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |   4 +-
 drivers/gpu/drm/xlnx/zynqmp_kms.c                  |   2 +-
 include/drm/drm_atomic_state_helper.h              |   3 -
 include/drm/drm_gem_atomic_helper.h                |  13 +--
 include/drm/drm_plane.h                            |  12 ---
 include/drm/drm_simple_kms_helper.h                |   1 +
 75 files changed, 343 insertions(+), 433 deletions(-)
---
base-commit: bd4f284df04d76fd65e57141cb1e6e7a49e4c3cb
change-id: 20260629-drm-no-more-plane-reset-04950f42e07f

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

