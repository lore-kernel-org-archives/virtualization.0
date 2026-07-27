Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82B3CE48F
	for <virtualization@lists.linux.dev>; Mon, 27 Jul 2026 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163399; cv=none; b=nAcojnVtQysdV9vtHFgdwlZnRrGPeUmJTowkUU1geFEeDA1zQQPYwSt+jyze+itMdZqxs6v8qqBtwUwpixabz77WQsFUpc7LI4cgya3lXy8goBUiFKW1fZK8HvlrAGnFRWXEyCSXoo2aUl0wOiJNBWr8DZylnl+uSAoG+KCDiQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163399; c=relaxed/simple;
	bh=lKnly6ba33m1vVp/+mkNYlL4bqzNfhRuO4PbeoEjqyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QV1SLHtRD5GK0qF3aqKXlqI2EypeDC4CtQNCnR8adWvBbK0JIKksFYBkuqWGMT0aPjErJLaDWlpviJRBCe2am3fEgsYV07T8RRKRNADLoUXSGkNVf8oZYY/GHzDW6wET3hh0u4xQjKuq2bT4SKtkl+YAT2TNyUbP4iVrvMdUyWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZgO4qeT9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZgO4qeT9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDn4X62407913;
	Mon, 27 Jul 2026 14:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cL/VYc
	kYOM5FAjlzVSQ3Xb7rNg3Q3ZS6xi9asUfQhA0=; b=ZgO4qeT9D1Ni8m2l1KVlER
	AAAHeLlix489DveR7Ahxkha4DpVIEllyoJuht3xHmp57nv93rDf0Cjr96+DQNIkn
	BPb0Z4JeklGR2KYa9go5HzOLPMr34ZCiq9d3mP62gaO6QjXzoC9rndKOYS72UNFg
	0f4J6r6Moxq5huEQM/TwxTaB70zUnJXLg/YCwXo7/VYoS0TccD3J5BTp5zZpd7Jo
	NA805ZqPSPwwhbNM/Us9xvgh5TSw3P+nmYZKRf5g8wodsL0eYUHM5km6y3IbLGms
	rSh82AAGOxCSDQgjmsv3j/g0vfD9l279eDmEqJy6qEBQt8VAD8xSgeU0ogE4yFbA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xgj8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:42:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REfHqG031134;
	Mon, 27 Jul 2026 14:42:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg5jmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:42:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66REgrmj30212712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:42:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC6E620111;
	Mon, 27 Jul 2026 14:42:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 633112010F;
	Mon, 27 Jul 2026 14:42:45 +0000 (GMT)
