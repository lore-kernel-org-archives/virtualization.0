From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] scsi: virtio_scsi: remove unnecessary condition check
Date: Thu, 9 Jul 2020 17:25:23 +0200
Message-ID: <d7a9319b-37ec-95dd-c20c-76017a3b1699@redhat.com>
References: <1594307167-8807-1-git-send-email-xianting_tian@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1594307167-8807-1-git-send-email-xianting_tian@126.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Xianting Tian <xianting_tian@126.com>, mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc: virtualization@lists.linux-foundation.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/07/20 17:06, Xianting Tian wrote:
> kmem_cache_destroy and mempool_destroy can correctly handle
> null pointer parameter, so there is no need to check if the
> parameter is null before calling kmem_cache_destroy and
> mempool_destroy.
> 
> Signed-off-by: Xianting Tian <xianting_tian@126.com>
> ---
>  drivers/scsi/virtio_scsi.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index bfec84a..54ac83e 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -1003,14 +1003,10 @@ static int __init init(void)
>  	return 0;
>  
>  error:
> -	if (virtscsi_cmd_pool) {
> -		mempool_destroy(virtscsi_cmd_pool);
> -		virtscsi_cmd_pool = NULL;
> -	}
> -	if (virtscsi_cmd_cache) {
> -		kmem_cache_destroy(virtscsi_cmd_cache);
> -		virtscsi_cmd_cache = NULL;
> -	}
> +	mempool_destroy(virtscsi_cmd_pool);
> +	virtscsi_cmd_pool = NULL;
> +	kmem_cache_destroy(virtscsi_cmd_cache);
> +	virtscsi_cmd_cache = NULL;
>  	return ret;
>  }
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
