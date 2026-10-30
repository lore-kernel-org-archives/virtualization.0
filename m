Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373234;
	b=uePMDYopwAvWtNkcAykUV5T2CEa7n7MzfSu/4qqEZYK7pe/UBJei+11h39u3rsLjoK2m
	 IIXD0s9FYmAYCGVGkTy6kRvBwieLk2bSyet8/iVf74C3O9eneas46+Ztt7OAD1f1Lv6tM
	 OvLgPRhJNj3kStvrjxD5acJKlaQQsha25+VF89xVGTHaB+RDLRdpDvUMl2izYW7tGefx8
	 zbvMlb8zSKkol23XcveqbHqMDAPPc4Duif9hotsNfDBRpbzY3hjgjbzu6pCyFZyQULbTc
	 8C3aG6qvCMGrf+10ECtJK41rccRwKUQfbUf3E9bhpDyaJt7fxBuXrjBtfhOa4nTo+4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373234;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tE9bdY9RJ4Os2qBL05nMpHueQKuKzNP8e9qxF9mma60=;
	b=pkWF+/9KCzsRaK3e/8LOjIImEba1LkntK3afoygWL+wXpFQKDnxi5JLYrjHsbQRYdGn7
	 GeZOFlowf2Bjk0bUtnRxpCMQiWFZOeKiuE7QGnUtOtewmNIiWWkRKhgkPa6Gfm3A1gqaV
	 lgdk5wdpHbVdbZJe2nlEtP+eV/UNlDMojRiH6EsacfaZ7O9l8MgqaL+SRvxIFRO2onizr
	 AEInj0g39LY+FG7+CSiIMpvSN04H8sL4jftAPm2bC+OxTyQazr+PzZM5ZliiCR8hcI8SH
	 RnbEpM/8nHGO0A1TPhIPs0PXpOkpDam1JU31GO8SIpRRHh/MBqP7LR60PbRGjnnUiVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTLAk2QQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1112D60A2616;
	Fri, 30 Oct 2026 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTLAk2QQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF301F000C1;
	Fri, 30 Oct 2026 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373233;
	bh=tE9bdY9RJ4Os2qBL05nMpHueQKuKzNP8e9qxF9mma60=;
	h=From:Subject:Date:To:Cc;
	b=LTLAk2QQkLlwzQwWKDKCkKVftMpfWOwyXeAs2YdnHWiWzISwSISDRYJev7o/BWAQI
	 xZPNMmSx/Pzr0jt67t5w5hI9YPjR4n5pNZxafWkFjvLTXGoLGz7slG1ePAIY9X/Vt7
	 Mv3e+LzSz81zSs3VX3SL9agDu5cZZCS8RU1evP0wEz65Gbv4eGLigsnC4FPB85GUkm
	 zyC5va+uNRwxsZOgd0Pkb5QM/laWTokdmm8qXRNW1G5dpXOwiKrKVMMXCMPc5eb0Cg
	 JTC4AvM6enfURzBoA/WgpAwmYVodho++LUm+cBJ+0Q9qRQCRUM/a38y6406b2dncrZ
	 H25nqRZwUawjw==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3 00/37] drm/connector: Convert all drivers to
 atomic_create_state and remove reset
Date: Fri, 30 Oct 2026 16:13:30 +0100
Message-Id: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/33OwW7CMAyA4VeJfMZTYtI26Yn3QDvQ1EC0Ndmcr
 NqE+u5TywUuHG3Zn/4bFJbIBXp1A+E5lpgT9Gq/UxCup3RhjCP0CkhTqzvtcZQJU8YpC2PIKXG
 oWVC4cEXbMBs7dqGlADsFX8Ln+Lvpx/f7LPz9E0us9yUMp7Iy0xRrr7w5N8TeO7IDrPfXWGqWv
 y1uNtvD2mG0sS87ZoMaG9cGHzS1jvaHD5bEn29ZLhs80wNG9Boj1KiHji27ZjDsnrBlWf4BhnZ
 sDEQBAAA=
X-Change-ID: 20260709-drm-no-more-connector-reset-45ee14d7c62c
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Russell King <linux@armlinux.org.uk>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, 
 Alison Wang <alison.wang@nxp.com>, Stefan Agner <stefan@agner.ch>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 linux-renesas-soc@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org, 
 Alexey Brodkin <abrodkin@synopsys.com>, 
 Alex Lanzano <lanzano.alex@gmail.com>, Chia-I Wu <olvaffe@gmail.com>, 
 David Airlie <airlied@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 virtualization@lists.linux.dev, Haneen Mohammed <hamohammed.sa@gmail.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8385; i=mripard@kernel.org;
 h=from:subject:message-id; bh=DZZrNGoYdZWKHOY12EKnVjZERSuJ0LCp6SPnhbDGbgs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtsiuvPaged7Fn/JHvyf5F52RSjl2f/q+R7OXudiuS
 k+f8lSgtGMqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBMZMMMxvr4R378V/fzfz2/
 9vgjVtsVOudidZLmHneZ2vlpJVdh+pK+0MzA31Kyu78cObJCK//rsWrGhlOb36bvdfjnbOuiuO+
 lEWPGC/vHFbd3+fjabWlgmPkqQ3XT0hQvSaZZWqsauVeqLExUBgA=
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
Changes in v3:
- Fix error path in dw-hdmi
- Fix test error path for amdgpu kunit tests
- Fix nouveau legacy path
- Link to v2: https://lore.kernel.org/r/20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org

