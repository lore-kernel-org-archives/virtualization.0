From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Subject: Re: [PATCH 05/16] drm/gma: removed optional dummy crtc mode_fixup
	function.
Date: Mon, 7 Mar 2016 15:31:02 +0100
Message-ID: <CAMeQTsZe1JfvsOb8TkLVOSHcvLcsB5GkPKe-VfGL-F45zvE_Sg__37486.6696460687$1457361082$gmane$org@mail.gmail.com>
References: <cover.1455630967.git.palminha@synopsys.com>
	<fc5717ec27bea9b114e48b9d3de1512cf48f44b6.1455630967.git.palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <fc5717ec27bea9b114e48b9d3de1512cf48f44b6.1455630967.git.palminha@synopsys.com>
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
Cc: nicolas.pitre@linaro.org, boris.brezillon@free-electrons.com, jianwei.wang.chn@gmail.com, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, alison.wang@freescale.com, dri-devel <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, vincent.abriou@st.com, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 16, 2016 at 3:17 PM, Carlos Palminha
<CARLOS.PALMINHA@synopsys.com> wrote:
> This patch set nukes all the dummy crtc mode_fixup implementations.
> (made on top of Daniel topic/drm-misc branch)
>
> Signed-off-by: Carlos Palminha <palminha@synopsys.com>

You should try to avoid mixing code style fixes with functional
changes but in case of gma500 it's hard to resist. No need to change
this.

This might already have been merged but if not:

Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

