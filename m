From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] tools/virtio: add ringtest utilities
Date: Fri, 22 Jan 2016 13:53:05 +0100
Message-ID: <20160122135305.3b708888.cornelia.huck@de.ibm.com>
References: <1453380639-10459-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1453380639-10459-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 21 Jan 2016 14:52:32 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:


> +#if defined(__x86_64__) || defined(__i386__)
> +#include "x86intrin.h"
> +
> +static inline void wait_cycles(unsigned long long cycles)
> +{
> +	unsigned long long t;
> +
> +	t = __rdtsc();
> +	while (__rdtsc() - t < cycles) {}
> +}
> +
> +#define VMEXIT_CYCLES 500
> +#define VMENTRY_CYCLES 500

#elif defined(__s390x__)
static inline void wait_cycles(unsigned long long cycles)
{
	asm volatile("0: brctg %0,0b" : : "d" (cycles));
}

/* tweak me */
#define VMEXIT_CYCLES 200
#define VMENTRY_CYCLES 200

Values are probably off...

> +
> +#else
> +static inline void wait_cycles(unsigned long long cycles)
> +{
> +	_Exit(5);
> +}
> +#define VMEXIT_CYCLES 0
> +#define VMENTRY_CYCLES 0
> +#endif

> +/* Compiler barrier - similar to what Linux uses */
> +#define barrier() asm volatile("" ::: "memory")
> +
> +/* Is there a portable way to do this? */
> +#if defined(__x86_64__) || defined(__i386__)
> +#define cpu_relax() asm ("rep; nop" ::: "memory")
> +#else
> +#define cpu_relax() assert(0)

Fall back to barrier() instead?

> +#endif

> diff --git a/tools/virtio/ringtest/run-on-all.sh b/tools/virtio/ringtest/run-on-all.sh
> new file mode 100755
> index 0000000..52b0f71
> --- /dev/null
> +++ b/tools/virtio/ringtest/run-on-all.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +
> +#use last CPU for host. Why not the first?
> +#many devices tend to use cpu0 by default so
> +#it tends to be busier
> +HOST_AFFINITY=$(cd /dev/cpu; ls|grep -v '[a-z]'|sort -n|tail -1)
> +
> +#run command on all cpus
> +for cpu in $(cd /dev/cpu; ls|grep -v '[a-z]'|sort -n);

How portable is /dev/cpu/? Maybe look in sysfs instead?

> +do
> +	#Don't run guest and host on same CPU
> +	#It actually works ok if using signalling
> +	if
> +		(echo "$@" | grep -e "--sleep" > /dev/null) || \
> +			test $HOST_AFFINITY '!=' $cpu
> +	then
> +		echo "GUEST AFFINITY $cpu"
> +		"$@" --host-affinity $HOST_AFFINITY --guest-affinity $cpu
> +	fi
> +done
> +echo "NO GUEST AFFINITY"
> +"$@" --host-affinity $HOST_AFFINITY
> +echo "NO AFFINITY"
> +"$@"

It did not die on me for a basic (affinityless) run on s390. Let's see
if I find time to look at the actual ring code next week.
