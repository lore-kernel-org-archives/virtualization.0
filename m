Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995123845A7
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573901; cv=none; b=He4RrE24nNtGvNNhsA/m2erFFzGB6QOoKd+cOgyW2C2C5iGOZ56oOjhJiPgeZ/M81elC3rI2tMV8Md0ovWM0q2Q5fXQ/Qh4YAgPl3Vs3tC9ev5t7Y+z0V15LSME2hU0tgP2KuJkUguxZedJP6UhQn73oWn2SPR54cKjr+N4kQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573901; c=relaxed/simple;
	bh=CR6lPjPmIs7B/vZ6MqXQRnma9EgaPId0HcCnLjsrn7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESjw7bNjir2aDkxKQL4QhEx7eC6pZe1VBfJOfavgdqBj4RXOd70DQtQRgCiP08W46vaXrvRqcMaH37VjQjWisZIW/C36oXP3a3Ecw+/Kg93bsgh8NwoM7wylPTLWzKcyWGGbsxSWYEJggvo3e1y77zmu5fVvBg3M+BIGQkb20wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZYB0HaKV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZYB0HaKV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RGSGt22592686;
	Mon, 28 Sep 2026 05:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=892+fRqgga7UiOa0g
	Yx1oSkKwKbBRGQrN7BUe+0/Oyg=; b=ZYB0HaKV4v45HbM6UQV2vXEp8umBl5fl4
	JoUzP3tMqyn/Mc+Gqat6FWK/zj0Ri1jf+I/VntSpSt2V1SMLnbqPILCc2IZlYLfn
	sQ4BkNkdHQFXLX/4FX7i149KLJHE4epZezO/eO7jdfOrEHkArkXwPAN58iTAObkx
	hz6XlL9RUMyF6z//cMtAbQ2Xzi5VAf6+H/IoGSg5zUnSrz9QNSuHcXIKm/hCwnH1
	SQEOPAmsQz1Qnw48y1WkVnVhZnQZ0z8y0r2ClXsuWd+hVxQDhleGlCgCINqNRYOt
	9/jpkff1Y2/ZrSB9hklAtZBp2Q6IjYMdJegrJckOnbdz23tbasxPg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qqyg00-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:38:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S4GILb2157653;
	Mon, 28 Sep 2026 05:38:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhbrw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:38:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5bwX131392032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:37:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D98820043;
	Mon, 28 Sep 2026 05:37:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3581F20040;
	Mon, 28 Sep 2026 05:37:48 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:37:47 +0000 (GMT)
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
Subject: [PATCH v14 01/13] sched/cputime: Add kcpustat_field_total helper
Date: Mon, 28 Sep 2026 11:07:16 +0530
Message-ID: <20260928053728.797539-2-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX+2OjZj3HRGt8
 hj5cJ7LRVqDPzDfJtbX0M3pO1nT538JjRLO8Nn6ZPPONp71NyjG0vCRR3UUP+GGF9/USaPeqtgf
 b+87tpG4FNDWfZPSrGjwSGP+k+JTn+5E1oVIU+vQpf5NnZWOCEIMzFt8raPoV+U0HSbgTHjScXm
 Ile3ePefMyqP73qzSIxik3CpZsrXdmFLaHo/mgvuIlTsKQFR5kFnE3OCggq7v7Zp0XyTuE5qg4i
 kmpzSqANGw09DPexvS/wtZo8LnTOGSv0n8R4vIQpatVhdmQUN1mHKfh7MHDxycJoanYc4J684J9
 jRTwPleDmxOcazM8u99RFhNTWLWtio9IzVnCPCXMIOOanwiQhYXMQBUivEZ6ROXIbBDxQKLKoZV
 EDYL2EsNPoNzo47tVhNn/jf9ugsPHH+oeqMz0InTZJkwQ2yl+iVIzKCVpeWKouHsMWivP87r7al
 7MkN55cAiRBBDgvBhPA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6ab9fd3c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=e8TCS894uZmGZegT9CcA:9
X-Proofpoint-ORIG-GUID: TfOJIZQfneDVHPj9kYCvClPObCTbIm_j
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX7Atg57VeLfB9
 KgOVynp+OaAxzxeQcBkEMZa/i2wV/8yFJQHFFBgGBM41fQjkzG7FjAIJ/ARvmeYk5jf8P7opWcn
 yJb1uOtLXsgRWm0kGU49M5TukmO9J38=
X-Proofpoint-GUID: Z0klzcSu0mugIBGtFY80S_6hXNe_OMmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280022

Provide a new helper function which sums up a given type of cpustat
over a specified cpumask.

This allows the caller's code to be simpler and avoids duplication.
For example, subsequent patch in the steal governor use this exact
same pattern when calculating steal time.

Number of cpus can be derived from cpumask_weight() where necessary.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
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

