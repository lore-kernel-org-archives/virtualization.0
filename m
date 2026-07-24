Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B3D4908B7
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902214; cv=none; b=EtQwEM1ScqWd7fnHm8R+CJn5UlkjgHKrsuGGlIY7E2r96CxeAOuQPuYbMxdLtoGLzGYXhT+n88xVu3EDAxSftrwaHvkRp8l/UlYQ9k5nYwlPv0Uz7bciXUxfP+3E/Mpa+S4uhOH9G5EXEbT7pW3Gg9dmgRKVayVpmmg9OE91X0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902214; c=relaxed/simple;
	bh=lFn6yudg7HtGZWnonuoEUEeFLNJ83HIX7SI5cWN9MVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXDnuZ5AackU1hswOr63tznDr0C+IuauMEsPHX88vCmXS1Yp+88c4bMndb1XUi6O+SP8st5G03kYCeRcwitvvB3DPvdbTrvNhjWqHBaG2dpP5wgSCzzyCbrXPuuY0JcB/jxycR84I/TT+J7QbKUHtp+WXSN22euW6P2N3yaEFa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lPvnPeY/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lPvnPeY/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfla11974199;
	Fri, 24 Jul 2026 14:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=C+rWP+vHDsQ3aZepR
	duYt4yeLX6PoV71sT1na6/prNs=; b=lPvnPeY/EwljiH8Vye1HYQP4GPwhJnYaV
	UmZCjwlT4ravHYc2ZCDGnP3mQkdu9lBPFf5wULgKBbbyv61R17a1bqmJbEzmlnN/
	M2+3ur8QoUwHja6jBTSBZ2/p5agidksUlxKt3ja684q2pZvSkQecCZMDo2aQ7drq
	C7ShjQRVmGVCBNZM2UtYAEMsnl1Ou1/+l74SDh2D4ZUgWX9O/STGvN8uQuJeDlXb
	o1it3SqQbhQvyexqgDRlSQ3Mtmxkw6ytl6pltEiXQ5fm9kwpRPYY2E4SmfulJ2+t
	55ClnSuCNcRlyG2hIQV44b7XNLfQ1r4y1nxxBHjOhjsbgj/jedtqw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h50a0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:09:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4ltJ014575;
	Fri, 24 Jul 2026 14:09:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk96wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:09:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OE9qcG42533130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:09:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5344520171;
	Fri, 24 Jul 2026 14:09:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2179220176;
	Fri, 24 Jul 2026 14:09:43 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.20.178])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:09:42 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
        corbet@lwn.net
Cc: sshegde@linux.ibm.com, tglx@kernel.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com,
        chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org,
        arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com,
        tj@kernel.org, tommaso.cucinotta@gmail.com, maz@kernel.org,
        rafael@kernel.org, rdunlap@infradead.org, kernellwp@gmail.com,
        linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev
Subject: [PATCH v9 10/11] virt/steal_governor: Implement steal_governor policy loop
Date: Fri, 24 Jul 2026 19:37:31 +0530
Message-ID: <20260724140732.2683314-11-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724140732.2683314-1-sshegde@linux.ibm.com>
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX4wTYfDUwFXQ5
 zhU1UA+Z0MwVQRc0LwCN++tpDw3WvqDvjlq3dHnPo7+hJDvaOOOEmsjruaDF03mwOGVMBd9Ydzy
 4t2h6XdusZSE9DdupKccxIjXBTce0mA=
X-Proofpoint-ORIG-GUID: hvjd0CBqvhHLmRKaZ3quIHCqS14xPXjn
X-Proofpoint-GUID: Whx-zw6UZsQW4qu3eCs4PnPGZ7ixwITv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfXyHBLQZXxdrKG
 Z1/9XuXGzc7AFBgJw21IKJGBGTaphkdQ+XKlg/PfuDunDWiylpGf3wVhZlx0Deipc19xlhRitFd
 8X1wPHWgBzRAyjGdhFyPykADkJQJLdI+DBUESiNPvld5IK4TEz4mCLqe2QV0EpHz+dUxlmf7r5d
 mk31jQmlt4xc6CVRgcMWOtgtuKmIRHkCJSzysfux47ny2d216CWDIeYkXrRLM1dZhIsQjq4ySg4
 DEVbYWH6uU8IvE+OCI1sl7+lidzkM2xnUEdQxs1AgvJKulmj/w5JSXN/xxkyhbTKYHMFnVEruK9
 zC9XmqjsOhsRWp9pI6FvN1VYe32mdXZ6JO/PIneycLufmlhNdloh8DgoZdLiOpdyWaOgNszhoCo
 wTe802+hRME5Ifsj8HG9BUkuUjE43NJULll9LzzuYiwRlcDZ9TFKqfuYnWyp2jiX5IPUj2LJp0c
 UT7fycTK4LmBqj+6vMA==
