From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net 1/4] virtio-net: correctly redirect linearized packet
Date: Mon, 21 May 2018 18:03:38 +0300
Message-ID: <20180521180321-mutt-send-email-mst__38080.5262634114$1526914906$gmane$org@kernel.org>
References: <1526891706-18516-1-git-send-email-jasowang@redhat.com>
	<1526891706-18516-2-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1526891706-18516-2-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 21, 2018 at 04:35:03PM +0800, Jason Wang wrote:
> After a linearized packet was redirected by XDP, we should not go for
> the err path which will try to pop buffers for the next packet and
> increase the drop counter. Fixing this by just drop the page refcnt
> for the original page.
> 
> Fixes: 186b3c998c50 ("virtio-net: support XDP_REDIRECT")
> Reported-by: David Ahern <dsahern@gmail.com>
> Tested-by: David Ahern <dsahern@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 770422e..c15d240 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -787,7 +787,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  			}
>  			*xdp_xmit = true;
>  			if (unlikely(xdp_page != page))
> -				goto err_xdp;
> +				put_page(page);
>  			rcu_read_unlock();
>  			goto xdp_xmit;
>  		default:
> -- 
> 2.7.4
