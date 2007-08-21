From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Tue, 21 Aug 2007 09:11:05 -0400
Message-ID: <1187701865.4363.308.camel__38647.917044773$1187702212$gmane$org@ghaskins-t60p.haskins.net>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
	<1187328402.4363.110.camel@ghaskins-t60p.haskins.net>
	<1187336618.6449.106.camel@localhost.localdomain>
	<1187358614.4363.135.camel@ghaskins-t60p.haskins.net>
	<1187652496.19435.141.camel@localhost.localdomain>
	<64F9B87B6B770947A9F8391472E032160D464FEB@ehost011-8.exch011.intermedia.net>
	<1187683122.19435.171.camel@localhost.localdomain>
	<1187697638.4363.277.camel@ghaskins-t60p.haskins.net>
	<46CAD9CC.6050209@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46CAD9CC.6050209@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-08-21 at 15:25 +0300, Avi Kivity wrote:
> Gregory Haskins wrote:
> > On Tue, 2007-08-21 at 17:58 +1000, Rusty Russell wrote:
> >
> >   
> >> Partly the horror of the code, but mainly because it is an in-order
> >> ring.  You'll note that we use a reply ring, so we don't need to know
> >> how much the other side has consumed (and it needn't do so in order).
> >>
> >>     
> >
> > I have certainly been known to take a similar stance when looking at Xen
> > code ;) (recall the lapic work I did).  However, that said I am not yet
> > convinced that an out-of-order ring (at least as a fundamental
> > primitive) buys us much.  
> 
> It's pretty much required for block I/O into disk arrays.

You are misunderstanding me.  I totally agree that block io is
inherently out-of-order.  What I am trying to convey is that at a
fundamental level *everything* (including block-io) can be viewed as an
ordered sequence of events.

For instance, consider that a block-io driver is making requests like
"perform read transaction X", and "perform write transaction Y".
Likewise, the host side can pass events like "completed transaction Y"
and "completed transaction X".  At this level, everything is *always*
ordered, regardless of the fact that X and Y were temporally rearranged
by the host.

This is what the ioq/pvbus series is trying to address:  These low-level
primitives for moving events in and out of the guest in a VMM agnostic
way.  From there, you could apply higher level constructs such as an
out-of-order sg descriptor ring to represent your block-io data.  The
low-level primitives simply become a way to convey changes to that
construct.

In a nutshell, IOQ provides a simple bi-directional ordered event
channel and a context associated hypercall mechanism (see
pvbus_device->call()) to accomplish these low-level chores.

I am also advocating caution on the tx path, as I think indirection
(e.g. queuing) as opposed to direct access (e.g. contextual hypercall)
has limited applicability.  Trying to come up with a complex
"one-size-fits-all" queue for the tx path may be not worthwhile since in
the end there is still a 1:1 with queue-insert:hypercall.  You might as
well just pass the descriptor directly via the contextual hypercall.
Where this ends up being a win is where you can do the bi-dir NAPI-like
tricks like IOQNET and have the queue-insert to hypercall ratio become >
1.  

> 
> Xen does out-of-order, btw, on its single ring, but at the cost of some 
> complexity.  I don't believe it is worthwhile and prefer split 
> request/reply rings.

I am not against the split rings either.  The article that Rusty
forwarded was very interesting indeed.  But if I understood the article
and Rusty, there are kind of two aspects to it.  A) Using two rings to
make an cache-thrash friendly ordered ring, or B) adding out-of-order
capability to these two rings.  I am certainly in favor of (A) for use
as the low-level event transport.  I just question whether the
complexity of (B) is justified as the one and only queuing mechanism
when there are plenty of patterns that simply cannot take advantage of
it.

What I am wondering is if we should have a set of low-level primitives
that deal primarily with ordered event sequencing and VMM abstraction,
and a higher set of code expressed in terms of these primitives for
implementing the constructs such as (B) for block-io.

> 
> With my VJ T-shirt on, I can even say it's more efficient, as each side 
> of the ring will have a single writer and a single reader, reducing 
> ping-pong effects if the interrupt completions happens to land on the 
> wrong cpu.

Agreed.


> 
> Network tx can be out of order too (with some traffic destined to other 
> guests, some to the host, and some to external interfaces, completions 
> will be out of order).

Well, not with respect to the 1:1 event delivery channel as I envision
it (unless I am misunderstanding you?)

Regards,
-Greg
