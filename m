From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 29/51] drm/cirrus: Drop explicit
 drm_mode_config_cleanup call
Date: Fri, 28 Feb 2020 21:32:35 +0100
Message-ID: <20200228203235.GC22966@ravnborg.org>
References: <20200227181522.2711142-1-daniel.vetter@ffwll.ch>
 <20200227181522.2711142-30-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200227181522.2711142-30-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, m.felsch@pengutronix.de, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, l.stach@pengutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 27, 2020 at 07:15:00PM +0100, Daniel Vetter wrote:
> We can even delete the drm_driver.release hook now!
> =

> This is made possible by a preceeding patch which added a drmm_
> cleanup action to drm_mode_config_init(), hence all we need to do to
> ensure that drm_mode_config_cleanup() is run on final drm_device
> cleanup is check the new error code for _init().
> =

> v2: Explain why this cleanup is possible (Laurent).
> =

> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Noralf Tr=F8nnes" <noralf@tronnes.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: virtualization@lists.linux-foundation.org

Acked-by: Sam Ravnborg <sam@ravnborg.org>

But as stated in other post - using drmm_mode_config_init()
would make this more readable.

	Sam

> ---
>  drivers/gpu/drm/cirrus/cirrus.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> =

> diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cir=
rus.c
> index a9d789a56536..6ac0286810ec 100644
> --- a/drivers/gpu/drm/cirrus/cirrus.c
> +++ b/drivers/gpu/drm/cirrus/cirrus.c
> @@ -510,11 +510,15 @@ static const struct drm_mode_config_funcs cirrus_mo=
de_config_funcs =3D {
>  	.atomic_commit =3D drm_atomic_helper_commit,
>  };
>  =

> -static void cirrus_mode_config_init(struct cirrus_device *cirrus)
> +static int cirrus_mode_config_init(struct cirrus_device *cirrus)
>  {
>  	struct drm_device *dev =3D &cirrus->dev;
> +	int ret;
> +
> +	ret =3D drm_mode_config_init(dev);
> +	if (ret)
> +		return ret;
>  =

> -	drm_mode_config_init(dev);
>  	dev->mode_config.min_width =3D 0;
>  	dev->mode_config.min_height =3D 0;
>  	dev->mode_config.max_width =3D CIRRUS_MAX_PITCH / 2;
> @@ -522,15 +526,12 @@ static void cirrus_mode_config_init(struct cirrus_d=
evice *cirrus)
>  	dev->mode_config.preferred_depth =3D 16;
>  	dev->mode_config.prefer_shadow =3D 0;
>  	dev->mode_config.funcs =3D &cirrus_mode_config_funcs;
> +
> +	return 0;
>  }
>  =

>  /* ------------------------------------------------------------------ */
>  =

> -static void cirrus_release(struct drm_device *dev)
> -{
> -	drm_mode_config_cleanup(dev);
> -}
> -
>  DEFINE_DRM_GEM_FOPS(cirrus_fops);
>  =

>  static struct drm_driver cirrus_driver =3D {
> @@ -544,7 +545,6 @@ static struct drm_driver cirrus_driver =3D {
>  =

>  	.fops		 =3D &cirrus_fops,
>  	DRM_GEM_SHMEM_DRIVER_OPS,
> -	.release         =3D cirrus_release,
>  };
>  =

>  static int cirrus_pci_probe(struct pci_dev *pdev,
> @@ -591,7 +591,9 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
>  	if (cirrus->mmio =3D=3D NULL)
>  		goto err_unmap_vram;
>  =

> -	cirrus_mode_config_init(cirrus);
> +	ret =3D cirrus_mode_config_init(cirrus);
> +	if (ret)
> +		goto err_cleanup;
>  =

>  	ret =3D cirrus_conn_init(cirrus);
>  	if (ret < 0)
> @@ -613,7 +615,6 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
>  	return 0;
>  =

>  err_cleanup:
> -	drm_mode_config_cleanup(dev);
>  	iounmap(cirrus->mmio);
>  err_unmap_vram:
>  	iounmap(cirrus->vram);
> -- =

> 2.24.1
