From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH 2/6] drm: Add drm_simple_encoder_{init,create}()
Date: Fri, 7 Feb 2020 15:36:49 +0100
Message-ID: <e43dcf9c-e228-dd01-2e55-5ad75804cf79@tronnes.org>
References: <20200207084135.4524-1-tzimmermann@suse.de>
 <20200207084135.4524-3-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200207084135.4524-3-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, kraxel@redhat.com, sam@ravnborg.org, alexander.deucher@amd.com, emil.velikov@collabora.com
Cc: spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



Den 07.02.2020 09.41, skrev Thomas Zimmermann:
> The simple-encoder helpers initialize an encoder with an empty
> implementation. This covers the requirements of most of the existing
> DRM drivers. A call to drm_simple_encoder_create() allocates and
> initializes an encoder instance, a call to drm_simple_encoder_init()
> initializes a pre-allocated instance.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_encoder.c | 116 ++++++++++++++++++++++++++++++++++
>  include/drm/drm_encoder.h     |  10 +++
>  2 files changed, 126 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c

<snip>

> +/**
> + * drm_simple_encoder_create - Allocate and initialize an encoder
> + * @dev: drm device
> + * @encoder_type: user visible type of the encoder
> + * @name: printf style format string for the encoder name, or NULL for
> + *        default name
> + *
> + * Allocates and initialises an encoder that has no further functionality. The
> + * encoder will be released automatically.
> + *
> + * Returns:
> + * The encoder on success, a pointer-encoder error code on failure.
> + */
> +struct drm_encoder *drm_simple_encoder_create(struct drm_device *dev,
> +					      int encoder_type,
> +					      const char *name, ...)
> +{
> +	char *namestr = NULL;
> +	struct drm_encoder *encoder;
> +	int ret;
> +
> +	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);

The encoder can outlive the devres if the device is unbound when
userspace has open fds, so you can't use devm_ here.

Noralf.

> +	if (!encoder)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (name) {
> +		va_list ap;
> +
> +		va_start(ap, name);
> +		namestr = kvasprintf(GFP_KERNEL, name, ap);
> +		va_end(ap);
> +		if (!namestr) {
> +			ret = -ENOMEM;
> +			goto err_devm_kfree;
> +		}
> +	}
> +
> +	ret = __drm_encoder_init(dev, encoder,
> +				 &drm_simple_encoder_funcs_destroy,
> +				 encoder_type, namestr);
> +	if (ret)
> +		goto err_kfree;
> +
> +	return encoder;
> +
> +err_kfree:
> +	if (name)
> +		kfree(namestr);
> +err_devm_kfree:
> +	devm_kfree(dev->dev, encoder);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL(drm_simple_encoder_create);
> +
