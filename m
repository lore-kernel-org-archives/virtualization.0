From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] scsi: virtio_scsi: remove unnecessary condition check
Date: Thu, 9 Jul 2020 17:26:27 +0200
Message-ID: <6e8405da-b960-f4f7-b46b-442ddab8d983@redhat.com>
References: <1594305992-8458-1-git-send-email-xianting_tian@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1594305992-8458-1-git-send-email-xianting_tian@126.com>
Content-Language: en-US
Sender: linux-scsi-owner@vger.kernel.org
To: Xianting Tian <xianting_tian@126.com>, mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc: virtualization@lists.linux-foundation.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/07/20 16:46, Xianting Tian wrote:
> kmem_cache_destroy can correctly handle null pointer parameter,
> so there is no need to check if the parameter is null before
> calling kmem_cache_destroy.
> 
> Signed-off-by: Xianting Tian <xianting_tian@126.com>
> ---
>  drivers/scsi/virtio_scsi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index bfec84a..5bc288f 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -1007,10 +1007,8 @@ static int __init init(void)
>  		mempool_destroy(virtscsi_cmd_pool);
>  		virtscsi_cmd_pool = NULL;
>  	}
> -	if (virtscsi_cmd_cache) {
> -		kmem_cache_destroy(virtscsi_cmd_cache);
> -		virtscsi_cmd_cache = NULL;
> -	}
> +	kmem_cache_destroy(virtscsi_cmd_cache);
> +	virtscsi_cmd_cache = NULL;
>  	return ret;
>  }
>  
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
