From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/5] x86/vmware: Steal time accounting support
Date: Fri, 13 Mar 2020 14:17:42 +0100
Message-ID: <20200313131742.GA8142@zn.tnic>
References: <20200212200312.2033-1-amakhalov@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200212200312.2033-1-amakhalov@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Alexey Makhalov <amakhalov@vmware.com>
Cc: Juergen Gross <jgross@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "VMware, Inc." <pv-drivers@vmware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 12, 2020 at 08:03:07PM +0000, Alexey Makhalov wrote:
> Hello,
> 
> This patchset introduces steal time accounting support for
> the VMware guest. The idea and implementation of guest
> steal time support is similar to KVM ones and it is based
> on steal clock. The steal clock is a per CPU structure in
> a shared memory between hypervisor and guest, initialized
> by each CPU through hypercall. Steal clock is got updated
> by the hypervisor and read by the guest. 
> 
> The patchset consists of 5 items:
> 
> 1. x86/vmware: Make vmware_select_hypercall() __init
> Minor clean up.
> 
> 2. x86/vmware: Remove vmware_sched_clock_setup()
> Preparation for the main patch.
> 
> 3. x86/vmware: Steal time clock for VMware guest
> Core steal time support functionality.
> 
> 4. x86/vmware: Enable steal time accounting
> Support for steal time accounting used by update_rq_clock().
> 
> 5. x86/vmware: Use bool type for vmw_sched_clock
> Minor clean up.
> 
> Alexey Makhalov (5):
>   x86/vmware: Make vmware_select_hypercall() __init
>   x86/vmware: Remove vmware_sched_clock_setup()
>   x86/vmware: Steal time clock for VMware guest
>   x86/vmware: Enable steal time accounting
>   x86/vmware: Use bool type for vmw_sched_clock
> 
>  Documentation/admin-guide/kernel-parameters.txt |   2 +-
>  arch/x86/kernel/cpu/vmware.c                    | 227 +++++++++++++++++++++++-
>  2 files changed, 220 insertions(+), 9 deletions(-)

$ make ARCH=i386 allyesconfig
$ make ARCH=i386

  ...

  AR      drivers/net/built-in.a
  AR      drivers/built-in.a
  GEN     .version
  CHK     include/generated/compile.h
  LD      vmlinux.o
ld: arch/x86/kernel/kvm.o:(.discard+0x2): multiple definition of `__pcpu_unique_steal_time'; arch/x86/kernel/cpu/vmware.o:(.discard+0x0): first defined here
make: *** [Makefile:1078: vmlinux] Error 1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
