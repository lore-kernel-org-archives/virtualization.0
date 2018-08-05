From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Sun, 5 Aug 2018 03:22:36 +0300
Message-ID: <20180805031046-mutt-send-email-mst__7853.32692689753$1533428445$gmane$org@kernel.org>
References: <20180802182959-mutt-send-email-mst@kernel.org>
	<82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
	<20180802200646-mutt-send-email-mst@kernel.org>
	<e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
	<20180802225738-mutt-send-email-mst@kernel.org>
	<de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
	<20180803070507.GA1344@infradead.org>
	<eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
	<20180803220443-mutt-send-email-mst@kernel.org>
	<051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mpe@ellerman.id.au, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, paulus@samba.org, marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 03, 2018 at 08:16:21PM -0500, Benjamin Herrenschmidt wrote:
> On Fri, 2018-08-03 at 22:07 +0300, Michael S. Tsirkin wrote:
> > On Fri, Aug 03, 2018 at 10:58:36AM -0500, Benjamin Herrenschmidt wrote:
> > > On Fri, 2018-08-03 at 00:05 -0700, Christoph Hellwig wrote:
> > > > >   2- Make virtio use the DMA API with our custom platform-provided
> > > > > swiotlb callbacks when needed, that is when not using IOMMU *and*
> > > > > running on a secure VM in our case.
> > > > 
> > > > And total NAK the customer platform-provided part of this.  We need
> > > > a flag passed in from the hypervisor that the device needs all bus
> > > > specific dma api treatment, and then just use the normal plaform
> > > > dma mapping setup. 
> > > 
> > > Christoph, as I have explained already, we do NOT have a way to provide
> > > such a flag as neither the hypervisor nor qemu knows anything about
> > > this when the VM is created.
> > 
> > I think the fact you can't add flags from the hypervisor is
> > a sign of a problematic architecture, you should look at
> > adding that down the road - you will likely need it at some point.
> 
> Well, we can later in the boot process. At VM creation time, it's just
> a normal VM. The VM firmware, bootloader etc... are just operating
> normally etc...

I see the allure of this, but I think down the road you will
discover passing a flag in libvirt XML saying
"please use a secure mode" or whatever is a good idea.

Even thought it is probably not required to address this
specific issue.

For example, I don't think ballooning works in secure mode,
you will be able to teach libvirt not to try to add a
balloon to the guest.

> Later on, (we may have even already run Linux at that point,
> unsecurely, as we can use Linux as a bootloader under some
> circumstances), we start a "secure image".
> 
> This is a kernel zImage that includes a "ticket" that has the
> appropriate signature etc... so that when that kernel starts, it can
> authenticate with the ultravisor, be verified (along with its ramdisk)
> etc... and copied (by the UV) into secure memory & run from there.
> 
> At that point, the hypervisor is informed that the VM has become
> secure.
> 
> So at that point, we could exit to qemu to inform it of the change,

That's probably a good idea too.

> and
> have it walk the qtree and "Switch" all the virtio devices to use the
> IOMMU I suppose, but it feels a lot grosser to me.

That part feels gross, yes.

> That's the only other option I can think of.
> 
> > However in this specific case, the flag does not need to come from the
> > hypervisor, it can be set by arch boot code I think.
> > Christoph do you see a problem with that?
> 
> The above could do that yes. Another approach would be to do it from a
> small virtio "quirk" that pokes a bit in the device to force it to
> iommu mode when it detects that we are running in a secure VM. That's a
> bit warty on the virito side but probably not as much as having a qemu
> one that walks of the virtio devices to change how they behave.
> 
> What do you reckon ?

I think you are right that for the dma limit the hypervisor doesn't seem
to need to know.

> What we want to avoid is to expose any of this to the *end user* or
> libvirt or any other higher level of the management stack. We really
> want that stuff to remain contained between the VM itself, KVM and
> maybe qemu.
>
> We will need some other qemu changes for migration so that's ok. But
> the minute you start touching libvirt and the higher levels it becomes
> a nightmare.
> 
> Cheers,
> Ben.

I don't believe you'll be able to avoid that entirely. The split between
libvirt and qemu is more about community than about code, random bits of
functionality tend to land on random sides of that fence.  Better add a
tag in domain XML early is my advice. Having said that, it's your
hypervisor. I'm just suggesting that when hypervisor does somehow need
to care then I suspect most people won't be receptive to the argument
that changing libvirt is a nightmare.

> > > >  To get swiotlb you'll need to then use the DT/ACPI
> > > > dma-range property to limit the addressable range, and a swiotlb
> > > > capable plaform will use swiotlb automatically.
> > > 
> > > This cannot be done as you describe it.
> > > 
> > > The VM is created as a *normal* VM. The DT stuff is generated by qemu
> > > at a point where it has *no idea* that the VM will later become secure
> > > and thus will have to restrict which pages can be used for "DMA".
> > > 
> > > The VM will *at runtime* turn itself into a secure VM via interactions
> > > with the security HW and the Ultravisor layer (which sits below the
> > > HV). This happens way after the DT has been created and consumed, the
> > > qemu devices instanciated etc...
> > > 
> > > Only the guest kernel knows because it initates the transition. When
> > > that happens, the virtio devices have already been used by the guest
> > > firmware, bootloader, possibly another kernel that kexeced the "secure"
> > > one, etc... 
> > > 
> > > So instead of running around saying NAK NAK NAK, please explain how we
> > > can solve that differently.
> > > 
> > > Ben.
> > > 
