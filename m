From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm: Split out drm_probe_helper.h
Date: Tue, 15 Jan 2019 22:30:11 -0500
Message-ID: <CADnq5_Oa0dj1+eOcAF6QxVxy0XRXNggZT+4K=Cm_=G80V-ejGQ__28264.9944223978$1547692446$gmane$org@mail.gmail.com>
References: <20190115104137.25695-1-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190115104137.25695-1-daniel.vetter@ffwll.ch>
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
Cc: nouveau <nouveau@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>, linux-rockchip@lists.infradead.org, spice-devel@lists.freedesktop.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, etnaviv@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@l
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 15, 2019 at 5:41 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> Having the probe helper stuff (which pretty much everyone needs) in
> the drm_crtc_helper.h file (which atomic drivers should never need) is
> confusing. Split them out.
>
> To make sure I actually achieved the goal here I went through all
> drivers. And indeed, all atomic drivers are now free of
> drm_crtc_helper.h includes.
>
> v2: Make it compile. There was so much compile fail on arm drivers
> that I figured I'll better not include any of the acks on v1.
>
> v3: Massive rebase because i915 has lost a lot of drmP.h includes, but
> not all: Through drm_crtc_helper.h > drm_modeset_helper.h -> drmP.h
> there was still one, which this patch largely removes. Which means
> rolling out lots more includes all over.
>
> This will also conflict with ongoing drmP.h cleanup by others I
> expect.
>
> v3: Rebase on top of atomic bochs.
>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com> (v2)
> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org> (v2)
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: etnaviv@lists.freedesktop.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: spice-devel@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-tegra@vger.kernel.org
> Cc: xen-devel@lists.xen.org
> ---
> Merging this is going to be a bit a mess due to all the ongoing drmP.h
> cleanups. I think the following should work:
> - Apply Sam's prep patches for removing drmP.h from
>   drm_modeset_helper.h
> - Get the i915 drmP.h cleanup backmerged into drm-misc-next
> - Apply this patch.
> - Apply Sam's patch to remove drmP.h from drm_modeset_helper.h
> - All through drm-misc-next, which has some potential for trivial
>   conflicts around #includes with other drivers unfortunately.
>
> I hope there's no other driver who'll blow up accidentally because
> someone else is doing a drmP.h cleanup. Laurent maybe?
>
> Jani, ack on this?
> -Daniel

amdgpu and radeon:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
