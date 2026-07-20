Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081B2F0680
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568299; cv=none; b=eiMP59MPxS46iITNAaTpcBJcaqHfKSDjEdLKLEJiLWoMQ22litPNHMcbUWTNLvNIU44R7cBBlXA1wb3M5bm/ngWHPxH+FxAU3HXf9MTxlYl1Op/BZpEHqx+OEhfiUhHtseMSn6NXi4Gh5v6qv0dPbx/iF/8hbqzBE2x3tQG5AHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568299; c=relaxed/simple;
	bh=+gTR/UX/KM1ppW80g8D+7wCBdjKbpWLvfZ05vvbG5oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjWsSzeSW9n9zLAw1+zYZi07a8Rz5Jmmzb4fcuV6AZW9fUw8mraYDHBnbilFZsNyWmvLT9y7xFYCgI9LIOFjARqTBQwRp331eQ+ZpB6dS5wTNbjjdIOnafPZaCf3ADsIurAeyGutdctYUmhkaRmgkDO+DeqcoqX3EQSy2+qAq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jlTLsi5a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jlTLsi5a"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHCZN12714996;
	Mon, 20 Jul 2026 17:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lpavJ6Y0X+wN2wVis
	fptYdvYz/1lyMylIj5b8vP2mjk=; b=jlTLsi5a+BiVzUJ7etCO+L0BBSngsB7Jl
	AUySDPZB83Uo2+pd/Ve0SSdPvO/hMixEqivpuEL5Xq/djNM9gv9JF/ejuoiSSmNv
	jQP5XkD2rDF10FdbJdsuzU9FC4vRxs6/An2XXEeg2Qpq8ZIFH6cv+GCHoYMUzq2H
	YLMZdzOJXYMif+8SE3ROlHBW6/SnLfA7gA6HZQaDD1SZ2efMmNFSvPSAjZuDXjCA
	bJv1l9+DFApZn3DDBD8LJC/+ESKc6UrDZK/Z/phRCYcWu6+zB/KhSf15NFP1i6d/
	ujpTfBID3iWmNog4xISDszhNdlIxyktEI3bsMIX63so42CD5lK7aA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g0dc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:24:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KHJwU4023243;
	Mon, 20 Jul 2026 17:24:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6vxr3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:24:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHOYW952166920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:24:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA2E42004B;
	Mon, 20 Jul 2026 17:24:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7CF120040;
	Mon, 20 Jul 2026 17:24:26 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.17.130])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:24:26 +0000 (GMT)
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
Subject: [PATCH v8 10/11] virt/steal_governor: Implement steal_governor policy loop
Date: Mon, 20 Jul 2026 22:52:49 +0530
Message-ID: <20260720172250.2257582-11-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720172250.2257582-1-sshegde@linux.ibm.com>
References: <20260720172250.2257582-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX5hGqNIJJZ+5k
 zZAkF8WgrBt2lY6U3bs0wpVEeJQ0CygedZwrlmSQCMO0GQq4Isrs5xuzxKXH7kDCV0irPOulEFk
 ZRi7Vdj/SyG3u4+JgJO/x+1im/dQjZxGq8AhEiIeknK+Byt/qSwK0uQLe3MieXuerlBHKK2isyg
 ML6ImObaAQNORrIqw9uVlF7PNWViEu560EwD0HIwAeC435JAtRKBMrB7xhxIDO85eIUSwsLIxup
 uQrcuPHv1pGemxcswj8TiqgsHrClMeMrp1v5k0WEZtZhySRVX4RiLmWFq9DGuhvfhZiOaKY6+I9
 apFPVkWQvs+jgR25GLXnT44fMrGiayucgxJYIpLA/oVmbvSheYUnh0/ewU76jKbgAiAjOyPh8S0
 cr+wQJybVp/7P39zsmhjmOtq8iovg7SOuhmcFBpXRyVJ0p4xqy0ZOlaP+g7DZGPDU9N5DM9sXUX
 odR7plFC7u7QE48knqQ==
X-Proofpoint-GUID: tFvuEG9xKY6WuYDDMzi_buEFDzUCbLIW
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5e59d8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=dzxYU6fr5WJrpIuQ_HEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfXzfbMHHHsqp/U
 HYTkmZJPOvfGc5lHCcYii6iFqLR32yI2uSt8ySHuSatXlICTgbzxIkcGGat/KM5AmB65ha+FVpM
 774gq5TTjFQLKX+hyas90RLuIaJjzgg=
