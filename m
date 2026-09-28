Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A87235201A;
	Mon, 28 Sep 2026 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578108; cv=none; b=cr8a6+OQcV0suewgDZXKzmR8gG/aIFplfu34mCaO7OFi26ilTMdt7lQ+IvAht9YT5EVt42S+0IKg30KI6hPB35J2o6JZtxOBeVhsnIy7Wd7Ur59h7B2jpHkMAQty5hmb/XLm0b/iE+w7QW1+UKZXxWMDca9/I+xeDgRUu6ad8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578108; c=relaxed/simple;
	bh=q3LA9MCjwQv35u2JvEXOlkmrM/0dIMCCwBXSeuQCuZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICHLSY5/Vwm4mnO3ZT+jhvYuCaNheLgMU3f3wWwMk/C2SjGQahdEHJpNDr2GFpET21e0vVz8bLrbAx6MJdV3DYPtYv1BuVW3VCH59JCmB8HDTlpXElZJ7Vywv3UBtqVaATQ6TH4tgsIi7byL/K+kyPwUL3YNM1MgNb68B20FRxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JS1ePXNb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JS1ePXNb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RFrUha1679474;
	Mon, 28 Sep 2026 06:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xnyZ5m
	EgbizKiRFurOndf5PYQcDMGYIXKNCB7QT253w=; b=JS1ePXNbHrrLwL5zZEHhpG
	vFe8qow4Qr87Gqb4KItAs0IQUdBecd7OnkLM3Y/TcMSww+N3AnQj3Ytev0kjU+Ig
	OyAZ35aKB3ghLUHyTZTY2/WgR3Er7PdeK6OfHkWfnpee9Ln7H8NS+1Usm3vjNJDN
	Y/4AcnrbbQm7E1gNVmCr7tvOksZQgfqPNcXSy2dD7xT3qH3paOgcjFYvz+EkjQml
	ovf/GDNDwXWtXWqOiVGZOWRCS+nWl5hdyXA2PfajvoZMBTmcuMbfTR52h8ETBP+C
	luyypS8nfAG+SOxlbgKlC7tgD4IyBEGUh1/Ig3ugMkQw7fAS1Ly0iYz224qbL/Xg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fdyjew-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 06:48:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S3bTsv2070673;
	Mon, 28 Sep 2026 06:48:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck42j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 06:48:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S6mMeR52887926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 06:48:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5766E20040;
	Mon, 28 Sep 2026 06:48:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20F2620043;
	Mon, 28 Sep 2026 06:48:21 +0000 (GMT)
Received: from [9.124.213.68] (unknown [9.124.213.68])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 06:48:20 +0000 (GMT)
Message-ID: <d2a6a7a5-b97f-4bc9-99ab-36a1ece7646a@linux.ibm.com>
Date: Mon, 28 Sep 2026 12:18:20 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 06/13] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
To: sashiko-reviews@lists.linux.dev
Cc: Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-7-sshegde@linux.ibm.com>
 <20260928060002.C0D711F000FF@smtp.kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260928060002.C0D711F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6aba0db8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=9iOWRUIKCgyvEe7fJk0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNiBTYWx0ZWRfXwcEUMtTPe0YF
 dlk4kvFyadkjjAZn6qlK8uku36emdGYUhca8kk4acLI0C26lSao/FbFoml9q7xcp1jtCz1n5Mw1
 AkEduBXLRgvBRRyoXV6LrHJMwb04+G0=
X-Proofpoint-ORIG-GUID: rgn1oPahi_qtCHzDfFuGrrJP9sI8isie
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNiBTYWx0ZWRfXyn0/QXFp1Hwc
 kCc02UJdY9U9fkXbDZqodr0Ney6ORNgbVfcwWAG47t+ZWUmNIoZgdbG5Lu7otV+XUa60I8pzx1W
 +SPBLzfvXy//WLcQlgTLNvy3ERtjhC1h7+FNsQzDgTrgAs465PLiDLL/uSvruxtzpzltb62u/96
 Ge9eylbz787fDOM38tG9BiwYC73btRH4U03n0pS5RZ4XT/N/EvMfylZBGOkL7NoBEUoRkyBzfDF
 m6k21/IA3+1O6HEOMx/RstBbsNqxCXkny+NaRJewRCZBgApvSCN8wjhiS9MngR50KpqmkLyoEqd
 M7glLH3X97qoLnX4DbHQ5KyX5vu0K48V68Rg/6T3lUL3uLQFF2betM1pvbm6DsMmReHuqfP5BPn
 iIPX4u8zngAoD887QDThFZMNz1WGADb2J838EbwMS5WeIHdCrTWox7b/6/fa5Ky+f4jOQiinwYT
 bs8RFnRi8mGDCin6nUA==
X-Proofpoint-GUID: rgn1oPahi_qtCHzDfFuGrrJP9sI8isie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280026

I believe most of the comments have been addressed in the previous rounds.

