From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 2/6] smp: add function to execute a function synchronously
	on a physical cpu
Date: Mon, 21 Mar 2016 13:24:31 +0100
Message-ID: <1458563075-30298-3-git-send-email-jgross@suse.com>
References: <1458563075-30298-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1458563075-30298-1-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, jdelvare@suse.com, konrad.wilk@oracle.com, peterz@infradead.org, hpa@zytor.com, akataria@vmware.com, x86@kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

On some hardware models (e.g. Dell Studio 1555 laptop) some hardware
related functions (e.g. SMIs) are to be executed on physical cpu 0
only. Instead of open coding such a functionality multiple times in
the kernel add a service function for this purpose. This will enable
the possibility to take special measures in virtualized environments
like Xen, too.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2: instead of manipulating the allowed set of cpus use cpu specific
    workqueue as requested by Peter Zijlstra
---
 include/linux/smp.h |  2 ++
 kernel/smp.c        | 44 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/up.c         |  9 +++++++++
 3 files changed, 55 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index c441407..fc9d21b 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -196,4 +196,6 @@ extern void arch_enable_nonboot_cpus_end(void);
 
 void smp_setup_processor_id(void);
 
+int smp_call_sync_on_phys_cpu(unsigned int cpu, int (*func)(void *), void *par);
+
 #endif /* __LINUX_SMP_H */
diff --git a/kernel/smp.c b/kernel/smp.c
index 7416544..62da74b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -739,3 +739,47 @@ void wake_up_all_idle_cpus(void)
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
+
+/**
+ * smp_call_sync_on_phys_cpu - Call a function on a specific physical cpu
+ *
+ * Used to call a function on a specific physical cpu. Even if the specified
+ * cpu isn't the current one, return only after the called function has
+ * returned.
+ */
+struct smp_sync_call_struct {
+	struct work_struct	work;
+	struct completion	done;
+	int			(*func)(void *);
+	void			*data;
+	int			ret;
+};
+
+static void smp_call_sync_callback(struct work_struct *work)
+{
+	struct smp_sync_call_struct *sscs;
+
+	sscs = container_of(work, struct smp_sync_call_struct, work);
+	sscs->ret = sscs->func(sscs->data);
+
+	complete(&sscs->done);
+}
+
+int smp_call_sync_on_phys_cpu(unsigned int cpu, int (*func)(void *), void *par)
+{
+	struct smp_sync_call_struct sscs = {
+		.work = __WORK_INITIALIZER(sscs.work, smp_call_sync_callback),
+		.done = COMPLETION_INITIALIZER_ONSTACK(sscs.done),
+		.func = func,
+		.data = par,
+	};
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	queue_work_on(cpu, system_wq, &sscs.work);
+	wait_for_completion(&sscs.done);
+
+	return sscs.ret;
+}
+EXPORT_SYMBOL_GPL(smp_call_sync_on_phys_cpu);
diff --git a/kernel/up.c b/kernel/up.c
index 1760bf3..afd395c 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -82,3 +82,12 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 	preempt_enable();
 }
 EXPORT_SYMBOL(on_each_cpu_cond);
+
+int smp_call_sync_on_phys_cpu(unsigned int cpu, int (*func)(void *), void *par)
+{
+	if (cpu != 0)
+		return -EINVAL;
+
+	return func(par);
+}
+EXPORT_SYMBOL_GPL(smp_call_sync_on_phys_cpu);
-- 
2.6.2
