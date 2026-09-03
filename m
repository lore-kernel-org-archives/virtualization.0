Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8743F8231
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417264; cv=none; b=sPWf31KlXAqsYeXtwT3MWOkfMUEZ+l/irM4WHdnwQC1VJOXfRptyiaBIxJgtMENqaAWNmzUvaW2OC6NzQdcpwSw7QuOn4Xg22DcStEjdcJbcHm1C8/LggfH8GAtfEb+rW9I1xFy/uyyqfvzgrRHalXTWKkpyMKhCWvSV58iLAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417264; c=relaxed/simple;
	bh=A3ybtl3ykEgjMXQnq1OCQh0jcPITN2wyvRS4IGfAezQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwW1lX2YtjWpmW8qTz4vfwBS8K5q4F7ZBSGW5uFcJG2ThvC7wxiomv+/qrYCQRW9frgysJQT+9PHLQ3YKJEOQiCz/ook7kGb28G1epa3gOYb6lpfwTqa/YI+FB9jmvsUQqp6HefjpozQzFV/voAHRPRgDAgauL+g6uSQT8eaxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=chU8I+m/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="chU8I+m/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361R0T2187828;
	Thu, 3 Sep 2026 06:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fnfT0ivtkk+EP4Gna
	2l5cIIl//9yLKT11aDYfbke8ao=; b=chU8I+m/oT3uOXvPHQQYtXSA+K7se/2r1
	yT3vIYEPKjtGUPtq+kZc1YUVgfUzdxNHBqc1hg6vg7xwaIbcsYcgu7gaBJYvtLaE
	r7Iw0Z1vm5DPTvc93VausAuBqzqwnigdgPHOzT2+YlIT/wgJp3gItkxl0wEJ4cVP
	7CQ3kWsFra1rrsu3Q/6bmGMRFj0XlFK/rp3328XSPQMtmKXGnLHWx6sc6gNB/MnV
	2KYL/5CLQA2qgDGNXOqXaCM/SGthpwDcCYs2k5gPg5tsX0r0OzvdNjoe78VeZrjm
	FouLNdM4iFzMVH5ZSrlqJX6guFYSm6B6ZDil7naA6WLIzAk/CsO9g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5udcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:34:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6836QFuH006172;
	Thu, 3 Sep 2026 06:34:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hpa16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:34:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6836XuZV14418278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 06:33:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 548F820043;
	Thu,  3 Sep 2026 06:33:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04E6C20040;
	Thu,  3 Sep 2026 06:33:48 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.27.193])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 06:33:47 +0000 (GMT)
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
Subject: [PATCH v12 07/13] sched/fair: Load balance only among preferred CPUs
Date: Thu,  3 Sep 2026 12:02:34 +0530
Message-ID: <20260903063240.268775-8-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9914da cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=f1WSfB00kwmd_FHdG74A:9
X-Proofpoint-GUID: A_aLlRxNqqJKFZk8ZjDE4qEVSCAZmL8Q
X-Proofpoint-ORIG-GUID: CcMkAZ7OGpvib_7vR4mubDeP7P8aDZQi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX7pBP59vXCAbs
 6bQVTQdnwqo6ibiuwlSnxRUvPwtU0vpZ2Fm8KE4XhvSL1+ylykMB5j2ZYmbh7TZ/r/wDzflt2fM
 hfsewhv99/LibUr94Qnzpj32sgiX3a4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfXzGVlE+ZkNKcx
 GsVgrdbbCmUFC54Zaw4aFffm+rKF6ksA9XjjNvkeVqspt9afFRuZa1c/oEKknSEzWVoNn3iPuif
 rBLgR+V3LAxVuTJaM7K7dUYIjpeYcJ/h1p+Lr77pn64FpWxNfObIvG5pf0dlk8G6aG7ZiSpPdAy
 2YV+lhID+/rD8AyDhiq+hZPXmRXaGJIB3AadRE4vJvSIEgWFDnoj8B/K9oFsg1ioHWDDU2H4Xf7
 hkvCdrKBw/8ITh7+ekRg88tNHpHpbE1vXnKiLlB6kGKM5YnZHdp3/XhnY54u4FPTPcnBJpmIGLC
 bFwk7j34zCiJmUSIHBO448qMLRBOfDhJWgri6W6Y0ZHpKVBk/b4RsW9ruThXYVUWaq2zLL/q4P+
 BQmbx8Aj+33aHVm35ADSmspuudQkZtkmKdSRuiqhowQa3LKELKUsK5V/CaA3WPfQTgSo4+5+GTR
 Q46W9ksJ/VM3cxawOOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030057

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
index b8bd308c2d5b..4ef1167b8c73 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13473,7 +13473,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	};
 	bool need_unlock = false;
 
-	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
+	cpumask_and(cpus, sched_domain_span(sd), cpu_preferred_mask);
 
 	schedstat_inc(sd->lb_count[idle]);
 
@@ -14588,10 +14588,8 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
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

