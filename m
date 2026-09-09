Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC3566C70
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962282; cv=none; b=fKHoywHV7YwMYERfIaEdGRczEqRcMgjMr0uuigU2kX06hY5Mu4WtLQkVowQsMLlNYtwu/6zXAfe9Z9tYh+3Asoj/1yh9wz3+9x6s0P4/2w56bA8rq12WGXbpN39plIBk9DC4cKXp71JOR+oPsC/goV7W3yRSC7cL7+18gj2udyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962282; c=relaxed/simple;
	bh=pcimYOOL6+P+IW6Ux7ERwm14/LNW4GEhMJ81/gPpXUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGmpz6OWHkSdOTmlYSQNjJWN/3Vu6S5E92DOaVyAtVwwWBy/U/5THsLXQoUajdRTQneijACXM6NdxCQQkM7hMGLdBVT5zj1FHa9XupcUjM53az0ezwjfAIMcX8B3t42gSosNhd9AM6jiA15ca/bhpqjLYcwy9KyDcqWg9NjOW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FBamveQf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FBamveQf"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1OHi3817316;
	Wed, 9 Sep 2026 13:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yzjj3BRODohMppU0o
	Q0SJfycz1Tb29sNFQoAAx+sX5c=; b=FBamveQf1X8ox05zrGUwBQ75tvvz0oVdo
	PFgBvHw7TpOBO0ediiojna+wz9GwHNEsyTq8GBtr8ZYNYTB93l3nUy1NEVFCp2jO
	yHpWd+lzCKoUKxVDI+iMch3wZ5PCcKRxyOOMHgVGiHbz4wLYC/xzIFAwNlPz1IYz
	gz6L4BUUvPwO/Sv1iKCQqDTvXfh9D4w4HdMN+cgvH8NZvDzuJBufhky86F3bGQwk
	OaFMwIwiXHBF0JTnnvrdfEFobdl/kpSeB6wfZ8p33PJIA/W2deJWx+JouBEnRiXP
	HGBmUNLwdQs7EkTIcRahgWbcmsjUnCMPHBBhMOYn63bClTUDwkQzg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf468nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:57:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689DuGv1026483;
	Wed, 9 Sep 2026 13:57:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgjex6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:57:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689Dvd1h45351370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 13:57:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B361F2004B;
	Wed,  9 Sep 2026 13:57:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5112220043;
	Wed,  9 Sep 2026 13:57:28 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.210.73])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 13:57:28 +0000 (GMT)
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
Subject: [PATCH v13 06/13] sched/core: Try to use a preferred CPU in is_cpu_allowed
Date: Wed,  9 Sep 2026 19:26:10 +0530
Message-ID: <20260909135617.871006-7-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909135617.871006-1-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: agan9hkQNmu0nw1T6EVpTUaDLVnDUOOc
X-Proofpoint-GUID: 2Zd1QorcqOcY30UiVji6Va9hfgNQC7Te
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa165d9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=xlrYe_syFdJcAglVzgYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX0TNNS1TCsXKe
 RqAe+YObOdBq0YXiGPTBu3yUX8eE/5mcQGcHWY8JDzbLNp3v2UBY1+rLYU3O0S/BRSnAQt1YY32
 1yOerU+NJVDnzqg0GZJn8V71+Sg8ikjLpt+ll5WyfPAZNIRs/ivz8Fbu3nZ4k0W9QmkGQUNz2ln
 J+uRJEu3HEZG6GQEO69sQ0XQtqqAIv/k3Is8rpMtqVLJ22Djauc72iQ1T/kKI+4GrlcfYj60H9w
 5d23fqf1+S4QQhbcB9n4ZY9j5gbqiLSjbb4kZpKhbyZTyajwbfbHgu8kXkVbvbYL/lKDq3TqY2g
 1/SBSaWSY8SxMh6Ko7GNnKIRKJE2PH5jAA6yA+cpn9vTJLRrQJELTiDwyJidj9s2RniEdx9TDKO
 QcOw8QReOdrbKfIgxDnUNYd54w+qu08N/Y//xr7ylpkvF/5ZULwFHvQprh9A9I6CuMxy3rBrAfR
 KSyI6xtK+NkHcadh84Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfXwOTcIE9pzd76
 Myrgnn/EZvM+Qqg3RX4OyuVRRoijon3dRLIBq/BJzwnW0Svoy9XFxzjWRhKzcSEqm2rwwd8AG49
 gnCDgsfq3MeBimAUXg55nRcC/Ok1v8Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090151

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

