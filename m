From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Date: Thu, 30 Jan 2020 19:56:43 -0800
Message-ID: <43aeecb4-4c08-df3d-1c1d-699ec4c494bd@infradead.org>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200131033651.103534-1-tiwei.bie@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, jasowang@redhat.com
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, shahafs@mellanox.com, jgg@mellanox.com, rob.miller@broadcom.com, haotian.wang@sifive.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, hch@infradead.org, jiri@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, maxime.coquelin@redhat.com, lingshan.zhu@intel.com, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On 1/30/20 7:36 PM, Tiwei Bie wrote:
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index f21c45aa5e07..13e6a94d0243 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -34,6 +34,18 @@ config VHOST_VSOCK
>  	To compile this driver as a module, choose M here: the module will be called
>  	vhost_vsock.
>  
> +config VHOST_VDPA
> +	tristate "Vhost driver for vDPA based backend"
> +	depends on EVENTFD && VDPA
> +	select VHOST
> +	default n
> +	---help---
> +	This kernel module can be loaded in host kernel to accelerate
> +	guest virtio devices with the vDPA based backends.

	                              vDPA-based

> +
> +	To compile this driver as a module, choose M here: the module
> +	will be called vhost_vdpa.
> +

The preferred Kconfig style nowadays is
(a) use "help" instead of "---help---"
(b) indent the help text with one tab + 2 spaces

and don't use "default n" since that is already the default.

>  config VHOST
>  	tristate
>          depends on VHOST_IOTLB

thanks.
-- 
~Randy
