From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 03/11] tuntap: enable bh early during processing
	XDP
Date: Thu, 6 Sep 2018 13:02:51 -0400
Message-ID: <20180906130224-mutt-send-email-mst__38023.5052355149$1536253252$gmane$org@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
	<20180906040526.22518-4-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180906040526.22518-4-jasowang@redhat.com>
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

On Thu, Sep 06, 2018 at 12:05:18PM +0800, Jason Wang wrote:
> This patch move the bh enabling a little bit earlier, this will be
> used for factoring out the core XDP logic of tuntap.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

no reason to disable bh for non-xdp things.

> ---
>  drivers/net/tun.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d3677a544b56..372caf7d67d9 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1726,22 +1726,18 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  			goto err_xdp;
>  		}
>  	}
> +	rcu_read_unlock();
> +	local_bh_enable();
>  
>  	skb = build_skb(buf, buflen);
> -	if (!skb) {
> -		rcu_read_unlock();
> -		local_bh_enable();
> +	if (!skb)
>  		return ERR_PTR(-ENOMEM);
> -	}
>  
>  	skb_reserve(skb, pad - delta);
>  	skb_put(skb, len);
>  	get_page(alloc_frag->page);
>  	alloc_frag->offset += buflen;
>  
> -	rcu_read_unlock();
> -	local_bh_enable();
> -
>  	return skb;
>  
>  err_redirect:
> -- 
> 2.17.1
