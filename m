From: Andrew Jones <drjones@redhat.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove CONFIG_XEN_DOM0 compile option
Date: Mon, 09 Jan 2012 12:38:08 -0500 (EST)
Message-ID: <3f35c565-bcaf-49d2-ba46-c61ca95aa51b@zmail13.collab.prod.int.phx2.redhat.com>
References: <20120109170418.GD28700@phenom.dumpdata.com>
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
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



----- Original Message -----
> On Mon, Jan 09, 2012 at 04:12:10PM +0000, Stefano Stabellini wrote:
> > On Mon, 9 Jan 2012, Konrad Rzeszutek Wilk wrote:
> > > On Mon, Jan 09, 2012 at 11:39:44AM +0000, Stefano Stabellini
> > > wrote:
> > > > I don't think we should add "PCI_XEN && SWIOTLB_XEN &&
> > > > X86_LOCAL_APIC &&
> > > > X86_IO_APIC && ACPI && PCI" to XEN either.
> > > > However it should be possible to add only the right
> > > > dependencies to the
> > > > right places.
> > > > In practice it should be sufficient to:
> > > > 
> > > > - make PCI_XEN depend on X86_LOCAL_APIC && X86_IO_APIC && ACPI;
> > > 
> > > Not good. You can make non-ACPI builds with PCI.
> > > 
> > > .. and you are missing CONFIG_PCI in there.
> > > > 
> > > > - make XEN_PCIDEV_FRONTEND and XEN_PCIDEV_BACKEND depend on
> > > > PCI_XEN;
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
> removed them since it peppered the xen.c with tons of #ifdef
> CONFIG_ACPI.
> 
> What about PVonHVM. There is this nagging feeling in the back of my
> head that turning CONFIG_XEN_DOM0 disables the CONFIG_PVHVM option?
> Or something like that? Maybe it is the other way around?
> 
> It would seem we need to seperate the PVHVM  from DOM0. But the extra
> complexity comes with Mukesh's PVonHVM Hybrid which can do dom0 stuff
> with PVonHVM (should be searchable on xen-devel to find the patches).

They're currently separate, i.e. no problem with DOM0 off and PVHVM on,
or vice-versa afaict. I don't know anything about the hybrid though.

> 
> Ian also mentioned that we MUST have the XEN_PRIVILIGED option,
> otherwise
> we will cause a regression with the GRUB tools. So that must stay or
> we need
> provide a deprecation schedule for the next 3 years to remove it and
> have patches in the GRUB toolchains.

Yeah, that's a bummer.

> 
> Either way, there is also the question of making sure that no
> regressions
> are introduced - so a lot of the CONFIG_* interdependencies will have
> to be checked. I think that means checking CONFIG_XEN,
> CONFIG_PRIVILIGED,
> CONFIG_PVHVM, CONFIG_PCI, CONFIG_ACPI, CONFIG_XEN_BACKEND in various
> combinations.
> 

I guess if we did the s/XEN_DOM0/LOCAL_APIC && IO_APIC && ACPI/ in
arch/x86/pci/xen.c it would be pretty easy to review for equivalence.
Then keep CONFIG_PRIVILIGED, but drop XEN_DOM0 from everywhere else and
compile in the 3 files. I don't think it makes much sense to do it
though. XEN_DOM0 keeps things tidier now and might be useful later.

> Oh, I forgot CONFIG_XEN_FRONTEND.. And I think that one can also
> become
> a module (ditto for XEN_BACKEND)
> 
> And everytime we did something to those we managed to mess them up so
> we should be dilligient.
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
> 
