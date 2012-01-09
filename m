From: Andrew Jones <drjones@redhat.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove CONFIG_XEN_DOM0 compile option
Date: Mon, 09 Jan 2012 05:37:33 -0500 (EST)
Message-ID: <d6148ae9-932e-4fba-947e-ee70b2e25fd2@zmail13.collab.prod.int.phx2.redhat.com>
References: <alpine.DEB.2.00.1201061648440.3150@kaball-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1201061648440.3150@kaball-desktop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, konrad wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



----- Original Message -----
> On Fri, 6 Jan 2012, Andrew Jones wrote:
> > XEN_DOM0 is a silent option that has been automatically selected
> > when
> > CONFIG_XEN is selected since 6b0661a5e6fbf. If this option was
> > changed
> > to a menu configurable option then it would only give users the
> > ability
> > to compile out about 100 kbytes of code.
> 
> I think that it is less than that because backends are not tied to
> dom0
> in any way, even though currently they cannot be compiled without
> XEN_DOM0.
> Running a network or block backend in domU is a well known
> configuration.
> Therefore the code compiled out only amounts to about 10K.
> 
> 
> > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > index 8795480..0725228 100644
> > --- a/drivers/xen/Kconfig
> > +++ b/drivers/xen/Kconfig
> > @@ -78,8 +78,9 @@ config XEN_DEV_EVTCHN
> >  
> >  config XEN_BACKEND
> >  	bool "Backend driver support"
> > -	depends on XEN_DOM0
> >  	default y
> > +	depends on XEN && PCI_XEN && SWIOTLB_XEN
> > +	depends on X86_LOCAL_APIC && X86_IO_APIC && ACPI && PCI
> >  	help
> >  	  Support for backend device drivers that provide I/O services
> >  	  to other virtual machines.
> 
> I think we can trimmer the dependency list here: after all backends
> can
> be run in unpriviledged guests as well (see driver domains).
> So I think it should depend only on XEN.

Hmm.. Actually, with dependency lists in mind, I think a really messed
this patch up. I should have either had CONFIG_XEN inherit these deps,
or I should have spread them around to be required at only the specific
places they're needed, and then left the stub functions in. Neither of
those options seems like a good idea to me. We either force all XEN
guests to always have all the deps needed for an initial domain, which
is exactly the opposite of the suggestion above (trimming XEN_BACKEND
deps for driver domains), or we actually make the code messier and
more complicated with more #ifdefs, which are now neatly packaged with
XEN_DOM0.

The driver domain concept may actually be the technical need for
making XEN_DOM0 optional. If we want the ability to build a minimally
configed XEN kernel to be used as a driver domain, then it doesn't
seem like we'd want it to also be capable of running as an initial
domain, or to be forced to have all the dependencies and code of an
initial domain.

With that in mind, I propose we go back to my initial patch, relax
deps for XEN_BACKEND, and double check that each individual backend
has the appropriate minimal deps. In general, it should be a goal to
make sure most XEN options are menu selectable and that all dep lists
are minimized in order to make sure driver domains can be built with
minimal configs.

Drew

> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
> 
