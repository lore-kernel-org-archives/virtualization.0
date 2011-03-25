From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Re: [PATCH] xen: fix p2m section mismatches
Date: Fri, 25 Mar 2011 11:06:38 -0400
Message-ID: <20110325150638.GH27651__33560.756877023$1301065885$gmane$org@dumpdata.com>
References: <20110324133432.544092e4.randy.dunlap@oracle.com>
	<20110324144802.1def1400@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110324144802.1def1400@nehalam>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, akpm <akpm@linux-foundation.org>, xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 24, 2011 at 02:48:02PM -0700, Stephen Hemminger wrote:
> On Thu, 24 Mar 2011 13:34:32 -0700
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > Fix section mismatch warnings:
> > set_phys_range_identity() is called by __init xen_set_identity(),
> > so also mark set_phys_range_identity() as __init.
> > then:
> > __early_alloc_p2m() is called set_phys_range_identity(), so also mark
> > __early_alloc_p2m() as __init.
> > 
> > WARNING: arch/x86/built-in.o(.text+0x7856): Section mismatch in reference from the function __early_alloc_p2m() to the function .init.text:extend_brk()
> > The function __early_alloc_p2m() references
> > the function __init extend_brk().
> > This is often because __early_alloc_p2m lacks a __init 
> > annotation or the annotation of extend_brk is wrong.
> > 
> > WARNING: arch/x86/built-in.o(.text+0x7967): Section mismatch in reference from the function set_phys_range_identity() to the function .init.text:extend_brk()
> > The function set_phys_range_identity() references
> > the function __init extend_brk().
> > This is often because set_phys_range_identity lacks a __init 
> > annotation or the annotation of extend_brk is wrong.
> > 
> > Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> > ---
> >  arch/x86/xen/p2m.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > --- linux-2.6.38-git13.orig/arch/x86/xen/p2m.c
> > +++ linux-2.6.38-git13/arch/x86/xen/p2m.c
> > @@ -497,7 +497,7 @@ static bool alloc_p2m(unsigned long pfn)
> >  	return true;
> >  }
> >  
> > -bool __early_alloc_p2m(unsigned long pfn)
> > +bool __init __early_alloc_p2m(unsigned long pfn)
> 
> __early_alloc_p2m could be static as well.

<nods> Let me queue it up for rc1. Thanks guys.
