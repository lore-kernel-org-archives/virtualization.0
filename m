From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH][next] drm: Replace zero-length array with flexible-array member
Date: Tue, 25 Feb 2020 16:17:35 +0200
Message-ID: <87a756sqdc.fsf@intel.com>
References: <20200225140347.GA22864@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200225140347.GA22864@embeddedor>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Eric Anholt <eric@anholt.net>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Thomas Hellstrom <thellstrom@vmware.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 25 Feb 2020, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.h         | 2 +-
>  drivers/gpu/drm/gma500/intel_bios.h           | 2 +-
>  drivers/gpu/drm/i915/display/intel_vbt_defs.h | 4 ++--
>  drivers/gpu/drm/i915/gt/intel_lrc.c           | 2 +-
>  drivers/gpu/drm/i915/i915_gpu_error.h         | 2 +-

Please split out the i915 changes to a separate patch.

>  drivers/gpu/drm/msm/msm_gem.h                 | 2 +-
>  drivers/gpu/drm/qxl/qxl_cmd.c                 | 2 +-
>  drivers/gpu/drm/vboxvideo/vboxvideo.h         | 2 +-
>  drivers/gpu/drm/vc4/vc4_drv.h                 | 2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c    | 2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c       | 2 +-
>  include/drm/bridge/mhl.h                      | 4 ++--
>  include/drm/drm_displayid.h                   | 2 +-
>  include/uapi/drm/i915_drm.h                   | 4 ++--

Not sure it's worth touching uapi headers. They're full of both [0] and
[]. Again, please at least split it to a separate patch to be decided
separately.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
