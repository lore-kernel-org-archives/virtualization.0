From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 00/11] improve the fb_setcmap helper
Date: Wed, 21 Jun 2017 09:40:17 +0200
Message-ID: <20170621074017.owckvjsejf63wpju__28647.0420346179$1498030832$gmane$org@phenom.ffwll.local>
References: <1497986735-14418-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1497986735-14418-1-git-send-email-peda@axentia.se>
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
Cc: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Philippe Cornu <philippe.cornu@st.com>, Yannick Fertre <yannick.fertre@st.com>, Ben Skeggs <bskeggs@redhat.com>, amd-gfx@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, virtualization@lists.linux-foundation.org, Vincent Abriou <vincent.abriou@st.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 20, 2017 at 09:25:24PM +0200, Peter Rosin wrote:
> Hi!
> 
> While trying to get CLUT support for the atmel_hlcdc driver, and
> specifically for the emulated fbdev interface, I received some
> push-back that my feeble in-driver attempts should be solved
> by the core. This is my attempt to do it right.
> 
> Boris and Daniel, was this approximately what you had in mind?

Yeah, this is awesome. I tried to do it a few times myself, but always
failed (also due to lack of real use-case on my side).

> I have obviously not tested all of this with more than a compile,
> but the first patch is enough to make the atmel-hlcdc driver
> do what I need. The rest is just lots of removals and cleanup
> made possible by the improved core.

If it works for you it's imo good enough. Not sure anyone else really
cares about fbdev lut support at all. I have a few comments on the first
patch, but once that's sorted, and once we have given driver maintainers
enough time to ack I think I'll merge the entire pile into drm-misc.

Nice work, thanks for doing it.

Cheers, Daniel

> Please test, I would not be surprised if I have fouled up some
> bit-manipulation somewhere in this mostly mechanical change...
> 
> Cheers,
> peda
> 
> Peter Rosin (11):
>   drm/fb-helper: do a generic fb_setcmap helper in terms of crtc
>     .gamma_set
>   drm: amd: remove dead code and pointless local lut storage
>   drm: ast: remove dead code and pointless local lut storage
>   drm: cirrus: remove dead code and pointless local lut storage
>   dmr: gma500: remove dead code and pointless local lut storage
>   drm: i915: remove dead code and pointless local lut storage
>   drm: mgag200: remove dead code and pointless local lut storage
>   drm: nouveau: remove dead code and pointless local lut storage
>   drm: radeon: remove dead code and pointless local lut storage
>   drm: stm: remove dead code and pointless local lut storage
>   drm: remove unused and redundant callbacks
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c      |  24 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |   1 -
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c      |  27 ++----
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c      |  27 ++----
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c       |  27 ++----
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c       |  27 ++----
>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c    |  23 -----
>  drivers/gpu/drm/ast/ast_drv.h               |   1 -
>  drivers/gpu/drm/ast/ast_fb.c                |  20 -----
>  drivers/gpu/drm/ast/ast_mode.c              |  26 ++----
>  drivers/gpu/drm/cirrus/cirrus_drv.h         |   8 --
>  drivers/gpu/drm/cirrus/cirrus_fbdev.c       |   2 -
>  drivers/gpu/drm/cirrus/cirrus_mode.c        |  71 ++++-----------
>  drivers/gpu/drm/drm_fb_helper.c             | 131 +++++++++-------------------
>  drivers/gpu/drm/gma500/framebuffer.c        |  22 -----
>  drivers/gpu/drm/gma500/gma_display.c        |  32 +++----
>  drivers/gpu/drm/gma500/psb_intel_display.c  |   7 +-
>  drivers/gpu/drm/gma500/psb_intel_drv.h      |   1 -
>  drivers/gpu/drm/i915/intel_drv.h            |   1 -
>  drivers/gpu/drm/i915/intel_fbdev.c          |  31 -------
>  drivers/gpu/drm/mgag200/mgag200_drv.h       |   5 --
>  drivers/gpu/drm/mgag200/mgag200_fb.c        |   2 -
>  drivers/gpu/drm/mgag200/mgag200_mode.c      |  62 ++++---------
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c     |  26 ++----
>  drivers/gpu/drm/nouveau/nouveau_crtc.h      |   3 -
>  drivers/gpu/drm/nouveau/nouveau_fbcon.c     |  22 -----
>  drivers/gpu/drm/nouveau/nv50_display.c      |  39 +++------
>  drivers/gpu/drm/radeon/atombios_crtc.c      |   1 -
>  drivers/gpu/drm/radeon/radeon_connectors.c  |   7 +-
>  drivers/gpu/drm/radeon/radeon_display.c     |  71 ++++++---------
>  drivers/gpu/drm/radeon/radeon_fb.c          |   2 -
>  drivers/gpu/drm/radeon/radeon_legacy_crtc.c |   1 -
>  drivers/gpu/drm/stm/ltdc.c                  |  12 ---
>  drivers/gpu/drm/stm/ltdc.h                  |   1 -
>  include/drm/drm_fb_helper.h                 |  32 -------
>  include/drm/drm_modeset_helper_vtables.h    |  16 ----
>  36 files changed, 171 insertions(+), 640 deletions(-)
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
