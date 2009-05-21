From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 13:01:50 +0100
Message-ID: <200905211301.52089.paul__28340.2344598018$1242916615$gmane$org@codesourcery.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211134.21184.paul@codesourcery.com>
	<4A15346C.8090906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A15346C.8090906@redhat.com>
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

> >> The PCI bus doesn't need any special support (I think) but something on
> >> the other end needs to interpret those writes.
> >
> > Sure. But there's definitely nothing PCI specific about it. I assumed
> > this would all be contained within the APIC.
>
> MSIs are defined by PCI and their configuration is done using the PCI
> configuration space.

A MSI is just a regular memory write, and the PCI spec explicitly states that 
a target (e.g. the APIC) is unable to distinguish between a MSI and any other 
write. The PCI config bits just provide a way of telling the device where/what 
to write.

> >> In any case we need some internal API for this, and qemu_irq looks like
> >> a good choice.
> >
> > What do you expect to be using this API?
>
> virtio, emulated devices capable of supporting MSI (e1000?), device
> assignment (not yet in qemu.git).

It probably makes sense to have common infrastructure in pci.c to 
expose/implement device side MSI functionality. However I see no need for a 
direct API between the device and the APIC. We already have an API for memory 
accesses and MMIO regions. I'm pretty sure a system could implement MSI by 
pointing the device at system ram, and having the CPU periodically poll that.

Paul
