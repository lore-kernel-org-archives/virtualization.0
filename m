From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa: move to drivers/vdpa
Date: Wed, 1 Apr 2020 14:32:55 +0800
Message-ID: <ee5c17e0-0e28-8979-ff6a-5ea1659a24e0@redhat.com>
References: <20200331191825.249436-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200331191825.249436-1-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/1 =E4=B8=8A=E5=8D=883:19, Michael S. Tsirkin wrote:
> We have both vhost and virtio drivers that depend on vdpa.
> It's easier to locate it at a top level directory otherwise
> we run into issues e.g. if vhost is built-in but virtio
> is modular.  Let's just move it up a level.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>
> Randy I'd say the issue you are reporting (vhost=3Dy, virtio=3Dm)
> is esoteric enough not to require a rebase for this.
> So I'd just apply this on top.
> Do you agree?
>
>   MAINTAINERS                                   | 1 +
>   drivers/Kconfig                               | 2 ++
>   drivers/Makefile                              | 1 +
>   drivers/{virtio =3D> }/vdpa/Kconfig             | 0
>   drivers/{virtio =3D> }/vdpa/Makefile            | 0
>   drivers/{virtio =3D> }/vdpa/ifcvf/Makefile      | 0
>   drivers/{virtio =3D> }/vdpa/ifcvf/ifcvf_base.c  | 0
>   drivers/{virtio =3D> }/vdpa/ifcvf/ifcvf_base.h  | 0
>   drivers/{virtio =3D> }/vdpa/ifcvf/ifcvf_main.c  | 0
>   drivers/{virtio =3D> }/vdpa/vdpa.c              | 0
>   drivers/{virtio =3D> }/vdpa/vdpa_sim/Makefile   | 0
>   drivers/{virtio =3D> }/vdpa/vdpa_sim/vdpa_sim.c | 0
>   drivers/virtio/Kconfig                        | 2 --
>   13 files changed, 4 insertions(+), 2 deletions(-)
>   rename drivers/{virtio =3D> }/vdpa/Kconfig (100%)
>   rename drivers/{virtio =3D> }/vdpa/Makefile (100%)
>   rename drivers/{virtio =3D> }/vdpa/ifcvf/Makefile (100%)
>   rename drivers/{virtio =3D> }/vdpa/ifcvf/ifcvf_base.c (100%)
>   rename drivers/{virtio =3D> }/vdpa/ifcvf/ifcvf_base.h (100%)
>   rename drivers/{virtio =3D> }/vdpa/ifcvf/ifcvf_main.c (100%)
>   rename drivers/{virtio =3D> }/vdpa/vdpa.c (100%)
>   rename drivers/{virtio =3D> }/vdpa/vdpa_sim/Makefile (100%)
>   rename drivers/{virtio =3D> }/vdpa/vdpa_sim/vdpa_sim.c (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 70c47bc55343..7cfa55c765fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17695,6 +17695,7 @@ L:	virtualization@lists.linux-foundation.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/virtio/
>   F:	drivers/virtio/
> +F:	drivers/vdpa/
>   F:	tools/virtio/
>   F:	drivers/net/virtio_net.c
>   F:	drivers/block/virtio_blk.c
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 7a6d8b2b68b4..ac23d520e916 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -138,6 +138,8 @@ source "drivers/virt/Kconfig"
>  =20
>   source "drivers/virtio/Kconfig"
>  =20
> +source "drivers/vdpa/Kconfig"
> +
>   source "drivers/vhost/Kconfig"
>  =20
>   source "drivers/hv/Kconfig"
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 31cf17dee252..21688f3b1588 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_DMADEVICES)	+=3D dma/
>   obj-y				+=3D soc/
>  =20
>   obj-$(CONFIG_VIRTIO)		+=3D virtio/
> +obj-$(CONFIG_VDPA)		+=3D vdpa/
>   obj-$(CONFIG_XEN)		+=3D xen/
>  =20
>   # regulators early, since some subsystems rely on them to initialize
> diff --git a/drivers/virtio/vdpa/Kconfig b/drivers/vdpa/Kconfig
> similarity index 100%
> rename from drivers/virtio/vdpa/Kconfig
> rename to drivers/vdpa/Kconfig
> diff --git a/drivers/virtio/vdpa/Makefile b/drivers/vdpa/Makefile
> similarity index 100%
> rename from drivers/virtio/vdpa/Makefile
> rename to drivers/vdpa/Makefile
> diff --git a/drivers/virtio/vdpa/ifcvf/Makefile b/drivers/vdpa/ifcvf/Ma=
kefile
> similarity index 100%
> rename from drivers/virtio/vdpa/ifcvf/Makefile
> rename to drivers/vdpa/ifcvf/Makefile
> diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcv=
f/ifcvf_base.c
> similarity index 100%
> rename from drivers/virtio/vdpa/ifcvf/ifcvf_base.c
> rename to drivers/vdpa/ifcvf/ifcvf_base.c
> diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcv=
f/ifcvf_base.h
> similarity index 100%
> rename from drivers/virtio/vdpa/ifcvf/ifcvf_base.h
> rename to drivers/vdpa/ifcvf/ifcvf_base.h
> diff --git a/drivers/virtio/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcv=
f/ifcvf_main.c
> similarity index 100%
> rename from drivers/virtio/vdpa/ifcvf/ifcvf_main.c
> rename to drivers/vdpa/ifcvf/ifcvf_main.c
> diff --git a/drivers/virtio/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> similarity index 100%
> rename from drivers/virtio/vdpa/vdpa.c
> rename to drivers/vdpa/vdpa.c
> diff --git a/drivers/virtio/vdpa/vdpa_sim/Makefile b/drivers/vdpa/vdpa_=
sim/Makefile
> similarity index 100%
> rename from drivers/virtio/vdpa/vdpa_sim/Makefile
> rename to drivers/vdpa/vdpa_sim/Makefile
> diff --git a/drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdp=
a_sim/vdpa_sim.c
> similarity index 100%
> rename from drivers/virtio/vdpa/vdpa_sim/vdpa_sim.c
> rename to drivers/vdpa/vdpa_sim/vdpa_sim.c
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 99e424570644..2aadf398d8cc 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -109,5 +109,3 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
>   	 If unsure, say 'N'.
>  =20
>   endif # VIRTIO_MENU
> -
> -source "drivers/virtio/vdpa/Kconfig"
