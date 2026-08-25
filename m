Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89A3F58CA
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654437; cv=none; b=NBKIA0rd9rU2DbV7eze8nthYZWhxk4Mtlpl2MMM7Kdt1/gg4Zgr3xjmSj8/GfTJRSvFLxAkwgySBjRgDVLxGMi3H7A8qzXObBcUXrrGkZYqbJvp2biaWyH5L90KNtDpEuQlHWBM8X9krn+ubsFTsnffK4rXqcpogOWAtvCQ1sF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654437; c=relaxed/simple;
	bh=BiNd8Mdg9P00eC4yhP+EJoIA/x5mEIkySM2Su1+MU/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UylUvGY3WhxXnieYZVt1GFp6Y0IyQl3WawnavTf2EOLvpbSFmEd4N4Ev0mR9nfV/7gEisnxZonAs5ozA0M8j7xNSKk8fi6Fl9b0Af3gC8zlE/5/khB5GpnXA6WmpLPfQeLwPL87UTJq/lKIvCDsHoBpHtkLOT453QOYONIYgdiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XPtpx6qW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XPtpx6qW"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8VhY3212102;
	Tue, 25 Aug 2026 10:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=huPGzYzb0L8qddyfH
	sU+EtPMbusT9LKb8JvY8Wc6gws=; b=XPtpx6qW8q7uxLXF0WindBJYuE0tS9tk+
	yjdWgWpYU82e6+M+7l1IRhUsFCc7WpPKdDDfy0WwVaJqHcqPn/Hd4NdgawJc7bs9
	Zf9Se0ZAIoFKFgJCrfFs6/ZUn5sBpn0je/QPqPpjWHVOE/Oev9Il19Gqti0kDX+A
	mHuj+w1liviIEZ3RidZ67h4H+bai57tX+rDGF1khnKUCT9r/aDg13W47VDKoepBb
	MNak4p8NpNNWzjjuzOEcZ3RkVs29kHqpUv0kjGtFll7Nlf25Zm7Gxg6MRrNPWAbG
	EAJgcMBK5KkeGnQNr1wICwjbe3HGeBUtDnWBjicFg1TI1Fwfg7L7Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hqpxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:40:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PAQJ71005904;
	Tue, 25 Aug 2026 10:40:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3juqnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:40:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PAeHRf45679094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 10:40:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5897B20040;
	Tue, 25 Aug 2026 10:40:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D63320043;
	Tue, 25 Aug 2026 10:40:08 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.21.103])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 10:40:08 +0000 (GMT)
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
Subject: [PATCH v11 05/12] sched/core: Try to use a preferred CPU in is_cpu_allowed
Date: Tue, 25 Aug 2026 16:08:48 +0530
Message-ID: <20260825103855.721013-6-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfX0KK8QhvJyzhz
 u2ir2zRg5BGl8a9Lzh+L2EWViTlbIedGFboIwsJkEgHtQ+zB4+yioi/NfvVMO/a/QDSWoC39Izd
 ZgkoWX8seqPnCOHc778T0N3r8JK2bQw=
X-Proofpoint-GUID: aLbpluOMUVAkKgYO7y018QqmbIDCULqp
X-Proofpoint-ORIG-GUID: ltJNFGTdYoPJA6MjDKfu0BEJe9vqsSXR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfX9d1wBQ8XDwHM
 dM7fep7+Ood3211dKJjrvGDAkLnk1uEx84Wkrg2GzgjD29zHjo4NWyIFrMMkB0tTLDmlD2IlbTh
 yFNuaXMQy+Cv6AZG/mkLokLYrk5hn/C1qaerzFA7i5lPx4Oa1XycrQwrVutELL6yR/Gp5Sjur1j
 7O7fn6P+v10eMOcpOaLgBOq883cDvTn9uFCHugNhUXxlDDC2ywO27CD00bKZhoMs2W1dyS8JqQx
 KsyPxiuFhMjWchwCJkoXltb4Ov5Sp6I2YPAf8XqPk5p6IpaQfrdpWE0wlPQmJ7AxvtPbF1klO5I
 kTytqKtgnHWFTeve3szTow3nVz2lMQrW+QC7A1W2ZqDZXpwdU3JHrN1qz1aySP6PlL/C61urtUW
 Vw2SgQEE346JUArhLgbaYx9Pn1ejS+9VIo4drAT613kHl7101Zxh9Po35NgUb/wgQzqk3o41CVT
 vrBxwhu5R3bbxUYapEw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8d7116 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=h9snqJY24oqFoxCgr8cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250089

