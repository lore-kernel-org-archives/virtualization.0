Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7B3F3285
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417238; cv=none; b=HWrfeRoDbhfQWXoudSJ5PSR78wNmVqa2zn76e5T6xHyFS1ZO/PevKrcKhFLdPRiIYyQKmXUEVobjvLiDNYw5F5PueNFlZlwqFXqCpUSVlpNrh1wBAAwdmGbE4SOpZOcBhsetVjqUqAyRSFPR8T9gcZs99+tfTbQdHDUe6DT5yoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417238; c=relaxed/simple;
	bh=97yJ0THLB4cf6SqyTlFhdn7NOun/2YQV++5NA2pinEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1QPeWESGd4uBcaSFsdQKYRO4trF34dvYCZwvHsYWuAmq0J+5okPKNnEQruF2yh9zWDZySzepCNSTHRj+V73tKeR6Bx419UF9sip6aed8A3pUK2Zj9BptTzaCKokkWMefx+YxaGQz3JZWSntXvol4NLId1VUzXSRmab/M/xMx3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qmQdfL8r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qmQdfL8r"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361R062187826;
	Thu, 3 Sep 2026 06:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nUq4ue
	THD/OEH31225VtVI5W8hjEc/+402p4LxaJaHc=; b=qmQdfL8rTNKrvytL5fkhl3
	odLFItYOSru5U8OcDXwjnMajCPKEfIoGuRm9N9jYhYEMq1m3OYkE0eD2TW6h5EB/
	1jnHFme7J1QEYgHxP2oKgA77b/Wsp9UwiLlIRHUMgVtGmqPSSb4cGaf6e6eXCo3I
	iZl65KCZrBdTq4qDRp/+CaoA9LGKOz9QrYmI1tYZX7oSF+L7T04yyVfx2zYMsYo3
	ef0NkSAU2WDXpKOqNSjMKz7cF3kAxNyE2aIARqrwpAvo9n99cmFarWT7OzS4xXVX
	QgaejDMs146A+hif2+jZzTR5jjX+gk7TXy3LLIWUF9nmcqpqZkOM3z3l8lqZ0NVQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5udac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:33:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6836QMo7003031;
	Thu, 3 Sep 2026 06:33:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjaprb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:33:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6836XUPD51380500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 06:33:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18B5520043;
	Thu,  3 Sep 2026 06:33:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9CAA20040;
	Thu,  3 Sep 2026 06:33:21 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.27.193])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 06:33:21 +0000 (GMT)
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
Subject: [PATCH v12 04/13] cpumask: Introduce cpu_preferred_mask
Date: Thu,  3 Sep 2026 12:02:31 +0530
Message-ID: <20260903063240.268775-5-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903063240.268775-1-sshegde@linux.ibm.com>
References: <20260903063240.268775-1-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9914c0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=LLUen9C-ZHFwCquRYTkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wfkPrL5O0k4eMdWtB4rJYlKfFeiUVuWZ
X-Proofpoint-ORIG-GUID: aT0ZW2IRkBPDiV6tMXTa4lpT-4irK_Uq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfXx00cLt0jHqwL
 RqFVOK1rcmdX7cosP0eMC9/2Hy7qFxD2Ne8et2+z0RV29ikdxM8wAbltTF37vTqVJm/YhLpC/zz
 ZSnu84Z5C4fo0aIJRNAMZDCTpefxcko=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfXx0ACmEkuoJX4
 wA5XvfKNARYp/+TwIrAr3T2sJi8HUMMbx/M0IJxZdDgxxPaMBFowsWGpSbCjC3UcnuXrIIxLwux
 wT66Ly3U/MB/qNkWJCKT0l8zg6OM4S2P3A4vklRfPk1K3y4S2T41dMMGtGqlYcG1qjc/uiv6yWF
 Jd7vfx6dnMN2b80tBkqBP+zNSXpEPc+Buu1ZTZSTyq5zURq3w5l743OcMo/w3RX1PbbMKoa7rRo
 GoGhisCVbwtfmAE2uNx50uR95uqxZlxYBHS+RqTYscmYeoHVqnD5yxV4V1aUOJtzA1kuWYKjjMQ
 +I7ITxpZL5yyvyc19EsO88D3+t+gB3PRW0k6fXOS3H7VL+Z4EB9x6V3Gmbco3k8eTJYinRFrN6i
 ql+GOSuTKu5VQFgu9f39u9a0aP+3/MfbuWbpFS2WRYIbJ/jS+z9WrPEodYWB0LVUhWV/Z29UadJ
 jin0TVeD57Ld5QMYVVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030057

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
index 7c8f16797f94..bf89bb3f30f6 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -121,12 +121,20 @@ extern struct cpumask __cpu_enabled_mask;
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
@@ -1181,6 +1189,12 @@ void init_cpu_possible(const struct cpumask *src);
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
 
@@ -1275,6 +1289,11 @@ static __always_inline bool cpu_dying(unsigned int cpu)
 	return cpumask_test_cpu(cpu, cpu_dying_mask);
 }
 
+static __always_inline bool cpu_preferred(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_preferred_mask);
+}
+
 #else
 
 #define num_online_cpus()	1U
@@ -1313,6 +1332,11 @@ static __always_inline bool cpu_dying(unsigned int cpu)
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
index 985aea617cfe..edc067a0c422 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -194,3 +194,7 @@ config SCHED_CLASS_EXT
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
index 5a61650f12b7..a689a0cea4eb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8582,6 +8582,9 @@ int sched_cpu_activate(unsigned int cpu)
 	 */
 	sched_set_rq_online(rq, cpu);
 
+	/* preferred is subset of active and follows its state */
+	set_cpu_preferred(cpu, true);
+
 	return 0;
 }
 
@@ -8595,6 +8598,8 @@ int sched_cpu_deactivate(unsigned int cpu)
 	if (ret)
 		return ret;
 
+	set_cpu_preferred(cpu, false);
+
 	/*
 	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
 	 * load balancing when not active
-- 
2.52.0

