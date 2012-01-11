From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 00:13:49 +0200
Message-ID: <20120111221349.GD27292@redhat.com>
References: <20111218101831.GB30374@redhat.com>
	<87bor5nlht.fsf@rustcorp.com.au>
	<20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au>
	<20120111102129.GC20988@redhat.com>
	<1326316422.23910.154.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1326316422.23910.154.camel@pasglop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 12, 2012 at 08:13:42AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2012-01-11 at 12:21 +0200, Michael S. Tsirkin wrote:
> > 
> > > BenH also convinced me we should finally make the config space LE if
> > > we're going to change things.  Since PCI is the most common transport,
> > > guest-endian confuses people.  And it sucks for really weird machines.
> > 
> > Are we going to keep guest endian for e.g. virtio net header?
> > If yes the benefit of switching config space is not that big.
> > And changes in devices would affect non-PCI transports.
> 
> I think the concept of "guest endian" is broken by design. What does
> that mean when running for example an ARM or a ppc 440 "guest" which
> could be either endian ? Since you can't hard code your guest endian how
> do you obtain/negociate it ? Also you now have to deal with dual endian
> in the host, makes everything trickier.
> 
> Just make everything LE.

Yea. But it's not a pure transport issue, just fixing configuration
won't be enough.  E.g. we have structures like virtio net header.

> > Quite possibly all or some of these things help performance
> > but do we have to change the spec before we have experimental
> > proof?
> 
> Well, I would argue that the network driver world has proven countless
> times that those are good ideas :-)

Below you seem to suggest that separate rings like
virtio has now is better than a single ring like Rusty
suggested.

> But by all mean, let's do a
> prototype implementation with virtio-net for example and bench it.
> 
> I don't think you need a single ring. For multiqueue net, you definitely
> want multiple rings and you do want rings to remain uni-directional.
> 
> One other thing that can be useful is to separate the completion ring
> from the actual ring of DMA descriptors, making the former completely
> read-only by the guest and the later completely read only by the host.

Are you familiar with current virtio ring structure?  How is this
different?

> For example take the ehea ethernet rx model. It has 3 rx "rings" per
> queue. One contains the completions, it's a toggle-valid model so we
> never write back to clear valid, it contains infos from the parser, the
> tokenID of the packet and the index as to where in which ring the data
> is, wich is either inline in the completion ring (small packet), header
> inline & data in a data ring or completely in a data ring. Then you have
> two data rings which are simply rings of SG list entries (more or less).
> 
> We typically pre-populate the data rings with skb's for 1500 and 9000
> bytes packets. Small packets come in immediately in the completion ring,
> and large packets via the data ring. 

Won't real workloads suffer from packet reordering?

> That's just -an- example. There's many other to take inspiration from.
> Network folks have beaten to death the problem of ring efficiency vs.
> CPU caches.
> 
> > > Moreover, I think we should make all these changes at once (at least, in
> > > the spec).  That makes it a big change, and it'll take longer to
> > > develop, but makes it easy in the long run to differentiate legacy and
> > > modern virtio.
> > > 
> > > Thoughts?
> > > Rusty.
> > 
> > BTW this seems to be the reverse from what you have in Mar 2001,
> > see 87mxkjls61.fsf@rustcorp.com.au :)
> 
> That was 10 years ago... 

Sorry, typo. It was Mar 2010 :)

> > I am much less concerned with what we do for configuration,
> > but I do not believe we have learned all performance lessons
> > from virtio ring1. 
> 
> Maybe we have learned some more since then ? :-)

There was 1 change in ring layout.

> > Is there any reason why we shouldn't be
> > able to experiment with inline within virtio1 and see
> > whether that gets us anything?
> > If we do a bunch of changes to the ring at once, we can't
> > figure out what's right, what's wrong, or back out of
> > mistakes later.
> > 
> > Since there are non PCI transports that use the ring,
> > we really shouldn't make both the configuration and
> > the ring changes depend on the same feature bit.
> 
> Another advantage of inline data is that it makes things a lot easier
> for cases where only small amount of data need to be exchanged, such as
> control/status rings, maybe virtio-tty (which I'm working on), etc... 
> 
> Cheers,
> Ben.

Is that getting you a lot of speedup? Note you want to add more code on
data path for everyone.  Why can't you have a fixed buffer in memory and
just point to that?

-- 
MST
