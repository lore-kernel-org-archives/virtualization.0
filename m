From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] lguest: virtio-rng support
Date: Sat, 17 May 2008 14:46:39 +1000
Message-ID: <200805171446.39814.rusty__22501.4741452926$1210999744$gmane$org@rustcorp.com.au>
References: <482C8595.5030509@garzik.org>
	<200805161539.59739.rusty@rustcorp.com.au>
	<1210934981.6381.1.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1210934981.6381.1.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Theodore Tso <tytso@mit.edu>, Herbert Xu <herbert@gondor.apana.org.au>, Jeff Garzik <jeff@garzik.org>, Matt Mackall <mpm@selenic.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, "H. Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 16 May 2008 20:49:41 Johannes Berg wrote:
> > +
> > +/* Our random number generator device reads from /dev/urandom into the Guest's
> > + * input buffers.  The usual case is that the Guest doesn't want random numbers
> > + * and so has no buffers although /dev/urandom is still readable, whereas
> > + * console is the reverse. 
>
> Is it really a good idea to use the hosts /dev/urandom to fill the
> guests /dev/random?

Technically it's up to rngd in the guest to decide whether to feed entropy
or not (ie. /dev/urandom or /dev/random).

If we use /dev/random in the host, we risk a DoS.  But since /dev/random
is 0666 on my system, perhaps noone actually cares?

Cheers,
Rusty.
