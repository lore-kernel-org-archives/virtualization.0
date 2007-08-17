From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Fri, 17 Aug 2007 01:26:42 -0400
Message-ID: <1187328402.4363.110.camel__21776.3288332664$1187328646$gmane$org@ghaskins-t60p.haskins.net>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187313953.6449.70.camel@localhost.localdomain>
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
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

 Comments inline...

On Fri, 2007-08-17 at 11:25 +1000, Rusty Russell wrote:
> 
> Transport has several parts.  What the hypervisor knows about (usually
> shared memory and some interrupt mechanism and possibly "DMA") and what
> is convention between users (eg. ringbuffer layouts).  Whether it's 1:1
> or n-way (if 1:1, is it symmetrical?).

TBH, I am not sure what you mean by 1:1 vs n-way ringbuffers (its
probably just lack of sleep and tomorrow I will smack myself for
asking ;)

But could you elaborate here?

>   Whether it has to be host <->
> guest, or can be inter-guest.  Whether it requires trust between the
> sides.
> 
> My personal thoughts are that we should be aiming for 1:1 untrusting.

Untrusting I understand, and I agree with you there.  Obviously the host
is implicitly trusted (you have no choice, really) but I think the
guests should be validated just as you would for a standard
userspace/kernel interaction (e.g. validate pointer arguments and their
range, etc).

> And not having inter-guest is just
> poor form (and putting it in later is impossible, as we'll see).

I agree that having an ability to do inter-guest is a good idea.
However, I don't know if I am convinced if it has to be done in a
direct, zero-copy way. Mediating through the host certainly can work and
is probably acceptable for most things.  In this way the host is
essentially acting as a DMA agent to copy from one guests memory to the
other.  It solves the "trust" issue and simplifies the need to have a
"grant table" like mechanism which can get pretty hairy, IMHO.

I *could* be convinced otherwise, but that is my current thought.  This
would essentially look very similar to how my patch #4 (loopback) works.
It takes a pointer from an tx-queue and copies the data to a pointer
from an empty descriptor in the other side's rx-queue.  If you move that
concept down into the host this is how I was envisioning it working.

> 
> It seems that a shared-memory "ring-buffer of descriptors" is the
> simplest implementation.  But there are two problems with a simple
> descriptor ring:
> 
>         1) A ring buffer doesn't work well for things which process
>         out-of-order, such as a block device.
>         2) We either need huge descriptors or some chaining mechanism to
>         handle scatter-gather.
> 

I definitely agree that a simple descriptor-ring in of itself doesn't
solve all possible patterns directly.  I don't know if you had a chance
to look too deeply into the IOQ code yet, but it essentially is a very
simple descriptor-ring as you mention.

However, I don't view that as a limitation because I envision this type
of thing to be just one "tool" or layer in a larger puzzle.  One that
can be applied many different ways to solve more complex problems.

(The following is a long and boring story about my train of thought and
how I got to where I am today with this code)

<boring-story>What I was seeing as a general problem is efficient basic
event movement.  <obvious-statement>Each guest->host or host->guest
transition is expensive so we want to minimize the number of these
occurring </obvious-statement> (ideally down to 1 (or less!) per
operation).

Now moving events out of a guest in one (or fewer) IO operations is
fairly straight forward (hypercall namespace is typically pretty large
and they can have accompanying parameters (including pointers)
associated with them).  However, moving events *into* the guest in one
(or fewer) shots is difficult because by default you really only have a
single parameter (interrupt vector) to convey any meaning.  To make
matters worse, the namespace for vectors can be rather small (e.g. 256
on x86).

Now traditionally we would of course solve the latter problem by
turning around and doing some kind of additional IO operation to get
more details about the event.  Any why not?  Its dirt cheap on
bare-metal.  Of course, in a VM this is particularly expensive and we
want to avoid it.

Enter the shared memory concept:  E.g. put details about the event
somewhere in memory that can be read in the guest without a VMEXIT.  Now
your interrupt vector is simply ringing the doorbell on your
shared-memory.  The question becomes: how to you synchronize access to
the memory without necessitating as much overhead as you had to begin
with? E.g. how does one side know when the other side is done and wants
more data, etc.  What if you want to parallelize things, etc.

Enter the shared-memory queue: Now you have a way to organize your
memory such that both sides can use it effectively and simultaneously.

So there you have it:  We can use a simple shared-memory-queue to
efficiently move event data into a guest.  And we can use hypercalls to
efficiently move it out.  As it turns out, there are also cases where
using a queue for the output side makes sense too, but the basic case is
for input.  But long story short, that is the basic fundamental purpose
of this subsystem.

Now enter the more complex usage patterns:  

For instance, a block device driver could do two hypercalls ("write
sglist-A[] as transaction X to position P", and "write sglist-B[] as
transaction Y to position Q"), and the host process them out of order
and write "completed transaction Y", and "completed transaction X" into
the driver's event queue.  (The block driver might also use a tx-queue
instead of hypercalls if it wanted, but this may or may not make sense).

