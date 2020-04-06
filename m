From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa-sim: depend on HAS_DMA
Date: Mon, 6 Apr 2020 08:34:15 +0800
Message-ID: <6e2ad3e3-c4cb-98cb-e15d-8d9e7aa14f50@redhat.com>
References: <20200405081355.2870-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200405081355.2870-1-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/5 =E4=B8=8B=E5=8D=884:14, Michael S. Tsirkin wrote:
> set_dma_ops isn't available on all architectures:
>
>          make ARCH=3Dum
> ...
>
>     drivers/vdpa/vdpa_sim/vdpa_sim.c: In function 'vdpasim_create':
>>> drivers/vdpa/vdpa_sim/vdpa_sim.c:324:2: error: implicit declaration o=
f function 'set_dma_ops'; did you mean 'set_groups'?
> +[-Werror=3Dimplicit-function-declaration]
>       set_dma_ops(dev, &vdpasim_dma_ops);
>       ^~~~~~~~~~~
>       set_groups
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/vdpa/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 08b615f2da39..d0cb0e583a5d 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -14,7 +14,7 @@ if VDPA_MENU
>  =20
>   config VDPA_SIM
>   	tristate "vDPA device simulator"
> -	depends on RUNTIME_TESTING_MENU
> +	depends on RUNTIME_TESTING_MENU && HAS_DMA
>   	select VDPA
>   	select VHOST_RING
>   	select VHOST_IOTLB


Acked-by: Jason Wang <jasowang@redhat.com>
