From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2/2] lguest: virtio-rng support
Date: Mon, 19 May 2008 10:10:49 +0100
Message-ID: <48314419.4080606__30373.5172180042$1211188409$gmane$org@goop.org>
References: <482C8595.5030509@garzik.org>
	<200805171628.03801.rusty@rustcorp.com.au>
	<482E8D75.10606@goop.org>
	<200805191905.11452.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805191905.11452.rusty@rustcorp.com.au>
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
> On Saturday 17 May 2008 17:47:01 Jeremy Fitzhardinge wrote:
>   
>> But the host->guest protocol should include the number of bits estimated
>> entropy along with the bits themselves.
>>     
>
> If we go down that path, we have to come up with a way of feeding that 
> information to guest userspace.  Patches welcome.  If we meanwhile assume 
> entropy == #bits, it fits the current /dev/hwrng model, and we can add an 
> entropy count later if we want to change that.
>   

Really?  Wouldn't guest userspace just use /dev/random as usual, which I 
think does have an ioctl to give that kind of information?  And the 
interfaces do allow things injecting entropy into the kernel pool to 
provide entropy estimates along with the actual bits themselves.

> I'll change my lguest implementation to suck from /dev/random, since noone 
> else seems to consider its depletion to be a real issue.  It's no worse than 
> what any other process can do.
>   

Well, I think having some rate-limiting controls would be nice to have, 
but certainly not a show-stopper for a first implementation.

    J
