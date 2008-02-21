From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 19/28] ia64/xen: xen domU irq chip introducing some helper
	functions, xen_send_ipi.
Date: Thu, 21 Feb 2008 15:22:54 -0800
Message-ID: <47BE07CE.5090008__46701.935659121$1203636483$gmane$org@goop.org>
References: <20080221091731.641745000@ls.local.valinux.co.jp>
	<20080221091904.517166000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080221091904.517166000@ls.local.valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: yamahata@valinux.co.jp
Cc: virtualization@lists.linux-foundation.org, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

yamahata@valinux.co.jp wrote:
> diff --git a/arch/ia64/kernel/irq_ia64.c b/arch/ia64/kernel/irq_ia64.c
> index 0b52f19..b5dcb49 100644
> --- a/arch/ia64/kernel/irq_ia64.c
> +++ b/arch/ia64/kernel/irq_ia64.c
> @@ -30,6 +30,9 @@
>  #include <linux/threads.h>
>  #include <linux/bitops.h>
>  #include <linux/irq.h>
> +#ifdef CONFIG_XEN
> +#include <linux/cpu.h>
> +#endif
>  
>  #include <asm/delay.h>
>  #include <asm/intrinsics.h>
> @@ -204,6 +207,13 @@ assign_irq_vector (int irq)
>  
>  	vector = -ENOSPC;
>  
> +#ifdef CONFIG_XEN
> +	if (is_running_on_xen()) {
> +		extern int xen_assign_irq_vector(int);
> +		return xen_assign_irq_vector(irq);
> +	}
> +#endif
>   

No extern prototypes in .c files; definitely not nested in block scope 
(here and elsewhere in the series).

> +static char timer_name[NR_CPUS][15];
> +static char ipi_name[NR_CPUS][15];
> +static char resched_name[NR_CPUS][15];
> +static char cmc_name[NR_CPUS][15];
> +static char cmcp_name[NR_CPUS][15];
> +static char cpep_name[NR_CPUS][15];

Why not use percpu?

> +/* FIXME: There's no obvious point to check whether slab is ready. So
> + * a hack is used here by utilizing a late time hook.
> + */
Could you hook onto paravirt_post_allocator_init()?

    J
