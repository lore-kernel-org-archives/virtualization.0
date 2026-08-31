Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310535AC07
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 02:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788142789; cv=none; b=U+y/56TFOeX6t2v9+M+mE4y0HHsXdfuAj988UHR2kpMzanXgsb5umJDjU0zDet/Ihl301PBaAST1hRp2WgUMtIHVRO0SoiQFiotgIXqeKCpu//BzHOhYeLFQcVyGf+Vd3gwn5CkOZ2HGmg9pLp4taeC5mDye9UUsmwEdZBdJ2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788142789; c=relaxed/simple;
	bh=8wyENaWSpYI08S5MtR3aCZVTtD+p1XXQWJAWLX2kr6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEygX8OeQn5j2ZeVYbH4nRsFZhEIsBi+Jomp8ElAcAklkSNqCkKOJkOSZCO9iiI6BMFW3x28l9kCW8/Oi2Zy84056xVrukKbbeEwfvVoBRL7gmWajIdnqBoBS8BcxRTbzVADfd8MS/wIQpr6X74CokMf2GS1MmbZ3gx1EakhyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E++q3NTl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E++q3NTl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V21qR13969966;
	Mon, 31 Aug 2026 02:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KUiHKf
	FocjBPvbaOP8gXPdYyNHezfeowG5V5JhmB4Y4=; b=E++q3NTlY4nGs+EQ9Ikiq/
	k0gCkkCfQtLlGJHmjf9QqxZdFjuyTqo54iG8dmKwxmke7TlEmB0A0AQ4tU/c3N4M
	pb3DEEpET6qTOIuLmmIcDGN9NZeuo7ffME/XaWmKU5OG7BxuLthAnL4wL6oDAVTS
	lo5vWkFZbAPZVPvMzpvUqW9XpIYMEhhXzAtBXfX2prtKUZMP+36JuLqK41YkjMTe
	+kosSbQjP/BIPHA42Gc1QXnjSlfDfg2CDuuNzfh2zlTix79Aq3mmBx0LhL+D7/jk
	qFU8gQxqNTFfXuKNXGfX5T984p73Hx52L9yykJKefCsg+d+UH7C64c3RaIyz9Ktw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudem85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 02:18:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V1uOQM028550;
	Mon, 31 Aug 2026 02:18:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h3bwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 02:18:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V2Is8M42074408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 02:18:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CBE82004E;
	Mon, 31 Aug 2026 02:18:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 830BD20040;
	Mon, 31 Aug 2026 02:18:46 +0000 (GMT)
Received: from [9.124.216.182] (unknown [9.124.216.182])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 02:18:46 +0000 (GMT)
Message-ID: <53035ba4-53ec-4907-93b8-c8b957d1fa61@linux.ibm.com>
Date: Mon, 31 Aug 2026 07:48:45 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/12] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
To: Yury Norov <ynorov@nvidia.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, yury.norov@gmail.com, kprateek.nayak@amd.com,
        iii@linux.ibm.com, corbet@lwn.net, meted@linux.ibm.com,
        tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
        seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, maddy@linux.ibm.com, srikar@linux.ibm.com,
        hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
        frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
        christian.loehle@arm.com, tj@kernel.org, tommaso.cucinotta@gmail.com,
        maz@kernel.org, rafael@kernel.org, rdunlap@infradead.org,
        kernellwp@gmail.com, linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev, sunlightlinux@gmail.com
