From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [kvm-devel] [PATCH 3/6] virtio net driver
Date: Fri, 21 Sep 2007 22:08:33 +0800
Message-ID: <20070921140833.GA12242__11457.6049767949$1190385890$gmane$org@gondor.apana.org.au>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<200709211248.11783.borntraeger@de.ibm.com>
	<1190375615.27805.9.camel@localhost.localdomain>
	<200709211436.43964.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200709211436.43964.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, lguest <lguest@ozlabs.org>, Jeff Garzik <jeff@garzik.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 21, 2007 at 02:36:43PM +0200, Christian Borntraeger wrote:
>
> @@ -335,7 +344,7 @@ static void *virtnet_probe(struct device
>  	dev->poll = virtnet_poll;
>  	dev->hard_start_xmit = start_xmit;
>  	dev->weight = 16;
> -	dev->features = NETIF_F_HIGHDMA;
> +	dev->features = NETIF_F_HIGHDMA | NETIF_F_LLTX;
>  	SET_NETDEV_DEV(dev, device);
>  
>  	/* Do we support "hardware" checksums? */

Please don't use LLTX in new drivers.  We're trying to get rid
of it since it's

1) unnecessary;
2) causes problems with AF_PACKET seeing things twice.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
