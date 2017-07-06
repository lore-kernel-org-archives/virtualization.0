From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v4 00/14] improve the fb_setcmap helper
Date: Thu,  6 Jul 2017 14:20:34 +0200
Message-ID: <1499343648-29695-1-git-send-email-peda__11725.7873680957$1509078754$gmane$org@axentia.se>
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
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Russell King <linux@armlinux.org.uk>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Vincent Abriou <vincent.abriou@st.com>, Philippe Cornu <philippe.cornu@st.com>, Peter Rosin <peda@axentia.se>, Yannick Fertre <yannick.fertre@st.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi!

While trying to get CLUT support for the atmel_hlcdc driver, and
specifically for the emulated fbdev interface, I received some
push-back that my feeble in-driver attempts should be solved
by the core. This is my attempt to do it right.

I have obviously not tested all of this with more than a compile,
but patches 1 and 3 are enough to make the atmel-hlcdc driver
do what I need. The rest is just lots of removals and cleanup made
possible by the other improvements.

Please test, I would not be surprised if I have fouled up some
bit-manipulation somewhere, or if I have misunderstood something
about atomics...

Changes since v3:
- Rebased onto drm-misc-next and dropped patches 1-3 from v3, since
  they are already merged.
- Dropped the v3 patch 4/16 ("drm/color-mgmt: move atomic state/commit
  out from .gamma_set") since the atomic setcmap no longer uses
  the crtc .gamma_set callback.
- Added patch 1/14 which exports drm_atomic_replace_property_blob...
- ...and patch 2/14 which uses this new export to simplify
  drm_atomic_helper_legacy_gamma_set.
- Big changes to patch 3/14 (was 5/16 in v3). It had various locking
  issues and the atomic setcmap is rather different.

Changes since v2:
- Added patch 1/16 which factors out pseudo-palette handling.
- Removed the if (cmap->start + cmap->len < cmap->start)
  sanity check on the assumption that the fbdev core handles it.
- Added patch 4/16 which factors out atomic state and commit
  handling from drm_atomic_helper_legacy_gamma_set to
  drm_mode_gamma_set_ioctl.
- Do one atomic commit for all affected crtc.
- Removed a now obsolete note in include/drm/drm_crtc.h (ammended
  the last patch).
- Cc list is getting long, so I have redused the list for the
  individual patches. If you would like to get the full series
  (or nothing at all) for the next round (if that is needed) just
  say so.

Changes since v1:

- Rebased to next-20170621
- Split 1/11 into a preparatory patch, a cleanup patch and then
  the meat in 3/14.
- Handle pseudo-palette for FB_VISUAL_TRUECOLOR.
- Removed the empty .gamma_get/.gamma_set fb helpers from the
  armada driver that I had somehow managed to ignore but which
  0day found real quick.
- Be less judgemental on drivers only providing .gamma_get and
  .gamma_set, but no .load_lut. That's actually a valid thing
  to do if you only need pseudo-palette for FB_VISUAL_TRUECOLOR.
- Add a comment about colliding bitfields in the nouveau driver.
- Remove gamma_set/gamma_get declarations from the radeon driver
  (the definitions were removed in v1).

Cheers,
peda

Peter Rosin (14):
  drm/atomic: export drm_atomic_replace_property_blob
  drm/atomic-helper: update lut props directly in ..._legacy_gamma_set
  drm/fb-helper: separate the fb_setcmap helper into atomic and legacy
    paths
  drm: amd: remove dead code and pointless local lut storage
  drm: armada: remove dead empty functions
  drm: ast: remove dead code and pointless local lut storage
  drm: cirrus: remove dead code and pointless local lut storage
  drm: gma500: remove dead code and pointless local lut storage
  drm: i915: remove dead code and pointless local lut storage
  drm: mgag200: remove dead code and pointless local lut storage
  drm: nouveau: remove dead code and pointless local lut storage
  drm: radeon: remove dead code and pointless local lut storage
  drm: stm: remove dead code and pointless local lut storage
  drm: remove unused and redundant callbacks

 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c      |  24 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |   1 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c      |  27 +---
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c      |  27 +---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c       |  27 +---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c       |  27 +---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c    |  23 ---
 drivers/gpu/drm/armada/armada_crtc.c        |  10 --
 drivers/gpu/drm/armada/armada_crtc.h        |   2 -
 drivers/gpu/drm/armada/armada_fbdev.c       |   2 -
 drivers/gpu/drm/ast/ast_drv.h               |   1 -
 drivers/gpu/drm/ast/ast_fb.c                |  20 ---
 drivers/gpu/drm/ast/ast_mode.c              |  26 +---
 drivers/gpu/drm/cirrus/cirrus_drv.h         |   8 -
 drivers/gpu/drm/cirrus/cirrus_fbdev.c       |   2 -
 drivers/gpu/drm/cirrus/cirrus_mode.c        |  71 ++-------
 drivers/gpu/drm/drm_atomic.c                |  17 +-
 drivers/gpu/drm/drm_atomic_helper.c         |  23 +--
 drivers/gpu/drm/drm_fb_helper.c             | 232 +++++++++++++++++++---------
 drivers/gpu/drm/gma500/framebuffer.c        |  22 ---
 drivers/gpu/drm/gma500/gma_display.c        |  32 ++--
 drivers/gpu/drm/gma500/psb_intel_display.c  |   7 +-
 drivers/gpu/drm/gma500/psb_intel_drv.h      |   1 -
 drivers/gpu/drm/i915/intel_drv.h            |   1 -
 drivers/gpu/drm/i915/intel_fbdev.c          |  31 ----
 drivers/gpu/drm/mgag200/mgag200_drv.h       |   5 -
 drivers/gpu/drm/mgag200/mgag200_fb.c        |   2 -
 drivers/gpu/drm/mgag200/mgag200_mode.c      |  62 ++------
 drivers/gpu/drm/nouveau/dispnv04/crtc.c     |  26 ++--
 drivers/gpu/drm/nouveau/nouveau_crtc.h      |   3 -
 drivers/gpu/drm/nouveau/nouveau_fbcon.c     |  22 ---
 drivers/gpu/drm/nouveau/nv50_display.c      |  40 ++---
 drivers/gpu/drm/radeon/atombios_crtc.c      |   1 -
 drivers/gpu/drm/radeon/radeon_connectors.c  |   7 +-
 drivers/gpu/drm/radeon/radeon_display.c     |  71 ++++-----
 drivers/gpu/drm/radeon/radeon_fb.c          |   2 -
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c |   1 -
 drivers/gpu/drm/radeon/radeon_mode.h        |   4 -
 drivers/gpu/drm/stm/ltdc.c                  |  12 --
 drivers/gpu/drm/stm/ltdc.h                  |   1 -
 include/drm/drm_atomic.h                    |   4 +
 include/drm/drm_crtc.h                      |   8 -
 include/drm/drm_fb_helper.h                 |  32 ----
 include/drm/drm_modeset_helper_vtables.h    |  16 --
 44 files changed, 314 insertions(+), 669 deletions(-)

-- 
2.1.4