References: <20260825103855.721013-1-sshegde@linux.ibm.com>
 <20260825103855.721013-6-sshegde@linux.ibm.com>
 <8262d2f9-9f2f-4821-8497-991d7c8448a3@arm.com> <apMziCV_8y0xeIBT@yury>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <apMziCV_8y0xeIBT@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: nxi8kzaB1HTzC9ejFsocYVYtN5rg9wla
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDAxNSBTYWx0ZWRfX4cHK2z+Jk4Bv
 2Axf1Gqw/u458y5vtwqq8chOIuojhvNx/qnTnSp58BSpQK0WTbtB2B4D+QGtZWWTD2fwS+jJ3XI
 DShMMqAmmedN/4HxAXfxE+1sK/yX9YUffCujtS7WbTE9PHY1+NHZLgWkGZOuyvI9xvQJp2xwNTt
 ScG5WnLWVcm/GdO1BZeI/NpjqvEE5RErbK21bK0GEAF5MXahMYS/2IbekjHkQMb3ZYVI1n5V9mN
 KLQCuAPUhk9ojKz8FsufAAGbJipkT670SHBbl79XAztoYchbZolrpTLCawXfsOkIPXdytJ7Kfp4
 UWZbbtn956fT8qkndn9USJEKNjy+VpL5zuIiRUHj9+0D06JIcSU1Eu95HxN7QhpCR8fYw26Dc95
 +/AJxhJuLRY7zcO7Ldy5rhlb4gn9acDk9ZHG53a8+tUJPNO50ShavRZxnGBDMi9MsZI0op4r+5g
 dXXTjM2AQku9Ecs+1Vw==
X-Proofpoint-ORIG-GUID: HOh8yDAZBSpciK9eL02HwO_3DCeMbxqY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDAxNSBTYWx0ZWRfX6gXvH3ofdf6q
 0/MJyK2ToqAbjxkLJs6BrR0t6pk77sh8CENv8GiwzmMs7Vid9SxGM32N/UacoIoCKrOUBJo5EKi
 O2S9624PD3nl21Hfj9dWCkI8RVnQKhY=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a94e493 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=e7p6DMnVRXWE9DMeyOcA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310015

Hi Yury,
Thanks for going through and your suggestions!.

On 8/30/26 1:01 AM, Yury Norov wrote:
> On Fri, Aug 28, 2026 at 09:51:47AM +0200, Dietmar Eggemann wrote:
>> On 25.08.26 12:38, Shrikanth Hegde wrote:
>>> When possible, try to choose a preferred CPU.
>>>
>>> This is essential to maintain user affinities when preferred
>>> CPUs change. A task pinned on a non-preferred CPU should continue
>>> to run there, since this is a non-user triggered event.
>>>
>>> If a CPU is non-preferred and the task can run on other CPUs which are
>>> currently preferred, then choose a preferred CPU instead.
>>> This is decided by checking if cpus_ptr and cpu_preferred_mask
>>> intersect or not. If yes, then the task has other preferred CPUs.
>>>
>>> The push task mechanism uses a stopper thread which calls
>>> select_fallback_rq() and uses this mechanism to pick a preferred CPU.
>>>
>>> This takes care of the wakeup path for FAIR tasks too.
>>> is_cpu_allowed() is called to ensure wakeups happen on preferred CPUs.
>>> With that, additional checks in available_idle_cpu() are not necessary.
>>>
>>> Ignore the preferred CPU state if a task's affinity is changing and
>>> its new mask no longer includes the CPU it is currently running on.
>>> This ensures migration_cpu_stop() does not abort, preventing the task
>>> from being stranded outside its allowed affinity.
>>>
>>> Account for tasks with architecture-specific CPU masks
>>> (e.g., 32-bit tasks on arm64). For such tasks, explicitly check against
>>> the arch-allowed CPUs to determine if any of the preferred CPUs are
>>> actually valid.
>>>
>>> For the majority of cases, this would still keep select_fallback_rq()
>>> as O(N). cpumask_intersects(), which is O(N), is called only if
>>> !cpu_preferred. The task running there is expected to move out.
>>> Subsequently, it should run on a preferred CPU. This becomes O(N**2)
>>> only for tasks pinned solely to non-preferred CPUs. That is a rare case.
>>>
>>> Overhead is minimal when the CPU is preferred.
>>>
>>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>> ---
>>>   kernel/sched/core.c | 41 +++++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 39 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index a45f7c308329..f71317fe281d 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -2494,6 +2494,35 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
>>>   	return rq->nr_pinned;
>>>   }
>>>   
>>> +static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
>>> +{
>>> +	const struct cpumask *valid_mask;
>>> +	int i;
>>> +
>>> +	if (cpu_preferred(cpu))
>>> +		return false;
>>> +
>>> +	/* Only FAIR tasks honor preferred CPU state */
>>> +	if (unlikely(p->sched_class != &fair_sched_class))
>>> +		return false;
>>> +
>>> +	/* Ignore preferred state if task affinity is changing */
>>> +	if (unlikely(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr)))
>>> +		return false;
>>> +
>>> +	valid_mask = task_cpu_possible_mask(p);
>>> +	if (likely(valid_mask == cpu_possible_mask))
>>> +		return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
>>> +
>>> +	/* Tasks with arch-specific CPU masks. e.g. 32-bit tasks on arm64. */
>>> +	for_each_cpu_and(i, p->cpus_ptr, cpu_preferred_mask) {
>>> +		if (cpumask_test_cpu(i, valid_mask))
>>> +			return true;
>>> +	}
>>
>> Looking more into this, there might be a window in 64-32-bit execve()
>> for 32bit EL0 tasks on Arm64 (w/ allow_mismatched_32bit_el0 command line
>> option).
>>
>> The time before arch_setup_new_exec() calls
>> force_compatible_cpus_allowed_ptr() to restrict CPU affinity for those
>> tasks.
>>
>> Let me run more test on this ...
>>
>> Why not simply:
>>
>> - return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
>> + return cpumask_first_and_and(p->cpus_ptr, cpu_preferred_mask,
>> +                              task_cpu_possible_mask(p)) < nr_cpu_ids;
>>
>> IMHO, you want to know whether there is at least one CPU that belongs to
>> all three CPU masks?
>   
> Yeah, the cpumask_first_and_and() would replace the for-loop more
> effectively, but I'd suggest introducing the new helper:
> 
> 
>          return cpumask_intersects_and(p->cpus_ptr, cpu_preferred_mask,
>                                        task_cpu_possible_mask(p));
> 