When possible, try to choose a preferred CPU.

This is essential to maintain user affinities when preferred
CPUs change. A task pinned on a non-preferred CPU should continue
to run there, since this is a non-user triggered event.

If a CPU is non-preferred and the task can run on other CPUs which are
currently preferred, then choose a preferred CPU instead.
This is decided by checking if cpus_ptr and cpu_preferred_mask
intersect or not. If yes, then the task has other preferred CPUs.

The push task mechanism uses a stopper thread which calls
select_fallback_rq() and uses this mechanism to pick a preferred CPU.

This takes care of the wakeup path for FAIR tasks too.
is_cpu_allowed() is called to ensure wakeups happen on preferred CPUs.
With that, additional checks in available_idle_cpu() are not necessary.

Ignore the preferred CPU state if a task's affinity is changing and
its new mask no longer includes the CPU it is currently running on.
This ensures migration_cpu_stop() does not abort, preventing the task
from being stranded outside its allowed affinity.

Account for tasks with architecture-specific CPU masks
(e.g., 32-bit tasks on arm64). For such tasks, explicitly check against
the arch-allowed CPUs to determine if any of the preferred CPUs are
actually valid.

For the majority of cases, this would still keep select_fallback_rq()
as O(N). cpumask_intersects(), which is O(N), is called only if
!cpu_preferred. The task running there is expected to move out.
Subsequently, it should run on a preferred CPU. This becomes O(N**2)
only for tasks pinned solely to non-preferred CPUs. That is a rare case.

Overhead is minimal when the CPU is preferred.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a45f7c308329..f71317fe281d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2494,6 +2494,35 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 	return rq->nr_pinned;
 }
 
+static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
+{
+	const struct cpumask *valid_mask;
+	int i;
+
+	if (cpu_preferred(cpu))
+		return false;
+
+	/* Only FAIR tasks honor preferred CPU state */
+	if (unlikely(p->sched_class != &fair_sched_class))
+		return false;
+
+	/* Ignore preferred state if task affinity is changing */
+	if (unlikely(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr)))
+		return false;
+
+	valid_mask = task_cpu_possible_mask(p);
+	if (likely(valid_mask == cpu_possible_mask))
+		return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
+
+	/* Tasks with arch-specific CPU masks. e.g. 32-bit tasks on arm64. */
+	for_each_cpu_and(i, p->cpus_ptr, cpu_preferred_mask) {
+		if (cpumask_test_cpu(i, valid_mask))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
@@ -2509,8 +2538,12 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 		return cpu_online(cpu);
 
 	/* Non kernel threads are not allowed during either online or offline. */
-	if (!(p->flags & PF_KTHREAD))
+	if (!(p->flags & PF_KTHREAD)) {
+		/* Try to use preferred CPU if task's affinity allows */
+		if (task_can_sched_on_preferred(cpu, p))
+			return false;
 		return cpu_active(cpu);
+	}
 
 	/* KTHREAD_IS_PER_CPU is always allowed. */
 	if (kthread_is_per_cpu(p))
@@ -2520,7 +2553,11 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (cpu_dying(cpu))
 		return false;
 
-	/* But are allowed during online. */
+	/* Try to keep unbound kthreads on a preferred CPU if possible. */
+	if (task_can_sched_on_preferred(cpu, p))
+		return false;
+
+	/* Otherwise, they are allowed to run on online CPU. */
 	return cpu_online(cpu);
 }
 
-- 
2.47.3

