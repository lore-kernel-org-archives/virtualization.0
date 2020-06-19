From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-mem: Fix build error due to improper use 'select'
Date: Fri, 19 Jun 2020 07:39:06 -0400
Message-ID: <20200619073841-mutt-send-email-mst@kernel.org>
References: <20200619080333.194753-1-chenweilong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200619080333.194753-1-chenweilong@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Weilong Chen <chenweilong@huawei.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, lizefan@huawei.com, linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 19, 2020 at 04:03:33PM +0800, Weilong Chen wrote:
> As noted in:
> https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt
> "select should be used with care. select will force a symbol to a
> value without visiting the dependencies."
> Config VIRTIO_MEM should not select CONTIG_ALLOC directly.
> Otherwise it will cause an error:
> https://bugzilla.kernel.org/show_bug.cgi?id=208245
> 
> Signed-off-by: Weilong Chen <chenweilong@huawei.com>

Cc virtio mem maintainer:
M:      David Hildenbrand <david@redhat.com>


> ---
>  drivers/virtio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 5809e5f5b157..5c92e4a50882 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -85,7 +85,7 @@ config VIRTIO_MEM
>  	depends on VIRTIO
>  	depends on MEMORY_HOTPLUG_SPARSE
>  	depends on MEMORY_HOTREMOVE
> -	select CONTIG_ALLOC
> +	depends on CONTIG_ALLOC
>  	help
>  	 This driver provides access to virtio-mem paravirtualized memory
>  	 devices, allowing to hotplug and hotunplug memory.
> -- 
> 2.17.1
