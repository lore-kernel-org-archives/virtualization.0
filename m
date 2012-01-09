From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove CONFIG_XEN_DOM0 compile option
Date: Mon, 9 Jan 2012 16:12:10 +0000
Message-ID: <alpine.DEB.2.00.1201091532420.3150@kaball-desktop>
References: <d6148ae9-932e-4fba-947e-ee70b2e25fd2@zmail13.collab.prod.int.phx2.redhat.com>
	<alpine.DEB.2.00.1201091054111.3150@kaball-desktop>
	<20120109145648.GA25563@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120109145648.GA25563@phenom.dumpdata.com>
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
> On Mon, Jan 09, 2012 at 11:39:44AM +0000, Stefano Stabellini wrote:
> > I don't think we should add "PCI_XEN && SWIOTLB_XEN && X86_LOCAL_APIC &&
> > X86_IO_APIC && ACPI && PCI" to XEN either.
> > However it should be possible to add only the right dependencies to the
> > right places.
> > In practice it should be sufficient to:
> > 
> > - make PCI_XEN depend on X86_LOCAL_APIC && X86_IO_APIC && ACPI;
> 
> Not good. You can make non-ACPI builds with PCI.
> 
> .. and you are missing CONFIG_PCI in there.
> > 
> > - make XEN_PCIDEV_FRONTEND and XEN_PCIDEV_BACKEND depend on PCI_XEN;
> 
> OK. That sounds good.
> > 
> > - remove the 'ifdef CONFIG_ACPI' from arch/x86/pci/xen.c.
> 
> No.. same issue - non-ACPI builds can be with PCI.
> > 

Right.. in that case we should carefully replace the 'ifdef
CONFIG_XEN_DOM0' with 'ifdef CONFIG_ACPI' in arch/x86/pci/xen.c.
It would effectively keep things as they are now: if ACPI and XEN are
enabled together in the config file, your kernel is able to setup
interrupts when running as DOM0.
Regarding X86_LOCAL_APIC and X86_IO_APIC I cannot recall anymore where
these dependencies come from exactly.


> > > The driver domain concept may actually be the technical need for
> > > making XEN_DOM0 optional. If we want the ability to build a minimally
> > > configed XEN kernel to be used as a driver domain, then it doesn't
> > > seem like we'd want it to also be capable of running as an initial
> > > domain, or to be forced to have all the dependencies and code of an
> > > initial domain.
> > 
> > In practice any decent driver domain needs PCI and ACPI support, so
> > basically it has the same config requirement of XEN_DOM0. At that point
> 
> Sure.. for backends. But for frontends that requirement is not always true.

Right but a driver domain is bound to have at least the pci backend.


> > we have already discussed that having XEN_DOM0 enabled or disabled
> > hardly makes any differences, so we can just get rid of it.
> 
> Or in other words, substitute it as CONFIG_PCI_XEN.

I was just trying to assign the dependencies where they really belong
and I proposed to remove the 'ifdef CONFIG_ACPI' because I didn't
realize that one can build working PCI configurations on XEN without it.

The fact that PCI_XEN would be used then almost as XEN_DOM0 is used now
is just a side effect, due to the fact that PCI and device interrupts
initialization is what mainly differentiates dom0 from other
configurations.


> But this brings a question about MCE, ACPI cpu freq and ACPI S3.
> Those all belong to the dom0 - not to any driver domain. So getting rid
> of CONFIG_XEN_DOM0 would present a problem - what would those depend on?

They would depend on XEN and whatever else they really depend on, for
example ACPI.
