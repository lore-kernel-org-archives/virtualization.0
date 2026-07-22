Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C8402B97
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704491; cv=none; b=M85YjtIOdJoJZJcl+GUAcq3Up+lufSR+NoFvFyt2IQUwbtHdkl2UjNQyBV9pDVhsS+FzLE1KJtJSTxGQl1d9Y+iCtIoUNqEOC7J/oEzVduV/B9vRJvV7B3QgNLvgmZk00H/tq4KQe0hOjlRI0Exaa748PjCXaB+IWzpxS2OGhic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704491; c=relaxed/simple;
	bh=IGMyaUgqXEctz4MBYbXSyVyY/7dcmEbnT8rUP0Zv8lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fe3IQGBf6Lj3BlYRs9X90Q8K9UhGN2XNie/xe8RmB0wstXrhcEG8zctzmeOSYvulJBLL487MZAsS8b0MtXzKwaLtnTFBZGSNPO14xXH3SSd8VBWX9E9VF2sSeOwLYyLWzKA1sfwBWlyLw5qia06gNksRiw2XVEwrR5yNOIcUNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nPZMLWbr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nPZMLWbr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M5Be393156814;
	Wed, 22 Jul 2026 07:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xjt0pc
	iVQjtiH5Nj5Ea40OjUeuXT08tHbKFuK5aIklQ=; b=nPZMLWbr9B3XMwLKEhYEDI
	S7Xvk2jzkEulBvC2ZER5nIXGfwJYktS97TXKpN6xZPA/D0qRbbCpHd+4SeDb+QEP
	Azzvf9Rsh7V9OJ/xth5vxWjg/1tK0sgrU7nB2sM7l07zH3rhHMYk8yG7tqHoFj9b
	vYpj92jqLXALgK0K10BHkAaIBvq8wH0juDhCh591x0Iklie8yIRJaFwlk9ppfhzL
	CTfraEz+hwgolI5MF2D0DqDH1N7aUJHPseIqi6rswZzlmN5nvd8J+pOKpvbXnfwt
	TSZW9rc2iqKYxMh21Bmljrz3F9IWYE+12Pbhhb1Mf+fvMAoirTeT4RzHZHG7vK9A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7910rvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 07:14:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66M74fSJ014280;
	Wed, 22 Jul 2026 07:14:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah63cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 07:14:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66M7EP3437814534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 07:14:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0104D2004F;
	Wed, 22 Jul 2026 07:14:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 261B820040;
	Wed, 22 Jul 2026 07:14:05 +0000 (GMT)
Received: from [9.124.218.133] (unknown [9.124.218.133])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 07:14:04 +0000 (GMT)
Message-ID: <c64ed18e-7863-44c3-9c7b-2f1efd1a805e@linux.ibm.com>
Date: Wed, 22 Jul 2026 12:44:03 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/11] virt/steal_governor: Implement steal_governor
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
References: <20260720172250.2257582-1-sshegde@linux.ibm.com>
 <20260720172250.2257582-11-sshegde@linux.ibm.com> <al_IbeAa3sDrt9A7@yury>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <al_IbeAa3sDrt9A7@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FtNoO_8pJ5vUf4OnHvLkKe52s-ihx3sU
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a606dd7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=jJrOw3FHAAAA:8
 a=vkDHN0YYL4jHxM_DRLwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2NiBTYWx0ZWRfX7QiW536hmml3
 mWwnzcajJJUYntIyeBKXDibFX58HTFK17hcAcol1MHi7HcHPA90wQlyEIGyz9Yn07Qdx2SEQcTu
 X2mieig+O3v+vmsVR67PVhOg1xO/ze4=
X-Proofpoint-GUID: Ebd8hMDq5Yl8-TY49EqU3ROzDX-KoktA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2NiBTYWx0ZWRfX3q4pYiQ2TOvY
 YcO45jcv3nevTIsOYllp1gfHl+/rKZaQ8W1hn6FiA5o4BB2RppfAWkw8cBl2kF/WRzUsamI0zSp
 kj1NvrB7xj2RC0B1LzRnxs/6jIe2vs2Eu6Q3IHTsZYwbbpjQYaBz/+Gh+/HMzvtw7oVtPHnbmll
 Ae90fYb2vPg8WenrvNsp+lm+C2FTow4BsEh4mkVs9AlRWI+uZzOnSsNP9EP7xHFuv5C8VqmakqF
 vN26BTzsiaf1cMvnqJwlE6iFtUxiMd/3eyPjlEaLbSYmXdlMkcKkOaPQr6HKXJdYA/Po/WrVIxp
 28NmX392bTjy43vHaWDhFuw5+/C/ck5PS74oVUrqlWGppRvOTwexzubR0bHh6e2CWyoYgt0Slju
 aO3dJRBiyOl0Ajnl5U+Agcf7TG20wtsbEtLFGcjCHLUAyizRQaXiMtU3QmFKBnBEoEisw0HXmVV
 QK5VWxEuU8oNjzZ0QGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220066

