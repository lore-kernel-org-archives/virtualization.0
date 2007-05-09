From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [patch 7/9] lguest: the net driver
Date: Wed, 09 May 2007 20:12:46 +1000
Message-ID: <E1HljA6-0001E4-00@gondolin.me.apana.org.au>
References: <200705090951.l499pdOr020406@shell0.pdx.osdl.net>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <200705090951.l499pdOr020406@shell0.pdx.osdl.net>
Sender: netdev-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, rusty@rustcorp.com.au, ak@suse.de, jeff@garzik.org, jmorris@namei.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

akpm@linux-foundation.org wrote:
>
> +       if (desc->features & LGUEST_NET_F_NOCSUM)
> +               dev->features |= NETIF_F_NO_CSUM;

Any reason why you're using NO_CSUM here instead of HW_CSUM?
Practically there is no difference but NO_CSUM could be treated
differently in future and I'm not sure whether such changes would
be desirable in this driver (i.e., not even generating a partial
checksum).

Also, there doesn't seem to be any passing of metadata to the
backend which means that neither NO_CSUM/HW_CSUM can work if
somebody needs to look at the checksum field.  You could use
IP_CSUM if you do the same hack on the backend that Xen does.
Otherwise you'll have to make do with no checksum offload at all.

I think you'd also need a change_mtu function if the SG feature
is going to be of some use since the default Ethernet one limits
the MTU to 1500.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
