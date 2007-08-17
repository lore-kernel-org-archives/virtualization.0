From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Fri, 17 Aug 2007 17:43:38 +1000
Message-ID: <1187336618.6449.106.camel__11006.7385867753$1187336815$gmane$org@localhost.localdomain>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
	<1187328402.4363.110.camel@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187328402.4363.110.camel@ghaskins-t60p.haskins.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <ghaskins@novell.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-08-17 at 01:26 -0400, Gregory Haskins wrote:
> Hi Rusty,
> 
>  Comments inline...
> 
> On Fri, 2007-08-17 at 11:25 +1000, Rusty Russell wrote:
> > 
> > Transport has several parts.  What the hypervisor knows about (usually
> > shared memory and some interrupt mechanism and possibly "DMA") and what
> > is convention between users (eg. ringbuffer layouts).  Whether it's 1:1
> > or n-way (if 1:1, is it symmetrical?).
> 
> TBH, I am not sure what you mean by 1:1 vs n-way ringbuffers (its
> probably just lack of sleep and tomorrow I will smack myself for
> asking ;)
> 
> But could you elaborate here?

Hi Gregory,

	Sure, these discussions can get pretty esoteric.  The question is
whether you want a point-to-point transport (as we discuss here), or an
N-way.  Lguest has N-way, but I'm not convinced it's worthwhile, as
there's some overhead involved in looking up recipients (basically futex
code).

> > And not having inter-guest is just
> > poor form (and putting it in later is impossible, as we'll see).
> 
> I agree that having an ability to do inter-guest is a good idea.
> However, I don't know if I am convinced if it has to be done in a
> direct, zero-copy way. Mediating through the host certainly can work and
> is probably acceptable for most things.  In this way the host is
> essentially acting as a DMA agent to copy from one guests memory to the
> other.  It solves the "trust" issue and simplifies the need to have a
> "grant table" like mechanism which can get pretty hairy, IMHO.

I agree that page sharing is silly.  But we can design a mechanism where
it such a "DMA agent" need only enforce a few very simple rules not the
whole protocol, and yet the guest doesn't know whether it's talking to
an agent or the host.

> > So we end up with an array of descriptors with next pointers, and two
> > ring buffers which refer to those descriptors: one for what descriptors
> > are pending, and one for what descriptors have been used (by the other
> > end).
> 
> That's certainly one way to do it. IOQ (coming from the "simple ordered
> event sequence" mindset) has one logically linear ring.  It uses a set
> of two "head/tail" indices ("valid" and "inuse") and an ownership flag
> (per descriptor) to essentially offer similar services as you mention.
> Producers "push" items at the index head, and consumers "pop" items from
> the index tail.  Only the guest side can manipulate the valid index.
> Only the producer can manipulate the inuse-head.  And only the consumer
> can manipulate the inuse-tail.  Either side can manipulate the ownership
> bit, but only in strict accordance with the production or consumption of
> data.

Well, for cache reasons you should really try to avoid having both sides
write to the same data.  Hence two separate cache-aligned regions is
better than one region and a flip bit.  And if you make them separate
pages, then this can also be inter-guest safe 8)

> One thing that is particularly cool about the IOQ design is that its
> possible to get to 0 IO events for certain circumstances.  For instance,
> if you look at the IOQNET driver, it has what I would call
> "bidirectional NAPI".  I think everyone here probably understands how
> standard NAPI disables RX interrupts after the first packet is received
> Well, IOQNET can also disable TX hypercalls after the first one goes
> down to the host.  Any subsequent writes will simply post to the queue
> until the host catches up and re-enables "interrupts".  Maybe all of
> these queue schemes typically do that...im not sure...but I thought it
> was pretty cool.

Yeah, I agree.  I'm not sure how important it is IRL, but it *feels*
clever 8)

> > (1) have the hypervisor be aware of the descriptor page format, location
> > and which guest can access it.
> > (2) have the descriptors themselves contains a type (read/write) and a
> > valid bit.
> > (3) have a "DMA" hypercall to copy to/from someone else's descriptors.
> > 
> > Note that this means we do a copy for the untrusted case which doesn't
> > exist for the trusted case.  In theory the hypervisor could do some
> > tricky copy-on-write page-sharing for very large well-aligned buffers,
> > but it remains to be seen if that is actually useful.
> 
> That sounds *somewhat* similar to what I was getting at above with the
> dma/loopback thingy.  Though you are talking about that "grant table"
> stuff and are scaring me ;)

Yeah, I fear grant tables too.  But in any scheme, the descriptors imply
permission, so with a little careful design and implementation it should
"just work"...

Cheers,
Rusty.
