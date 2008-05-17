From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] lguest: virtio-rng support
Date: Sat, 17 May 2008 16:28:03 +1000
Message-ID: <200805171628.03801.rusty__34539.1181683683$1211005829$gmane$org@rustcorp.com.au>
References: <482C8595.5030509@garzik.org>
	<200805171446.39814.rusty@rustcorp.com.au>
	<482E6417.8040602@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <482E6417.8040602@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Theodore Tso <tytso@mit.edu>, Herbert Xu <herbert@gondor.apana.org.au>, Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Matt Mackall <mpm@selenic.com>, Johannes Berg <johannes@sipsolutions.net>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 17 May 2008 14:50:31 H. Peter Anvin wrote:
> Rusty Russell wrote:
> > On Friday 16 May 2008 20:49:41 Johannes Berg wrote:
> >>> +
> >>> +/* Our random number generator device reads from /dev/urandom into the
> >>> Guest's + * input buffers.  The usual case is that the Guest doesn't
> >>> want random numbers + * and so has no buffers although /dev/urandom is
> >>> still readable, whereas + * console is the reverse.
> >>
> >> Is it really a good idea to use the hosts /dev/urandom to fill the
> >> guests /dev/random?
> >
> > Technically it's up to rngd in the guest to decide whether to feed
> > entropy or not (ie. /dev/urandom or /dev/random).
>
> Uhm, no.  It's not.  Unless the host provides actual entropy
> information, you have a security hole.

Huh?  We just can't assume it adds entropy.  AFAICT rngd -H0 is what we want 
here.

> > If we use /dev/random in the host, we risk a DoS.  But since /dev/random
> > is 0666 on my system, perhaps noone actually cares?
>
> There is no point in feeding the host /dev/urandom to the guest (except 
> for seeding, which can be handled through other means); it will do its 
> own mixing anyway.

Seeding is good, but unlikely to be done properly for first boot of some 
standard virtualized container.  In practice, feeding /dev/urandom from the 
host will make /dev/urandom harder to predict in the guest.

> The reason to provide anything at all from the host 
> is to give it "golden" entropy bits.

But you did not address the DoS question: can we ignore it?  Or are we trading 
off a DoS in the host against a potential security weakness in the guest?

If so, how do we resolve it?

Thanks,
Rusty.
