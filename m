From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 01/20] x86/ticketlock: clean up types and accessors
Date: Sat, 13 Nov 2010 17:57:32 +0800
Message-ID: <20101113095732.GF3837__39533.667258411$1289837679$gmane$org@hack>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
	<742be99eb6d64784dbc3e446d22df78b7a55fc0c.1288794124.git.jeremy.fitzhardinge@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <742be99eb6d64784dbc3e446d22df78b7a55fc0c.1288794124.git.jeremy.fitzhardinge@citrix.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Nick Piggin <npiggin@suse.de>, Xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <peterz@infradead.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 03, 2010 at 10:59:42AM -0400, Jeremy Fitzhardinge wrote:
...
> static __always_inline void __ticket_spin_lock(arch_spinlock_t *lock)
> {
>-	int inc = 0x00010000;
>-	int tmp;
>+	unsigned inc = 1 << TICKET_SHIFT;
>+	unsigned tmp;

Please don't use old implicit-int.

> 
>-	return (((tmp >> TICKET_SHIFT) - tmp) & ((1 << TICKET_SHIFT) - 1)) > 1;
>+	return ((tmp.tail - tmp.head) & TICKET_MASK) > 1;


There is a type promotion here.


> }
> 
> #ifndef CONFIG_PARAVIRT_SPINLOCKS
>diff --git a/arch/x86/include/asm/spinlock_types.h b/arch/x86/include/asm/spinlock_types.h
>index dcb48b2..4582640 100644
>--- a/arch/x86/include/asm/spinlock_types.h
>+++ b/arch/x86/include/asm/spinlock_types.h
>@@ -5,11 +5,27 @@
> # error "please don't include this file directly"
> #endif
> 
>+#include <linux/types.h>
>+
>+#if (CONFIG_NR_CPUS < 256)
>+typedef u8  __ticket_t;
>+#else
>+typedef u16 __ticket_t;
>+#endif
>+
>+#define TICKET_SHIFT	(sizeof(__ticket_t) * 8)
>+#define TICKET_MASK	((1 << TICKET_SHIFT) - 1)


So here you may need to cast the result to __ticket_t.


Thanks.