X-Authority-Analysis: v=2.4 cv=du3rzVg4 c=1 sm=1 tr=0 ts=6a637236 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=zdfznts9tQKWGqFkqZ0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240124

schedule work at regular intervals to implement the steal_governor
policy of monitoring the steal time and take action on the state of
preferred CPUs. The interval is determined by interval_ms parameter.
schedule_delayed_work is used since interval_ms
is in the order of milliseconds. Work need not happen instantly.

Periodic policy loop essentially does:
- Gets the total/delta steal values and cpus to use steal_ratio.
- Calculate the steal_ratio as below.

       steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())

  It is calculated to consider the fractional values of steal time.
  I.e 10 means 0.1% steal time. A few tricks such as divide by 10,000
  are used to avoid possible overflow.
- If steal value is higher than high threshold, call the method to reduce
  the preferred CPUs.
- If steal value is lower or equal to low threshold, call the method to
  increase the preferred CPUs.
- If the steal value is in between, no action is taken.
- Save the values for next delta calculations.
- Ensure design checks are met.
  1. At least one core/CPU must be there in preferred mask.
  2. preferred CPUs is subset of active CPUs.
If not met, then restore preferred CPUs to active and stop
requeue of the work. Driver is effectively non-functional after that.


In order to help the above loop, a few helper functions have been added.

1. get_system_steal_time()
- steal governor takes global view of steal time instead of individual
  vCPU. Collect the steal values across the vCPUs of interest.
- Sum up steal time values across possible CPUs. This helps to keep it
  a monotonically increasing number and avoids spikes due to CPU
  hotplug.

2. decrease_preferred_cpus()
- Called when there is high steal time. It needs to decide which CPUs to
  mark as non-preferred and set that state.
- Get first housekeeping CPU and its core mask. Mark it as
  protected core. This helps to keep at least one core as preferred.
  kernel ensures at least one housekeeping CPU stays active.
- Find the last CPU outside of this protected core mask. (target CPU)
- Based on that target CPU, get its sibling and mark them as
  non-preferred.

3. increase_preferred_cpus()
- Called when there is low steal time. It needs to decide which CPUs to
  mark as preferred and set that state.
- Get the first active non-preferred CPUs. This likely is the last
  set of CPUs being marked as non-preferred.
- get the siblings of that CPU and mark them as preferred.

4. get_system_cpus()
- informs how many CPUs needs to be considered for steal_ratio
  calculations.
- Return number of possible CPUs as get_system_steal_time computes
  steal values across possible CPUs.

Notes:
1. Using core instead of individual CPUs performs better as SMT is
   quite common and some hypervisor such as powerVM does core scheduling.

2. This doesn't do any NUMA splicing to keep the code simpler and
   minimal overhead. Current code expects CPUs spread uniformly
   across NUMA nodes.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/virt/steal_governor.c | 155 ++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index fda86777d6f0..991821a82485 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -13,13 +13,18 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cleanup.h>
 #include <linux/cpuhplock.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kernel_stat.h>
 #include <linux/kconfig.h>
 #include <linux/ktime.h>
+#include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/sched/isolation.h>
+#include <linux/topology.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
@@ -108,6 +113,151 @@ module_param_named(low_threshold, sg_ctx.low_threshold, uint, 0444);
 MODULE_PARM_DESC(low_threshold,
 		 "Low steal threshold. default: 200 i.e 2%. Must be < high_threshold");
 
