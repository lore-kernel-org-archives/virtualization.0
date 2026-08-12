Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB24B04B7
	for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513311; cv=none; b=dSeNo4DN5xqTgFtGeHiVo5+rLNP8zMfRPxIRumm5bZZ8utLxkrtIjlbRJLwLG9bHB+v6pxPu0l9IhPJzAl65PVhTguFMzUU8Wj3gx2zUoWMQL3mzU3ks3RzlEAa7j8NT72+zJOhUc6qK5no1i+UO+q90n6Mgoff4AYZuWMg8MVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513311; c=relaxed/simple;
	bh=kVarbSkXTaCjfYt1E/AFEKjccs8bdUv0Uv4GGJyo+os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXPw4mr9fYHKu35I3s0+4iYf+o1HETjAU7QUKgV6+Na0DQcFfQOclJQdMq/YwiUS9jIv0LArWp+TY6O3RKUNTX+8Bew0jvVYpIuetaOcGJfWhgA0zkdctBpJeAIqvM+ZCAC9YoZnjiIb6IqZ1ZzrJC0MfZka1sly/yrib3JdECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bru99dPX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bru99dPX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C31Vsr416373;
	Wed, 12 Aug 2026 05:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QJ4UHhGufY3DzvJa7
	xsdGTzizaUXF5U10Kzs9dh5iU4=; b=Bru99dPXlNUomok69+P36MzQZOn0sa46S
	uWbRrrsoLDDQIzDCl8hOmN1MIobFh1inqLSObQ3XWCSojtms6KDYcMLOObChVk03
	B/NM4KviPQ6Fz/cE3JTPkuVgf1cf8iaJ2Rb64QFB+iBd0w0JmInUdZt5lrxQdOkR
	jIe3IL/rSTiQ89HnvyFAFaig8h6xHvBzW6hIQUw0GXCRerMU4rfhHMYfA8ZmgzSs
	Cf2fq1fLdERJSDFYoVxUI8y2gW2ShSwZXxjVRm8//6Qp30M6rwfO26UOoQEkrxiR
	5XhP1tuIj9MCUtKs4Ic5rB5FyQqMLU3/F8Dz5RSIm69aZNfP+Wycw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk00yk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:41:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C5fJ3e012748;
	Wed, 12 Aug 2026 05:41:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjvpat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:41:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C5fTIg35783088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 05:41:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F36D2004B;
	Wed, 12 Aug 2026 05:41:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7168820040;
	Wed, 12 Aug 2026 05:41:20 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.217.151])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 05:41:20 +0000 (GMT)
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
Subject: [PATCH v10 05/12] sched/core: Try to use a preferred CPU in is_cpu_allowed
Date: Wed, 12 Aug 2026 11:10:26 +0530
Message-ID: <20260812054033.95658-6-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfX3TJOJUgymRxJ
 U4z0Hp4ruUSaYEF+7pMpnxIyspR3rMDgRBHpmSutDFuVV1Zy+QqDg4gh61fTWK/rguez+MIPwD5
 v9Nb33dHWKGzn3OQOB8HbT5Xim9CSb9ZRnr1pWYt9glwy/zYTsTwBj5Jp4M90AdQj6htyRHHtGi
 kicAlSamw0wtGPkxNR+uHWvGo7I2Z9t0+iZRYrqPteVmf854HwMqitiV91SQkGQ69t7/4/tGf59
 BsvRArOubwbwUAbmdwnCKs4VzyjvZjlTToTUDDYGLOda/tVQ2yLoYs7v3fMkStfFs/UQtQHxTC+
 4E2XTMdaRfhpi+Z+9Is421yNepuDVPX/LiOLdk9mYTaUk0h5ASIh57mgKEv5+FNmVxISlkXsn+A
 GiPp3/okNQnj2+fG1psTnrdivT/Ts0bGJxWrVgCNialXDx39G7E/3LiM6kGQcnNnLXTzcLhW93c
 UzEtN8+9CoVS2hkHgjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfX2yaZ6tRQHiX3
 ttBJkrIZvb9VQRT6ORMOKckhyWxKWVDMbyF8YkaqYI+7zKPonEco+d1SuF/pIwQTcM4ubA1WY9K
 XfYv3+hs1Ea81ZTkBxKSbkucgtI3Xcg=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c078f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=TBRyIjXBjLUW-Ng_AUEA:9
X-Proofpoint-GUID: KpscK3vHwCeCHyXvco_HNY3LSCneEIZ0
X-Proofpoint-ORIG-GUID: g-Gl2t0XYBoQIM-mxrMhN1kx24tk9fC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120041

When possible, try to choose a preferred CPU.

This is essential to maintain user affinities when preferred
CPUs change. A task pinned on a non-preferred CPU should continue
to run there, since this is a non-user triggered event.

If a CPU is non-preferred and the task can run on other CPUs which are
currently preferred, then choose a preferred CPU instead.
This is decided by checking if cpus_ptr and cpu_preferred_mask
intersect or not. If yes, then the task has other preferred CPUs.

The push task mechanism uses a stopper thread which calls
select_fallback_rq() and uses this mechanism to pick a preferred CPU.

This takes care of the wakeup path for FAIR tasks too.
is_cpu_allowed() is called to ensure wakeups happen on preferred CPUs.
With that, additional checks in available_idle_cpu() are not necessary.

For the majority of cases, this would still keep select_fallback_rq()
as O(N). cpumask_intersects(), which is O(N), is called only if
!cpu_preferred. The task running there is expected to move out.
Subsequently, it should run on a preferred CPU. This becomes O(N**2)
only for tasks pinned solely to non-preferred CPUs. That is a rare case.

Overhead is minimal when the CPU is preferred.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a45f7c308329..1c90bcad0a75 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2494,6 +2494,18 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
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
+	return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
+}
+
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
@@ -2509,8 +2521,12 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
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
@@ -2520,7 +2536,11 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
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
2.47.3

