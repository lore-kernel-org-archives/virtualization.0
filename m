From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] virtio_net: Fix skb->csum_start computation
Date: Thu, 29 May 2008 17:31:16 +1000
Message-ID: <200805291731.17131.rusty__8061.57279662347$1212046530$gmane$org@rustcorp.com.au>
References: <1211887247-31979-1-git-send-email-markmc@redhat.com>
	<1211887247-31979-3-git-send-email-markmc@redhat.com>
	<1211887247-31979-4-git-send-email-markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1211887247-31979-4-git-send-email-markmc@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 27 May 2008 21:20:47 Mark McLoughlin wrote:
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

As should the rx_bytes += skb->len.  Thanks for this!

Applied (and 1/3, the typo patch).

I'll backport this to -stable, as well.

Thanks,
Rusty.
