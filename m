From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 00/23] drm: Eliminate plane->fb/crtc usage for atomic
	drivers
Date: Tue, 27 Mar 2018 10:21:44 +0200
Message-ID: <20180327082144.GQ14155__26621.3887175129$1522138814$gmane$org@phenom.ffwll.local>
References: <20180322152313.6561-1-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180322152313.6561-1-ville.syrjala@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk, Eric Anholt <eric@anholt.net>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Dave Airlie <airlied@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thomas Hellstrom <thellstrom@vmware.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Sinclair Yeh <syeh@vmware.com>, Rob Clark <robdclark@gmail.com>, amd-gfx@lists.freedesktop.org, martin.peres@free.fr, VMware Graphics <linux-graphics-maintainer@vmware.com>, Harry Wentland <harry.wentland@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Inki Dae <inki.dae@samsung.com>, virtualization@lists.linux-foundation.org, Vincent Abriou <vincent.abriou@st.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 22, 2018 at 05:22:50PM +0200, Ville Syrjala wrote:
> From: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> =

> I really just wanted to fix i915 to re-enable its planes afer load
> detection (a two line patch). This is what I actually ended up with
> after I ran into a framebuffer refcount leak with said two line patch.
> =

> I've tested this on a few i915 boxes and so far it's looking
> good. Everything else is just compile tested.
> =

> Entire series available here:
> git://github.com/vsyrjala/linux.git plane_fb_crtc_nuke
> =

> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: chris@chris-wilson.co.uk
> Cc: "Christian K=F6nig" <christian.koenig@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: freedreno@lists.freedesktop.org
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: martin.peres@free.fr
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sinclair Yeh <syeh@vmware.com>
> Cc: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: Vincent Abriou <vincent.abriou@st.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
> =

> Ville Syrj=E4l=E4 (23):
>   Revert "drm/atomic-helper: Fix leak in disable_all"
>   drm/atomic-helper: Make drm_atomic_helper_disable_all() update the
>     plane->fb pointers
>   drm: Clear crtc->primary->crtc when disabling the crtc via setcrtc()
>   drm/atomic-helper: WARN if legacy plane fb pointers are bogus when
>     committing duplicated state
>   drm: Add local 'plane' variable for primary/cursor planes
>   drm: Adjust whitespace for legibility
>   drm: Make the fb refcount handover less magic
>   drm: Use plane->state->fb over plane->fb
>   drm/i915: Stop consulting plane->fb
>   drm/msm: Stop consulting plane->fb
>   drm/sti: Stop consulting plane->fb
>   drm/vmwgfx: Stop consulting plane->fb
>   drm/zte: Stop consulting plane->fb
>   drm/atmel-hlcdc: Stop using plane->fb
>   drm: Stop updating plane->crtc/fb/old_fb on atomic drivers
>   drm/amdgpu/dc: Stop updating plane->fb
>   drm/i915: Stop updating plane->fb/crtc
>   drm/exynos: Stop updating plane->crtc
>   drm/msm: Stop updating plane->fb/crtc
>   drm/virtio: Stop updating plane->fb
>   drm/vc4: Stop updating plane->fb/crtc
>   drm/i915: Restore planes after load detection
>   drm/i915: Make force_load_detect effective even w/ DMI quirks/hotplug

Ok, I reviewed the core patches, looks all good.

Also starting auditing all the drivers. I think there's some small
oversights in there, and I need to update my grep foo a bit, but by and
large looks all reasonable.

Imo we should start merging, that will also make the auditing easier.
-Daniel

> =

>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 -
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 12 +---
>  drivers/gpu/drm/drm_atomic.c                      | 55 ++--------------
>  drivers/gpu/drm/drm_atomic_helper.c               | 79 ++++++++++-------=
------
>  drivers/gpu/drm/drm_crtc.c                        | 51 ++++++++++-----
>  drivers/gpu/drm/drm_fb_helper.c                   |  7 --
>  drivers/gpu/drm/drm_framebuffer.c                 |  5 --
>  drivers/gpu/drm/drm_plane.c                       | 64 +++++++++++-------
>  drivers/gpu/drm/drm_plane_helper.c                |  4 +-
>  drivers/gpu/drm/exynos/exynos_drm_plane.c         |  2 -
>  drivers/gpu/drm/i915/intel_crt.c                  |  6 ++
>  drivers/gpu/drm/i915/intel_display.c              |  9 +--
>  drivers/gpu/drm/i915/intel_fbdev.c                |  2 +-
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c         |  3 +-
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c        |  2 -
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c        |  2 -
>  drivers/gpu/drm/sti/sti_plane.c                   |  9 +--
>  drivers/gpu/drm/vc4/vc4_crtc.c                    |  3 -
>  drivers/gpu/drm/virtio/virtgpu_display.c          |  2 -
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c               |  6 +-
>  drivers/gpu/drm/zte/zx_vou.c                      |  2 +-
>  include/drm/drm_atomic.h                          |  3 -
>  22 files changed, 143 insertions(+), 187 deletions(-)
> =

> -- =

> 2.16.1
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
