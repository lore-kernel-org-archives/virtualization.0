From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: msi irq allocation api
Date: Thu, 21 May 2009 16:12:31 +0300
Message-ID: <20090521131231.GH25309__11670.3744083226$1242911846$gmane$org@redhat.com>
References: <20090520162130.GA22109@redhat.com>
	<200905211329.41578.paul@codesourcery.com>
	<4A154B60.4080701@redhat.com>
	<200905211409.33325.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905211409.33325.paul@codesourcery.com>
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

On Thu, May 21, 2009 at 02:09:32PM +0100, Paul Brook wrote:
> > > A tight coupling between PCI devices and the APIC is just going to cause
> > > us problems later one. I'm going to come back to the fact that these are
> > > memory writes so once we get IOMMU support they will presumably be
> > > subject to remapping by that, just like any other memory access.
> >
> > I'm not suggesting the qemu_irq will extend all the way to the apic.
> > Think of it as connecting the device core with its interrupt unit.
> >
> > > Even ignoring that, qemu_irq isn't really the right interface. A MSI is a
> > > one- off event, not a level state. OTOH stl_phys is exactly the right
> > > interface.
> >
> > The qemu_irq callback should do an stl_phys().  The device is happy
> > since it's using the same API it uses for non-MSI. 
> 
> MSI provides multiple edge triggered interrupts, whereas traditional mode 
> provides a single level triggered interrupt. My guess is most devices will 
> want to treat these differently anyway.

So, is qemu_send_msi better than qemu_set_irq.

> Either way, this is an implementation detail between pci.c and individual 
> devices. It has nothing to do with the APIC.
> 
> Paul

-- 
MST
