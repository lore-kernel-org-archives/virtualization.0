From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v2 1/4] kernel/sched: introduce vcpu preempted check interface
Date: Tue, 28 Jun 2016 10:43:08 -0400
Message-ID: <1467124991-13164-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org
Cc: dave@stgolabs.net, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, peterz@infradead.org, mpe@ellerman.id.au, boqun.feng@gmail.com, will.deacon@arm.com, waiman.long@hpe.com, mingo@redhat.com, paulus@samba.org, benh@kernel.crashing.org, schwidefsky@de.ibm.com, paulmck@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

This patch support to fix lock holder preemption issue.

For kernel users, we could use bool vcpu_is_preempted(int cpu) to detech if
one vcpu is preempted or not.

The default implementation is a macro defined by false. So compiler can
wrap it out if arch dose not support such vcpu pteempted check.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 include/linux/sched.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6e42ada..cbe0574 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3293,6 +3293,18 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 
 #endif /* CONFIG_SMP */
 
+/*
+ * In order to deal with a various lock holder preemption issues provide an
+ * interface to see if a vCPU is currently running or not.
+ *
+ * This allows us to terminate optimistic spin loops and block, analogous to
+ * the native optimistic spin heuristic of testing if the lock owner task is
+ * running or not.
+ */
+#ifndef vcpu_is_preempted
+#define vcpu_is_preempted(cpu)	false
+#endif
+
 extern long sched_setaffinity(pid_t pid, const struct cpumask *new_mask);
 extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 
-- 
2.4.11
