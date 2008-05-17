From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] lguest: virtio-rng support
Date: Sat, 17 May 2008 08:57:07 -0700
Message-ID: <482F0053.2000509__27488.631840288$1211040389$gmane$org@zytor.com>
References: <482C8595.5030509@garzik.org>
	<200805171446.39814.rusty@rustcorp.com.au>
	<482E6417.8040602@zytor.com>
	<200805171628.03801.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805171628.03801.rusty@rustcorp.com.au>
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
>> Uhm, no.  It's not.  Unless the host provides actual entropy
>> information, you have a security hole.
> 
> Huh?  We just can't assume it adds entropy.  AFAICT rngd -H0 is what we want 
> here.

We can, if it comes from /dev/random.

>>> If we use /dev/random in the host, we risk a DoS.  But since /dev/random
>>> is 0666 on my system, perhaps noone actually cares?
>> There is no point in feeding the host /dev/urandom to the guest (except 
>> for seeding, which can be handled through other means); it will do its 
>> own mixing anyway.
> 
> Seeding is good, but unlikely to be done properly for first boot of some 
> standard virtualized container.  In practice, feeding /dev/urandom from the 
> host will make /dev/urandom harder to predict in the guest.

Only up to a point.

>> The reason to provide anything at all from the host 
>> is to give it "golden" entropy bits.
> 
> But you did not address the DoS question: can we ignore it?  Or are we trading 
> off a DoS in the host against a potential security weakness in the guest?
> 
> If so, how do we resolve it?

I don't think you have a DoS situation at all.  The worst thing is that 
you don't have any entropy available at all, at which point /dev/urandom 
is as insecure as it ever is.

	-hpa
