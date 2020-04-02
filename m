From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] vhost: drop vring dependency on iotlb
Date: Thu, 2 Apr 2020 23:01:13 +0800
Message-ID: <44f9b9d3-3da2-fafe-aa45-edd574dc6484@redhat.com>
References: <20200402144519.34194-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200402144519.34194-1-mst@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/2 =E4=B8=8B=E5=8D=8810:46, Michael S. Tsirkin wrote:
> vringh can now be built without IOTLB.
> Select IOTLB directly where it's used.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Applies on top of my vhost tree.
> Changes from v1:
> 	VDPA_SIM needs VHOST_IOTLB


It looks to me the patch is identical to v1.

Thanks


>
>   drivers/vdpa/Kconfig  | 1 +
>   drivers/vhost/Kconfig | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 7db1460104b7..08b615f2da39 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -17,6 +17,7 @@ config VDPA_SIM
>   	depends on RUNTIME_TESTING_MENU
>   	select VDPA
>   	select VHOST_RING
> +	select VHOST_IOTLB
>   	default n
>   	help
>   	  vDPA networking device simulator which loop TX traffic back
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index f0404ce255d1..cb6b17323eb2 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -8,7 +8,6 @@ config VHOST_IOTLB
>  =20
>   config VHOST_RING
>   	tristate
> -	select VHOST_IOTLB
>   	help
>   	  This option is selected by any driver which needs to access
>   	  the host side of a virtio ring.