+/* Return collective steal time across system. */
+static u64 get_system_steal_time(void)
+{
+	int cpu;
+	u64 total_steal = 0;
+
+	for_each_possible_cpu(cpu)
+		total_steal += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
+
+	return total_steal;
+}
+
+/* Return number of CPUs to consider steal ratio. */
+static unsigned int get_system_cpus(void)
+{
+	return num_possible_cpus();
+}
+
+/*
+ *
+ * Called when the steal governor detects high physical CPU contention.
+ * It finds the last active core in the preferred mask and mark those
+ * CPUs as non-preferred.
+ *
+ * Must ensure:
+ * - at least one core is always kept as preferred
+ * - preferred is always subset of active.
+ */
+static void decrease_preferred_cpus(void)
+{
+	const struct cpumask *first_hk_core;
+	int target_cpu = nr_cpu_ids;
+	int cpu;
+
+	guard(cpus_read_lock)();
+	cpu = cpumask_first_and(housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
+				cpu_preferred_mask);
+	if (cpu >= nr_cpu_ids)
+		return;
+
+	/* Always leave first housekeeping core as preferred. */
+	first_hk_core = topology_sibling_cpumask(cpu);
+	cpu = cpumask_last(cpu_preferred_mask);
+	if (cpu >= nr_cpu_ids)
+		return;
+
+	/* Find the last CPU which doesn't belong to that first hk_core. */
+	if (!cpumask_test_cpu(cpu, first_hk_core)) {
+		target_cpu = cpu;
+	} else {
+		for_each_cpu_andnot(cpu, cpu_preferred_mask, first_hk_core)
+			target_cpu = cpu;
+	}
+
+	/* Only the first housekeeping core remains */
+	if (target_cpu >= nr_cpu_ids)
+		return;
+
+	for_each_cpu_and(cpu, topology_sibling_cpumask(target_cpu),
+			 cpu_preferred_mask)
+		set_cpu_preferred(cpu, false);
+}
+
+/*
+ * Called when the steal governor detects no/low physical CPU contention.
+ * It finds the first active core outside of preferred mask and mark
+ * those CPUs as preferred.
+ *
+ * Must ensure preferred is subset of active.
+ */
+static void increase_preferred_cpus(void)
+{
+	int first_cpu, cpu;
+
+	guard(cpus_read_lock)();
+	first_cpu = cpumask_first_andnot(cpu_active_mask, cpu_preferred_mask);
+
+	/* All CPUs are preferred. Nothing to increase further */
+	if (first_cpu >= nr_cpu_ids)
+		return;
+
+	for_each_cpu_and(cpu, topology_sibling_cpumask(first_cpu),
+			 cpu_active_mask)
+		set_cpu_preferred(cpu, true);
+}
+
+static bool preferred_cpus_valid(void)
+{
+	if (cpumask_empty(cpu_preferred_mask)) {
+		pr_err("empty preferred mask. stopping\n");
+		return false;
+	}
+
+	if (!cpumask_subset(cpu_preferred_mask, cpu_active_mask)) {
+		pr_err("preferred: %*pbl is not subset of active: %*pbl, stopping\n",
+		       cpumask_pr_args(cpu_preferred_mask),
+		       cpumask_pr_args(cpu_active_mask));
+		return false;
+	}
+
+	return true;
+}
+
+static void compute_preferred_cpus_work(struct work_struct *work)
+{
+	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
+	ktime_t now;
+
+	now = ktime_get();
+	delta_ns = ktime_to_ns(ktime_sub(now, sg_ctx.time));
+
+	if (unlikely(delta_ns < NSEC_PER_MSEC)) {
+		pr_err_ratelimited("work scheduled too soon delta_ns: %llu\n", delta_ns);
+		goto requeue_work;
+	}
+
+	curr_steal = get_system_steal_time();
+	delta_steal = curr_steal > sg_ctx.steal ? curr_steal - sg_ctx.steal : 0;
+	sg_ctx.steal = curr_steal;
+	sg_ctx.time = now;
+
+	/*
+	 * steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())
+	 * To avoid possible overflow, divide the denominator early.
+	 * Note minimum interval is 100ms.
+	 */
+	delta_ns = max_t(u64, div_u64(delta_ns * get_system_cpus(), 10000), 1);
+	steal_ratio = div64_u64(delta_steal, delta_ns);
+
+	if (steal_ratio > sg_ctx.high_threshold)
+		decrease_preferred_cpus();
+	else if (steal_ratio <= sg_ctx.low_threshold)
+		increase_preferred_cpus();
+	else
+		goto requeue_work;
+
+	if (!preferred_cpus_valid()) {
+		restore_preferred_to_active();
+		return;
+	}
+
+requeue_work:
+	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
+}
+
 static int __init steal_governor_init(void)
 {
 	if (sg_ctx.low_threshold >= sg_ctx.high_threshold) {
@@ -117,6 +267,10 @@ static int __init steal_governor_init(void)
 	}
 
 	sg_ctx.delay = msecs_to_jiffies(sg_ctx.interval_ms);
+	INIT_DELAYED_WORK(&sg_ctx.work, compute_preferred_cpus_work);
+	sg_ctx.steal = get_system_steal_time();
+	sg_ctx.time = ktime_get();
+	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
 	pr_info("enabled. interval: %ums, high_threshold: %u, low_threshold: %u\n",
 		sg_ctx.interval_ms, sg_ctx.high_threshold, sg_ctx.low_threshold);
 
@@ -125,6 +279,7 @@ static int __init steal_governor_init(void)
 
 static void __exit steal_governor_exit(void)
 {
+	disable_delayed_work_sync(&sg_ctx.work);
 	restore_preferred_to_active();
 	pr_info("disabled\n");
 }
-- 
2.47.3

