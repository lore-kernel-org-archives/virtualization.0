From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 24/28] ia64/xen: time paravirtualization
Date: Fri, 22 Feb 2008 12:57:42 +0900
Message-ID: <20080222035742.GC2406%yamahata__40289.8514447317$1203652803$gmane$org@valinux.co.jp>
References: <20080221091731.641745000@ls.local.valinux.co.jp>
	<20080221091906.007909000@ls.local.valinux.co.jp>
	<47BE0508.7080203@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47BE0508.7080203@goop.org>
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
Cc: virtualization@lists.linux-foundation.org, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 21, 2008 at 03:11:04PM -0800, Jeremy Fitzhardinge wrote:
> yamahata@valinux.co.jp wrote:
> >diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
> >index 17fda52..1bb0362 100644
> >--- a/arch/ia64/kernel/time.c
> >+++ b/arch/ia64/kernel/time.c
> >@@ -29,6 +29,14 @@
> > #include <asm/sections.h>
> > #include <asm/system.h>
> > 
> >+#include <asm/xen/hypervisor.h>
> >+#ifdef CONFIG_XEN
> >+#include <linux/kernel_stat.h>
> >+#include <linux/posix-timers.h>
> >+#include <xen/interface/vcpu.h>
> >+#include <asm/percpu.h>
> >+#endif
> >+
> 
> ia64 doesn't use clocksources yet?  Couldn't you share a lot of this 
> with the 32-bit Xen time code (esp stolen time accounting)?

It does. I'll look into sharing code.
(Probably after cpu paravirtualization)

-- 
yamahata
