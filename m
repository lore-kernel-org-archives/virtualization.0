Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B1375AC6
	for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 05:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513329; cv=none; b=pUaP4pMtT548wempZm1+hg9Ko2N3JIyFjLzm2MuOdoWsf6lwRbQCfNCMUNHGSGb5+pQfnMDeuIzd/rsIyxk9G173SWyyB4uWtl4lGmWjl8ZRCuTUSnX5YyaZkCnnmFsDTYNIhkH7/pv+JO5y8f4RdhRj2KKHEsrhreO4J1BmOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513329; c=relaxed/simple;
	bh=NGWM9vWEkl8FYFhxzz71q6GQPIX+zMVOKC8a/3xl3HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQRh5rvqywVJf6u9ENJHlj6Qye6e/PmJLPS2/KCui8gCfIhdgqtESQDThS1us8H/D7Yv7MOriIEUNeX7E0JwA26+FAn5g1mEv/UnVWxZMxUzXpFJO67hJ7rmNeSfl1D9hKVBzhLimC9V4ZrDMPmJr4knnLOO1hFZhV/Xj3kgPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KG9DVudr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KG9DVudr"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C31XXk2238399;
	Wed, 12 Aug 2026 05:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y5rmXjg73Xx+HPrgm
	UoEXLwpNZNmUcVBn2VJOi1Zhtg=; b=KG9DVudrMC8XweJrOj9MbraI9fHFtnmjA
	XyPdCHYiXa/nMzB5il3M/KJTajebeOb2ibvFiVskiF6OZoSNyeH3NVD9DR7JrFfm
	a/zkmwI6SKKQaxgYyuP9CnONDhbjc0s37WzVkR3v21DmUdd5smVuMYbVHEzN4rAT
	JAHHPog1MkIO6jqGyyJVsW+K9Qge/blFHIlK9Po0fLYF5Zpd/wx/oyXZa7egtLUj
	DSq6hERTerszBGHbUueBYMenF98Cn3UtoD7/Gl5Q9xlEljpwr3OHoE5DKAe2R2gp
	rnjXLiew9Lnehy25dIFtmqw0xc8CFLUBj4LpqfNmVD1ba+W3F5BJw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9gy45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:41:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C5fHcN012736;
	Wed, 12 Aug 2026 05:41:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjvpbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:41:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C5flAY33620440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 05:41:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DC8120043;
	Wed, 12 Aug 2026 05:41:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0E9320040;
	Wed, 12 Aug 2026 05:41:38 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.217.151])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 05:41:38 +0000 (GMT)
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
Subject: [PATCH v10 07/12] sched/core: Push current task from non preferred CPU
Date: Wed, 12 Aug 2026 11:10:28 +0530
Message-ID: <20260812054033.95658-8-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: rF4OcqybNF4WYKlw1759VRk-Dg09BwM8
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c07a1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=rPhwLmmYJdnLsqmuV48A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfXxUfwXImvFfu0
 LrjS2+nKSsvo6v4vBTxntlJz/XQ3lwT1Xg1j/tNsszn5y4sU+1XEDRnR3XSGozJywOMNxphyNdE
 W5IQN4Ika0FeKE65uiPCDxlffi4tIiEFXvEsARPBKNxh2zulz0zEKgoHAz+Le+2yT/fmDi9TO3o
 FpZmLHc3Juq3fB9xXjzVEy6do+tJPfITzvoaaXIuGNJU1sRYtQpASHJJU7H9riom4XEzLJ5ROrN
 tobhZP9UkG06tb0AsCRdWu2HNmOKYOUjPT1itYGSjLYhkG3ih6AZqOD1scznhjKNmmY3DCxfdt5
 BkIlY1cL8HQBIMU3hgWqY71O+AmNKNZXScZtbOz1+G3pIF3v4N85CBwvOnt4r+e+OZbdNvun+EV
 VQKXqXc+vzW/Um/jBPwN2+CSGUy32nJJg9Y9iQM+5wm/S7q0t4YOOP0J0Gu11XHTrM5o4ECKPu5
 pla1tXD5ABumMO3EgIw==
X-Proofpoint-ORIG-GUID: s3HsnTy3SAQkHNFNqWX74isZPZkIn3ev
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfX3baCurEa3Cc4
 5tqMxJTj/T3CtJZB71nGtRimkTjKVY8vNMlhZKDIxnagJdrZ46+1bD9jg9YxueVD8341xra3JYd
 R5pBB5hKDBXP86f5VpW0aflR6mAMVks=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120041

