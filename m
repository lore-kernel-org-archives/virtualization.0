From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 00/11] improve the fb_setcmap helper
Date: Tue, 20 Jun 2017 21:25:24 +0200
Message-ID: <1497986735-14418-1-git-send-email-peda__43084.6862764612$1509078057$gmane$org@axentia.se>
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
To: linux-kernel@vger.kernel.org
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Philippe Cornu <philippe.cornu@st.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Yannick Fertre <yannick.fertre@st.com>, Sean Paul <seanpaul@chromium.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, Vincent Abriou <vincent.abriou@st.com>, Peter Rosin <peda@axentia.se>, Ben Skeggs <bskeggs@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi!

While trying to get CLUT support for the atmel_hlcdc driver, and
specifically for the emulated fbdev interface, I received some
push-back that my feeble in-driver attempts should be solved
by the core. This is my attempt to do it right.

Boris and Daniel, was this approximately what you had in mind?

I have obviously not tested all of this with more than a compile,
but the first patch is enough to make the atmel-hlcdc driver
do what I need. The rest is just lots of removals and cleanup
made possible by the improved core.

Please test, I would not be surprised if I have fouled up some
bit-manipulation somewhere in this mostly mechanical change...

Cheers,
peda

Peter Rosin (11):
  drm/fb-helper: do a generic fb_setcmap helper in terms of crtc
    .gamma_set
  drm: amd: remove dead code and pointless local lut storage
  drm: ast: remove dead code and pointless local lut storage
  drm: cirrus: remove dead code and pointless local lut storage
  dmr: gma500: remove dead code and pointless local lut storage
  drm: i915: remove dead code and pointless local lut storage
  drm: mgag200: remove dead code and pointless local lut storage
  drm: nouveau: remove dead code and pointless local lut storage
  drm: radeon: remove dead code and pointless local lut storage
  drm: stm: remove dead code and pointless local lut storage
  drm: remove unused and redundant callbacks

 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c      |  24 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |   1 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c      |  27 ++----
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c      |  27 ++----
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c       |  27 ++----
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c       |  27 ++----
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c    |  23 -----
 drivers/gpu/drm/ast/ast_drv.h               |   1 -
 drivers/gpu/drm/ast/ast_fb.c                |  20 -----
 drivers/gpu/drm/ast/ast_mode.c              |  26 ++----
 drivers/gpu/drm/cirrus/cirrus_drv.h         |   8 --
 drivers/gpu/drm/cirrus/cirrus_fbdev.c       |   2 -
 drivers/gpu/drm/cirrus/cirrus_mode.c        |  71 ++++-----------
 drivers/gpu/drm/drm_fb_helper.c             | 131 +++++++++-------------------
 drivers/gpu/drm/gma500/framebuffer.c        |  22 -----
 drivers/gpu/drm/gma500/gma_display.c        |  32 +++----
 drivers/gpu/drm/gma500/psb_intel_display.c  |   7 +-
 drivers/gpu/drm/gma500/psb_intel_drv.h      |   1 -
 drivers/gpu/drm/i915/intel_drv.h            |   1 -
 drivers/gpu/drm/i915/intel_fbdev.c          |  31 -------
 drivers/gpu/drm/mgag200/mgag200_drv.h       |   5 --
 drivers/gpu/drm/mgag200/mgag200_fb.c        |   2 -
 drivers/gpu/drm/mgag200/mgag200_mode.c      |  62 ++++---------
 drivers/gpu/drm/nouveau/dispnv04/crtc.c     |  26 ++----
 drivers/gpu/drm/nouveau/nouveau_crtc.h      |   3 -
 drivers/gpu/drm/nouveau/nouveau_fbcon.c     |  22 -----
 drivers/gpu/drm/nouveau/nv50_display.c      |  39 +++------
 drivers/gpu/drm/radeon/atombios_crtc.c      |   1 -
 drivers/gpu/drm/radeon/radeon_connectors.c  |   7 +-
 drivers/gpu/drm/radeon/radeon_display.c     |  71 ++++++---------
 drivers/gpu/drm/radeon/radeon_fb.c          |   2 -
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c |   1 -
 drivers/gpu/drm/stm/ltdc.c                  |  12 ---
 drivers/gpu/drm/stm/ltdc.h                  |   1 -
 include/drm/drm_fb_helper.h                 |  32 -------
 include/drm/drm_modeset_helper_vtables.h    |  16 ----
 36 files changed, 171 insertions(+), 640 deletions(-)

-- 
2.1.4
