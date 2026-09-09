Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F25678FC
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962294; cv=none; b=WecPV3qZ0v/ABDrolTqGjtlQ4zoF+V839oePIvvNKdFAVhPJPg3iutcv0T5rF307HUaVqf8dLWG6VAAPJtzsyKY4BGVMBSPB8A+5mUeV834LYgJip7H+DgX8cYY5QF7S0s9JnzQZmO5HrnVkycZwB957wEP8l82jj9DYuEuArfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962294; c=relaxed/simple;
	bh=A3ybtl3ykEgjMXQnq1OCQh0jcPITN2wyvRS4IGfAezQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWGGp3QowkA0MHNxs7/aUOX3UqVvk5jV3gyDMHlCCToMxmJ3m317465zg+FQjO9d7/mdxgff5NSZGKnLAliMQ2IH0QOfuPflp0ZccqGtJ+oX6dCMz0zby169yfZ27tH3fc51i+e52gtWoNCMLDkItH732WbxBpAdT6rlAM9Z0V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GsIrQJy4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GsIrQJy4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1XtH1930793;
	Wed, 9 Sep 2026 13:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fnfT0ivtkk+EP4Gna
	2l5cIIl//9yLKT11aDYfbke8ao=; b=GsIrQJy4esDcQdU/BBPqk+RPabgskDLBq
	OTnKhmbmOb+vhNkcAqfzpuqum7M7FsUr1Sdr5h8iqGYPBE8JqA56Pvv6qvYcw1vR
	D1+Tge8aoeHlItb+jIqELng/Mh6iy5keKNuSCSRuj17bgc57+G6wiF/N4LFcU1EY
	01vYprjuaPPju/2PJx93RN1u+4yffrTCHuDKWv76YNBauNV0Fr/ngjpG3qnVn8jp
	2Yzsesx/9fMuBe8vzfiAcSQl+dUR8cgplqI5/qNKWVg+7YiXEWL+eAiWdd5+OA0J
	ensJ4krc9WPD3i6J9tQ+0efOm7QWSSrooAl9xnRq5XF0CMG+yU6AA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqk670f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:57:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689DuFtY023754;
	Wed, 9 Sep 2026 13:57:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqjr71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:57:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689DvpwF50397508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 13:57:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E61A42004E;
	Wed,  9 Sep 2026 13:57:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4582C20043;
	Wed,  9 Sep 2026 13:57:40 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.210.73])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 13:57:39 +0000 (GMT)
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
Subject: [PATCH v13 07/13] sched/fair: Load balance only among preferred CPUs
Date: Wed,  9 Sep 2026 19:26:11 +0530
Message-ID: <20260909135617.871006-8-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 1GrtuuNt7tblTF-lnf7Z5nkYvLKEWPaP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX1TCiUcVMf07x
 siilTg1tV4DVPIHhqDfDKUPl4QvYFN4BnmB3C62gMatK3hPzEZXEHb+mWDTyDARj2eObpJt1xfW
 jCpVKQOh4P36lr+b04lQ028tK4/t7FE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfXysol1tCGJ5XR
 6R07eGHsgA4WZ2Pb+dG+Heua/YmX7mQ9JgDZg9ZqlOp0BRbJv3UnUZEBSknwWrqHZBNQ7cp7+3q
 PbK8b7+JlMsFFzAy6ofZkvK9FyWlnRZ0b9aLsk4gyZn7a2ousdr72xT2nyEL4iAoClw5iI/dHLo
 S8L2r7Z1ylFiFMR9ntFCG5ZEFwvZq9XHBAa8VAHh3nKOTlWrKOpHiq2hhsiUfwuIElodHNYhnNI
 WHw0zS+yQUMbdo1XVvAlAtisY5hPvFszcgBi3qFRUYrYPzfrICdU2Hnx5trFfrEI4yaNnrItMyz
 Zk+raxEZJP4MN0WMC60RhqpGCHXoqE2aNt3rCDDQENpIcBnue9Zmt4gy8jNxc2XTUkoNl4a+wgM
 5uu4+Vco//tJgG7kbKPccqjefeHwgXFlYvHAhM4psIiijO7JQ4y7/r8Gud2BXMMGHlW2I80prQ6
 gJcY6HO1rweZPaaAPDw==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6aa165e4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=f1WSfB00kwmd_FHdG74A:9
X-Proofpoint-GUID: RyIksc_0sTAVu1BWOQeH4J-dQjnxtP3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090151

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