> ---
>  drivers/gpu/drm/gma500/cdv_intel_display.c   | 13 ++++++-------
>  drivers/gpu/drm/gma500/gma_display.c         |  7 -------
>  drivers/gpu/drm/gma500/gma_display.h         |  3 ---
>  drivers/gpu/drm/gma500/mdfld_intel_display.c |  2 --
>  drivers/gpu/drm/gma500/oaktrail_crtc.c       |  1 -
>  drivers/gpu/drm/gma500/psb_intel_display.c   |  1 -
>  6 files changed, 6 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_display.c b/drivers/gpu/drm/gma500/cdv_intel_display.c
> index 6126546..17db4b4 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_display.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_display.c
> @@ -116,7 +116,7 @@ static const struct gma_limit_t cdv_intel_limits[] = {
>          .p1 = {.min = 1, .max = 10},
>          .p2 = {.dot_limit = 225000, .p2_slow = 10, .p2_fast = 10},
>          .find_pll = cdv_intel_find_dp_pll,
> -        }
> +       }
>  };
>
>  #define _wait_for(COND, MS, W) ({ \
> @@ -245,7 +245,7 @@ cdv_dpll_set_clock_cdv(struct drm_device *dev, struct drm_crtc *crtc,
>         /* We don't know what the other fields of these regs are, so
>          * leave them in place.
>          */
> -       /*
> +       /*
>          * The BIT 14:13 of 0x8010/0x8030 is used to select the ref clk
>          * for the pipe A/B. Display spec 1.06 has wrong definition.
>          * Correct definition is like below:
> @@ -256,7 +256,7 @@ cdv_dpll_set_clock_cdv(struct drm_device *dev, struct drm_crtc *crtc,
>          *
>          * if DPLLA sets 01 and DPLLB sets 02, both use clk from DPLLA
>          *
> -        */
> +        */
>         ret = cdv_sb_read(dev, ref_sfr, &ref_value);
>         if (ret)
>                 return ret;
> @@ -646,7 +646,7 @@ static int cdv_intel_crtc_mode_set(struct drm_crtc *crtc,
>                  * for DP/eDP. When using SSC clock, the ref clk is 100MHz.Otherwise
>                  * it will be 27MHz. From the VBIOS code it seems that the pipe A choose
>                  * 27MHz for DP/eDP while the Pipe B chooses the 100MHz.
> -                */
> +                */
>                 if (pipe == 0)
>                         refclk = 27000;
>                 else
> @@ -659,7 +659,7 @@ static int cdv_intel_crtc_mode_set(struct drm_crtc *crtc,
>         }
>
>         drm_mode_debug_printmodeline(adjusted_mode);
> -
> +
>         limit = gma_crtc->clock_funcs->limit(crtc, refclk);
>
>         ok = limit->find_pll(limit, crtc, adjusted_mode->clock, refclk,
> @@ -721,7 +721,7 @@ static int cdv_intel_crtc_mode_set(struct drm_crtc *crtc,
>                         pipeconf |= PIPE_6BPC;
>         } else
>                 pipeconf |= PIPE_8BPC;
> -
> +
>         /* Set up the display plane register */
>         dspcntr = DISPPLANE_GAMMA_ENABLE;
>
> @@ -974,7 +974,6 @@ struct drm_display_mode *cdv_intel_crtc_mode_get(struct drm_device *dev,
>
>  const struct drm_crtc_helper_funcs cdv_intel_helper_funcs = {
>         .dpms = gma_crtc_dpms,
> -       .mode_fixup = gma_crtc_mode_fixup,
>         .mode_set = cdv_intel_crtc_mode_set,
>         .mode_set_base = gma_pipe_set_base,
>         .prepare = gma_crtc_prepare,
> diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
> index ff17af4..d6a5c77 100644
> --- a/drivers/gpu/drm/gma500/gma_display.c
> +++ b/drivers/gpu/drm/gma500/gma_display.c
> @@ -485,13 +485,6 @@ bool gma_encoder_mode_fixup(struct drm_encoder *encoder,
>         return true;
>  }
>
> -bool gma_crtc_mode_fixup(struct drm_crtc *crtc,
> -                        const struct drm_display_mode *mode,
> -                        struct drm_display_mode *adjusted_mode)
> -{
> -       return true;
> -}
> -
>  void gma_crtc_prepare(struct drm_crtc *crtc)
>  {
>         const struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
> diff --git a/drivers/gpu/drm/gma500/gma_display.h b/drivers/gpu/drm/gma500/gma_display.h
> index ed569d8..fc64241 100644
> --- a/drivers/gpu/drm/gma500/gma_display.h
> +++ b/drivers/gpu/drm/gma500/gma_display.h
> @@ -75,9 +75,6 @@ extern void gma_crtc_load_lut(struct drm_crtc *crtc);
>  extern void gma_crtc_gamma_set(struct drm_crtc *crtc, u16 *red, u16 *green,
>                                u16 *blue, u32 start, u32 size);
>  extern void gma_crtc_dpms(struct drm_crtc *crtc, int mode);
> -extern bool gma_crtc_mode_fixup(struct drm_crtc *crtc,
> -                               const struct drm_display_mode *mode,
> -                               struct drm_display_mode *adjusted_mode);
>  extern void gma_crtc_prepare(struct drm_crtc *crtc);
>  extern void gma_crtc_commit(struct drm_crtc *crtc);
>  extern void gma_crtc_disable(struct drm_crtc *crtc);
> diff --git a/drivers/gpu/drm/gma500/mdfld_intel_display.c b/drivers/gpu/drm/gma500/mdfld_intel_display.c
> index acd3834..92e3f93e 100644
> --- a/drivers/gpu/drm/gma500/mdfld_intel_display.c
> +++ b/drivers/gpu/drm/gma500/mdfld_intel_display.c
> @@ -1026,10 +1026,8 @@ mrst_crtc_mode_set_exit:
>
>  const struct drm_crtc_helper_funcs mdfld_helper_funcs = {
>         .dpms = mdfld_crtc_dpms,
> -       .mode_fixup = gma_crtc_mode_fixup,
>         .mode_set = mdfld_crtc_mode_set,
>         .mode_set_base = mdfld__intel_pipe_set_base,
>         .prepare = gma_crtc_prepare,
>         .commit = gma_crtc_commit,
>  };
> -
> diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> index 1048f0c..da9fd34 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> @@ -657,7 +657,6 @@ pipe_set_base_exit:
>
>  const struct drm_crtc_helper_funcs oaktrail_helper_funcs = {
>         .dpms = oaktrail_crtc_dpms,
> -       .mode_fixup = gma_crtc_mode_fixup,
>         .mode_set = oaktrail_crtc_mode_set,
>         .mode_set_base = oaktrail_pipe_set_base,
>         .prepare = gma_crtc_prepare,
> diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm/gma500/psb_intel_display.c
> index dcdbc37..398015b 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_display.c
> +++ b/drivers/gpu/drm/gma500/psb_intel_display.c
> @@ -430,7 +430,6 @@ struct drm_display_mode *psb_intel_crtc_mode_get(struct drm_device *dev,
>
>  const struct drm_crtc_helper_funcs psb_intel_helper_funcs = {
>         .dpms = gma_crtc_dpms,
> -       .mode_fixup = gma_crtc_mode_fixup,
>         .mode_set = psb_intel_crtc_mode_set,
>         .mode_set_base = gma_pipe_set_base,
>         .prepare = gma_crtc_prepare,
> --
> 2.5.0
>
