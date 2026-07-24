Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41125341ABB
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902184; cv=none; b=fMKnJH6gG15zy9b/9qpbAHY9vMgplAalWVRm4YbAAExKcgIa24w8p53zQOSuDvfcWXUVkR7pxNedglCNuqOO9Wr+ah/y0C0T5ebHBXFS8GPUq+cYLqo9nLYfBaq5cKJDL3t55G4Qh2W2EEM8sYtL5MlZz4lWHEWm5XIWkXCbRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902184; c=relaxed/simple;
	bh=GKJDo8AI7wWFoFr67ephXxtE17uqG5Sitcmc2r3sofM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+qchONT6RA5/COVad6YhVRp+e4Gfy6uffpl9G3xfc646FH96lgv7am9hi+XTWs5coiA/OJtqBfQ1AFRfM7TY7fMBvMifIi/mBK66cGygXjSPSauDHqcklBvCs+FXR2XDVyPRWyBt7Xml1hL3b9HBrLx4pklC24vzPiUh6NZGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KyGGavFz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KyGGavFz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODgCsH1994940;
	Fri, 24 Jul 2026 14:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=b2ibZAPLvpNMWrXYA
	z/XxHR3KuVpRAIfxZuRDDmAorg=; b=KyGGavFzufNm+gBFqL2Ht4ABa0Mzlcc8f
	ZlID5pi/3BMHCil6WszwhQKUYsG0hn2ELeR/gzGkA03YijOk0NKZ+qaq3+qz+sdv
	yhH1PPLI2C0AW2xEwdX2ziFUcpomO8fJaGQNRkBhIU0y8awI1Gx8t7K0TSY8Und9
	eTB7ZYohHwADr+DeAqJl2mn/op4M0vSrZWR1IDWW3WNd8OYYnQBpUIH2EqoSjnUn
	KOitAitxdJlg5yHb4Vzaex5P2AcM0nQAiu8MWyjeHZNWmmcLm5SDGQr/rcldzORu
	HFazbi7kaKDOMABS7VbhhK+aaCxuu3MPGbK2MaIaKRE0pAc2h0z/A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahmcm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:09:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4eeF014519;
	Fri, 24 Jul 2026 14:09:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk96uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:09:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OE9OAB50463070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:09:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C819E20177;
	Fri, 24 Jul 2026 14:09:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0508020171;
	Fri, 24 Jul 2026 14:09:17 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.20.178])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:09:16 +0000 (GMT)
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
Subject: [PATCH v9 07/11] sched/debug: Add migration stats due to non preferred CPUs
Date: Fri, 24 Jul 2026 19:37:28 +0530
Message-ID: <20260724140732.2683314-8-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: vIVDiDO0rKYOooJH_to9CyGeasr39wJL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfXxF/t0BC7Rk55
 kIKovsul7jVJmTNLqLllPO0vOhxW7keY3e4dKaVHGdxorvnxaoLh9pbRSjs6s8ux/8PG8nxhNgC
 5k7mmcM97W0RVuDcL8udktrEm6BY8Qkj0vvz1hICqOgmFXKase/5WGv4iO6xEjfhD9VVXcMofEg
 m7U4OkiCqapjTtg/oauoRUr0820Tdf1HzZdR9VtnGMyTWA5ZeZtzINRHsYsXTOu7w8ekAgnVam/
 rZ+nUG6+ENbVrYD+hbtREbAitg4GlePzXGajbCj7fBn/hQT3Lc/mRxCSFiErByZ7o1mAcKDoWSU
 rFpnZWzjcddytdj4Io0LKLvKGuXuph47Zrsm7oZfTafRQNUik1WsIxySzu0t5WpvEMj/CvtKU1l
 JLKPzD08dmWS2qsK/3QKAfR7bn5HVofPH7lTLihEWSupNyys1yL/ua4WxpFtnzLVA6l16ZEn9sp
 yBi6jDPMO1EDDY1sRKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX48ngWp8hnvwe
 1d5w+D6nWepssRCRlyQpydKa7I6CXxp7ag2TxVKls9JiFGHdE6C/dHHbF0D6pqotu9Q3Vx49ZHM
 6lJoSPvtb4npTfUsjswEWlw6jP5BqzY=
X-Proofpoint-GUID: dsirhQ6s-NtAP_pe_RMJv32KbwP4pzZT
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a63721a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=-i9lZGrASMRMKgkbeRgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240124

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

