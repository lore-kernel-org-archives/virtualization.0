Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241033932D1
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574034; cv=none; b=djh5d07d0u+pIaFuBGQqv71D3qMKVslp7ytRhXAActP1BBjx4M7rN7EBF4MVYyN+tO6ZB0ooUoPEBIZf+Ks/bbnfHx4GolBrpKOheNgJQE/SSadkaY27FJwCQijI63wMZ2v/6Ju4fzCoIPAS17wdoxEtdgLdZM5V2I38I19jFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574034; c=relaxed/simple;
	bh=VDp2zBoCFEaRDgWzZVNpKOazoIedhMgdmV1VZIRF634=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlS5Iwqt/lj637hzC04+H/RgbqbVKqVYieWDUTX2QYyhBZlOqqGZKYjtHxoY3XEZ5zkgeNdbGqBFBKGDZ3XlXW36Vp3EO0x+PD97atW2TNKeo+HysWEb3RxfJFLGoE8tB1ATh7P+TDxuJKUc/OCWmo40/ZZsLKIILr26zOGoLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X+koVt7+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X+koVt7+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RHXNid264923;
	Mon, 28 Sep 2026 05:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gjYq6SHKwdXjFp3Ex
	vbEGIeub4757cwklj45vWP8riU=; b=X+koVt7+vjsLH671ZOm9sQKJeLsbSPQUU
	c1wVLhgaEJrdDLjBTvG/AEqruOM1RqcSARDDti7wqaqVEpTV6XteX7GEkSQnuRjR
	Yk6c1hEFzY79meXaXbIS5fekMihKLtT4MJp0xr9lfc51erGhOLjdVtg6hKXyNXrc
	ao3qDAnw1fqDax1uet4CrH7D/i3LGJR7Uk9+EvhPvxijinze20YoRu4b+GKskJhX
	FUJJdlcofIJu856F6lgqv+SzG2IiH/bxUIZA62htU3TiC2HwDtzVTjZ7n3gEHyyl
	asX96n6L5Av5kluUTd1X4suORfVs09Y9M0QmGozPlYpQlbByyD/8g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j4yjw6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:40:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S2DN3L2055623;
	Mon, 28 Sep 2026 05:40:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpm05w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:40:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5e5nR50594176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:40:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C68820043;
	Mon, 28 Sep 2026 05:40:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C276D20040;
	Mon, 28 Sep 2026 05:39:54 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:39:54 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
        corbet@lwn.net, meted@linux.ibm.com, ynorov@nvidia.com
Cc: sshegde@linux.ibm.com, tglx@kernel.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com,
        chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org,
        arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com,
        tj@kernel.org, tommaso.cucinotta@gmail.com, maz@kernel.org,
        rafael@kernel.org, rdunlap@infradead.org, kernellwp@gmail.com,
        linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev, sunlightlinux@gmail.com
Subject: [PATCH v14 12/13] virt/steal_governor: Implement steal_governor policy loop
Date: Mon, 28 Sep 2026 11:07:27 +0530
Message-ID: <20260928053728.797539-13-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928053728.797539-1-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX0r74g+BJ+ANS
 jz7kq2Hzt1pdhCaSSIThZO/hJBXe4O5oUodkZ/cc0kXWphSHDxi+37u/3M6NQgwVQ5AtvUvk4eR
 /mCoq+4r28C9pT8H25la1KP2bGj4UDY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX0LjGXc9J6TeD
 TqWhxag38Lq5xxDZ15cKgud/5U+V7E9h0Yb17c1cJYLFIOMglCyZYOb+GQfglqKQ3YasyYh9wxl
 c709JoM5pMGpHdwuSII56cbkhGrxALEEswXk+B8R6+uRR/9NIaOggA6rn9x0l35jm+yLlf6gwyB
 4AAUvss86Ibo4J+FH3o2cqewFycQYmeMvlWDiM6qN7c8TQwSKHQmg2LUIqRBAioWRBrcErI9MSA
 Q7cMMkZYN//TK40ml4XAO3cqUQvOkkP79PN8uTGQtHv1X5B5KLFlIOJ3OdxDnkV/ksKlgsxnvME
 kl4o6TplXECE0wis5CLxRg1UOHZ5Wlgo++4o01HepJdVbF+RQwknufDbae1KoLygalb2mk5Gt0h
 yXIS6ws3qjBDbVjKmcD4vNk5OX9hqbklghrD/brNKrPVfL5Feqtr9WLlcyXZoSIdOCmQTQUSdsv
 v73cSuGFhXEkeouBsUQ==
