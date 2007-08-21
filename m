From: Gregory Haskins <ghaskins@novell.com>
Subject: RE: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Tue, 21 Aug 2007 10:06:02 -0400
Message-ID: <1187705162.4363.323.camel__48756.7329350442$1187705414$gmane$org@ghaskins-t60p.haskins.net>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
	<1187328402.4363.110.camel@ghaskins-t60p.haskins.net>
	<1187336618.6449.106.camel@localhost.localdomain>
	<1187358614.4363.135.camel@ghaskins-t60p.haskins.net>
	<1187652496.19435.141.camel@localhost.localdomain>
	<64F9B87B6B770947A9F8391472E032160D464FEB@ehost011-8.exch011.intermedia.net>
	<1187683122.19435.171.camel@localhost.localdomain>
	<1187697638.4363.277.camel@ghaskins-t60p.haskins.net>
	<1187704038.19435.194.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187704038.19435.194.camel@localhost.localdomain>
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
Cc: kvm-devel@lists.sourceforge.net, Dor Laor <dor.laor@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-08-21 at 23:47 +1000, Rusty Russell wrote:

> Hi Gregory,
> 
> 	The main current use is disk drivers: they process out-of-order.

Maybe for you ;)  I am working on the networking/IVMC side.

> 
> >   I think the use of rings for the tx-path in of
> > itself is questionable unless you can implement something like the bidir
> > NAPI that I demonstrated in ioqnet.  Otherwise, you end up having to
> > hypercall on each update to the ring anyway and you might as well
> > hypercall directly w/o using a ring.
> 
> 	In the guest -> host direction, an interface like virtio is designed
> for batching, with the explicit distinction between add_buf & sync.

Right.  IOQ has "iter_push()" and "signal()" as synonymous operations.
But note that batching via deferred synchronization does not implicitly
require a shared queue. E.g. you could batch internally and then
hypercall at the "sync" point.  However, batching via a queue is still
nice because at least you give the host side a chance to independently
"notice" the changes concurrently before the sync.  But I digress...

>   On
> the receive side, you can have explicit interrupt suppression on
> implicit mitigation caused by scheduling effects.

Agreed.  This is precisely what the bidir NAPI stuff is doing and I
didn't mean to imply that virtio wasn't capable of it too.  All I meant
is that if you *don't* take advantage of it, the guest->host path via a
queue is likely overkill.  E.g. you might as well hypercall instead.


> 	But in fact as we can see, two rings need less from each ring than one
> ring.  One ring must have producer and consumer indices, so the producer
> doesn't overrun the consumer.  But if the second ring is used to feed
> consumption, the consumer index isn't required any more: in fact, it's
> just confusing to have.

Don't get me wrong.  I am totally in favor of the two ring approach.
You have enlightened me on that front. :)  I was under the impression
that then making the two-ringed approach support out-of-order added
significantly more complexity.  Did I understand that wrong?

> 
> 	I really think that a table of descriptors, a ring for produced
> descriptors and a ring for used descriptors is the most cache-friendly,
> bidir-non-trusting simple implementation possible.  Of course, the
> produced and used rings might be the same format, which allows code
> sharing and if you squint a little, that's your "lowest level" simple
> ringbuffer.

Sounds reasonable to me.

> 
> Thanks for the discussion,

Ditto!
-Greg
