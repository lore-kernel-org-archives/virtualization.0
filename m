From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 23/25] xen: Lockdep fixes for xen-netfront
Date: Tue, 24 Apr 2007 13:22:31 +1000
Message-ID: <E1HgBbr-0007Ob-00@gondolin.me.apana.org.au>
References: <20070423215713.768656419@goop.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070423215713.768656419@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: chrisw@sous-sol.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
> @@ -1212,10 +1212,10 @@ static int netif_poll(struct net_device 
>        int pages_flipped = 0;
>        int err;
> 
> -       spin_lock(&np->rx_lock);
> +       spin_lock_bh(&np->rx_lock);
> 
>        if (unlikely(!netfront_carrier_ok(np))) {
> -               spin_unlock(&np->rx_lock);
> +               spin_unlock_bh(&np->rx_lock);

You don't need to disable BH in netif_poll since it's always called
with BH disabled.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
