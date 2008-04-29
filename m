From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/4] virtio: wean net driver off NETDEV_TX_BUSY
Date: Tue, 29 Apr 2008 13:06:16 +0800
Message-ID: <20080429050616.GA17840__24738.0010122017$1209445703$gmane$org@gondor.apana.org.au>
References: <200804290116.05951.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200804290116.05951.rusty@rustcorp.com.au>
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

On Tue, Apr 29, 2008 at 01:16:05AM +1000, Rusty Russell wrote:
>
> +	/* If we has a buffer left over from last time, send it now. */
> +	if (vi->last_xmit_skb) {
> +		if (xmit_skb(vi, vi->last_xmit_skb) != 0) {
> +			/* Drop this skb: we only queue one. */
> +			kfree_skb(skb);
> +			goto stop_queue;

We should increment the drop counter here.

Otherwise these patches all look good to me.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
