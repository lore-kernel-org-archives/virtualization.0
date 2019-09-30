From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2] vsock/virtio: add support for MSG_PEEK
Date: Mon, 30 Sep 2019 16:12:36 +0200
Message-ID: <20190930141236.lp3nroal33k63vlg__12962.3851202027$1569852772$gmane$org@steredhat>
References: <1569522214-28223-1-git-send-email-matiasevara@gmail.com>
	<1569602663-16815-1-git-send-email-matiasevara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1569602663-16815-1-git-send-email-matiasevara@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matias Ezequiel Vara Larsen <matiasevara@gmail.com>
Cc: eric.dumazet@gmail.com, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Hi Matias,

On Fri, Sep 27, 2019 at 04:44:23PM +0000, Matias Ezequiel Vara Larsen wrote:
> This patch adds support for MSG_PEEK. In such a case, packets are not
> removed from the rx_queue and credit updates are not sent.
> 
> Signed-off-by: Matias Ezequiel Vara Larsen <matiasevara@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 55 +++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 3 deletions(-)

The patch LGTM. As David pointed out, this patch should go into net-next.
Since now net-next is open, you can resend with net-next tag [1] and
with:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

[1] https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 94cc0fa..cf15751 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -264,6 +264,55 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk,
>  }
>  
>  static ssize_t
> +virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> +				struct msghdr *msg,
> +				size_t len)
> +{
> +	struct virtio_vsock_sock *vvs = vsk->trans;
> +	struct virtio_vsock_pkt *pkt;
> +	size_t bytes, total = 0, off;
> +	int err = -EFAULT;
> +
> +	spin_lock_bh(&vvs->rx_lock);
> +
> +	list_for_each_entry(pkt, &vvs->rx_queue, list) {
> +		off = pkt->off;
> +
> +		if (total == len)
> +			break;
> +
> +		while (total < len && off < pkt->len) {
> +			bytes = len - total;
> +			if (bytes > pkt->len - off)
> +				bytes = pkt->len - off;
> +
> +			/* sk_lock is held by caller so no one else can dequeue.
> +			 * Unlock rx_lock since memcpy_to_msg() may sleep.
> +			 */
> +			spin_unlock_bh(&vvs->rx_lock);
> +
> +			err = memcpy_to_msg(msg, pkt->buf + off, bytes);
> +			if (err)
> +				goto out;
> +
> +			spin_lock_bh(&vvs->rx_lock);
> +
> +			total += bytes;
> +			off += bytes;
> +		}
> +	}
> +
> +	spin_unlock_bh(&vvs->rx_lock);
> +
> +	return total;
> +
> +out:
> +	if (total)
> +		err = total;
> +	return err;
> +}
> +
> +static ssize_t
>  virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  				   struct msghdr *msg,
>  				   size_t len)
> @@ -330,9 +379,9 @@ virtio_transport_stream_dequeue(struct vsock_sock *vsk,
>  				size_t len, int flags)
>  {
>  	if (flags & MSG_PEEK)
> -		return -EOPNOTSUPP;
> -
> -	return virtio_transport_stream_do_dequeue(vsk, msg, len);
> +		return virtio_transport_stream_do_peek(vsk, msg, len);
> +	else
> +		return virtio_transport_stream_do_dequeue(vsk, msg, len);
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_stream_dequeue);
>  
> -- 
> 2.7.4
> 

-- 