Ack. However, we will only need this change if ARM64 wants to enable
this driver right now. If not, we can go back to the earlier
cpumask_intersects(), and the 3-way intersection can be added
later when the ARM ecosystem enables the feature.


Dietmar/Vincent,
Do you think it makes sense to enable the driver on ARM64 now?
Or you think it is better to delay it and once the feature is stable
ARM ecosystem can enable it?

> This would also highlight the intention better - we're looking for
> intersection, and call the 'intersects' function.
> 
> I don't like how this patch plays with likely() macro.
> Possible == task_possible condition is surely likely for x86, but is
> always unlikely for aarch64/el0-32 tasks. This would lead to suboptimal
> code generation on aarch64.
> 
> The approach I've suggested also worsen performance because of a
> possibly unnecessary traversing of the cpu_possible_mask.
> 
> If task_can_sched_on_preferred() is really a performance critical piece
> of code, we can invent arch_task_can_sched_on_preferred() to avoid it.
> 

It is called only on non-preferred CPU and unless pinned, tasks would have moved
out of it. So we are okay here I guess. If it really pops up, then we can do the
above idea.

> --
> 
> On general side, the governor is really tested in 2 configurations:
> PPC+powervm and x86+kvm; and there's clearly an interest from XEN and
> ARM engineers.
> 
> Maybe, to stay on safe side, we'd enable the feature where it's actually
> tested? I suggested it when DOM0 case was revealed, and now we've got
> the 2nd corner case from arm64 compat tasks.

Indeed. It would safer and that way it would get more testing before arch/hypervisor
enables it.

The design is intended to work on architectures that provide steal-time
accounting, but each architecture and hypervisor combination should be validated
before enabling it.

> 
> The advantages of this approach are:
> 
>   - faster adoption of the existing code for the tested architectures;
>   - delegate arch/vm support to the domain professionals;
>   - delay arch/vm support decisions to the later phase of adoption, when
>     the API is better stabilized.
> 
> Thanks,
> Yury

So far, I have PPC_SPLPAR, S390, X86_64 in the Kconfig list.
I will wait to hear from Dietmar/Vincent about ARM.
