From: Quan Xu <quan.xu04@gmail.com>
Subject: [PATCH RFC v3 5/6] tick: get duration of the last idle loop
Date: Mon, 13 Nov 2017 18:27:08 +0800
Message-ID: <1510568829-5645-2-git-send-email-quan.xu0__28207.9559904107$1511414764$gmane$org@gmail.com>
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
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Quan Xu <quan.xu0@gmail.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Quan Xu <quan.xu0@gmail.com>

the last idle loop is from tick_nohz_idle_enter to tick_nohz_idle_exit.

Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
Signed-off-by: Quan Xu <quan.xu0@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/tick.h     |    2 ++
 kernel/time/tick-sched.c |   11 +++++++++++
 kernel/time/tick-sched.h |    3 +++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index cf413b3..77ae46d 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -118,6 +118,7 @@ enum tick_dep_bits {
 extern void tick_nohz_idle_exit(void);
 extern void tick_nohz_irq_exit(void);
 extern ktime_t tick_nohz_get_sleep_length(void);
+extern ktime_t tick_nohz_get_last_idle_length(void);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
@@ -127,6 +128,7 @@ enum tick_dep_bits {
 static inline void tick_nohz_idle_enter(void) { }
 static inline void tick_nohz_idle_exit(void) { }
 
+static ktime_t tick_nohz_get_last_idle_length(void) { return -1; }
 static inline ktime_t tick_nohz_get_sleep_length(void)
 {
 	return NSEC_PER_SEC / HZ;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c7a899c..65c9cc0 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -548,6 +548,7 @@ static void tick_nohz_update_jiffies(ktime_t now)
 		else
 			ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
 		ts->idle_entrytime = now;
+		ts->idle_length = delta;
 	}
 
 	if (last_update_time)
@@ -998,6 +999,16 @@ void tick_nohz_irq_exit(void)
 }
 
 /**
+ * tick_nohz_get_last_idle_length - return the length of the last idle loop
+ */
+ktime_t tick_nohz_get_last_idle_length(void)
+{
+	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+
+	return ts->idle_length;
+}
+
+/**
  * tick_nohz_get_sleep_length - return the length of the current sleep
  *
  * Called from power state control code with interrupts disabled
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 954b43d..2630cf9 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -39,6 +39,8 @@ enum tick_nohz_mode {
  * @idle_sleeptime:	Sum of the time slept in idle with sched tick stopped
  * @iowait_sleeptime:	Sum of the time slept in idle with sched tick stopped, with IO outstanding
  * @sleep_length:	Duration of the current idle sleep
+ * @idle_length:	Duration of the last idle loop is from
+ *			tick_nohz_idle_enter to tick_nohz_idle_exit.
  * @do_timer_lst:	CPU was the last one doing do_timer before going idle
  */
 struct tick_sched {
@@ -59,6 +61,7 @@ struct tick_sched {
 	ktime_t				idle_sleeptime;
 	ktime_t				iowait_sleeptime;
 	ktime_t				sleep_length;
+	ktime_t				idle_length;
 	unsigned long			last_jiffies;
 	u64				next_timer;
 	ktime_t				idle_expires;
-- 
1.7.1
