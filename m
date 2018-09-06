From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 04/11] tuntap: simplify error handling in
	tun_build_skb()
Date: Thu, 6 Sep 2018 13:14:46 -0400
Message-ID: <20180906130425-mutt-send-email-mst__44867.3603743829$1536253966$gmane$org@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
	<20180906040526.22518-5-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180906040526.22518-5-jasowang@redhat.com>
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

On Thu, Sep 06, 2018 at 12:05:19PM +0800, Jason Wang wrote:
> There's no need to duplicate page get logic in each action. So this
> patch tries to get page and calculate the offset before processing XDP
> actions, and undo them when meet errors (we don't care the performance
> on errors). This will be used for factoring out XDP logic.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I see some issues with this one.

> ---
>  drivers/net/tun.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 372caf7d67d9..f8cdcfa392c3 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1642,7 +1642,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  				     int len, int *skb_xdp)
>  {
>  	struct page_frag *alloc_frag = &current->task_frag;
> -	struct sk_buff *skb;
> +	struct sk_buff *skb = NULL;
>  	struct bpf_prog *xdp_prog;
>  	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  	unsigned int delta = 0;
> @@ -1668,6 +1668,9 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  	if (copied != len)
>  		return ERR_PTR(-EFAULT);
>  
> +	get_page(alloc_frag->page);
> +	alloc_frag->offset += buflen;
> +

This adds an atomic op on XDP_DROP which is a data path
operation for some workloads.

>  	/* There's a small window that XDP may be set after the check
>  	 * of xdp_prog above, this should be rare and for simplicity
>  	 * we do XDP on skb in case the headroom is not enough.
> @@ -1695,23 +1698,15 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  
>  		switch (act) {
>  		case XDP_REDIRECT:
> -			get_page(alloc_frag->page);
> -			alloc_frag->offset += buflen;
>  			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
>  			xdp_do_flush_map();
>  			if (err)
> -				goto err_redirect;
> -			rcu_read_unlock();
> -			local_bh_enable();
> -			return NULL;
> +				goto err_xdp;
> +			goto out;
>  		case XDP_TX:
> -			get_page(alloc_frag->page);
> -			alloc_frag->offset += buflen;
>  			if (tun_xdp_tx(tun->dev, &xdp) < 0)
> -				goto err_redirect;
> -			rcu_read_unlock();
> -			local_bh_enable();
> -			return NULL;
> +				goto err_xdp;
> +			goto out;
>  		case XDP_PASS:
>  			delta = orig_data - xdp.data;
>  			len = xdp.data_end - xdp.data;
> @@ -1730,23 +1725,23 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  	local_bh_enable();
>  
>  	skb = build_skb(buf, buflen);
> -	if (!skb)
> -		return ERR_PTR(-ENOMEM);
> +	if (!skb) {
> +		skb = ERR_PTR(-ENOMEM);
> +		goto out;

So goto out will skip put_page, and we did
do get_page above. Seems wrong. You should
goto err_skb or something like this.


> +	}
>  
>  	skb_reserve(skb, pad - delta);
>  	skb_put(skb, len);
> -	get_page(alloc_frag->page);
> -	alloc_frag->offset += buflen;
>  
>  	return skb;
>  
> -err_redirect:
> -	put_page(alloc_frag->page);
>  err_xdp:
> +	alloc_frag->offset -= buflen;
> +	put_page(alloc_frag->page);
> +out:

Out here isn't an error at all, is it?  You should not mix return and
error handling IMHO.



>  	rcu_read_unlock();
>  	local_bh_enable();
> -	this_cpu_inc(tun->pcpu_stats->rx_dropped);

Doesn't this break rx_dropped accounting?

> -	return NULL;
> +	return skb;
>  }
>  
>  /* Get packet from user space buffer */
> -- 
> 2.17.1
