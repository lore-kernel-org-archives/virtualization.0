Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9029B484251;
	Mon, 31 Aug 2026 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193064; cv=none; b=TV/4zQN7+IaxX3wA96ey1s28iLy87FmzDhQWnUUheJnI03lXV2fgBQ1zOiLjxSDVNMIjXSx6gYZ6FdW5wwgh/OxNAr/3HBz/cZ3HwYnuYlhrxgU9wWWnsg2bUrWRTrB9AB+TCB7eMAjuDDFemilVcNsTpvVyr9ltcosmqbUiILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193064; c=relaxed/simple;
	bh=UQdPVjsSllmbAksMbFCnvGYfKEyx+A8rEA2R4ECxdOM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZYr4uKtcHskElFoi43IfII+W9nwrc4qoZjaiTPRG/7VdNmWoSsjxLoQ8gmP3ZWel0y3zfYz3A1PQG/vmq/EFLgkpAoJQJRvIXx7emKOTOj6wZZvN47RAIj0mUJcV55RAtopXIPCiSi+75R8dw2jBU40d9GcszmHYpM6ybD3RDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOufgh6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOufgh6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8771F000E9;
	Mon, 31 Aug 2026 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788193062;
	bh=P49xYdhz/xjQ7BMYEEzVnSoncIoxJ9kG0EiBOFLfPl4=;
	h=From:Subject:Date:To:Cc;
	b=cOufgh6jV1ylZ0/c48mF4elVJ9nF9FeI4rC/0rzzTyoqGjE0HVPGEDABGzgDEV3vI
	 iUozhugXufPr3T01SxkQZ1bmwNK/N/PtzgAd4gWzJai+9/LuDPlU2LBJ/xW2tKRCRp
	 YV2oJJhx3RwbY/9cIKN31dfI9eJeAT6V3WURQ4mBIPEFMmNMnmHUdGosmocGgz54rt
	 /1HtPdFXL254gV2Nd1WChSFm4qhgLXrnZXaXQHxDo0JO1VG2RUr5QTm6UlxinAaQSn
	 VIgK7aCD4ny4wDZofm2VdVYpYghrohClIrrElf29YQtKtfWXRtqfmdZkK7w0CDN0ZT
	 8bmlzlDnpwnsg==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3 00/40] drm/plane: Convert all drivers to
 atomic_create_state and remove reset
Date: Mon, 31 Aug 2026 18:17:16 +0200
Message-Id: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNPQ7CMAyG4augzBi57j8T90AMFXEgoiSVU0Wgq
 ncnLQNi6Ph+kh9PKrBYDuq4m5RwtMF6lyLf79T13rkbg9WpFSFVWFELWp7gPDy9MAx95xiEA4+
 ARVuiKYixNipdD8LGvlb5fEl9t2H08l4fxWxZv2aN22bMACFH0m1TGS4Nnh4sjvuDl5ta0Eg/q
 MmKbYgS1JCmtsq1zvLiD5rn+QNzj1DiCAEAAA==
