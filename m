Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D5B3914F5
	for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 05:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513351; cv=none; b=f3yu4Ps05JzWYITfhTAcvI54sD7mTMhxS02COw/recGjs9DxX7Ko46fyN8AYfsr7djESCX6YT6oKTbLC93XqLWYvK+/Tlvs9QisVhbwIUMQdNVyqpkaMhPjBOe/6vTd5bv0+TVgyVYCnDOW8TzrzkcAGszvqg6TxegyhNlt9eEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513351; c=relaxed/simple;
	bh=+yfHTWgKgLh790EbNhkjVUsRVD0YRzyvN4sLTAprGas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHWZ68IgHFAfyv1i+Tlu4YTwmINtaP5pNmAE2mMYsDGF1KwGvNhIPXnRMRzuAwCSOG095ePSysExCpMA3oCOT25d+hZuijEaSaF2dvGQ4oFptqFYMEFRWykhq3V2dokiUB6jnNRkErHHiTtHhJkxvDIheqIYrzykJub8F3FSRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mgyoAEZr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mgyoAEZr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C31Y882284959;
	Wed, 12 Aug 2026 05:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=isD5y7pJIlIHSlzmA
	ozVo2wF0pUCCRpOYT3tASXOZsI=; b=mgyoAEZrMUe2G2poM143ikgb9es5YZyfw
	yZudXVCXDEglaIZhd/ea5vdfxuxp4uhUxlFsZuODMQB4sRttPAeIGtSt9hv3zslU
	KIoyK/P0sqZ8kyGgNN9ChlOHRxDMQyIbk35rv13zsCyPLUgJSFRJYCLvcWm7Q5c1
	HvW6FScumXjIvIV13cDyxlttcESH5WbhXvxdBVTBQHcVmOt4jfDzLbI9cWX15uq0
	iNSwpGvxAqPFW0hG56qH53uMWrwNPYjwGgkNcWSn8BIBmTO2/l7R3gg1qJ91RCt0
	3Ki5a+hUhJpHRswGcyFNOURxBE12glLR9r9ai7krk6y1DrMFSBLVQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9s1eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:42:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C5fGWd010356;
	Wed, 12 Aug 2026 05:42:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gcj39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:42:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C5g8sM38469986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 05:42:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B636720043;
	Wed, 12 Aug 2026 05:42:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CA3120040;
	Wed, 12 Aug 2026 05:41:58 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.217.151])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 05:41:58 +0000 (GMT)
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
        virtualization@lists.linux.dev
Subject: [PATCH v10 09/12] virt: Introduce steal governor driver
Date: Wed, 12 Aug 2026 11:10:30 +0530
Message-ID: <20260812054033.95658-10-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812054033.95658-1-sshegde@linux.ibm.com>
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfX2q1CLil9G7Dp
 SX9HBOsChoJUri8a1royNzwX3pW32t39LhkS9xJJyLyxyVuEVx/bLh8wKKH5yXpz04HhgfVSTLG
 ytVjWibQxPc8pF9vAtrdciDUZUdib7powby/ohvBBH4yHxZwRLluCk75LtfkR68ZlDGpy9UhVCC
 6RMOAeZGaIAvRPrskDs4pBFHvB6LuEJBFPsfjZtF76b37OYeU6FrQ2VckX7+GZScitL53z04Rk9
 ioFjuqkBKg+0wPdjAl3S460Nt5TPGR2DX1N2i754fj9KcwjPWEh54S7WDRfFU0XL4jEXbw0dhnm
 JvzX7h50Mi1kHdIQ34rXf3+gd0k+0g9J99BDEBB2EarfAY8eBF4ruCZt2n/mKvgYMbo5wLOhZz+
 xVEZmYaA/IR5rARbO2E17vbC/A0lbTxhHJ+PPuDupgugP8ITcvhMtX/zSLI3a/5CW2XDPAMCe7a
 HX1UOE0KxTB8GIf2eeQ==
X-Proofpoint-ORIG-GUID: NnR1Q3IblPpoGQrK8Nc0vQk9WW3Wvokn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfXzV7Zsn7VdG1A
 /iGBWJLIzMMqpIqQWKvKedXVmMeILBEYD7bWK4bSySucpDEM4jqlxoJk5QaxD4Kwc3r/tqL6ckP
 wtrnym1DjUmFfO3SirBqFN2+H6w+MpI=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c07b6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8 a=zd2uoN0lAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=63rvlg9gmhNNS91pnNMA:9
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: 3p1qfRsmXlNtwW5d3MrZUNBuGR7ItCos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120041

Introduce a new driver in virt named steal_governor. This driver
will compute the steal time and drive the policy decisions regarding the
preferred CPU state.

More details can be found in Documentation/driver-api/steal-governor.rst.

