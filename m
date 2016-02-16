From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 00/16] drm crtc cleanup: nuke optional dummy crtc mode_fixup
	function.
Date: Tue, 16 Feb 2016 14:09:44 +0000
Message-ID: <cover.1455630967.git.palminha@synopsys.com>
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
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch, patrik.r.jakobsson@gmail.com, virtualization@lists.linux-foundation.org
Cc: nicolas.pitre@linaro.org, boris.brezillon@free-electrons.com, jianwei.wang.chn@gmail.com, jani.nikula@intel.com, alison.wang@freescale.com, CARLOS.PALMINHA@synopsys.com, linux-renesas-soc@vger.kernel.org, laurent.pinchart@ideasonboard.com, benjamin.gaignard@linaro.org, vincent.abriou@st.com, sudipm.mukherjee@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

This patch set nukes all the dummy crtc mode_fixup implementations.
(made on top of Daniel topic/drm-misc branch)

Carlos Palminha (16):
  drm: fixes crct set_mode when crtc mode_fixup is null.
  drm/cirrus: removed optional dummy crtc mode_fixup function.
  drm/mgag200: removed optional dummy crtc mode_fixup function.
  drm/udl: removed optional dummy crtc mode_fixup function.
  drm/gma: removed optional dummy crtc mode_fixup function.
  drm/rcar-du: removed optional dummy crtc mode_fixup function.
  drm/omapdrm: removed optional dummy crtc mode_fixup function.
  drm/msm/mdp: removed optional dummy crtc mode_fixup function.
  drm/shmobile: removed optional dummy crtc mode_fixup function.
  drm/sti: removed optional dummy crtc mode_fixup function.
  drm/atmel-hldcd: removed optional dummy crtc mode_fixup function.
  drm/nouveau/dispnv04: removed optional dummy crtc mode_fixup function.
  drm/virtio: removed optional dummy crtc mode_fixup function.
  drm/fsl-dcu: removed optional dummy crtc mode_fixup function.
  drm/bochs: removed optional dummy crtc mode_fixup function.
  drm/ast: removed optional dummy crtc mode_fixup function.

 drivers/gpu/drm/ast/ast_mode.c                 |  8 --------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c |  9 ---------
 drivers/gpu/drm/bochs/bochs_kms.c              |  8 --------
 drivers/gpu/drm/cirrus/cirrus_mode.c           | 13 -------------
 drivers/gpu/drm/drm_crtc_helper.c              |  9 ++++++---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c     |  8 --------
 drivers/gpu/drm/gma500/cdv_intel_display.c     | 13 ++++++-------
 drivers/gpu/drm/gma500/gma_display.c           |  7 -------
 drivers/gpu/drm/gma500/gma_display.h           |  3 ---
 drivers/gpu/drm/gma500/mdfld_intel_display.c   |  2 --
 drivers/gpu/drm/gma500/oaktrail_crtc.c         |  1 -
 drivers/gpu/drm/gma500/psb_intel_display.c     |  1 -
 drivers/gpu/drm/mgag200/mgag200_mode.c         | 13 -------------
 drivers/gpu/drm/msm/mdp/mdp4/mdp4_crtc.c       |  8 --------
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_crtc.c       |  8 --------
 drivers/gpu/drm/nouveau/dispnv04/crtc.c        |  8 --------
 drivers/gpu/drm/omapdrm/omap_crtc.c            |  8 --------
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c         |  9 ---------
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c      |  8 --------
 drivers/gpu/drm/sti/sti_crtc.c                 |  9 ---------
 drivers/gpu/drm/udl/udl_modeset.c              |  9 ---------
 drivers/gpu/drm/virtio/virtgpu_display.c       |  8 --------
 22 files changed, 12 insertions(+), 158 deletions(-)

-- 
2.5.0
