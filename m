From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH v3 00/16] improve the fb_setcmap helper
Date: Wed, 5 Jul 2017 08:08:16 +0200
Message-ID: <20170705060816.nwufo2m7cmthjopn__16434.2927899726$1499234912$gmane$org@phenom.ffwll.local>
References: <1499164632-5582-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1499164632-5582-1-git-send-email-peda@axentia.se>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Rosin <peda@axentia.se>
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thomas Hellstrom <thellstrom@vmware.com>, Sinclair Yeh <syeh@vmware.com>, Russell King <linux@armlinux.org.uk>, amd-gfx@lists.freedesktop.org, VMware Graphics <linux-graphics-maintainer@vmware.com>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>, intel-gfx@lists.freedesktop.org, Vincent Abriou <vincent.abriou@st.com>, Philippe Cornu <philippe.cornu@st.com>, linux-kernel@vger.kernel.org, Yannick Fertre <yannick.fertre@st.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 04, 2017 at 12:36:56PM +0200, Peter Rosin wrote:
> Hi!
> 
> While trying to get CLUT support for the atmel_hlcdc driver, and
> specifically for the emulated fbdev interface, I received some
> push-back that my feeble in-driver attempts should be solved
> by the core. This is my attempt to do it right.
> 
> I have obviously not tested all of this with more than a compile,
> but patches 1 through 5 are enough to make the atmel-hlcdc driver
> do what I need. The rest is just lots of removals and cleanup made
> possible by the improved core.
> 
> Please test, I would not be surprised if I have fouled up some
> bit-manipulation somewhere, or if I have misunderstood something
> about atomics...
> 
> Changes since v2:
> - Added patch 1/16 which factors out pseudo-palette handling.
> - Removed the if (cmap->start + cmap->len < cmap->start)
>   sanity check on the assumption that the fbdev core handles it.
> - Added patch 4/16 which factors out atomic state and commit
>   handling from drm_atomic_helper_legacy_gamma_set to
>   drm_mode_gamma_set_ioctl.
> - Do one atomic commit for all affected crtc.
> - Removed a now obsolete note in include/drm/drm_crtc.h (ammended
>   the last patch).
> - Cc list is getting long, so I have redused the list for the
>   individual patches. If you would like to get the full series
>   (or nothing at all) for the next round (if that is needed) just
>   say so.

Is this still on top of my locking rework? I tried to apply patches 1-3,
but there's minor conflicts ...
-Daniel

