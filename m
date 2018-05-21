From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net 2/4] virtio-net: correctly transmit XDP buff after
	linearizing
Date: Mon, 21 May 2018 18:03:51 +0300
Message-ID: <20180521180346-mutt-send-email-mst__31927.9090538204$1526914930$gmane$org@kernel.org>
References: <1526891706-18516-1-git-send-email-jasowang@redhat.com>
	<1526891706-18516-3-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1526891706-18516-3-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 21, 2018 at 04:35:04PM +0800, Jason Wang wrote:
> We should not go for the error path after successfully transmitting a
> XDP buffer after linearizing. Since the error path may try to pop and
> drop next packet and increase the drop counters. Fixing this by simply
> drop the refcnt of original page and go for xmit path.
> 
> Fixes: 72979a6c3590 ("virtio_net: xdp, add slowpath case for non contiguous buffers")
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c15d240..6260d65 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -775,7 +775,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  			}
>  			*xdp_xmit = true;
>  			if (unlikely(xdp_page != page))
> -				goto err_xdp;
> +				put_page(page);
>  			rcu_read_unlock();
>  			goto xdp_xmit;
>  		case XDP_REDIRECT:
> -- 
> 2.7.4
