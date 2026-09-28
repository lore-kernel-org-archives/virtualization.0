Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C438F624
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573966; cv=none; b=KtwnIzHCCr8LJO43WDwwtla+T1WVi1Ck+Yk4wMydTbRtRouk84iM/XR5hLZ9YV0BS+c2vdCVTCXReofDEUJKRrSew2fUUkKN8Yu6gJSr4HK5XZrUl8w32B/HlSQAAQ8dar2oVk0WB7hGhubbEGF0GvOoZJ6QQaqpuHATLqZ6kDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573966; c=relaxed/simple;
	bh=cCcN25wxQ0amDxXfkakTvCLp9vaOSJu+PcSRy4xXwT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdGiZaXiK3AGjU5JnhF3retrJvnK8KeicoDW9/XaNbqrJZFOC3FtXVX8eu3yteX08ikHomr/LH7J2i0pjgN5dKKVavsPATJ1xjluHC1wAGCYn+3M2wgUh4+8mqxmO20Ss7lSjU6IRU/hDOSvDeBObbzzTQEMgCew6LywiyPCQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rFJoJcYq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rFJoJcYq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RGWOGS244825;
	Mon, 28 Sep 2026 05:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XRlAaDFrmNDeJHVPL
	dO791mIaiCLsR4lZg/ONlxLNp0=; b=rFJoJcYq7wPjkVNzEUZG3aqHEIYWutzUK
	wzwdHwFyJaX1h4Uo9tQgIqYOawQs/xWXW48gmcVG9LlQx25YD3P79gduxPVcw1CG
	MN1za9Cj2AAUYwYGe+c0U6Alqc3DllZcV/u4VmltTdbOHTzgUQUR2qdz5FWhfayY
	DRMNZOBFAfhgWQaNv5ixl1Bx2JKlifmn3lNYNcWKnSuEjVscNYcsWmuAhzan6Kh9
	I6Nm6cdkhQuaq74elLxnJo13D3ZTrKmzVBb8davfJ+wmy/LmYJpUcA38UCCPt3rK
	SjdGyUB0hoQAU9mx/uGfvJ/fuGHQUZAsSyzSS1jMV2/6NpsXW5+2g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s4ygd6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:39:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S3FXN72024361;
	Mon, 28 Sep 2026 05:39:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw3wsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:39:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5curp48431416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:38:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D051520043;
	Mon, 28 Sep 2026 05:38:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 796B320040;
	Mon, 28 Sep 2026 05:38:45 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:38:45 +0000 (GMT)
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
Subject: [PATCH v14 06/13] sched/core: Try to use a preferred CPU in is_cpu_allowed
Date: Mon, 28 Sep 2026 11:07:21 +0530
Message-ID: <20260928053728.797539-7-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX48bCQTaZfK1T
 ViFblsbB5NoI1zmk1j1q77+m+83AjBW4SKFEXksfSzRrMJoQoRSIrtV8Mnv5BvMuiIkkf8iVKEY
 VpsAj+XND/ycyPijUnancJ0/6A24p7o=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6ab9fd76 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=xlrYe_syFdJcAglVzgYA:9
X-Proofpoint-GUID: lxQbB7vwlYLEmCs_F56N1raLOqBTBzVD
X-Proofpoint-ORIG-GUID: WfFh8Be1OCZjNYGT8X0DYobdNiRo1wrU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX4ync0jFq9vdA
 p5K29yZ2JXkS4+iJ8cc5VOgzBvOR8J5VUtVYl/nfYnNZeuqzYY9o4LtEpzRwN9wZGqVKnYWVbUu
 TxnhQ3dvtuwxA+ouBNrsq4OAZzsUPJ8HQIsP+7atzKvIhqS9xNSdkuhdGc2RNr8rDeQFjLLcoMh
 xrdQjQsJei1+QPA8nFJBKXd3mKXL2Fxa5vxXc6onLl7YM0PgoDHc2FzIXhnFx5Cxz23rFruH3f6
 1mAfDFNSVY30onkPsAnzqhWPICNSuCd4uT1Xo4mJfRNm036tS3SMFKUxY7o1OZdw5aHt+dWXDZn
 x9GB+cvQ3x+XfY5uYcnxZL2VS8xnnXcVf4nB61AFyl7iBawkeZuvSTv7Qjnibf5PH6osWGO7L74
 e/juIYikg1khOu56paN9I8MNg8A/O1WaXP8wLwRjGGxSJc+QQPVeXTeHUQbOJV2DNwjR/ByOo7V
 C0cS91HMyTujUrE8l3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280022

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
 kernel/sched/core.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0183c75d7d51..04400f934cc7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2504,6 +2504,24 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 	return rq->nr_pinned;
 }
 
+static inline bool task_can_migrate_to_preferred(struct task_struct *p, int cpu)
+{
+	/* No need to migrate from a preferred CPU */
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
@@ -2519,8 +2537,12 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 		return cpu_online(cpu);
 
 	/* Non kernel threads are not allowed during either online or offline. */
-	if (!(p->flags & PF_KTHREAD))
+	if (!(p->flags & PF_KTHREAD)) {
+		/* Try to use preferred CPU if task's affinity allows */
+		if (task_can_migrate_to_preferred(p, cpu))
+			return false;
 		return cpu_active(cpu);
+	}
 
 	/* KTHREAD_IS_PER_CPU is always allowed. */
 	if (kthread_is_per_cpu(p))
@@ -2530,7 +2552,11 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (cpu_dying(cpu))
 		return false;
 
-	/* But are allowed during online. */
+	/* Try to keep unbound kthreads on a preferred CPU if possible. */
+	if (task_can_migrate_to_preferred(p, cpu))
+		return false;
+
+	/* Otherwise, they are allowed to run on online CPU. */
 	return cpu_online(cpu);
 }
 
-- 
2.52.0

