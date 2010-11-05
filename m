From: Dave Young <hidave.darkstar@gmail.com>
Subject: Re: [PATCH 36/49] drivers/video: Use vzalloc
Date: Fri, 5 Nov 2010 13:27:05 +0800
Message-ID: <AANLkTinpKni-pfEzo=OwZZePVHapafVHJOydDoDU268_@mail.gmail.com>
References: <cover.1288925424.git.joe@perches.com>
	<alpine.DEB.2.00.1011031108260.11625@router.home>
	<a1c4c46381ac1867c4af3edb811e58a721957842.1288925425.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a1c4c46381ac1867c4af3edb811e58a721957842.1288925425.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Jiri Kosina <trivial@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 5, 2010 at 11:08 AM, Joe Perches <joe@perches.com> wrote:
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> =C2=A0drivers/video/arcfb.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
5 ++---
> =C2=A0drivers/video/broadsheetfb.c | =C2=A0 =C2=A04 +---
> =C2=A0drivers/video/hecubafb.c =C2=A0 =C2=A0 | =C2=A0 =C2=A05 ++---
> =C2=A0drivers/video/metronomefb.c =C2=A0| =C2=A0 =C2=A04 +---
> =C2=A0drivers/video/xen-fbfront.c =C2=A0| =C2=A0 =C2=A03 +--
> =C2=A05 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
> index 3ec4923..86573e2 100644
> --- a/drivers/video/arcfb.c
> +++ b/drivers/video/arcfb.c
> @@ -515,11 +515,10 @@ static int __devinit arcfb_probe(struct platfor=
m_device *dev)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We need a flat backing store for the Ar=
c's
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 less-flat actual paged framebuffer=
 */
> - =C2=A0 =C2=A0 =C2=A0 if (!(videomemory =3D vmalloc(videomemorysize)=
))
> + =C2=A0 =C2=A0 =C2=A0 videomemory =3D vmalloc(videomemorysize);

typo?

> + =C2=A0 =C2=A0 =C2=A0 if (!videomemory)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return retval;
>
> - =C2=A0 =C2=A0 =C2=A0 memset(videomemory, 0, videomemorysize);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0info =3D framebuffer_alloc(sizeof(struct a=
rcfb_par), &dev->dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!info)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;
> diff --git a/drivers/video/broadsheetfb.c b/drivers/video/broadsheetf=
b.c
> index ebda687..377dde3 100644
> --- a/drivers/video/broadsheetfb.c
> +++ b/drivers/video/broadsheetfb.c
> @@ -1101,12 +1101,10 @@ static int __devinit broadsheetfb_probe(struc=
t platform_device *dev)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0videomemorysize =3D roundup((dpyw*dpyh), P=
AGE_SIZE);
>
> - =C2=A0 =C2=A0 =C2=A0 videomemory =3D vmalloc(videomemorysize);
> + =C2=A0 =C2=A0 =C2=A0 videomemory =3D vzalloc(videomemorysize);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!videomemory)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_fb_re=
l;
>
> - =C2=A0 =C2=A0 =C2=A0 memset(videomemory, 0, videomemorysize);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0info->screen_base =3D (char *)videomemory;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0info->fbops =3D &broadsheetfb_ops;
>
> diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
> index c77bcc6..a941e6f 100644
> --- a/drivers/video/hecubafb.c
> +++ b/drivers/video/hecubafb.c
> @@ -231,11 +231,10 @@ static int __devinit hecubafb_probe(struct plat=
form_device *dev)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0videomemorysize =3D (DPY_W*DPY_H)/8;
>
> - =C2=A0 =C2=A0 =C2=A0 if (!(videomemory =3D vmalloc(videomemorysize)=
))
> + =C2=A0 =C2=A0 =C2=A0 videomemory =3D vzalloc(videomemorysize);
> + =C2=A0 =C2=A0 =C2=A0 if (!videomemory)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return retval;
>
> - =C2=A0 =C2=A0 =C2=A0 memset(videomemory, 0, videomemorysize);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0info =3D framebuffer_alloc(sizeof(struct h=
ecubafb_par), &dev->dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!info)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_fball=
oc;
> diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.=
c
> index 63ed3b7..c0c358c 100644
> --- a/drivers/video/metronomefb.c
> +++ b/drivers/video/metronomefb.c
> @@ -628,12 +628,10 @@ static int __devinit metronomefb_probe(struct p=
latform_device *dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* we need to add a spare page because our=
 csum caching scheme walks
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * to the end of the page */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0videomemorysize =3D PAGE_SIZE + (fw * fh);
> - =C2=A0 =C2=A0 =C2=A0 videomemory =3D vmalloc(videomemorysize);
> + =C2=A0 =C2=A0 =C2=A0 videomemory =3D vzalloc(videomemorysize);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!videomemory)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_fb_re=
l;
>
> - =C2=A0 =C2=A0 =C2=A0 memset(videomemory, 0, videomemorysize);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0info->screen_base =3D (char __force __iome=
m *)videomemory;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0info->fbops =3D &metronomefb_ops;
>
> diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.=
c
> index 428d273..81fcaea 100644
> --- a/drivers/video/xen-fbfront.c
> +++ b/drivers/video/xen-fbfront.c
> @@ -395,10 +395,9 @@ static int __devinit xenfb_probe(struct xenbus_d=
evice *dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&info->dirty_lock);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&info->resize_lock);
>
> - =C2=A0 =C2=A0 =C2=A0 info->fb =3D vmalloc(fb_size);
> + =C2=A0 =C2=A0 =C2=A0 info->fb =3D vzalloc(fb_size);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (info->fb =3D=3D NULL)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error_nom=
em;
> - =C2=A0 =C2=A0 =C2=A0 memset(info->fb, 0, fb_size);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0info->nr_pages =3D (fb_size + PAGE_SIZE - =
1) >> PAGE_SHIFT;
>
> --
> 1.7.3.1.g432b3.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>



--=20
Regards
dave
