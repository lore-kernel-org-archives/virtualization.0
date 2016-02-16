From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 01/16] drm: fixes crct set_mode when crtc mode_fixup is
	null.
Date: Tue, 16 Feb 2016 20:37:29 +0300
Message-ID: <56C35E59.8070805@cogentembedded.com>
References: <cover.1455630967.git.palminha@synopsys.com>
	<9d41105dee6632b4bb50e9555f2196ac249b9fce.1455630967.git.palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9d41105dee6632b4bb50e9555f2196ac249b9fce.1455630967.git.palminha@synopsys.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, airlied@linux.ie, dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch, patrik.r.jakobsson@gmail.com, virtualization@lists.linux-foundation.org
Cc: nicolas.pitre@linaro.org, boris.brezillon@free-electrons.com, jianwei.wang.chn@gmail.com, jani.nikula@intel.com, alison.wang@freescale.com, linux-renesas-soc@vger.kernel.org, laurent.pinchart@ideasonboard.com, benjamin.gaignard@linaro.org, vincent.abriou@st.com, sudipm.mukherjee@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Hello.

On 02/16/2016 05:10 PM, Carlos Palminha wrote:

> This patch set nukes all the dummy crtc mode_fixup implementations.
> (made on top of Daniel topic/drm-misc branch)
>
> Signed-off-by: Carlos Palminha <palminha@synopsys.com>
> ---
>   drivers/gpu/drm/drm_crtc_helper.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
> index e70d064..7539eea 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> @@ -343,9 +343,12 @@ bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
>   		}
>   	}
>
> -	if (!(ret = crtc_funcs->mode_fixup(crtc, mode, adjusted_mode))) {
> -		DRM_DEBUG_KMS("CRTC fixup failed\n");
> -		goto done;
> +	if (crtc_funcs->mode_fixup) {
> +		if (!(ret = crtc_funcs->mode_fixup(crtc, mode,
> +						adjusted_mode))) {

    You haven't run the patch thru scripts/checkpatch.pl, have you? :-)
(It curses on assignment inside the *if* expression.)

[...]

MBR, Sergei
