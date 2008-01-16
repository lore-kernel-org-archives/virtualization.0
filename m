From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 2/3] virtio: Net header needs gso_hdr_len
Date: Wed, 16 Jan 2008 11:06:21 +1100
Message-ID: <E1JEvnR-0006ax-00__7233.78920597515$1200442842$gmane$org@gondolin.me.apana.org.au>
References: <200801152143.37112.rusty@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801152143.37112.rusty@rustcorp.com.au>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
> It's far easier to deal with GSO if we don't have to parse the packet
> to figure out the header length.  Add the field to the virtio_net_hdr
> struct (and fix the spaces that somehow crept in there).
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
> drivers/net/virtio_net.c   |    4 +++-
> include/linux/virtio_net.h |   11 ++++++-----
> 2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff -r 24ef33a4ab14 drivers/net/virtio_net.c
> --- a/drivers/net/virtio_net.c  Tue Jan 15 16:59:58 2008 +1100
> +++ b/drivers/net/virtio_net.c  Tue Jan 15 21:21:40 2008 +1100
> @@ -126,6 +126,7 @@ static void receive_skb(struct net_devic
>                /* Header must be checked, and gso_segs computed. */
>                skb_shinfo(skb)->gso_type |= SKB_GSO_DODGY;
>                skb_shinfo(skb)->gso_segs = 0;
> +               skb_set_transport_header(skb, hdr->gso_hdr_len);

Why do we need this? When receiving GSO packets from an untrusted
source the network stack will fill in the transport header offset
after verifying that the headers are sane.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
