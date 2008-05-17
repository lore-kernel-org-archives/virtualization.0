From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] lguest: virtio-rng support
Date: Fri, 16 May 2008 21:50:31 -0700
Message-ID: <482E6417.8040602@zytor.com>
References: <482C8595.5030509@garzik.org>
	<200805161539.59739.rusty@rustcorp.com.au>
	<1210934981.6381.1.camel@johannes.berg>
	<200805171446.39814.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805171446.39814.rusty@rustcorp.com.au>
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
Cc: Theodore Tso <tytso@mit.edu>, Herbert Xu <herbert@gondor.apana.org.au>, Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Matt Mackall <mpm@selenic.com>, Johannes Berg <johannes@sipsolutions.net>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Friday 16 May 2008 20:49:41 Johannes Berg wrote:
>>> +
>>> +/* Our random number generator device reads from /dev/urandom into the Guest's
>>> + * input buffers.  The usual case is that the Guest doesn't want random numbers
>>> + * and so has no buffers although /dev/urandom is still readable, whereas
>>> + * console is the reverse. 
>> Is it really a good idea to use the hosts /dev/urandom to fill the
>> guests /dev/random?
> 
> Technically it's up to rngd in the guest to decide whether to feed entropy
> or not (ie. /dev/urandom or /dev/random).

Uhm, no.  It's not.  Unless the host provides actual entropy 
information, you have a security hole.

> If we use /dev/random in the host, we risk a DoS.  But since /dev/random
> is 0666 on my system, perhaps noone actually cares?

/dev/random	= give me actual entropy, if you have some.
/dev/urandom	= give me what you have, regardless of quality.

There is no point in feeding the host /dev/urandom to the guest (except 
for seeding, which can be handled through other means); it will do its 
own mixing anyway.  The reason to provide anything at all from the host 
is to give it "golden" entropy bits.

	-hpa
