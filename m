From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/3] virtio: find_vqs/del_vqs virtio operations
Date: Fri, 8 May 2009 15:48:22 +0300
Message-ID: <20090508124821.GA3073__18211.6902004511$1241787251$gmane$org@redhat.com>
References: <cover.1241700929.git.mst@redhat.com>
	<20090507141039.GA1530@redhat.com>
	<200905081637.09729.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905081637.09729.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 08, 2009 at 04:37:06PM +0930, Rusty Russell wrote:
> On Thu, 7 May 2009 11:40:39 pm Michael S. Tsirkin wrote:
> > This replaces find_vq/del_vq with find_vqs/del_vqs virtio operations,
> > and updates all drivers. This is needed for MSI support, because MSI
> > needs to know the total number of vectors upfront.
> 
> Hmm, I have a similar need for a dev to vq mapping (debugging stats).  How's
> this as a common basis?

This helps. Should I redo mine on top of this?

> Thanks,
> Rusty.
> 
> virtio: add names to virtqueue struct, mapping from devices to queues.
> 
> Add a linked list of all virtqueues for a virtio device: this helps for
> debugging and is also needed for upcoming interface change.
> 
> Also, add a "name" field for clearer debug messages.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Yes, this will simplify supporting find_vqs.

> @@ -303,10 +313,12 @@ struct virtqueue *vring_new_virtqueue(un
>  	vq->vq.callback = callback;
>  	vq->vq.vdev = vdev;
>  	vq->vq.vq_ops = &vring_vq_ops;
> +	vq->vq.name = name;
>  	vq->notify = notify;
>  	vq->broken = false;
>  	vq->last_used_idx = 0;
>  	vq->num_added = 0;
> +	list_add_tail(&vq->vq.list, &vdev->vqs);
>  #ifdef DEBUG
>  	vq->in_use = false;
>  #endif
> @@ -327,6 +339,7 @@ EXPORT_SYMBOL_GPL(vring_new_virtqueue);
>  
>  void vring_del_virtqueue(struct virtqueue *vq)
>  {
> +	list_del(&vq->list);
>  	kfree(to_vvq(vq));
>  }
>  EXPORT_SYMBOL_GPL(vring_del_virtqueue);

I note lack of locking here. This is okay in practice as
drivers don't really call find/del vq in parallel,
but making this explicit with find_vqs will be best, yes?

-- 
MST
