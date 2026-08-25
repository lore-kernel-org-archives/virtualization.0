Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60633393DFB
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654401; cv=none; b=NBSoZQdx3km5grJCDoNDrHg1jRB+oZFJpTWsucHpSGJLcQX8WzQXhi8/EC/kiQgS0rn0ub2b4pCZywcYRz18TglhOQ4/V5g2SAkIJGdTwWyjw+H5SkScpPxKIbx538sH/EMiZyd+UudEV3BhHwDqdkalaF18fcaeanUajmgXYh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654401; c=relaxed/simple;
	bh=RFgc2L4WKSY/F0QeippM6bdE8F3DxIYfwndMfhN0lqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FU5CoBJ+PLwrb4H2vfYNDDmZ8uP4LvgVv3h+EXwQjm9v1okne3kzovG1vzzCIgm/1rLAWcum59Cq0zvdRnoZSzGJZZ74VDleAFD0Imwxsa6zGgt5gXWmH8VBpepJkE+MpJgQ27O79sp3nSBwGbSBYCL2RmxrVBxod73ExbSZ19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LR6yMnD7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LR6yMnD7"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8VcpW378024;
	Tue, 25 Aug 2026 10:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KppzS74er64w/GSvH
	wVqe7UepaXnfYsXgjBBDSgiBMU=; b=LR6yMnD7cxnEY98l7npIbb+txZcPPtApj
	ufHVCrnbMYNSwwa3nQlgwXd/Q8VrbH9UAyYEGfLNC8xtZpm8KRTMLNp+bUFNOJav
	sH3TzRtIU1SPm8yaShVjl7onBukXOM9pdlotIKGU01G1gvGdp67VJxgDSuYE0GqU
	YBU5yDXr7OozHBG2mbe2Bgql3e+tZoPEtcz3lCvpZ9VNLK7BqGf4oxvcgztCfmdV
	YhK/UYRdAQKv2JWi0Gj3eTmwYqdToVOkDExYWmjIQH6HlruApsrlqBEsjJQ2v82w
	IAOXt91MxY1IgbdhPXFvgo5TwgvPGQqBdQbCfzlu4eL+7jS7WgpZA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx7a78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:39:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PAQJTU017467;
	Tue, 25 Aug 2026 10:39:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragbj4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:39:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PAddQ843450756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 10:39:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDE4120040;
	Tue, 25 Aug 2026 10:39:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1E3F20043;
	Tue, 25 Aug 2026 10:39:30 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.21.103])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 10:39:30 +0000 (GMT)
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
Subject: [PATCH v11 01/12] sched/cputime: Add kcpustat_field_total helper
Date: Tue, 25 Aug 2026 16:08:44 +0530
Message-ID: <20260825103855.721013-2-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfX8D4qBR712lY0
 /+yr1XNlh3hTpQpcpynTmUYojNu/FF0Lt5XnBdyki9+xv+32NjrCrxcNYXVjBQwueJD9vbw/Q0m
 gsGn7j4bq0uPICIGvZwlpOxF7xMutHQ=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8d70f1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=e8TCS894uZmGZegT9CcA:9
X-Proofpoint-ORIG-GUID: DPBUR8WH_6bIwWRsG8HhI32rm0Z-_yNU
X-Proofpoint-GUID: B1Om_OUypLAdxNiX4T87RO_2oaTqVbgj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfXyw/2hRs1Cl3x
 IxafQLSmqwOwDxNsiCUC/5JU+SAesfrRNuPZEl+bul7oYQsHung8T9GJPprQ1BOQEjqHtDX14j2
 hv/u7B2MJI06nC56VcTi6F+1npG4a4qROmBu0FMPLxVnibaEaNDgOABkrw+Xpz8hb9EekhO1C32
 JkB2m1FjQX99E8jl9WUsHf7RekHrFVO0JEjsaA8D8LxcVCXpzJ9RwTebgh5Sp1E/MAaTg2gL+LD
 O2wuNqEBSCsjvRwK2JhWCsGlYTvt1/mIqkMoKvXZuckdhroqDW+OtM38pbn7HqArte5ZnTSRKB8
 ajjaJBrViSmAVEnTg8h9QqcDUixVwC+RKdh/AKTOhxPTAyrUjm/89c0Mwxzn8zq1z0003jv4Suh
 I2lnA6FQxGKufEc7t+ESR3rCVAGNZZubGMIYejK/M2r7ARXpvwb0XTR4ab/pGfBy/QVCK6CwT5c
 xBc+m89f1+GRfqsUsyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250089

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
2.47.3

