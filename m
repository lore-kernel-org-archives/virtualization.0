From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 13/16] caif_virtio: use simplified virtqueue accessors.
Date: Wed, 20 Feb 2013 18:13:12 +0800
Message-ID: <5124A1B8.7030102@cn.fujitsu.com>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
	<1361260594-601-14-git-send-email-rusty@rustcorp.com.au>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1361260594-601-14-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 02/19/2013 03:56 PM, Rusty Russell wrote:
> We never add buffers with input and output parts, so use the new accessors.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  drivers/net/caif/caif_virtio.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
> index df832e7..9360055 100644
> --- a/drivers/net/caif/caif_virtio.c
> +++ b/drivers/net/caif/caif_virtio.c
> @@ -364,8 +364,7 @@ static int cfv_netdev_tx(struct sk_buff *skb, struct net_device *netdev)
>  	/* Add buffer to avail ring. Flow control below should ensure
>  	 * that this always succeedes
>  	 */
> -	ret = virtqueue_add_buf(cfv->vq_tx, &sg, 1, 0,
> -				buf_info, GFP_ATOMIC);
> +	ret = virtqueue_add_outbuf(cfv->vq_tx, &sg, 1, buf_info, GFP_ATOMIC);
>  
>  	if (unlikely(WARN_ON(ret < 0))) {
>  		kfree(buf_info);
> 
