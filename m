Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A87E0FF
	for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513292; cv=none; b=pLtHQeA+2u+FgcZqo6NB1tyF3/lsdxRKRWvdcQDTFkYlEvOkjAvTXbNLE+9OBnUK0p2/OXyEM0kq1p5wqmGtdGwrFc7PCQdy3jKKvf4diOgzgEoKj0Px1TLQ4rdGf99e43pPVIlyeUDly891++raILbfCZtIzMuQSoVOXkXWmbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513292; c=relaxed/simple;
	bh=NHxNTsuQ5kYaOU6wiQ3qsu9Kigs6uHpexu2ofPPXkNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOZfGrVzget2xnRr3plqOI6pVzpsS95dwYt0aAqQYCJZrAUjUxEnTwjsC5WJYqJhYyW5LWdwfsDwN8/a4FoAVdPc8xl2jQOHmQIYmJ8xYhsnCE+oJFeHceYvlqiLDyXKYfQe1A4SOe5k/SFKDFfZc/5qGIdG0kA6gAdCVMCWppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=np+XEFKr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="np+XEFKr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C31dJD2313519;
	Wed, 12 Aug 2026 05:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CjMua/
	sfQJspq5hiL4ZeydI1nOj4VlT3LwXZv+NrykY=; b=np+XEFKrXs6CI/8Jwq8km3
	d5L1g4dFdyRAjD9wq4ycURIjLq1mi9PQ+5Qmspw6nQs/YxXKGZGpCpT339AoKzFt
	uzRxBG+cLy0Kuc6yJlsxMoWXXYv0KPQKGBJKj4MG7j67UgzIe7a7L4SSf4P+SyEE
	FIMHYUJt6ERQ/vmN/ij6EacN14oudv2Y5eU73L20L3IEzrPNsW4fzAUHkm0+s+R2
	gS7eWA+661CLvt76WKQcLIufXSQVs1qrDccBb6kQKsfKs6Zb7ZZ/lUSOTyGTJvHQ
	ZWUu9bnhC7SR13quB6xx9iL6Ou7fAcodDx0L94OARA+BAluO4xjp2pVMYJnI450g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw87rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:41:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C5BPRR023149;
	Wed, 12 Aug 2026 05:41:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w4t16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:41:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C5fBCx34668908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 05:41:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1609720043;
	Wed, 12 Aug 2026 05:41:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FD8820040;
	Wed, 12 Aug 2026 05:41:03 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.217.151])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 05:41:02 +0000 (GMT)
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
Subject: [PATCH v10 03/12] cpumask: Introduce cpu_preferred_mask
Date: Wed, 12 Aug 2026 11:10:24 +0530
Message-ID: <20260812054033.95658-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812054033.95658-1-sshegde@linux.ibm.com>
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c077c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=9QGdkmv71c8RgJbqbJ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 51TYTiDjmkoquLA6_SbG3yuUsJfXh3iQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfX5Pm3oVXdzO35
 qThQqZKKtxXVBnVvdfn/RQwZ9GPvbJt0WzftWVojrerC0N++PttyUJka7dJhWH85nUum8NV3T1S
 oc9g+rBgT7VB+VEU3oRPmuSaSjHL29xiKYvDdOat2Hifu7PZv5/mTPvwkRUsW8fiIBGhvQa5bJ/
 vKahxRh0aXyLK1uI1naub/ZVs1mZRsOS1fqn0qrX6vHNisG0Bjl/FSdHaT4wz/hgmhUtLVh+5Vm
 VCnyBCvJ6cwZAaYMqi8J4N9HqtWY9IH4LGTqistDP+J6J8XhpMW/nhErWk0h+Zde00yw8yBrPDL
 Z3X3M+bHnGqrftaL844QwkQQhSna2323YBbRsTyn9VQa6pEbLNyomMbE0ip5W9OLmM3ehieiBA5
 7fQcPJ/jS/nWxKgM4A4KRrppkcLH04gZElP+j6o3bR0UKGFMNaVUGgGj6qa/LxrEv95aEDQAbq2
 iRR/RV8h1fDnGsrccZQ==
X-Proofpoint-ORIG-GUID: jmD1EhkEQykSZwhGL-8AnHxc52pYxi7T
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfXz2VJoHBzbYN1
 p0R4C484tTi1STGowbHOhe5tTLnerxItNDgcZEXaWffmaX7oX75xRH/vBVLRE3ysHIQaTbuvmD0
 UHZcDK/9+9+K4zJrle8vpUR2VQTAjZ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120041

Provide the preferred CPU infrastructure. Define get/set macros
which could be used to get/set CPU state as preferred.

CONFIG_PREFERRED_CPU will be selected by the driver which handles
steal time values. It is going to set/clear preferred CPU state.
This driver will be called steal_governor and it is introduced in
subsequent patches. It periodically computes the steal ratio and
decides on preferred CPU state.

