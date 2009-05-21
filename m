From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 15:50:18 +0100
Message-ID: <200905211550.21217.paul__20954.2171135128$1242917514$gmane$org@codesourcery.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211514.31059.paul@codesourcery.com>
	<4A156739.6060207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A156739.6060207@redhat.com>
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
To: Avi Kivity <avi@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

> >>> kvm has no business messing with the PCI device code.
> >>
> >> kvm has a fast path for irq injection.  If qemu wants to support it we
> >> need some abstraction here.
> >
> > Fast path from where to where? Having the PCI layer bypass/re-implement
> > the APIC and inject the interrupt directly into the cpu core sounds a
> > particularly bad idea.
>
> kvm implements the APIC in the host kernel (qemu upstream doesn't
> support this yet).  The fast path is wired to the in-kernel APIC, not
> the cpu core directly.
>
> The idea is to wire it to UIO for device assignment, to a virtio-device
> implemented in the kernel, and to qemu.

I still don't see why you're trying to bypass straight from the pci layer to 
the apic. Why can't you just pass the apic MMIO writes to the kernel? You've 
presumably got to update the apic state anyway.

Paul