X-Change-ID: 20260629-drm-no-more-plane-reset-04950f42e07f
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 hamohammed.sa@gmail.com, louis.chauvet@bootlin.com, melissa.srw@gmail.com, 
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, alison.wang@nxp.com, stefan@agner.ch, 
 jstultz@google.com, sumit.semwal@linaro.org, xinliang.liu@linaro.org, 
 yongqin.liu@linaro.org, Frank.Li@nxp.com, 
 Sascha Hauer <s.hauer@pengutronix.de>, festevam@gmail.com, 
 imx@lists.linux.dev, kernel@pengutronix.de, victor.liu@nxp.com, 
 anitha.chrisanthus@intel.com, paulk@sys-base.io, chenhuacai@kernel.org, 
 jeffbai@aosc.io, lvjianmin@loongson.cn, wuqianhai@loongson.cn, 
 xry111@xry111.site, zhengxingda@iscas.ac.cn, marex@denx.de, 
 airlied@redhat.com, kraxel@redhat.com, spice-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, andy.yan@rock-chips.com, heiko@sntech.de, 
 hjc@rock-chips.com, linux-rockchip@lists.infradead.org, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, orsonzhai@gmail.com, 
 zhang.lyra@gmail.com, alain.volmat@foss.st.com, rgallaispou@gmail.com, 
 alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com, 
 philippe.cornu@foss.st.com, raphael.gallais-pou@foss.st.com, 
 yannick.fertre@foss.st.com, jyri.sarha@iki.fi, 
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
 chunkuang.hu@kernel.org, matthias.bgg@gmail.com, 
 Lyude Paul <lyude@redhat.com>, dakr@kernel.org, 
 nouveau@lists.freedesktop.org, geert+renesas@glider.be, 
 kieran.bingham+renesas@ideasonboard.com, 
 laurent.pinchart+renesas@ideasonboard.com, 
 linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, 
 tomi.valkeinen+renesas@ideasonboard.com, 
 Biju Das <biju.das.jz@bp.renesas.com>, linux-sunxi@lists.linux.dev, 
 samuel@sholland.org, wens@kernel.org, bcm-kernel-feedback-list@broadcom.com, 
 zack.rusin@broadcom.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7711; i=mripard@kernel.org;
 h=from:subject:message-id; bh=UQdPVjsSllmbAksMbFCnvGYfKEyx+A8rEA2R4ECxdOM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlTVwqc1s2/O5npboPLBs8f9/2OrUnzbD+Zc2d9+p7w2
 Ps83PWvO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBExPQZ68waZE79Kbj6M+VI
 eegPpkc7du/3kt3862j2dl4/6RXs09Kv7xAU+7RF4d/B/dw5Mq/9zBgb5j5pltE76RyQyPlA086
 951/o/P85k6TUqm2YVp+cIDqz8rjT2TZ2j+xFjPX+fNNa+LUB
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
Changes in v3:
- Drop leftover state destruction in sun4i
- Rebase on current drm-misc-next
- Link to v2: https://lore.kernel.org/r/20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org

Changes in v2:
- Rebase on latest drm-misc-next tag
- Fix sashiko reviews
- Fix atmel-hlcdc breakage
- Link to v1: https://lore.kernel.org/r/20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org

