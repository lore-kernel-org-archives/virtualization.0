From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2/2] lguest: virtio-rng support
Date: Mon, 19 May 2008 10:45:23 +0100
Message-ID: <48314C33.7010604__23354.9742064953$1211190473$gmane$org@goop.org>
References: <482C8595.5030509@garzik.org>
	<200805191905.11452.rusty@rustcorp.com.au>
	<48314419.4080606@goop.org>
	<200805191928.13043.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805191928.13043.rusty@rustcorp.com.au>
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
Cc: Theodore Tso <tytso@mit.edu>, Herbert Xu <herbert@gondor.apana.org.au>, Jeff Garzik <jeff@garzik.org>, Matt Mackall <mpm@selenic.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Johannes Berg <johannes@sipsolutions.net>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Unfortunately not.  Hardware randomness devices export /dev/hwrng, and it's up 
> to userspace to feed that into /dev/random (or not).  That's usually done by 
> rngd, which at least on my system, assumes 1 bit of entropy per bit of data 
> from /dev/hwrng by default.
>
> I was a little surprised that this decision was exported to userspace, but if 
> you're not prepared to unconditionally trust hw rngs, it makes sense to palm 
> it off.

Yeah, that's a bit of a pity.  Hardware rngs can often generate really 
crappy randomness, which needs tons of processing to remove noise like 
50/60hz hum, etc.

>   We could write a boutique device for virtualization which *did* feed 
> directly, but that would be a little gauche.
>   

Well, yes, we can certainly do any amount of processing we like to the 
stuff provided to guests, so that the 1:1 bits/entropy ratio is as true 
as we can make it.

    J