Hi Yury.

On 7/22/26 12:58 AM, Yury Norov wrote:
> On Mon, Jul 20, 2026 at 10:52:49PM +0530, Shrikanth Hegde wrote:

[...]
    
>> +/*
>> + * Returns steal time of the full system.
>> + * Compute collective steal time across all possible CPUs.
>> + */
>> +static u64 get_system_steal_time(void)
>> +{
>> +	int cpu;
>> +	u64 total_steal = 0;
>> +
>> +	for_each_possible_cpu(cpu)
>> +		total_steal += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
>> +
>> +	return total_steal;
>> +}
> 
> There's another implementation of the same logic in
> hd_calculate_steal_percentage())
> 
> It means it should live in include/linux/kernel_stat.h as:
>          
>          u64 kcpustat_steal_time(struct cpumask *cpus);
> 
> Or possibly even more generic:
> 
>          u64 kcpustat_field_total(enum cpu_usage_stat usage, struct cpumask *cpus);

That's good idea. Below are the callsites i think can be
refactored in addition to this patch.
  
arch/s390/kernel/hiperdispatch.c: hd_calculate_steal_percentage
fs/proc/uptime.c: uptime_proc_show

I can pick up this refactoring post the series. I think it is better
not to club them together. is that ok?

> 
> Similarly to the existing kcpustat_field().
> 
> The other possible candidates are: fs/proc/stat.c:: show_stat()
> arch_cpu_idle_time(), but I think it's out of the scope of your
> series.

Yes.

drivers/leds/trigger/ledtrig-activity.c: led_activity_function
fs/proc/stat.c: show_stat

These two sum up multiple CPUTIME_ fields. Doing them in one loop is
likely better than getting each of them in a separate loop. No?


> 
> What's the relation between the arch/s390/kernel/hiperdispatch.c and
> your steal governor? Is that a similar concept?
> 

It is similar but independent idea. Ilya explained it in brief below.
https://youtu.be/adxUKFPlOp0?t=1846

Tobais, Ilya, Correct me if i am wrong.

- It samples steal time and decides on CPU_CAPACITY of a
   CPU (between 1024 and 126) periodically.
- Triggers sched domain rebuild.


But Using CPU_CAPACITY to ensure no task running has drawbacks as we had
explored it very early.
- It fails under high concurrency. Typical real life workloads spawns
   threads/tasks based on online CPUs. Scheduler chooses low capacity
   CPUs instead of running them on busy CPUs. So under high concurrency or
   high utilization it simply doesn't work.
- It takes a long time to get the running task out of it.
- It needs a sched domain rebuild. That is costly
   (One can play tricks to avoid it)
- There are PR/SM overheads.


Since S390 has explicit knowledge of which CPUs to take out, it will likely
want a arch specific mechanism in steal_governor to take out Vertical Low CPUs
first. That is being deferred for now, once s390 has that, my take is
hiperdispatch can be removed altogether.

>> +/*
>> + * Returns number of CPUs to consider for steal ratio.
>> + * Return possible CPUs.
>> + */
> 
> Can you rephrase the comment? It has 2 'return' sections with
> different meaning. If the 2nd one is the implementation detail,
> I'd put it inside the function scope, or drop entirely.
> 

Ok. Let me drop second statement there.