On 9/28/26 11:30 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] sched/core: O(N^2) wakeup latency and task clumping in fallback path
> - [High] sched/fair: Active load balancing to non-preferred CPUs silently fails
> - [High] sched/core: TOCTOU race with CPU hotplug breaks task affinity
> --
> 
> commit dfa0f159ec643e02807bc453bbfcc49c9f1e7915
> Author: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> sched/core: Try to use a preferred CPU in is_cpu_allowed
> 
> This commit modifies the scheduler to preferentially select preferred CPUs
> when checking if a task is allowed to run on a given CPU. It introduces a
> helper function to check if a task can migrate to a preferred CPU based on
> its affinity mask.
> 
>> For the majority of cases, this would still keep select_fallback_rq()
>> as O(N). cpumask_intersects_and(), which is O(N), is called only if
>> !cpu_preferred. The task running there is expected to move out.
>> Subsequently, it should run on a preferred CPU. This becomes O(N**2)
>> only for tasks pinned solely to non-preferred CPUs. That is a rare case.
> 
> Is this description accurate?
> 
> Because the fallback loop iterates over the affinity mask sequentially, if
> the allowed preferred CPUs happen to have higher indices than the
> non-preferred CPUs, the loop will perform the intersection operation for
> every non-preferred CPU it checks. This means any task with preferred CPUs
> at higher indices could experience the quadratic latency overhead, rather
> than only tasks pinned solely to non-preferred CPUs.
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 0183c75d7d518..04400f934cc72 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
> [ ... ]
>> @@ -2504,6 +2504,24 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
>>   	return rq->nr_pinned;
>>   }
>>   
>> +static inline bool task_can_migrate_to_preferred(struct task_struct *p, int cpu)
>> +{
>> +	/* No need to migrate from a preferred CPU */
>> +	if (cpu_preferred(cpu))
>> +		return false;
>> +
>> +	/* Only FAIR tasks honor preferred CPU state */
>> +	if (unlikely(p->sched_class != &fair_sched_class))
>> +		return false;
>> +
>> +	/* Ignore preferred state if task affinity is changing */
>> +	if (unlikely(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr)))
>> +		return false;
>> +
>> +	return cpumask_intersects_and(p->cpus_ptr, cpu_preferred_mask,
>> +				      task_cpu_possible_mask(p));
>> +}
> 
> [Severity: High]
> Does this intersection operation lead to quadratic latency during wakeups
> when combined with the fallback loop?
> 
> When select_task_rq() in kernel/sched/core.c picks a non-preferred CPU
> because it is idle, is_cpu_allowed() will reject it, forcing the task into
> select_fallback_rq(). The fallback loop iterates sequentially over all CPUs:
> 
> kernel/sched/core.c:select_fallback_rq() {
>      ...
>      for_each_cpu(dest_cpu, p->cpus_ptr) {
>          if (!is_cpu_allowed(p, dest_cpu))
>              continue;
>          ...
>          goto out;
>      }
>      ...
> }
> 
> If the allowed preferred CPUs are at the end of the cpumask, wouldn't this
> perform an intersection for every non-preferred CPU it checks, leading to
> severe scheduling latency? Additionally, wouldn't this deterministic loop
> always dump the task on the first preferred CPU it finds, destroying load
> distribution by clumping tasks on the lowest-ID preferred CPU?
> 
> This performance degradation from wakeups on non-preferred CPUs does not
> appear to be resolved in the final state of the patch series.

It is mentioned in the changelog and this is true only when wakeup happens on
a non-preferred CPUs. Even if it runs there is meant to pushed out. So take a
bit more cycles and do the right thing.

> 
> [ ... ]
>> @@ -2519,8 +2537,12 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
>>   		return cpu_online(cpu);
>>   
>>   	/* Non kernel threads are not allowed during either online or offline. */
>> -	if (!(p->flags & PF_KTHREAD))
>> +	if (!(p->flags & PF_KTHREAD)) {
>> +		/* Try to use preferred CPU if task's affinity allows */
>> +		if (task_can_migrate_to_preferred(p, cpu))
>> +			return false;
> 
> [Severity: High]
> Could returning false for non-preferred CPUs here cause active load
> balancing to silently fail?

Spreading load to non-preferred CPUs is by design and expected.

> 
> During routine background load balancing, if the system attempts to pull
> load from a preferred CPU to an idle non-preferred CPU, the stopper thread
> will run __migrate_task().
> 
> kernel/sched/core.c:__migrate_task() {
>      ...
>      if (!is_cpu_allowed(p, dest_cpu))
>          return rq;
>      ...
> }
> 
> Since the destination is non-preferred, won't is_cpu_allowed() reject it,
> causing the stopper thread to silently abort the migration and break load
> distribution?
> 
> While follow-up patches in the series restrict the busiest CPU to preferred
> CPUs, they do not appear to prevent the destination from being non-preferred,
> leaving this active load balancing path broken.
> 
> [Severity: High]
> Can this rejection introduce a race condition with CPU hotplug that breaks
> a task's user-configured affinity?
> 
> In select_fallback_rq() in kernel/sched/core.c, the loop might skip an
> active, non-preferred CPU because task_can_migrate_to_preferred() indicates
> another preferred CPU is available in the affinity mask. If a concurrent
> CPU hotplug operation removes that preferred CPU from the active mask before
> the loop reaches it, the loop will skip it too:

There is two iterations and steal governor's minimal interval is 100ms.
So it is likely safe.

> 
> kernel/sched/core.c:select_fallback_rq() {
>      ...
>      for_each_cpu(dest_cpu, p->cpus_ptr) {
>          if (!is_cpu_allowed(p, dest_cpu))
>              continue;
>      ...
> }
> 
> Could the loop then terminate without finding any allowed CPU, permanently
> forcing the task outside of its allowed affinity?
> 
>>   		return cpu_active(cpu);
>> +	}
> 

