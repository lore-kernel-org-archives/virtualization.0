Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E67A3F929B
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654467; cv=none; b=EIUAz7QlZyAux5bF0Xcgpa+uTotsz1FkvypN6Rhu0kKS6VRdPs2wuKhn5w0V4mCwi4y4inY2umpNCdsIEbTgimdnB/dOYbwUFZqk4JTtYqMCBG9BR8KlQUdAfeJSn/RbW164erkm2NMZNtICWgBkd8PIq4xNjoT419v6KKwRiM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654467; c=relaxed/simple;
	bh=2xR+GfiiOyB6SfZW1OIBhLdJhb+vSWJx+KgzVSGdgKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpTvdrQQitqU0MNwdjTBxehsksmh7mVRb4SRq1ZOUrLca1kOEOjR52DtsEfkU1iogZDAk0hJbrUXMth14Y6qApLZ8OYCDRNCy7zhZVgWKmtgBVnpSzIX/xc4kbJw9Gyn43v7HT6xVkJjbNDJsVRpG9IQMHyBmRuFkFqbTjbn/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tFx3XDfW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tFx3XDfW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8VobG3390794;
	Tue, 25 Aug 2026 10:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Qww1wRP7Agkql+FnH
	hwzR+d5eVxTN2AMCyH9arsexeY=; b=tFx3XDfWVUtgfBilB4BUvIqPsXFS7orJI
	rE/GIti4W5AQ6V+Brkt/elH9mzDCBvJfgtrylNGcEWNtqiZJVdymCsGMxaNpwcUk
	uKzXv3hcN8x4WHQhd6GXQnWZQiyp+q34UjFI2IgDVS+F2xwaHD8XAZm4jpNom4hF
	05zy/xNixLvl4WMszyCj68n7+brOKCyXlyXetkwcbTfi1wSRtKXeeLHh2K7mpUjj
	maxaIkdzUtM+tp8eR2u+m9f7xE7QU9rLmXiqoeGHGjqhZ+TWvfQfkMFxVMeWgKXA
	u9ukkSg0e5cfCu/+s+csF2i9xkT2H3gjY402kwlDIkNlkwq7YBPCQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726efh56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:40:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PAQHOn005244;
	Tue, 25 Aug 2026 10:40:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q3xer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:40:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PAekY252101570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 10:40:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 866F82004F;
	Tue, 25 Aug 2026 10:40:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AD452004B;
	Tue, 25 Aug 2026 10:40:37 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.21.103])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 10:40:37 +0000 (GMT)
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
Subject: [PATCH v11 08/12] sched/debug: Add migration stats due to non preferred CPUs
Date: Tue, 25 Aug 2026 16:08:51 +0530
Message-ID: <20260825103855.721013-9-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8d7133 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=-i9lZGrASMRMKgkbeRgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfXzWtzZte3SU6w
 Kexcw9wuR7eTbaEuNuzMjpbsaq9QLIgMeUearlD6uMUmilDZyi2OF7sCRlEz2XbCEouuuBrkqjB
 2TtZEnpJmA251buBik0eAJI/cQ/jTjM=
X-Proofpoint-GUID: vp3WLSpTWu8piiDa4fCbp5S59kfnMNKe
X-Proofpoint-ORIG-GUID: DWqDtcZY1EYHHP7L3PvT0Di5dI_bQiVA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfX2Ryqr09CO4ox
 lMbpsE2TY36GhJ7o7K4x6PoiQ6dRzS+Xxl2ZHiKMxLYkuTSxq7d/zUTZuZWk0Lt8AD4QpQKXQQ+
 ZkcoZpV8hmUcOX4gPnKOhkb6BcxtH6sZT/l/YSVEAdC8BP5ACWsl7ZdTAbJpLEQ0nzPafoGcv+8
 3i8fr54l0LWRYe5y9cu98yh8P+Q90KuDo9ENRTnwAjp63qkLiD2NrUVus5BwFxEnjTgzFd4Nw0X
 mFitIzAormBzcp/ec9kuv3CdUXCPvASSL+2QwCgoB9595P9HRB7pBsmhyZXueC4TvyufEl6Zn+l
 lH38lLJmrc24x1HaPVf+wwXLJYUj2+qIrYSYnEwuN81h1RGZTlXxcCjgXyE/Bq5fFai8taJsaw5
 uC7mxt/OW4md3NkE2Y0F+utaYiudlKPsLs7MJ62E4j6VzGGO0+ePOf1p6BDAgJ7JCbkaQzI1VID
 8lYl9HBN1v2q1vLCqow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250089

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
index 2521ed5ce576..e73d2dd997b3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11353,8 +11353,13 @@ static int sched_non_preferred_cpu_push_stop(void *arg)
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