>> +static unsigned int get_num_cpus_steal_ratio(void)
>> +{
>> +	return num_possible_cpus();
>> +}
>> +
>> +/*
>> + * Take action to decrease preferred CPUs.
>> + *
> 
> Drop this 'Take action' wording please.

Ok.

> 
>> + * Decrease the preferred CPUs by 1 core.
>> + * Take out the last core in the active & preferred.
>> + *
>> + * Must ensure
>> + * - least one housekeeping core is always kept as preferred
> 
> s/least/at least/ ?

Yep.

> 
>> + * - preferred is always subset of active.
>> + */
>> +static void decrease_preferred_cpus(void)
>> +{
>> +	int tmp_cpu, first_hk_cpu, last_cpu;
>> +	const struct cpumask *first_hk_core;
>> +	int target_cpu = nr_cpu_ids;
>> +
>> +	guard(cpus_read_lock)();
>> +	first_hk_cpu = cpumask_first_and(housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
>> +					 cpu_preferred_mask);
>> +	if (first_hk_cpu >= nr_cpu_ids)
>> +		return;
>> +
>> +	last_cpu = cpumask_last(cpu_preferred_mask);
>> +
>> +	if (last_cpu >= nr_cpu_ids)
>> +		return;
>> +
>> +	/* Always leave first housekeeping core as preferred. */
>> +	first_hk_core = topology_sibling_cpumask(first_hk_cpu);
>> +
>> +	/* Find the last CPU which doesn't belong to that first hk_core. */
>> +	if (!cpumask_test_cpu(last_cpu, first_hk_core)) {
>> +		target_cpu = last_cpu;
>> +	} else {
>> +		for_each_cpu_andnot(tmp_cpu, cpu_preferred_mask, first_hk_core)
>> +			target_cpu = tmp_cpu;
>> +	}
> 
> Too much local variables. You can drop those tmp_cpu, last_cpu and
> target_cpu, and just use a single variable 'cpu'. That would also
> simplify your logic:
> 
>          cpu = cpumask_last(cpu_preferred_mask);
>          core = topology_sibling_cpumask(first_hk_cpu);
> 
>          if (cpumask_test_cpu(cpu, core)) {
>                  for_each_cpu_andnot(cpu, cpu_preferred_mask, core)
>                          /* nop */ ;
>          }
> 
>          if (cpu >= nr_cpu_ids)
>                  return;
> 
> And so on.

Ok. Just two would suffice i think. cpu, and target_cpu.
With a bit shuffling first_hk_cpu can also go away.


I need at least two so that this loop works.

         for_each_cpu_and(tmp_cpu, topology_sibling_cpumask(target_cpu),
                          cpu_preferred_mask)
                 set_cpu_preferred(tmp_cpu, false);

> 
>> +
>> +	/* Only the first housekeeping core remains */
>> +	if (target_cpu >= nr_cpu_ids)
>> +		return;
>> +
>> +	for_each_cpu_and(tmp_cpu, topology_sibling_cpumask(target_cpu),
>> +			 cpu_preferred_mask)
>> +		set_cpu_preferred(tmp_cpu, false);
>> +}
>> +
>> +/*
>> + * Take action to increase preferred CPUs.
>> + *
> 
> Again, drop this 'take action' thing.

Sure.

> 
>> + * Increase the preferred CPUs by 1 core.
>> + * Add the first core in active & !preferred
>> + *
>> + * Must ensure preferred is subset of active.
>> + */
>> +static void increase_preferred_cpus(void)
>> +{
>> +	int first_cpu, tmp_cpu;
>> +
>> +	guard(cpus_read_lock)();
>> +	first_cpu = cpumask_first_andnot(cpu_active_mask, cpu_preferred_mask);
>> +
>> +	/* All CPUs are preferred. Nothing to increase further */
>> +	if (first_cpu >= nr_cpu_ids)
>> +		return;
>> +
>> +	for_each_cpu_and(tmp_cpu, topology_sibling_cpumask(first_cpu),
>> +			 cpu_active_mask)
>> +		set_cpu_preferred(tmp_cpu, true);
>> +}
>> +
>> +static void compute_preferred_cpus_work(struct work_struct *work)
>> +{
>> +	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
>> +	ktime_t now;
>> +
>> +	now = ktime_get();
>> +	delta_ns = ktime_to_ns(ktime_sub(now, sg_core_ctx.time));
>> +
>> +	if (unlikely(delta_ns < NSEC_PER_MSEC)) {
>> +		pr_err_ratelimited("steal_governor: work scheduled too soon delta_ns: %llu\n",
>> +				   delta_ns);
>> +		goto requeue_work;
>> +	}
>> +
>> +	curr_steal = get_system_steal_time();
>> +	delta_steal = curr_steal > sg_core_ctx.steal ?
>> +		      curr_steal - sg_core_ctx.steal : 0;
>> +
>> +	/* Update for next calculation */
>> +	sg_core_ctx.steal = curr_steal;
>> +	sg_core_ctx.time = now;
>> +
>> +	/*
>> +	 * steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())
>> +	 * To avoid possible overflow, divide the denominator early.
>> +	 * Note minimum interval is 100ms.
>> +	 */
>> +	delta_ns = max_t(u64, div_u64(delta_ns * get_num_cpus_steal_ratio(),
>> +				      100 * 100), 1);
>> +	steal_ratio = div64_u64(delta_steal, delta_ns);
>> +
>> +	if (steal_ratio > sg_core_ctx.high_threshold)
>> +		decrease_preferred_cpus();
>> +	if (steal_ratio <= sg_core_ctx.low_threshold)
>> +		increase_preferred_cpus();
> 
> If you neither increase, nor decrease, you don't need to check the mask
> because you know you don't modify it. Also, I'd wrap the below integrity
> checks into a helper function.
> 
> 	if (steal_ratio > sg_core_ctx.high_threshold)
> 		decrease_preferred_cpus();
> 	else if (steal_ratio <= sg_core_ctx.low_threshold)
> 		increase_preferred_cpus();
>          else
>                  goto requeue_work;
> 
>          if (check_integrity())
>                  return;
> 

Ack. Good catch. Will do.

>> +	/* maintain design constructs always */
>> +	if (cpumask_empty(cpu_preferred_mask)) {
>> +		pr_err("empty preferred mask. stop steal governor\n");
>> +		restore_preferred_to_active();
>> +		return;
>> +	}
>> +
>> +	if (!cpumask_subset(cpu_preferred_mask, cpu_active_mask)) {
>> +		pr_err("preferred: %*pbl is not subset of active: %*pbl, stop steal governor\n",
>> +		       cpumask_pr_args(cpu_preferred_mask),
>> +		       cpumask_pr_args(cpu_active_mask));
>> +		restore_preferred_to_active();
>> +		return;
>> +	}
>> +
>> +requeue_work:
>> +	/* Trigger for next sampling */
> 
> The lablel above is pretty explaining to me. The comment just
> duplicates it. Maybe drop the comment?

Ok.

> 
>> +	schedule_delayed_work(&sg_core_ctx.work,
>> +			      msecs_to_jiffies(sg_core_ctx.interval_ms));
> 
> If you need jiffies, why don't you have them in the structure, instead of
> milliseconds?
> 
> 	schedule_delayed_work(&sg_core_ctx.work, sg_core_ctx.delay);
> 

I would prefer milliseconds as jiffies is very difficult for users to understand.
It depends on HZ value and one has to query from configs.

HZ can very from 100 to 1000 today. Again I will have to play tricks to schedule
the governor at fixed intervals.

So i think it is better to use milliseconds here.
Correct me if i am not making sense.

>> +}
>> +
>>   static int __init steal_governor_init(void)
>>   {
>>   	if (sg_core_ctx.low_threshold >= sg_core_ctx.high_threshold) {
>> @@ -100,11 +252,19 @@ static int __init steal_governor_init(void)
>>   	pr_info("steal_governor is enabled. interval: %ums, high_threshold: %u, low_threshold: %u\n",
>>   		sg_core_ctx.interval_ms, sg_core_ctx.high_threshold, sg_core_ctx.low_threshold);
>>   
>> +	INIT_DELAYED_WORK(&sg_core_ctx.work, compute_preferred_cpus_work);
>> +	sg_core_ctx.steal = get_system_steal_time();
>> +	sg_core_ctx.time = ktime_get();
>> +
>> +	schedule_delayed_work(&sg_core_ctx.work,
>> +			      msecs_to_jiffies(sg_core_ctx.interval_ms));
>> +
>>   	return 0;
>>   }
>>   
>>   static void __exit steal_governor_exit(void)
>>   {
>> +	disable_delayed_work_sync(&sg_core_ctx.work);
>>   	restore_preferred_to_active();
>>   	pr_info("steal_governor is disabled\n");
>>   }
>> diff --git a/drivers/virt/steal_governor/core.h b/drivers/virt/steal_governor/core.h
>> index e27305284ac0..59329c1d7109 100644
>> --- a/drivers/virt/steal_governor/core.h
>> +++ b/drivers/virt/steal_governor/core.h
>> @@ -12,6 +12,11 @@
>>   #include <linux/workqueue.h>
>>   #include <linux/ktime.h>
>>   #include <linux/kconfig.h>
>> +#include <linux/kernel_stat.h>
>> +#include <linux/topology.h>
>> +#include <linux/sched/isolation.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/math64.h>
>>   
>>   struct steal_governor {
>>   	struct delayed_work	work;
>> -- 
>> 2.47.3

