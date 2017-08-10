From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] virtio: Reduce BUG if total_sg > virtqueue size to
	WARN.
Date: Fri, 11 Aug 2017 00:21:16 +0300
Message-ID: <20170811001447-mutt-send-email-mst__38207.0000669502$1502400086$gmane$org@kernel.org>
References: <20170810164035.19963-1-rjones@redhat.com>
	<20170810164035.19963-2-rjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170810164035.19963-2-rjones@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 10, 2017 at 05:40:34PM +0100, Richard W.M. Jones wrote:
> If using indirect descriptors, you can make the total_sg as large as
> you want.

That would be a spec violation though, even if it happens to
work on current QEMU.

The spec says:
	A driver MUST NOT create a descriptor chain longer than the Queue Size of the device.

What prompted this patch?  Do we ever encounter this situation?

>  If not, BUG is too serious because the function later
> returns -ENOSPC.
> 
> Thanks Paolo Bonzini, Christoph Hellwig.
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 5e1b548828e6..27cbc1eab868 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -296,7 +296,6 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  	}
>  #endif
>  
> -	BUG_ON(total_sg > vq->vring.num);
>  	BUG_ON(total_sg == 0);
>  
>  	head = vq->free_head;
> @@ -305,8 +304,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  	 * buffers, then go indirect. FIXME: tune this threshold */
>  	if (vq->indirect && total_sg > 1 && vq->vq.num_free)
>  		desc = alloc_indirect(_vq, total_sg, gfp);
> -	else
> +	else {
>  		desc = NULL;
> +		WARN_ON_ONCE(total_sg > vq->vring.num && !vq->indirect);
> +	}
>  
>  	if (desc) {
>  		/* Use a single buffer which doesn't continue */
> -- 
> 2.13.1
