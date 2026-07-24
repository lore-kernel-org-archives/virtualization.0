Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A539A4A4
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902177; cv=none; b=bI732I56tCaHzIpzfbY0FVb824+vCho7ucTuZd8WsyaXZOZRVYqWq1ZabjGuYBuPAY9jbKhqb4fVWZuGZMl41Za0qy+K58tPt6t+fBWEdSbR23zHIq3Y013lLGm0ZxF6M0ZOve/04U5rja1ENR1AcCji5AZRi1mLYxBzOepQbOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902177; c=relaxed/simple;
	bh=6CVIJ23rx2F1q/8wVuK5hcqZDwr+T57KuQc2qkWXlrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJDKw99ziDSBf8r+c8Goh6BPrS6UZH3lXj0/5R8nO2Uv1t/5J9EhRWm8w5qBAwACs2z/qmptePLQ+4XkChmPetK5xTzTq/2J40A+bpKJo3P8TCbyvRUf/JACX9yCZlsL/4PImXSl691aV3NyZuj6JRj0sVT0hcaHXoymubXdO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F+vx5+3H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F+vx5+3H"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODg0Gs1898352;
	Fri, 24 Jul 2026 14:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Qvp7lKASIi6FxhulV
	1QnpUj/cv0Gt58b7Gz/8zmDO4Y=; b=F+vx5+3Hk4rAvejBTgJaQsAG2fkcKSohz
	/HCiNGfCz8ICiIJKPAwxRn26RFhjLp3Oc9QbU5p4F3sJfiMxLkkMNuTb2H5uHDUW
	bb13ferKwHAur/Wssa7Z4z1ktkZ3G79zGOHQvjwhWUYF0rVc6cmwDP42iPSe/s3Z
	gFL4XDHecudhccqwmG/VXLEfHy61cYhlL+OQAzv3KyY0oItmXADMZc97QjDtbT5N
	ZoYVufRxyxQfkgX6MPTJ+Bw4nGV7fP6pxYGFcqHY8gfLkivzsYmngSNPKxUxRF2z
	/kYM4zoL32/t0W+pPkZzZBB77cI/8cflDCJBjoB5/C3/tLlv4CCeg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kme7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:09:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4iFl009171;
	Fri, 24 Jul 2026 14:09:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyrxd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:09:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OE9GDS42729908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:09:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A51620176;
	Fri, 24 Jul 2026 14:09:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3968820171;
	Fri, 24 Jul 2026 14:09:08 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.20.178])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:09:08 +0000 (GMT)
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
Subject: [PATCH v9 06/11] sched/core: Push current task from non preferred CPU
Date: Fri, 24 Jul 2026 19:37:27 +0530
Message-ID: <20260724140732.2683314-7-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724140732.2683314-1-sshegde@linux.ibm.com>
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a637212 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=rPhwLmmYJdnLsqmuV48A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX6jMXo3wulaPz
 zmWJK5IAmu2DuNxpfLkEjgJd8mgCPWXgcVhc8O6MBugHF10jDph3YPX7HvDoLTUz/4Ry6sosf7l
 hBFHfmfKtSJKqYLUIlmhRHl8LH826jf+XDlITFbtzlTGZYH5sfqakbawXiarxCcQH0mIZiUNFXq
 XeoSJHng6QGwUUmTz+BGWSpFshNjVSJDm72FWSGj6qyJHLn8HLOxWHP6jF2Ht9ePDIwCsSjUsDV
 k3fixqvbEtEj+tYcdRdzXKZV6UvNm1iEWvwxq2LeQOUtbveyhG2xjZT6vYU32OLHnLIV0WXwI1t
 5KvNr5kZwHSRnQI0L9XylJmqgN15RAueS5pjGD7jprzTXa0j4bftog+e/FWv8od5BqmEIeCfcDn
 rA914uTkfRcV1GwGbKrubD7Im4yERCv5WTvUJPp8SpwwIlIekbAWsS/qtS4vMi0rNfz77sWVHUg
 jere8zzK4b2Ynrc8s7w==
X-Proofpoint-ORIG-GUID: OlU09TAilH0cJ-1hjxNWLpgzTQLsIBmP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX9YxyABk1F719
 vm2RlN76UdE+kLcn0zCDTZydfvVyOXqd81jt4PTXMZAaTgKpjfg4OzpZnr5LXl1YM7BDsmZcUXx
 x77Se8HOO3CftHapjce0ccqz0tAyPgU=
X-Proofpoint-GUID: MtkJlG71amT934T1RP_53hlT7mD88ZGT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240124

Actively push out task running on a non-preferred CPU. Since the task is
running on the CPU, need to stop the cpu and push the task out.
However, if the task is pinned only to non-preferred CPUs, it will continue
running there. This will help in maintaining the userspace affinities
unlike CPU hotplug or isolated cpusets.

Though code is similar to  __balance_push_cpu_stop and quite close to
push_cpu_stop, it is being kept separate as it provides a cleaner
implementation with CONFIG_PREFERRED_CPU.

Add push_task_work_done flag to protect work buffer.
Works only with FAIR class.

For now, only current running task is pushed out. This keeps the code
simpler. In future optimization maybe done to move all the queued
task on the rq.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c  | 78 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  8 +++++
 2 files changed, 86 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9e8eec4451b6..704043531b24 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5774,6 +5774,9 @@ void sched_tick(void)
 	unsigned long hw_pressure;
 	u64 resched_latency;
 
+	if (!cpu_preferred(cpu))
+		sched_push_current_non_preferred_cpu(rq);
+
 	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		arch_scale_freq_tick();
 
@@ -11292,3 +11295,78 @@ void sched_change_end(struct sched_change_ctx *ctx)
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
index 6de6366f2faa..80c02e2c09eb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1277,6 +1277,8 @@ struct rq {
 
 	struct list_head cfs_tasks;
 
+	bool			push_task_work_done;
+
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
@@ -4242,4 +4244,10 @@ static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
 	return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
 }
 
+#ifdef CONFIG_PREFERRED_CPU
+void sched_push_current_non_preferred_cpu(struct rq *rq);
+#else	/* !CONFIG_PREFERRED_CPU */
+static inline void sched_push_current_non_preferred_cpu(struct rq *rq) { }
+#endif
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.47.3

