From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v4 3/6] smp: add function to execute a function synchronously
	on a cpu
Date: Tue,  5 Apr 2016 07:10:04 +0200
Message-ID: <1459833007-11618-4-git-send-email-jgross@suse.com>
References: <1459833007-11618-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1459833007-11618-1-git-send-email-jgross@suse.com>
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
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, jdelvare@suse.com, peterz@infradead.org, hpa@zytor.com, akataria@vmware.com, x86@kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

On some hardware models (e.g. Dell Studio 1555 laptop) some hardware
related functions (e.g. SMIs) are to be executed on physical cpu 0
only. Instead of open coding such a functionality multiple times in
the kernel add a service function for this purpose. This will enable
the possibility to take special measures in virtualized environments
like Xen, too.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4: change return value in case of illegal cpu as requested by Peter Zijlstra
    make pinning of vcpu an option as suggested by Peter Zijlstra

V2: instead of manipulating the allowed set of cpus use cpu specific
    workqueue as requested by Peter Zijlstra
---
 include/linux/smp.h |  2 ++
 kernel/smp.c        | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/up.c         | 17 +++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index c441407..3b5813b 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -196,4 +196,6 @@ extern void arch_enable_nonboot_cpus_end(void);
 
 void smp_setup_processor_id(void);
 
+int smp_call_on_cpu(unsigned int cpu, bool pin, int (*func)(void *), void *par);
+
 #endif /* __LINUX_SMP_H */
diff --git a/kernel/smp.c b/kernel/smp.c
index 9388064..357458b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -740,3 +740,53 @@ void wake_up_all_idle_cpus(void)
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
+
+/**
+ * smp_call_on_cpu - Call a function on a specific cpu
+ *
+ * Used to call a function on a specific cpu and wait for it to return.
+ * Optionally make sure the call is done on a specified physical cpu via vcpu
+ * pinning in order to support virtualized environments.
+ */
+struct smp_call_on_cpu_struct {
+	struct work_struct	work;
+	struct completion	done;
+	int			(*func)(void *);
+	void			*data;
+	int			ret;
+	int			cpu;
+};
+
+static void smp_call_on_cpu_callback(struct work_struct *work)
+{
+	struct smp_call_on_cpu_struct *sscs;
+
+	sscs = container_of(work, struct smp_call_on_cpu_struct, work);
+	if (sscs->cpu >= 0)
+		hypervisor_pin_vcpu(sscs->cpu);
+	sscs->ret = sscs->func(sscs->data);
+	if (sscs->cpu >= 0)
+		hypervisor_pin_vcpu(-1);
+
+	complete(&sscs->done);
+}
+
+int smp_call_on_cpu(unsigned int cpu, bool pin, int (*func)(void *), void *par)
+{
+	struct smp_call_on_cpu_struct sscs = {
+		.work = __WORK_INITIALIZER(sscs.work, smp_call_on_cpu_callback),
+		.done = COMPLETION_INITIALIZER_ONSTACK(sscs.done),
+		.func = func,
+		.data = par,
+		.cpu  = pin ? cpu : -1,
+	};
+
+	if (cpu >= nr_cpu_ids)
+		return -ENXIO;
+
+	queue_work_on(cpu, system_wq, &sscs.work);
+	wait_for_completion(&sscs.done);
+
+	return sscs.ret;
+}
+EXPORT_SYMBOL_GPL(smp_call_on_cpu);
diff --git a/kernel/up.c b/kernel/up.c
index 3ccee2b..8266810b 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -83,3 +83,20 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 	preempt_enable();
 }
 EXPORT_SYMBOL(on_each_cpu_cond);
+
+int smp_call_on_cpu(unsigned int cpu, bool pin, int (*func)(void *), void *par)
+{
+	int ret;
+
+	if (cpu != 0)
+		return -ENXIO;
+
+	if (pin)
+		hypervisor_pin_vcpu(0);
+	ret = func(par);
+	if (pin)
+		hypervisor_pin_vcpu(-1);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(smp_call_on_cpu);
-- 
2.6.2
