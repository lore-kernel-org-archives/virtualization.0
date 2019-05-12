From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/8] vsock/virtio: limit the memory used per-socket
Date: Sun, 12 May 2019 12:57:48 -0400
Message-ID: <20190512125447-mutt-send-email-mst@kernel.org>
References: <20190510125843.95587-1-sgarzare@redhat.com>
	<20190510125843.95587-2-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190510125843.95587-2-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 10, 2019 at 02:58:36PM +0200, Stefano Garzarella wrote:
> Since virtio-vsock was introduced, the buffers filled by the host
> and pushed to the guest using the vring, are directly queued in
> a per-socket list avoiding to copy it.
> These buffers are preallocated by the guest with a fixed
> size (4 KB).
> 
> The maximum amount of memory used by each socket should be
> controlled by the credit mechanism.
> The default credit available per-socket is 256 KB, but if we use
> only 1 byte per packet, the guest can queue up to 262144 of 4 KB
> buffers, using up to 1 GB of memory per-socket. In addition, the
> guest will continue to fill the vring with new 4 KB free buffers
> to avoid starvation of other sockets.
> 
> This patch solves this issue copying the payload in a new buffer.
> Then it is queued in the per-socket list, and the 4KB buffer used
> by the host is freed.
> 
> In this way, the memory used by each socket respects the credit
> available, and we still avoid starvation, paying the cost of an
> extra memory copy. When the buffer is completely full we do a
> "zero-copy", moving the buffer directly in the per-socket list.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vhost/vsock.c                   |  2 +
>  include/linux/virtio_vsock.h            |  8 +++
>  net/vmw_vsock/virtio_transport.c        |  1 +
>  net/vmw_vsock/virtio_transport_common.c | 95 ++++++++++++++++++-------
>  4 files changed, 81 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index bb5fc0e9fbc2..7964e2daee09 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -320,6 +320,8 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
>  		return NULL;
>  	}
>  
> +	pkt->buf_len = pkt->len;
> +
>  	nbytes = copy_from_iter(pkt->buf, pkt->len, &iov_iter);
>  	if (nbytes != pkt->len) {
>  		vq_err(vq, "Expected %u byte payload, got %zu bytes\n",
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index e223e2632edd..345f04ee9193 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -54,9 +54,17 @@ struct virtio_vsock_pkt {
>  	void *buf;
>  	u32 len;
>  	u32 off;
> +	u32 buf_len;
>  	bool reply;
>  };
>  
> +struct virtio_vsock_buf {
> +	struct list_head list;
> +	void *addr;
> +	u32 len;
> +	u32 off;
> +};
> +
>  struct virtio_vsock_pkt_info {
>  	u32 remote_cid, remote_port;
>  	struct vsock_sock *vsk;
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 15eb5d3d4750..af1d2ce12f54 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -280,6 +280,7 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
>  			break;
>  		}
>  
> +		pkt->buf_len = buf_len;
>  		pkt->len = buf_len;
>  
>  		sg_init_one(&hdr, &pkt->hdr, sizeof(pkt->hdr));
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 602715fc9a75..0248d6808755 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -65,6 +65,9 @@ virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
>  		pkt->buf = kmalloc(len, GFP_KERNEL);
>  		if (!pkt->buf)
>  			goto out_pkt;
> +
> +		pkt->buf_len = len;
> +
>  		err = memcpy_from_msg(pkt->buf, info->msg, len);
>  		if (err)
>  			goto out;
> @@ -86,6 +89,46 @@ virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
>  	return NULL;
>  }
>  
> +static struct virtio_vsock_buf *
> +virtio_transport_alloc_buf(struct virtio_vsock_pkt *pkt, bool zero_copy)
> +{
> +	struct virtio_vsock_buf *buf;
> +
> +	if (pkt->len == 0)
> +		return NULL;
> +
> +	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> +	if (!buf)
> +		return NULL;
> +
> +	/* If the buffer in the virtio_vsock_pkt is full, we can move it to
> +	 * the new virtio_vsock_buf avoiding the copy, because we are sure that
> +	 * we are not use

we do not use

> more memory than that counted by the credit mechanism.
> +	 */
> +	if (zero_copy && pkt->len == pkt->buf_len) {
> +		buf->addr = pkt->buf;
> +		pkt->buf = NULL;
> +	} else {
> +		buf->addr = kmalloc(pkt->len, GFP_KERNEL);
> +		if (!buf->addr) {
> +			kfree(buf);
> +			return NULL;
> +		}
> +
> +		memcpy(buf->addr, pkt->buf, pkt->len);
> +	}
> +
> +	buf->len = pkt->len;
> +
> +	return buf;
> +}
> +
> +static void virtio_transport_free_buf(struct virtio_vsock_buf *buf)
> +{
> +	kfree(buf->addr);
> +	kfree(buf);
> +}
> +
>  /* Packet capture */
>  static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  {
> @@ -190,17 +233,15 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	return virtio_transport_get_ops()->send_pkt(pkt);
>  }
>  
> -static void virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> -					struct virtio_vsock_pkt *pkt)
> +static void virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs, u32 len)
>  {
> -	vvs->rx_bytes += pkt->len;
> +	vvs->rx_bytes += len;
>  }
>  
> -static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
> -					struct virtio_vsock_pkt *pkt)
> +static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs, u32 len)
>  {
> -	vvs->rx_bytes -= pkt->len;
> -	vvs->fwd_cnt += pkt->len;
> +	vvs->rx_bytes -= len;
> +	vvs->fwd_cnt += len;
>  }
>  
>  void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct virtio_vsock_pkt *pkt)
> @@ -254,36 +295,36 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  				   size_t len)
>  {
>  	struct virtio_vsock_sock *vvs = vsk->trans;
> -	struct virtio_vsock_pkt *pkt;
> +	struct virtio_vsock_buf *buf;
>  	size_t bytes, total = 0;
>  	int err = -EFAULT;
>  
>  	spin_lock_bh(&vvs->rx_lock);
>  	while (total < len && !list_empty(&vvs->rx_queue)) {
> -		pkt = list_first_entry(&vvs->rx_queue,
> -				       struct virtio_vsock_pkt, list);
> +		buf = list_first_entry(&vvs->rx_queue,
> +				       struct virtio_vsock_buf, list);
>  
>  		bytes = len - total;
> -		if (bytes > pkt->len - pkt->off)
> -			bytes = pkt->len - pkt->off;
> +		if (bytes > buf->len - buf->off)
> +			bytes = buf->len - buf->off;
>  
>  		/* sk_lock is held by caller so no one else can dequeue.
>  		 * Unlock rx_lock since memcpy_to_msg() may sleep.
>  		 */
>  		spin_unlock_bh(&vvs->rx_lock);
>  
> -		err = memcpy_to_msg(msg, pkt->buf + pkt->off, bytes);
> +		err = memcpy_to_msg(msg, buf->addr + buf->off, bytes);
>  		if (err)
>  			goto out;
>  
>  		spin_lock_bh(&vvs->rx_lock);
>  
>  		total += bytes;
> -		pkt->off += bytes;
> -		if (pkt->off == pkt->len) {
> -			virtio_transport_dec_rx_pkt(vvs, pkt);
> -			list_del(&pkt->list);
> -			virtio_transport_free_pkt(pkt);
> +		buf->off += bytes;
> +		if (buf->off == buf->len) {
> +			virtio_transport_dec_rx_pkt(vvs, buf->len);
> +			list_del(&buf->list);
> +			virtio_transport_free_buf(buf);
>  		}
>  	}
>  	spin_unlock_bh(&vvs->rx_lock);
> @@ -841,20 +882,24 @@ virtio_transport_recv_connected(struct sock *sk,
>  {
>  	struct vsock_sock *vsk = vsock_sk(sk);
>  	struct virtio_vsock_sock *vvs = vsk->trans;
> +	struct virtio_vsock_buf *buf;
>  	int err = 0;
>  
>  	switch (le16_to_cpu(pkt->hdr.op)) {
>  	case VIRTIO_VSOCK_OP_RW:
>  		pkt->len = le32_to_cpu(pkt->hdr.len);
> -		pkt->off = 0;
> +		buf = virtio_transport_alloc_buf(pkt, true);


This seems to be the only callers and second parameter
is always true. So why is it needed?

>  
> -		spin_lock_bh(&vvs->rx_lock);
> -		virtio_transport_inc_rx_pkt(vvs, pkt);
> -		list_add_tail(&pkt->list, &vvs->rx_queue);
> -		spin_unlock_bh(&vvs->rx_lock);
> +		if (buf) {
> +			spin_lock_bh(&vvs->rx_lock);
> +			virtio_transport_inc_rx_pkt(vvs, pkt->len);
> +			list_add_tail(&buf->list, &vvs->rx_queue);
> +			spin_unlock_bh(&vvs->rx_lock);
>  
> -		sk->sk_data_ready(sk);
> -		return err;
> +			sk->sk_data_ready(sk);
> +		}
> +
> +		break;
>  	case VIRTIO_VSOCK_OP_CREDIT_UPDATE:
>  		sk->sk_write_space(sk);
>  		break;
> -- 
> 2.20.1