> 
> Changes since v1:
> 
> - Rebased to next-20170621
> - Split 1/11 into a preparatory patch, a cleanup patch and then
>   the meat in 3/14.
> - Handle pseudo-palette for FB_VISUAL_TRUECOLOR.
> - Removed the empty .gamma_get/.gamma_set fb helpers from the
>   armada driver that I had somehow managed to ignore but which
>   0day found real quick.
> - Be less judgemental on drivers only providing .gamma_get and
>   .gamma_set, but no .load_lut. That's actually a valid thing
>   to do if you only need pseudo-palette for FB_VISUAL_TRUECOLOR.
> - Add a comment about colliding bitfields in the nouveau driver.
> - Remove gamma_set/gamma_get declarations from the radeon driver
>   (the definitions were removed in v1).
> 
> Cheers,
> peda
> 
> Peter Rosin (16):
>   drm/fb-helper: factor out pseudo-palette
>   drm/fb-helper: keep the .gamma_store updated in drm_fb_helper_setcmap
>   drm/fb-helper: remove drm_fb_helper_save_lut_atomic
>   drm/color-mgmt: move atomic state/commit out from .gamma_set
>   drm/fb-helper: do a generic fb_setcmap helper in terms of crtc
>     .gamma_set
>   drm: amd: remove dead code and pointless local lut storage
>   drm: armada: remove dead empty functions
>   drm: ast: remove dead code and pointless local lut storage
>   drm: cirrus: remove dead code and pointless local lut storage
>   drm: gma500: remove dead code and pointless local lut storage
>   drm: i915: remove dead code and pointless local lut storage
>   drm: mgag200: remove dead code and pointless local lut storage
>   drm: nouveau: remove dead code and pointless local lut storage
>   drm: radeon: remove dead code and pointless local lut storage
>   drm: stm: remove dead code and pointless local lut storage
>   drm: remove unused and redundant callbacks
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c      |  24 ----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |   1 -
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c      |  29 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c      |  29 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c       |  29 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c       |  29 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c    |  25 +---
>  drivers/gpu/drm/armada/armada_crtc.c        |  10 --
>  drivers/gpu/drm/armada/armada_crtc.h        |   2 -
>  drivers/gpu/drm/armada/armada_fbdev.c       |   2 -
>  drivers/gpu/drm/ast/ast_drv.h               |   1 -
>  drivers/gpu/drm/ast/ast_fb.c                |  20 ---
>  drivers/gpu/drm/ast/ast_mode.c              |  28 +---
>  drivers/gpu/drm/cirrus/cirrus_drv.h         |   8 --
>  drivers/gpu/drm/cirrus/cirrus_fbdev.c       |   2 -
>  drivers/gpu/drm/cirrus/cirrus_mode.c        |  73 +++--------
>  drivers/gpu/drm/drm_atomic_helper.c         |  37 ++----
>  drivers/gpu/drm/drm_color_mgmt.c            |  27 +++-
>  drivers/gpu/drm/drm_fb_helper.c             | 195 +++++++++++++++++-----------
>  drivers/gpu/drm/gma500/framebuffer.c        |  22 ----
>  drivers/gpu/drm/gma500/gma_display.c        |  34 ++---
>  drivers/gpu/drm/gma500/gma_display.h        |   2 +-
>  drivers/gpu/drm/gma500/psb_intel_display.c  |   7 +-
>  drivers/gpu/drm/gma500/psb_intel_drv.h      |   1 -
>  drivers/gpu/drm/i915/intel_drv.h            |   1 -
>  drivers/gpu/drm/i915/intel_fbdev.c          |  31 -----
>  drivers/gpu/drm/mgag200/mgag200_drv.h       |   5 -
>  drivers/gpu/drm/mgag200/mgag200_fb.c        |   2 -
>  drivers/gpu/drm/mgag200/mgag200_mode.c      |  64 +++------
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c     |  28 ++--
>  drivers/gpu/drm/nouveau/nouveau_crtc.h      |   3 -
>  drivers/gpu/drm/nouveau/nouveau_fbcon.c     |  22 ----
>  drivers/gpu/drm/nouveau/nv50_display.c      |  42 ++----
>  drivers/gpu/drm/radeon/atombios_crtc.c      |   1 -
>  drivers/gpu/drm/radeon/radeon_connectors.c  |   7 +-
>  drivers/gpu/drm/radeon/radeon_display.c     |  73 +++++------
>  drivers/gpu/drm/radeon/radeon_fb.c          |   2 -
>  drivers/gpu/drm/radeon/radeon_legacy_crtc.c |   1 -
>  drivers/gpu/drm/radeon/radeon_mode.h        |   4 -
>  drivers/gpu/drm/stm/ltdc.c                  |  12 --
>  drivers/gpu/drm/stm/ltdc.h                  |   1 -
>  drivers/gpu/drm/vc4/vc4_crtc.c              |   2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c         |   2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.h         |   2 +-
>  include/drm/drm_atomic_helper.h             |   2 +-
>  include/drm/drm_crtc.h                      |  11 +-
>  include/drm/drm_fb_helper.h                 |  32 -----
>  include/drm/drm_modeset_helper_vtables.h    |  16 ---
>  48 files changed, 301 insertions(+), 702 deletions(-)
> 
> -- 
> 2.1.4
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
