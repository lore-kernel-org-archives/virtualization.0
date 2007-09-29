From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [kvm-devel] [RFC] KVM Source layout Proposal to accommodate new
	CPU architecture
Date: Sat, 29 Sep 2007 16:25:02 +0200
Message-ID: <20070929142502.GA18388__17740.5298025862$1191251589$gmane$org@uranus.ravnborg.org>
References: <42DFA526FC41B1429CE7279EF83C6BDC753A4E@pdsmsx415.ccr.corp.intel.com>
	<46FB7566.9030504@qumranet.com>
	<1191071211.26950.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1191071211.26950.28.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel@lists.sourceforge.net, "Zhang, Xiantao" <xiantao.zhang@intel.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty.

On Sat, Sep 29, 2007 at 11:06:51PM +1000, Rusty Russell wrote:
> On Thu, 2007-09-27 at 11:18 +0200, Avi Kivity wrote:
> > The whole drivers/kvm/ thing was just a trick to get merged quickly.  I
> > think the new layout should be something like
> > 
> >   virt/kvm/, include/linux/kvm*.h -> common code
> >   virt/lguest/ -> the other hypervisor
> >   virt/virtio/ -> shared I/O infrastructure
> >   virt/ -> the CONFIG_VIRTIALIZATION menu
> >   arch/x86/kvm/, include/asm-x86/ -> x86 specific code
> >   arch/ia64/kvm/, include/asm-ia64/ -> ia64 specific code
> 
> The problem with this separation is that module source cannot span
> directories (at least, not that I could find).

That's supported but not in the most elegant fashion.
In your Makefile in the top-level directory
just specify the relevant .o files in the subdirectories.
So you would have:
lguest-y := file.o
lguest-y += dir/foo.o
lguest-y += dir2/bar.o

obj-$(CONFIG_...) := lguset.o

If you have trouble making this work drop me a mail and I
will try to help with a more specific example.

	Sam
