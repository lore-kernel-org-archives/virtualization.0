From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 5 Jun 2013 22:43:17 +0300
Message-ID: <20130605194317.GA30923@redhat.com>
References: <20130603101136.GB8649@redhat.com> <87fvwytpa1.fsf@rustcorp.com.au>
	<20130604064216.GD19433@redhat.com> <871u8g67d6.fsf@codemonkey.ws>
	<20130605140936.GB10604@redhat.com> <87ehcgr3wq.fsf@codemonkey.ws>
	<20130605151953.GA25987@redhat.com> <87bo7ktvaw.fsf@codemonkey.ws>
	<20130605162029.GB26561@redhat.com> <87li6obd2r.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87li6obd2r.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 05, 2013 at 01:57:16PM -0500, Anthony Liguori wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Wed, Jun 05, 2013 at 10:46:15AM -0500, Anthony Liguori wrote:
> >> Look, it's very simple.
> > We only need to do it if we do a change that breaks guests.
> >
> > Please find a guest that is broken by the patches. You won't find any.
> 
> I think the problem in this whole discussion is that we're talking past
> each other.
> 
> Here is my understanding:
> 
> 1) PCI-e says that you must be able to disable IO bars and still have a
> functioning device.
> 
> 2) It says (1) because you must size IO bars to 4096 which means that
> practically speaking, once you enable a dozen or so PIO bars, you run
> out of PIO space (16 * 4k == 64k and not all that space can be used).


Let me add 3 other issues which I mentioned and you seem to miss:

3) architectures which don't have fast access to IO ports, exist
   virtio does not work there ATM

4) setups with many PCI bridges exist and have the same issue
   as PCI express. virtio does not work there ATM

5) On x86, even with nested page tables, firmware only decodes
   the page address on an invalid PTE, not the data. You need to
   emulate the guest to get at the data. Without
   nested page tables, we have to do page table walk and emulate
   to get both address and data. Since this is how MMIO
   is implemented in kvm on x86, MMIO is much slower than PIO
   (with nested page tables by a factor of >2, did not test without).

> virtio-pci uses a IO bars exclusively today.  Existing guest drivers
> assume that there is an IO bar that contains the virtio-pci registers.
> So let's consider the following scenarios:
> 
> QEMU of today:
> 
> 1) qemu -drive file=ubuntu-13.04.img,if=virtio
> 
> This works today.  Does adding an MMIO bar at BAR1 break this?
> Certainly not if the device is behind a PCI bus...
> 
> But are we going to put devices behind a PCI-e bus by default?  Are we
> going to ask the user to choose whether devices are put behind a legacy
> bus or the express bus?
> 
> What happens if we put the device behind a PCI-e bus by default?  Well,
> it can still work.  That is, until we do something like this:
> 
> 2) qemu -drive file=ubuntu-13.04.img,if=virtio -device virtio-rng
>         -device virtio-balloon..
> 
> Such that we have more than a dozen or so devices.  This works
> perfectly fine today.  It works fine because we've designed virtio to
> make sure it works fine.  Quoting the spec:
> 
> "Configuration space is generally used for rarely-changing or
>  initialization-time parameters. But it is a limited resource, so it
>  might be better to use a virtqueue to update configuration information
>  (the network device does this for filtering, otherwise the table in the
>  config space could potentially be very large)."
> 
> In fact, we can have 100s of PCI devices today without running out of IO
> space because we're so careful about this.
> 
> So if we switch to using PCI-e by default *and* we keep virtio-pci
> without modifying the device IDs, then very frequently we are going to
> break existing guests because the drivers they already have no longer
> work.
> 
> A few virtio-serial channels, a few block devices, a couple of network
> adapters, the balloon and RNG driver, and we hit the IO space limit
> pretty damn quickly so this is not a contrived scenario at all.  I would
> expect that we frequently run into this if we don't address this problem.
> 
> So we have a few options:
> 1) Punt all of this complexity to libvirt et al and watch people make
>    the wrong decisions about when to use PCI-e.  This will become yet
>    another example of KVM being too hard to configure.
> 
> 2) Enable PCI-e by default and just force people to upgrade their
>    drivers.
> 
> 3) Don't use PCI-e by default but still add BAR1 to virtio-pci
> 
> 4) Do virtio-pcie, make it PCI-e friendly (drop the IO BAR completely),

We can't do this - it will hurt performance.

>    give
>    it a new device/vendor ID.   Continue to use virtio-pci for existing
>    devices potentially adding virtio-{net,blk,...}-pcie variants for
>    people that care to use them.
> 
> I think 1 == 2 == 3 and I view 2 as an ABI breaker.

Why do you think 2 == 3? 2 changes default behaviour. 3 does not.

> libvirt does like
> policy so they're going to make a simple decision and always use the
> same bus by default.  I suspect if we made PCI the default, they might
> just always set the PCI-e flag just because.

This sounds very strange. But let's assume you are right for
the sake of the argument ...

> There are hundreds of thousands if not millions of guests with existing
> virtio-pci drivers.  Forcing them to upgrade better have an extremely
> good justification.
> 
> I think 4 is the best path forward.  It's better for users (guests
> continue to work as they always have).  There's less confusion about
> enabling PCI-e support--you must ask for the virtio-pcie variant and you
> must have a virtio-pcie driver.  It's easy to explain.

I don't think how this changes the situation. libvirt still need
to set policy and decide which device to use.

> It also maps to what regular hardware does.  I highly doubt that there
> are any real PCI cards that made the shift from PCI to PCI-e without
> bumping at least a revision ID.

Only because the chance it's 100% compatible on the software level is 0.
It always has some hardware specific quirks.
No such excuse here.

> It also means we don't need to play games about sometimes enabling IO
> bars and sometimes not.

This last paragraph is wrong, it ignores the issues 3) to 5) 
I added above.

If you do take them into account:
	- there are reasons to add MMIO BAR to PCI,
	  even without PCI express
	- we won't be able to drop IO BAR from virtio

> Regards,
> 
> Anthony Liguori
> 
> >
> >
> > -- 
> > MST
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
