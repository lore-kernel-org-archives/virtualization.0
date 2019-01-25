From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 01/26] drm/irq: Don't check for DRIVER_HAVE_IRQ in
	drm_irq_(un)install
Date: Fri, 25 Jan 2019 15:09:00 +0000
Message-ID: <CACvgo52A2Cb3RLRZdGopcbUb6424XnVJkU2PYC0sJGFie4ueyg__43675.3363160946$1548442310$gmane$org@mail.gmail.com>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
	<20190124165831.16427-2-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190124165831.16427-2-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, linux-renesas-soc@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>, spice-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, linux-amlogic@lists.infradead.org, freedreno@lists.freedesktop.org, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 24 Jan 2019 at 16:58, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> If a non-legacy driver calls these it's valid to assume there is
> interrupt support. The flag is really only needed for legacy drivers.

... legacy drivers which issue the IRQ via the DRM_IOCTL_CONTROL legacy IOCTL.

At a later stage, we might as well add LEGACY to the name:
DRIVER_LEGACY_HAVE_IRQ?


>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      | 2 +-
>  drivers/gpu/drm/arm/hdlcd_drv.c              | 2 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 2 +-
>  drivers/gpu/drm/drm_irq.c                    | 6 ------
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c    | 2 +-
>  drivers/gpu/drm/gma500/psb_drv.c             | 2 +-
>  drivers/gpu/drm/i915/i915_drv.c              | 2 +-
>  drivers/gpu/drm/meson/meson_drv.c            | 2 +-
>  drivers/gpu/drm/msm/msm_drv.c                | 3 +--
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c            | 3 +--
>  drivers/gpu/drm/qxl/qxl_drv.c                | 2 +-
>  drivers/gpu/drm/radeon/radeon_drv.c          | 2 +-
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c     | 2 +-
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c          | 2 +-
>  drivers/gpu/drm/vc4/vc4_drv.c                | 1 -
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c          | 2 +-
>  drivers/staging/vboxvideo/vbox_drv.c         | 2 +-

Local grep shows one more non-legacy entry in
drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c

With that file addressed and trivial comment additions, patches: 1, 2,
3 and 26 are
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

HTH
Emil
