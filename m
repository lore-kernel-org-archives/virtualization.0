From: Rusty Russell <rusty@rustcorp.com.au>
Subject: RE: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Tue, 21 Aug 2007 17:58:42 +1000
Message-ID: <1187683122.19435.171.camel__11342.3249139034$1187683262$gmane$org@localhost.localdomain>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
	<1187328402.4363.110.camel@ghaskins-t60p.haskins.net>
	<1187336618.6449.106.camel@localhost.localdomain>
	<1187358614.4363.135.camel@ghaskins-t60p.haskins.net>
	<1187652496.19435.141.camel@localhost.localdomain>
	<64F9B87B6B770947A9F8391472E032160D464FEB@ehost011-8.exch011.intermedia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <64F9B87B6B770947A9F8391472E032160D464FEB@ehost011-8.exch011.intermedia.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dor Laor <dor.laor@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, Gregory Haskins <ghaskins@novell.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-08-21 at 00:33 -0700, Dor Laor wrote:
> >> > Well, for cache reasons you should really try to avoid having both
> >sides
> >> > write to the same data.  Hence two separate cache-aligned regions
> is
> >> > better than one region and a flip bit.
> >>
> >> While I certainly can see what you mean about the cache implications
> >for
> >> a bit-flip design, I don't see how you can get away with not having
> >both
> >> sides write to the same memory in other designs either.  Wouldn't you
> >> still have to adjust descriptors from one ring to the other?  E.g.
> >> wouldn't both sides be writing descriptor pointer data in this case,
> >or
> >> am I missing something?
> >
> >Hi Gregory,
> >
> >	You can have separate produced and consumed counters: see for
> >example
> >Van Jacobson's Netchannels presentation
> >http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf page 23.
> >
> >	This single consumed count isn't sufficient if you can consume
> >out-of-order: for that you really want a second "reply" ringbuffer
> >indicating what buffers are consumed.
> >
> 
> Rusty, although your code works pretty nice, (I'll send some raw patches
> later on today with 
> kvm support for virtio). I was wandering why didn't you use Xen's ring
> implementation?
> They have separate counters and also union for the request/response
> structure in the same
> descriptor.

Partly the horror of the code, but mainly because it is an in-order
ring.  You'll note that we use a reply ring, so we don't need to know
how much the other side has consumed (and it needn't do so in order).

Cheers,
Rusty.
