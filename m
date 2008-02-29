From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 0/5] RFC: ia64/pv_ops: ia64 intrinsics paravirtualization
Date: Fri, 29 Feb 2008 11:45:49 +0900
Message-ID: <20080229024549.GB11349%yamahata__44813.8021900833$1204253376$gmane$org@valinux.co.jp>
References: <12041926372068-git-send-email-yamahata@valinux.co.jp>
	<10EA09EFD8728347A513008B6B0DA77A02D767E9@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <10EA09EFD8728347A513008B6B0DA77A02D767E9@pdsmsx411.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Dong, Eddie" <eddie.dong@intel.com>
Cc: virtualization@lists.linux-foundation.org, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 29, 2008 at 01:21:27AM +0800, Dong, Eddie wrote:

> > * Option 4: indirect function call
> > The code would look like
> >         struct pv_cpu_ops {
> >                 unsigned long (*get_cpuid)(unsigned long index)
> >                 ....
> >         };
> >         extern struct pv_cpu_ops pv_cpu_ops;
> >         ...
> >         static inline unsigned long
> >         paravirt_get_cpuid(unsigned long index)
> >         {
> >                 return pv_cpu_ops->get_cpuid(index);
> >         }
> >         #define ia64_get_cpuid  paravirt_get_cpuid
> > 
> >   Pros:
> >   - Binary patch isn't required.
> >   - indirect function call is the very way x86 pv_ops adopted.
> >   - If hypervisor supports fast hypercall using gate page,
> >     it may want to use function call.
> > 
> >   Cons:
> >   - Binary patch is difficult.
> >     ia64 function call uses stacked registers, so that marking br.call
> >     instruction is difficult.
> >   - so that the performance is suboptimal especially for native case.
> > 
> 
> I am not sure if this statement is true. We can still patching it. For
> example
> using same inline asm code for paravirt_get_cpuid definition and it
> could be
> exactly same with X86.

Stacked registers must be allocated by alloc instruction.
And it is issued in caller function's prologue. I.e. gcc maintains
how many local registers (sol) and output output registers (sof - sol)
are used.
So if we call function from inline assembly, we have to tell to gcc 
how many output registers are used. I haven't found the way to do
that.
On the other hand On x86, just telling clobbered registers is okay.

Even if we find the way to tell it to gcc, the next issue it how to
determin how many local registers (sol).
In assembler source code we can refer function arguments as out0...,
but when binary patching we have to determin its register number.

-- 
yamahata
