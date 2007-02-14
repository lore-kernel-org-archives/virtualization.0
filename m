From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Re: [patch 13/21] Xen-paravirt: Add nosegneg
	capability to the vsyscall page notes
Date: Wed, 14 Feb 2007 16:38:46 +1100
Message-ID: <1171431526.19842.108.camel@localhost.localdomain>
References: <20070213221729.772002682@goop.org>
	<20070213221830.466651996@goop.org>  <45D23F97.5040907@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D23F97.5040907@vmware.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-02-13 at 14:45 -0800, Zachary Amsden wrote:
> Jeremy Fitzhardinge wrote:
> > Add the "nosegneg" fake capabilty to the vsyscall page notes. This is
> > used by the runtime linker to select a glibc version which then
> > disables negative-offset accesses to the thread-local segment via
> > %gs. These accesses require emulation in Xen (because segments are
> > truncated to protect the hypervisor address space) and avoiding them
> > provides a measurable performance boost.
> >   
> 
> I don't like this because now a kernel compiled with both CONFIG_XEN and 
> CONFIG_VMI has "nosegneg" turned on.  We don't actually require this for 
> performance or correctness, so it would be nice to be able to 
> dynamically turn it off instead of having it forced.

Ditto for lguest.

Rusty.
