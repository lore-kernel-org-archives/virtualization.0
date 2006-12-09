From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] no paravirt for X86_VOYAGER or X86_VISWS
Date: Sat, 9 Dec 2006 13:45:18 -0800
Message-ID: <20061209214518.GW1397@sequoia.sous-sol.org>
References: <20061209015131.fc19aeb3.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758067AbWLIVlQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061209015131.fc19aeb3.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org, akpm <akpm@osdl.org>, chrisw@sous-sol.org, rusty@rustcorp.com.au, jeremy@goop.org, zach@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

* Randy Dunlap (randy.dunlap@oracle.com) wrote:
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

Acked-by: Chris Wright <chrisw@sous-sol.org>
