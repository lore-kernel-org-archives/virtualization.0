Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77EC5632BD
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962226; cv=none; b=JEei5JBA1h1Kk5VeJ9OZnUJQXRagVVwIdZzzXd/p/sXL5aaNDsj72NvMcuR4BJakZz3z08+7WCd5366So5ecrbPNhhEdO4Jc6csW5naY4sSj2/msTcw+RXqoYEGOdTZAzbI/jUBsRIYNKADqNWuqGTXBiRXKeyGVJy7+m2A0/mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962226; c=relaxed/simple;
	bh=lcTxuNscdga8rSaz2B9Z8OQb0HAC8x5awntGKWwkXZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWdDeTvt5wOcpYMSTfPUKCP1w7Y5dC+tUcEZH9rLj0+u64pLujTQbjdpxWMkjZuLoor0FGVeZVpCU73l3I0NXb1+t/tcrdCM7qo/qLwQcBAWWEP9lGjJzgxh+CaM60POLTi1ZdVDj3iLf9vrbupYZoa3c/ju5deXAzQuFJhIsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C9c3chZd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C9c3chZd"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B225K2666620;
	Wed, 9 Sep 2026 13:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=konEXc2jTuQon/wY6
	/ypdMZPr5LgLRKRsqLJ5NwwP50=; b=C9c3chZd7M0w2qa9oheSjJmptvn+s7HSt
	OMd8DechHHolozlDCr1WOydbwNtmH1Hz2on+eI+XsahivAGs5P+cw1oomyUy9uCY
	K6cK96ESResCuO7NCT2HFfQJK1ZyE2UFDq2/SCkq2Xrnt2ZjvIHipkm2ff48EU0N
	/H5AR6R5eulAjqSGvElURxQOuOGxPvHUrCmxniy9JTRoa351qyOPpLk/vXeoQqqV
	q+FFuOc33I79EQf4V1UhbTDHg+8Ekf8SLDRMGc6DNfzD8ZxerfEQF1kmk0lTqljC
	6BpQzzjuOCzDAbbxlveKgWZVKJmHIFfEOaqZMMl6aTRwBtEhJrpuw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrww72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:56:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689DuN1d020570;
	Wed, 9 Sep 2026 13:56:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yjd33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:56:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689DuiA511403702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 13:56:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 141E42004B;
	Wed,  9 Sep 2026 13:56:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C38B20040;
	Wed,  9 Sep 2026 13:56:32 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.210.73])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 13:56:31 +0000 (GMT)
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
Subject: [PATCH v13 01/13] sched/cputime: Add kcpustat_field_total helper
Date: Wed,  9 Sep 2026 19:26:05 +0530
Message-ID: <20260909135617.871006-2-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa165a1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=e8TCS894uZmGZegT9CcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfXziMmBFHmVHKE
 2RwWRjUhWJCgKF/Sd7nw7S4ettUstnGts5ulvrgk6hns5f5+9TYMQ6Nmvxf+H5q4jtLGNkRBiF/
 z518yxgYkcPTMWCem7hOBUq5A0epM1Y=
X-Proofpoint-ORIG-GUID: lgTGQw0UJ9crgihd163uA7KxZDzmxxde
X-Proofpoint-GUID: PO4zVumFtxpgkYRnNSIO-SP5vcl6U6TH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX2LScm9IvF8Oz
 n2rVoSzn3CI4IyEflu8QjvZ3/mMKc2kPUFrHTbh6gEC0Z4lYeoUknm8Aab/8Uu6CB129BW+M1rU
 GiYVKLhvhOp39noFb9AFTlo9ZySuLy/KJELE4idwSIIUbk752YzueH9Z6uuGTJbhx5s559qExAl
 qvdz3zKfoacxUjKlXXT8/zNdtYRfzJUje1ooMuVH8rCLqSPi05iornTne81/B9g/f1kHBkwu6wh
 URG01WmtGUEYkvYN07OH63ZaIXNVniaftJ6m1FbthQx6kxIP67/iWVTqShQvrVEbCmPwQJ/jJAH
 gY/qFc/CTWS6tjm/zOYJePoCDc1DZ+AHwTMaKbQXyoe0hNq009ILZTgPbVz6NK4KiFqhmaOCgdJ
 6lD05QpEAk/TfTrqaGp2+oR9dWr72+/O0upgESstMlXo0v5JIQE1Igi3yNqz7z18E1fPKhE5r2A
 KC4DfVYV+G4yZ3puwcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090151

Provide a new helper function which sums up a given type of cpustat
over a specified cpumask.

This allows the caller's code to be simpler and avoids duplication.
For example, subsequent patch in the steal governor use this exact
same pattern when calculating steal time.

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

