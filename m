Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672428;
	b=Q5uemXG2dOGDW2Q7jKOzFSWlsp78SYDU+X5MC3VT4v5K6c1+WEU5kPk0qVt4FSdoGmyj
	 OnxzOhIqPeWoOGzfag704FRHDKxZaBlPnCEWOFZnh2nk2BOwSwV9dd3FtpmO11PcbkLcz
	 VKG0ueUmlPDXoMBG2j1GCGfAjV0XSVJsF2s7vGUTNny3we/xSCnSsv5m/FjOyS+tOoyIW
	 38sHgvvuUkEZxtZG8OiHnVCzOjNIxqoPNCtk4mysRuXOBQjLxSFZVJZqF+maqcL/6YmCi
	 WhL/V4Bvz8ptFZOlzHKxZrlg4YBE5+8NOTEY1B7D94sR/y2zuWq6zRyTOiaB/bgAeFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672428;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=es0EBw+s01NCevX6p6GYQJTMMjVuoGTr4HClcof2aRA=;
	b=VPvSQz03FZG9RNYiXdDMAHAQSO7en/Tu59WVOTpwVS40KcSLcw9U5JNRQUMPCNvTf5fa
	 IBkRoR8fZnuTS2PvNu62FJ/l4H2Jo7bJno0dQw/DGGEHdJIsZ6zr0yZgay+XqP33PlK8R
	 C2j5DRUiNXrng+JrY70nhDCnMzf6/hZ0vPoHwbaZ7RUSRIpFrV5e+zr9u28jUtg4ZoPN6
	 5OPreoOr5mZX2DSgYLZ5iSTRlMWNhcA6NQIjh9hl+/JAUEzl59X36iYUVdzfJ5p+ufyqN
	 V8qJEq8D/re8W9Ywi8uaY6cqSIhETms30xhSb9oBe82etIk/JBgJ+bMDddixf4tdWgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3UvU8sc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D52606A31E;
	Thu, 22 Oct 2026 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3UvU8sc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C249B1F000C1;
	Thu, 22 Oct 2026 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792672427;
	bh=es0EBw+s01NCevX6p6GYQJTMMjVuoGTr4HClcof2aRA=;
	h=From:Subject:Date:To:Cc;
	b=S3UvU8sc13/k33yf8QZiv/7uF2MDwHf3xjNmGLC6O7vJJqa2EsTAvFV6VERueVqaX
	 KbJPhoKrsFGl0ozfSDGXqa/gvOSS47YMM8XFNCrI44pNEZqvSNDfaJWIyqXRfn1iyP
	 tOXWqsMQVlaIgETZvAZJmOinxNRJlL4GE+oet56i8vHfhlkUHk0bd2SyDS2jBSh6vQ
	 h1EerhG6CTWwTrFq7c9M0Pcy70XfUkLqNu7c6RB5n6ex1Z+WhXV46ZeNTqwY6EKQ25
	 ZQoQGxFmpJQxsd+P2bJHSXfMBR7cW/PYZfU71VG4HWp9/17BpXUCK4vttjJEgpKJrv
	 5+yeyF/+Gh3Dg==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 00/59] drm/connector: Convert all drivers to
 atomic_create_state and remove reset
Date: Thu, 22 Oct 2026 14:30:59 +0200
Message-Id: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Oyw6CMBBFf4XM2jFt5VVX/odxAWWURml1WomG8
 O8W2Lu8k3vPnAkCsaUAx2wCptEG610KapeB6Rt3I7RdyqCEKkUlNHY8oPM4eCY03jky0TMyBYq
 YF0Qy7ypTKgOJ8GS62s9KP1+2zPR6pydxO0LbhAUzDDYeMy2vhSKta5W3sPR7GxL8u8qNch0sH
 lLI/K/HKFFgUZdGm1Sv1eF0J3b02Hu+wWWe5x/N8Hdo9wAAAA==
X-Change-ID: 20260709-drm-no-more-connector-reset-45ee14d7c62c
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Ruben Wauters <rubenru09@aol.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, 
 Alison Wang <alison.wang@nxp.com>, Stefan Agner <stefan@agner.ch>, 
 Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Yongbang Shi <shiyongbang@huawei.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>, Gerd Hoffmann <kraxel@redhat.com>, 
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 linux-renesas-soc@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org, 
 Alexey Brodkin <abrodkin@synopsys.com>, Hans de Goede <hansg@kernel.org>, 
 LiangCheng Wang <zaq14760@gmail.com>, Alex Lanzano <lanzano.alex@gmail.com>, 
 Sean Paul <sean@poorly.run>, Chia-I Wu <olvaffe@gmail.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11112; i=mripard@kernel.org;
 h=from:subject:message-id; bh=l8HHxUF3ppkOWkHs/T+vPFIyXJxDYh41p1hKBDhkwOM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mHrFm95UZ4hNsDky/UeeVf6r7FOOW/TK/tl9b71/x
 a/25817HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiMy4xNjz+MKfvS8IPz4Pv
 7sXOO3X6TJiz2vrd3oaau3kPeJ+JrzO3E06I6HV5cZGNhTNZfAb7fsb6rHTnrCXTJzyey3v359X
 WDMVpC+71/xRwmp6k4HY30jBg55GC3SpL7Bqkd32e7+CR4h8DAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

