Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2285F207A32;
	Wed,  9 Sep 2026 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972567; cv=none; b=ZSKqf4n2OFN9URX5514FOVYWZD9EOpAtVYvmpSplee9RFt9reRgkQ8N+vXFcWlwYuzwRRY4X8x2tv1gdDMIViqOPZXMVI8MZ+YCI+f3dAxkh8fAQpEtUsn8uRLlv1q0VcTHyuNbEKAXCQeKgELflFzYRLQzFTDz2Jerh9RCBl/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972567; c=relaxed/simple;
	bh=wHS+DG2q0m0gDSc/jjOXNji8R2RTctlJvzIPABeCid0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pieYf3PvYYGC53FAowwfrSmEUAcHslOnpeBItsZWIPx8UVur2A1+kSXX8g++g18ECvUgL3JwQJ6QozahSdzCTJ8yYMvpnGfUMzid52RnW6J/x0G+5JRmnM57qDDzW09L703M3LhfoeJF0BvB+8lw+GSsYP8I52vOMjIoS2ilT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qfY4o1I2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qfY4o1I2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1krs1931243;
	Wed, 9 Sep 2026 16:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t+lBvG
	3w1dnU5gTGvWUdH/EvDR2+eYWX1cNOOC2zw58=; b=qfY4o1I22G4gxO8kMO1BRy
	5HgDIE01yhaQtSiWl748tf3pCPGT06/oEkE5WAoBDKcMQ1s3Ekcgxhu81emaAPZr
	ONsLnjXsHSJWp03QII5hjVKUkqD4DE8NvGycLVO988ake+ObkhIyrKIY2relBG4a
	lD/R22S3CxLlkB9q1eJkeqdNcwazF6AhRCBbOn3LSWqS7+I5G/MMeBB3tQvFowXx
	RcMiHpEO5buDyFboxd4azPGd4x9d83XoLUlJ80mHAnaNuSdUvXiTxiKhYd7p/Hj0
	kLQiLVyzLt0aAyh2DImTBKtxUWVXNf1U/q+OiSw4bsfwptdrxOaXZipu//q2pvCw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqk762c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:49:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689GfEdR009087;
	Wed, 9 Sep 2026 16:49:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdk3djc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:49:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689GnLV428639502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 16:49:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 024862004B;
	Wed,  9 Sep 2026 16:49:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBC4320040;
	Wed,  9 Sep 2026 16:49:19 +0000 (GMT)
Received: from [9.124.210.73] (unknown [9.124.210.73])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 16:49:19 +0000 (GMT)
Message-ID: <dcf010e4-c4f1-4d49-9c31-bea6baba1c41@linux.ibm.com>
Date: Wed, 9 Sep 2026 22:19:18 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 06/13] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, Eugenio Perez <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-7-sshegde@linux.ibm.com>
 <20260909141814.BAF841F00A3E@smtp.kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260909141814.BAF841F00A3E@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qsB5BoRrAB9TSdCh_ptB7bN9WUc-KmIU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE4NCBTYWx0ZWRfX5QscqTwqhaGj
 6scmtetK/4fPzbLZ8DouiuGALJBljMzyrzrNBE83oU92HajxfikyrEelB6NE0mMONxHiBmRXBK+
 ubZeXLkP89blmMSk0frALRuh3ownRkw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE4NCBTYWx0ZWRfX+XhMESDX6ItI
 TDXs2dWTkY4p3CGRBy9gRuJdK/bCuBzbBExYM8i7/G0TEbL1+jH2Jv/8/EQpCBCsO3RRl3yctUg
 ifZEQ8SNdnbhtK8nLIzTxfiJkMMXYe6t04vcTKGHSRQlQHPa2yOqUpjX7f5Y1uXi4YrLCXjI1Bu
 euTRlYWk5JilBiXsLHS4QLg3uWKqcSccJ1ZszZStYRHlFygXG0xpLOBzN7Qo26lqq7hNFrvnlTY
 doOMzJsZM3BI2KN+wzwWYFWL4dqhjyb8rFyIo6+crOXHErw2AWGdnmHHpuJaRHSFAIqO+d6FJOZ
 T9m6K0IlfRgiM7z4GH01s3qNohUSjpqae50FsAdl3zn9WmLrtyZi1+lG945SYR5bcrcckP4e7LB
 DyGMdZmstFa2yFJowgl+5cwKSFOrCKVRK6fnxVvp6NqEwJ76BwpjMonbiqje1qECVg8znQvU7Io
 IuehhAfdD7FbowjHjeA==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6aa18e15 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aB60JJqhC16U7aw51h8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qsB5BoRrAB9TSdCh_ptB7bN9WUc-KmIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090184



On 9/9/26 7:48 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Wakeup path funneling to lowest-ID preferred CPU bypassing CFS load balancing
> --
> 
> commit 2b5645419bf5356450334e7129102cfed3b5f5bf
> Author: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> sched/core: Try to use a preferred CPU in is_cpu_allowed
> 
> When possible, try to choose a preferred CPU to maintain user affinities
> when preferred CPUs change. Update is_cpu_allowed() to ensure wakeups
> happen on preferred CPUs.
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index a689a0cea4ebe..b4ef2e92d786b 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
> [ ... ]
>> @@ -2519,8 +2536,12 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
>>   		return cpu_online(cpu);
>>   
>>   	/* Non kernel threads are not allowed during either online or offline. */
>> -	if (!(p->flags & PF_KTHREAD))
>> +	if (!(p->flags & PF_KTHREAD)) {
>> +		/* Try to use preferred CPU if task's affinity allows */
>> +		if (task_can_sched_on_preferred(cpu, p))
>> +			return false;
> 
> [Severity: High]
> Does returning false here for non-preferred CPUs cause FAIR wakeups to funnel
> into a single CPU and bypass CFS load balancing?
> 
> When a FAIR task wakes up, select_task_rq_fair() and select_idle_sibling()
> search for an idle CPU. Because select_idle_sibling() remains unaware of
> cpu_preferred_mask, it can actively select an idle non-preferred CPU.
> 
> When this selected CPU is checked after the scheduler class's placement
> decision, is_cpu_allowed() will now hard-reject it. This forces
> select_task_rq() into the slow path:
> 
>      cpu = p->sched_class->select_task_rq(p, task_cpu(p), wake_flags);
>      if (unlikely(!is_cpu_allowed(p, cpu)))
>          cpu = select_fallback_rq(task_cpu(p), p);
> 
> Because select_fallback_rq() sequentially searches the mask:
> 
>      for_each_cpu(dest_cpu, nodemask) {
>          if (is_cpu_allowed(p, dest_cpu))
>              return dest_cpu;
>      }
> 
> Will this cause waking tasks to be dumped repeatedly onto the lowest-ID
> preferred CPU, creating massive runqueue hotspots?
> 

This is expected by design and existing load balancer will spread the task out
post the wakeup among preferred CPUs.

Since effectively workload has lesser CPUs compared to original, preferred CPUs
can be overloaded with more than one task per rq. That's also expected by design.

I don't see it as major concern.

>>   		return cpu_active(cpu);
>> +	}
>>   
>>   	/* KTHREAD_IS_PER_CPU is always allowed. */
>>   	if (kthread_is_per_cpu(p))
> 

