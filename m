From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH RFC 4/5] tun: vringfd xmit support.
Date: Mon, 07 Apr 2008 13:13:44 +0800
Message-ID: <E1Jijfs-0004Lo-00__6693.29307643256$1207545335$gmane$org@gondolin.me.apana.org.au>
References: <200804052206.33922.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804052206.33922.rusty@rustcorp.com.au>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, maxk@qualcomm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> +/* We are done with this skb: put it in the used pile. */
> +static void skb_finished(struct skb_shared_info *sinfo)
> +{
> +       struct skb_shinfo_tun *sht = (void *)(sinfo + 1);
> +
> +       /* FIXME: Race prevention */
> +       vring_used_buffer_atomic(sht->tun->outring, sht->id, sht->len);
> +       vring_wake(sht->tun->outring);
> +
> +       /* Release device. */
> +       dev_put(sht->tun->dev);
> +}

On second thought, this is not going to work.  The network stack
can clone individual pages out of this skb and put it into a new
skb.  Therefore whatever scheme we come up with will either need
to be page-based, or add a flag to tell the network stack that it
can't clone those pages.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
