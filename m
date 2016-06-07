From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 00/20] drm/atomic: Provide default ->best_encoder() behavior
Date: Tue,  7 Jun 2016 13:47:55 +0200
Message-ID: <1465300095-16971-1-git-send-email-boris.brezillon__32237.7143464566$1465300149$gmane$org@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Stefan Agner <stefan@agner.ch>, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, linux-tegra@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Inki Dae <inki.dae@sam>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

This patch series aims at replacing all dummy ->best_encoder()
implementations where we have a 1:1 relationship between encoders
and connectors.
The core already provides the drm_atomic_helper_best_encoder()
function which is taking the first encoder attached to the
connector (after making sure only one encoder was attached to the
connector), but it's not automatically used, and drivers wanting
to rely on this default behavior have to explicitly assign their
->best_encoder() hook to drm_atomic_helper_best_encoder().

The first patch fixes remaining places where
drm_atomic_helper_best_encoder() should be called when ->best_encoder()
is NULL, so that drivers using the atomic helpers can get rid of the
explicit ->best_encoder assignment if they need to rely on the default
drm_atomic_helper_best_encoder() implementation.

The following patches are killing all open coded ->best_encoder()
implementations that could be replaced by
drm_atomic_helper_best_encoder().

All modifications have been compile tested except for the changed on
the intel driver.
I've also tested on an atmel board, but I recommend waiting for DRM
driver maintainers feedback before applying the associated changes.

Note that once patch 1 is applied, the other patches can be applied
independently.

Best Regards,

Boris

Changes since v1:
- remove useless ->encoder backpointers in some implementations
- documented the default behavior in the vtable doc
- added R-b/A-b tags

Boris Brezillon (20):
  drm/atomic: Fix remaining places where !funcs->best_encoder is valid
  drm: arc: Rely on the default ->best_encoder() behavior
  drm: atmel-hlcdc: Rely on the default ->best_encoder() behavior
  drm: exynos: Rely on the default ->best_encoder() behavior
  drm: fsl-dcu: Rely on the default ->best_encoder() behavior
  drm: i915: Rely on the default ->best_encoder() behavior where
    appropriate
  drm: mediatek: Rely on the default ->best_encoder() behavior
  drm: msm: Rely on the default ->best_encoder() behavior where
    appropriate
  drm: rcar-du: Rely on the default ->best_encoder() behavior
  drm: rockchip: Rely on the default ->best_encoder() behavior
  drm: sti: Rely on the default ->best_encoder() behavior
  drm: sun4i: Rely on the default ->best_encoder() behavior
  drm: tegra: Rely on the default ->best_encoder() behavior
  drm: vc4: Rely on the default ->best_encoder() behavior
  drm: virtgpu: Rely on the default ->best_encoder() behavior
  drm: omap: Rely on the default ->best_encoder() behavior
  drm/bridge: anx78xx: Rely on the default ->best_encoder() behavior
  drm/bridge: ptn3460: Rely on the default ->best_encoder() behavior
  drm/bridge: ps8622: Rely on the default ->best_encoder() behavior
  drm/bridge: dw-hdmi: Use drm_atomic_helper_best_encoder()

 drivers/gpu/drm/arc/arcpgu_hdmi.c                  | 18 ------------------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 12 ------------
 drivers/gpu/drm/bridge/analogix-anx78xx.c          |  8 --------
 drivers/gpu/drm/bridge/dw-hdmi.c                   | 11 +----------
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |  8 --------
 drivers/gpu/drm/bridge/parade-ps8622.c             | 10 ----------
 drivers/gpu/drm/drm_atomic_helper.c                |  4 +++-
 drivers/gpu/drm/drm_fb_helper.c                    | 13 ++++++++++++-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |  9 ---------
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |  9 ---------
 drivers/gpu/drm/exynos/exynos_drm_vidi.c           |  8 --------
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  8 --------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |  9 ---------
 drivers/gpu/drm/i915/intel_crt.c                   |  1 -
 drivers/gpu/drm/i915/intel_display.c               |  8 --------
 drivers/gpu/drm/i915/intel_dp.c                    |  1 -
 drivers/gpu/drm/i915/intel_drv.h                   |  1 -
 drivers/gpu/drm/i915/intel_dsi.c                   |  1 -
 drivers/gpu/drm/i915/intel_dvo.c                   |  1 -
 drivers/gpu/drm/i915/intel_hdmi.c                  |  1 -
 drivers/gpu/drm/i915/intel_lvds.c                  |  1 -
 drivers/gpu/drm/i915/intel_sdvo.c                  |  1 -
 drivers/gpu/drm/i915/intel_tv.c                    |  1 -
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |  9 ---------
 drivers/gpu/drm/msm/edp/edp_connector.c            | 10 ----------
 drivers/gpu/drm/msm/hdmi/hdmi_connector.c          |  8 --------
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_lvds_connector.c |  9 ---------
 drivers/gpu/drm/omapdrm/omap_connector.c           | 10 ----------
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          | 12 ------------
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h          |  3 ---
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c          |  1 -
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c          |  1 -
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c           |  3 ---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c             |  9 ---------
 drivers/gpu/drm/rockchip/inno_hdmi.c               |  9 ---------
 drivers/gpu/drm/sti/sti_dvo.c                      | 10 ----------
 drivers/gpu/drm/sti/sti_hda.c                      | 10 ----------
 drivers/gpu/drm/sti/sti_hdmi.c                     | 10 ----------
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  | 10 ----------
 drivers/gpu/drm/sun4i/sun4i_tv.c                   |  9 ---------
 drivers/gpu/drm/tegra/drm.h                        |  2 --
 drivers/gpu/drm/tegra/dsi.c                        |  1 -
 drivers/gpu/drm/tegra/hdmi.c                       |  1 -
 drivers/gpu/drm/tegra/output.c                     |  8 --------
 drivers/gpu/drm/tegra/rgb.c                        |  1 -
 drivers/gpu/drm/tegra/sor.c                        |  1 -
 drivers/gpu/drm/vc4/vc4_dpi.c                      |  9 ---------
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  9 ---------
 drivers/gpu/drm/virtio/virtgpu_display.c           | 10 ----------
 include/drm/drm_modeset_helper_vtables.h           | 10 ++++++++--
 50 files changed, 24 insertions(+), 305 deletions(-)

-- 
2.7.4
