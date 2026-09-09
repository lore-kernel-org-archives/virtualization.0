Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676955519A2
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962300; cv=none; b=BkLjgZYpm5OrgZPzM8AQfHLiylS/zKGxBysx7hYGRjxyb1PlZxm5BdENMIUqDKiILkza9vnibzkaSm882vNYmhbRSh+dVLVrKm8PcVDeJwshRh1SfuPWiotmgxKboqKYYIIwJF65XOWDVa3gPFNLpr7ftcHx9dAjEJ+ezm3SiIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962300; c=relaxed/simple;
	bh=MKzNnUi9C9nx/L1eV+TIbD60XIveXsVYaFAM0qa+nz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoOKfGLyv/wGJML/iQ0fdjLjLah7988b+/wcRfOb0GxWp8woc8MCeg/mMNoPCLGN8Zq+oJeH1E1c44okWEOAUrqxZ3YuR3NM3piEX9MaJLWVGpSS30c+kdVVJgXeWVaXD9cyoYx/KD/U+/fmzno91Br/NOiEALxFZPAbFPe+17Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=stLHcuvq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="stLHcuvq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1c4d3839630;
	Wed, 9 Sep 2026 13:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZXQkIhxhILBViE0xl
	UhZxBaRKsFtV/5uBgzscerU6vE=; b=stLHcuvq88LZaKjOu6l20Y/Ob+/GCx9XU
	XzEVwBeoTiQ0gMf5M3oQKuC107cqUpCau1R9LWudixO39EpZ6ICtujIsta47iFf/
	SNoMhJVfgjvcP3R8MyxifoGn1D9EmLTGKZaHme9CeIOIKLB1fKCiah86Db3fBWjV
	8L1aJekh3/hPAHnkhuDx8eNL5qbfL6vf47uQVlSVDaRqTh62ZqNb6qksoTGYCk4m
	Z9Mgc7O/ky4DS4LtfGJbdo03B16REq01MIO4aIHCLjMyIOfY0L/nKVcQfg+Ym37V
	eXxYi4NPTcSJm25voPyDyxXz1UMhsMMlaV9olq1blASsb4GAlkzKA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf5vnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:58:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689DuD3E020438;
	Wed, 9 Sep 2026 13:58:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yjd7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:58:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689Dw2oP33227074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 13:58:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18D362004B;
	Wed,  9 Sep 2026 13:58:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8519620043;
	Wed,  9 Sep 2026 13:57:51 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.210.73])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 13:57:51 +0000 (GMT)
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
Subject: [PATCH v13 08/13] sched/core: Push current task from non preferred CPU
Date: Wed,  9 Sep 2026 19:26:12 +0530
Message-ID: <20260909135617.871006-9-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: Qof9cDZooZLbNjftznDvL50b_MokrMqu
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa165ef cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=rPhwLmmYJdnLsqmuV48A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX+fmLVnh0qpl0
 P+wVi4wDVm+Z3XbNywU1OapPyHBTHlUhhaouhngOm99rJyjt/yMVI5eRRz7kigrHfb9tPXDd9Xx
 Stwn8spLa/UvHzsmMMZhXPt+/7MnAM0=
X-Proofpoint-ORIG-GUID: UZLpCWsnhxQYSry4BUKiwqNtBTUp4S0Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX8NQo2Oen/VmJ
 1ysdx1ENCjFZW2T24TsnVf0dZBD/bUylIobYfF0RzceZFCrExnltrx8UiIiW4mCiffn768QSdQ2
 F+a3y5Rhs6DDTxY2D+/9QVy3YrQdcezcIxbAJyS6fPT3tGlOvQjTDiyDC+zFImIOmmhj4Kp1tyz
 7UpWKkfHcQF6/wzZuTLEWFl4TcC1Wm2Lr7A+OPhx/WToo1SmJVgLPdwYfUGHrOuNrqMa5U3BBvy
 Cd1fzqDiarV93VovZuXP5Vsd51Tmd9gYOZ96yf7gcflrLHRkFw4q03mtIYNpiCTLbsd5IoJ6zRB
 +VsnIxWYj+uujSGYgOCYNJfasUX3pfVHjIZBCOm2qxcVUMkbSQInJf/95ZPC8cO01rYIr3jG+Be
 Ol/L+2sTSN2QKm2zlsXEf+42Olcl6sMrBAuMUOV2hQkGvfLKzjDe/Un7Si4RvwXDLIv2g/fcPY6
 Fd4CmdT6OTqgTA0QAsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090151

Actively push out the current running task on a non-preferred CPU. Since
the task is currently running, a stopper thread must be queued to push the
task out. However, if the task is pinned only to non-preferred CPUs,
it will continue running there. This helps to maintain userspace
affinities, unlike CPU hotplug or isolated cpusets.

Though the code is similar to __balance_push_cpu_stop and quite close to
push_cpu_stop, it is kept separate as it provides a cleaner
implementation specifically for CONFIG_PREFERRED_CPU.

Add the npc_push_work_pending flag to protect the work buffer.

For now, only the currently running task is pushed out. This keeps the code
simpler. In the future, an optimization may be added to move all queued
tasks on the runqueue.

This works only for the FAIR scheduling class.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c  | 86 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  9 +++++
 2 files changed, 95 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b4ef2e92d786..458b8c6fd9af 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5808,6 +5808,9 @@ void sched_tick(void)
 	unsigned long hw_pressure;
 	u64 resched_latency;
 
+	if (!cpu_preferred(cpu))
+		sched_push_current_non_preferred_cpu(rq);
+
 	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		arch_scale_freq_tick();
 
@@ -11202,3 +11205,86 @@ void sched_change_end(struct sched_change_ctx *ctx)
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
+		scoped_guard(rq_lock_irqsave, rq)
+			rq->npc_push_work_pending = false;
+		put_task_struct(p);
+		return 0;
+	}
+
+	raw_spin_lock_irq(&p->pi_lock);
+
+	/*
+	 * select_fallback_rq() may acquire the rq lock in case of fallback.
+	 * So call it before grabbing rq lock. If the task migrates to
+	 * another CPU before the rq lock is acquired, subsequent validation
+	 * of task's current rq will help to safely bail out.
+	 */
+	cpu = select_fallback_rq(rq->cpu, p);
+	rq_lock(rq, &rf);
+	rq->npc_push_work_pending = false;
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
+ * similar to how task moves during hotplug. In select_fallback_rq() a
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
+		if (rq->npc_push_work_pending)
+			return;
+
+		if (is_migration_disabled(push_task))
+			return;
+
+		rq->npc_push_work_pending = true;
+	}
+
+	/* sched_tick runs with interrupts disabled. */
+	get_task_struct(push_task);
+	stop_one_cpu_nowait(rq->cpu, sched_non_preferred_cpu_push_stop,
+			    push_task, this_cpu_ptr(&npc_push_task_work));
+}
+#endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6c3ad70e58b8..f3129e9e1b62 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1326,6 +1326,9 @@ struct rq {
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	u64			prev_steal_time_rq;
 #endif
+#ifdef CONFIG_PREFERRED_CPU
+	bool			npc_push_work_pending;
+#endif
 
 	/* calc_load related fields */
 	unsigned long		calc_load_update;
@@ -4280,4 +4283,10 @@ DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
 
 #include "ext/ext.h"
 
+#ifdef CONFIG_PREFERRED_CPU
+void sched_push_current_non_preferred_cpu(struct rq *rq);
+#else	/* !CONFIG_PREFERRED_CPU */
+static inline void sched_push_current_non_preferred_cpu(struct rq *rq) { }
+#endif
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.52.0

