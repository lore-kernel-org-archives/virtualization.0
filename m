From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 00/21] Xen-paravirt: Xen guest
 implementation for paravirt_ops interface
Date: Fri, 16 Feb 2007 15:49:32 -0800
Message-ID: <45D6430C.4030403@goop.org>
References: <20070216022449.739760547@goop.org>
	<Pine.LNX.4.64.0702161244380.26718@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <Pine.LNX.4.64.0702161244380.26718@schroedinger.engr.sgi.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Christoph Lameter wrote:
> I am thoroughly confused. Maybe that is because I have not been following 
> this issue closely but it seems that you are using the paravirt interface 
> as an API for Xen code in the guest? I thought the idea of paravirt was to 
> have an API that is generic? This patchset seems to be mostly realizing 
> Xen specific functionality? How does the code here interact with KVM, 
> VMWare and other hypervisors?

There are two things in this patch series: generic kernel changes, and
the core bits of Xen itself.

The earlier part of the patch contains changes to the core kernel which
are needed for Xen, but are generally harmless to non-paravirt use, or
to being virtualized under other hypervisors.   In some cases these are
plain bugfixes (like dealing with absent vga hardware), or things which
have become parameterised (like the pgd alignment, or whether we share
the kernel pmd in PAE mode).

But there are also extensions to the paravirt_ops interface.  The
largest of these is adding the appropriate hooks for
non-shadowed-pagetable hypervisors.  While Xen is the only example of
this at the moment, its not a Xen-specific set of hooks.  It allows a
hypervisor backend to have detailed control over what actually gets put
into pagetables; in Xen's case this means we can convert the kernel's
pseudo-physical addresses into machine addresses, but you could imagine
a hypervisor maintaining some other structure in parallel with the
pagetable or something like that.  An analogy would be extending the IO
DMA interfaces to account for an IOMMU, even if only one hardware
platform actually has an IOMMU.

The latter part of the series is basically pure Xen-specifc stuff, which
is almost entirely restricted to Xen-specific parts of the tree.  This
code introduces a number of new Xen-specific interfaces, but they're
completely distinct from paravirt_ops.

    J
