Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF5B3EB104
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788751443; cv=none; b=ZQo/jZ+/aK+RvYPEm0y0i6wx9y8tVKVWBdmEGyk7AdwhXnjaly/kYjryYOYMkcEMoDVJ9FJolcENH2m2j0wzviFGoNQMQSn1Y3dt7dvWEBV67uOaWv14jT1Rv83Em/QYprZe1+pgCQpHQaatQkRH2yeod9vhNGmQ98H1imTxP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788751443; c=relaxed/simple;
	bh=+3qeet1gjH+Lyp5L/bYg2ta9Sk6uQvhZlImteiB/d5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtuMa2IClRZIanPBOvKDk5qEkrwzd1LZI7iSUfNSV5G+si6Me6et2I1EcW2Kg/+pEXtST9XIc533pDV909sRhdrPx4NcS1yjrrGxcZZ9W8EZRPWtd6NoCxuLuB+/sbzGkZSu8ISMvxS4f3wyNqOelxdK5q0vsJqM/ekR1crv4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qFklfuIz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qFklfuIz"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6870VVR9319839;
	Mon, 7 Sep 2026 03:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xgBjMM
	jxtCv55t7GMT2w+mlDGqrwgg7Z4rq7MwlBzjI=; b=qFklfuIz0Lq2xUNoZyDnH/
	EwGHd3Mne3jJE7shMq7WsMIwSryd65iz6aF6KXILoZzqYG1TWi1/Qr5iHqkG/CiF
	fiuo4TnG/MfljRQIhVQzAsoFuuRlxcfIGeMzN/+1ikLOI7pWVrlXPgHKEow/0bcc
	3eHjO9nRL+EOqy+ZU5P6bfowzDLzJJeRDtkUpccecvTrhZBppPjIaXwZGqM/T92B
	P+5/NwyPo7O5aXsCCwW65IOIRMCNDvupqlGvJqA3bP/3rMbm+lU0xV3KCq8yNXmc
	bWJbqTtoCceGQzHAfE9z10rF+U8CslLfbDZjv24UQVfzlGsOOsZ/ESWGWJ+2bppg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf3p9wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 03:23:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6873BSWo020221;
	Mon, 7 Sep 2026 03:23:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdq3swf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 03:23:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6873NUw847251788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 03:23:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3B3F2004E;
	Mon,  7 Sep 2026 03:23:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FB0B20043;
	Mon,  7 Sep 2026 03:23:20 +0000 (GMT)
Received: from [9.124.222.214] (unknown [9.124.222.214])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 03:23:20 +0000 (GMT)
Message-ID: <7d88a3c4-a7e4-4814-9e29-84955b69a5b3@linux.ibm.com>
Date: Mon, 7 Sep 2026 08:53:19 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/13] sched/core: Push current task from non
 preferred CPU
To: Yury Norov <ynorov@nvidia.com>, yury.norov@gmail.com
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
        meted@linux.ibm.com, tglx@kernel.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com,
        chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org,
        arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com,
        tj@kernel.org, tommaso.cucinotta@gmail.com, maz@kernel.org,
        rafael@kernel.org, rdunlap@infradead.org, kernellwp@gmail.com,
        linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev, sunlightlinux@gmail.com
References: <20260903063240.268775-1-sshegde@linux.ibm.com>
 <20260903063240.268775-9-sshegde@linux.ibm.com> <aptiJP_8SWwZWju6@yury>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aptiJP_8SWwZWju6@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: zrImal1Nzg-DsaD9VLSbOR3qG45-w3L7