Or a network driver might push a sglist of a packet to write into a
txqueue entry, and the host might copy a received packet into the
drivers rx-queue. (This is essentally what IOQNET is).  The guest would
see interrupts for its tx-queue to say "i finished the send, reclaim
your skbs", and it would see interrupts on the rx-queue to say "here's
data to receive".

Etc. etc.  In the first case, the events were "please write this" and
"write completed".  In the second they were "please write this", "im
done writing" and "please read this".  Sure there is data associated
with these events and they are utilized in drastically different
patterns.  But either way they were just events and the event stream can
be looked at as a simple ordered sequence....even if their underlying
constructs are not per se.  Does this make any sense?

</boring story> 

> So we end up with an array of descriptors with next pointers, and two
> ring buffers which refer to those descriptors: one for what descriptors
> are pending, and one for what descriptors have been used (by the other
> end).

That's certainly one way to do it. IOQ (coming from the "simple ordered
event sequence" mindset) has one logically linear ring.  It uses a set
of two "head/tail" indices ("valid" and "inuse") and an ownership flag
(per descriptor) to essentially offer similar services as you mention.
Producers "push" items at the index head, and consumers "pop" items from
the index tail.  Only the guest side can manipulate the valid index.
Only the producer can manipulate the inuse-head.  And only the consumer
can manipulate the inuse-tail.  Either side can manipulate the ownership
bit, but only in strict accordance with the production or consumption of
data.

Generally speaking, a driver (guest or host side) is seeking to either
the head or tail (depending on if its a producer or consumer) and then
waiting for the ownership bit to change in its favor.  Once its changed,
the data is produced or consumed, the bit is flipped back to the other
side, and the index is advanced.  That, in a nutshell, is how the whole
deal works.... coupled with the fact that a basic "ioq_signal" operation
will kick the other side (which would typically be either a hypercall or
an interrupt depending on which side of the link you were on).

One thing that is particularly cool about the IOQ design is that its
possible to get to 0 IO events for certain circumstances.  For instance,
if you look at the IOQNET driver, it has what I would call
"bidirectional NAPI".  I think everyone here probably understands how
standard NAPI disables RX interrupts after the first packet is received
Well, IOQNET can also disable TX hypercalls after the first one goes
down to the host.  Any subsequent writes will simply post to the queue
until the host catches up and re-enables "interrupts".  Maybe all of
these queue schemes typically do that...im not sure...but I thought it
was pretty cool.

> 
> This is sufficient for guest<->host, but care must be taken for guest
> <-> guest.  Let's dig down:
> 
> Consider a transport from A -> B.  A populates the descriptor entries
> corresponding to its sg, then puts the head descriptor entry in the
> "pending" ring buffer and sends B an interrupt.  B sees the new pending
> entry, reads the descriptors, does the operation and reads or writes
> into the memory pointed to by the descriptors.  It then updates the
> "used" ring buffer and sends A an interrupt.
> 
> Now, if B is untrusted, this is more difficult.  It needs to read the
> descriptor entries and the "pending" ring buffer, and write to the
> "used" ring buffer.  We can use page protection to share these if we
> arrange things carefully, like so:
> 
>         struct desc_pages
>         {
>         	/* Page of descriptors. */
>         	struct lguest_desc desc[NUM_DESCS];
>         
>         	/* Next page: how we tell other side what buffers are available. */
>         	unsigned int avail_idx;
>         	unsigned int available[NUM_DESCS];
>         	char pad[PAGE_SIZE - (NUM_DESCS+1) * sizeof(unsigned int)];
>         
>         	/* Third page: how other side tells us what's used. */
>         	unsigned int used_idx;
>         	struct lguest_used used[NUM_DESCS];
>         };
> 
> But we still have the problem of an untrusted B having to read/write A's
> memory pointed to A's descriptors.  At this point, my preferred solution
> so far is as follows (note: have not implemented this!):
> 
> (1) have the hypervisor be aware of the descriptor page format, location
> and which guest can access it.
> (2) have the descriptors themselves contains a type (read/write) and a
> valid bit.
> (3) have a "DMA" hypercall to copy to/from someone else's descriptors.
> 
> Note that this means we do a copy for the untrusted case which doesn't
> exist for the trusted case.  In theory the hypervisor could do some
> tricky copy-on-write page-sharing for very large well-aligned buffers,
> but it remains to be seen if that is actually useful.

That sounds *somewhat* similar to what I was getting at above with the
dma/loopback thingy.  Though you are talking about that "grant table"
stuff and are scaring me ;)  But in all seriousness, it would be pretty
darn cool to get that to work.  I am still trying to wrap my head around
all of this....

> 
> Sorry for the long mail, but I really want to get the mechanism correct.

I see your long mail, and I raise you 10x ;)

Regards,
-Greg
