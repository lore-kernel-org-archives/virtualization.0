From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: Zerocopy VM-to-VM networking using virtio-net
Date: Thu, 23 Apr 2015 18:54:46 +0200
Message-ID: <20150423185446.33ae3e07.cornelia.huck__27472.957611508$1429808130$gmane$org@de.ibm.com>
References: <20150422170138.GA8388@stefanha-thinkpad.redhat.com>
	<20150422194603.1e650ec7.cornelia.huck@de.ibm.com>
	<CAJSP0QVb8n7QGTEhE=9FV3S02Ui8be2dY_0B6bsC2yHoD1Buyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QVb8n7QGTEhE=9FV3S02Ui8be2dY_0B6bsC2yHoD1Buyg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Rik van Riel <riel@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-comment@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 22 Apr 2015 19:00:52 +0100
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Apr 22, 2015 at 6:46 PM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > On Wed, 22 Apr 2015 18:01:38 +0100
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:

> >> virtio-net VM-to-VM extensions
> >> ------------------------------
> >> A few extensions to virtio-net are necessary to support zero-copy
> >> VM-to-VM communication.  The extensions are covered informally
> >> throughout the text, this is not a VIRTIO specification change proposal.
> >>
> >> The VM-to-VM capable virtio-net PCI adapter has an additional MMIO BAR
> >> called the Shared Buffers BAR.  The Shared Buffers BAR is a shared
> >> memory region on the host so that the virtio-net devices in VM1 and VM2
> >> both access the same region of memory.
> >>
> >> The vring is still allocated in guest RAM as usual but data buffers must
> >> be located in the Shared Buffers BAR in order to take advantage of
> >> zero-copy.
> >>
> >> When VM1 places a packet into the tx queue and the buffers are located
> >> in the Shared Buffers BAR, the host finds the VM2's rx queue descriptor
> >> with the same buffer address and completes it without copying any data
> >> buffers.
> >
> > The shared buffers BAR looks PCI-specific, but what about other
> > mechanisms to provide a shared space between two VMs with some kind of
> > lightweight notifications? This should make it possible to implement a
> > similar mode of operation for other transports if it is factored out
> > correctly. (The actual implementation of this shared space is probably
> > the difficult part :)
> 
> It depends on the primitives available.  For example, in a virtual DMA
> page-flipping environment the hypervisor could change page ownership
> between the two VMs.  This does not required shared memory.  But
> there's a cost to virtual memory bookkeeping so it might only be a win
> for big packets.
> 
> Does s390 have a mechanism for giving VMs permanent shared or
> temporary access to memory pages?

Under kvm/qemu, currently not. Under z/VM, there's DCSS; while we don't
want to copy that interface, we'll probably want to introduce something
similar in the future. No design yet, though.

> Virtqueue kick is still used for notification.  In fact, the virtqueue
> operation is basically the same, except that data buffers are now
> located in the Shared Buffers BAR instead.

You're right, if this is in the virtqueue buffers, this should just
work.

> 
> >> Discussion
> >> ----------
> >> The result is that applications in separate VMs can communicate in true
> >> zero-copy fashion.
> >>
> >> I think this approach could be fruitful in bringing virtio-net to
> >> VM-to-VM networking use cases.  Unless virtio-net is extended for this
> >> use case, I'm afraid DPDK and OpenDataPlane communities might steer
> >> clear of VIRTIO.
> >>
> >> This is an idea I want to share but I'm not working on a prototype.
> >> Feel free to flesh it out further and try it!
> >
> > Definetly interesting. It seems you get much of the needed
> > infrastructure by simply leveraging what PCI gives you anyway? If we
> > want something like in other environments (say, via ccw on s390), we'd
> > have to come up with a mechanism that can give us the same (which is
> > probably the hard part).
> 
> It may not be a win in all environments.  It depends on the primitives
> available for memory access.
> 
> With PCI devices and a Linux host we can use a shared memory region.
> If shared memory is not available then maybe there is no performance
> win to be had.

I think if there's a good split between concept and specific backend,
we just can figure out the "shared" part later on.