A new kconfig called STEAL_GOVERNOR is introduced in subsequent patches,
which enables this driver. This driver will select CONFIG_PREFERRED_CPU.
This makes configs driven by user preference/configuration.
When the driver is disabled, preferred CPUs remain the same as active CPUs.

The file layout of the driver is kept simple for now. The code is in
drivers/virt/steal_governor.c, and the configs are part of
drivers/virt/Kconfig.

The main structure of the steal governor contains:
- work, delay: Deferred periodic work function variables.
- steal, time: Used to calculate deltas during periodic work.
- interval_ms, high_threshold, low_threshold: Tuning knobs for the
  steal governor.

While there, add MAINTAINERS entry for this new driver.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 Documentation/driver-api/index.rst          |   1 +
 Documentation/driver-api/steal-governor.rst | 137 ++++++++++++++++++++
 MAINTAINERS                                 |   9 ++
 drivers/virt/steal_governor.c               |  68 ++++++++++
 4 files changed, 215 insertions(+)
 create mode 100644 Documentation/driver-api/steal-governor.rst
 create mode 100644 drivers/virt/steal_governor.c

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index eaf7161ff957..0a973b59cba3 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -138,6 +138,7 @@ Subsystem-specific APIs
    sm501
    soundwire/index
    spi
+   steal-governor
    surface_aggregator/index
    switchtec
    sync_file
diff --git a/Documentation/driver-api/steal-governor.rst b/Documentation/driver-api/steal-governor.rst
new file mode 100644
index 000000000000..672eeccabfe8
--- /dev/null
+++ b/Documentation/driver-api/steal-governor.rst
@@ -0,0 +1,137 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Steal Governor
+==============
+
+:Author: Shrikanth Hegde <sshegde@linux.ibm.com>
+
+Introduction
+============
+
+The steal governor is aimed at mitigating the Noisy Neighbour problem
+which occurs in paravirtualized environments with CPU overcommit.
+The performance of a workload running in one VM gets degraded by
+the activity of other VMs on the same host. As a result, all VMs
+collectively make slower forward progress.
+
+In such systems, high utilization in all VMs causes the hypervisor to
+frequently preempt vCPUs. This vCPU preemption is expensive.
+To mitigate this, the kernel aims to restrict workloads to a subset of
+Preferred CPUs to reduce physical CPU contention.
+A detailed explanation of Preferred CPUs is available in
+``Documentation/scheduler/sched-paravirt.rst``.
+
+The steal governor selects ``CONFIG_PREFERRED_CPU=y`` which enables the
+scheduler core infrastructure to move the tasks to Preferred CPUs where
+possible. The driver controls the policy decisions regarding the state of
+preferred CPUs. That is, this driver decides which CPUs are preferred
+and which CPUs are non-preferred.
+
+The driver code is available at ``drivers/virt/steal_governor.c``.
+
+Core idea
+=========
+
+steal time is an indication available today in Guest which shows contention
+for underlying physical CPU. Use it as a hint in the guest to fold the
+workload to a reduced set of vCPUs. When there is contention, steal time
+will show up in all the guests. When each guest honors the hint and folds
+the workload to a smaller set of vCPUs (Preferred CPUs), it reduces the
+contention and thereby reduces vCPU preemption.
+This is achieved without any cross-guest communication.
+
+Steal governor driver effectively does:
+
+1. Periodically computes steal ratio across the possible CPUs.
+
+2. If steal ratio is greater than high threshold, reduce the number of
+   preferred CPUs by 1 core. Ensure at least one core is left always.
+   Skip changing the state of offline CPUs in that core.
+
+3. If steal ratio is less than or equal to low threshold, increase the
+   number of preferred CPUs by 1 core. If preferred is same as active,
+   nothing to be done. Skip changing the state of offline CPUs.
+   This helps to handle cases where few CPUs are offline in a core and
+   those offline CPUs will not be marked as preferred.
+
+4. Ensure preferred CPUs is always subset of active CPUs.
+   On feature disable it is same as active CPUs.
+
+This feature works best only when all the VMs enable the feature as
+it is a co-operative scheme. If a specific VM doesn't enable this feature
+it may end up with more CPUs than others, still should lead to better
+performance when seen from system view.
+Those who enable this driver must ensure it is enabled in all VMs.
+
+Module Parameters
+=================
+
+interval_ms
+-----------
+
+How often steal governor checks for steal time.
+Default: 1000 i.e. 1 second. Value should be in between 100ms to 100sec.
+
+This controls how fast steal governor driver reacts to changes to the
+contention of physical CPUs. Since it does a fair amount of work, setting
+too low may have overhead. Setting it too high might render it ineffective.
+
+low_threshold
+-------------
+
+lower threshold value in percentage * 100.
+Default: 200, i.e. 2% steal is considered as low threshold.
+Can't be higher than high_threshold.
+
+This determines what values should be considered as nil/no steal values.
+When steal governor sees steal ratio is less than or equal to this value,
+it will increase the preferred CPUs by 1 core.
+Using zero might cause oscillations.
+
+high_threshold
+--------------
+
+higher threshold value in percentage * 100
+Default: 500, i.e. 5% steal is considered as high threshold.
+Can't be lower than low_threshold. Must be less than 10000.
+
+This determines what values should be considered as high steal values.
+When steal governor sees steal ratio is higher than this value, it will
+reduce the preferred CPUs by 1 core.
+
+Limitations of default values
+-----------------------------
+
+Because of the vast diversity in VM configurations (e.g., highly populated
+vs. sparsely populated CPU masks, few offlined CPUs etc), the default
+thresholds may not be optimal for all systems. Users may need to tune these
+parameters based on the system under test to achieve the best results.
+
+For example:
+Possible CPUs = 128 and Active CPUs = 8
+Steal on online CPUs = 50%
+steal ratio: (50% * 8 + 0% * 120) / 128 = 3.125%
+This would fall in between and default values won't work.
+In this example, if one wants effective 2% and 5% limits, then set,
+low_threshold  = (2% * 8 + 0% * 120) / 128 = 0.1250% = 12
+high_threshold = (5% * 8 + 0% * 120) / 128 = 0.3125% = 31
+
+Using possible CPUs helps to handle spikes during CPU hotplug as the steal
+time across possible CPUs is a monotonically increasing value.
+
+Reasons for CONFIG_STEAL_GOVERNOR=m
+===================================
+
+Selecting this driver makes CONFIG_PREFERRED_CPU=y. That makes configs
+driven by user preference. Though one can have CONFIG_STEAL_GOVERNOR=y,
+It is recommended to build CONFIG_STEAL_GOVERNOR=m due to below reasons:
+
+1. Doing periodic work has additional overheads. Enabling this driver
+   in systems where steal time cannot happen is of no use. There is no
+   benefit with additional overheads in such systems.
+
+2. This works well when all VMs work in co-operative manner. When an
+   administrative user enables it in one VM, he/she will likely enable
+   it all VMs.
+
+3. User can tweak the module parameters by reloading the module.
diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..40d46ba48ecd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25914,6 +25914,15 @@ F:	rust/helpers/jump_label.c
 F:	rust/kernel/generated_arch_static_branch_asm.rs.S
 F:	rust/kernel/jump_label.rs
 
