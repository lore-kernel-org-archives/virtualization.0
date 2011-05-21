From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2 11/14] virtio: don't delay avail index update
Date: Sat, 21 May 2011 11:56:32 +0930
Message-ID: <874o4ovlev.fsf__22132.7952378944$1305945755$gmane$org@rustcorp.com.au>
References: <cover.1305846412.git.mst@redhat.com>
	<33d7df119ccbedc9b54fbe4b674076b4f7ba3499.1305846412.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <33d7df119ccbedc9b54fbe4b674076b4f7ba3499.1305846412.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 20 May 2011 02:12:19 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Update avail index immediately instead of upon kick:
> for virtio-net RX this helps parallelism with the host.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c |   28 +++++++++++++++++++---------
>  1 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index eed5f29..8218fe6 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -89,7 +89,7 @@ struct vring_virtqueue
>  	unsigned int num_free;
>  	/* Head of free buffer list. */
>  	unsigned int free_head;
> -	/* Number we've added since last sync. */
> +	/* Number we've added since last kick. */
>  	unsigned int num_added;

I always like to see obsolescent nomenclature cleaned up like this.
Thanks.

>  	/* Last used index we've seen. */
> @@ -174,6 +174,13 @@ int virtqueue_add_buf_gfp(struct virtqueue *_vq,
>  
>  	BUG_ON(data == NULL);
>  
> +	/* Prevent drivers from adding more than num bufs without a kick. */
> +	if (vq->num_added == vq->vring.num) {
> +		printk(KERN_ERR "gaaa!!!\n");
> +		END_USE(vq);
> +		return -ENOSPC;
> +	}
> +

I like "gaaa!" but it won't tell us which driver.  How about the more
conventional:

        if (WARN_ON(vq->num_added >= vq->vring.num)) {
        	END_USE(vq);
        	return -ENOSPC;
        }

I'd really like to see the results of this patch.  It's useless for
outgoing net traffic (we deal with one packet at a time) but perhaps a
flood of incoming packets would show something.

Thanks,
Rusty.
