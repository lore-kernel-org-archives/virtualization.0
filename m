From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 3/3] vhost: don't touch avail ring if in_order
	is negotiated
Date: Fri, 23 Nov 2018 10:41:25 -0500
Message-ID: <20181123103750-mutt-send-email-mst__31787.3696600602$1542987565$gmane$org@kernel.org>
References: <20181123030016.4924-1-jasowang@redhat.com>
	<20181123030016.4924-4-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181123030016.4924-4-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 23, 2018 at 11:00:16AM +0800, Jason Wang wrote:
> Device use descriptors table in order, so there's no need to read
> index from available ring. This eliminate the cache contention on
> avail ring completely.

Well this isn't what the in order feature says in the spec.

It forces the used ring to be in the same order as
the available ring. So I don't think you can skip
checking the available ring. And in fact depending on
ring size and workload, using all of descriptor buffer might
cause a slowdown.
Rather you should be able to get
about the same speedup, but from skipping checking
the used ring in virtio.


> Virito-user + vhost_kernel + XDP_DROP gives about ~10% improvement on
> TX from 4.8Mpps to 5.3Mpps on Intel(R) Core(TM) i7-5600U CPU @
> 2.60GHz.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vhost.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5f81a66d34..c8be151bc897 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2002,6 +2002,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  	__virtio16 avail_idx;
>  	__virtio16 ring_head;
>  	int ret, access;
> +	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>  
>  	/* Check it isn't doing very strange things with descriptor numbers. */
>  	last_avail_idx = vq->last_avail_idx;
> @@ -2034,15 +2035,19 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  
>  	/* Grab the next descriptor number they're advertising, and increment
>  	 * the index we've seen. */
> -	if (unlikely(vhost_get_avail(vq, ring_head,
> -		     &vq->avail->ring[last_avail_idx & (vq->num - 1)]))) {
> -		vq_err(vq, "Failed to read head: idx %d address %p\n",
> -		       last_avail_idx,
> -		       &vq->avail->ring[last_avail_idx % vq->num]);
> -		return -EFAULT;
> +	if (!in_order) {
> +		if (unlikely(vhost_get_avail(vq, ring_head,
> +		    &vq->avail->ring[last_avail_idx & (vq->num - 1)]))) {
> +			vq_err(vq, "Failed to read head: idx %d address %p\n",
> +				last_avail_idx,
> +				&vq->avail->ring[last_avail_idx % vq->num]);
> +			return -EFAULT;
> +		}
> +		head = vhost16_to_cpu(vq, ring_head);
> +	} else {
> +		head = last_avail_idx & (vq->num - 1);
>  	}
>  
> -	head = vhost16_to_cpu(vq, ring_head);
>  
>  	/* If their number is silly, that's an error. */
>  	if (unlikely(head >= vq->num)) {
> -- 
> 2.17.1