+STEAL GOVERNOR DRIVER
+M:	Shrikanth Hegde <sshegde@linux.ibm.com>
+R:	Yury Norov <yury.norov@gmail.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
+F:	Documentation/driver-api/steal-governor.rst
+F:	drivers/virt/steal_governor.c
+
 STI AUDIO (ASoC) DRIVERS
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
 L:	linux-sound@vger.kernel.org
diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
new file mode 100644
index 000000000000..d427282966d2
--- /dev/null
+++ b/drivers/virt/steal_governor.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Steal time governor driver periodically computes steal time.
+ * Based on the thresholds it either reduce/increase the preferred
+ * CPUs which can be used by the workload to avoid vCPU preemption
+ * to an extent possible in paravirtualized environment.
+ *
+ * Available with CONFIG_STEAL_GOVERNOR
+ *
+ * Copyright (C) 2026 IBM
+ * Author: Shrikanth Hegde <sshegde@linux.ibm.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpuhplock.h>
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/kconfig.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#if !IS_ENABLED(CONFIG_PREFERRED_CPU)
+#error "Steal Governor requires CONFIG_PREFERRED_CPU"
+#endif
+
+struct steal_governor {
+	ktime_t			time;
+	u64			steal;
+	unsigned long		delay;
+	unsigned int		interval_ms;
+	unsigned int		high_threshold;
+	unsigned int		low_threshold;
+	struct delayed_work	work;
+};
+
+static struct steal_governor sg_ctx;
+
+static void restore_preferred_to_active(void)
+{
+	int cpu;
+
+	guard(cpus_read_lock)();
+	for_each_cpu(cpu, cpu_active_mask)
+		set_cpu_preferred(cpu, true);
+}
+
+static int __init steal_governor_init(void)
+{
+	pr_info("enabled\n");
+	return 0;
+}
+
+static void __exit steal_governor_exit(void)
+{
+	restore_preferred_to_active();
+	pr_info("disabled\n");
+}
+
+module_init(steal_governor_init);
+module_exit(steal_governor_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("IBM Corporation");
+MODULE_DESCRIPTION("Virtualization Steal Time Governor");
-- 
2.47.3

