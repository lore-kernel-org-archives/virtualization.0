Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60754071E4
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568279; cv=none; b=i8nb7YcajA/5HcsxXW4dKIMozVs4S+obXavrmBAves6nayQ6Kc+xvSZo8IvLMv90XXOCGjX1RCGRI+yHYGggJZCI9ZFQIqydmbl0vu0zOxyo8Xzr+5l1XYIvrEwFVLDUzDKjafg7qGWfaMBY3LFW02ek4HW+90ldfWeloQT0Z4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568279; c=relaxed/simple;
	bh=GKJDo8AI7wWFoFr67ephXxtE17uqG5Sitcmc2r3sofM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0TiNxYErtiy803dwM9v+TPDtWmAJM+dGpzT+aAe1+owZ863w6OLFzCpgoJ9ix3otgsjsIX9biz2IdqkEE61cydyuUd4fjp2wzdJ7+ky+4E/0Y7bhU91za3tWafjUyB+E8xdBgvmMBMNZjl1EcZnrkfUSQlb2E02R2m8nJYa1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D3YdqaBM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D3YdqaBM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBg022815868;
	Mon, 20 Jul 2026 17:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=b2ibZAPLvpNMWrXYA
	z/XxHR3KuVpRAIfxZuRDDmAorg=; b=D3YdqaBMw+nl/y/+iGJVl/9bomMFZqMY5
	/E2Syj31tXCBaMekNqq1chXTGeOpxTEB0HwyQURp6bulKLc4LO+t8RIZezctgtl3
	i474vBaCzBZYWG623rPBoAkB4ljzghJ+xWbW+NZ0uQFW3M3gk+v1xRpVAZq13KNw
	u5D98gTTadi9eaYfDPKFccXj8qpjbTySpiV0ufY4uDEEMYaiVUOFS8oqhFcAF+9p
	IEV6zBMaREGn5PLpzJlZH4UkFN76oPhpG9i2MxcSMfD1DNuc9r3kKYsA7LAT+/kE
	TiM0RYLEb2rXS5VlXvO2xVNkWbNYhYV/rfiFvIQs7G8ZLCDfUyAyQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790rq8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:24:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KHK0JB002260;
	Mon, 20 Jul 2026 17:24:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagxjry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:24:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHO90n10420638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:24:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D0CE2004D;
	Mon, 20 Jul 2026 17:24:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C982020040;
	Mon, 20 Jul 2026 17:24:00 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.17.130])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:24:00 +0000 (GMT)
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
Subject: [PATCH v8 07/11] sched/debug: Add migration stats due to non preferred CPUs
Date: Mon, 20 Jul 2026 22:52:46 +0530
Message-ID: <20260720172250.2257582-8-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: CMhb9ormIitGwgLRG95x5bje4v0tFU1M
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5e59bf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=-i9lZGrASMRMKgkbeRgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX506iJGzgXXEr
 aK7ET/FUtmk4MhC33L7r5p7pibd8nqoinJVe0+tCJa7NTqCw9fxjTdxLtZBQ51aeh3KKwt82H+Q
 oL2uFuJsQCSs356r72IHMV9m6z5uWWw=
X-Proofpoint-GUID: cOxhTDn8N0RCtGLI09-FVkanVKPWrtWP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfXwtXiluePDxeK
 FDkresOJVJdl8KacuQNa01bPuC8A2Ii4L1IGs3RxhndXdhqrRElcpYCAZKIKkTf2qTynokGKRKA
 Zlz8e4hGizEhW4NXhzzBaLVNzLtrSCsVQ2lTrIdZkuwviPzpY/1mBVorx0iprIRnzZZBEMpA2hW
 fTlOJHGOReEfVrErGP87G6GTP5PvK8JFFsOTsvWywOt2815uMXHVnKtiZ97nY9B2p/4R0TFMtmz
 N+C+cfNuH4LtN2idzjxCez3b5EWJ/G5+/2ciAH1ErKwCS5+5P0COIDaFzh/i7lPAs+RjrfjglGy
 2DMIs1DwoiwNNjct6LMmT+27GTHkHdqJTOlWclAipbGxKlAeTlYJUGsU3T1zQ3tykUsbFrCF5jX
 GAxEt1fkVhh0hI1lOrWpMitVZD4cmUus0k0J8hqYZUh5hHshMqaqg7ERMM1XaOFK+298TUQl8jQ
 W/PSSSA2HSaWSfnHpKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200191

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
index 968b18a7f470..37849d2f1dbd 100644
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
index 704043531b24..f0d9bcfd35e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11324,8 +11324,13 @@ static int sched_non_preferred_cpu_push_stop(void *arg)
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
index 72236db67983..5ebb2055e6d5 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1446,6 +1446,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P_SCHEDSTAT(nr_failed_migrations_running);
 		P_SCHEDSTAT(nr_failed_migrations_hot);
 		P_SCHEDSTAT(nr_forced_migrations);
+		P_SCHEDSTAT(nr_migrations_cpu_non_preferred);
 		P_SCHEDSTAT(nr_wakeups);
 		P_SCHEDSTAT(nr_wakeups_sync);
 		P_SCHEDSTAT(nr_wakeups_migrate);
-- 
2.47.3

