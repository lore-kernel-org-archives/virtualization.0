From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost/scsi: fix reuse of &vq->iov[out] in response
Date: Tue, 23 Aug 2016 17:15:33 +0300
Message-ID: <20160823170953-mutt-send-email-mst@kernel.org>
References: <1465250508-33133-1-git-send-email-bcodding@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1465250508-33133-1-git-send-email-bcodding@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Coddington <bcodding@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 06, 2016 at 06:01:48PM -0400, Benjamin Coddington wrote:
> The address of the iovec &vq->iov[out] is not guaranteed to contain the scsi
> command's response iovec throughout the lifetime of the command.  Rather, it
> is more likely to contain an iovec from an immediately following command
> after looping back around to vhost_get_vq_desc().  Pass along the iovec
> entirely instead.
> 
> Fixes: 79c14141a487 ("vhost/scsi: Convert completion path to use copy_to_iter")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

Thanks, and sorry about the delayed response.
Originally I thought there's an issue here in that in theory, the response
could be split across multiple iov entries.

However, I now noticed that this is already unsupported:

                if (unlikely(vq->iov[out].iov_len < rsp_size)) {
                        vq_err(vq, "Expecting at least virtio_scsi_cmd_resp"
                                " size, got %zu bytes\n", vq->iov[out].iov_len);
                        break;
                }

So I will queue this, but I think that we need to look at removing the
assumption here longer term.

> ---
>  drivers/vhost/scsi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 0e6fd55..c93e125 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -88,7 +88,7 @@ struct vhost_scsi_cmd {
>  	struct scatterlist *tvc_prot_sgl;
>  	struct page **tvc_upages;
>  	/* Pointer to response header iovec */
> -	struct iovec *tvc_resp_iov;
> +	struct iovec tvc_resp_iov;
>  	/* Pointer to vhost_scsi for our device */
>  	struct vhost_scsi *tvc_vhost;
>  	/* Pointer to vhost_virtqueue for the cmd */
> @@ -557,7 +557,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
>  		memcpy(v_rsp.sense, cmd->tvc_sense_buf,
>  		       se_cmd->scsi_sense_length);
>  
> -		iov_iter_init(&iov_iter, READ, cmd->tvc_resp_iov,
> +		iov_iter_init(&iov_iter, READ, &cmd->tvc_resp_iov,
>  			      cmd->tvc_in_iovs, sizeof(v_rsp));
>  		ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
>  		if (likely(ret == sizeof(v_rsp))) {
> @@ -1054,7 +1054,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
>  		}
>  		cmd->tvc_vhost = vs;
>  		cmd->tvc_vq = vq;
> -		cmd->tvc_resp_iov = &vq->iov[out];
> +		cmd->tvc_resp_iov = vq->iov[out];
>  		cmd->tvc_in_iovs = in;
>  
>  		pr_debug("vhost_scsi got command opcode: %#02x, lun: %d\n",
> -- 
> 2.5.5
