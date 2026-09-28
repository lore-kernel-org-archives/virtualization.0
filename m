Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280438DC73
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573990; cv=none; b=CXPrZiBSKovmMJ7u0rRES/S5qsXdfzdDb/OPJi86KmzNPWBtyCnB3orY10rceMb311HU3mLsnKEOSba2Y25M0Dm1uzV2eXkPFLHF0RKrhLFwh8wXWUScctf+DKmnbr5Obkg8D7NrVIk4mrY3lchTDy9NYAJmAK8FJnS9Jq30sS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573990; c=relaxed/simple;
	bh=IRVM4geJCsD0ItkxIqXXmf5V7g4Z8aaLjlhLaxcxOqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzvJ1+RmTVzrbGbPILPgO4ciBAZjLQSnFeFvCRMVhLAP+DAOjrT1z0MDyJrg0TYVAe+B82tlyzN/jnPhkEzqxig6R9WYcz+pspHTCi+cTixvSg7T3sTa/OK2zy3Wsv8VacAqnfEaS2va8Ea0fU2cUV0cyc8LoWZJo7O0jCZNvwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KXp+Gb84; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KXp+Gb84"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RGW9Q42592681;
	Mon, 28 Sep 2026 05:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jAAvfi/7pCMiC/pCH
	JtiC92MS6IlIkOJ1+hIXOWhpkg=; b=KXp+Gb84Dm1IzlOt4Qt86/Kh4w7mQ5kSt
	MLtXEcZ303sIP2exIW4kbtZYttmqSUCQBnt2f1mfLBAGS0+ycIB+eSz1n/G83p31
	PFoPPeK6/5Tynr4+vRsIUGxUwxePWF4VRQQXFNoXtqLyoW2VfBrKdUiVwgKjWIio
	4W7o2lTSF2aJyN35cdi9P3FOklCeh7dZ+GR86BUmhxyOxGHd912Bo/jIP4idRUpZ
	JmplJGxjlBCsFgDH185XP8K58XhKgbQ8sfFbnkly4F7xVQWZbW0x066irYNEgvGw
	FA9aAf9ih/ct/PN5/To4cCcb4Ud8fvu7C/QCWO0RTgiDPnogaMAfw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qqyg49-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:39:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S2CGDi2055912;
	Mon, 28 Sep 2026 05:39:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpm049-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:39:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5dKYZ38339054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:39:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 461AC20040;
	Mon, 28 Sep 2026 05:39:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B26520043;
	Mon, 28 Sep 2026 05:39:09 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:39:09 +0000 (GMT)
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
Subject: [PATCH v14 08/13] sched/core: Push current task from non preferred CPU
Date: Mon, 28 Sep 2026 11:07:23 +0530
Message-ID: <20260928053728.797539-9-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX9EsSgW+I38Xv
 N0LtRAhgnw7P1jzUMbQTlLbi4Tzsd9ujT0e/RqUQKgcJmUDb4NjSh7fmpas9zorWhR304tANmbP
 n7s5ICXiiBl2X08TggJOWd+GUeuQIv3SGu80yswBEEPZwRt+wxB0pKOY0aFsQJGEt+eiufzg2As
 Mh4AZlq4TtoaLq5xZvfj5m2V7qSlRGOsc51x+zBO6NivBHnBDSfIt3VIgKDtdieSNQGCPcd4fgN
 GjuKt8bVW5D7DQkIdaluTzydsUfNo4OzTwt1BUZTrNL36ftAP2NLgw05BRnmZo8+xakjqwnu9f6
 qQ822Pb7kBtlKPDc1fG5UHhwrecRTbJv3B69WfB8BgTKXvHwiQgKmxeCMm9+EM1/gQr+OYoF2gy
 kvvjCOlXtWjgA+AOzDCLhXDvH7lZNRuGiwAi124Drv6Gpj+c7mH8RFMNmwDtHd4Os7vOoDiDGeD
 tKWnCPanpc/EdmL+SyA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6ab9fd8d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=rPhwLmmYJdnLsqmuV48A:9
X-Proofpoint-ORIG-GUID: 4gbSefNn5ncWH4M0jifC2vnyiyZlMtj4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX1jkd2d8wCgpB
 wx/6hBwhq+3h2zx5S842uur+DiF/i4WWvX9e7RU/b9PkUrfZGDdEEbOoBFOo+qlGLe+IOtglhl2
 YLc5FeehEQbNnqSZu93Uv/qRkBa5mLQ=
X-Proofpoint-GUID: tBz7vp1qCkpb7L-wtOMljSyNC1T6nKSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280022

Actively push out the current running task on a non-preferred CPU (NPC).
Since the task is currently running, a stopper thread must be queued
to push the task out. However, if the task is pinned only to
non-preferred CPUs, it will continue running there.
This helps to maintain userspace affinities, unlike CPU hotplug
or isolated cpusets.

The implementation follows the structure of __balance_push_cpu_stop(),
but is kept separate to handle the preferred-CPU specific conditions and
pending-work state under CONFIG_PREFERRED_CPU.

Add the npc_push_work_pending flag to protect the work buffer.

For now, only the currently running task is pushed out. This keeps the code
simpler. In the future, an optimization may be added to move all queued
tasks on the runqueue.

This works only for the FAIR scheduling class.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  9 +++++
 2 files changed, 92 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04400f934cc7..5049eff58fb7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5809,6 +5809,9 @@ void sched_tick(void)
 	unsigned long hw_pressure;
 	u64 resched_latency;
 
+	if (!cpu_preferred(cpu))
+		sched_push_current_non_preferred_cpu(rq);
+
 	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		arch_scale_freq_tick();
 
@@ -11201,3 +11204,83 @@ void sched_change_end(struct sched_change_ctx *ctx)
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
+	scoped_guard (raw_spinlock_irq, &p->pi_lock) {
+		/*
+		 * select_fallback_rq() may acquire the rq lock in case of
+		 * fallback. So call it before grabbing rq lock. If the task
+		 * migrates to another CPU before the rq lock is acquired,
+		 * subsequent validation of task's current rq will help to
+		 * safely bail out.
+		 */
+		cpu = select_fallback_rq(rq->cpu, p);
+		rq_lock(rq, &rf);
+		rq->npc_push_work_pending = false;
+		update_rq_clock(rq);
+		context_unsafe_alias(rq);
+
+		if (task_rq(p) == rq && task_on_rq_queued(p))
+			rq = __migrate_task(rq, &rf, p, cpu);
+		rq_unlock(rq, &rf);
+	}
+
+	put_task_struct(p);
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
+		if (!task_can_migrate_to_preferred(push_task, rq->cpu))
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
index b98084e1f5b0..ee482bb12a66 100644
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
@@ -4292,4 +4295,10 @@ DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
 
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

