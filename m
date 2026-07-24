Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC34908B7
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902170; cv=none; b=myAzAy+JC3lX/odlk7L2BtyQb+H2M41FZAHMcWLuFeQ4DFL4EVAFdkPw/p0FAmpZrlOHHrZ4bn0d8mlFQgJFCVNdWFIWGBo2XH7rXbNr5llM51Bu92G4NV8E/yngQ8KwvNYmjzE0E9AW0CgfrCRQq+Z1QCsFsYYW8UeFBIznBFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902170; c=relaxed/simple;
	bh=r60YBsYQkwwNOoF0Ymgd/+uEg0+fYJIikjKDd5ytK1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekFvc+9+8b5yFo1Dgju5cMgP9Qf0hSptar1IhAPl3KhFEYoOO/JIYzf0blZVA8LN9tr/UuFYsdoRihVQK28f0i/K+sgvkqLR9uNlsdXruaG0JZDvl5wJV85N7VrQOe4bvgnj2ZZfgX/yDUS71XZoFUcxc+ni2qa3U5ZljYj3BvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sGas3Mc/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sGas3Mc/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODffIZ1973724;
	Fri, 24 Jul 2026 14:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AUk7cOLmOOFx4Bh91
	AksrlknVURTsH5xT72L6KGYGbA=; b=sGas3Mc/hpnci3vuM1OnyiYeQ/3TiluUd
	PcgxQHeNJOh0cq90hIolM3xO1wvtX2/ZTzuWqV4thUCRTRLrH75xM5UtDl2VUuXr
	liNTB+7X0m8vreuHj1GamtkWOr8CrB27SYZQbIzDes/OijeLh+yJNmdLR0/QyNcM
	4r76w54xiKTCzM0o1gPGoSsU04J4kiDEqZ8vYzFKO4vYIk0mNN3QGrr09Ibhytkp
	CYos9C27llp5KAQ6nxt4MTmUUyiAAxo0oIZagCR740aLElSTnvFs3P9VfO+IiWfs
	W1WhE8CpwIkiV9iuVWLUeeUcUuPI0ZziE9lcyI+KIqK2cY1y9LgfA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h509vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:09:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4mVg029231;
	Fri, 24 Jul 2026 14:09:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gs10r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:09:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OE95PL43057430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:09:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EFE220176;
	Fri, 24 Jul 2026 14:08:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62C6920171;
	Fri, 24 Jul 2026 14:08:41 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.20.178])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:08:41 +0000 (GMT)
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
Subject: [PATCH v9 04/11] sched/core: Try to use a preferred CPU in is_cpu_allowed
Date: Fri, 24 Jul 2026 19:37:25 +0530
Message-ID: <20260724140732.2683314-5-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX4lz3isBmATZL
 9Zr3FgWE42TP7JRJ/DiYj4gvI2qg0yt6f5LuyVvgki13th9VvBwuQMIuWhMkQoydPZU4eiP+rkW
 oDgLkxjNMZAf1XkoIO1ijkttmVyCU/A=
X-Proofpoint-ORIG-GUID: IzPvZt21JDwpNuL3WIEgkOuw78Zb1r7L
X-Proofpoint-GUID: YNfNk_lDyvdd6oIgdWIV3Uip4YIGjLHL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX8yqmC1tXaJWz
 HuSB5PDfn2RNge9o4M4wElyFklqeEuLm8azGLW7F4k3VY4ll+U1zgE0BTreT1EOaqChwEADc8/y
 XmysOhPr4aJXJ3yY6AVpeuXA5GXIuJjsxpbbR7l4z/x8/vHBwrwqFo/PYcrpSfS4MWW/PCwkqJE
 qQKqtsRVQnz7UnG/eB+JAc2YTManpfisyN8PGJ+T9t3cLgWA/fzYK1fQCj6vMQhcEE47KhkAbhR
 tDT7b34qiseOLDvA30VVkuZobuhZVT7oeK0F1O+1cV/pnS63bMohXaJRdOqlvNNmn5RTcEvcpoh
 FndV0JCk9K2MGdiAIwMOurwEtwqg0dCurkR5y8jO+NacUo0tk6xujUbYzW4KhlSyaPOY1128mQG
 dqneXbUIyDS1Gaom+BoOV8Xas5xNlgL/9mgpwePZRsL4IU6TnYu147OeDCxPfHz63CNp2f8OfW4
 w+HUtIaJF2IaISqF2eg==
X-Authority-Analysis: v=2.4 cv=du3rzVg4 c=1 sm=1 tr=0 ts=6a637206 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=7HQO46LoG9f-b4O6KL4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240124

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