X-Proofpoint-GUID: eKDAiZnKn75BVPjYCjFa1DFEf3DEf1YJ
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6a9e2e38 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ZHGiqxHou45PFmVM3NkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDAyOSBTYWx0ZWRfX918BeP/941HV
 GN93u7H7YYJglb2YIF3loIaieSVK9HPqEkZmNJT/iy+C4ehOpzeg01BvS6QBXYdqfCLL54zXZdU
 EKj/W86I6pcf81K2Wpvsk3ULoWSnUIQulll2w5l3sdQyePOHRCDyXuYy9rByxx1SUUf2klzsSRB
 Ohpm9mKcePmQEZw/P9mBOpPzKkxxn0vSsvDxUEmf9O7pOcfoME6JyUGtPTItJIdBc+UbtTDVA6y
 uu0tyN/yVy8IQ7wHRI+Nk+ygLGrjS4kXJsdkvj0yeD7fngWj3FdJROUJhGOiSxwxppw5gmWm5R5
 lInGVIvLm1e/+9XMLrvuIC5a1vM+Eta5uB6ZUEh0AfD14RoRBqD7DJWySo3f1beX9FYtg48iaUc
 BBxPeyAdvFXDZIpzV8lW5uB0/QpFO+rsphzYzqWr99F4qHdX6FxbwkdcipKG+dg3tQOmY76G2Y9
 VkSLIk7JCiXDs/EgRXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDAyOSBTYWx0ZWRfX36zLO75rAIrY
 xxMJa/fxWIHv9FF/xx0G8ktbj9lNqjA9ILAoJbnm9qJ32lrFSxhNxPGzg/28J43G9gT+teV2fnU
 m6JAYCSpyJPlCsz6tSCIEEPUal0yIzo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070029

Hi Yury, thanks for taking a look.

