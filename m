From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/6] drm: Add drm_simple_encoder_{init,create}()
Date: Fri, 7 Feb 2020 11:33:33 +0100
Message-ID: <20200207103333.rxebukm4hukavlq5@sirius.home.kraxel.org>
References: <20200207084135.4524-1-tzimmermann@suse.de>
 <20200207084135.4524-3-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200207084135.4524-3-tzimmermann@suse.de>
Content-Disposition: inline
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
Cc: airlied@linux.ie, maarten.lankhorst@linux.intel.com, mripard@kernel.org, virtualization@lists.linux-foundation.org, noralf@tronnes.org, dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com, spice-devel@lists.freedesktop.org, sam@ravnborg.org, emil.velikov@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

> +static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
> +/**
> + * drm_simple_encoder_init - Init a preallocated encoder
> + * @dev: drm device
> + * @funcs: callbacks for this encoder
> + * @encoder_type: user visible type of the encoder
> + * @name: printf style format string for the encoder name, or NULL
> + *        for default name
> + *
> + * Initialises a preallocated encoder that has no further functionality. The
> + * encoder will be released automatically.
> + *
> + * Returns:
> + * Zero on success, error code on failure.
> + */
> +int drm_simple_encoder_init(struct drm_device *dev,
> +			    struct drm_encoder *encoder,
> +			    int encoder_type, const char *name, ...)

How about using

#define drm_simple_encoder_init(dev, type, name, ...) \
        drm_encoder_init(dev, drm_simple_encoder_funcs_cleanup, type, name, __VA_ARGS__)

instead ?

cheers,
  Gerd
