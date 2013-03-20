From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 12/22] virtio_scsi: use virtqueue_add_inbuf() for
	virtscsi_kick_event.
Date: Wed, 20 Mar 2013 09:19:21 +0800
Message-ID: <20130320011920.GB13649@hj.localdomain>
References: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
	<1363599293-23065-13-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363599293-23065-13-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 18, 2013 at 08:04:43PM +1030, Rusty Russell wrote:
> It's a bit clearer, and add_buf is going away.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Reviewed-by: Asias He <asias@redhat.com>

> ---
>  drivers/scsi/virtio_scsi.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index bb67576..f679b8c 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -222,8 +222,8 @@ static int virtscsi_kick_event(struct virtio_scsi *vscsi,
>  
>  	spin_lock_irqsave(&vscsi->event_vq.vq_lock, flags);
>  
> -	err = virtqueue_add_buf(vscsi->event_vq.vq, &sg, 0, 1, event_node,
> -				GFP_ATOMIC);
> +	err = virtqueue_add_inbuf(vscsi->event_vq.vq, &sg, 1, event_node,
> +				  GFP_ATOMIC);
>  	if (!err)
>  		virtqueue_kick(vscsi->event_vq.vq);
>  
> -- 
> 1.7.10.4
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

-- 
Asias