X-Proofpoint-ORIG-GUID: cPwz2W4GhKgr65z2WT8PLlEt2Pv2nDVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200191

schedule work at regular intervals to implement the steal_governor
policy of monitoring the steal time and take action on the state of
preferred CPUs. The interval is determined by interval_ms parameter.
schedule_delayed_work is used since interval_ms
is in the order of milliseconds. Work need not happen instantly.

Periodic policy loop essentially does:
- Gets the total/delta steal values and cpus to use steal_ratio.
  (get_system_steal_time, get_num_cpus_steal_ratio)
- Calculate the steal_ratio as below.

       steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())

  It is calculated to consider the fractional values of steal time.
  I.e 10 means 0.1% steal time. A few tricks such as divide by 10,000
  are used to avoid possible overflow.
- If steal value is higher than high threshold, call the method to reduce
  the preferred CPUs. (decrease_preferred_cpus)
- If steal value is lower or equal to low threshold, call the method to
  increase the preferred CPUs. (increase_preferred_cpus)
- If the steal value is in between, no action is taken.
- Save the values for next delta calculations.
- Ensure design checks are met.
  1. At least one core/CPU must be there in preferred mask.
  2. preferred CPUs is subset of active CPUs.
If not met, then restore preferred CPUs to active and stop
requeue of the work. Driver is effectively non-functional after that.

In Order to help the above loop, a few helper functions have been added.

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

4. get_num_cpus_steal_ratio()
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
 drivers/virt/steal_governor/core.c | 160 +++++++++++++++++++++++++++++
 drivers/virt/steal_governor/core.h |   5 +
 2 files changed, 165 insertions(+)

diff --git a/drivers/virt/steal_governor/core.c b/drivers/virt/steal_governor/core.c
index 1cb766a8ce28..97f82d6df60f 100644
--- a/drivers/virt/steal_governor/core.c
+++ b/drivers/virt/steal_governor/core.c
@@ -89,6 +89,158 @@ module_param_named(low_threshold, sg_core_ctx.low_threshold, uint, 0444);
 MODULE_PARM_DESC(low_threshold,
 		 "Low steal threshold. default: 200 i.e 2%. Must be < high_threshold");
 
