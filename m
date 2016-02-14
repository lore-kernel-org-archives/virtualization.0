From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 01/17] drm/virtio: removed optional dummy encoder
	mode_fixup function.
Date: Sun, 14 Feb 2016 19:25:08 +0100
Message-ID: <20160214182508.GF11240__9134.32038291848$1455474301$gmane$org@phenom.ffwll.local>
References: <daniel.vetter@ffwll.ch,>
	<1455285069-2819-1-git-send-email-palminha@synopsys.com>
	<1455285069-2819-2-git-send-email-palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1455285069-2819-2-git-send-email-palminha@synopsys.com>
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

On Fri, Feb 12, 2016 at 01:50:53PM +0000, Carlos Palminha wrote:

Sob-line from you is missing on all patches, I can't merge them. Also
please copypaste a default blurb to all patches that this is only recently
no longer needed. And dunno what happened to your patch series, the
threading is somehow broken. In case your mail server doesn't accept a big
patch series you can first format .patch files using git format-patch with
threading enabled (should be the default) and then send them out in
chunks.

When resending please also add the r-b tag from Alex for amdgpu/radoen.

Thanks, Daniel

> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index a165f03..429aa31 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -282,13 +282,6 @@ static const struct drm_crtc_helper_funcs virtio_gpu_crtc_helper_funcs = {
>  	.atomic_check  = virtio_gpu_crtc_atomic_check,
>  };
>  
> -static bool virtio_gpu_enc_mode_fixup(struct drm_encoder *encoder,
> -				      const struct drm_display_mode *mode,
> -				      struct drm_display_mode *adjusted_mode)
> -{
> -	return true;
> -}
> -
>  static void virtio_gpu_enc_mode_set(struct drm_encoder *encoder,
>  				    struct drm_display_mode *mode,
>  				    struct drm_display_mode *adjusted_mode)
> @@ -362,7 +355,6 @@ virtio_gpu_best_encoder(struct drm_connector *connector)
>  }
>  
>  static const struct drm_encoder_helper_funcs virtio_gpu_enc_helper_funcs = {
> -	.mode_fixup = virtio_gpu_enc_mode_fixup,
>  	.mode_set   = virtio_gpu_enc_mode_set,
>  	.enable     = virtio_gpu_enc_enable,
>  	.disable    = virtio_gpu_enc_disable,
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
