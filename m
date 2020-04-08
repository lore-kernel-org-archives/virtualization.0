From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 39/44] drm/cirrus: Use devm_drm_dev_alloc
Date: Wed, 8 Apr 2020 10:01:03 +0200
Message-ID: <20200408080103.GR14965@ravnborg.org>
References: <20200403135828.2542770-1-daniel.vetter@ffwll.ch>
 <20200403135828.2542770-40-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200403135828.2542770-40-daniel.vetter@ffwll.ch>
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
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Gerd Hoffmann <kraxel@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 03, 2020 at 03:58:23PM +0200, Daniel Vetter wrote:
> Already using devm_drm_dev_init, so very simple replacment.
> =

> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: "Noralf Tr=F8nnes" <noralf@tronnes.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: virtualization@lists.linux-foundation.org
> Cc: Emil Velikov <emil.velikov@collabora.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  drivers/gpu/drm/cirrus/cirrus.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> =

> diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cir=
rus.c
> index a36269717c3b..4b65637147ba 100644
> --- a/drivers/gpu/drm/cirrus/cirrus.c
> +++ b/drivers/gpu/drm/cirrus/cirrus.c
> @@ -567,18 +567,13 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
>  		return ret;
>  =

>  	ret =3D -ENOMEM;
> -	cirrus =3D kzalloc(sizeof(*cirrus), GFP_KERNEL);
> -	if (cirrus =3D=3D NULL)
> -		return ret;
> +	cirrus =3D devm_drm_dev_alloc(&pdev->dev, &cirrus_driver,
> +				    struct cirrus_device, dev);
> +	if (IS_ERR(cirrus))
> +		return PTR_ERR(cirrus);
>  =

>  	dev =3D &cirrus->dev;
> -	ret =3D devm_drm_dev_init(&pdev->dev, dev, &cirrus_driver);
> -	if (ret) {
> -		kfree(cirrus);
> -		return ret;
> -	}
>  	dev->dev_private =3D cirrus;
> -	drmm_add_final_kfree(dev, cirrus);
>  =

>  	cirrus->vram =3D devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0),
>  				    pci_resource_len(pdev, 0));
> -- =

> 2.25.1
> =

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
