From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/5] vhost: factor out IOTLB
Date: Thu, 16 Jan 2020 20:14:33 -0800
Message-ID: <4a577560-d42a-eed2-97a0-42d2f91495e2@infradead.org>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-2-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200116124231.20253-2-jasowang@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On 1/16/20 4:42 AM, Jason Wang wrote:
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 3d03ccbd1adc..f21c45aa5e07 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -36,6 +36,7 @@ config VHOST_VSOCK
>  
>  config VHOST
>  	tristate
> +        depends on VHOST_IOTLB
>  	---help---
>  	  This option is selected by any driver which needs to access
>  	  the core of vhost.
> @@ -54,3 +55,9 @@ config VHOST_CROSS_ENDIAN_LEGACY
>  	  adds some overhead, it is disabled by default.
>  
>  	  If unsure, say "N".
> +
> +config VHOST_IOTLB
> +	tristate
> +        default m
> +        help
> +          Generic IOTLB implementation for vhost and vringh.

Use tab + 2 spaces for Kconfig indentation.

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