Actively push out the current running task on a non-preferred CPU. Since
the task is currently running, a stopper thread must be queued to push the
task out. However, if the task is pinned only to non-preferred CPUs,
it will continue running there. This helps to maintain userspace
affinities, unlike CPU hotplug or isolated cpusets.

Though the code is similar to __balance_push_cpu_stop and quite close to
push_cpu_stop, it is kept separate as it provides a cleaner
implementation specifically for CONFIG_PREFERRED_CPU.

Add the push_task_work_done flag to protect the work buffer.

For now, only the currently running task is pushed out. This keeps the code
simpler. In the future, an optimization may be added to move all queued
tasks on the runqueue.

This works only for the FAIR scheduling class.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c  | 78 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  8 +++++
 2 files changed, 86 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1c90bcad0a75..c51ba2979496 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5786,6 +5786,9 @@ void sched_tick(void)
 	unsigned long hw_pressure;
 	u64 resched_latency;
 
+	if (!cpu_preferred(cpu))
+		sched_push_current_non_preferred_cpu(rq);
+
 	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		arch_scale_freq_tick();
 
@@ -11304,3 +11307,78 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}
 }
+
+#ifdef CONFIG_PREFERRED_CPU
+static DEFINE_PER_CPU(struct cpu_stop_work, npc_push_task_work);
+
+static int sched_non_preferred_cpu_push_stop(void *arg)
+{
+	struct task_struct *p = arg;
+	struct rq *rq = this_rq();
+	struct rq_flags rf;
+	int cpu;
+
+	if (cpu_preferred(rq->cpu)) {
+		scoped_guard(rq_lock, rq)
+			rq->push_task_work_done = false;
+		put_task_struct(p);
+		return 0;
+	}
+
+	raw_spin_lock_irq(&p->pi_lock);
+
+	/* This could take rq lock. So call it before rq lock is taken */
+	cpu = select_fallback_rq(rq->cpu, p);
+	rq_lock(rq, &rf);
+	rq->push_task_work_done = false;
+	update_rq_clock(rq);
+
+	context_unsafe_alias(rq);
+
+	if (task_rq(p) == rq && task_on_rq_queued(p) &&
+	    !is_migration_disabled(p))
+		rq = __migrate_task(rq, &rf, p, cpu);
+
+	rq_unlock(rq, &rf);
+	raw_spin_unlock_irq(&p->pi_lock);
+	put_task_struct(p);
+
+	return 0;
+}
+
+/*
+ * Push the current task running on non-preferred CPU(npc).
+ * Using this non preferred CPU will lead to more contention
+ * in the host. So it is better not to use this CPU.
+ *
+ * Since task is running, call a stopper to push the task out. This is
+ * similar to how task moves during hotplug. In select_fallback_rq a
+ * preferred CPU will be chosen and henceforth task shouldn't come back to
+ * this CPU again.
+ *
+ * Works for FAIR class only.
+ *
+ * If task is affined only on non-preferred CPUs, no point in moving it out.
+ */
+void sched_push_current_non_preferred_cpu(struct rq *rq)
+{
+	struct task_struct *push_task = rq->curr;
+
+	scoped_guard(rq_lock, rq) {
+		/* Push the task if its explicit affinity allows */
+		if (!task_can_sched_on_preferred(rq->cpu, push_task))
+			return;
+
+		/* There is already a stopper thread. Don't race with it. */
+		if (rq->push_task_work_done)
+			return;
+
+		rq->push_task_work_done = true;
+	}
+
+	/* sched_tick runs with interrupts disabled. */
+	get_task_struct(push_task);
+	stop_one_cpu_nowait(rq->cpu, sched_non_preferred_cpu_push_stop,
+			    push_task, this_cpu_ptr(&npc_push_task_work));
+}
+#endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 26ae13c86b69..6cee31466087 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1277,6 +1277,8 @@ struct rq {
 
 	struct list_head cfs_tasks;
 
+	bool			push_task_work_done;
+
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
@@ -4230,4 +4232,10 @@ DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
 
 #include "ext/ext.h"
 
+#ifdef CONFIG_PREFERRED_CPU
+void sched_push_current_non_preferred_cpu(struct rq *rq);
+#else	/* !CONFIG_PREFERRED_CPU */
+static inline void sched_push_current_non_preferred_cpu(struct rq *rq) { }
+#endif
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.47.3

