From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/4] net: skb_orphan on dev_hard_start_xmit
Date: Sun, 5 Jul 2009 11:34:08 +0800
Message-ID: <20090705033408.GB7430__26168.6584250585$1246764897$gmane$org@gondor.apana.org.au>
References: <20090703075530.GA25190@gondor.apana.org.au>
	<20090703.200254.172991821.davem@davemloft.net>
	<20090704030830.GA32442@gondor.apana.org.au>
	<20090703.201347.146036232.davem@davemloft.net>
	<20090704074245.GA1615@gondor.apana.org.au>
	<20090704090910.GA2185@gondor.apana.org.au>
	<20090705032658.GA7430@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090705032658.GA7430@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: patrick.ohly@intel.com, libertas-dev@lists.infradead.org, dcbw@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, rolandd@cisco.com, divy@chelsio.com, xemul@openvz.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jul 05, 2009 at 11:26:58AM +0800, Herbert Xu wrote:
> 
> Here's a another crazy idea:
> 
> Let's use dummy TX descriptors to generate an interrupt, either
> with or without transmitting an actual packet on the wire depending
> on the NIC.

Here's an even crazier idea that doesn't use dummy descriptors.

xmit(skb)

	if (TX queue contains no interrupting descriptor &&
	    qdisc is empty)
		mark TX descriptor as interrupting

	if (TX queue now contains an interrupting descriptor &&
	    qdisc len < 2)
		stop queue

	if (TX ring full)
		stop queue

clean()

 	do work
	wake queue as per usual

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