This is a follow-up to the plane and CRTC reset removal series, and
part of a larger effort to remove the reset hook from all KMS objects.

The connector reset hook is overloaded: it is called both at probe
time to create the initial software state and during suspend/resume to
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

This series converts all connector drivers tree-wide from the reset hook
to atomic_create_state, then removes the reset hook from struct
drm_connector_funcs entirely. The conversions were done using a
combination of Coccinelle semantic patches, mechanical one-line
replacements and manual adjustments.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v2:
- Change the parameter order of __drm_atomic_helper_connector_hdmi_state_init
- Fixed state argument casing for drm_atomic_helper_connector_tv_margins_state_init
  and drm_atomic_helper_connector_tv_state_init
- Put atomic_create_state before atomic_duplicate_state
- Fix state allocation for MST and WB connectors
- Link to v1:
  https://lore.kernel.org/r/20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org

---
Maxime Ripard (59):
      drm/hdmi: Change __drm_atomic_helper_connector_hdmi_state_init parameter order
      drm/atomic-state-helper: Rename connector_tv_margins_reset to state_init
      drm/atomic-state-helper: Rename connector_tv_reset to state_init
      drm/panel: Add atomic_create_state support
      drm/amdgpu: vkms: Switch to drm_atomic_helper_connector_create_state
      drm/aspeed: Switch to drm_atomic_helper_connector_create_state
      drm/ast: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: analogix-anx6345: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: analogix-anx78xx: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: chrontel-ch7033: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: nxp-ptn3460: Switch to drm_atomic_helper_connector_create_state
      drm/panel: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: synopsys: dw-hdmi: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: tc358767: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: tda998x: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: ti-tfp410: Switch to drm_atomic_helper_connector_create_state
      drm/exynos: Switch to drm_atomic_helper_connector_create_state
      drm/fsl-dcu: Switch to drm_atomic_helper_connector_create_state
      drm/hisilicon: hibmc: Switch to drm_atomic_helper_connector_create_state
      drm/logicvc: Switch to drm_atomic_helper_connector_create_state
      drm/loongson: Switch to drm_atomic_helper_connector_create_state
      drm/mgag200: Switch to drm_atomic_helper_connector_create_state
      drm/mipi-dbi: Switch to drm_atomic_helper_connector_create_state
      drm/qxl: Switch to drm_atomic_helper_connector_create_state
      drm/renesas: shmobile: Switch to drm_atomic_helper_connector_create_state
      drm/sitronix: st7571: Switch to drm_atomic_helper_connector_create_state
      drm/sitronix: st7920: Switch to drm_atomic_helper_connector_create_state
      drm/sti: Switch to drm_atomic_helper_connector_create_state
      drm/sun4i: Switch to drm_atomic_helper_connector_create_state
      drm/tegra: Switch to drm_atomic_helper_connector_create_state
      drm/tests: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: arcpgu: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: bochs: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: cirrus: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: gm12u320: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: pixpaper: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: repaper: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: sharp: Switch to drm_atomic_helper_connector_create_state
      drm/udl: Switch to drm_atomic_helper_connector_create_state
      drm/vboxvideo: Switch to drm_atomic_helper_connector_create_state
      drm/virtio: Switch to drm_atomic_helper_connector_create_state
      drm/vkms: Switch to drm_atomic_helper_connector_create_state
      drm/xen: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: synopsys: dw-hdmi: Convert to atomic_create_state
      drm/meson: Convert to atomic_create_state
      drm/gud: Convert to atomic_create_state
      drm/sun4i: hdmi: Convert to atomic_create_state
      drm/sun4i: tv: Convert to atomic_create_state
      drm/tests: hdmi: Convert to atomic_create_state
      drm/vc4: hdmi: Convert to atomic_create_state
      drm/vc4: vec: Convert to atomic_create_state
      drm/connector: Remove drm_atomic_helper_connector_reset()
      drm/amdgpu: dm: Convert to atomic_create_state
      drm/ast: Convert to atomic_create_state
      drm/i915: Convert to atomic_create_state
      drm/nouveau: Convert to atomic_create_state
      drm/tegra: Convert to atomic_create_state
      drm/connector: Remove __drm_atomic_helper_connector_reset()
      drm/connector: Remove reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 32 ++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |  3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 11 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 17 +++-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 90 ++++++++++++++--------
 drivers/gpu/drm/aspeed/aspeed_gfx_out.c            |  2 +-
 drivers/gpu/drm/ast/ast_dp.c                       | 18 ++---
 drivers/gpu/drm/ast/ast_dp501.c                    |  2 +-
 drivers/gpu/drm/ast/ast_sil164.c                   |  2 +-
 drivers/gpu/drm/ast/ast_vga.c                      |  2 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |  2 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |  2 +-
 drivers/gpu/drm/bridge/chrontel-ch7033.c           |  2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          | 12 ++-
 drivers/gpu/drm/bridge/tc358767.c                  |  2 +-
 drivers/gpu/drm/bridge/tda998x_drv.c               |  2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |  2 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |  4 +-
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  9 +--
 drivers/gpu/drm/drm_atomic_state_helper.c          | 67 ++++------------
 drivers/gpu/drm/drm_connector.c                    |  8 --
 drivers/gpu/drm/drm_mode_config.c                  |  4 +-
 drivers/gpu/drm/drm_panel.c                        | 16 +++-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |  2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |  2 +-
 drivers/gpu/drm/gud/gud_connector.c                | 20 +++--
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c     |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |  2 +-
 drivers/gpu/drm/i915/display/intel_connector.c     |  6 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |  6 +-
 drivers/gpu/drm/logicvc/logicvc_interface.c        |  2 +-
 drivers/gpu/drm/loongson/lsdc_output_7a1000.c      |  2 +-
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c      |  4 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         | 12 ++-
 drivers/gpu/drm/mgag200/mgag200_vga.c              |  2 +-
 drivers/gpu/drm/mgag200/mgag200_vga_bmc.c          |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            | 11 ++-
 drivers/gpu/drm/nouveau/nouveau_connector.c        | 27 ++++---
 drivers/gpu/drm/nouveau/nouveau_connector.h        |  3 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |  2 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  |  2 +-
 drivers/gpu/drm/sitronix/st7571.c                  |  2 +-
 drivers/gpu/drm/sitronix/st7920.c                  |  2 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |  2 +-
 drivers/gpu/drm/sti/sti_hda.c                      |  2 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |  2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             | 17 +++-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |  2 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |  2 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   | 16 +++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |  2 +-
 drivers/gpu/drm/tegra/dsi.c                        | 17 ++--
 drivers/gpu/drm/tegra/hdmi.c                       |  2 +-
 drivers/gpu/drm/tegra/sor.c                        | 13 ++--
 drivers/gpu/drm/tests/drm_atomic_commit_test.c     |  2 +-
 drivers/gpu/drm/tests/drm_atomic_test.c            |  2 +-
 drivers/gpu/drm/tests/drm_connector_test.c         |  4 +-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 17 +++-
 drivers/gpu/drm/tests/drm_probe_helper_test.c      |  2 +-
 drivers/gpu/drm/tiny/arcpgu.c                      |  2 +-
 drivers/gpu/drm/tiny/bochs.c                       |  2 +-
 drivers/gpu/drm/tiny/cirrus-qemu.c                 |  2 +-
 drivers/gpu/drm/tiny/gm12u320.c                    |  2 +-
 drivers/gpu/drm/tiny/pixpaper.c                    |  2 +-
 drivers/gpu/drm/tiny/repaper.c                     |  2 +-
 drivers/gpu/drm/tiny/sharp-memory.c                |  2 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |  2 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     | 31 ++++++--
 drivers/gpu/drm/vc4/vc4_vec.c                      | 16 +++-
 drivers/gpu/drm/virtio/virtgpu_display.c           |  2 +-
 drivers/gpu/drm/vkms/vkms_connector.c              |  2 +-
 drivers/gpu/drm/vkms/vkms_writeback.c              |  2 +-
 drivers/gpu/drm/xen/xen_drm_front_conn.c           |  2 +-
 include/drm/display/drm_hdmi_state_helper.h        |  4 +-
 include/drm/drm_atomic_state_helper.h              |  9 +--
 include/drm/drm_connector.h                        | 12 ---
 include/drm/drm_mipi_dbi.h                         |  2 +-
 82 files changed, 360 insertions(+), 276 deletions(-)
---
base-commit: 91f52e99824b0beebb48cad51bbda81437af8664
change-id: 20260709-drm-no-more-connector-reset-45ee14d7c62c

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

