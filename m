Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817C3EEAF9
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902197; cv=none; b=Y+TBiaH5ZQrIP6VMu4NB9P0xxDPd8UHd3YCbaRPAMoS1tV4QhdjN7avaRZU09ydZQP34kPJJ/pXYC0Y86SH6YRGqaK5hyUxVYG7M+Lmi2tUHXmQRUFR4mqUM3GyuYQg6SpYU33J2PI+SmdzATx/Nwu6+hp5CkI6uW0ouKSh/364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902197; c=relaxed/simple;
	bh=vMCeSJV6MQCHscG5r6KOnQ98v56d4nl0k9lovG99o8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJMxosaDGUM97zd47I2jF2wWa6tO9j7yRvQIodktmmie2Ajht6WenFsDMXXPC3UCiooDhVbZDQ4xDUCFEwEhiXyHNuv/hiBIUihZyn5VHolfaDPvbG2Fi9/Gc2ocTv9HvA7PXB++MpDmYwSvrS654+m+i2u2rzhUsa5A/phCyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GgS8uQjM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GgS8uQjM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfeW51992747;
	Fri, 24 Jul 2026 14:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=glhjCI2T2okwfViYv
	uRd98jthZapwwkgAM3w4Lxz5wU=; b=GgS8uQjMeLtmm10EZavzGoi39wWt/bbEo
	CAZWODIasYhDA4ubWInD2dnjvacjcXXgQmhH4JoMut608OZKu/wpfXI7sFPzwTLV
	hW450UqxnRWHGNL8OZwxSFR0heYM+qI9vrt0hvkYhh0CIOBiY2TfXTB882iSkLmG
	1atk8uSbz4wnZzUHm3Jx1bQ9OHtpfLJKWBZjUkaRUu96d16MTZiZDD5JUpk9B6vz
	E1z+cKMuBpuXrXMP/b9bC+vGG+CD8xPF+8LRVW7cYSD+4ZRg6gkf7FiJZsIjDiG+
	7qvU/WkW+vOdtF8T+z7zw/NsfPw2jjFV+fR4OTpqQzyO0pF8XpDlQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h009ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:09:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4eCr013218;
	Fri, 24 Jul 2026 14:09:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wh9ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:09:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OE9XIZ28574394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:09:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E0F720176;
	Fri, 24 Jul 2026 14:09:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 376EB20171;
	Fri, 24 Jul 2026 14:09:25 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.20.178])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:09:24 +0000 (GMT)
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
Subject: [PATCH v9 08/11] virt: Introduce steal governor driver
Date: Fri, 24 Jul 2026 19:37:29 +0530
Message-ID: <20260724140732.2683314-9-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a637223 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=8b9GpE9nAAAA:8 a=YbEHxgcznFVOlIjCzhQA:9 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: qYpjejyhImixNt4nEuTDtof3MKnDyL9i
X-Proofpoint-GUID: B8Xp6WrxfRC86bvY3lWWH3OvtY2ABeSQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX9RzxTKes2Hsh
 bAijak6xmHzPeKBj7g6LoY5lmbJdo/pW+FhygbTxZVWcpZtSi7cnByFnZCLUvdTrH3jDwchN0L0
 jrc9EXftXOLs3QgpdT2h18dJJ3mOzcYepM4/dGMk5b8jx20dHxXALzq/lAefuZ23H+MKRkLTRYY
 jaAZdntt9gRDbdsdC+wZJer5sXQbqQ8bVemNnBzOi0nesZH6nB9fSXN4TzqbSVdGkWwD9pviBU6
 DoqamVx6hsWwgmHIgHE/9l7PHHk6hLqJPV8LUvnHn1Q7BS8JzX1ToNYxhpWs0VitUHEgSTjwNpg
 7Of2rwtrgwOlfK9FRtughVz73jZlGgrvh2VPIFh/jbl+d4ScsxAMprDo5Vwlh2VVINOC/NTC0HW
 1saW9msXPdv1kLh77mueqYTEckQYDHdGnONDWc9JBGQoBPvVAx/vqr8UER9jFwsr8oW7sZsQb7x
 ms7BFYnMeLSkYvHxlSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfXyhQKiNt8sHLr
 nyBGEXzIqIIFxhvd9q3nWFSASFsr7MdRgmrCVW961BX4CFuK/niE8+n1YQqdXh+JfrnVMVfy0Di
 AxOoAWRCTiqIM8TtuZ/MZB1lYykSkJA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240124

