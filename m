From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Fri, 17 Aug 2007 09:50:14 -0400
Message-ID: <1187358614.4363.135.camel__17482.9313219108$1187358950$gmane$org@ghaskins-t60p.haskins.net>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
	<1187328402.4363.110.camel@ghaskins-t60p.haskins.net>
	<1187336618.6449.106.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187336618.6449.106.camel@localhost.localdomain>
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

On Fri, 2007-08-17 at 17:43 +1000, Rusty Russell wrote:

> 	Sure, these discussions can get pretty esoteric.  The question is
> whether you want a point-to-point transport (as we discuss here), or an
> N-way.  Lguest has N-way, but I'm not convinced it's worthwhile, as
> there's some overhead involved in looking up recipients (basically futex
> code).

Ah, ok I get it.  In that case: yeah, I agree 1:1 is probably the way to
go.  We can always build some kind of N-way transport in terms of 1:1
primitives if its desirable (though its probably better in most cases to
just reuse something like an ethernet transport/bridge than invent
something new). 


> 
> I agree that page sharing is silly.  But we can design a mechanism where
> it such a "DMA agent" need only enforce a few very simple rules not the
> whole protocol, and yet the guest doesn't know whether it's talking to
> an agent or the host.

Interesting....I would love to hear more of your ideas surrounding this.


> Well, for cache reasons you should really try to avoid having both sides
> write to the same data.  Hence two separate cache-aligned regions is
> better than one region and a flip bit.

While I certainly can see what you mean about the cache implications for
a bit-flip design, I don't see how you can get away with not having both
sides write to the same memory in other designs either.  Wouldn't you
still have to adjust descriptors from one ring to the other?  E.g.
wouldn't both sides be writing descriptor pointer data in this case, or
am I missing something?

> And if you make them separate pages, then this can also be inter-guest
> safe 8)

Ok, now you are making my head hurt 8)

> 
> Yeah, I agree.  I'm not sure how important it is IRL, but it *feels*
> clever 8)

Heh, yeah, I agree I don't know how much it saves.  I kind of got it for
free based on the general design of the queue, so I thought "hey that's
pretty cool".  It shouldn't *hurt*, anyway ;)


> 
> Yeah, I fear grant tables too.  But in any scheme, the descriptors imply
> permission, so with a little careful design and implementation it should
> "just work"...
> 

I am certainly looking forward to hearing more of your ideas in this
area.  Very interesting, indeed....

Regards,
-Greg