A CPU is set to preferred when it becomes active. Later it may be
marked as non-preferred depending on steal ratio by the steal_governor.

Always maintain design construct of preferred is subset of active.
i.e. preferred ⊆ active ⊆ online ⊆ present ⊆ possible

With CONFIG_PREFERRED_CPU=n, ensure set_cpu_preferred is a nop and get
method returns the active state in that case.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 include/linux/cpumask.h | 24 ++++++++++++++++++++++++
 kernel/Kconfig.preempt  |  4 ++++
 kernel/cpu.c            |  6 ++++++
 kernel/sched/core.c     |  5 +++++
 4 files changed, 39 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index d3cda0544954..34d08a3d80e1 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -122,12 +122,20 @@ extern struct cpumask __cpu_enabled_mask;
 extern struct cpumask __cpu_present_mask;
 extern struct cpumask __cpu_active_mask;
 extern struct cpumask __cpu_dying_mask;
+
+#ifdef CONFIG_PREFERRED_CPU
+extern struct cpumask __cpu_preferred_mask;
+#else
+#define __cpu_preferred_mask __cpu_active_mask
+#endif
+
 #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
 #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
 #define cpu_enabled_mask   ((const struct cpumask *)&__cpu_enabled_mask)
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
 #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
+#define cpu_preferred_mask ((const struct cpumask *)&__cpu_preferred_mask)
 
 extern atomic_t __num_online_cpus;
 extern unsigned int __num_possible_cpus;
@@ -1164,6 +1172,12 @@ void init_cpu_possible(const struct cpumask *src);
 #define set_cpu_active(cpu, active)	assign_cpu((cpu), &__cpu_active_mask, (active))
 #define set_cpu_dying(cpu, dying)	assign_cpu((cpu), &__cpu_dying_mask, (dying))
 
+#ifdef CONFIG_PREFERRED_CPU
+#define set_cpu_preferred(cpu, preferred) assign_cpu((cpu), &__cpu_preferred_mask, (preferred))
+#else
+#define set_cpu_preferred(cpu, preferred) do { } while (0)
+#endif
+
 void set_cpu_online(unsigned int cpu, bool online);
 void set_cpu_possible(unsigned int cpu, bool possible);
 
@@ -1258,6 +1272,11 @@ static __always_inline bool cpu_dying(unsigned int cpu)
 	return cpumask_test_cpu(cpu, cpu_dying_mask);
 }
 
+static __always_inline bool cpu_preferred(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_preferred_mask);
+}
+
 #else
 
 #define num_online_cpus()	1U
@@ -1296,6 +1315,11 @@ static __always_inline bool cpu_dying(unsigned int cpu)
 	return false;
 }
 
+static __always_inline bool cpu_preferred(unsigned int cpu)
+{
+	return cpu == 0;
+}
+
 #endif /* NR_CPUS > 1 */
 
 #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 88c594c6d7fc..de789b274ba3 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -192,3 +192,7 @@ config SCHED_CLASS_EXT
 	  For more information:
 	    Documentation/scheduler/sched-ext.rst
 	    https://github.com/sched-ext/scx
+
+config PREFERRED_CPU
+	bool
+	depends on SMP && PARAVIRT
diff --git a/kernel/cpu.c b/kernel/cpu.c
index b3c8553d7bd6..376d297a6292 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3103,6 +3103,11 @@ EXPORT_SYMBOL(__cpu_dying_mask);
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);
 
+#ifdef CONFIG_PREFERRED_CPU
+struct cpumask __cpu_preferred_mask __read_mostly;
+EXPORT_SYMBOL_GPL(__cpu_preferred_mask);
+#endif
+
 void init_cpu_present(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_present_mask, src);
@@ -3160,6 +3165,7 @@ void __init boot_cpu_init(void)
 	/* Mark the boot cpu "present", "online" etc for SMP and UP case */
 	set_cpu_online(cpu, true);
 	set_cpu_active(cpu, true);
+	set_cpu_preferred(cpu, true);
 	set_cpu_present(cpu, true);
 	set_cpu_possible(cpu, true);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e7cde033a31..a45f7c308329 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8690,6 +8690,9 @@ int sched_cpu_activate(unsigned int cpu)
 	 */
 	sched_set_rq_online(rq, cpu);
 
+	/* preferred is subset of active and follows its state */
+	set_cpu_preferred(cpu, true);
+
 	return 0;
 }
 
@@ -8703,6 +8706,8 @@ int sched_cpu_deactivate(unsigned int cpu)
 	if (ret)
 		return ret;
 
+	set_cpu_preferred(cpu, false);
+
 	/*
 	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
 	 * load balancing when not active
-- 
2.47.3

