From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/8] vhost: Create accessors for virtqueues
 private_data
Date: Tue, 31 Mar 2020 14:14:23 -0400
Message-ID: <20200331141244-mutt-send-email-mst@kernel.org>
References: <20200331180006.25829-1-eperezma@redhat.com>
 <20200331180006.25829-2-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200331180006.25829-2-eperezma@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 31, 2020 at 07:59:59PM +0200, Eugenio Pérez wrote:
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  drivers/vhost/net.c   | 28 +++++++++++++++-------------
>  drivers/vhost/vhost.h | 28 ++++++++++++++++++++++++++++
>  drivers/vhost/vsock.c | 14 +++++++-------
>  3 files changed, 50 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index e158159671fa..6c5e7a6f712c 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -424,7 +424,7 @@ static void vhost_net_disable_vq(struct vhost_net *n,
>  	struct vhost_net_virtqueue *nvq =
>  		container_of(vq, struct vhost_net_virtqueue, vq);
>  	struct vhost_poll *poll = n->poll + (nvq - n->vqs);
> -	if (!vq->private_data)
> +	if (!vhost_vq_get_backend_opaque(vq))
>  		return;
>  	vhost_poll_stop(poll);
>  }
> @@ -437,7 +437,7 @@ static int vhost_net_enable_vq(struct vhost_net *n,
>  	struct vhost_poll *poll = n->poll + (nvq - n->vqs);
>  	struct socket *sock;
>  
> -	sock = vq->private_data;
> +	sock = vhost_vq_get_backend_opaque(vq);
>  	if (!sock)
>  		return 0;
>  
> @@ -524,7 +524,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>  		return;
>  
>  	vhost_disable_notify(&net->dev, vq);
> -	sock = rvq->private_data;
> +	sock = vhost_vq_get_backend_opaque(rvq);
>  
>  	busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
>  				     tvq->busyloop_timeout;
> @@ -570,8 +570,10 @@ static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
>  
>  	if (r == tvq->num && tvq->busyloop_timeout) {
>  		/* Flush batched packets first */
> -		if (!vhost_sock_zcopy(tvq->private_data))
> -			vhost_tx_batch(net, tnvq, tvq->private_data, msghdr);
> +		if (!vhost_sock_zcopy(vhost_vq_get_backend_opaque(tvq)))
> +			vhost_tx_batch(net, tnvq,
> +				       vhost_vq_get_backend_opaque(tvq),
> +				       msghdr);
>  
>  		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, false);
>  
> @@ -685,7 +687,7 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
>  	struct vhost_virtqueue *vq = &nvq->vq;
>  	struct vhost_net *net = container_of(vq->dev, struct vhost_net,
>  					     dev);
> -	struct socket *sock = vq->private_data;
> +	struct socket *sock = vhost_vq_get_backend_opaque(vq);
>  	struct page_frag *alloc_frag = &net->page_frag;
>  	struct virtio_net_hdr *gso;
>  	struct xdp_buff *xdp = &nvq->xdp[nvq->batched_xdp];
> @@ -952,7 +954,7 @@ static void handle_tx(struct vhost_net *net)
>  	struct socket *sock;
>  
>  	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_TX);
> -	sock = vq->private_data;
> +	sock = vhost_vq_get_backend_opaque(vq);
>  	if (!sock)
>  		goto out;
>  
> @@ -1121,7 +1123,7 @@ static void handle_rx(struct vhost_net *net)
>  	int recv_pkts = 0;
>  
>  	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
> -	sock = vq->private_data;
> +	sock = vhost_vq_get_backend_opaque(vq);
>  	if (!sock)
>  		goto out;
>  
> @@ -1344,9 +1346,9 @@ static struct socket *vhost_net_stop_vq(struct vhost_net *n,
>  		container_of(vq, struct vhost_net_virtqueue, vq);
>  
>  	mutex_lock(&vq->mutex);
> -	sock = vq->private_data;
> +	sock = vhost_vq_get_backend_opaque(vq);
>  	vhost_net_disable_vq(n, vq);
> -	vq->private_data = NULL;
> +	vhost_vq_set_backend_opaque(vq, NULL);
>  	vhost_net_buf_unproduce(nvq);
>  	nvq->rx_ring = NULL;
>  	mutex_unlock(&vq->mutex);
> @@ -1528,7 +1530,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>  	}
>  
>  	/* start polling new socket */
> -	oldsock = vq->private_data;
> +	oldsock = vhost_vq_get_backend_opaque(vq);
>  	if (sock != oldsock) {
>  		ubufs = vhost_net_ubuf_alloc(vq,
>  					     sock && vhost_sock_zcopy(sock));
> @@ -1538,7 +1540,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>  		}
>  
>  		vhost_net_disable_vq(n, vq);
> -		vq->private_data = sock;
> +		vhost_vq_set_backend_opaque(vq, sock);
>  		vhost_net_buf_unproduce(nvq);
>  		r = vhost_vq_init_access(vq);
>  		if (r)
> @@ -1575,7 +1577,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>  	return 0;
>  
>  err_used:
> -	vq->private_data = oldsock;
> +	vhost_vq_set_backend_opaque(vq, oldsock);
>  	vhost_net_enable_vq(n, vq);
>  	if (ubufs)
>  		vhost_net_ubuf_put_wait_and_free(ubufs);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index a123fd70847e..0808188f7e8f 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -244,6 +244,34 @@ enum {
>  			 (1ULL << VIRTIO_F_VERSION_1)
>  };
>  
> +/**
> + * vhost_vq_set_backend_opaque - Set backend opaque.
> + *
> + * @vq            Virtqueue.
> + * @private_data  The private data.
> + *
> + * Context: Need to call with vq->mutex acquired.
> + */
> +static inline void vhost_vq_set_backend_opaque(struct vhost_virtqueue *vq,
> +					       void *private_data)
> +{
> +	vq->private_data = private_data;
> +}
> +
> +/**
> + * vhost_vq_get_backend_opaque - Get backend opaque.
> + *
> + * @vq            Virtqueue.
> + * @private_data  The private data.
> + *
> + * Context: Need to call with vq->mutex acquired.
> + * Return: Opaque previously set with vhost_vq_set_backend_opaque.
> + */
> +static inline void *vhost_vq_get_backend_opaque(struct vhost_virtqueue *vq)
> +{
> +	return vq->private_data;
> +}
> +
>  static inline bool vhost_has_feature(struct vhost_virtqueue *vq, int bit)
>  {
>  	return vq->acked_features & (1ULL << bit);


I think I prefer vhost_vq_get_backend and vhost_vq_set_backend.

"opaque" just means that it's void * that is clear from the signature
anyway.


> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index c2d7d57e98cf..6e20dbe14acd 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -91,7 +91,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  
>  	mutex_lock(&vq->mutex);
>  
> -	if (!vq->private_data)
> +	if (!vhost_vq_get_backend_opaque(vq))
>  		goto out;
>  
>  	/* Avoid further vmexits, we're already processing the virtqueue */
> @@ -440,7 +440,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>  
>  	mutex_lock(&vq->mutex);
>  
> -	if (!vq->private_data)
> +	if (!vhost_vq_get_backend_opaque(vq))
>  		goto out;
>  
>  	vhost_disable_notify(&vsock->dev, vq);
> @@ -533,8 +533,8 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>  			goto err_vq;
>  		}
>  
> -		if (!vq->private_data) {
> -			vq->private_data = vsock;
> +		if (!vhost_vq_get_backend_opaque(vq)) {
> +			vhost_vq_set_backend_opaque(vq, vsock);
>  			ret = vhost_vq_init_access(vq);
>  			if (ret)
>  				goto err_vq;
> @@ -547,14 +547,14 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>  	return 0;
>  
>  err_vq:
> -	vq->private_data = NULL;
> +	vhost_vq_set_backend_opaque(vq, NULL);
>  	mutex_unlock(&vq->mutex);
>  
>  	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>  		vq = &vsock->vqs[i];
>  
>  		mutex_lock(&vq->mutex);
> -		vq->private_data = NULL;
> +		vhost_vq_set_backend_opaque(vq, NULL);
>  		mutex_unlock(&vq->mutex);
>  	}
>  err:
> @@ -577,7 +577,7 @@ static int vhost_vsock_stop(struct vhost_vsock *vsock)
>  		struct vhost_virtqueue *vq = &vsock->vqs[i];
>  
>  		mutex_lock(&vq->mutex);
> -		vq->private_data = NULL;
> +		vhost_vq_set_backend_opaque(vq, NULL);
>  		mutex_unlock(&vq->mutex);
>  	}
>  
> -- 
> 2.18.1
