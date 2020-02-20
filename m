From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 2/4] drm/ast: Use simple encoder
Date: Thu, 20 Feb 2020 20:09:43 +0100
Message-ID: <20200220190943.GB20011@ravnborg.org>
References: <20200218084815.2137-1-tzimmermann@suse.de>
 <20200218084815.2137-3-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200218084815.2137-3-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, virtualization@lists.linux-foundation.org, noralf@tronnes.org, daniel@ffwll.ch, alexander.deucher@amd.com, spice-devel@lists.freedesktop.org, emil.velikov@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Thomas.

On Tue, Feb 18, 2020 at 09:48:13AM +0100, Thomas Zimmermann wrote:
> The ast driver uses an empty implementation for its encoder. Replace
> the code with the generic simple encoder.
> 
> v2:
> 	* rebase onto new simple-encoder interface
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
From browsign the code - looks good:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam

> ---
>  drivers/gpu/drm/ast/ast_drv.h  |  6 +-----
>  drivers/gpu/drm/ast/ast_mode.c | 25 ++++++++-----------------
>  2 files changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
> index f5d8780776ae..656d591b154b 100644
> --- a/drivers/gpu/drm/ast/ast_drv.h
> +++ b/drivers/gpu/drm/ast/ast_drv.h
> @@ -121,6 +121,7 @@ struct ast_private {
>  		unsigned int next_index;
>  	} cursor;
>  
> +	struct drm_encoder encoder;
>  	struct drm_plane primary_plane;
>  	struct drm_plane cursor_plane;
>  
> @@ -238,13 +239,8 @@ struct ast_crtc {
>  	u8 offset_x, offset_y;
>  };
>  
> -struct ast_encoder {
> -	struct drm_encoder base;
> -};
> -
>  #define to_ast_crtc(x) container_of(x, struct ast_crtc, base)
>  #define to_ast_connector(x) container_of(x, struct ast_connector, base)
> -#define to_ast_encoder(x) container_of(x, struct ast_encoder, base)
>  
>  struct ast_vbios_stdtable {
>  	u8 misc;
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index 562ea6d9df13..7a9f20a2fd30 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -40,6 +40,7 @@
>  #include <drm/drm_gem_vram_helper.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
>  
>  #include "ast_drv.h"
>  #include "ast_tables.h"
> @@ -968,28 +969,18 @@ static int ast_crtc_init(struct drm_device *dev)
>   * Encoder
>   */
>  
> -static void ast_encoder_destroy(struct drm_encoder *encoder)
> -{
> -	drm_encoder_cleanup(encoder);
> -	kfree(encoder);
> -}
> -
> -static const struct drm_encoder_funcs ast_enc_funcs = {
> -	.destroy = ast_encoder_destroy,
> -};
> -
>  static int ast_encoder_init(struct drm_device *dev)
>  {
> -	struct ast_encoder *ast_encoder;
> +	struct ast_private *ast = dev->dev_private;
> +	struct drm_encoder *encoder = &ast->encoder;
> +	int ret;
>  
> -	ast_encoder = kzalloc(sizeof(struct ast_encoder), GFP_KERNEL);
> -	if (!ast_encoder)
> -		return -ENOMEM;
> +	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DAC);
> +	if (ret)
> +		return ret;
>  
> -	drm_encoder_init(dev, &ast_encoder->base, &ast_enc_funcs,
> -			 DRM_MODE_ENCODER_DAC, NULL);
> +	encoder->possible_crtcs = 1;
>  
> -	ast_encoder->base.possible_crtcs = 1;
>  	return 0;
>  }
>  
> -- 
> 2.25.0
