From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/5] Add structs and functions for paravirt clocksource.
Date: Tue, 03 Jun 2008 14:34:05 +0100
Message-ID: <4845484D.7000202@goop.org>
References: <1212498439-1283-1-git-send-email-kraxel@redhat.com>
	<1212498439-1283-2-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1212498439-1283-2-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.osdl.org, kvm-owner@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> +/*
> + * These structs MUST NOT be changed.
> + * They are the ABI between hypervisor and guest OS.
> + * Both Xen and KVM are using this.
> + *
> + * pvclock_vcpu_time_info holds the system time and the tsc timestamp
> + * of the last update. So the guest can use the tsc delta to get a
> + * more precise system time.
>   

You should note that these are per-cpu parameters.

> + *
> + * pvclock_wall_clock references the point in time when the system
> + * time was zero (usually boot time), thus the guest calculates the
> + * current wall clock by adding the system time.
> + *
> + * Protocol for the "version" fields is: hypervisor raises it (making
> + * it uneven) before it starts updating the fields and raises it again
> + * (making it even) when it is done.  Thus the guest can make sure the
> + * time values it got are consistent by checking the version before
> + * and after reading them.
> + */
> +
> +struct pvclock_vcpu_time_info {
> +	uint32_t version;
>   

Use the standard u32/u64 I think (or the __u32 forms, maybe).

> +	uint32_t pad0;
> +	uint64_t tsc_timestamp;
> +	uint64_t system_time;
> +	uint32_t tsc_to_system_mul;
> +	int8_t   tsc_shift;
> +	int8_t	 pad[3];
> +} __attribute__((__packed__)); /* 32 bytes */
> +
> +struct pvclock_wall_clock {
> +	uint32_t version;
> +	uint32_t sec;
> +	uint32_t nsec;
> +} __attribute__((__packed__));
> +
> +#endif /* __ASSEMBLY__ */
> +#endif /* _ASM_X86_PVCLOCK_ABI_H_ */
> diff --git a/include/asm-x86/pvclock.h b/include/asm-x86/pvclock.h
> new file mode 100644
> index 0000000..85b1bba
> --- /dev/null
> +++ b/include/asm-x86/pvclock.h
> @@ -0,0 +1,13 @@
> +#ifndef _ASM_X86_PVCLOCK_H_
> +#define _ASM_X86_PVCLOCK_H_
> +
> +#include <linux/clocksource.h>
> +#include <asm/pvclock-abi.h>
> +
> +/* some helper functions for xen and kvm pv clock sources */
> +cycle_t pvclock_clocksource_read(struct pvclock_vcpu_time_info *src);
> +void pvclock_read_wallclock(struct pvclock_wall_clock *wall,
> +			    struct pvclock_vcpu_time_info *vcpu,
> +			    struct timespec *ts);
> +
> +#endif /* _ASM_X86_PVCLOCK_H_ */
>   
