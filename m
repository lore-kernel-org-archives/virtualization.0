Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA85A39184A
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574000; cv=none; b=INLfVA+q3hBqMZRoVThkiOZX52/KDoa26k0OSMvmgu8pyoL94piQpFCxaVIC1aLgbfyvkObeCErnmvnjPDo3Mv3pLXrcr1Y4btyEI54Mqh5+cLHj39QVo1b9kmNn5Zu6HRZrGd2TZEcw0uaCykg2mj1wWhdR8wPyHd1v8xaQbLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574000; c=relaxed/simple;
	bh=o6IL35yuP0geseDlIrISR8Ao+kDmtkEqc0xfeVKE9QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTsajEYWQ9WMDZFkNTH49rCkqk+0r11tq+pTAPeDne0Bv0IIjYhC5k2jJCmBj/O1usONnJ00dfZCSusgLW1c2dElqHcrnU5Pb9ol3KuhtSPuYhBjmX1GNkx28jYgAu1h+YWmUQrSxlxlV6moGqljxapCBwRD3nBVpeZfNS2ctN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cnNENZef; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cnNENZef"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RATGCd2336464;
	Mon, 28 Sep 2026 05:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sECo3KiO0eGuCK0Mt
	cUlBfaTnspvIUyrmH6xkbcfO5k=; b=cnNENZef8/UXx0zfgCW8W8oPCMf5Oo6CY
	xJpCQ6mVW2/1rTkgUZJUKtiCvjd2oOHodfBEDNgf/ogLfnJW6/0cehheo4Zi0ROh
	JaV2qqRkwB5D39DnCz/LYfHnDsaFy4+fx1HNSwVtq3HPEV1Of8uGroC9OoEtOoFe
	1UVfqANtHbiE1SeZZKvVg3TNnT32XC3fLGXOhaS1Qu1jkK5t/eeUVcz7bQ+ziKZk
	af4GCXyi179TVCiFSR/5OoIb673gfKFc0zi2G8KqxN1C5cn8LbkjiGRgkXMkCINV
	W0x8IfdVz6wXeC9XeuOUnsmWhF6p2f0FNkKm3lglzBnftJ0z/drew==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j4yjtj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:39:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S2oIVm2024364;
	Mon, 28 Sep 2026 05:39:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw3wu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:39:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5dVXs45613414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:39:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 858A720043;
	Mon, 28 Sep 2026 05:39:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCBAA20040;
	Mon, 28 Sep 2026 05:39:20 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:39:20 +0000 (GMT)
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
Subject: [PATCH v14 09/13] sched/debug: Add migration stats due to non preferred CPUs
Date: Mon, 28 Sep 2026 11:07:24 +0530
Message-ID: <20260928053728.797539-10-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX/LmzqE4FqoV9
 xe25t46F8k3IJ64o291CmOWW2js74hRuJgWeaShsL7Vzzr1tjWXq6dCuFRYjpFOXcNYZiqYQ3FN
 OEuiO/6xrNR32DAJcznfr9MrMr2fsZQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX4eflMuDXdZP+
 JlPpvEnc1du9viGjZ6eVQ6RnbHka5ei/+EaqFCh/ZIAW8Ow3ZHzyEyYM290Wb2e1GKwwuK0PRYK
 soSqO0tAne8Xg2wXUouB82imtQ8qlG7dCREAHkZ/YR7Nf0MkO0F4XB61Xk/9/eUOZ/Zxu/Ob0ji
 8osadaA3WUc6TuUR+Ojb/SKjYAqAY64IJMSIjXHAgYEgfrjgpicv7LCFW7aO49yMjxGFF7/R0Bm
 qXOadxWIvmI57pM33eIybSkeTeARYHMVtOJgjOHQBMexHPua7z6Nb4bV55hWfFYB3YGNAFuQdjU
 jdAORaaVNFTpNcoy1uFOvxJmPfK0426CgDqnesBbfvEClZdUIBTIhvD1kzwnhX0o86onIGIZaGx
 Cp93hZf4ingTkNeFeMJBxCRhDmVM5+skwIGeFCmdYnIYZRnG9e3d4M3Pr2b02nPT9q6UeB/sSj/
 I54yGcLIFt3OC2jjNYQ==
X-Proofpoint-GUID: GgSZ01-8kIyjb2w0qsvwxr08zzfd_A6I
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6ab9fd99 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=D3ujz_5LJ-5Q2PFxUbYA:9
X-Proofpoint-ORIG-GUID: 6eXNB_Bpai_Um-8gFDzM2RR1ErGdVyfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280022

Add a new per-task stat,
- nr_migrations_cpu_non_preferred: number of push migrations while the
  CPU is non-preferred.

Since this new stat is per-task, it changes only /proc/<pid>/sched.
It doesn't update /proc/schedstat. Hence increasing the schedstat version
is not necessary.

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
index 5049eff58fb7..7465c983e6f6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11236,8 +11236,13 @@ static int sched_non_preferred_cpu_push_stop(void *arg)
 		update_rq_clock(rq);
 		context_unsafe_alias(rq);
 
-		if (task_rq(p) == rq && task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, cpu);
+		if (task_rq(p) == rq && task_on_rq_queued(p)) {
+			struct rq *dest_rq = __migrate_task(rq, &rf, p, cpu);
+
+			if (rq != dest_rq)
+				schedstat_inc(p->stats.nr_migrations_cpu_non_preferred);
+			rq = dest_rq;
+		}
 		rq_unlock(rq, &rf);
 	}
 
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

