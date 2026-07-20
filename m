Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19F0446041
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568234; cv=none; b=UY+dvNZrccr+sr0dXIFB/4a1D47nTQ/QtFMONgkPRjMpS4kr9OwoTeX6oh5rDfxktl6nVex233MDLykaYMPSl79W9hQyYz2bcCQ1MXX7NTRpDiwKOXRfSMUnT5CxRF7TqaiJAoBudnNbiO3B0ZfhsrQC3e35QaXUcNA/B3VpMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568234; c=relaxed/simple;
	bh=gmpHwEuFtj2beAn+ZAbelKhxkrT6blFXZd5T1X5Bdkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBbHwh2PokDP2cEFEvbavjgoH+yysFOSLgKt/7TSzgtJM1xxi/1V3enCoLh8WqTGcUUSb6dW0Dh43wQ8n7pscHlXOT8k/VZ24pcAbWBfiWvUaxrNETNwUFwrmeMr72UemsVjB6ivQ7Sy1ZCwRnIGdRnPiPfkXSjqZUfVdcJf+Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JW6ej23F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JW6ej23F"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBkR82816018;
	Mon, 20 Jul 2026 17:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sajGA6
	s6Wp3SH4D8i6yR6GOXW8i4W+wUtSmULeZX5G0=; b=JW6ej23FWnpjHK+GbIu98p
	NSdjN2G/fqcU/xlpbcrKb/dEYuju0CfJ1ZB1Ts1mLEDDvcC1ycJS162kBkFAVpEu
	hpV1VfOJ9Nh0zImzezwT5ME0uki441l2QQT3dfwqvukZqlZAU6xTo4+V+OjDyMNd
	qy/nGCSpjOL3Njw4sLxDNakSPAHHCKddsKzBpButd6kJvu41zWGowLQStobsrVhc
	zfoLXy4pxp3P6muvbHeruDLX2W+/J1BqOPTvmTBbxFP8aQ7cr8wu7Hb11Kn1vpMb
	AfEKs0LR93RkkbWrTg9ih5KBs8dMmn5mb56pm+H7ZOotMpd0cgwhrTwCz7Wqn0kg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790rq4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:23:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KHJvFb002533;
	Mon, 20 Jul 2026 17:23:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpxsf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:23:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHNPrO53084420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:23:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 436722004D;
	Mon, 20 Jul 2026 17:23:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E04B20043;
	Mon, 20 Jul 2026 17:23:17 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.17.130])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:23:16 +0000 (GMT)
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
Subject: [PATCH v8 02/11] cpumask: Introduce cpu_preferred_mask
Date: Mon, 20 Jul 2026 22:52:41 +0530
Message-ID: <20260720172250.2257582-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720172250.2257582-1-sshegde@linux.ibm.com>
References: <20260720172250.2257582-1-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: twjcrRyG2Sk2wVmzk5G8BrlS44HZsg4L
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5e5992 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=9QGdkmv71c8RgJbqbJ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX797zaaLBIOS/
 EbIwH4opNPgcl7BuEK2SL8MqwSYPcmjv8t3wG97b5fhAT8HkD/dct1CLA3UK8VPGD7eRW4uO9aN
 hcH8fsnKFvTZk4qzRuzOt+7gVbhnNCo=
X-Proofpoint-GUID: uGct0AJ9iawiqx2HSB-ZtlN5MI8tCm1o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX8A5zuZlMBC4B
 UZATZXMaV78mKseALWngCKLklhk59b/67bElas1lXTirRmdkPrHr8rEdKL71fzCuw1ryQFrBW7i
 IHGaPRaJyXvuuNZM2pHja3x5ER3zIVRJKNnijVswZDWilERoHG9PXW2DMFsCjms6bX2e1ECtVbg
 vrCGd9zeaHLVYgaXscljmxdWSI6L8+j2YOLED8avKNx5fu0uFWSxsEOvMVwQGvMDBuEdnXRq4kf
 GuI6oWZRbINTVPCabIrFFLXTGl3BTp6vdeqPgXYrPk4m4qVhMs2BFZmLsfeFGJ30M/kt334367u
 OGCJvb7ZVJvX8inUMrfhL/Vkl1IAl6pZw4/jAdSx9MKH5Y8BtuLK5zrxed+TQq6bd7K8CmjDcjB
 V9TAm9KgBcj9afId1yjjky0Jul19wLZeBLFLjvQulbCgP+p47Q+cZ2Kpj9pe3iyCvWeuEjmC3xH
 pjyQBWE2bZLcrYfDQxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200191

Provide cpu_preferred_mask infrastructure. Define get/set macros
which could be used to get/set CPU state as preferred.

PREFERRED_CPU config will be selected by the driver which handles
steal time values. It is going to set/clear preferred CPU state.
This driver will be called steal_governor and it is introduced in
subsequent patches. It periodically samples the steal time and
decides on preferred CPU state.

A CPU is set to preferred when it becomes active. Later it may be
marked as non-preferred depending on steal time values with
steal_governor being enabled.

Always maintain design construct of preferred is subset of active.
i.e. preferred ⊆ active ⊆ online ⊆ present ⊆ possible

With PREFERRED_CPU=n, ensure set_cpu_preferred is a nop and get
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