+/*
+ * Returns steal time of the full system.
+ * Compute collective steal time across all possible CPUs.
+ */
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
+/*
+ * Returns number of CPUs to consider for steal ratio.
+ * Return possible CPUs.
+ */
+static unsigned int get_num_cpus_steal_ratio(void)
+{
+	return num_possible_cpus();
+}
+
+/*
+ * Take action to decrease preferred CPUs.
+ *
+ * Decrease the preferred CPUs by 1 core.
+ * Take out the last core in the active & preferred.
+ *
+ * Must ensure
+ * - least one housekeeping core is always kept as preferred
+ * - preferred is always subset of active.
+ */
+static void decrease_preferred_cpus(void)
+{
+	int tmp_cpu, first_hk_cpu, last_cpu;
+	const struct cpumask *first_hk_core;
+	int target_cpu = nr_cpu_ids;
+
+	guard(cpus_read_lock)();
+	first_hk_cpu = cpumask_first_and(housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
+					 cpu_preferred_mask);
+	if (first_hk_cpu >= nr_cpu_ids)
+		return;
+
+	last_cpu = cpumask_last(cpu_preferred_mask);
+
+	if (last_cpu >= nr_cpu_ids)
+		return;
+
+	/* Always leave first housekeeping core as preferred. */
+	first_hk_core = topology_sibling_cpumask(first_hk_cpu);
+
+	/* Find the last CPU which doesn't belong to that first hk_core. */
+	if (!cpumask_test_cpu(last_cpu, first_hk_core)) {
+		target_cpu = last_cpu;
+	} else {
+		for_each_cpu_andnot(tmp_cpu, cpu_preferred_mask, first_hk_core)
+			target_cpu = tmp_cpu;
+	}
+
+	/* Only the first housekeeping core remains */
+	if (target_cpu >= nr_cpu_ids)
+		return;
+
+	for_each_cpu_and(tmp_cpu, topology_sibling_cpumask(target_cpu),
+			 cpu_preferred_mask)
+		set_cpu_preferred(tmp_cpu, false);
+}
+
+/*
+ * Take action to increase preferred CPUs.
+ *
+ * Increase the preferred CPUs by 1 core.
+ * Add the first core in active & !preferred
+ *
+ * Must ensure preferred is subset of active.
+ */
+static void increase_preferred_cpus(void)
+{
+	int first_cpu, tmp_cpu;
+
+	guard(cpus_read_lock)();
+	first_cpu = cpumask_first_andnot(cpu_active_mask, cpu_preferred_mask);
+
+	/* All CPUs are preferred. Nothing to increase further */
+	if (first_cpu >= nr_cpu_ids)
+		return;
+
+	for_each_cpu_and(tmp_cpu, topology_sibling_cpumask(first_cpu),
+			 cpu_active_mask)
+		set_cpu_preferred(tmp_cpu, true);
+}
+
+static void compute_preferred_cpus_work(struct work_struct *work)
+{
+	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
+	ktime_t now;
+
+	now = ktime_get();
+	delta_ns = ktime_to_ns(ktime_sub(now, sg_core_ctx.time));
+
+	if (unlikely(delta_ns < NSEC_PER_MSEC)) {
+		pr_err_ratelimited("steal_governor: work scheduled too soon delta_ns: %llu\n",
+				   delta_ns);
+		goto requeue_work;
+	}
+
+	curr_steal = get_system_steal_time();
+	delta_steal = curr_steal > sg_core_ctx.steal ?
+		      curr_steal - sg_core_ctx.steal : 0;
+
+	/* Update for next calculation */
+	sg_core_ctx.steal = curr_steal;
+	sg_core_ctx.time = now;
+
+	/*
+	 * steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())
+	 * To avoid possible overflow, divide the denominator early.
+	 * Note minimum interval is 100ms.
+	 */
+	delta_ns = max_t(u64, div_u64(delta_ns * get_num_cpus_steal_ratio(),
+				      100 * 100), 1);
+	steal_ratio = div64_u64(delta_steal, delta_ns);
+
+	if (steal_ratio > sg_core_ctx.high_threshold)
+		decrease_preferred_cpus();
+	if (steal_ratio <= sg_core_ctx.low_threshold)
+		increase_preferred_cpus();
+
+	/* maintain design constructs always */
+	if (cpumask_empty(cpu_preferred_mask)) {
+		pr_err("empty preferred mask. stop steal governor\n");
+		restore_preferred_to_active();
+		return;
+	}
+
+	if (!cpumask_subset(cpu_preferred_mask, cpu_active_mask)) {
+		pr_err("preferred: %*pbl is not subset of active: %*pbl, stop steal governor\n",
+		       cpumask_pr_args(cpu_preferred_mask),
+		       cpumask_pr_args(cpu_active_mask));
+		restore_preferred_to_active();
+		return;
+	}
+
+requeue_work:
+	/* Trigger for next sampling */
+	schedule_delayed_work(&sg_core_ctx.work,
+			      msecs_to_jiffies(sg_core_ctx.interval_ms));
+}
+
 static int __init steal_governor_init(void)
 {
 	if (sg_core_ctx.low_threshold >= sg_core_ctx.high_threshold) {
@@ -100,11 +252,19 @@ static int __init steal_governor_init(void)
 	pr_info("steal_governor is enabled. interval: %ums, high_threshold: %u, low_threshold: %u\n",
 		sg_core_ctx.interval_ms, sg_core_ctx.high_threshold, sg_core_ctx.low_threshold);
 
+	INIT_DELAYED_WORK(&sg_core_ctx.work, compute_preferred_cpus_work);
+	sg_core_ctx.steal = get_system_steal_time();
+	sg_core_ctx.time = ktime_get();
+
+	schedule_delayed_work(&sg_core_ctx.work,
+			      msecs_to_jiffies(sg_core_ctx.interval_ms));
+
 	return 0;
 }
 
 static void __exit steal_governor_exit(void)
 {
+	disable_delayed_work_sync(&sg_core_ctx.work);
 	restore_preferred_to_active();
 	pr_info("steal_governor is disabled\n");
 }
diff --git a/drivers/virt/steal_governor/core.h b/drivers/virt/steal_governor/core.h
index e27305284ac0..59329c1d7109 100644
--- a/drivers/virt/steal_governor/core.h
+++ b/drivers/virt/steal_governor/core.h
@@ -12,6 +12,11 @@
 #include <linux/workqueue.h>
 #include <linux/ktime.h>
 #include <linux/kconfig.h>
+#include <linux/kernel_stat.h>
+#include <linux/topology.h>
+#include <linux/sched/isolation.h>
+#include <linux/cleanup.h>
+#include <linux/math64.h>
 
 struct steal_governor {
 	struct delayed_work	work;
-- 
2.47.3

