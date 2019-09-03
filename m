From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 2/5] vsock/virtio: reduce credit update messages
Date: Tue, 3 Sep 2019 00:38:02 -0400
Message-ID: <20190903003050-mutt-send-email-mst@kernel.org>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190717113030.163499-3-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190717113030.163499-3-sgarzare@redhat.com>
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

On Wed, Jul 17, 2019 at 01:30:27PM +0200, Stefano Garzarella wrote:
> In order to reduce the number of credit update messages,
> we send them only when the space available seen by the
> transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/virtio_vsock.h            |  1 +
>  net/vmw_vsock/virtio_transport_common.c | 16 +++++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index 7d973903f52e..49fc9d20bc43 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -41,6 +41,7 @@ struct virtio_vsock_sock {
>  
>  	/* Protected by rx_lock */
>  	u32 fwd_cnt;
> +	u32 last_fwd_cnt;
>  	u32 rx_bytes;
>  	struct list_head rx_queue;
>  };
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 095221f94786..a85559d4d974 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -211,6 +211,7 @@ static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
>  void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct virtio_vsock_pkt *pkt)
>  {
>  	spin_lock_bh(&vvs->tx_lock);
> +	vvs->last_fwd_cnt = vvs->fwd_cnt;
>  	pkt->hdr.fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
>  	pkt->hdr.buf_alloc = cpu_to_le32(vvs->buf_alloc);
>  	spin_unlock_bh(&vvs->tx_lock);
> @@ -261,6 +262,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  	struct virtio_vsock_sock *vvs = vsk->trans;
>  	struct virtio_vsock_pkt *pkt;
>  	size_t bytes, total = 0;
> +	u32 free_space;
>  	int err = -EFAULT;
>  
>  	spin_lock_bh(&vvs->rx_lock);
> @@ -291,11 +293,19 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  			virtio_transport_free_pkt(pkt);
>  		}
>  	}
> +
> +	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
> +
>  	spin_unlock_bh(&vvs->rx_lock);
>  
> -	/* Send a credit pkt to peer */
> -	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
> -					    NULL);
> +	/* We send a credit update only when the space available seen
> +	 * by the transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE

This is just repeating what code does though.
Please include the *reason* for the condition.
E.g. here's a better comment:

	/* To reduce number of credit update messages,
	 * don't update credits as long as lots of space is available.
	 * Note: the limit chosen here is arbitrary. Setting the limit
	 * too high causes extra messages. Too low causes transmitter
	 * stalls. As stalls are in theory more expensive than extra
	 * messages, we set the limit to a high value. TODO: experiment
	 * with different values.
	 */


> +	 */
> +	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
> +		virtio_transport_send_credit_update(vsk,
> +						    VIRTIO_VSOCK_TYPE_STREAM,
> +						    NULL);
> +	}
>  
>  	return total;
>  
> -- 
> 2.20.1
