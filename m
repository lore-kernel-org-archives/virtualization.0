From: Ilya Lesokhin <ilyal@mellanox.com>
Subject: RE: Virtio BoF minutes from KVM Forum 2017
Date: Thu, 2 Nov 2017 08:18:28 +0000
Message-ID: <VI1PR0501MB2734983F5079B3FE5B9FCE60D45C0@VI1PR0501MB2734.eurprd05.prod.outlook.com>
References: <20171029125225.lx4ezpkbvjjsjv3x@localhost.localdomain>
	<20171101162357-mutt-send-email-mst@kernel.org>
	<AM4PR0501MB2723D56ED113A7B98D3785F0D45F0@AM4PR0501MB2723.eurprd05.prod.outlook.com>
	<20171101190219-mutt-send-email-mst@kernel.org>
	<AM4PR0501MB2723A2C058045E70A66959B3D45F0@AM4PR0501MB2723.eurprd05.prod.outlook.com>
	<20171101214417-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171101214417-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday, November 02, 2017 5:40 AM, Michael S. Tsirkin wrote:

> > [I.L] In the current proposal descriptor size == SGE (scatter gather entry) size.
> > I'm not sure that's a good idea.
> > For example we are considering having an RX ring were you just post a
> > list of PFN's so a sge is only 8 bytes.
> 
> You mean without length, flags etc?  So when you are concerned about memory
> usage because you have many users for buffers (like e.g. with Linux
> networking), then sizing buffers dynamically helps a lot. Single user cases like
> DPDK or more recently XDP are different and they can afford making all buffers
> same size.
> 
[I.L] Yes, no length or flags, we just fill it with packets back to back, so 
Memory usage wise it quite efficient.

> For sure 8 byte entries would reduce cache pressure.  Question is how to we
> handle so much variety in the ring layouts. Thoughts?
> 
[I.L] I agree that there are downsides to too much variety in the ring layouts.

It does seem that to get to most out of the ring layout I suggested
will require changing to the vring API to work with descriptors (== work requests) 
rather than sg lists.

I guess I need to think about it a bit more.

> I don't think we focused on DPDK limitations.  For sure, lots of people use LSO or
> other buffers with many s/g entries. But it also works pretty well more or less
> whatever you do as you are able to pass a single large packet then - so the per-
> packet overhead is generally amortized.
> 
[I.L] I see you point, I'll have to think about it some more.

> > And the storage guys also complained about this issue.
> 
> Interesting. What was the complaint exactly.
> 
[I.L]  That scatter gather is Important and that we shouldn't
Optimize for the single SGE case.
But the point you made earlier about amortization also applies here.


> > [I.L] The device can do a single large read and do the parsing afterword's.
> 
> For sure but that wastes some pcie bandwidth.
> 
> > You could also use the doorbell to tell the device how much to read.
> 
> We currently use that to pass address of last descriptor.
[I.L] If you read up to the last descriptor you don't waste any pcie bandwidth.

> >
> > > Seems to look like the avail bit in the kvm forum presentation.
> > >
> > [I.L] I don't want to argue over the name. The main difference in my
> > proposal is that the device doesn't need to write to the descriptor.
> > If it wants to you can define a separate bit for that.
> 
> A theoretical analysis shows less cache line bounces if device writes and driver
> writes go to same location.
> A micro-benchmark and dpdk tests seem to match that.
> 
> If you want to split them, how about a test showing either a benefit for software
> or an explanation about why it's significantly different for hardware than
> software?
> 
[I.L]  The separate bit can be in the same cacheline.

> > I don't remember seeing an option to write used entries in a separate
> > address, I'll appreciate it if you can point me to the right direction.
> 
> It wasn't described in the talk.
> 
> But it's simply this: driver detects used entry by detecting a used bit flip.  If
> device does not use the option to skip writing back some used entries then
> there's no need for used entries written by device and by driver to overlap. If
> device does skip then we need them to overlap as driver also needs to reset the
> used flag so used != avail.
> 
[I.L]  I don't follow, how does the device inform the driver the a descriptor has been
Processed?

> > Regarding the shared ring vs separate ring, I can't really argue with
> > you as I haven't done the relevant measurement.
> > I'm just saying it might not always be optimal in all use case, So you
> > should consider leaving both options open.
> >
> > It's entirely possible that for virtio-net you want a single ring,
> > Where for PV-RDMA you want separate rings.
> 
> Well RDMA consortium decided a low-level API for cards will help application
> portability, and that spec has a concept of completion queues which are shared
> between request queues.  So the combined ring optimization kind of goes out
> the window for that kind of device :) I'm not sure just splitting out used rings will
> be enough though.
> 
I didn't say the splitting the used ring is going to be enough. I suggested two things:
1. don't force the device to write to the request queue.
2. Allow efficient implementation of completion queues 
Through support for inline descriptors.


In any case, You've given me some valuable feedback
and I have better understanding of why you went with the
current ring layout.

Thanks,
Ilya