Changes in v2:
- Change the parameter order of __drm_atomic_helper_connector_hdmi_state_init
- Fixed state argument casing for drm_atomic_helper_connector_tv_margins_state_init
  and drm_atomic_helper_connector_tv_state_init
- Put atomic_create_state before atomic_duplicate_state
- Fix state allocation for MST and WB connectors
- Link to v1:
  https://lore.kernel.org/r/20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org

---
Maxime Ripard (37):
      drm/amdgpu: vkms: Switch to drm_atomic_helper_connector_create_state
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
      drm/loongson: Switch to drm_atomic_helper_connector_create_state
      drm/mipi-dbi: Switch to drm_atomic_helper_connector_create_state
      drm/renesas: shmobile: Switch to drm_atomic_helper_connector_create_state
      drm/sitronix: st7571: Switch to drm_atomic_helper_connector_create_state
      drm/sti: Switch to drm_atomic_helper_connector_create_state
      drm/sun4i: Switch to drm_atomic_helper_connector_create_state
      drm/tegra: Switch to drm_atomic_helper_connector_create_state
      drm/tests: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: arcpgu: Switch to drm_atomic_helper_connector_create_state
      drm/tiny: sharp: Switch to drm_atomic_helper_connector_create_state
      drm/virtio: Switch to drm_atomic_helper_connector_create_state
      drm/vkms: Switch to drm_atomic_helper_connector_create_state
      drm/xen: Switch to drm_atomic_helper_connector_create_state
      drm/bridge: synopsys: dw-hdmi: Convert to atomic_create_state
      drm/meson: Convert to atomic_create_state
      drm/sun4i: hdmi: Convert to atomic_create_state
      drm/sun4i: tv: Convert to atomic_create_state
      drm/tests: hdmi: Convert to atomic_create_state
      drm/connector: Remove drm_atomic_helper_connector_reset()
      drm/amdgpu: dm: Convert to atomic_create_state
      drm/i915: Convert to atomic_create_state
      drm/nouveau: Convert to atomic_create_state
      drm/tegra: Convert to atomic_create_state
      drm/connector: Remove __drm_atomic_helper_connector_reset()
      drm/connector: Remove reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  32 ++---
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  11 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  17 ++-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 102 +++++++++++-----
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |   2 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |   2 +-
 drivers/gpu/drm/bridge/chrontel-ch7033.c           |   2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |   2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  14 ++-
 drivers/gpu/drm/bridge/tc358767.c                  |   2 +-
 drivers/gpu/drm/bridge/tda998x_drv.c               |   2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |   2 +-
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |   3 +-
 drivers/gpu/drm/drm_atomic_state_helper.c          |  43 -------
 drivers/gpu/drm/drm_connector.c                    |   8 --
 drivers/gpu/drm/drm_mode_config.c                  |   4 +-
 drivers/gpu/drm/drm_panel.c                        |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |   2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |   2 +-
 drivers/gpu/drm/i915/display/intel_connector.c     |   6 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |   6 +-
 drivers/gpu/drm/loongson/lsdc_output_7a1000.c      |   2 +-
 drivers/gpu/drm/loongson/lsdc_output_7a2000.c      |   4 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |  12 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  25 ++--
 drivers/gpu/drm/nouveau/nouveau_connector.c        | 129 ++++++++++++++++-----
 drivers/gpu/drm/nouveau/nouveau_connector.h        |   3 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  |   2 +-
 drivers/gpu/drm/sitronix/st7571.c                  |   2 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |   2 +-
 drivers/gpu/drm/sti/sti_hda.c                      |   2 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |   2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  16 ++-
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 |   2 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  |   2 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |  16 ++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |   2 +-
 drivers/gpu/drm/tegra/dsi.c                        |  17 ++-
 drivers/gpu/drm/tegra/hdmi.c                       |   2 +-
 drivers/gpu/drm/tegra/sor.c                        |  13 +--
 drivers/gpu/drm/tests/drm_atomic_commit_test.c     |   2 +-
 drivers/gpu/drm/tests/drm_atomic_test.c            |   2 +-
 drivers/gpu/drm/tests/drm_connector_test.c         |   4 +-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  16 ++-
 drivers/gpu/drm/tests/drm_probe_helper_test.c      |   2 +-
 drivers/gpu/drm/tiny/arcpgu.c                      |   2 +-
 drivers/gpu/drm/tiny/sharp-memory.c                |   2 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |   2 +-
 drivers/gpu/drm/vkms/vkms_connector.c              |   2 +-
 drivers/gpu/drm/vkms/vkms_writeback.c              |   2 +-
 drivers/gpu/drm/xen/xen_drm_front_conn.c           |   2 +-
 include/drm/drm_atomic_state_helper.h              |   3 -
 include/drm/drm_connector.h                        |  12 --
 include/drm/drm_mipi_dbi.h                         |   2 +-
 58 files changed, 351 insertions(+), 236 deletions(-)
---
base-commit: 91f52e99824b0beebb48cad51bbda81437af8664
change-id: 20260709-drm-no-more-connector-reset-45ee14d7c62c

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

