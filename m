From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 11/15] ia64/pv_ops: paravirtualize NR_IRQS
Date: Thu, 24 Apr 2008 21:21:44 +0900
Message-ID: <20080424122144.GE15640%yamahata__5926.87975517965$1209039914$gmane$org@valinux.co.jp>
References: <1207716548202-git-send-email-yamahata@valinux.co.jp>
	<1207716549755-git-send-email-yamahata@valinux.co.jp>
	<yq08wz6l0jd.fsf@jaguar.mkp.net>
	<20080422101113.GH28863%yamahata@valinux.co.jp>
	<480DD4A7.9020207@sgi.com>
	<20080423025414.GA7679%yamahata@valinux.co.jp>
	<480F41CE.3000803@sgi.com>
	<20080424111913.GB15640%yamahata@valinux.co.jp>
	<48107474.8010400@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <48107474.8010400@sgi.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jes Sorensen <jes@sgi.com>
Cc: eddie.dong@intel.com, xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 24, 2008 at 01:52:20PM +0200, Jes Sorensen wrote:

> >+/*
> >+ * PARAVIRT_NR_IRQS is defined by asm-offsets.c as
> >+ * max(IA64_NATIVE_NR_IRQS, XEN_NR_IRQS, ...) depending on config.
> >+ */
> >+#ifndef ASM_OFFSETS_C
> >+#include <asm/asm-offsets.h>
> >+#define NR_IRQS	PARAVIRT_NR_IRQS
> > #endif
> > 
> > static __inline__ int
> 
> Shouldn't this be defined as IA64_NATIVE_NR_IRQS?

I eliminated this hunk completly.

> I wouldn't do the
> #ifndef ASM_OFFSETS_C part, you should be able to just include it
> unconditionally.

Still two ASM_OFFSET_C remain, but I couldn't find
a way to sort out deep header inclusion dependency.
Without them, asm-offset.c doesn't compile.


From c101e113912a4bbc117b4d93e215169a55581602 Mon Sep 17 00:00:00 2001
From: Isaku Yamahata <yamahata@valinux.co.jp>
Date: Thu, 24 Apr 2008 21:02:26 +0900
Subject: ia64/pv_ops: paravirtualize NR_IRQS

Make NR_IRQ overridable by each pv instances.
Pv instance may need each own number of irqs so that
NR_IRQS should be the maximum number of nr_irqs each
pv instances need.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/kernel/asm-offsets.c |   18 ++++++++++++++++++
 include/asm-ia64/hardirq.h     |    4 +++-
 include/asm-ia64/irq.h         |    4 ++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/kernel/asm-offsets.c b/arch/ia64/kernel/asm-offsets.c
index 230a6f9..08a09e3 100644
--- a/arch/ia64/kernel/asm-offsets.c
+++ b/arch/ia64/kernel/asm-offsets.c
@@ -10,6 +10,7 @@
 #include <linux/pid.h>
 #include <linux/clocksource.h>
 
+#include <asm-ia64/irq.h>
 #include <asm-ia64/processor.h>
 #include <asm-ia64/ptrace.h>
 #include <asm-ia64/siginfo.h>
@@ -291,4 +292,21 @@ void foo(void)
 		offsetof (struct itc_jitter_data_t, itc_jitter));
 	DEFINE(IA64_ITC_LASTCYCLE_OFFSET,
 		offsetof (struct itc_jitter_data_t, itc_lastcycle));
+	BLANK();
+
+	{
+		/*
+		 * calculate
+		 * max(IA64_NATIVE_NR_IRQS, XEN_NR_IRQS, FOO_NR_IRQS...)
+		 * depending on config.
+		 */
+		union paravirt_nr_irqs_max {
+			char ia64_native_nr_irqs[IA64_NATIVE_NR_IRQS];
+#ifdef CONFIG_XEN
+			char xen_nr_irqs[XEN_NR_IRQS];
+#endif
+		};
+
+		DEFINE(NR_IRQS, sizeof (union paravirt_nr_irqs_max));
+	}
 }
diff --git a/include/asm-ia64/hardirq.h b/include/asm-ia64/hardirq.h
index 140e495..7ee7626 100644
--- a/include/asm-ia64/hardirq.h
+++ b/include/asm-ia64/hardirq.h
@@ -8,7 +8,9 @@
 
 
 #include <linux/threads.h>
+#ifndef ASM_OFFSETS_C
 #include <linux/irq.h>
+#endif
 
 #include <asm/processor.h>
 
@@ -26,7 +28,7 @@
  * The hardirq mask has to be large enough to have space for potentially all IRQ sources
  * in the system nesting on a single CPU:
  */
-#if (1 << HARDIRQ_BITS) < NR_IRQS
+#if !defined (ASM_OFFSETS_C) && ((1 << HARDIRQ_BITS) < NR_IRQS)
 # error HARDIRQ_BITS is too low!
 #endif
 
diff --git a/include/asm-ia64/irq.h b/include/asm-ia64/irq.h
index a66d268..60e4c1d 100644
--- a/include/asm-ia64/irq.h
+++ b/include/asm-ia64/irq.h
@@ -17,9 +17,9 @@
 #define NR_VECTORS	256
 
 #if (NR_VECTORS + 32 * NR_CPUS) < 1024
-#define NR_IRQS (NR_VECTORS + 32 * NR_CPUS)
+#define IA64_NATIVE_NR_IRQS (NR_VECTORS + 32 * NR_CPUS)
 #else
-#define NR_IRQS 1024
+#define IA64_NATIVE_NR_IRQS 1024
 #endif
 
 static __inline__ int
-- 
1.5.3



-- 
yamahata
