From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 00/14] improve the fb_setcmap helper
Date: Mon, 26 Jun 2017 11:35:27 +0200
Message-ID: <20170626093526.7dezn6d74m5ktsok__32389.3210771077$1498469738$gmane$org@phenom.ffwll.local>
References: <1498111597-10714-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1498111597-10714-1-git-send-email-peda@axentia.se>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Philippe Cornu <philippe.cornu@st.com>, Russell King <linux@armlinux.org.uk>, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Yannick Fertre <yannick.fertre@st.com>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Vincent Abriou <vincent.abriou@st.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 22, 2017 at 08:06:23AM +0200, Peter Rosin wrote:
> Hi!
> 
> While trying to get CLUT support for the atmel_hlcdc driver, and
> specifically for the emulated fbdev interface, I received some
> push-back that my feeble in-driver attempts should be solved
> by the core. This is my attempt to do it right.
> 
> I have obviously not tested all of this with more than a compile,
> but patches 1 and 3 are enough to make the atmel-hlcdc driver
> do what I need (when patched to support CLUT modes). The rest is
> just lots of removals and cleanup made possible by the improved
> core.
> 
> Please test, I would not be surprised if I have fouled up some
> bit-manipulation somewhere in this mostly mechanical change...
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

Ok some nits/questions on the first three, but in principle looks all ok I
think. The driver patches also look good (but I didn't yet carefully
review all the conversion). What we might want to do is entirely remove
driver's reliance on ->gamma_store (mostly amounts to in-lining the
load_lut functions) and only update ->gamma_store after gamma_set returned
successfully. But that's a bit more work.

Save/restoring it instead might be simpler to fix that bug, but since it's
pre-existing also ok as follow-up.

Cheers, Daniel

> 
> Cheers,
> peda
> 
> Peter Rosin (14):
>   drm/fb-helper: keep the .gamma_store updated in drm_fb_helper_setcmap
>   drm/fb-helper: remove drm_fb_helper_save_lut_atomic
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
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c      |  27 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c      |  27 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c       |  27 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c       |  27 ++---
>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c    |  23 ----
>  drivers/gpu/drm/armada/armada_crtc.c        |  10 --
>  drivers/gpu/drm/armada/armada_crtc.h        |   2 -
>  drivers/gpu/drm/armada/armada_fbdev.c       |   2 -
>  drivers/gpu/drm/ast/ast_drv.h               |   1 -
>  drivers/gpu/drm/ast/ast_fb.c                |  20 ----
>  drivers/gpu/drm/ast/ast_mode.c              |  26 +----
>  drivers/gpu/drm/cirrus/cirrus_drv.h         |   8 --
>  drivers/gpu/drm/cirrus/cirrus_fbdev.c       |   2 -
>  drivers/gpu/drm/cirrus/cirrus_mode.c        |  71 +++---------
>  drivers/gpu/drm/drm_fb_helper.c             | 164 +++++++++++++---------------
>  drivers/gpu/drm/gma500/framebuffer.c        |  22 ----
>  drivers/gpu/drm/gma500/gma_display.c        |  32 ++----
>  drivers/gpu/drm/gma500/psb_intel_display.c  |   7 +-
>  drivers/gpu/drm/gma500/psb_intel_drv.h      |   1 -
>  drivers/gpu/drm/i915/intel_drv.h            |   1 -
>  drivers/gpu/drm/i915/intel_fbdev.c          |  31 ------
>  drivers/gpu/drm/mgag200/mgag200_drv.h       |   5 -
>  drivers/gpu/drm/mgag200/mgag200_fb.c        |   2 -
>  drivers/gpu/drm/mgag200/mgag200_mode.c      |  62 +++--------
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c     |  26 ++---
>  drivers/gpu/drm/nouveau/nouveau_crtc.h      |   3 -
>  drivers/gpu/drm/nouveau/nouveau_fbcon.c     |  22 ----
>  drivers/gpu/drm/nouveau/nv50_display.c      |  40 +++----
>  drivers/gpu/drm/radeon/atombios_crtc.c      |   1 -
>  drivers/gpu/drm/radeon/radeon_connectors.c  |   7 +-
>  drivers/gpu/drm/radeon/radeon_display.c     |  71 +++++-------
>  drivers/gpu/drm/radeon/radeon_fb.c          |   2 -
>  drivers/gpu/drm/radeon/radeon_legacy_crtc.c |   1 -
>  drivers/gpu/drm/radeon/radeon_mode.h        |   4 -
>  drivers/gpu/drm/stm/ltdc.c                  |  12 --
>  drivers/gpu/drm/stm/ltdc.h                  |   1 -
>  include/drm/drm_fb_helper.h                 |  32 ------
>  include/drm/drm_modeset_helper_vtables.h    |  16 ---
>  40 files changed, 205 insertions(+), 658 deletions(-)
> 
> -- 
> 2.1.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
