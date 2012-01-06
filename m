From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [Xen-devel] [PATCH 3/4] xen kconfig: add dom0 support help text
Date: Fri, 6 Jan 2012 09:55:43 +0000
Message-ID: <1325843743.25206.438.camel@zakaz.uk.xensource.com>
References: <5a67dfb3-fab0-4792-ba17-95f0934cf7af@zmail13.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5a67dfb3-fab0-4792-ba17-95f0934cf7af@zmail13.collab.prod.int.phx2.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Jones <drjones@redhat.com>
Cc: "jeremy@goop.org" <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2012-01-06 at 09:26 +0000, Andrew Jones wrote:
> 
> ----- Original Message -----
> > On Fri, 2012-01-06 at 08:57 +0000, Andrew Jones wrote:
> > > Describe dom0 support in the config menu and supply help text for
> > > it.
> > 
> > This turns a non-user visible symbol into a user visible one.
> > Previously
> > if Xen was enabled and the other prerequisites were met you would get
> > dom0 support automatically -- do we really want to change that?
> > According to 6b0661a5e6fbf it was a deliberate decision to have it
> > this
> > way.
> 
> I think it's a necessary evil in order to give users the ability to
> compile kernels without the support. I know it doesn't make much sense
> for most users, but...

Who actually wants to do this though and why? Do you have a bug report
requesting this change?

Almost all of the things which dom0 needs (e.g. PCI device management
etc) is also required by a domU with passthrough enabled so the savings
are really very slight.

We are talking less than 1k of code AFAICT, 319 bytes for
arch/x86/xen/vga.o and 573 for drivers/xen/xenfs/xenstored.o plus
whatever xen_register_gsi (a couple of dozen lines of code) adds to
arch/x86/pci/xen.o. grep doesn't show CONFIG_XEN_DOM0 being used
anywhere else. What savings do you see in practice from disabling just
this symbol?

We need to weigh up the size change against the complexity of asking the
user yet another question, I'm not convinced the question is worth it on
balance.

> > 
> > BTW, you forgot a Signed-off-by and the appropriate CCs (please use
> > MAINTAINERS or ./scripts/get-maintainer.pl).
> > 
> 
> Sorry, I'll resend properly.

I've added those CC's to this reply too.

Ian.

> 
> Drew
> 
> > Ian.
> > 
> > > ---
> > >  arch/x86/xen/Kconfig |    7 ++++++-
> > >  1 files changed, 6 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> > > index 26c731a..88862d5 100644
> > > --- a/arch/x86/xen/Kconfig
> > > +++ b/arch/x86/xen/Kconfig
> > > @@ -14,9 +14,14 @@ config XEN
> > >  	  Xen hypervisor.
> > >  
> > >  config XEN_DOM0
> > > -	def_bool y
> > > +	bool "Xen Initial Domain (Dom0) support"
> > > +	default y
> > >  	depends on XEN && PCI_XEN && SWIOTLB_XEN
> > >  	depends on X86_LOCAL_APIC && X86_IO_APIC && ACPI && PCI
> > > +	help
> > > +	  This allows the kernel to be used for the initial Xen domain,
> > > +	  Domain0. This is a privileged guest that supplies backends
> > > +	  and is used to manage the other Xen domains.
> > >  
> > >  # Dummy symbol since people have come to rely on the
> > >  PRIVILEGED_GUEST
> > >  # name in tools.
> > 
> > 
> > 
