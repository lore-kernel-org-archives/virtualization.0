From: Quan Xu <quan.xu03@gmail.com>
Subject: [PATCH RFC v3 3/6] sched/idle: Add a generic poll before enter real
	idle path
Date: Mon, 13 Nov 2017 18:06:02 +0800
Message-ID: <1510567565-5118-4-git-send-email-quan.xu0__35694.1366255798$1511414742$gmane$org@gmail.com>
References: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, x86@kernel.org, xen-devel@lists.xenproject.org
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Len Brown <len.brown@intel.com>, Quan Xu <quan.xu0@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, Peter Zijlstra <peterz@infradead.org>, Kyle Huey <me@kylehuey.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Tobias Klauser <tklauser@distanz.ch>
List-Id: virtualization@lists.linuxfoundation.org

From: Yang Zhang <yang.zhang.wz@gmail.com>

Implement a generic idle poll which resembles the functionality
found in arch/. Provide weak arch_cpu_idle_poll function which
can be overridden by the architecture code if needed.

Interrupts arrive which may not cause a reschedule in idle loops.
In KVM guest, this costs several VM-exit/VM-entry cycles, VM-entry
for interrupts and VM-exit immediately. Also this becomes more
expensive than bare metal. Add a generic idle poll before enter
real idle path. When a reschedule event is pending, we can bypass
the real idle path.

Signed-off-by: Quan Xu <quan.xu0@gmail.com>
Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kyle Huey <me@kylehuey.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/process.c |    7 +++++++
 kernel/sched/idle.c       |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c676853..f7db8b5 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -333,6 +333,13 @@ void arch_cpu_idle(void)
 	x86_idle();
 }
 
+#ifdef CONFIG_PARAVIRT
+void arch_cpu_idle_poll(void)
+{
+	paravirt_idle_poll();
+}
+#endif
+
 /*
  * We use this if we don't have any better idle routine..
  */
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 257f4f0..df7c422 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -74,6 +74,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 }
 
 /* Weak implementations for optional arch specific functions */
+void __weak arch_cpu_idle_poll(void) { }
 void __weak arch_cpu_idle_prepare(void) { }
 void __weak arch_cpu_idle_enter(void) { }
 void __weak arch_cpu_idle_exit(void) { }
@@ -219,6 +220,7 @@ static void do_idle(void)
 	 */
 
 	__current_set_polling();
+	arch_cpu_idle_poll();
 	quiet_vmstat();
 	tick_nohz_idle_enter();
 
-- 
1.7.1
