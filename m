From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [patch 31/32] xen: --- drivers/net/xen-netfront.c | 6 +++--- 1 file changed, 3 insertions(+), 3 deletions(-)
Date: Wed, 02 May 2007 16:33:53 +1000
Message-ID: <E1Hj8PR-0007wA-00@gondolin.me.apana.org.au>
References: <20070429172916.861677000@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992838AbXEBGer@vger.kernel.org>
In-Reply-To: <20070429172916.861677000@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: ak@suse.de, akpm@linux-foundation.org, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> ===================================================================
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -1213,10 +1213,10 @@ static int netif_poll(struct net_device 

Any reason why xen-netfront isn't just in a single patch? It makes
it a bit hard to review having it scattered around like this.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
