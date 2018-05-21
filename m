From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH net-next 06/12] tuntap: enable premmption early
Date: Mon, 21 May 2018 17:32:38 +0300
Message-ID: <20180521173230-mutt-send-email-mst__23719.4711844952$1526913037$gmane$org@kernel.org>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
	<1526893473-20128-7-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1526893473-20128-7-git-send-email-jasowang@redhat.com>
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

On Mon, May 21, 2018 at 05:04:27PM +0800, Jason Wang wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>

typo in subject

> ---
>  drivers/net/tun.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 44d4f3d..24ecd82 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1697,6 +1697,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  			goto err_xdp;
>  		}
>  	}
> +	rcu_read_unlock();
> +	preempt_enable();
>  
>  	skb = build_skb(buf, buflen);
>  	if (!skb) {
> @@ -1710,9 +1712,6 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  	get_page(alloc_frag->page);
>  	alloc_frag->offset += buflen;
>  
> -	rcu_read_unlock();
> -	preempt_enable();
> -
>  	return skb;
>  
>  err_redirect:
> -- 
> 2.7.4
