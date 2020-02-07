From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/6] drm: Add drm_simple_encoder_{init,create}()
Date: Fri, 7 Feb 2020 17:25:10 +0100
Message-ID: <20200207162510.GH43062@phenom.ffwll.local>
References: <20200207084135.4524-1-tzimmermann@suse.de>
 <20200207084135.4524-3-tzimmermann@suse.de>
 <e43dcf9c-e228-dd01-2e55-5ad75804cf79@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e43dcf9c-e228-dd01-2e55-5ad75804cf79@tronnes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie, dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, virtualization@lists.linux-foundation.org, daniel@ffwll.ch, alexander.deucher@amd.com, spice-devel@lists.freedesktop.org, sam@ravnborg.org, emil.velikov@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 07, 2020 at 03:36:49PM +0100, Noralf Tr=F8nnes wrote:
> =

> =

> Den 07.02.2020 09.41, skrev Thomas Zimmermann:
> > The simple-encoder helpers initialize an encoder with an empty
> > implementation. This covers the requirements of most of the existing
> > DRM drivers. A call to drm_simple_encoder_create() allocates and
> > initializes an encoder instance, a call to drm_simple_encoder_init()
> > initializes a pre-allocated instance.
> > =

> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > ---
> >  drivers/gpu/drm/drm_encoder.c | 116 ++++++++++++++++++++++++++++++++++
> >  include/drm/drm_encoder.h     |  10 +++
> >  2 files changed, 126 insertions(+)
> > =

> > diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encode=
r.c
> =

> <snip>
> =

> > +/**
> > + * drm_simple_encoder_create - Allocate and initialize an encoder
> > + * @dev: drm device
> > + * @encoder_type: user visible type of the encoder
> > + * @name: printf style format string for the encoder name, or NULL for
> > + *        default name
> > + *
> > + * Allocates and initialises an encoder that has no further functional=
ity. The
> > + * encoder will be released automatically.
> > + *
> > + * Returns:
> > + * The encoder on success, a pointer-encoder error code on failure.
> > + */
> > +struct drm_encoder *drm_simple_encoder_create(struct drm_device *dev,
> > +					      int encoder_type,
> > +					      const char *name, ...)
> > +{
> > +	char *namestr =3D NULL;
> > +	struct drm_encoder *encoder;
> > +	int ret;
> > +
> > +	encoder =3D devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
> =

> The encoder can outlive the devres if the device is unbound when
> userspace has open fds, so you can't use devm_ here.

Ah yes great catch. Rule of thumb: Never use devm_ for any drm_*
structure. It's wrong.

There's a todo somewhere to essentially create a drm_managed set of apis
where the cleanup matches the right lifetime - we need to only
free/release drm resource at drm_driver->release time.
-Daniel

> =

> Noralf.
> =

> > +	if (!encoder)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	if (name) {
> > +		va_list ap;
> > +
> > +		va_start(ap, name);
> > +		namestr =3D kvasprintf(GFP_KERNEL, name, ap);
> > +		va_end(ap);
> > +		if (!namestr) {
> > +			ret =3D -ENOMEM;
> > +			goto err_devm_kfree;
> > +		}
> > +	}
> > +
> > +	ret =3D __drm_encoder_init(dev, encoder,
> > +				 &drm_simple_encoder_funcs_destroy,
> > +				 encoder_type, namestr);
> > +	if (ret)
> > +		goto err_kfree;
> > +
> > +	return encoder;
> > +
> > +err_kfree:
> > +	if (name)
> > +		kfree(namestr);
> > +err_devm_kfree:
> > +	devm_kfree(dev->dev, encoder);
> > +	return ERR_PTR(ret);
> > +}
> > +EXPORT_SYMBOL(drm_simple_encoder_create);
> > +

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
