From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 19:49:34 +0300
Message-ID: <20090521164934.GB6474__49975.2491283745$1242926464$gmane$org@redhat.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211514.31059.paul@codesourcery.com>
	<4A156739.6060207@redhat.com>
	<200905211550.21217.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905211550.21217.paul@codesourcery.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 21, 2009 at 03:50:18PM +0100, Paul Brook wrote:
> > >>> kvm has no business messing with the PCI device code.
> > >>
> > >> kvm has a fast path for irq injection.  If qemu wants to support it we
> > >> need some abstraction here.
> > >
> > > Fast path from where to where? Having the PCI layer bypass/re-implement
> > > the APIC and inject the interrupt directly into the cpu core sounds a
> > > particularly bad idea.
> >
> > kvm implements the APIC in the host kernel (qemu upstream doesn't
> > support this yet).  The fast path is wired to the in-kernel APIC, not
> > the cpu core directly.
> >
> > The idea is to wire it to UIO for device assignment, to a virtio-device
> > implemented in the kernel, and to qemu.
> 
> I still don't see why you're trying to bypass straight from the pci layer to 
> the apic. Why can't you just pass the apic MMIO writes to the kernel? You've 
> presumably got to update the apic state anyway.
> 
> Paul

As far as I can tell, at least on Intel, MSI interrupts are not MMIO writes.
They are PCI memory writes to a hard-coded address range that
are passed to APIC. I don't think MMIO writes can triger MSI,
or at least this does not seem to be documented.

-- 
MST
