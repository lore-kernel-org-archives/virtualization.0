From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 2/4] virtio_net: return NETDEV_TX_BUSY instead of
	queueing an extra skb.
Date: Tue, 23 Jun 2009 10:54:59 +0800
Message-ID: <20090623025459.GA5991__22451.518130447$1245725758$gmane$org@gondor.apana.org.au>
References: <200905292346.04815.rusty@rustcorp.com.au>
	<200906181647.51045.rusty@rustcorp.com.au>
	<20090618073422.GA4087@gondor.apana.org.au>
	<200906191307.20360.rusty@rustcorp.com.au>
	<20090619043613.GA15163@gondor.apana.org.au>
	<OF1B3705AA.30E31D1D-ON652575DD.001F2CCD-652575DD.001FAE94@in.ibm.com>
	<20090622073417.GA21698@gondor.apana.org.au>
	<20090622182529.GA4990@xw6200.broadcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090622182529.GA4990@xw6200.broadcom.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matt Carlson <mcarlson@broadcom.com>
Cc: Krishna Kumar2 <krkumar2@in.ibm.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 22, 2009 at 11:25:29AM -0700, Matt Carlson wrote:
>
> As was said elsewhere, from the driver writer's perspective every packet
> that has already been submitted (queued) to the hardware cannot be
> preempted.  Slightly extending that logic doesn't seem like that much of
> a problem, especially if it saves the troublesome requeuing logic higher up.

I think this is pretty much the same as returning TX_BUSY :)

Do you have access to one of these buggy cards? Can you run some
tests to see what the difference between TSO and GSO is on them?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