X-Proofpoint-GUID: 1_bkqleq0KGNuwrfKHL2slkCej8Z_D-U
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6ab9fdba cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=dzxYU6fr5WJrpIuQ_HEA:9
X-Proofpoint-ORIG-GUID: 1M-1wEqyYc81FvBzOQIpmEomHng9lN5M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280022

Schedule work at regular intervals to implement the steal_governor
policy loop, which monitors steal time and takes action on the state of
preferred CPUs. The interval is determined by the interval_ms parameter.
schedule_delayed_work() is used since interval_ms is on the order of
milliseconds and the work does not need to happen instantly.

Periodic policy loop essentially does:

- Gets the total/delta steal values and cpus to use steal_ratio.
- Calculate the steal_ratio as below.

       steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())

  It is calculated this way to consider the fractional values of steal
  time. I.e 10 means 0.1% steal time. A few tricks such as
  divide by 10,000 are used to avoid possible overflow.
- If steal ratio is higher than high threshold, call the method to reduce
  the preferred CPUs.
- If steal ratio is lower or equal to low threshold, call the method to
  increase the preferred CPUs.
- If the steal ratio falls in between, no action is taken.
- Ensures design constraints always met.
  1. At least one core/CPU must be there in preferred mask.
  2. preferred CPUs is subset of active CPUs.
  If not met, then restore preferred CPUs to active and stop
  requeue of the work. Driver is effectively non-functional after that.

Note that design checks are always performed. This helps avoid placing
driver-specific design constraints inside the core CPU hotplug mechanism.
User may offline specific set of CPUs that could leave the preferred
mask as empty. With the design check performed always, driver gracefully
shuts down upon detecting that edge case.

In order to help the above loop, a few helper functions have been added.
1. get_system_steal_time()
- steal governor takes global view of steal time instead of individual
  vCPU. Collect the steal values across the vCPUs of interest.
- Sum up steal time values across possible CPUs. This helps to keep it
  a monotonically increasing number and avoids spikes due to CPU
  hotplug.

2. decrease_preferred_cpus()
- Called when there is high steal time. It needs to decide which CPUs to
  mark as non-preferred.
- Get first housekeeping CPU and its core mask. Mark it as
  protected core. This helps to keep at least one core as preferred.
  (kernel ensures at least one housekeeping CPU stays active.)
- Find the last CPU outside of this protected core mask. i.e target CPU
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
- Since only active CPUs effectively contribute to steal time delta,
  returns number of active CPUs. This also helps to avoid dilution of
  thresholds in sparsely populated systems.

Notes:
1. Using core instead of individual CPUs performs better as SMT is
   quite common and some hypervisor such as powerVM does core scheduling.

2. This doesn't do any NUMA splicing to keep the code simpler and
   minimal overhead. Current code expects CPUs spread uniformly
   across NUMA nodes.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/virt/steal_governor.c | 149 ++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index 27f53ea16498..6e31f9923dea 100644
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
 #ifdef CONFIG_XEN
@@ -111,6 +116,145 @@ module_param_named(low_threshold, sg_ctx.low_threshold, uint, 0444);
 MODULE_PARM_DESC(low_threshold,
 		 "Low steal threshold. default: 200 i.e 2%. Must be < high_threshold");
 
+/* Return collective steal time across system. */
+static u64 get_system_steal_time(void)
+{
+	return kcpustat_field_total(CPUTIME_STEAL, cpu_possible_mask);
+}
+
+/* Return number of CPUs to consider for steal ratio. */
+static unsigned int get_system_cpus(void)
+{
+	return num_active_cpus();
+}
+
+/*
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
+static void steal_governor_loop(struct work_struct *work)
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
+	/*
+	 * else: steal ratio is within bounds. Still do design checks so that
+	 * module restores to active if CPU hotplug breaks those assumptions.
+	 */
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
 #ifdef CONFIG_XEN
@@ -127,6 +271,10 @@ static int __init steal_governor_init(void)
 	}
 
 	sg_ctx.delay = msecs_to_jiffies(sg_ctx.interval_ms);
+	INIT_DELAYED_WORK(&sg_ctx.work, steal_governor_loop);
+	sg_ctx.steal = get_system_steal_time();
+	sg_ctx.time = ktime_get();
+	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
 	pr_info("enabled. interval: %ums, high_threshold: %u, low_threshold: %u\n",
 		sg_ctx.interval_ms, sg_ctx.high_threshold, sg_ctx.low_threshold);
 
@@ -135,6 +283,7 @@ static int __init steal_governor_init(void)
 
 static void __exit steal_governor_exit(void)
 {
+	disable_delayed_work_sync(&sg_ctx.work);
 	restore_preferred_to_active();
 	pr_info("disabled\n");
 }
-- 
2.52.0

