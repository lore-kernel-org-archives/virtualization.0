Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9463F39D4
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654468; cv=none; b=Ue9iISfGbT8sVwELOs/o4yjaRnQE9pMpznmGEYhVkdsHtymdBOX1vI7iaRFiY8ha5ZOL3eLb0lrI8mYtCX6An3/TkqK9Qm+cYNJCpqtkVHEN5JYVPY9GNpSTeMjhL2yco3n7mMAdfUGK8JhfsSNeII5RX6toRyeYDht4MvEyKSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654468; c=relaxed/simple;
	bh=6KwuUZtuTcOUm7TntwXKfO9i782T82hHxTENBGHfBSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfY5pnUneC5lnYHQmstZaIcYMG+JCdQvpvauW5F1Gmt5fA3fTP0hQx6O+d7YZlgMh3aCkoI6IsxP9ULpc9ACA2K0Lt+9CkfEc0nFSfc/GzhH34b7AdOZNrz2UY/QIMP8uIBRStzbr6pWPHdxrK7mVlrcsfeg36KBM/tqjA7kKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZF9OV925; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZF9OV925"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8Vdas3390460;
	Tue, 25 Aug 2026 10:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a8os8F5RheDxzlYAt
	UWfftOSSw0lp1C9oXZZzHYTR7I=; b=ZF9OV925McB61QzzKDgZkGmGCgTAz17sR
	wL46X47QAtqHxDRETGMEk7y5XDSbZ+r/gaW1qAuGcGnLcQTfJ2juD0j16EZ+Aj91
	ldHDzWEsVz6hP5tl2FXeKyhoNe7KDq8q3h5YkMFNwXSBMSwOEmPGhmjkg5LpXW1t
	6Y6+6AEAviwzIki9sWbD7gNtw8spgADRtAvr+VfG+tAOi+FVnJYyssI63dnENbux
	gle5ShYsyaE0A2YNI2/DYkUh127bgM7JulTOfFVaJdYpAWKfwqu89xbbf1IeDqFY
	f+MwRrUIElf0qL493e2KkMgRSdHo3utV/DWFJLA8a/trBpQuiHbvw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726efh4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:40:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PAQGOC009613;
	Tue, 25 Aug 2026 10:40:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw3ufm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:40:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PAeacq12517698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 10:40:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C960B2004F;
	Tue, 25 Aug 2026 10:40:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36BE32004B;
	Tue, 25 Aug 2026 10:40:28 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.21.103])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 10:40:27 +0000 (GMT)
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
Subject: [PATCH v11 07/12] sched/core: Push current task from non preferred CPU
Date: Tue, 25 Aug 2026 16:08:50 +0530
Message-ID: <20260825103855.721013-8-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8d712a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=rPhwLmmYJdnLsqmuV48A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfXzOasTb0rkO8U
 rV/V5cLZsOQvCjvUFnfFlNaJGXrWBdu2eb0X7s2ha0LmRb6C5NNLoMZ3jcM1d0hyxSlOlIq7HX2
 x/rZE+P84MqFbycG7e4Jv0ameUAW1bM=
X-Proofpoint-GUID: yQnyL9wCjaJv2slSirhQbZqNchA0MaUL
X-Proofpoint-ORIG-GUID: Bkz8bEWwchGHbhipsrL_ZkMo4z3Ic4Ij
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfXy8sMxCX9MWzF
 tKiAqa96E0PfMN3wxuzQNRXj5ufutsolppj8LsbTTj0ECmmsEQ7vP1IloeDjHp+KSYvCMfqZSK4
 dk8j/qbis8cQG+f2K/aKBSFjpH0koa83XPMNYqeDNZuw0TGSOHL71jXMOCeGBbuexRn7Co7ksC0
 gYVtihHhaNWCpM6zjnU9wb0bq8cy4VcULe2wgadT7oVdw7cYmAojyqlmbFYyMzYH8Xg3/pPI4lS
 hRLjEq1bGVhtxHdl1ylpxYmD0xmIdNteEAjxUCpsB29LMp8AKlMm033q4KSrdjvKMsiD1W2uTyU
 OR5PXzDv+ogf39Mw647o5teuGc9kceeEgG/5jdKkrUI1MO7mnpasN929n2+o/6MBzONz7EhIoes
 rjx9dAgXE5bcgzDsCaP3l9FQ2K4AkqzvkQ8A9/JQz7S/xvE33Pu/uuRIZbJym5KLIny9/vGB7zW
 T0DR0IEEAFx1hGc/6fA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250089

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
 kernel/sched/core.c  | 81 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  8 +++++
 2 files changed, 89 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f71317fe281d..2521ed5ce576 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5803,6 +5803,9 @@ void sched_tick(void)
 	unsigned long hw_pressure;
 	u64 resched_latency;
 
+	if (!cpu_preferred(cpu))
+		sched_push_current_non_preferred_cpu(rq);
+
 	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		arch_scale_freq_tick();
 
@@ -11321,3 +11324,81 @@ void sched_change_end(struct sched_change_ctx *ctx)
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
+		if (is_migration_disabled(push_task))
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

