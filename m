From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] lguest: virtio-rng support
Date: Mon, 19 May 2008 19:05:10 +1000
Message-ID: <200805191905.11452.rusty__29722.3056004897$1211188231$gmane$org@rustcorp.com.au>
References: <482C8595.5030509@garzik.org>
	<200805171628.03801.rusty@rustcorp.com.au>
	<482E8D75.10606@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <482E8D75.10606@goop.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Theodore Tso <tytso@mit.edu>, Herbert Xu <herbert@gondor.apana.org.au>, Jeff Garzik <jeff@garzik.org>, Matt Mackall <mpm@selenic.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Johannes Berg <johannes@sipsolutions.net>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 17 May 2008 17:47:01 Jeremy Fitzhardinge wrote:
> But the host->guest protocol should include the number of bits estimated
> entropy along with the bits themselves.

If we go down that path, we have to come up with a way of feeding that 
information to guest userspace.  Patches welcome.  If we meanwhile assume 
entropy == #bits, it fits the current /dev/hwrng model, and we can add an 
entropy count later if we want to change that.

I'll change my lguest implementation to suck from /dev/random, since noone 
else seems to consider its depletion to be a real issue.  It's no worse than 
what any other process can do.

Thanks,
Rusty.
