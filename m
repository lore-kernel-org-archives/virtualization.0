From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 5/6] x86: switch config from UNINLINE_SPIN_UNLOCK to
	INLINE_SPIN_UNLOCK
Date: Thu, 30 Apr 2015 12:54:02 +0200
Message-ID: <1430391243-7112-6-git-send-email-jgross__14938.7436140843$1430453298$gmane$org@suse.com>
References: <1430391243-7112-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1430391243-7112-1-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com, jeremy@goop.org, chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, gleb@kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

There is no need any more for a special treatment of _raw_spin_unlock()
regarding inlining compared to the other spinlock functions. Just treat
it like all the other spinlock functions.

Remove selecting UNINLINE_SPIN_UNLOCK in case of PARAVIRT_SPINLOCKS.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/Kconfig                 | 1 -
 include/linux/spinlock_api_smp.h | 2 +-
 kernel/Kconfig.locks             | 7 ++++---
 kernel/Kconfig.preempt           | 3 +--
 kernel/locking/spinlock.c        | 2 +-
 lib/Kconfig.debug                | 1 -
 6 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 226d569..4f85c7e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -666,7 +666,6 @@ config PARAVIRT_DEBUG
 config PARAVIRT_SPINLOCKS
 	bool "Paravirtualization layer for spinlocks"
 	depends on PARAVIRT && SMP
-	select UNINLINE_SPIN_UNLOCK
 	---help---
 	  Paravirtualized spinlocks allow a pvops backend to replace the
 	  spinlock implementation with something virtualization-friendly
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 5344268..839a804 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -69,7 +69,7 @@ _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 #define _raw_spin_trylock_bh(lock) __raw_spin_trylock_bh(lock)
 #endif
 
-#ifndef CONFIG_UNINLINE_SPIN_UNLOCK
+#ifdef CONFIG_INLINE_SPIN_UNLOCK
 #define _raw_spin_unlock(lock) __raw_spin_unlock(lock)
 #endif
 
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 08561f1..9cc5f72 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -87,9 +87,6 @@ config ARCH_INLINE_WRITE_UNLOCK_IRQ
 config ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
 	bool
 
-config UNINLINE_SPIN_UNLOCK
-	bool
-
 #
 # lock_* functions are inlined when:
 #   - DEBUG_SPINLOCK=n and GENERIC_LOCKBREAK=n and ARCH_INLINE_*LOCK=y
@@ -132,6 +129,10 @@ config INLINE_SPIN_LOCK_IRQSAVE
 	def_bool y
 	depends on !GENERIC_LOCKBREAK && ARCH_INLINE_SPIN_LOCK_IRQSAVE
 
+config INLINE_SPIN_UNLOCK
+	def_bool y
+	depends on !PREEMPT || ARCH_INLINE_SPIN_UNLOCK
+
 config INLINE_SPIN_UNLOCK_BH
 	def_bool y
 	depends on ARCH_INLINE_SPIN_UNLOCK_BH
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 3f9c974..6aca8987 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -36,7 +36,6 @@ config PREEMPT_VOLUNTARY
 config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	select PREEMPT_COUNT
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index db3ccb1..0e2b531 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -177,7 +177,7 @@ void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)
 EXPORT_SYMBOL(_raw_spin_lock_bh);
 #endif
 
-#ifdef CONFIG_UNINLINE_SPIN_UNLOCK
+#ifndef CONFIG_INLINE_SPIN_UNLOCK
 void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)
 {
 	__raw_spin_unlock(lock);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1767057..0b4cc3c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -920,7 +920,6 @@ config RT_MUTEX_TESTER
 config DEBUG_SPINLOCK
 	bool "Spinlock and rw-lock debugging: basic checks"
 	depends on DEBUG_KERNEL
-	select UNINLINE_SPIN_UNLOCK
 	help
 	  Say Y here and build SMP to catch missing spinlock initialization
 	  and certain other kinds of spinlock errors commonly made.  This is
-- 
2.1.4
