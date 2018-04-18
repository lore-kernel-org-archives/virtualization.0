From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drm: Print unadorned pointers
Date: Wed, 18 Apr 2018 17:52:09 +0200
Message-ID: <20180418155209.GA1634__38593.6069921174$1524066641$gmane$org@kroah.com>
References: <20180418092450.13798-1-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180418092450.13798-1-abrodkin@synopsys.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: amd-gfx@lists.freedesktop.org, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Tom Lendacky <thomas.lendacky@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, dri-devel@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, Cihangir Akturk <cakturk@gmail.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Sinclair Yeh <syeh@vmware.com>, Vincent Abriou <vincent.abriou@st.com>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Sandy Huang <hjc@rock-chips.com>, Roger He <Hongbo.He@amd.com>, Gustavo Padovan <gustavo@pado>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 18, 2018 at 12:24:50PM +0300, Alexey Brodkin wrote:
> After commit ad67b74 ("printk: hash addresses printed with %p")
> pointers are being hashed when printed. However, this makes
> debug output completely useless. Switch to %px in order to see the
> unadorned kernel pointers.
> =

> This was done with the following one-liner:
>  find drivers/gpu/drm -type f -name "*.c" -exec sed -r -i '/DRM_DEBUG|KER=
N_DEBUG|pr_debug/ s/%p\b/%px/g' {} +
> =

> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tobin C. Harding <me@tobin.cc>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: "Christian K=F6nig" <christian.koenig@amd.com>
> Cc: Cihangir Akturk <cakturk@gmail.com>
> Cc: CK Hu <ck.hu@mediatek.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: "Heiko St=FCbner" <heiko@sntech.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: "Michel D=E4nzer" <michel.daenzer@amd.com>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Roger He <Hongbo.He@amd.com>
> Cc: Roman Li <Roman.Li@amd.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Samuel Li <Samuel.Li@amd.com>
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Shirish S <shirish.s@amd.com>
> Cc: Sinclair Yeh <syeh@vmware.com>
> Cc: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Tony Cheng <Tony.Cheng@amd.com>
> Cc: Vincent Abriou <vincent.abriou@st.com>
> Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: etnaviv@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 14 +++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c            |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c            | 10 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c            |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c             | 18 ++++-----
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 14 +++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  2 +-
>  drivers/gpu/drm/armada/armada_gem.c                | 12 +++---
>  drivers/gpu/drm/drm_atomic.c                       | 44 +++++++++++-----=
------
>  drivers/gpu/drm/drm_bufs.c                         |  8 ++--
>  drivers/gpu/drm/drm_dp_mst_topology.c              |  4 +-
>  drivers/gpu/drm/drm_lease.c                        |  6 +--
>  drivers/gpu/drm/drm_lock.c                         |  2 +-
>  drivers/gpu/drm/drm_scatter.c                      |  4 +-
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c              |  6 +--
>  drivers/gpu/drm/i810/i810_dma.c                    |  2 +-
>  drivers/gpu/drm/i915/i915_perf.c                   |  2 +-
>  drivers/gpu/drm/i915/intel_display.c               |  2 +-
>  drivers/gpu/drm/i915/intel_guc_ct.c                |  4 +-
>  drivers/gpu/drm/i915/intel_guc_submission.c        |  2 +-
>  drivers/gpu/drm/i915/intel_uc_fw.c                 |  2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c             |  2 +-
>  drivers/gpu/drm/mga/mga_warp.c                     |  2 +-
>  drivers/gpu/drm/msm/msm_drv.c                      |  4 +-
>  drivers/gpu/drm/qxl/qxl_cmd.c                      |  4 +-
>  drivers/gpu/drm/qxl/qxl_fb.c                       |  2 +-
>  drivers/gpu/drm/qxl/qxl_ttm.c                      |  2 +-
>  drivers/gpu/drm/radeon/radeon_display.c            |  2 +-
>  drivers/gpu/drm/radeon/radeon_dp_mst.c             | 12 +++---
>  drivers/gpu/drm/radeon/radeon_object.c             |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c      |  2 +-
>  drivers/gpu/drm/savage/savage_bci.c                |  2 +-
>  drivers/gpu/drm/sti/sti_gdp.c                      |  4 +-
>  drivers/gpu/drm/sti/sti_mixer.c                    |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_crtc.c                 |  4 +-
>  drivers/gpu/drm/ttm/ttm_page_alloc.c               |  2 +-
>  drivers/gpu/drm/udl/udl_fb.c                       |  2 +-
>  drivers/gpu/drm/via/via_dma.c                      |  4 +-
>  drivers/gpu/drm/via/via_irq.c                      |  2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c            |  2 +-
>  45 files changed, 120 insertions(+), 120 deletions(-)
> =

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 1d6e1479da38..32e85fe83152 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -438,7 +438,7 @@ static int add_bo_to_vm(struct amdgpu_device *adev, s=
truct kgd_mem *mem,
>  	if (!bo_va_entry)
>  		return -ENOMEM;
>  =

> -	pr_debug("\t add VA 0x%llx - 0x%llx to vm %p\n", va,
> +	pr_debug("\t add VA 0x%llx - 0x%llx to vm %px\n", va,
>  			va + bo_size, vm);
>  =

>  	/* Add BO to VM internal data structures*/

<snip>

As others have pointed out, please do not do this.  Use %pK as needed.
And perhaps revisit some of the "need" for these pointers at all in the
first place...

thanks,

greg k-h
