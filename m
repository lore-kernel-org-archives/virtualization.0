Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92AB334C3C
	for <virtualization@lists.linux.dev>; Sat, 25 Jul 2026 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784951724; cv=none; b=NH8PfrmN4yhR3aetFBeHXwqQlFGCcuZf9GdR86ARsriD7Fpb1Riuiqg7RMtDmil9VbmFF2kNSBwkWdyQmvWASI7sXRulmfqG+fMAdJaNoxSqc6hsbmTWQw3+tQL+hA5mBJ2cMWEA/wmvbGAEnIPKdL1rpKPHmrqGg+fyWM1jCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784951724; c=relaxed/simple;
	bh=SNpP04hn5F5cn9vruBKqaEAbN6vd9hOpwz4CDhHGE/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mms6siNtfBqyAg/sp2Eu05I7AmUONqUgih1eXumx0sFfKLw10PKzD6/XEsB/xiPbQD5wtd7K58DwFc5MOXEMsf6PldY6MlIYbxarZkikIZUBQPDEXRXYZV7oaXttKVfPpJtYHDeGGf0+UmDp+E1MZO8I90pIKmB36J2vKpfRkt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DMUKTTgC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DMUKTTgC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P320JF3686846;
	Sat, 25 Jul 2026 03:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jLM1wO
	wIjsTL795061WExYD6CA77xP4pQFpIl9LnsnY=; b=DMUKTTgCzJA+fVp9Z+syOO
	K5dyQ2hLN4YWbLsfAm26FrQZWsA5LiTYOSn1UwcrB/9MQOSltlUskBqB/onyGOM+
	VXvlxgE2bsPPKv9YZpcs9gB3+QGzo9R0s1sL6MMUqeD28dx4UNxaMFxJ6YfTIbgc
	OGXK7oSmbSZKHU11i+UKgYu4CeHLtTdYjurZBeNdSIVcbcPOWrjO/2+LWY8YAKdt
	NSTjsiFEf+UydB0bBl4IMCmGb3aJADJ5dHIYpjkPlw7QD7OOzLte+CYC3+HecpAu
	Onyd6gZJGJugNn+tlRlPLHOeDFNpnfD2OEuocGleUg7uJEqr5hzRZcRc3WLds3GA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmmv504bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 03:55:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66P3fL0T029219;
	Sat, 25 Jul 2026 03:55:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn12g3fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 03:55:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66P3t0QK8257974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 03:55:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB0E520043;
	Sat, 25 Jul 2026 03:55:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E20320040;
	Sat, 25 Jul 2026 03:54:52 +0000 (GMT)
Received: from [9.124.223.44] (unknown [9.124.223.44])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 03:54:51 +0000 (GMT)
Message-ID: <493495db-01a4-43bc-9261-0456436be933@linux.ibm.com>
Date: Sat, 25 Jul 2026 09:24:51 +0530
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ybt45pc9wcTBCbbfcFkaIZXIQSlrScDZ
X-Authority-Analysis: v=2.4 cv=E679Y6dl c=1 sm=1 tr=0 ts=6a64339a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=C920T_kPIOPA6LgbBOQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDAzMSBTYWx0ZWRfX5eZRu4vsO4DE
 zg/YmrXiiTSvfKUufNZYyHrBl3bzioAT+HVuBp22DZox6ULB/LFLS2V9alFQqc1Z+O6JgcZRQ/U
 sqSLI5ecKNvnWJyM43u9dhZi8VBgZmI=
X-Proofpoint-GUID: mRtOHzg_o1XdWCUJxDXyqoKVdWGlFWj8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDAzMSBTYWx0ZWRfX15gC+qVIQvsu
 G38MA3F2+gLEewGthal3gOS/diEDg9s+WfpcnhwZpAKyeyhaeL3CLEkGKUc/Ps+sPxUrw6ZuBI+
 IpYFcw+crpwCRYK1zwB9UYbe8y0qbxm5lNVb8bEIDLAfDbMJldAc+uU968eADhPBXApfrmyla3c
 ecEa71ZpP4IZROpekhTQ9xZ7oreG2bpPsewZlwb6IKaG51lZ0buxjkD74KaE5TaRZ0Xa+f1l2Mc
 RlBZybxcQjusau4DLlGV29378gg0bHZDaZDDQCre+Kxor+9bXfCw95O+76JBd2ZzRvCNLOihi+W
 1FL6iMGKPm7wtmcdQ5JRsmpVqVlprtqfaZdUjaN/c9C8ogB5fz+jUtyJxIqFdT09KJkgF9oRZM/
 +h/neMiZIh+JOkXETRHXfjgUKyKR5RtmK65fRjqeLNIaoEMYa9ZmgF5qEtZmV0ADbmNcB70n+Jj
 zGcbxhMSxPb9n5JuaQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250031

