From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 13:29:37 +0100
Message-ID: <200905211329.41578.paul__416.572966105555$1242916740$gmane$org@codesourcery.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211301.52089.paul@codesourcery.com>
	<4A154432.1060808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A154432.1060808@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 21 May 2009, Avi Kivity wrote:
> Paul Brook wrote:
> >>>> In any case we need some internal API for this, and qemu_irq looks
> >>>> like a good choice.
> >>>
> >>> What do you expect to be using this API?
> >>
> >> virtio, emulated devices capable of supporting MSI (e1000?), device
> >> assignment (not yet in qemu.git).
> >
> > It probably makes sense to have common infrastructure in pci.c to
> > expose/implement device side MSI functionality. However I see no need for
> > a direct API between the device and the APIC. We already have an API for
> > memory accesses and MMIO regions. I'm pretty sure a system could
> > implement MSI by pointing the device at system ram, and having the CPU
> > periodically poll that.
>
> Instead of writing directly, let's abstract it behind a qemu_set_irq().
> This is easier for device authors.  The default implementation of the
> irq callback could write to apic memory, while for kvm we can directly
> trigger the interrupt via the kvm APIs.

I'm still not convinced.

A tight coupling between PCI devices and the APIC is just going to cause us 
problems later one. I'm going to come back to the fact that these are memory 
writes so once we get IOMMU support they will presumably be subject to 
remapping by that, just like any other memory access.

Even ignoring that, qemu_irq isn't really the right interface. A MSI is a one-
off event, not a level state. OTOH stl_phys is exactly the right interface.

The KVM interface should be contained within the APIC implementation.

Paul
