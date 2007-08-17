From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Fri, 17 Aug 2007 11:25:53 +1000
Message-ID: <1187313953.6449.70.camel__27854.6360125349$1187314116$gmane$org@localhost.localdomain>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
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

On Thu, 2007-08-16 at 19:13 -0400, Gregory Haskins wrote:
> Here is the v3 release of the patch series for a generalized PV-IO
> infrastructure.  It has v2 plus the following changes:

Hi Gregory,

	This is a lot of code.  I'm having trouble taking it all in, TBH.  It
might help me if we could to go back to the basic transport
implementation questions.

Transport has several parts.  What the hypervisor knows about (usually
shared memory and some interrupt mechanism and possibly "DMA") and what
is convention between users (eg. ringbuffer layouts).  Whether it's 1:1
or n-way (if 1:1, is it symmetrical?).  Whether it has to be host <->
guest, or can be inter-guest.  Whether it requires trust between the
sides.

My personal thoughts are that we should be aiming for 1:1 untrusting.  I
like N-way, but it adds complexity.  And not having inter-guest is just
poor form (and putting it in later is impossible, as we'll see).

It seems that a shared-memory "ring-buffer of descriptors" is the
simplest implementation.  But there are two problems with a simple
descriptor ring:

        1) A ring buffer doesn't work well for things which process
        out-of-order, such as a block device.
        2) We either need huge descriptors or some chaining mechanism to
        handle scatter-gather.

So we end up with an array of descriptors with next pointers, and two
ring buffers which refer to those descriptors: one for what descriptors
are pending, and one for what descriptors have been used (by the other
end).

This is sufficient for guest<->host, but care must be taken for guest
<-> guest.  Let's dig down:

Consider a transport from A -> B.  A populates the descriptor entries
corresponding to its sg, then puts the head descriptor entry in the
"pending" ring buffer and sends B an interrupt.  B sees the new pending
entry, reads the descriptors, does the operation and reads or writes
into the memory pointed to by the descriptors.  It then updates the
"used" ring buffer and sends A an interrupt.

Now, if B is untrusted, this is more difficult.  It needs to read the
descriptor entries and the "pending" ring buffer, and write to the
"used" ring buffer.  We can use page protection to share these if we
arrange things carefully, like so:

        struct desc_pages
        {
        	/* Page of descriptors. */
        	struct lguest_desc desc[NUM_DESCS];
        
        	/* Next page: how we tell other side what buffers are available. */
        	unsigned int avail_idx;
        	unsigned int available[NUM_DESCS];
        	char pad[PAGE_SIZE - (NUM_DESCS+1) * sizeof(unsigned int)];
        
        	/* Third page: how other side tells us what's used. */
        	unsigned int used_idx;
        	struct lguest_used used[NUM_DESCS];
        };

But we still have the problem of an untrusted B having to read/write A's
memory pointed to A's descriptors.  At this point, my preferred solution
so far is as follows (note: have not implemented this!):

(1) have the hypervisor be aware of the descriptor page format, location
and which guest can access it.
(2) have the descriptors themselves contains a type (read/write) and a
valid bit.
(3) have a "DMA" hypercall to copy to/from someone else's descriptors.

Note that this means we do a copy for the untrusted case which doesn't
exist for the trusted case.  In theory the hypervisor could do some
tricky copy-on-write page-sharing for very large well-aligned buffers,
but it remains to be seen if that is actually useful.

Sorry for the long mail, but I really want to get the mechanism correct.

Cheers,
Rusty.
