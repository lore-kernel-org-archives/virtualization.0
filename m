Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D533911DF
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573974; cv=none; b=GOT5ChD0zVMC7CNvsC1QRC8uDT2oWadlsEpchsiywHzFw8x33HJll43J3gJqhaLTyx/XpydUu46wQN33PN8fNIhU966Km8hAndTNxXXwI8MRAvvgKGJO441twnfqbkiDPImfL34nxoOuJhzra78b1T+ffkzLxOf3/+bEIUwob5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573974; c=relaxed/simple;
	bh=WV94R4bdSJj1h+wqg3qTB69SyGPxryLA3aAI7gZJb5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhkLDRauV8F5L3sAIKNoNv5+s/FJY77WGF5mF+m7Tyl/T5hGA5NCJ6vz+F0KGs6CMKbeAY+22hfXGqCIBX4tTNrkWmf9Ma1IJ2220sA6GdjWywER26p293aTFdazyleXSTPweQqV2c7zhTy6eIIzgeJUuzNxXeE/MObO5iXzmtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JA+trgJW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JA+trgJW"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68REscbj030241;
	Mon, 28 Sep 2026 05:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ACCi0W5xeo6XQLJNz
	dWH/VD9NE5Z4JGt9f0/KSO0OnY=; b=JA+trgJWpXO5wsjz9X0WfvxwlWNsaWS8K
	GTaCOsGPY78vt9nkqpNulfgiPCtRW+hERIqeQbQ4CR+akqhjpXTVJV+DEnl+icGZ
	WF4dFO5m4tXq4McUv7h5c/bahBCUwx2VjNksFXChe6j9oK7oHVQm6ChLMcmI4uXj
	RUE3gJyTCWzbrFxVWtYaFmgPL9/E/SgqaAAmkrvIBzP7ZIzoTTi+FEOFVa8Q2PNz
	CpG7xV/evHGOdYIpdOMUULQJQNYHjks+pGBohgTCXU6kRSteejMjiwEF8fIqwk2P
	0XkIKSnEeWLB8pC84k1xGhsG6GLzL2ul0wK6p7lVDnCrydLDq9zHw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fjyg6u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:39:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S3c19j2157899;
	Mon, 28 Sep 2026 05:39:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhbrye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:39:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5d9O251118580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:39:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E38F420043;
	Mon, 28 Sep 2026 05:39:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7008320040;
	Mon, 28 Sep 2026 05:38:57 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:38:57 +0000 (GMT)
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
Subject: [PATCH v14 07/13] sched/fair: Load balance only among preferred CPUs
Date: Mon, 28 Sep 2026 11:07:22 +0530
Message-ID: <20260928053728.797539-8-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GOj41IppJTqaxUQvPK9LqLFz8UUsGgwl
X-Proofpoint-GUID: 2GOIzXwwlPJWKaLWJywVw1qEUyuPkHq6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfXw0WuEv4LP/f3
 uwWqZhu4fqCAtqRtV/gszJpm6CSjFzakv+kbfkYHPSuEPoAR6BRdFwecIMDI6Lipv88a0cfvFFo
 a/F5n+H4UyrZySKCCPFUcXUmAjE3LMs=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6ab9fd82 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=f1WSfB00kwmd_FHdG74A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX8AJFZiVf5BtC
 OtylOX+ZqJ2w1kXY9bl/1fG1xaS1r9T0SW9LvK6gFsyX9n5Tn9q+mMcLYIrR7CZv5o3UMrFQosp
 6A4WRq+BewXetXIQnQ7qs4mRHiQhWd/wpaHXHwfpT4FbVwZXCpfGobH7jawNa67Gol7s+irtWse
 zGpLPLFl1cFJ9KHEnGKmPVgxFM0s3lF6tFJH5xf/NzfWtqswGZJ9WDPwAY6Ct3LFMOvWabetNE0
 iJKpEuiPSGE4g7WHbNBjwaZ+fDUjspXaP1zKkJZkqoUiW3C3bQ2ci2vIbPQ3oOucw06hLxx063D
 9l2BKcCcq2gERB0BpqJ6JJnwdpf0wtI/KVy5iFw8G9khOIPRVZvPqlM2iE1T38nxCmZle1vpKko
 Qde832VDfxTOoSoM4YNBLkdPxY/q+fbDSOtTXnDGYWHMvPp71oltSArqKtq8enCtQJ9BC4V+ixE
 03wg2xjfWMN/0cT5hkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280022

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

Reviewed-by: Yury Norov <ynorov@nvidia.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03206e15e6fe..1c687c3c70f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13467,7 +13467,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	};
 	bool need_unlock = false;
 
-	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
+	cpumask_and(cpus, sched_domain_span(sd), cpu_preferred_mask);
 
 	schedstat_inc(sd->lb_count[idle]);
 
@@ -14582,10 +14582,8 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
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
2.52.0

