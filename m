From: Matt Wilson <msw@amazon.com>
Subject: Re: [Xen-devel] [PATCH] xen: remove unused Kconfig parameter
Date: Mon, 8 Jul 2013 12:34:59 -0700
Message-ID: <20130708193457.GA6926__49467.7659859464$1373386121$gmane$org@u109add4315675089e695.ant.amazon.com>
References: <1373264904-27053-1-git-send-email-michael.opdenacker@free-electrons.com>
	<20130708192854.GF4927@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130708192854.GF4927@phenom.dumpdata.com>
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
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, Michael Opdenacker <michael.opdenacker@free-electrons.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 08, 2013 at 03:28:54PM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Jul 08, 2013 at 08:28:24AM +0200, Michael Opdenacker wrote:
> > This patch proposes to remove the XEN_PRIVILEGED_GUEST kernel
> > configuration parameter defined in arch/x86/xen/Kconfig, but used
> > nowhere in the makefiles and source code.
> > 
> > This dummy parameter was added 3 years back, and it may
> > make sense to remove it now, as the reasons to use it were not
> > very clear.
> > 
> > Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
> 
> Can't remove it. It is used by grub2.

For reference, here's a related Debian bug report:
  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=633127

Summary: grub2 scripts parse /boot/config-$(uname -r)

--msw

> > ---
> >  arch/x86/xen/Kconfig | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> > index 1a3c765..b6401dc 100644
> > --- a/arch/x86/xen/Kconfig
> > +++ b/arch/x86/xen/Kconfig
> > @@ -19,11 +19,6 @@ config XEN_DOM0
> >  	depends on XEN && PCI_XEN && SWIOTLB_XEN
> >  	depends on X86_LOCAL_APIC && X86_IO_APIC && ACPI && PCI
> >  
> > -# Dummy symbol since people have come to rely on the PRIVILEGED_GUEST
> > -# name in tools.
> > -config XEN_PRIVILEGED_GUEST
> > -	def_bool XEN_DOM0
> > -
> >  config XEN_PVHVM
> >  	def_bool y
> >  	depends on XEN && PCI && X86_LOCAL_APIC
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel
