From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH] tcm_vhost: Fix tv_cmd leak in vhost_scsi_handle_vq
Date: Tue, 09 Apr 2013 08:46:42 -0700
Message-ID: <1365522402.24346.146.camel__3864.86776774309$1365522412$gmane$org@haakon2.linux-iscsi.org>
References: <1365498993-9688-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365498993-9688-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2013-04-09 at 17:16 +0800, Asias He wrote:
> If we fail to submit the allocated tv_vmd to tcm_vhost_submission_work,
> we will leak the tv_vmd. Free tv_vmd on fail path.
> 
> Signed-off-by: Asias He <asias@redhat.com>
> ---
>  drivers/vhost/tcm_vhost.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
> index 3351ed3..1f9116c 100644
> --- a/drivers/vhost/tcm_vhost.c
> +++ b/drivers/vhost/tcm_vhost.c
> @@ -860,7 +860,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
>  			vq_err(vq, "Expecting virtio_scsi_cmd_resp, got %zu"
>  				" bytes, out: %d, in: %d\n",
>  				vq->iov[out].iov_len, out, in);
> -			break;
> +			goto err;
>  		}
>  
>  		tv_cmd->tvc_resp = vq->iov[out].iov_base;
> @@ -882,7 +882,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
>  				" exceeds SCSI_MAX_VARLEN_CDB_SIZE: %d\n",
>  				scsi_command_size(tv_cmd->tvc_cdb),
>  				TCM_VHOST_MAX_CDB_SIZE);
> -			break; /* TODO */
> +			goto err;
>  		}
>  		tv_cmd->tvc_lun = ((v_req.lun[2] << 8) | v_req.lun[3]) & 0x3FFF;
>  
> @@ -895,7 +895,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
>  					data_direction == DMA_TO_DEVICE);
>  			if (unlikely(ret)) {
>  				vq_err(vq, "Failed to map iov to sgl\n");
> -				break; /* TODO */
> +				goto err;
>  			}
>  		}
>  

Mmmm, I think these cases also require a VIRTIO_SCSI_S_BAD_TARGET +
__copy_to_user + vhost_add_used_and_signal similar to how !tv_tpg is
handled..  Otherwise virtio-scsi will end up in scsi timeout -> abort,
no..?

Ditto for the vhost_scsi_allocate_cmd failure case..

vhost-net uses vhost_discard_vq_desc for some failure cases,  is that
needed here for the failure cases before __copy_from_user is called..?

> @@ -916,6 +916,11 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
>  	}
>  
>  	mutex_unlock(&vq->mutex);
> +	return;
> +
> +err:
> +	vhost_scsi_free_cmd(tv_cmd);
> +	mutex_unlock(&vq->mutex);
>  }
>  
>  static void vhost_scsi_ctl_handle_kick(struct vhost_work *work)
