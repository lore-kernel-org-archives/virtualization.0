From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] powerpc-virtio: virtio support
	introduced (block, network, serial, balloon, 9p-fs), both fullemu and
	power-kvm
Date: Wed, 18 May 2011 11:58:11 +0300
Message-ID: <20110518085811.GJ7589__7642.25202515281$1305709131$gmane$org@redhat.com>
References: <1305614826-1815-1-git-send-email-david@gibson.dropbear.id.au>
	<1305614826-1815-4-git-send-email-david@gibson.dropbear.id.au>
	<CC7C7633-F1F6-4CCC-BC48-F7DC057CB63E@suse.de>
	<20110518032745.GB3015@yookeroo.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110518032745.GB3015@yookeroo.fritz.box>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>, Alexey Kardashevskiy <aik@ozlabs.ru>, Rusty Russell <rusty@rustcorp.com.au>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 18, 2011 at 01:27:45PM +1000, David Gibson wrote:
> On Tue, May 17, 2011 at 09:06:41AM +0200, Alexander Graf wrote:
> > On 17.05.2011, at 08:47, David Gibson wrote:
> > > From: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > 
> > > The recently added pseries machine does not currently support PCI
> > > emulation.  For the (upcoming) kvm case, this is quite difficult to do
> > > because the preferred HV mode for the host kernel does not allow MMIO
> > > emulation (a hardware limitation).
> > > 
> > > Therefore, to support virtio devices, we implement a new virtio setup
> > > protocol for PAPR guests.  This is based loosely on the s390 and lguest
> > > methods, using the PAPR hcalls for the virtio primitive operations,
> > > and the PAPR device tree to advertise the virtio device resources to the
> > > guest.
> > > 
> > > This patch includes support for the virtio block, network, serial, and
> > > balloon devices, and the 9p filesystem.
> [snip]
> > 
> > Before including such a patch, we should really discuss the desired
> > interface for virtio on sPAPR. I personally would prefer if we could
> > have a generic MMIO hypercall that the guest issues, so that we can
> > simply use virtio-pci on sPAPR (and all the other PCI hardware).
> 
> Hrm.  I'm not thrilled at that idea.  We would still need to advertise
> in the device tree to use the MMIO hypercall, instead of going direct
> - since we will be going direct for things like passthrough PCI
> devices under KVM.
> 
> > But at the end of the day, the steps should be as follows:
> > 
> >   1) Discuss this on the virtualization ML
> 
> Ok, which list do you mean here?
> 
> >   2) Send patches for the virtio documentation so the protocol has a spec (which we're lacking for s390 still)
> >   3) Implement Linux side, upstream it
> 
> I don't see why the Linux guest side needs to go before the qemu
> side.  You can't use one without the other, so there's no clear order.

Agree here. I would further argue qemu should go in first,
this is what happens with real devices: first hardware, then
driver. Linux side just needs to be ready and available in the repository
somewhere.

> >   4) Upstream Qemu side
> > 
> > Since I haven't seen 1-3, I'd like to defer this patch until the
> > other points are good :)
> 
> Hmm.  I'll see what I can do.
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
