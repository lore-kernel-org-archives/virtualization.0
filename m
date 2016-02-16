From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 00/17] drm encoders cleanup: nuke optional dummy
	encoder mode_fixup function.
Date: Tue, 16 Feb 2016 15:38:21 +0100
Message-ID: <20160216143821.GG32705__9210.04999331689$1455633489$gmane$org@phenom.ffwll.local>
References: <cover.1455540137.git.palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1455540137.git.palminha@synopsys.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Cc: k.kozlowski@samsung.com, linux-samsung-soc@vger.kernel.org, jingoohan1@gmail.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-rockchip@lists.infradead.org, kgene@kernel.org, benjamin.gaignard@linaro.org, vincent.abriou@st.com, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 15, 2016 at 12:57:04PM +0000, Carlos Palminha wrote:
> mode_fixup function for encoder drivers became optional with patch
> http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha@synopsys.com
> 
> This patch set nukes all the dummy mode_fixup implementations.
> 
> (made on top of Daniel topic/drm-misc branch)
> 
> Changes v1->v2: incorporated Daniel comments
> * added signed-off-by line to all patches
> * threading enabled due to e-mail server constraints
> * common blurb lines to all patches
> * add reviewed by Alex, to patches 4 and 14

I've thrown them all into a topic branch for soaking, and plan to merge
into drm-misc in the next few days.

Thanks, Daniel

> 
> Carlos Palminha (17):
>   drm/virtio: removed optional dummy encoder mode_fixup function.
>   drm/udl: removed optional dummy encoder mode_fixup function.
>   drm/exynos: removed optional dummy encoder mode_fixup function.
>   drm/amdgpu: removed optional dummy encoder mode_fixup function.
>   drm/ast: removed optional dummy encoder mode_fixup function.
>   drm/bochs: removed optional dummy encoder mode_fixup function.
>   drm/cirrus: removed optional dummy encoder mode_fixup function.
>   drm/exynos: removed optional dummy encoder mode_fixup function.
>   drm/gma500: removed optional dummy encoder mode_fixup function.
>   drm/imx: removed optional dummy encoder mode_fixup function.
>   drm/msm/mdp: removed optional dummy encoder mode_fixup function.
>   drm/mgag200: removed optional dummy encoder mode_fixup function.
>   drm/qxl: removed optional dummy encoder mode_fixup function.
>   drm/radeon: removed optional dummy encoder mode_fixup function.
>   drm/rockchip: removed optional dummy encoder mode_fixup function.
>   drm/sti: removed optional dummy encoder mode_fixup function.
>   drm/tilcdc: removed optional dummy encoder mode_fixup function.
> 
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c           |  8 --------
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c           |  8 --------
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c            |  8 --------
>  drivers/gpu/drm/ast/ast_mode.c                   |  8 --------
>  drivers/gpu/drm/bochs/bochs_kms.c                |  8 --------
>  drivers/gpu/drm/cirrus/cirrus_mode.c             |  9 ---------
>  drivers/gpu/drm/exynos/exynos_dp_core.c          |  8 --------
>  drivers/gpu/drm/exynos/exynos_drm_dpi.c          |  8 --------
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c          |  8 --------
>  drivers/gpu/drm/exynos/exynos_drm_vidi.c         |  8 --------
>  drivers/gpu/drm/gma500/cdv_intel_crt.c           |  1 -
>  drivers/gpu/drm/gma500/cdv_intel_hdmi.c          |  1 -
>  drivers/gpu/drm/gma500/gma_display.c             |  7 -------
>  drivers/gpu/drm/gma500/gma_display.h             |  3 ---
>  drivers/gpu/drm/gma500/oaktrail_hdmi.c           |  1 -
>  drivers/gpu/drm/imx/dw_hdmi-imx.c                |  8 --------
>  drivers/gpu/drm/imx/imx-ldb.c                    |  8 --------
>  drivers/gpu/drm/imx/imx-tve.c                    |  8 --------
>  drivers/gpu/drm/imx/parallel-display.c           |  8 --------
>  drivers/gpu/drm/mgag200/mgag200_mode.c           |  8 --------
>  drivers/gpu/drm/msm/mdp/mdp4/mdp4_dsi_encoder.c  |  8 --------
>  drivers/gpu/drm/msm/mdp/mdp4/mdp4_dtv_encoder.c  |  8 --------
>  drivers/gpu/drm/msm/mdp/mdp4/mdp4_lcdc_encoder.c |  8 --------
>  drivers/gpu/drm/msm/mdp/mdp5/mdp5_cmd_encoder.c  |  9 ---------
>  drivers/gpu/drm/msm/mdp/mdp5/mdp5_encoder.c      |  8 --------
>  drivers/gpu/drm/qxl/qxl_display.c                |  9 ---------
>  drivers/gpu/drm/radeon/atombios_encoders.c       |  8 --------
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c           |  8 --------
>  drivers/gpu/drm/sti/sti_tvout.c                  | 10 ----------
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c            |  9 ---------
>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.c           |  9 ---------
>  drivers/gpu/drm/udl/udl_encoder.c                |  8 --------
>  drivers/gpu/drm/virtio/virtgpu_display.c         |  8 --------
>  33 files changed, 244 deletions(-)
> 
> -- 
> 2.5.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