Hi Yury,

On 7/25/26 2:35 AM, Yury Norov wrote:
> On Fri, Jul 24, 2026 at 07:37:31PM +0530, Shrikanth Hegde wrote:

[...]
    
>> +/* Return collective steal time across system. */
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
> In v8 I pointed to the identical function in s390 code, and you agreed
> to unify them, but that didn't happen. Please do that in the next
> version.

I thought I will do this refactoring after the series gets merged upstream.
If you insist, I will do this in next version.

> 
>> +/* Return number of CPUs to consider steal ratio. */
>> +static unsigned int get_system_cpus(void)
>> +{
>> +	return num_possible_cpus();
>> +}
>> +
>> +/*
>> + *
> 
> Useless line

My bad. Will remove.

> 
>> + * Called when the steal governor detects high physical CPU contention.
>> + * It finds the last active core in the preferred mask and mark those
>> + * CPUs as non-preferred.
>> + *
>> + * Must ensure:
>> + * - at least one core is always kept as preferred
>> + * - preferred is always subset of active.
>> + */
>> +static void decrease_preferred_cpus(void)
>> +{
>> +	const struct cpumask *first_hk_core;
>> +	int target_cpu = nr_cpu_ids;
>> +	int cpu;
>> +
>> +	guard(cpus_read_lock)();
>> +	cpu = cpumask_first_and(housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
>> +				cpu_preferred_mask);
>> +	if (cpu >= nr_cpu_ids)
>> +		return;
>> +
>> +	/* Always leave first housekeeping core as preferred. */
>> +	first_hk_core = topology_sibling_cpumask(cpu);
>> +	cpu = cpumask_last(cpu_preferred_mask);
>> +	if (cpu >= nr_cpu_ids)
>> +		return;
>> +
>> +	/* Find the last CPU which doesn't belong to that first hk_core. */
>> +	if (!cpumask_test_cpu(cpu, first_hk_core)) {
>> +		target_cpu = cpu;
>> +	} else {
>> +		for_each_cpu_andnot(cpu, cpu_preferred_mask, first_hk_core)
>> +			target_cpu = cpu;
>> +	}
>> +
>> +	/* Only the first housekeeping core remains */
>> +	if (target_cpu >= nr_cpu_ids)
>> +		return;
>> +
>> +	for_each_cpu_and(cpu, topology_sibling_cpumask(target_cpu),
>> +			 cpu_preferred_mask)
>> +		set_cpu_preferred(cpu, false);
>> +}
>> +
>> +/*
>> + * Called when the steal governor detects no/low physical CPU contention.
>> + * It finds the first active core outside of preferred mask and mark
>> + * those CPUs as preferred.
>> + *
>> + * Must ensure preferred is subset of active.
>> + */
>> +static void increase_preferred_cpus(void)
>> +{
>> +	int first_cpu, cpu;
>> +
>> +	guard(cpus_read_lock)();
>> +	first_cpu = cpumask_first_andnot(cpu_active_mask, cpu_preferred_mask);
>> +
>> +	/* All CPUs are preferred. Nothing to increase further */
>> +	if (first_cpu >= nr_cpu_ids)
>> +		return;
>> +
>> +	for_each_cpu_and(cpu, topology_sibling_cpumask(first_cpu),
>> +			 cpu_active_mask)
>> +		set_cpu_preferred(cpu, true);
>> +}
>> +
>> +static bool preferred_cpus_valid(void)
>> +{
>> +	if (cpumask_empty(cpu_preferred_mask)) {
>> +		pr_err("empty preferred mask. stopping\n");
>> +		return false;
>> +	}
>> +
>> +	if (!cpumask_subset(cpu_preferred_mask, cpu_active_mask)) {
>> +		pr_err("preferred: %*pbl is not subset of active: %*pbl, stopping\n",
>> +		       cpumask_pr_args(cpu_preferred_mask),
>> +		       cpumask_pr_args(cpu_active_mask));
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static void compute_preferred_cpus_work(struct work_struct *work)
> 
> Bad name. You're not only computing here, but actually adjusting the
> preferred CPUs mask.
> 

adjust_preferred_cpus_work or steal_governor_loop ?

>> +{
>> +	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
>> +	ktime_t now;
>> +
>> +	now = ktime_get();
>> +	delta_ns = ktime_to_ns(ktime_sub(now, sg_ctx.time));
>> +
>> +	if (unlikely(delta_ns < NSEC_PER_MSEC)) {
>> +		pr_err_ratelimited("work scheduled too soon delta_ns: %llu\n", delta_ns);
>> +		goto requeue_work;
>> +	}
>> +
>> +	curr_steal = get_system_steal_time();
>> +	delta_steal = curr_steal > sg_ctx.steal ? curr_steal - sg_ctx.steal : 0;
>> +	sg_ctx.steal = curr_steal;
>> +	sg_ctx.time = now;
>> +
>> +	/*
>> +	 * steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())
>> +	 * To avoid possible overflow, divide the denominator early.
>> +	 * Note minimum interval is 100ms.
>> +	 */
>> +	delta_ns = max_t(u64, div_u64(delta_ns * get_system_cpus(), 10000), 1);
>> +	steal_ratio = div64_u64(delta_steal, delta_ns);
> 
> So if:
> 
> Possible CPUs = 128
> Active CPUs = 8
> Steal on online CPUs = 50%
> Steal on offline CPUS = 0%
> 
> Then calculated ratio would be:
> 
>          (50% × 8 + 0% * 120) / 128 = 3.125%
> 
> Instead of decreasing the number of preferred CPUs, you'll do nothing
> under default thresholds, or even increase.
> 
> Have you tested your driver against such a configuration?

I thought about it, but given range of systems linux supports today, there
will always be configurations where defaults are not good enough.

That is why it is recommended to build it as module. load the driver
will custom high and low threshold.


I had it as active CPUs only earlier. but the concern is, what happens at hotplug.
Since online a new CPUs steal time can add big value, it can trigger high threshold
check, similarly for offline. Plus raciness w.r.t to active CPUs.
(same issue for online CPUs)

Hence I chose it as possible CPUs.

> 
> Also, I'm not quite sure how you'd handle a case when you have half
> of CPUS in your core offlined, but you manage preferred mask per-core,
> so you offline or online less CPUs than expected. Can you mention that
> scenario in the documentation?
> 

If it is with thresholds, it is same case as above. Other than that, i have
tested it doesn;t set for offline CPUs etc.

I am not sure if scaling the thresholds with active CPUs is a good idea or not.
It can easily cause more math headache for users.

>> +
>> +	if (steal_ratio > sg_ctx.high_threshold)
>> +		decrease_preferred_cpus();
>> +	else if (steal_ratio <= sg_ctx.low_threshold)
>> +		increase_preferred_cpus();
>> +	else
>> +		goto requeue_work;
>> +
>> +	if (!preferred_cpus_valid()) {
>> +		restore_preferred_to_active();
>> +		return;
>> +	}
>> +
>> +requeue_work:
>> +	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
>> +}
>> +
>>   static int __init steal_governor_init(void)
>>   {
>>   	if (sg_ctx.low_threshold >= sg_ctx.high_threshold) {
>> @@ -117,6 +267,10 @@ static int __init steal_governor_init(void)
>>   	}
>>   
>>   	sg_ctx.delay = msecs_to_jiffies(sg_ctx.interval_ms);
>> +	INIT_DELAYED_WORK(&sg_ctx.work, compute_preferred_cpus_work);
>> +	sg_ctx.steal = get_system_steal_time();
>> +	sg_ctx.time = ktime_get();
>> +	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
>>   	pr_info("enabled. interval: %ums, high_threshold: %u, low_threshold: %u\n",
>>   		sg_ctx.interval_ms, sg_ctx.high_threshold, sg_ctx.low_threshold);
>>   
>> @@ -125,6 +279,7 @@ static int __init steal_governor_init(void)
>>   
>>   static void __exit steal_governor_exit(void)
>>   {
>> +	disable_delayed_work_sync(&sg_ctx.work);
>>   	restore_preferred_to_active();
>>   	pr_info("disabled\n");
>>   }
>> -- 
>> 2.47.3

