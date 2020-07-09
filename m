From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 12/24] scsi: virtio_scsi: Demote seemingly unintentional
 kerneldoc header
Date: Thu, 9 Jul 2020 20:01:25 +0200
Message-ID: <ab85392c-2095-4023-4e20-503ee248a538@redhat.com>
References: <20200709174556.7651-1-lee.jones@linaro.org>
 <20200709174556.7651-13-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20200709174556.7651-13-lee.jones@linaro.org>
Content-Language: en-US
Sender: linux-scsi-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, jejb@linux.ibm.com, martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/07/20 19:45, Lee Jones wrote:
> This is the only use of kerneldoc in the sourcefile and no
> descriptions are provided.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/scsi/virtio_scsi.c:109: warning: Function parameter or member 'vscsi' not described in 'virtscsi_complete_cmd'
>  drivers/scsi/virtio_scsi.c:109: warning: Function parameter or member 'buf' not described in 'virtscsi_complete_cmd'
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/scsi/virtio_scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 0e0910c5b9424..56875467e4984 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -100,7 +100,7 @@ static void virtscsi_compute_resid(struct scsi_cmnd *sc, u32 resid)
>  		scsi_set_resid(sc, resid);
>  }
>  
> -/**
> +/*
>   * virtscsi_complete_cmd - finish a scsi_cmd and invoke scsi_done
>   *
>   * Called with vq_lock held.
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
