From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 09/51] drm/cirrus: Use drmm_add_final_kfree
Date: Thu, 27 Feb 2020 22:01:02 +0100
Message-ID: <20200227210102.GC29498@ravnborg.org>
References: <20200227181522.2711142-1-daniel.vetter@ffwll.ch>
 <20200227181522.2711142-10-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200227181522.2711142-10-daniel.vetter@ffwll.ch>
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
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, m.felsch@pengutronix.de, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, l.stach@pengutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 27, 2020 at 07:14:40PM +0100, Daniel Vetter wrote:
> With this we can drop the final kfree from the release function.
> =

> I also noticed that cirrus forgot to call drm_dev_fini().
> =

> v2: Don't call kfree(cirrus) after we've handed overship of that to
> drm_device and the drmm_ stuff.
> =

> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Noralf Tr=F8nnes" <noralf@tronnes.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: virtualization@lists.linux-foundation.org

Acked-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  drivers/gpu/drm/cirrus/cirrus.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> =

> diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cir=
rus.c
> index d2ff63ce8eaf..2232556ce34c 100644
> --- a/drivers/gpu/drm/cirrus/cirrus.c
> +++ b/drivers/gpu/drm/cirrus/cirrus.c
> @@ -35,6 +35,7 @@
>  #include <drm/drm_gem_shmem_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_ioctl.h>
> +#include <drm/drm_managed.h>
>  #include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
> @@ -527,10 +528,8 @@ static void cirrus_mode_config_init(struct cirrus_de=
vice *cirrus)
>  =

>  static void cirrus_release(struct drm_device *dev)
>  {
> -	struct cirrus_device *cirrus =3D dev->dev_private;
> -
>  	drm_mode_config_cleanup(dev);
> -	kfree(cirrus);
> +	drm_dev_fini(dev);
>  }
>  =

>  DEFINE_DRM_GEM_FOPS(cirrus_fops);
> @@ -575,9 +574,12 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
>  =

>  	dev =3D &cirrus->dev;
>  	ret =3D drm_dev_init(dev, &cirrus_driver, &pdev->dev);
> -	if (ret)
> -		goto err_free_cirrus;
> +	if (ret) {
> +		kfree(cirrus);
> +		goto err_pci_release;
> +	}
>  	dev->dev_private =3D cirrus;
> +	drmm_add_final_kfree(dev, cirrus);
>  =

>  	ret =3D -ENOMEM;
>  	cirrus->vram =3D ioremap(pci_resource_start(pdev, 0),
> @@ -618,8 +620,6 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
>  	iounmap(cirrus->vram);
>  err_dev_put:
>  	drm_dev_put(dev);
> -err_free_cirrus:
> -	kfree(cirrus);
>  err_pci_release:
>  	pci_release_regions(pdev);
>  	return ret;
> -- =

> 2.24.1
