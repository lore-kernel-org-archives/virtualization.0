Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A23F4DE2
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654477; cv=none; b=uGbwPFSOhw0KlJwcj03Gu6H44cygeRO39kDQp745BEgHw96bHQEfJG1hoiN0qf+o155iqsi/bLTVFL5Zv72USKJKZvrc3J1vItnK+91og2+/8FGxdFEPlv0+2W8MNSHNPl54+x78eVrr25NfwbzHynusNl1kgfVxM67rsZWZBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654477; c=relaxed/simple;
	bh=f4RZbwN6k91KJukFuM0RllMcM2/UmKVh0RGHevSVTTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3RZ/+8dqh3wrERDrtQ0JAu6CMfGSFeuimFPXITS3DAWb2XZ4ndKQ5dZlMTBV8/upOPwR47oJ6IkxQNvuwRwASlfq1S1e4bRO1AlORPBrs5Y33WNmFejU7ID6D3aqNZFoCcLVLrUrWnUOjsy7cE9+pmtzrp9HCEjXw6XzsQuBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Espd9RH3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Espd9RH3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8Vj7t378190;
	Tue, 25 Aug 2026 10:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RYcC6ETWvM62aQ350
	zQgjRWtGpEKDheacDz5dIWSh/o=; b=Espd9RH3uAGR8YwiGEb5RNSALJyBSl37L
	C4k5ZO0NUIV+I97uCgQnIMsceN7WYA+9ryVtOUJ/QnsWx3H3ZRU6YegDN0W0HsZP
	leilfyFOWTx13bYzckavrhWUG7Dr1uzdwZNo1GhnNRZSalsbcaDJZ3hErwVYjMpe
	G+Pp0HPujqO59H8jopBIbxfnmdMLOhL0WRODzz63fdasXd9xpXzeI88cKB1hu0GY
	HeFYDMEhXJk3rNScohHxL9CLUCLIRH2BhA3y49y/Fnmafly9OJiYNmrKmbf/LeVr
	c7aw4WRhIoL90ADXiWPRHea35/cxudm7TDgvVriyvx2CWJC1A2o/g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx7adv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:41:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PAQK46018791;
	Tue, 25 Aug 2026 10:41:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy3ffv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:41:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PAevBD31392400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 10:40:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2E392004B;
	Tue, 25 Aug 2026 10:40:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBE0D20040;
	Tue, 25 Aug 2026 10:40:46 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.21.103])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 10:40:46 +0000 (GMT)
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
Subject: [PATCH v11 09/12] virt: Introduce steal governor driver
Date: Tue, 25 Aug 2026 16:08:52 +0530
Message-ID: <20260825103855.721013-10-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825103855.721013-1-sshegde@linux.ibm.com>
References: <20260825103855.721013-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfX7IvX29bnWoH7
 TudtEGcFOkZ1i7kf24CcTjsTfqMBC+YVB41gvWaAZY9myRsu14zb90HwsTZ19I59BvpPzjwaM6I
 h3KbgpkZG1NV27hhQP0u3932fGXbfwk=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8d713e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=zd2uoN0lAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=NU4kZiTgvjoGX6N8-j0A:9
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: FVD92pthsrjbWkJmbfGkv3mgbV1NqaIG
X-Proofpoint-GUID: hohLAkCMI_aFdgBSHzGwSrOfQLUz5EQS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfX/2eRYGOaEMLd
 MI8d4yI+9XR1K4iQZ6UvqjNH8x/FljwkhIPRNCX+7WWm7CbtDaQv5tOrp3yoyLEDn7OsHHJPX6h
 XKo+oQoCScGUUa0tn6WmWpnMOdxtU4JQWTCQ/W1eX6yPvQFLi0UGFztM6rEG0g+GuhTYheD1LD7
 OaHy7TegBRfQk4WKROUovEt/0+l7zO/jI3v9YOxoyMY4w2PFAhsKB7jCe8rWJaDORlDB2fzSNq7
 hq/s0kryHFU+TOp7qPziTUiEChLFXk0W9VvJvvkjdLdSiVOkG9N+JIj7qO4GAuAZXSble0OirMU
 mUcF5GpqQ5TCIojK7nQgp79DKDhxbGw7O0h1jOBLtprb7e7Y2M5wFuVXKmj57pIQ8OXgm1KIOcj
 y8a+wLP5tSkHRMB+ijET1oVDPiv/zVoBkILsStOZuCicCWiSqC/U9tMMDBNift47j+PCf5hm2AE
 SVsCBJsVmx8Ik+wDn3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250089

Introduce a new driver in virt named steal_governor. This driver
will compute the steal time and drive the policy decisions regarding the
preferred CPU state.

Note that this driver is strictly intended for actual guests. Hence
block it on Xen dom0.
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
 Documentation/driver-api/steal-governor.rst | 151 ++++++++++++++++++++
 MAINTAINERS                                 |   9 ++
 drivers/virt/steal_governor.c               |  78 ++++++++++
 4 files changed, 239 insertions(+)
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
index 000000000000..3817eedb38d7
--- /dev/null
+++ b/Documentation/driver-api/steal-governor.rst
@@ -0,0 +1,151 @@
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
+1. Periodically computes the steal ratio using accumulated steal time
+   across possible CPUs, normalized by the number of active CPUs.
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
+performance when seen from system view. Those who enable this driver must
+ensure it is enabled in all VMs.
+
+Note that this driver is strictly intended for actual guests; for example,
+loading this module in a privileged VM like Xen Dom0 is blocked.
+
+Workload considerations
+=======================
+
+The steal governor is useful for workloads where vCPU preemption has
+costs beyond the lost CPU time, such as lock-holder preemption, critical
+sections, communicating threads, and cache or TLB disruption.
+
+Pure CPU-time workloads with independent workers may not benefit and
+could see a small regression due to additional guest scheduling overhead.
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
+Because of the vast diversity in VM configurations and different
+architectures, the default thresholds may not be optimal for all systems.
+Users may need to tune these parameters based on the system under
+test to achieve the best results.
+
+The governor sums the steal time across all possible CPUs, which ensures
+the accumulated steal time remains a monotonically increasing value.
+However, to calculate the effective steal ratio, it divides this sum
+by the number of active CPUs. Because only active CPUs contribute to
+the steal time delta, this prevents threshold dilution on sparsely
+populated systems.
+
+The driver reduces/increases preferred CPUs by core-level. This could provide
+faster convergence for hypervisors such as powerVM. But on KVM and Xen
+convergence could be slower depending on the configuration.
+Using a smaller interval_ms could help one to expedite it.
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
+2. This works well when all VMs work in a co-operative manner. When an
+   administrative user enables it in one VM, he/she will likely enable
+   it in all VMs.
+
+3. User can tweak the module parameters by reloading the module.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..e0c27d97659d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25923,6 +25923,15 @@ F:	rust/helpers/jump_label.c
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
index 000000000000..2320cbfa4b47
--- /dev/null
+++ b/drivers/virt/steal_governor.c
@@ -0,0 +1,78 @@
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
+#ifdef CONFIG_XEN
+#include <xen/xen.h>
+#endif
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
+#ifdef CONFIG_XEN
+	if (xen_initial_domain()) {
+		pr_err("Cannot load in Xen Dom0 (Host OS). Driver is for guests only.\n");
+		return -ENODEV;
+	}
+#endif
+
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

