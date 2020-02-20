From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V3 1/5] vhost: factor out IOTLB
Date: Wed, 19 Feb 2020 20:04:10 -0800
Message-ID: <61d64892-ce77-3e86-acb8-a49679fc0047@infradead.org>
References: <20200220035650.7986-1-jasowang@redhat.com>
 <20200220035650.7986-2-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200220035650.7986-2-jasowang@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: tiwei.bie@intel.com, jgg@mellanox.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On 2/19/20 7:56 PM, Jason Wang wrote:
> This patch factors out IOTLB into a dedicated module in order to be
> reused by other modules like vringh. User may choose to enable the
> automatic retiring by specifying VHOST_IOTLB_FLAG_RETIRE flag to fit
> for the case of vhost device IOTLB implementation.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  MAINTAINERS                 |   1 +
>  drivers/vhost/Kconfig       |   7 ++
>  drivers/vhost/Makefile      |   2 +
>  drivers/vhost/net.c         |   2 +-
>  drivers/vhost/vhost.c       | 221 +++++++++++-------------------------
>  drivers/vhost/vhost.h       |  36 ++----
>  drivers/vhost/vhost_iotlb.c | 171 ++++++++++++++++++++++++++++
>  include/linux/vhost_iotlb.h |  45 ++++++++
>  8 files changed, 304 insertions(+), 181 deletions(-)
>  create mode 100644 drivers/vhost/vhost_iotlb.c
>  create mode 100644 include/linux/vhost_iotlb.h
> 

Hi,
Sorry if you have gone over this previously:

> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 3d03ccbd1adc..eef634ff9a6e 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -36,6 +36,7 @@ config VHOST_VSOCK
>  
>  config VHOST
>  	tristate
> +	select VHOST_IOTLB
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
> +	default m

"default m" should not be needed. Just make whatever needs it select it.

> +	help
> +	  Generic IOTLB implementation for vhost and vringh.


-- 
~Randy
