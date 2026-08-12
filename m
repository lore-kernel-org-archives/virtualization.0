Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885C3905E6
	for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513273; cv=none; b=G8cYOvqCa9pSK/cSeHEG5eDlRwHj0tNnmjM7jRznJeiE9fHejT4y+sHN9jrHhpYlE6b3CGgzej9ftE43xLL+07Sh2k7QDU3CDig7KJ3A/p9e4G4Y2qgXGHBQjpj4vVRkDrGUUc3q4jJYXT+jcDDpFqg1/GLPU11SX1tWYPEhlrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513273; c=relaxed/simple;
	bh=6r9992HIygzYISTW/2+VEWQl2b2N806ylXZtH7gKNJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgyfX+eLe6mztQAbpqD4edcLWWM8t1q78tYSW2C3VuNVcrsJrpSD87Nay5NN8tsXWWHSIcsj9dtpO2yHF1GVh6Any6xNKKEEPbd82vHhv26RidMqY0q7UHPwaZBvCDQ4VdlKg06KJRndfTpf8gxqjcFPZk3DSMTFIgQpFOgbLE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qyu02fi1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qyu02fi1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C31lOg2313688;
	Wed, 12 Aug 2026 05:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NYIKiFngYTGj6eldO
	JLN6PCfJ/iqmxUsus4gz85gXXw=; b=qyu02fi17ifUVjKHre6vr4l68BNVl2u5U
	DH5HkMCoj/jxw/7xzjUvGBNEOvABCtlZA7cG2hiwsRScCyngFBPBZT6WZ3m1vWz1
	G2lrQ5538yYEz00+oedvmKCcHWo8c3W+iR5iH872VD8ZCruhPUd1N3alPhepB3V6
	Dmc9WKDhPKWs8kzp6fcVLSB0RngNWIxtfoZlnmQOVhAUwFZ3LQnx2b9vFnmqm5g2
	Q2fmxNgGudG7Vq1F1zSJK6t2yU3i7WDbGzTINXQSqedb7c4OHr1GPhTD2L7mqrrM
	EJiX/uwIiYJ8vlx8i4MHbB3ybBLlRHGe7NQDWGp4JaW8gMHP9Cblw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw87qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:40:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C5QMkQ023465;
	Wed, 12 Aug 2026 05:40:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy4fmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:40:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C5er9V50135422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 05:40:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A749A2004B;
	Wed, 12 Aug 2026 05:40:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE65C20040;
	Wed, 12 Aug 2026 05:40:44 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.217.151])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 05:40:44 +0000 (GMT)
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
        virtualization@lists.linux.dev
Subject: [PATCH v10 01/12] sched/cputime: Add kcpustat_field_total helper
Date: Wed, 12 Aug 2026 11:10:22 +0530
Message-ID: <20260812054033.95658-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812054033.95658-1-sshegde@linux.ibm.com>
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c076b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=e8TCS894uZmGZegT9CcA:9
X-Proofpoint-GUID: YNhKPf_ONA_FuoRHQd0FqK9bIBBrMiP7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfX9mEHCmAOQ7kv
 PSmzcan80mNPn3KgvGuXcTgazU+7R2pKkIrsA2aSY0DIpB6Xww0A1dT7CivVBsjnKqJRzQHSuzG
 jM2QibXO9cnKb86C1HN47EVKfxRTyOoknwVKBlL32DK3IQqy8aqL4Z55Q5Yjzx04Vb0RbtTU5wA
 VxaRpmiZY4KI73XQAptK8z37o8gynYTRPhJVcTmMDxPkDRxWqqJFKyWO+6Q4e3fnlKoVr4s/nxf
 5393IOdZywLtxwCl24JVeiT82vTNozeUht3705T8Fm47p49Uu6RcJksZ3iIccLkTX48H0tqrq34
 Q+KN75CTlAnZrXW+ZL/OtnNdnvJbMgN+nLM+lt0B9kbzKiveM86OKotHQ7LmXJkuvu4+l6LU89+
 zllcnJ7AAU7GhbHdnuCUn8+JWEJ+oFx1HSJdPBhJI88T7UUw5/Tbxr04GtMTC5H5f82Hm9yfgHN
 7j9ncG+bp6YE5JhoTdQ==
X-Proofpoint-ORIG-GUID: HiowgnlEHKyexb8VOMNZrBNEIGDntEVu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfXyHzRZDM3ngPc
 SMxMQY5MWQkMxcw8/yHDkqQi/840tzzqp8Il0M/ROMIVEQrFU2lPWs0pFphztLgdoGJTOHOa/Kz
 chhLh2RI2mpEawmQQOIZJ5GFZdaCOTM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120041

Provide a new helper function which sums up a given type of cpustat
over a specified cpumask.

This allows the caller's code to be simpler and avoids duplication.
For example, subsequent patch in the steal governor use this exact
same pattern when calculating steal time.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/s390/kernel/hiperdispatch.c |  8 ++------
 fs/proc/uptime.c                 |  6 +-----
 include/linux/kernel_stat.h      | 11 +++++++++++
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
index 217206522266..e5c7c818c178 100644
--- a/arch/s390/kernel/hiperdispatch.c
+++ b/arch/s390/kernel/hiperdispatch.c
@@ -210,13 +210,9 @@ static unsigned long hd_calculate_steal_percentage(void)
 	int cpus, cpu;
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
2.47.3

