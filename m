From: Rusty Russell <rusty@rustcorp.com.au>
Subject: RE: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Tue, 21 Aug 2007 23:47:18 +1000
Message-ID: <1187704038.19435.194.camel__41211.9038789116$1187704309$gmane$org@localhost.localdomain>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
	<1187328402.4363.110.camel@ghaskins-t60p.haskins.net>
	<1187336618.6449.106.camel@localhost.localdomain>
	<1187358614.4363.135.camel@ghaskins-t60p.haskins.net>
	<1187652496.19435.141.camel@localhost.localdomain>
	<64F9B87B6B770947A9F8391472E032160D464FEB@ehost011-8.exch011.intermedia.net>
	<1187683122.19435.171.camel@localhost.localdomain>
	<1187697638.4363.277.camel@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187697638.4363.277.camel@ghaskins-t60p.haskins.net>
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
Cc: kvm-devel@lists.sourceforge.net, Dor Laor <dor.laor@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-08-21 at 08:00 -0400, Gregory Haskins wrote:
> On Tue, 2007-08-21 at 17:58 +1000, Rusty Russell wrote:
> 
> > Partly the horror of the code, but mainly because it is an in-order
> > ring.  You'll note that we use a reply ring, so we don't need to know
> > how much the other side has consumed (and it needn't do so in order).
> > 
> 
> I have certainly been known to take a similar stance when looking at Xen
> code ;) (recall the lapic work I did).  However, that said I am not yet
> convinced that an out-of-order ring (at least as a fundamental
> primitive) buys us much.

Hi Gregory,

	The main current use is disk drivers: they process out-of-order.

>   I think the use of rings for the tx-path in of
> itself is questionable unless you can implement something like the bidir
> NAPI that I demonstrated in ioqnet.  Otherwise, you end up having to
> hypercall on each update to the ring anyway and you might as well
> hypercall directly w/o using a ring.

	In the guest -> host direction, an interface like virtio is designed
for batching, with the explicit distinction between add_buf & sync.  On
the receive side, you can have explicit interrupt suppression on
implicit mitigation caused by scheduling effects.

> OTOH, its possible that its redundant to have a simple low-level
> infrastructure and then build a more complex ring for out-of-order
> processing on top of it.  I'm not sure.  My gut feeling is that it will
> probably result in a cleaner implementation: The higher-layered ring can
> stop worrying about the interrupt/hypercall details (it would use the
> simple ring as its transport)....and implementations that don't need
> out-of-order (e.g. networks) don't have to deal with the associated
> complexity.

	But in fact as we can see, two rings need less from each ring than one
ring.  One ring must have producer and consumer indices, so the producer
doesn't overrun the consumer.  But if the second ring is used to feed
consumption, the consumer index isn't required any more: in fact, it's
just confusing to have.

	I really think that a table of descriptors, a ring for produced
descriptors and a ring for used descriptors is the most cache-friendly,
bidir-non-trusting simple implementation possible.  Of course, the
produced and used rings might be the same format, which allows code
sharing and if you squint a little, that's your "lowest level" simple
ringbuffer.

Thanks for the discussion,
Rusty.
