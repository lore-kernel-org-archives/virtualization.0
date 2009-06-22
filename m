From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/4] virtio_net: return NETDEV_TX_BUSY instead of queueing
	an extra skb.
Date: Mon, 22 Jun 2009 12:09:15 +0930
Message-ID: <200906221209.16481.rusty__31654.8365787186$1245638500$gmane$org@rustcorp.com.au>
References: <200905292346.04815.rusty@rustcorp.com.au>
	<200906192320.44904.rusty@rustcorp.com.au>
	<20090619141014.GA19828@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090619141014.GA19828@gondor.apana.org.au>
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
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, Matt Carlson <mcarlson@broadcom.com>, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 19 Jun 2009 11:40:14 pm Herbert Xu wrote:
> > On the other hand, we're underutilizing the queue to avoid it.  I find
> > that a little embarrassing.
>
> Here's why I think this is not an issue.  If your NIC is high
> bandwidth then your ring is going to have to be huge so the
> amount that is underutilised (a 64K packet) is tiny.  If your
> NIC is low bandwidth then this is where you often need QoS and
> in that case you do *NOT* want to fully utilise the HW queue.

Well, we leave that up to the NIC designer.  It's retro-justification for 
throwing away a few percent of the queue, but the QoS issue is even more in 
the noise.

But I will give in now and change virtio_net to use this substandard API :(

Thanks,
Rusty.
