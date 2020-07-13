From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 12/24] scsi: virtio_scsi: Demote seemingly
 unintentional kerneldoc header
Date: Mon, 13 Jul 2020 07:23:13 -0400
Message-ID: <20200713071453-mutt-send-email-mst@kernel.org>
References: <20200713080001.128044-1-lee.jones@linaro.org>
 <20200713080001.128044-13-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200713080001.128044-13-lee.jones@linaro.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-scsi@vger.kernel.org, martin.petersen@oracle.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, jejb@linux.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 13, 2020 at 08:59:49AM +0100, Lee Jones wrote:
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
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Pls merge with the rest of the patches (which tree is this for?)

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
> -- 
> 2.25.1
