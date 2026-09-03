Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6873FE344
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417280; cv=none; b=pG9ESsQYxQgCt54pM7zSqk+pAA/QQy8iSRZBzKSkv3PzsVYhhFjJ13F3JmrIeCwqkUcdkQ48wpb99WiNSaVZGjwSp8fflWK08qenU8cAkbyXiQ3HeVgOWBIt+wJ32bY3kXsJu5SDdLDNJnFRgXS4WuJJ97CK4xiqH0Ovqd4SCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417280; c=relaxed/simple;
	bh=vaYkKX+K8VFBybyZ3Yw8MnZeRfIljiPPd8tL1kriR9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sh2pXgiH2E/hj0A21iRfYbGB22McFdsb+gQJw3aTn+n1eeEgBvoRtZOZGSHm42NQQcXAzg35hMIorF8rzMwwCVbYSVwR1j4J+Az6QnD51nVxm5KP6qJZCk9nMk02ZCfZoyPinEOPA5243/ZtvD3g1g/OyiDRMJ+42p6yO+TOk+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TuGFiQ09; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TuGFiQ09"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683620pZ312347;
	Thu, 3 Sep 2026 06:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vUDbHBzfcYOv0qi67
	s84ZrLezq9BmZO9KCq/jLGQ6Es=; b=TuGFiQ09EIfkNNt42rCcFLkU41xEHB/GA
	M/jnS61K3s5MYzgSECNmo1uHDfTroTnAUGGppf65q18xdTgSG/0CbBHqGisncx1N
	k8xiLnYXdkHA1dbWZx3qsn69OYpOdR39mm2XmbsaYZ7Q/rQg2fMr91ZdNp6UEl+i
	UBSmJRTIL0d1w0bMRFumacRwZPqDfVgSSVBorM/YX40FxlbWnKJNTLU4cXGm3Sgy
	1qto3m6fOfJ8q5n6/qUADrNLTCZaLUfjENewKtUlV1+t+gilF4TFZqy365AvivKE
	sDkBQifQXVCkFC9fbOr0pmUgE6bOLNw5RT+tEdYjr81posFnFcH6g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rkdmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:34:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6836QHSu006191;
	Thu, 3 Sep 2026 06:34:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hpa21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:34:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6836YDg439190840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 06:34:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C67C120040;
	Thu,  3 Sep 2026 06:34:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 783A22004B;
	Thu,  3 Sep 2026 06:34:05 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.27.193])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 06:34:05 +0000 (GMT)
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
Subject: [PATCH v12 09/13] sched/debug: Add migration stats due to non preferred CPUs
Date: Thu,  3 Sep 2026 12:02:36 +0530
Message-ID: <20260903063240.268775-10-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903063240.268775-1-sshegde@linux.ibm.com>
References: <20260903063240.268775-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9914ec cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=tZLFZcUqokv_Co2pBPUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX8hD5P2BU39Rh
 aW/WvxEnSa91HNRXC6v1RS1uP1obwE8ywPQGcbvWwBV9Jjj1NPSo9Ivi4tGkyDcgai0d7bO7EII
 a8Jg9onoLpr9JER9KTlRPmd6ikCxOo8IaGcpPeFMcs+ZxnXoru7+5wipz3t/q/jlPGWmLsUFqWF
 SQUu6TZIsL90ONIJaBmNux+CluoqkyW8W22lh7DIUXpDYxES5/Hf3TEKFHiWEujWXwn+u42cENs
 nAtuklG/EWFwXZOwYaAMwZJN0zOfVZcBUaEIktZ+RWA15OaZ3Zue2502+r5tkd6CFvEoi5eCkRO
 i82fqfiE7cjUr7Sxp/KuJJvVJP+RrBahKIB8biiIzuj4acX1C9DXUWKaSxiLgDioHvI3mHHbjh0
 v6ANHJTpQ/zJtOLDpZQdZvVkWM/tYpwoFslANfX6+auCDo+poVzvKWICmrIkFkq0gm/KgmDri5I
 fhFg3bdGvaERX6Qu39Q==
X-Proofpoint-GUID: XgbEPRi2WnUmHjVVaEaOfljsvZEsVPE3
X-Proofpoint-ORIG-GUID: 2vj7drW60NxyzUUQwajx0Bk4wUIvqkAb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfXxQJ3fqak60Fy
 J8KeGDvvmN8jwuGTjmKvQwI+9GnX5s4XBBB5NUzLkSBL414qb/ljt6uWVyTXv+smls5ddVWZOm9
 xy/M42kbB7NKQhRxLORj1JjubgWYd+o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030057

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
index 35e7eedad104..f32e9fc47b68 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11234,8 +11234,13 @@ static int sched_non_preferred_cpu_push_stop(void *arg)
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

