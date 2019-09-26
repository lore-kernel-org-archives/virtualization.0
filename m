From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] vsock/virtio: add support for MSG_PEEK
Date: Thu, 26 Sep 2019 12:33:36 -0700
Message-ID: <f069a65d-33b9-1fa8-d26e-b76cc51fc7cb__48660.2792677999$1569526428$gmane$org@gmail.com>
References: <1569522214-28223-1-git-send-email-matiasevara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1569522214-28223-1-git-send-email-matiasevara@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matias Ezequiel Vara Larsen <matiasevara@gmail.com>, stefanha@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, davem@davemloft.net, sgarzare@redhat.com
List-Id: virtualization@lists.linuxfoundation.org



On 9/26/19 11:23 AM, Matias Ezequiel Vara Larsen wrote:
> This patch adds support for MSG_PEEK. In such a case, packets are not
> removed from the rx_queue and credit updates are not sent.
> 
> Signed-off-by: Matias Ezequiel Vara Larsen <matiasevara@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 50 +++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 94cc0fa..938f2ed 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -264,6 +264,50 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk,
>  }
>  
>  static ssize_t
> +virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> +				struct msghdr *msg,
> +				size_t len)
> +{
> +	struct virtio_vsock_sock *vvs = vsk->trans;
> +	struct virtio_vsock_pkt *pkt;
> +	size_t bytes, total = 0;
> +	int err = -EFAULT;
> +
> +	spin_lock_bh(&vvs->rx_lock);
> +
> +	list_for_each_entry(pkt, &vvs->rx_queue, list) {
> +		if (total == len)
> +			break;
> +
> +		bytes = len - total;
> +		if (bytes > pkt->len - pkt->off)
> +			bytes = pkt->len - pkt->off;
> +
> +		/* sk_lock is held by caller so no one else can dequeue.
> +		 * Unlock rx_lock since memcpy_to_msg() may sleep.
> +		 */
> +		spin_unlock_bh(&vvs->rx_lock);
> +
> +		err = memcpy_to_msg(msg, pkt->buf + pkt->off, bytes);
> +		if (err)
> +			goto out;
> +
> +		spin_lock_bh(&vvs->rx_lock);
> +
> +		total += bytes;
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
>

This seems buggy to me.

virtio_transport_recv_enqueue() seems to be able to add payload to the last packet in the queue.

The loop you wrote here would miss newly added chunks while the vvs->rx_lock spinlock has been released.

virtio_transport_stream_do_dequeue() is ok, because it makes sure pkt->off == pkt->len
before cleaning the packet from the queue.
