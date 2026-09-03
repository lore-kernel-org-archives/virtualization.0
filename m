Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3EA3E9F8D
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417253; cv=none; b=szdxZTO2n5skch+aFtAvB7ZmhASZCsfMQ10G4F2r6yAOO/SpQlpIg+gdSIuGvcpZ9gjVBUva6AfEzdBeNdpCDF2tEL7RUQR+fYqcyjJ8LfbYHvdHaD/R7joJR3Qpd7wBzRPE+8i7o1S8LpxCfAn1sAEpw0yzxwWeGXddn5wQQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417253; c=relaxed/simple;
	bh=pcimYOOL6+P+IW6Ux7ERwm14/LNW4GEhMJ81/gPpXUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WK1OC2nu73CBGlg46mx/PyqUQMDrcdP6O1cXIeayiByHu9CmTlmJqG6BjGISU/czCRec3iqQcY1DS6bJP44cedNrONBuPvP4ImRmto0wk8E4N3as7+rrvN0VyFp9HCWGSn+WDEKD0l0/wuuCopajpJXxHZaMpOMpLyGisYmeHnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z4n8u6nW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z4n8u6nW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683620pX312347;
	Thu, 3 Sep 2026 06:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yzjj3BRODohMppU0o
	Q0SJfycz1Tb29sNFQoAAx+sX5c=; b=Z4n8u6nWEPFtPL6yMq1ku5B6uUYDGdMKx
	BbX2yPQfy8exVrRrGsO/HbY840RdONH/RVtla5zRxPVkldg20tLwD70eWtXF0r2+
	2iTBynna4fs0ABqMd6wuwnJyzCZhnh+Wmmojh6rIw4iSItaB+r8ouZusAglESZLJ
	A8CjV4xnqOGw+QSF9NBL+U2TyOBNLnX9Gde0S2D2aKuJMqDUtTvNrP/9TF4xkw/5
	Qu8ctHXXGl9qi1EqAaJBYi/pJppmjBHpoFxb6kPXfPWn70kkKgQCu1ef13AhaCSu
	3ii3f+Yeq2qx6m3ujtHTIB57Hgs/Rl/dTbB2BHAQaca2Lu2dvNK1w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rkdk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:33:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6836QIAx023970;
	Thu, 3 Sep 2026 06:33:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkecms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:33:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6836Xl9Y47907222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 06:33:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9301420040;
	Thu,  3 Sep 2026 06:33:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47E7620043;
	Thu,  3 Sep 2026 06:33:39 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.27.193])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 06:33:39 +0000 (GMT)
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
Subject: [PATCH v12 06/13] sched/core: Try to use a preferred CPU in is_cpu_allowed
Date: Thu,  3 Sep 2026 12:02:33 +0530
Message-ID: <20260903063240.268775-7-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903063240.268775-1-sshegde@linux.ibm.com>
References: <20260903063240.268775-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9914d1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=xlrYe_syFdJcAglVzgYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX0K+8roSpB6GY
 h4+CzEIIoI/swSXJbFYJTi/Big4uBxe4BjScwyrhjycRhEd+6JazS0/IwNhsL0knFsGQ0nRIx/G
 GkfMFOQa06g0VM+aFxbljAUGp/4ZN49HhMHARpgekFuK+SPcpfLKqSwNkZSfIX2VDVf0aSc4/d1
 Cfk2uY7zyD6+U+8c3zdWAG+Okj0oOpDkcZeJqB/c80LrPy6NS/6ALlJ9d3qPQ0ac21v0N+uF8ci
 /K/Q82kLUbZupeqFzfG6bK9muGv1e9VAtO7Q7tzQrXmRRtJqwzxJAwBGPuHuOJRtdHkP6IzdoQc
 p7kP/OrpbNREnuutRhWNeZHACQKs2xMSibGsnJQn3OKFuzzHQAmb8fFRSaRU8soknYhUZzYSlVg
 fLZV2WcFDWHfvDCyoZGPishdUjpKtoItHu1ADl0DEqecO7IUKCTjGX94dYS3BVpdGoIQDAFATFf
 qWmJ0PHhg+3hlUKJ8Hg==
X-Proofpoint-GUID: 3PrdV094Hj3wTgsBZQAeX-dPsFCX_Sho
X-Proofpoint-ORIG-GUID: cyc1EFtu42axnfdpbpz0C8OPyEgUL55r
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfXyw3kIn/HkVMV
 5rZMbx6wBaVHfIacecSVvblGpJKfJQqtgRhkK7KPv/DP8b7XW+qt5F2XfzfiJBC9pCzzScaNI8W
 SsYKMUMmt57Qx+HWkoJnZ35YexChHIk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030057

When possible, try to choose a preferred CPU.

This is essential to maintain user affinities when preferred
CPUs change. A task pinned on a non-preferred CPU should continue
to run there, since this is a non-user triggered event.

If a CPU is non-preferred and the task can run on other CPUs which are
currently preferred, then choose a preferred CPU instead.
This is decided by checking if cpus_ptr, cpu_preferred_mask and
task possible CPUs intersect or not. If yes, then the task has
other preferred CPUs. This takes care of tasks with architecture-specific
CPU masks (e.g., 32-bit tasks on arm64).

The push task mechanism uses a stopper thread which calls
select_fallback_rq() and uses this mechanism to pick a preferred CPU.

This takes care of the wakeup path for FAIR tasks too.
is_cpu_allowed() is called to ensure wakeups happen on preferred CPUs.
With that, additional checks in available_idle_cpu() are not necessary.

Ignore the preferred CPU state if a task's affinity is changing and
its new mask no longer includes the CPU it is currently running on.
This ensures migration_cpu_stop() does not abort, preventing the task
from being stranded outside its allowed affinity.

For the majority of cases, this would still keep select_fallback_rq()
as O(N). cpumask_intersects_and(), which is O(N), is called only if
!cpu_preferred. The task running there is expected to move out.
Subsequently, it should run on a preferred CPU. This becomes O(N**2)
only for tasks pinned solely to non-preferred CPUs. That is a rare case.

Overhead is minimal when the CPU is preferred.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a689a0cea4eb..b4ef2e92d786 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2504,6 +2504,23 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 	return rq->nr_pinned;
 }
 
+static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
+{
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
+	return cpumask_intersects_and(p->cpus_ptr, cpu_preferred_mask,
+				      task_cpu_possible_mask(p));
+}
+
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
@@ -2519,8 +2536,12 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
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
@@ -2530,7 +2551,11 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
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
2.52.0

