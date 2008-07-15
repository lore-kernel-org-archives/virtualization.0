From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 4/5] virtio net: Allow receiving SG packets
Date: Tue, 15 Jul 2008 11:52:09 +0800
Message-ID: <20080715035209.GB2657__37430.5417099551$1216094055$gmane$org@gondor.apana.org.au>
References: <200807151341.39337.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200807151341.39337.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 14, 2008 at 10:41:38PM -0500, Rusty Russell wrote:
>
> +	/* If we can receive ANY GSO packets, we must allocate large ones. */
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4)
> +	    || virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6)
> +	    || virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN))
> +		dev->features |= NETIF_F_LRO;

We don't want to do this because LRO implies joining packets
together in an irreversible way which is not what this is about.

Case in point we're now disabling LRO for devices that are
forwarding packets which is totally unnecessary for virtio.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
