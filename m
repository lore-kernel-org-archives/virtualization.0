Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938453F326F
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654447; cv=none; b=f8uK4HlEKj8nuRRW+8ZrD3nc118KTOnfb9qQo6G9xFnVKFM1vd8oRVHHwu6qPpVqAxJMrBoWFSUUTxLIE2Q2NfOPzmviet46ZV8HItJjAhWOrGlwAfz9kpbV5FGIbnaidltJUQuKcsNkNbPDuvcPdCZPDt+goEMZLwCur/pNtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654447; c=relaxed/simple;
	bh=GPvVWYQDtRId4vsQqpgozI3SjqctT0MmSWzvFsN54Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdSMqBjS8jWrE98qor83LkMBx9hF6Sj+HgGAVx8/67ClXg2+FQ/S4izkpMFx/zXJYoxKl9PQv8Cj5HinLmnr0AzD2EOrySdPBlvRPLcpWJEkDNVpf66fAUIKDjhJlaoY1Hn2PHTm6rOgauqSRRD+2Bn5ynhSEiLJGJJWjLoyOpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J9Cl+cR+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J9Cl+cR+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8Vias378181;
	Tue, 25 Aug 2026 10:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pImetWbt1Ao/qbumC
	NTFwjRwcdp8/exLahCyfnPF9Dw=; b=J9Cl+cR+1UIM2EhDB3PaeAgGEmR//XIyV
	2cmFAP5XpU5EFKYRQeGudCgq7BJ8HGZnRRPCSyIMRJmkgXtjmDXN0hAQtwOxqwHA
	ndwmnjjGh7tS7ZKp92WQ67amo38vVgEL1MUImC/ueuNRnOmqLl5cELcpKVumknvl
	babr+I4iyiKxMn8aHDfLMiRdCpJ013fYB8zUb6ZlwDtYO3afN2XYzo0Z2ukK6daR
	gAyEr7u99zNy6xiTDquOXlgJaj37gJhZyg0obyMufnzlBUvDafu56kE0IigMwbdE
	tDHH0/5/9i+extIDInkDveO9xTF90++z4aD1FkeDkqUojgQLmeY6w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx7abt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:40:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PAQGuX018765;
	Tue, 25 Aug 2026 10:40:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy3fdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:40:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PAeRZ253608842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 10:40:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADA182004D;
	Tue, 25 Aug 2026 10:40:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFE4220043;
	Tue, 25 Aug 2026 10:40:17 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.21.103])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 10:40:17 +0000 (GMT)
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
Subject: [PATCH v11 06/12] sched/fair: Load balance only among preferred CPUs
Date: Tue, 25 Aug 2026 16:08:49 +0530
Message-ID: <20260825103855.721013-7-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfXyDWhKPOSeYoC
 q1qyqzBMf2CII7U3SohIW71GlpWGY+0GjGs0qSF4k99ETCgoZ3hk9pxWrTCsqEYTG1dQTw8asT+
 /ehkKmowyYdb4ruZAiHW+TkQhMbvcyQ=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8d7121 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=f1WSfB00kwmd_FHdG74A:9
X-Proofpoint-ORIG-GUID: lpWK3faDoVDiubBebcV1cpjBgggmP6L0
X-Proofpoint-GUID: 45Q0TBo6lpBCsmiiCDUluVAEiRK182Uj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfXzccKQ2W4NW2g
 5tn3JSTxfaab53zrm+sMxwliaGjqsgNC+kSactVzQYHw4hhXUc/t35SqK6FRCut8GHqslHrXUtn
 9zMJD/nXYdccfL4Jq8/M1x+cb01V04UzNRnKV/M8DzHAMULRRgIlEtsGc1gcE3SoKQo5C0HRYML
 fspaSZ0NM+R4IkX/BxxzhwgtPl7DDV+jaU0TMOIfldN7ZUgRv9uTmSkL8CUjPvA0zeyjo8xzY4u
 b7laNqu+biXJ06s8NUb+PqLIznRJtMqkJMw1to3xaLfhuxpuzSEEH1GOcjxgLyMydmBQN06YlhS
 /JVt/aOzIAv4ADQwRAAOuwnTEjASOZgnrNMwVkXSPI88cmQe26eC/UugidmGbJkVKbWysbXziA2
 vOiuuw27wabt2brk0MpLowoanc6XtX24PK23PmZOyoqVLJCMa/MFqOygySNKKuD5c1MZJRHoCvU
 NRFMWsi6SUnNmI1axKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250089

When a CPU is marked as non-preferred, any load pulled towards it is
pointless since the task will be pushed out again in the next tick.
So, consider only preferred CPUs for load balancing.

This ensures load balancing does not fight against the push task mechanism
which happens at the tick. Also, this stops active balancing from happening
on a non-preferred CPU pulling the load.

This also means there is no load balancing if a task is pinned only to
non-preferred CPUs. They will continue to run where they were previously
running before the CPUs were marked as non-preferred.

Bail out early for NEWIDLE balancing, as load balancing is done only on
preferred CPUs. Note that idle balancing is allowed to go through, since
that naturally updates nohz.next_balance when all the idle CPUs are
non-preferred.

Also, optimization in find_new_ilb() is skipped. The steal governor driver,
which is introduced in later patches, updates the preferred CPUs state in
descending order. find_new_ilb() checks for idle CPUs in ascending order.
Hence, in most common scenarios, the idle CPU found by find_new_ilb() will
already be a preferred CPU. When all idle CPUs are non-preferred, the first
idle CPU has to be chosen anyway. All of this is naturally handled in
find_new_ilb() currently. Adding additional complexity to it for rare
edge cases is not necessary.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f79fcba4afec..d2000ad430a0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13440,7 +13440,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	};
 	bool need_unlock = false;
 
-	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
+	cpumask_and(cpus, sched_domain_span(sd), cpu_preferred_mask);
 
 	schedstat_inc(sd->lb_count[idle]);
 
@@ -14555,10 +14555,8 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 	 */
 	this_rq->idle_stamp = rq_clock(this_rq);
 
-	/*
-	 * Do not pull tasks towards !active CPUs...
-	 */
-	if (!cpu_active(this_cpu))
+	/* Do not pull tasks towards !preferred CPUs */
+	if (!cpu_preferred(this_cpu))
 		return 0;
 
 	/*
-- 
2.47.3

