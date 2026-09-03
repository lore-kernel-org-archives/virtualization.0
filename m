Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526863EFFAF
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417211; cv=none; b=QKxCpfx80BqRSnlXwLFig9j8qa/a4WNYL1GDBacjtlC8NMBuGvcrSkPNFm0IrdhQkea9k95YUGJsqeb78FRdHUmFAxmY14+sryA8DS2eH/NhkWde1GSDL9vllPu8EJabZBtPqtK55pd0lXA3xodaR7mZ6ud9tPXm4n8KUtrxEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417211; c=relaxed/simple;
	bh=2eu4vRQOu6LsKhcT9hq/Hdw81Tdv7p6TCBbv2/1bsug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3hKl+SVcNZuuwOOfRKyipzco/xsuHFDCpw4iOligCiiC18GueF6Qr8jy2qXsiBYDCRbwHIZN1IpbYJfsfDOIvxfAkVjxqOisVYJbkWsilLXc2unubjerVNYDmQ1i2CF4EfIk7Kfz73fRmOT14CpSiOfQzRRby/KDdlYcH7+uRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YqvaZjat; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YqvaZjat"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361TnL2186474;
	Thu, 3 Sep 2026 06:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NQfHgXW5cs2koPTGX
	h0P0s8rQJgmbX6dJiIqaQWvd/I=; b=YqvaZjatTJ8LKOV+kCCksH5JV7p5E0aoU
	ijVrK4KRIu47QOIziOr+8/708b5mMTj2TyAoQCE6gjL0bYG8gO46P6FfJYPfsBBt
	tyZUp/JuQ23vb68A8VSZRZqqxE/wq14ZtjN0LMCwFDj67vPikpjeZAwjhykSALSb
	IpWiGd7p0T3vSWoAkENMcNzGW+zWsUHlchhyVLNjqQrY9nnJodXh/skERBLAORUt
	gpuLrMfztZzjUdjOLtbkGrn4EcmDiuQDfGMILq4ylnsqiPpOPUnd+fHWZHcq/yYQ
	8PmdZV+iv8KTsfk6H+jMRmDbrr0d7HFuGh569+tTNAIiyPVHvaRPg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq553fak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:33:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6836QHF7020546;
	Thu, 3 Sep 2026 06:33:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygp73a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:33:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6836X3A539190794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 06:33:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7A102004B;
	Thu,  3 Sep 2026 06:33:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 865BB20040;
	Thu,  3 Sep 2026 06:32:55 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.27.193])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 06:32:55 +0000 (GMT)
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
Subject: [PATCH v12 01/13] sched/cputime: Add kcpustat_field_total helper
Date: Thu,  3 Sep 2026 12:02:28 +0530
Message-ID: <20260903063240.268775-2-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX2COnjSnIqahD
 UVwNmLHNNrJLaCbfVTnLDwZmDSTf8ybrwZE//7y6Wfw08MrAGhz5feTw7l042owEwuutASgLqY1
 40Rh2pRH27f6EbjazgAyU889Z2eflOJc67cVDpWgojc8C8nMvlIkXuOYH6DmcwtWcZuyMCiYvtu
 qCCXT6tsroj3svn6qU2gaNXm0TzBQ24Dm4gAZVzvlr4NYlC5Wb495YpUPBCfcR3AfmLp/nlKJ0O
 KiZ6oYOo/n3o0bnfAejHt1baaBv2gVf2a17GWDr4wXPfO7HCd5ADZoqITQ2wa2RnVp21KfB1Mf0
 n5hpQ1fn35amk2LER5iBg38hQOYo874FvQI+44IxyPdd+04H6yze+1F1gFyz+ZtBKDlXoMerNbq
 rVyjWt+j9thsdQeu4VxkOEcyK+1IijlQK8TY5l+90E1lRHueNPhVwL6G6lbzpy0aiuQtcYZ6EgM
 MVd5/T1zM0BM0wpQUDA==
X-Proofpoint-ORIG-GUID: tQId7YB9h7jSvMrpTbKJhiXYA3O9LVgi
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9914a5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=e8TCS894uZmGZegT9CcA:9
X-Proofpoint-GUID: hZqHOvTbMu9hQ5Ujq4jrVLhHyr2k1_c0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfXxxwpfmy98rRC
 hkSE64YDqSiA04FE/pB2op0PNToOgA7d5TaiaMRgzfNNngVOgu8jg7uZsGUD/IRH9zerTkGn/3K
 FzCCQEsNZ5MN8Ip/2LbUSLWjb5IvBXw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030057

Provide a new helper function which sums up a given type of cpustat
over a specified cpumask.

This allows the caller's code to be simpler and avoids duplication.
For example, subsequent patch in the steal governor use this exact
same pattern when calculating steal time.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Yury Norov <ynorov@nvidia.com>
Reviewed-by: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/s390/kernel/hiperdispatch.c | 10 +++-------
 fs/proc/uptime.c                 |  6 +-----
 include/linux/kernel_stat.h      | 11 +++++++++++
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
index 217206522266..c21496f0a141 100644
--- a/arch/s390/kernel/hiperdispatch.c
+++ b/arch/s390/kernel/hiperdispatch.c
@@ -207,16 +207,12 @@ static unsigned long hd_calculate_steal_percentage(void)
 {
 	unsigned long time_delta, steal_delta, steal, percentage;
 	static ktime_t prev;
-	int cpus, cpu;
+	int cpus;
 	ktime_t now;
 
-	cpus = 0;
-	steal = 0;
 	percentage = 0;
-	for_each_cpu(cpu, &hd_vmvl_cpumask) {
-		steal += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
-		cpus++;
-	}
+	steal = kcpustat_field_total(CPUTIME_STEAL, &hd_vmvl_cpumask);
+	cpus = cpumask_weight(&hd_vmvl_cpumask);
 	/*
 	 * If there is no vertical medium and low CPUs steal time
 	 * is 0 as vertical high CPUs shouldn't experience steal time.
diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index 433aa947cd57..53143c66cbe1 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -15,12 +15,8 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 	struct timespec64 idle;
 	u64 idle_nsec;
 	u32 rem;
-	int i;
-
-	idle_nsec = 0;
-	for_each_possible_cpu(i)
-		idle_nsec += kcpustat_field(CPUTIME_IDLE, i);
 
+	idle_nsec = kcpustat_field_total(CPUTIME_IDLE, cpu_possible_mask);
 	ktime_get_boottime_ts64(&uptime);
 	timens_add_boottime(&uptime);
 
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 9ca6c2259dfe..c1e85550bf12 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -196,6 +196,17 @@ static inline void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
 }
 #endif /* !CONFIG_VIRT_CPU_ACCOUNTING_GEN */
 
+static inline u64 kcpustat_field_total(enum cpu_usage_stat usage, const struct cpumask *cpus)
+{
+	u64 total = 0;
+	int cpu;
+
+	for_each_cpu(cpu, cpus)
+		total += kcpustat_field(usage, cpu);
+
+	return total;
+}
+
 extern void account_user_time(struct task_struct *, u64);
 extern void account_guest_time(struct task_struct *, u64);
 extern void account_system_time(struct task_struct *, int, u64);
-- 
2.52.0

