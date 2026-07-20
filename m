Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A26543F4AF
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568250; cv=none; b=mfaVO7a6lpXx6pcIYKim4Gtyx6GPFLsHeTl+yDTY+90ZFPdKJCS/xJZTBNDGRAP39F7ROH41sqcPaR7230+VBg1+9MMAwPz8qZDIjNSSvEwjic0xNtR24qI600btExGx8CYRn5UHXeAJD1NsbfbBTFo6rc1zwq8ifLA52iOsxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568250; c=relaxed/simple;
	bh=r60YBsYQkwwNOoF0Ymgd/+uEg0+fYJIikjKDd5ytK1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qdz344DeIdEF9E2PLX3kUDkKmQtWQIr2qcXK3nkL5+ovh1JAtK+h12tUccJ7d2Eg8nccI63gyebjdgRL8yaJqxMYU05hllojHwPFs6KrVJwIqknZ93RFtbjrnHEIRhCisnBMkr6wuz6D6MwUU5Gob95O570RlUlmZugGt4bjA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lZZfphoE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lZZfphoE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBpEA2816058;
	Mon, 20 Jul 2026 17:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AUk7cOLmOOFx4Bh91
	AksrlknVURTsH5xT72L6KGYGbA=; b=lZZfphoE2+ECNtvIcjmkJe/bi/W44Hlik
	JAYOSc7dgb5T4n+JT5WjFdw7gZhuf86ZiHD/l9BMjvtZolLXE5Gemr0p2D9FV6GP
	BwXCBOsCy1Lbx4YcZn4WIoxBUbeiKnhuqceF199KzuBV1bVRrBe0m7uA5wMtNxR/
	CQXnMTb7satWn1DQZ0/g1N5OOZRfebwZPVbFBimsW3xChZ/xG6vWuDX/MtNU/rja
	I/2RKcc8zshzj4kXpDb84b3yd9AHpVOB6rcDrNoxLGG0ELnoMu4+4P//r1+u+FX+
	0HmlLfU/KlbO00lrPzAgkae+ukYI83thA7M4mAdbrX9dLbJX0UMkw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790rq6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:23:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KH4bv7016125;
	Mon, 20 Jul 2026 17:23:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjpm14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:23:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHNgwV60883230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:23:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F16420040;
	Mon, 20 Jul 2026 17:23:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 783C920043;
	Mon, 20 Jul 2026 17:23:34 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.17.130])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:23:34 +0000 (GMT)
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
Subject: [PATCH v8 04/11] sched/core: Try to use a preferred CPU in is_cpu_allowed
Date: Mon, 20 Jul 2026 22:52:43 +0530
Message-ID: <20260720172250.2257582-5-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720172250.2257582-1-sshegde@linux.ibm.com>
References: <20260720172250.2257582-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: GMKjWIeFiiPUECT_MxpvwWIiyuz2YIjE
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5e59a4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=7HQO46LoG9f-b4O6KL4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfXxvjgP6ltMQ6/
 BuPblXtSyvr0ciuilHVTC26xkiCmsSd4cJhNMJD1IVVVs2/yVxK0Uf5W2My0aLpE48DnGvZyug3
 jCzqmOlqo0Z2r17HKVwt9B4qwVbSrj8=
X-Proofpoint-GUID: LcAAntBWs20KNCBBghpFUBOaK_cidwge
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX41eXwiaHnvI1
 6/tlFxvXC4+I4NDKZOqJM8glfHx97AMqunLSd9cfoA4SNTDmh6KTjp89NRePgHB2KKJRAa5dSdb
 vpHmGrrnsr5BNWKbYspCujVDzfF3o7xAiYYis5YUKAoPt2dUKVp93WMGqSVxKv4ghNZatpRCazt
 rC5yICcSExQnWKQIi+VmKaLBJOx9dGwViFtsWol28NQB2Il9e1RCUSm60RaMoe8bK7ECibKMdLk
 GxPAviCUq60eh55IGNmWbQiD4IcpZnuunTlkbtsmg9PQA1KLxi8QCIxm4xB/ynM4aCtzEj+X6NW
 TDhbo8lPa+6fb2z/iFVKXhU8sD0anyDJYhG6lKVNtBu57FNsqlFWMNEqcTI5zVFStKnHEFi3fSY
 aYFGgZSmWOTXxEwFHqrTsBVHtZ/8E90AIoTL00ujt7JZt7Hb7/VlV1Ch4uEmY9tXZSXRYn3vTlU
 n4HOCHA2Oa4W66c6IgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200191

When possible, choose a preferred CPUs to pick.

This is essential to maintain user affinities when preferred
CPUs change. A task pinned on non-preferred CPU should continue
to run there, since this is non-user triggered.

If CPU is non-preferred and task can run on other CPUs which are
currently preferred, then choose those other CPUs instead.
This is decided by checking cpus_ptr and cpu_preferred_mask
intersect or not. If yes, task has other preferred CPUs, it can
run there instead.

Overhead is minimal when CPU is preferred.

Push task mechanism uses stopper thread which going to call
select_fallback_rq and use this mechanism to pick only a preferred CPU.

This takes care of wakeup path for FAIR tasks too.
is_cpu_allowed is called to ensure wakeup happens on preferred CPUs.
With that, additional checks in available_idle_cpu is not necessary.

For majority of the cases this would still keep select_fallback_rq
as O(N). task_has_preferred_cpus which is O(N) is called only if
!cpu_preferred. Then task running there is expected to move out.
So subsequent it should run on preferred CPU. This becomes O(N**2)
only for tasks pinned only non preferred CPUs. That is rare case.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c  | 12 ++++++++++--
 kernel/sched/sched.h | 12 ++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a45f7c308329..9e8eec4451b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2509,8 +2509,12 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
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
@@ -2520,7 +2524,11 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
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
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 26ae13c86b69..6de6366f2faa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4230,4 +4230,16 @@ DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
 
 #include "ext/ext.h"
 
+static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
+{
+	if (cpu_preferred(cpu))
+		return false;
+
+	/* Only FAIR tasks honor preferred CPU state */
+	if (unlikely(p->sched_class != &fair_sched_class))
+		return false;
+
+	return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
+}
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.47.3

