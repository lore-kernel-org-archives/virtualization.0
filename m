Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076143090C5
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902170; cv=none; b=G12+2oVPN9cPDx57L4kv27ldlbHIQWSuupOrbW2ynJsZXCkV9xCug6R7Pu2LmWXMZvgFIhBUbbHkIp0xc9yJTW9yr93iDhy0oNufcPcw5f4l+pd+iq8pBO2ednRuyB9S9W0qKPmnD1kCRrKj20JAI1jEnPtKJzNBRfJwBwurvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902170; c=relaxed/simple;
	bh=mogs20aHP34NhTa3btGIMuXI02JCgfTm/y3ZNbaFR4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ral0YTaYbnYz8NDT+WG85stsJHruu8LqNQGSHoJQmHwBfcXTAm8K62ASiUYMCGr/ME5O0jyIBODBFa+eSPFO+5xruIuoVBoeyN/0ciS1WPVqP5faW6X4GBeFqxeGc3SA2p5Ioyw6SivIziuOQb1kbvaIMOKu5mDX6GOGNHVB4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RVYb7gtH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RVYb7gtH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfdIZ1992736;
	Fri, 24 Jul 2026 14:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qxM/3vfEnWBwdX/qG
	crMqWJT1i63t6l50dahfJlucf8=; b=RVYb7gtHYjSR4MPxS94hiDEk/uUPnVrSJ
	PjXEkN2xZmM5KT+oR+7ZHQyDbOvJjltQpPAm+10Clk4RdqiYrJ6dA0j7yctqNnoQ
	JG0d4pGbYWF5zHCOJWaVjzYHjhOsHxeIWPyycwSubWuYJRzrw/+S3w7tYZlDoy5g
	uxjRWzu3u8QjqsSQNJTZqreLHfGc2DPny6rMqgPfDBtECzR8xFS2zLnYsZoDtDQz
	Xdy7DUpRyxaylrH/i06E4VK3fx3SUYJ9GQBTWzrbtSDS36VHV7D+1nvHOsdahopF
	hOGD8Rwqz4HbQ5ohnzUAa/ezPadbjOgAFeEOHHQOzKwlyBUVUMBcA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h009us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:09:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ODo3Pr024919;
	Fri, 24 Jul 2026 14:09:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahh5k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:09:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OE97js45941206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:09:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C56BB20171;
	Fri, 24 Jul 2026 14:09:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3ED520177;
	Fri, 24 Jul 2026 14:08:49 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.20.178])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:08:49 +0000 (GMT)
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
Subject: [PATCH v9 05/11] sched/fair: Load balance only among preferred CPUs
Date: Fri, 24 Jul 2026 19:37:26 +0530
Message-ID: <20260724140732.2683314-6-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a637209 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=2Q5jPFoXVaBPfP7xRooA:9
X-Proofpoint-ORIG-GUID: ZUYqW2vUTDVSMu8W5ZiUi-GuKjdFPCvZ
X-Proofpoint-GUID: xjJni0JwHTSuGFoqhXiE241AQaqR3A-m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX9bCJsuRjGdrA
 xY4WLcxQKyG6bH5EKkeWT5dDI+56bQe8m1sYBE4o9Q0KQ6Ao6Y2dqcKobyGLca9FFGNn46e33kO
 kc/e6qJbRQuglQyr+hiw9bsDKi5bZ2jtrg8773RMmC+EF6isHUWj1WxdoQCcuisIpARECzmA2gM
 2sXGazSYN3J8kLxfn0lgwsrRIm0rYgyCiMWhJQBH/PC2Yg/i7jeUj8to5kds9l5afkEC6tgSgdC
 Gs1z4XuoawrdD18v0FI2AWcgkOrh9ig/f6+nz/7FzHGllygk78UBjkwFhVIkQf6RIBUtQphCaUN
 qA+pMskrWxLKUD/vALsdp0XSNiVGgjB0ZIpZeW0apRjMkj+qFkKmxHci9U+DQPOhVgYhQQkLVzq
 9eA1Vxnye0jxaZzsrq5dXCEXoNmwN4GOo+Q8Bx8Qj7Eq4B9HGc/OH0bJKLaAzsOWp3Ue6Msy6/g
 AeBo+K1MPPaBJbPm+qA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfXxk3zJeaMxdQa
 B0wK5MQ9trhR7Rd4VH7jF7PuRvZj1EDDsNsWqwn0E4Ant4JpY13RNzkWZKU9hUXoDkQIXJZYk08
 JEltstOTn7okQgd8NE6xkbfnnFbZdp4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240124

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