On 9/5/26 5:58 AM, Yury Norov wrote:
> On Thu, Sep 03, 2026 at 12:02:35PM +0530, Shrikanth Hegde wrote:
>> Actively push out the current running task on a non-preferred CPU. Since
>> the task is currently running, a stopper thread must be queued to push the
>> task out. However, if the task is pinned only to non-preferred CPUs,
>> it will continue running there. This helps to maintain userspace
>> affinities, unlike CPU hotplug or isolated cpusets.
>>
>> Though the code is similar to __balance_push_cpu_stop and quite close to
>> push_cpu_stop, it is kept separate as it provides a cleaner
>> implementation specifically for CONFIG_PREFERRED_CPU.
>>
>> Add the push_task_work_done flag to protect the work buffer.
>>
>> For now, only the currently running task is pushed out. This keeps the code
>> simpler. In the future, an optimization may be added to move all queued
>> tasks on the runqueue.
>>
>> This works only for the FAIR scheduling class.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   kernel/sched/core.c  | 81 ++++++++++++++++++++++++++++++++++++++++++++
>>   kernel/sched/sched.h |  8 +++++
>>   2 files changed, 89 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index b4ef2e92d786..35e7eedad104 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -5808,6 +5808,9 @@ void sched_tick(void)
>>   	unsigned long hw_pressure;
>>   	u64 resched_latency;
>>   
>> +	if (!cpu_preferred(cpu))
>> +		sched_push_current_non_preferred_cpu(rq);
>> +
>>   	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
>>   		arch_scale_freq_tick();
>>   
>> @@ -11202,3 +11205,81 @@ void sched_change_end(struct sched_change_ctx *ctx)
>>   		p->sched_class->prio_changed(rq, p, ctx->prio);
>>   	}
>>   }
>> +
>> +#ifdef CONFIG_PREFERRED_CPU
>> +static DEFINE_PER_CPU(struct cpu_stop_work, npc_push_task_work);
>> +
>> +static int sched_non_preferred_cpu_push_stop(void *arg)
>> +{
>> +	struct task_struct *p = arg;
>> +	struct rq *rq = this_rq();
>> +	struct rq_flags rf;
>> +	int cpu;
>> +
>> +	if (cpu_preferred(rq->cpu)) {
>> +		scoped_guard(rq_lock_irqsave, rq)
>> +			rq->push_task_work_done = false;
>> +		put_task_struct(p);
>> +		return 0;
>> +	}
>> +
>> +	raw_spin_lock_irq(&p->pi_lock);
>> +
>> +	/* This could take rq lock. So call it before rq lock is taken */
>> +	cpu = select_fallback_rq(rq->cpu, p);
>> +	rq_lock(rq, &rf);
> 
> If select_fallback_rq() grabs the lock, then when it releases the
> lock, there's a window for race between the other process and the
> subsequent rq_lock(). Or I misunderstand it?
> 

select_fallback_rq taking lock is for any state change that needs to happen
such as fallback to possible CPUs etc.

Most of the time it won't grab the rq lock. Even if the task got pulled by load balancer
before grabbing the lock, Below (task_rq(p) == rq) will catch that, and it bails out.

So it is safe.

>> +	rq->push_task_work_done = false;
>> +	update_rq_clock(rq);
>> +
>> +	context_unsafe_alias(rq);
>> +
>> +	if (task_rq(p) == rq && task_on_rq_queued(p) &&
>> +	    !is_migration_disabled(p))
>> +		rq = __migrate_task(rq, &rf, p, cpu);
>> +
>> +	rq_unlock(rq, &rf);
>> +	raw_spin_unlock_irq(&p->pi_lock);
>> +	put_task_struct(p);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Push the current task running on non-preferred CPU(npc).
>> + * Using this non preferred CPU will lead to more contention
>> + * in the host. So it is better not to use this CPU.
>> + *
>> + * Since task is running, call a stopper to push the task out. This is
>> + * similar to how task moves during hotplug. In select_fallback_rq a
>> + * preferred CPU will be chosen and henceforth task shouldn't come back to
>> + * this CPU again.
>> + *
>> + * Works for FAIR class only.
>> + *
>> + * If task is affined only on non-preferred CPUs, no point in moving it out.
>> + */
>> +void sched_push_current_non_preferred_cpu(struct rq *rq)
>> +{
>> +	struct task_struct *push_task = rq->curr;
>> +
>> +	scoped_guard(rq_lock, rq) {
>> +		/* Push the task if its explicit affinity allows */
>> +		if (!task_can_sched_on_preferred(rq->cpu, push_task))
>> +			return;
>> +
>> +		/* There is already a stopper thread. Don't race with it. */
>> +		if (rq->push_task_work_done)
>> +			return;
>> +
>> +		if (is_migration_disabled(push_task))
>> +			return;
>> +
>> +		rq->push_task_work_done = true;
>> +	}
>> +
>> +	/* sched_tick runs with interrupts disabled. */
>> +	get_task_struct(push_task);
>> +	stop_one_cpu_nowait(rq->cpu, sched_non_preferred_cpu_push_stop,
>> +			    push_task, this_cpu_ptr(&npc_push_task_work));
>> +}
>> +#endif
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 6c3ad70e58b8..678e44134acf 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1298,6 +1298,8 @@ struct rq {
>>   
>>   	struct list_head cfs_tasks;
>>   
>> +	bool			push_task_work_done;
>> +
> 
> It should be protected with CONFIG_PREFERRED_CPU. Also, the name
> doesn't look correct. You set the variable to 'true' even before
> calling the stopper. Maybe need_push_to_npc, or similar?
>

ok. npc_push_work_pending is probably a better one? 
> Why did you place it between cfs_tasks and avg_rt? If no specific
> reason, maybe place it next to CONFIG_PARAVIRT-guarded fields.
> 

I don't see a common empty space there. I could increase the size.

> What about pahole?

I did check pahole on powerpc which has 128 byte cachelines.

	int                        online;               /*  4524     4 */
	struct list_head           cfs_tasks;            /*  4528    16 */

	/* XXX 64 bytes hole, try to pack */

It was empty space. Now, that i check 64 byte cachelines it may not be the
optimal one.

I do see, a couple common places for both 64 abd 126 byte cacheline. I believe those
are better places. It won't increase the size or cause any existing fields to
misalign. It also makes sense to guard it again CONFIG_PREFERRED_CPU. I had not
done to avoid ifdefs. But it is used only under it. So i think that makes sense too.

1.

	struct balance_callback *  balance_callback;     /*  3608     8 */
	unsigned char              nohz_idle_balance;    /*  3616     1 */
	unsigned char              idle_balance;         /*  3617     1 */

	/* XXX 6 bytes hole, try to pack */
	long unsigned int          misfit_task_load;     /*  3624     8 */


2.
	unsigned int               ttwu_count;           /*  5276     4 */
	unsigned int               ttwu_local;           /*  5280     4 */

	/* XXX 4 bytes hole, try to pack */

	struct cpuidle_state *     idle_state;           /*  5288     8 */


I will pick one after little bit of probing. My preference so far is first one.> 
>>   	struct sched_avg	avg_rt;
>>   	struct sched_avg	avg_dl;
>>   #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>> @@ -4280,4 +4282,10 @@ DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
>>   
>>   #include "ext/ext.h"
>>   
>> +#ifdef CONFIG_PREFERRED_CPU
>> +void sched_push_current_non_preferred_cpu(struct rq *rq);
>> +#else	/* !CONFIG_PREFERRED_CPU */
>> +static inline void sched_push_current_non_preferred_cpu(struct rq *rq) { }
>> +#endif
>> +
>>   #endif /* _KERNEL_SCHED_SCHED_H */
>> -- 
>> 2.52.0