---
Maxime Ripard (40):
      drm/simple-kms: Remove unused reset_plane hook
      drm/vkms: Convert to atomic_create_state
      drm/gem-atomic-helper: Remove __drm_gem_reset_shadow_plane()
      drm/amdgpu: Convert to atomic_create_state
      drm/fsl-dcu: Convert to atomic_create_state
      drm/hisilicon/kirin: Convert to atomic_create_state
      drm/imx/dc: Convert to atomic_create_state
      drm/kmb: Convert to atomic_create_state
      drm/logicvc: Convert to atomic_create_state
      drm/loongson: Convert to atomic_create_state
      drm/lcdif: Convert to atomic_create_state
      drm/mxsfb: Convert to atomic_create_state
      drm/qxl: Convert to atomic_create_state
      drm/rockchip: Convert to atomic_create_state
      drm/sprd: Convert to atomic_create_state
      drm/sti: Convert to atomic_create_state
      drm/stm: Convert to atomic_create_state
      drm/tests: kunit: Convert to atomic_create_state
      drm/tilcdc: Convert to atomic_create_state
      drm/vboxvideo: Convert to atomic_create_state
      drm/verisilicon: Convert to atomic_create_state
      drm/virtio: Convert to atomic_create_state
      drm/xlnx: Convert to atomic_create_state
      drm/atomic-state-helper: Remove drm_atomic_helper_plane_reset()
      drm/amdgpu_dm: Convert to atomic_create_state
      drm/armada: Convert to atomic_create_state
      drm/atmel-hlcdc: Drop spurious csc_init call from reset
      drm/atmel-hlcdc: Convert to atomic_create_state
      drm/exynos: Convert to atomic_create_state
      drm/imx/ipuv3: Convert to atomic_create_state
      drm/mediatek: Convert to atomic_create_state
      drm/nouveau: Convert to atomic_create_state
      drm/omap: Convert to atomic_create_state
      drm/rcar-du: Convert to atomic_create_state
      drm/rz-du: Convert to atomic_create_state
      drm/shmobile: Convert to atomic_create_state
      drm/sun4i: layer: Convert to atomic_create_state
      drm/vmwgfx: Convert to atomic_create_state
      drm/atomic-state-helper: Remove __drm_atomic_helper_plane_reset()
      drm/plane: Remove reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 28 +++++++++------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |  2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c | 30 ++++++----------
 drivers/gpu/drm/armada/armada_overlay.c            | 39 ++++++++++----------
 drivers/gpu/drm/armada/armada_plane.c              | 15 ++++----
 drivers/gpu/drm/armada/armada_plane.h              |  2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    | 33 ++++++++---------
 drivers/gpu/drm/drm_atomic_state_helper.c          | 41 ----------------------
 drivers/gpu/drm/drm_gem_atomic_helper.c            | 20 -----------
 drivers/gpu/drm/drm_mode_config.c                  |  4 +--
 drivers/gpu/drm/exynos/exynos_drm_plane.c          | 22 +++++-------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        |  2 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |  2 +-
 drivers/gpu/drm/imx/dc/dc-plane.c                  |  2 +-
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c            | 19 +++++-----
 drivers/gpu/drm/kmb/kmb_plane.c                    |  2 +-
 drivers/gpu/drm/logicvc/logicvc_layer.c            |  2 +-
 drivers/gpu/drm/loongson/lsdc_plane.c              |  2 +-
 drivers/gpu/drm/mediatek/mtk_plane.c               | 22 +++++-------
 drivers/gpu/drm/mxsfb/lcdif_kms.c                  |  2 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            | 15 ++++----
 drivers/gpu/drm/omapdrm/omap_plane.c               | 13 ++++---
 drivers/gpu/drm/qxl/qxl_display.c                  |  4 +--
 drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c    | 15 ++++----
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c      | 15 ++++----
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c       | 15 ++++----
 drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c | 15 ++++----
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |  2 +-
 drivers/gpu/drm/sprd/sprd_dpu.c                    |  2 +-
 drivers/gpu/drm/sti/sti_cursor.c                   |  2 +-
 drivers/gpu/drm/sti/sti_gdp.c                      |  2 +-
 drivers/gpu/drm/sti/sti_hqvdp.c                    |  2 +-
 drivers/gpu/drm/stm/ltdc.c                         |  2 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c                | 21 +++++------
 drivers/gpu/drm/tests/drm_kunit_helpers.c          |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              |  2 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |  2 +-
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c      |  2 +-
 drivers/gpu/drm/verisilicon/vs_plane.c             | 14 +++-----
 drivers/gpu/drm/verisilicon/vs_plane.h             |  2 +-
 drivers/gpu/drm/verisilicon/vs_primary_plane.c     |  2 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c             |  2 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  | 15 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                | 17 ++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  4 +--
 drivers/gpu/drm/xlnx/zynqmp_kms.c                  |  2 +-
 include/drm/drm_atomic_state_helper.h              |  3 --
 include/drm/drm_gem_atomic_helper.h                |  2 --
 include/drm/drm_plane.h                            | 12 -------
 include/drm/drm_simple_kms_helper.h                |  1 -
 56 files changed, 192 insertions(+), 324 deletions(-)
---
base-commit: 07c66ce1e6446f5cc6a4ace99a8d46880f45c527
change-id: 20260629-drm-no-more-plane-reset-04950f42e07f

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

