From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 14:09:32 +0100
Message-ID: <200905211409.33325.paul__4709.02991150997$1242916844$gmane$org@codesourcery.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211329.41578.paul@codesourcery.com>
	<4A154B60.4080701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A154B60.4080701@redhat.com>
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

> > A tight coupling between PCI devices and the APIC is just going to cause
> > us problems later one. I'm going to come back to the fact that these are
> > memory writes so once we get IOMMU support they will presumably be
> > subject to remapping by that, just like any other memory access.
>
> I'm not suggesting the qemu_irq will extend all the way to the apic.
> Think of it as connecting the device core with its interrupt unit.
>
> > Even ignoring that, qemu_irq isn't really the right interface. A MSI is a
> > one- off event, not a level state. OTOH stl_phys is exactly the right
> > interface.
>
> The qemu_irq callback should do an stl_phys().  The device is happy
> since it's using the same API it uses for non-MSI. 

MSI provides multiple edge triggered interrupts, whereas traditional mode 
provides a single level triggered interrupt. My guess is most devices will 
want to treat these differently anyway.

Either way, this is an implementation detail between pci.c and individual 
devices. It has nothing to do with the APIC.

Paul
