From: Quan Xu <quan.xu04@gmail.com>
Subject: [PATCH RFC v3 6/6] KVM guest: introduce smart idle poll algorithm
Date: Mon, 13 Nov 2017 18:27:09 +0800
Message-ID: <1510568829-5645-3-git-send-email-quan.xu0__23301.5008074746$1511414769$gmane$org@gmail.com>
References: <1510568829-5645-1-git-send-email-quan.xu0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1510568829-5645-1-git-send-email-quan.xu0@gmail.com>
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
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Quan Xu <quan.xu0@gmail.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Yang Zhang <yang.zhang.wz@gmail.com>

using smart idle poll to reduce the useless poll when system is idle.

Signed-off-by: Quan Xu <quan.xu0@gmail.com>
Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/kvm.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 2a6e402..8bb6d55 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -37,6 +37,7 @@
 #include <linux/debugfs.h>
 #include <linux/nmi.h>
 #include <linux/swait.h>
+#include <linux/tick.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -365,11 +366,57 @@ static void kvm_guest_cpu_init(void)
 		kvm_register_steal_time();
 }
 
+static unsigned int grow_poll_ns(unsigned int old, unsigned int grow,
+				 unsigned int max)
+{
+	unsigned int val;
+
+	/* set base poll time to 10000ns */
+	if (old == 0 && grow)
+		return 10000;
+
+	val = old * grow;
+	if (val > max)
+		val = max;
+
+	return val;
+}
+
+static unsigned int shrink_poll_ns(unsigned int old, unsigned int shrink)
+{
+	if (shrink == 0)
+		return 0;
+
+	return old / shrink;
+}
+
+static void kvm_idle_update_poll_duration(ktime_t idle)
+{
+	unsigned long poll_duration = this_cpu_read(poll_duration_ns);
+
+	/* so far poll duration is based on nohz */
+	if (idle == -1ULL)
+		return;
+
+	if (poll_duration && idle > paravirt_poll_threshold_ns)
+		poll_duration = shrink_poll_ns(poll_duration,
+					       paravirt_poll_shrink);
+	else if (poll_duration < paravirt_poll_threshold_ns &&
+		 idle < paravirt_poll_threshold_ns)
+		poll_duration = grow_poll_ns(poll_duration, paravirt_poll_grow,
+					     paravirt_poll_threshold_ns);
+
+	this_cpu_write(poll_duration_ns, poll_duration);
+}
+
 static void kvm_idle_poll(void)
 {
 	unsigned long poll_duration = this_cpu_read(poll_duration_ns);
+	ktime_t idle = tick_nohz_get_last_idle_length();
 	ktime_t start, cur, stop;
 
+	kvm_idle_update_poll_duration(idle);
+
 	start = cur = ktime_get();
 	stop = ktime_add_ns(ktime_get(), poll_duration);
 
-- 
1.7.1
