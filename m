From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove CONFIG_XEN_DOM0 compile option
Date: Mon, 9 Jan 2012 18:12:14 +0000
Message-ID: <alpine.DEB.2.00.1201091808460.3150@kaball-desktop>
References: <d6148ae9-932e-4fba-947e-ee70b2e25fd2@zmail13.collab.prod.int.phx2.redhat.com>
	<alpine.DEB.2.00.1201091054111.3150@kaball-desktop>
	<20120109145648.GA25563@phenom.dumpdata.com>
	<alpine.DEB.2.00.1201091532420.3150@kaball-desktop>
	<20120109170418.GD28700@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120109170418.GD28700@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrew Jones <drjones@redhat.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "jeremy@goop.org" <jeremy@goop.org>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 9 Jan 2012, Konrad Rzeszutek Wilk wrote:
> On Mon, Jan 09, 2012 at 04:12:10PM +0000, Stefano Stabellini wrote:
> > On Mon, 9 Jan 2012, Konrad Rzeszutek Wilk wrote:
> > > On Mon, Jan 09, 2012 at 11:39:44AM +0000, Stefano Stabellini wrote:
> > > > I don't think we should add "PCI_XEN && SWIOTLB_XEN && X86_LOCAL_APIC &&
> > > > X86_IO_APIC && ACPI && PCI" to XEN either.
> > > > However it should be possible to add only the right dependencies to the
> > > > right places.
> > > > In practice it should be sufficient to:
> > > > 
> > > > - make PCI_XEN depend on X86_LOCAL_APIC && X86_IO_APIC && ACPI;
> > > 
> > > Not good. You can make non-ACPI builds with PCI.
> > > 
> > > .. and you are missing CONFIG_PCI in there.
> > > > 
> > > > - make XEN_PCIDEV_FRONTEND and XEN_PCIDEV_BACKEND depend on PCI_XEN;
> > > 
> > > OK. That sounds good.
> > > > 
> > > > - remove the 'ifdef CONFIG_ACPI' from arch/x86/pci/xen.c.
> > > 
> > > No.. same issue - non-ACPI builds can be with PCI.
> > > > 
> > 
> > Right.. in that case we should carefully replace the 'ifdef
> > CONFIG_XEN_DOM0' with 'ifdef CONFIG_ACPI' in arch/x86/pci/xen.c.
> 
> .. which I think I did at some point as part of cleanup and then
> removed them since it peppered the xen.c with tons of #ifdef CONFIG_ACPI.

that's unfortunate


> What about PVonHVM. There is this nagging feeling in the back of my
> head that turning CONFIG_XEN_DOM0 disables the CONFIG_PVHVM option?
> Or something like that? Maybe it is the other way around?

nope, nothing I can think of.


> It would seem we need to seperate the PVHVM  from DOM0. But the extra
> complexity comes with Mukesh's PVonHVM Hybrid which can do dom0 stuff
> with PVonHVM (should be searchable on xen-devel to find the patches).

I think that at the moment PVHVM and DOM0 aren't tie to one another in
any way, apart from the fact that they use the same generic
infrastructure to remap interrupts and MSIs into event channels.
