From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] lguest: virtio-rng support
Date: Mon, 19 May 2008 19:28:12 +1000
Message-ID: <200805191928.13043.rusty__7047.49359651959$1211189437$gmane$org@rustcorp.com.au>
References: <482C8595.5030509@garzik.org>
	<200805191905.11452.rusty@rustcorp.com.au>
	<48314419.4080606@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48314419.4080606@goop.org>
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

On Monday 19 May 2008 19:10:49 Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> > On Saturday 17 May 2008 17:47:01 Jeremy Fitzhardinge wrote:
> >> But the host->guest protocol should include the number of bits estimated
> >> entropy along with the bits themselves.
> >
> > If we go down that path, we have to come up with a way of feeding that
> > information to guest userspace.  Patches welcome.  If we meanwhile assume
> > entropy == #bits, it fits the current /dev/hwrng model, and we can add an
> > entropy count later if we want to change that.
>
> Really?  Wouldn't guest userspace just use /dev/random as usual, which I
> think does have an ioctl to give that kind of information?  And the
> interfaces do allow things injecting entropy into the kernel pool to
> provide entropy estimates along with the actual bits themselves.

Unfortunately not.  Hardware randomness devices export /dev/hwrng, and it's up 
to userspace to feed that into /dev/random (or not).  That's usually done by 
rngd, which at least on my system, assumes 1 bit of entropy per bit of data 
from /dev/hwrng by default.

I was a little surprised that this decision was exported to userspace, but if 
you're not prepared to unconditionally trust hw rngs, it makes sense to palm 
it off.  We could write a boutique device for virtualization which *did* feed 
directly, but that would be a little gauche.

Cheers,
Rusty.
