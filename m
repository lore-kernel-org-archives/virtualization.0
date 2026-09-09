Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706AF49890A
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962337; cv=none; b=Jc/8jymtvJgTbii8TjJHR3mB8d10RcHmQ8z5iUzC4SLipM1f/+oibyE+aINBSbrxmxxHEP4nA/vZP080phDquF/Fpr4MgMcSU2vQzh7xNOgBJvkYvLTIRHWQDEEp+Bw5a0RukwuKfZhkAgWGPiqMrkip8fb/ogT1WY0Sana7kVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962337; c=relaxed/simple;
	bh=HLzMvQ226QUEgIEvDk0ogqXT8+gwOyH9y8tGguqSzpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8D/xS8FR8rRtAL+aUuVCFHiqOcU+cQR3D3UqCCm1Ies2Fj1mlEVfmIMsWA+WElQDiYNw2ZJV4t5z/iwZ3ubRkEe03c7uWSR010OlZb2hL/EyG+xOFtj902fDV8+zyfEcUMub2QJqB+rpKdUz8XbqOvG1JhupDWPDf12i/ldvjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lth9IQAG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lth9IQAG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1URP3817390;
	Wed, 9 Sep 2026 13:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VxBwYadto01xVmkHj
	kv+SCIB9GiRBYtMuAIvSCtNZvg=; b=Lth9IQAGuagT6iMCWNyGyPW7d4q877FFi
	SOxFpZFZDTmV4rTPGTX5tSL3fAnQLtD6A4+DMm5MN7yxwT27xcMKUjO0P4dzQgda
	S1fcEGTNL2GuL+Dl/OF0opqsrgYpn11gtbqK6hleFenu93R4islovBV45S+YWleK
	kyu8xNU2CPcuHqmMTZzLhYA13pYUx1ankI+xXlvGEtBwXG7h55xKl9OMpvlXnXJ+
	f7RibiLyBglr9mJMNBKVoE3Fko7MTNuVkhsGEUa+eFQCKWzBaAMl7B5WRQvqLuBJ
	ATWMVXHOVeJfbqXHYnOkuaTn36c2dXi3CKl2l2agFg1CPKNksPz0Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf468rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:58:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689DuFUx026472;
	Wed, 9 Sep 2026 13:58:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgjf0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:58:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689DwDqK39846206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 13:58:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E78C52004E;
	Wed,  9 Sep 2026 13:58:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81E8F2004B;
	Wed,  9 Sep 2026 13:58:02 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.210.73])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 13:58:02 +0000 (GMT)
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
Subject: [PATCH v13 09/13] sched/debug: Add migration stats due to non preferred CPUs
Date: Wed,  9 Sep 2026 19:26:13 +0530
Message-ID: <20260909135617.871006-10-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: XJasDvtQZcCcDl8wYHj4L8v6dYvfr64E
X-Proofpoint-GUID: ztzmHQ7UTxytzKsT0m0NvyH79zcPaYUl
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa16601 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=xOgPbWkph9TtLGg4_toA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX8nBgLh6iet5y
 4zD7Vi9TMqV2RB7qv0cp1dRlPhstWY+w2fkmNSWL37aaA/cpGt0JbwGOnVvDq8mJpxBNnHDgfBm
 bNcrJZE19kVsP1BhqrjSUO+TXchF2ajOUxVLYdiAdY23uB711kkS0lGPXSq+6TGR/wG77Dx7pWr
 9lijlTB5yk8rp/sftaCGL+VLUM5UuoDk/BQejhYiOulfPXUmi2nS7P06lbtUWA5IwjjR7JSTz/J
 Rpr3mW5BiNL98ORU39BZ1V1oNe4Fc7xsRguEWm7mdI0mQ7hF4a80s2RIVzQqFHr0G/U1V6toh5j
 RkK6mEq9M7z2l8HHnZJ33Q1tOIpCy7yvebEW1ZoSBOM2HBoRSFcMzSLWlpe5lQlgs76IrL4uRW9
 rhEEHIuvpkkT2SeBziAOEmE8f9QGTpl8CjZebd2p0YtTsFYgwqXcB2isoVRiYr6HSjESl0ms6yR
 oTQJUsV19VySj+TJpQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX8XBFLoYvUUzW
 a5qw7IqtRnTgUNktzYdfa0oYfKbdESWiWSY+qGZdCxB93ZWwJe96gZsvAkL82/hymg2j7I8YB9Y
 5oxfE3ihdbhKvIS9z+Ytt1Up8jX0LsQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090151

Add a new stat,
- nr_migrations_cpu_non_preferred: number of migrations happened since
  a CPU was marked as non preferred due to high steal time.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 include/linux/sched.h | 1 +
 kernel/sched/core.c   | 9 +++++++--
 kernel/sched/debug.c  | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d7cc77181ef9..48639b0c75d0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -554,6 +554,7 @@ struct sched_statistics {
 	u64				nr_failed_migrations_running;
 	u64				nr_failed_migrations_hot;
 	u64				nr_forced_migrations;
+	u64				nr_migrations_cpu_non_preferred;
 
 	u64				nr_wakeups;
 	u64				nr_wakeups_sync;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 458b8c6fd9af..fb8404bd47e2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11239,8 +11239,13 @@ static int sched_non_preferred_cpu_push_stop(void *arg)
 	context_unsafe_alias(rq);
 
 	if (task_rq(p) == rq && task_on_rq_queued(p) &&
-	    !is_migration_disabled(p))
-		rq = __migrate_task(rq, &rf, p, cpu);
+	    !is_migration_disabled(p)) {
+		struct rq *dest_rq = __migrate_task(rq, &rf, p, cpu);
+
+		if (rq != dest_rq)
+			schedstat_inc(p->stats.nr_migrations_cpu_non_preferred);
+		rq = dest_rq;
+	}
 
 	rq_unlock(rq, &rf);
 	raw_spin_unlock_irq(&p->pi_lock);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index fda10b3fa249..e6a3b516c703 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1440,6 +1440,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P_SCHEDSTAT(nr_failed_migrations_running);
 		P_SCHEDSTAT(nr_failed_migrations_hot);
 		P_SCHEDSTAT(nr_forced_migrations);
+		P_SCHEDSTAT(nr_migrations_cpu_non_preferred);
 		P_SCHEDSTAT(nr_wakeups);
 		P_SCHEDSTAT(nr_wakeups_sync);
 		P_SCHEDSTAT(nr_wakeups_migrate);
-- 
2.52.0

