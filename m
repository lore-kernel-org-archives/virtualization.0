Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99699475
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568260; cv=none; b=IHJS5XucSGcoX10uSyNm6150z5gEWseUirnNbV3beNOu7Hw1w129xtF+kwjgR0bdvFiUzbcCAY8FZ2bkc5j1QexHV5evo9aB0pYy27LENdmcRmnJY0rBCyFOCgpe/ol6PCpeFMRgIBVovWVjGGS93gya8GTjZpQymMwDBGwWs20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568260; c=relaxed/simple;
	bh=mogs20aHP34NhTa3btGIMuXI02JCgfTm/y3ZNbaFR4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMMfk+6FbROLYwjjQt/obzeC4NZDoEfdz9K0jgCG5Zi+z3DGzogluw9KhD6XtSMirWwxZNgHURUckR8L6tCubTPEfYz6xJGIHSXqT52aBSbyNwIxw1YqMXWTfAu8IMc82fgvotb6R6/9n1M9zTgzcXwfN02zyXeM9bOEajnmyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=igfDG9Do; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="igfDG9Do"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBjBP2730703;
	Mon, 20 Jul 2026 17:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qxM/3vfEnWBwdX/qG
	crMqWJT1i63t6l50dahfJlucf8=; b=igfDG9Do1AXNfCdHvO3/QCmIxSlyQYdq6
	8b3VhLCaCXHcylGpSpCxoeTcxMlHlLFccPZILotpYax5x5w7WQO6D/49N/0giNA9
	/pXIGu/4ovg1EZD7RysZUtNidJBtNUGHlaDOeF+rCWJ7nVVIlH9z8ugN8piNtwIp
	oOYxU6gLfb3mLU8xz7oN1mS2Jzb/t6rjmW7zyP7K093D4tkbbSx9O5r7L1VOuniI
	TONy5GDtej1KV8W0f5hfivm0se1/lNDpDUpIG9yMr0EELOfKXqZTiBJeo3WtT4MO
	r0U5Vjng4If3nm1n8YOJcIGNjbGzYHv0MVTVJRVbB1joFy0cJcaiw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k0eab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:23:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KHK1hR002555;
	Mon, 20 Jul 2026 17:23:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpxsgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:23:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHNoXS45351216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:23:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBA2B20043;
	Mon, 20 Jul 2026 17:23:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3BEB20040;
	Mon, 20 Jul 2026 17:23:42 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.17.130])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:23:42 +0000 (GMT)
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
Subject: [PATCH v8 05/11] sched/fair: Load balance only among preferred CPUs
Date: Mon, 20 Jul 2026 22:52:44 +0530
Message-ID: <20260720172250.2257582-6-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5e59ac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=2Q5jPFoXVaBPfP7xRooA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX1Iu8kfBP5BF6
 awDwwH2uSvCkceNEOF4ZCmOlu1FnfV9Q+ty3esLEEI8Xex5waf9HF6JVrkc9a03Jp1eI7fqVuCx
 XBCIiiAqC0Ay2Np1bIvcImVmiZerHVVrMRotYySSpTiVrOVZJSmVc27kBWz5NIvtl8JJm50AqQy
 Tsg5Vm4bC3PGTf4osUQO4IQPkHy4wxy5mBgnbSTFaQKYK1PFVWzMpGKlTGyymVGZR+QFBXKSQzi
 d47aAxl/RIB87reo18VrsdWFtidNcG7eNQSDTDOGx+5xGatembGCXunay6HcoF6O8/w09At84Rp
 uafp6JjCEj42kUYbfhZrei9rze3tCm33z+ARF9hg9WPuZhDwvfpR+ZNZBXnbj36NCUo2qFToyKh
 uGfXEZDcvn1jZK14e98u7F6Sm0Q4Gm0xZA8Fd9uA/CBhyHz7yvI67rFu94bpxu9/65SUXFnUWZC
 Rmmn/sesCBvFxyDnVSQ==
X-Proofpoint-ORIG-GUID: 9oPY5zjXGx3zLnuV7tMbon5oFZL-TrZa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX5sczSoAvWVoH
 Ld0iHiHfiXbql/cIVboPOBYWPtiai3Ejem65rQ0u3Sa3Iqu2PzPPNyGbh4QjXf6uRw7CVHEbba/
 63ycJpv+fpS+ip+sa21ZM/uZY5uUdTU=
X-Proofpoint-GUID: i4iKLkAEMNMw0D7gqeXaRlTuG1v6ADl_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200191

When cpu is marked as non preferred, any load pulled towards it is
pointless since in the next tick task will be pushed out again.
So, Consider only preferred CPUs for load balance.

This makes it not fight against the push task mechanism which happens
at tick. Also, this stops active balance to happen on non-preferred CPU
pulling the load.

This means there is no load balancing if the task is pinned only to
non-preferred CPUs. They will continue to run where they were previously
running before the CPUs was marked as non-preferred.

Bailout early for NEWIDLE and IDLE balance as load balancing is done
only on preferred CPUs.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df8c9c2c7918..12f5b7de28d2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13399,7 +13399,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	};
 	bool need_unlock = false;
 
-	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
+	cpumask_and(cpus, sched_domain_span(sd), cpu_preferred_mask);
 
 	schedstat_inc(sd->lb_count[idle]);
 
@@ -14337,7 +14337,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 			update_rq_clock(rq);
 			rq_unlock_irqrestore(rq, &rf);
 
-			if (flags & NOHZ_BALANCE_KICK)
+			if (flags & NOHZ_BALANCE_KICK &&
+			    cpu_preferred(balance_cpu))
 				sched_balance_domains(rq, CPU_IDLE);
 		}
 
@@ -14481,10 +14482,8 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
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

