From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [patch 02/11] x86/time: Implement clocksource_arch_init()
Date: Fri, 14 Sep 2018 17:45:06 +0200
Message-ID: <87zhwk6q2l.fsf__39936.3908487887$1536939793$gmane$org@vitty.brq.redhat.com>
References: <20180914125006.349747096@linutronix.de>
	<20180914125118.293161327@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180914125118.293161327@linutronix.de> (Thomas Gleixner's
	message of "Fri, 14 Sep 2018 14:50:08 +0200")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Runtime validate the VCLOCK_MODE in clocksource::archdata and disable
> VCLOCK if invalid, which disables the VDSO but keeps the system running.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/Kconfig       |    1 +
>  arch/x86/kernel/time.c |   16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
>
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -48,6 +48,7 @@ config X86
>  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>  	select ANON_INODES
>  	select ARCH_CLOCKSOURCE_DATA
> +	select ARCH_CLOCKSOURCE_INIT
>  	select ARCH_DISCARD_MEMBLOCK
>  	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
>  	select ARCH_HAS_DEBUG_VIRTUAL
> --- a/arch/x86/kernel/time.c
> +++ b/arch/x86/kernel/time.c
> @@ -10,6 +10,7 @@
>   *
>   */
>
> +#include <linux/clocksource.h>
>  #include <linux/clockchips.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -105,3 +106,18 @@ void __init time_init(void)
>  {
>  	late_time_init = x86_late_time_init;
>  }
> +
> +/*
> + * Sanity check the vdso related archdata content.
> + */
> +void clocksource_arch_init(struct clocksource *cs)
> +{
> +	if (cs->archdata.vclock_mode == VCLOCK_NONE)
> +		return;
> +
> +	if (cs->archdata.vclock_mode >= VCLOCK_MAX) {

It should be '>' as VCLOCK_MAX == VCLOCK_HVCLOCK == 3

> +		pr_warn("clocksource %s registered with invalid vclock_mode %d. Disabling vclock.\n",
> +			cs->name, cs->archdata.vclock_mode);
> +		cs->archdata.vclock_mode = VCLOCK_NONE;
> +	}
> +}

-- 
  Vitaly
