From: Sinclair Yeh <syeh@vmware.com>
Subject: Re: [PATCH v2 00/13] drm: Eliminate plane->fb/crtc usage for atomic
	drivers
Date: Wed, 30 May 2018 10:41:11 -0700
Message-ID: <20180530174110.GA26251@vmware.com>
References: <20180525185045.29689-1-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180525185045.29689-1-ville.syrjala@linux.intel.com>
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
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, amd-gfx@lists.freedesktop.org, VMware Graphics <linux-graphics-maintainer@vmware.com>, Harry Wentland <harry.wentland@amd.com>, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Deepak Rawat <drawat@vmware.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Rob Clark <robdclark@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, freedreno@lists.freedesktop.org, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

Thanks Ville.

This series: Reviewed-by: Sinclair Yeh <syeh@vmware.com>

On Fri, May 25, 2018 at 09:50:32PM +0300, Ville Syrjala wrote:
> From: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> =

> Here are again the last (?) bits of eliminating the plane->fb/crtc
> usage for atomic drivers. I've pushed everything else (thanks to
> everyone who reviewed them). =

> =

> Deepak said he'd tested the vmwgfx stuff, so I think it should be
> safe to land. Just missing a bit of review...
> =

> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: "Christian K=F6nig" <christian.koenig@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: David Airlie <airlied@linux.ie>
> Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
> Cc: Deepak Rawat <drawat@vmware.com>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: freedreno@lists.freedesktop.org
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Sinclair Yeh <syeh@vmware.com>
> Cc: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
> =

> Ville Syrj=E4l=E4 (13):
>   drm/vmwgfx: Stop using plane->fb in vmw_kms_atomic_check_modeset()
>   drm/vmwgfx: Stop using plane->fb in vmw_kms_helper_dirty()
>   drm/vmwgfx: Stop using plane->fb in vmw_kms_update_implicit_fb()
>   drm/vmwgfx: Stop updating plane->fb
>   drm/vmwgfx: Stop using plane->fb in atomic_enable()
>   drm/vmwgfx: Stop messing about with plane->fb/old_fb/crtc
>   drm/amdgpu/dc: Stop updating plane->fb
>   drm/i915: Stop updating plane->fb/crtc
>   drm/exynos: Stop updating plane->crtc
>   drm/msm: Stop updating plane->fb/crtc
>   drm/virtio: Stop updating plane->crtc
>   drm/vc4: Stop updating plane->fb/crtc
>   drm: Stop updating plane->crtc/fb/old_fb on atomic drivers
> =

>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 -
>  drivers/gpu/drm/drm_atomic.c                      | 55 +++--------------=
------
>  drivers/gpu/drm/drm_atomic_helper.c               | 15 +------
>  drivers/gpu/drm/drm_crtc.c                        |  8 +++-
>  drivers/gpu/drm/drm_fb_helper.c                   |  7 ---
>  drivers/gpu/drm/drm_framebuffer.c                 |  5 ---
>  drivers/gpu/drm/drm_plane.c                       | 14 +++---
>  drivers/gpu/drm/drm_plane_helper.c                |  4 +-
>  drivers/gpu/drm/exynos/exynos_drm_plane.c         |  2 -
>  drivers/gpu/drm/i915/intel_atomic_plane.c         | 12 -----
>  drivers/gpu/drm/i915/intel_display.c              |  7 ++-
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c         |  1 -
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c        |  2 -
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c         |  1 -
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c        |  2 -
>  drivers/gpu/drm/vc4/vc4_crtc.c                    |  3 --
>  drivers/gpu/drm/virtio/virtgpu_display.c          |  2 -
>  drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                | 24 ----------
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c               | 24 +++++++---
>  drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c              |  2 -
>  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c              |  5 +--
>  include/drm/drm_atomic.h                          |  3 --
>  22 files changed, 46 insertions(+), 154 deletions(-)
> =

> -- =

> 2.16.1