Introduce a new driver in virt named steal_governor. This driver
will compute the steal time and drive the policy decisions of preferred
CPU state.

More on it can be found in the Documentation/driver-api/steal-governor.rst

There is a new kconfig called STEAL_GOVERNOR which is introduced in
subsequent patches. That driver is going to select PREFERRED_CPU.
This makes configs driven by user preference.
When the driver is disabled, preferred CPUs is same as active CPUs.

File layout of the driver is being kept simple. Everything is in
drivers/virt/steal_governor.c and configs are part of
drivers/virt/Kconfig.

Main structure of steal governor has,
- work, delay: deferred periodic work function
- steal, time: To calculate the deltas in periodic work.
- interval_ms, high_threshold, low_threshold: debug knobs of
  steal_governor.

While there, Add MAINTAINERS entry for this new driver.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 Documentation/driver-api/index.rst          |   1 +
 Documentation/driver-api/steal-governor.rst | 118 ++++++++++++++++++++
 MAINTAINERS                                 |   9 ++
 drivers/virt/steal_governor.c               |  68 +++++++++++
 4 files changed, 196 insertions(+)
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
index 000000000000..a343ed6c7ff6
--- /dev/null
+++ b/Documentation/driver-api/steal-governor.rst
@@ -0,0 +1,118 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+Steal Governor
+==============
+
+:Author: Shrikanth Hegde <sshegde@linux.ibm.com>
+
+Introduction
+============
+
+Steal governor is a driver aimed at solving the Noisy Neighbour problem
+in paravirtualized environments. The performance of workload
+running in one VM gets affected significantly due to other VMs and
+combined they make slower forward progress.
+
+When there is overcommit of CPU resources, i.e. sum of virtual CPUs (vCPUs)
+of all VMs is greater than number of physical CPUs (pCPUs) and
+when all or many VMs have high utilization, hypervisor won't be able
+to satisfy the CPU requirement and has to context switch within or
+across VMs. I.e. the hypervisor needs to preempt one vCPU to run
+another. This is called vCPU preemption.
+This is more expensive compared to task context switch within a vCPU.
+
+In such cases it is better that combined vCPU ask from all VMs is reduced
+by not using some of the vCPUs. vCPUs where workload can be safely
+scheduled which won't increase any contention for pCPU are called as
+"Preferred CPUs".
+
+See more on "Preferred CPUs" in Documentation/scheduler/sched-arch.rst.
+Driver code is available at drivers/virt/steal_governor.c
+
+This driver makes CONFIG_PREFERRED_CPU=y which enables the scheduler core
+infrastructure to move tasks to Preferred CPUs where possible.
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
+1. Periodically computes steal time across the system.
+
+2. If steal time is greater than high threshold, reduce the number of
+   preferred CPUs by 1 core. Ensure at least one core is left always.
+
+3. If steal time is lower or equal to low threshold, increase the
+   number of preferred CPUs by 1 core. If preferred is same as active,
+   nothing to be done.
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
+Default: 1000 i.e 1 second. Value should be in between 100ms to 100sec.
+
+This controls how fast steal governor driver reacts to changes to
+the contention of physical CPUs. Since it does a fair amount of
+work, setting too low may have overhead. Setting it too
+high might render it ineffective.
+
+low_threshold
+-------------
+
+lower threshold value in percentage * 100.
+Default: 200, i.e 2% steal is considered as low threshold.
+Can't be higher than high_threshold.
+
+This determines what values should be considered as nil/no steal values.
+When steal governor see steal time is below or equal to this value, it
+will increase the preferred CPUs by 1 core. Having value as zero
+might cause oscillations.
+
+high_threshold
+--------------
+
+higher threshold value in percentage * 100
+Default: 500, i.e 5% steal is considered as high threshold.
+Can't be lower than low_threshold. Must be less than 10000.
+
+This determines what values should be considered as high steal values.
+When steal governor sees steal time is higher than this value, it will
+reduce the preferred CPUs by 1 core.
+
+Notes
+=====
+
+Selecting this driver makes CONFIG_PREFERRED_CPU=y. That makes configs
+driven by user preference.
+
+It is recommended to build CONFIG_STEAL_GOVERNOR=m due to below reasons:
+
+1. Doing periodic work has additional overheads. Enabling this driver
+   in systems where steal time cannot happen is of no use. There is no
+   benefit with additional overheads in such systems.
+
+2. This works well when all VMs work in co-operative manner. When an
+   administrative user enables it in one VM, he/she will likely enable
+   it all VMs.
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