Received: from [9.39.23.10] (unknown [9.39.23.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 14:42:45 +0000 (GMT)
Message-ID: <d3533cdb-d32a-4d75-84d5-a2908ecc7bfa@linux.ibm.com>
Date: Mon, 27 Jul 2026 20:12:44 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/11] virt/steal_governor: Implement steal_governor
 policy loop
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
        corbet@lwn.net, tglx@kernel.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com,
        chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org,
        arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com,
        tj@kernel.org, tommaso.cucinotta@gmail.com, maz@kernel.org,
        rafael@kernel.org, rdunlap@infradead.org, kernellwp@gmail.com,
        linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
 <20260724140732.2683314-11-sshegde@linux.ibm.com> <amPTg78qsOw4WpqB@yury>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <amPTg78qsOw4WpqB@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: POXXrDXrlCu6n3d-MMvW0W1CKFurGuZ4
X-Proofpoint-ORIG-GUID: pi0sFtLpCNH4JU1TwgjfYwp7pFhInOtx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfXy6ewYN/GJMyo
 pVp/+KDjq0NSga0T6MVn4CxfOfPIUhaREOEjcm9aV/1G/ZCPczlvy98yWaap3EkOxQTyKNeP2Hv
 ZfkJfLcByZ/fINQR3Pfh2o/iQmYq5Q0=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a676e73 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=0sYthHVnviW2AvWz4v8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX9JLFHZKOicDc
 uF2rPIpZT+a/XEbGB074BHyeJVWxF3fAuOxJ+5NsNVXdN4kLE0bx1cN3Qs4yurmIxrPI0et2Pvu
 9gGkHDD81vQNYLjZW7jz8Z3SIKah64ZPdAvQbfg7Idet0KySxu72OYGBasqlla5FhnIsLNmdk1/
 4EkKsrG0zl7u0gIq46/3fVXnmBDc99ZlE9R6ZtIKbNOFm8uARjq7qnBj5l0dEjNGBRR0LZoKDld
 m3uDqWfs9ZQtnaaaXpFVGkbi/Ik9NtWCGJgtM8wKAoStjvf4kRJmEVgU3nfgqkmpWEpikgcUVR6
 IZY4P4ezQ717DWCUf46QUsyT698Imlcuje85AtLe3f13S3b4IcyHQLZpXfkUblkLoBD+kGELxru
 GFWXDXEFgp530Pkf20quxuEO50o8FWoHF4VzFBOiyDFvw9DeogOnxFHUM3yDnC/AFTFAbYd6Gv3
 /mESHDggSnDFP1kaXBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136

Hi Yury,

On 7/25/26 2:35 AM, Yury Norov wrote:

> 
> In v8 I pointed to the identical function in s390 code, and you agreed
> to unify them, but that didn't happen. Please do that in the next
> version.
> 

This is diff i have now. I assume this is what you had suggested.
Let me know if it differs.
  

commit b3aa88b7207c7a23ef9d60dd12f02eb4f4d79abf (HEAD -> sched/core)
Author: Shrikanth Hegde <sshegde@linux.ibm.com>
Date:   Mon Jul 27 09:11:08 2026 -0400

     refactor for kcpustat_field_total

diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
index 217206522266..0c658f229b17 100644
--- a/arch/s390/kernel/hiperdispatch.c
+++ b/arch/s390/kernel/hiperdispatch.c
@@ -210,13 +210,10 @@ static unsigned long hd_calculate_steal_percentage(void)
         int cpus, cpu;
         ktime_t now;
  
-       cpus = 0;
-       steal = 0;
         percentage = 0;
-       for_each_cpu(cpu, &hd_vmvl_cpumask) {
-               steal += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
-               cpus++;
-       }
+       steal = kcpustat_field_total(CPUTIME_STEAL, &hd_vmvl_cpumask);
+       cpus = cpumask_weight(&hd_vmvl_cpumask);
+
         /*
          * If there is no vertical medium and low CPUs steal time
          * is 0 as vertical high CPUs shouldn't experience steal time.
diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index 715aa7f90407..1f0c377c739a 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -116,13 +116,7 @@ MODULE_PARM_DESC(low_threshold,
  /* Return collective steal time across system. */
  static u64 get_system_steal_time(void)
  {
-       int cpu;
-       u64 total_steal = 0;
-
-       for_each_possible_cpu(cpu)
-               total_steal += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
-
-       return total_steal;
+       return kcpustat_field_total(CPUTIME_STEAL, cpu_possible_mask);
  }
  
  /* Return number of CPUs to consider steal ratio. */
diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index 433aa947cd57..53143c66cbe1 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -15,12 +15,8 @@ static int uptime_proc_show(struct seq_file *m, void *v)
         struct timespec64 idle;
         u64 idle_nsec;
         u32 rem;
-       int i;
-
-       idle_nsec = 0;
-       for_each_possible_cpu(i)
-               idle_nsec += kcpustat_field(CPUTIME_IDLE, i);
  
+       idle_nsec = kcpustat_field_total(CPUTIME_IDLE, cpu_possible_mask);
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
+       u64 total = 0;
+       int cpu;
+
+       for_each_cpu(cpu, cpus)
+               total += kcpustat_field(usage, cpu);
+
+       return total;
+}
+
  extern void account_user_time(struct task_struct *, u64);
  extern void account_guest_time(struct task_struct *, u64);
  extern void account_system_time(struct task_struct *, int, u64);



Note:
As we discussed in v8, I am leaving
fs/proc/stat.c and drivers/leds/trigger/ledtrig-activity.c etc alone.
Those functions sum up multiple CPUTIME_ fields.
