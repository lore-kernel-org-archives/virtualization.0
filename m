From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] virtio-scsi: use pr_err() instead of printk()
Date: Fri, 08 Mar 2013 10:48:50 +0100
Message-ID: <5139B402.2030106@redhat.com>
References: <1362626968-16871-1-git-send-email-gaowanlong@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362626968-16871-1-git-send-email-gaowanlong@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 07/03/2013 04:29, Wanlong Gao ha scritto:
> Convert the virtio-scsi driver to use pr_err() instead of printk().
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

to this patch only.  For the other it's a matter of taste, and since
this is not a fast path it's easier to have a single label to bail out
out.  If you want to change it to "out", that's fine.

Paolo

> ---
>  drivers/scsi/virtio_scsi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 612e320..f679b8c 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -13,6 +13,8 @@
>   *
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/mempool.h>
> @@ -771,8 +773,7 @@ static int __init init(void)
>  
>  	virtscsi_cmd_cache = KMEM_CACHE(virtio_scsi_cmd, 0);
>  	if (!virtscsi_cmd_cache) {
> -		printk(KERN_ERR "kmem_cache_create() for "
> -				"virtscsi_cmd_cache failed\n");
> +		pr_err("kmem_cache_create() for virtscsi_cmd_cache failed\n");
>  		goto error;
>  	}
>  
> @@ -781,8 +782,7 @@ static int __init init(void)
>  		mempool_create_slab_pool(VIRTIO_SCSI_MEMPOOL_SZ,
>  					 virtscsi_cmd_cache);
>  	if (!virtscsi_cmd_pool) {
> -		printk(KERN_ERR "mempool_create() for"
> -				"virtscsi_cmd_pool failed\n");
> +		pr_err("mempool_create() for virtscsi_cmd_pool failed\n");
>  		goto error;
>  	}
>  	ret = register_virtio_driver(&virtio_scsi_driver);
> 
