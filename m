From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/4] virtio_net: Fix skb->csum_start computation
Date: Tue, 10 Jun 2008 18:21:42 -0400
Message-ID: <484EFE76.1080309__17081.6507576548$1213136622$gmane$org@garzik.org>
References: <200806082049.00641.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200806082049.00641.rusty@rustcorp.com.au>
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

Rusty Russell wrote:
> From: Mark McLoughlin <markmc@redhat.com>
> 
> hdr->csum_start is the offset from the start of the ethernet
> header to the transport layer checksum field. skb->csum_start
> is the offset from skb->head.
> 
> skb_partial_csum_set() assumes that skb->data points to the
> ethernet header - i.e. it computes skb->csum_start by adding
> the headroom to hdr->csum_start.
> 
> Since eth_type_trans() skb_pull()s the ethernet header,
> skb_partial_csum_set() should be called before
> eth_type_trans().
> 
> (Without this patch, GSO packets from a guest to the world outside the
> host are corrupted).
> 
> Signed-off-by: Mark McLoughlin <markmc@redhat.com>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/net/virtio_net.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

applied 1-4
