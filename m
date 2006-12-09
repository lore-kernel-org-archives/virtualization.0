From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] no paravirt for X86_VOYAGER or X86_VISWS
Date: Sat, 09 Dec 2006 02:18:26 -0800
Message-ID: <457A8D72.4090909@goop.org>
References: <20061209015131.fc19aeb3.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936590AbWLIKSd@vger.kernel.org>
In-Reply-To: <20061209015131.fc19aeb3.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, akpm <akpm@osdl.org>, chrisw@sous-sol.org, rusty@rustcorp.com.au, zach@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> Since Voyager and Visual WS already define ARCH_SETUP,
> it looks like PARAVIRT shouldn't be offered for them.
>
> In file included from arch/i386/kernel/setup.c:63:
> include/asm-i386/mach-visws/setup_arch.h:8:1: warning: "ARCH_SETUP" redefined
> In file included from include/asm/msr.h:5,
>                  from include/asm/processor.h:17,
>                  from include/asm/thread_info.h:16,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:46,
>                  from arch/i386/kernel/setup.c:26:
> include/asm/paravirt.h:163:1: warning: this is the location of the previous definition
> In file included from arch/i386/kernel/setup.c:63:
> include/asm-i386/mach-visws/setup_arch.h:8:1: warning: "ARCH_SETUP" redefined
> In file included from include/asm/msr.h:5,
>                  from include/asm/processor.h:17,
>                  from include/asm/thread_info.h:16,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/capability.h:45,
>                  from include/linux/sched.h:46,
>                  from arch/i386/kernel/setup.c:26:
> include/asm/paravirt.h:163:1: warning: this is the location of the previous definition
>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  arch/i386/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-2.6.19-git13.orig/arch/i386/Kconfig
> +++ linux-2.6.19-git13/arch/i386/Kconfig
> @@ -190,6 +190,7 @@ endchoice
>  config PARAVIRT
>  	bool "Paravirtualization support (EXPERIMENTAL)"
>  	depends on EXPERIMENTAL
> +	depends on !(X86_VISWS || X86_VOYAGER)
>  	help
>  	  Paravirtualization is a way of running multiple instances of
>  	  Linux on the same machine, under a hypervisor.  This option
>   

ACK.  At some point paravirt may subsume subarches, but for now it is
only supported on standard PC-style hardware.

    J
