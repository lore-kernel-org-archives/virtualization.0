From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [patch 10/34] Xen-pv_ops: Simplify smp_call_function*() by
	using common implementation
Date: Thu, 15 Mar 2007 19:38:04 -0700
Message-ID: <20070315193804.e8867472.rdunlap@xenotime.net>
References: <20070313233017.933601256@goop.org>
	<20070313233031.149028836@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070313233031.149028836@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Stephane@smtp.osdl.org, Zachary@smtp.osdl.org, Eranian <eranian@hpl.hp.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 13 Mar 2007 16:30:27 -0700 Jeremy Fitzhardinge wrote:

> smp_call_function and smp_call_function_single are almost complete
> duplicates of the same logic.  This patch combines them by
> implementing them in terms of the more general
> smp_call_function_mask().

The kernel-doc is still not quite correct.  Patch below applies
on top of this patch from Jeremy.
---

From: Randy Dunlap <randy.dunlap@oracle.com>

Clean up arch/i386/kernel/smp.c after the Xen pv_ops patches for
smp_call_function variants.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/i386/kernel/smp.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- linux-2621-rc3.orig/arch/i386/kernel/smp.c
+++ linux-2621-rc3/arch/i386/kernel/smp.c
@@ -517,14 +517,14 @@ static struct call_data_struct *call_dat
 =

 =

 /**
- * smp_call_function_mask(): Run a function on a set of other CPUs.
+ * smp_call_function_mask - Run a function on a set of other CPUs.
  * @mask: The set of cpus to run on.  Must not include the current cpu.
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
  * @wait: If true, wait (atomically) until function has completed on other=
 CPUs.
  *
  * Returns 0 on success, else a negative status code. Does not return until
- * remote CPUs are nearly ready to execute <<func>> or are or have finishe=
d.
+ * remote CPUs are nearly ready to execute func() or are or have finished.
  *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
@@ -583,14 +583,14 @@ int smp_call_function_mask(cpumask_t mas
 }
 =

 /**
- * smp_call_function(): Run a function on all other CPUs.
+ * smp_call_function - Run a function on all other CPUs.
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
  * @nonatomic: currently unused.
  * @wait: If true, wait (atomically) until function has completed on other=
 CPUs.
  *
  * Returns 0 on success, else a negative status code. Does not return until
- * remote CPUs are nearly ready to execute <<func>> or are or have execute=
d.
+ * remote CPUs are nearly ready to execute func() or are or have executed.
  *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
@@ -602,8 +602,9 @@ int smp_call_function(void (*func) (void
 }
 EXPORT_SYMBOL(smp_call_function);
 =

-/*
+/**
  * smp_call_function_single - Run a function on another CPU
+ * @cpu: The target (destination) CPU number.
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
  * @nonatomic: Currently unused.
@@ -611,7 +612,7 @@ EXPORT_SYMBOL(smp_call_function);
  *
  * Retrurns 0 on success, else a negative status code.
  *
- * Does not return until the remote CPU is nearly ready to execute <func>
+ * Does not return until the remote CPU is nearly ready to execute func()
  * or is or has executed.
  */
 int smp_call_function_single(int cpu, void (*func) (void *info), void *inf=
o,
