From: Krishna Kumar2 <krkumar2@in.ibm.com>
Subject: Re: [PATCH 2/4] virtio_net: return NETDEV_TX_BUSY instead of	queueing
	an extra skb.
Date: Mon, 22 Jun 2009 11:16:03 +0530
Message-ID: <OF1B3705AA.30E31D1D-ON652575DD.001F2CCD-652575DD.001FAE94__13781.2668378048$1245689635$gmane$org@in.ibm.com>
References: <200905292346.04815.rusty@rustcorp.com.au>
	<200906181647.51045.rusty@rustcorp.com.au>
	<20090618073422.GA4087@gondor.apana.org.au>
	<200906191307.20360.rusty@rustcorp.com.au>
	<20090619043613.GA15163@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090619043613.GA15163@gondor.apana.org.au>
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

Hi Herbert,

> Herbert Xu <herbert@gondor.apana.org.au> wrote on 06/19/2009 10:06:13 AM:
>
> > We either remove the API, or fix it.  I think fixing it is better,
because my
> > driver will be simpler and it's obvious noone wants to rewrite 50
drivers and
> > break several of them.
>
> My preference is obviously in the long term removal of TX_BUSY.
> Due to resource constraints that cannot be done immediately.  So
> at least we should try to stop its proliferation.
>
> BTW removing TX_BUSY does not mean that your driver has to stay
> complicated.  As I have said repeatedly your driver should be
> checking the stop-queue condition after transmission, not before.
>
> In fact queueing it in the driver is just as bad as return TX_BUSY!

I was curious about "queueing it in the driver" part: why is this bad? Do
you
anticipate any performance problems, or does it break QoS, or something
else I
have missed?

thanks,

- KK
