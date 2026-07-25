Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB853319601
	for <virtualization@lists.linux.dev>; Sat, 25 Jul 2026 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784949422; cv=none; b=DxJKqTY2Om7c22PEOWaumQ49Femq3gG8kQLsFx+OdPQhJpWPEIR9kGx7dK4BghcRQC+Mf2qQrDz/ZgRpwcTA1PAYOZsxg5FaC7VbMb5kE9fnIZvfgW5QaLlkIxb7JWq0NrTexMB2/oTujgqZwbLeScL2I/f6RgBpE+G1LS4jRdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784949422; c=relaxed/simple;
	bh=PYKt96wKvPs/WG3SMp72KCkRAFJZ4Ul5Xztr7ak2rZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mU3Hxz2OL8/elAaIwVPJBhTXUkybp/PhLcBh7QDnH5S09TkEslhWYEIu1U2Gz/W8xjYM3BTCE4Y+NDc7tt9/un+V4wLWbfIbK0VAKVl3A1Db0QGIZ2j76JIwyEdZkiAyjlgYl1EZos46It56R5mUCpmC2SLYVxbqzIU3HGP3cho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ihZzrH8r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ihZzrH8r"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P30mfw3683207;
	Sat, 25 Jul 2026 03:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a3Wq8E
	I6XRyGBx1V85oNfdDH0tv3gLD51ND8C2HekYs=; b=ihZzrH8rK/y1JvYt4ad0Dv
	KEmEGfufOkNo5G5NscOkcuo1fdMXqF4GTM6HRYumq/nS0+H7K+iLNRED5mo4o2v0
	FFtG0sy5E9H3lYOb3zr0saBKyguh46uC2PduMNVtii5aNmgM9BsMnlB8PItK1+I9
	MNml0Y//kZ6zd7eg+JARclIVRuM4yAPfH/AmI8MvoevfHdt4ciQ4er5antVqNtJU
	GGSUbTBkVuFOMHnTqU4p6JxxYaWV+HljGA6UgDQM2FVxx1W0TEJl7LLKlW9WAtG9
	Z1cBAJ6OP3E97qDu22OxXhBL/kAmN6UAsTiczI/iC4tgb9SC4dMZjiE2ORE1IQNQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmmv5018c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 03:16:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66P3Dx7h031543;
	Sat, 25 Jul 2026 03:16:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn2c005g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 03:16:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66P3GXZJ49807720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 03:16:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D7B520131;
	Sat, 25 Jul 2026 03:16:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4199B2012E;
	Sat, 25 Jul 2026 03:16:24 +0000 (GMT)
Received: from [9.124.223.44] (unknown [9.124.223.44])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 03:16:24 +0000 (GMT)
Message-ID: <f17d6966-12db-4020-b3d0-96f90a076193@linux.ibm.com>
Date: Sat, 25 Jul 2026 08:46:23 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/11] cpumask: Introduce cpu_preferred_mask
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
 <20260724140732.2683314-3-sshegde@linux.ibm.com> <amPES7GsB5sVCDjY@yury>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <amPES7GsB5sVCDjY@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: s5YivEFloasgkstqz8sxLtrknBJm59ji
X-Authority-Analysis: v=2.4 cv=E679Y6dl c=1 sm=1 tr=0 ts=6a642a97 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=U85ZJy5GhSDcuXyXOKoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDAyOCBTYWx0ZWRfXx04rZsbnC4lw
 Wc/36VZSQfpKHNj4LJRqisXesT2Pw8EN+jK5kfzZ0BgRaboOk5XkNNlEwMcQoSlu9U9jKYB/9nV
 Dj458PqkPUFjthGRDUzg07khx/hStZ8=
X-Proofpoint-GUID: 3Zb5CgGehcwnNpckexR_KkVBdJ-Vbr2_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDAyOCBTYWx0ZWRfXyc+Q7TBIMThw
 4HYatf3umZcBEBhg0dwwHMes7GNorU/2TpjyYR9bj+avOwQBw6MOsOn5SQYgXy/EKUvZo9k1Jnz
 asr7zD81BGSm2k+dfLwpIiMZu7GExRSh7A7/mcyI932uBJmYCIiC44eiLClNdPhsnhHoskT/UjF
 m8cbZ47tl6fBuA8tZmKO7L0PqPf70VS3Quc/2JF6ULhWKxlbZRftwogI2oNi0l/38vqnQf/BxXq
 LrxjBIOzRi2M4Pc+XgzeM9K+zn2jCFOuuB2EbFQjo8qsoGEG9UsBr0dWXOlW285ANpe2ursEeAf
 iG76Vf9TPI/P6L4lnf/XineAOWXfIdQj7SYU5TLLT8mSrbDXpua/fmiGiVIWS2ZjrolehZkpD+N
 5zNw2wQkDKawDRdqT90+QHS5WYS3V2b7xCnO4qYUKiS8j5Uy9pbyulcYs+S0i5bnQtmYEqBegpO
 EaNA7q+tvfcBUxJWEOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250028



On 7/25/26 1:30 AM, Yury Norov wrote:
> On Fri, Jul 24, 2026 at 07:37:23PM +0530, Shrikanth Hegde wrote:
>> Provide cpu_preferred_mask infrastructure. Define get/set macros
>> which could be used to get/set CPU state as preferred.
>>
>> PREFERRED_CPU config will be selected by the driver which handles
>> steal time values. It is going to set/clear preferred CPU state.
>> This driver will be called steal_governor and it is introduced in
>> subsequent patches. It periodically samples the steal time and
>> decides on preferred CPU state.
>>
>> A CPU is set to preferred when it becomes active. Later it may be
>> marked as non-preferred depending on steal time values with
>> steal_governor being enabled.
>>
>> Always maintain design construct of preferred is subset of active.
>> i.e. preferred ⊆ active ⊆ online ⊆ present ⊆ possible
>>
>> With PREFERRED_CPU=n, ensure set_cpu_preferred is a nop and get
>> method returns the active state in that case.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   include/linux/cpumask.h | 24 ++++++++++++++++++++++++
>>   kernel/Kconfig.preempt  |  4 ++++
>>   kernel/cpu.c            |  6 ++++++
>>   kernel/sched/core.c     |  5 +++++
>>   4 files changed, 39 insertions(+)
>>
>> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
>> index d3cda0544954..34d08a3d80e1 100644
>> --- a/include/linux/cpumask.h
>> +++ b/include/linux/cpumask.h
>> @@ -122,12 +122,20 @@ extern struct cpumask __cpu_enabled_mask;
>>   extern struct cpumask __cpu_present_mask;
>>   extern struct cpumask __cpu_active_mask;
>>   extern struct cpumask __cpu_dying_mask;
>> +
>> +#ifdef CONFIG_PREFERRED_CPU
>> +extern struct cpumask __cpu_preferred_mask;
>> +#else
>> +#define __cpu_preferred_mask __cpu_active_mask
>> +#endif
>> +
>>   #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
>>   #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
>>   #define cpu_enabled_mask   ((const struct cpumask *)&__cpu_enabled_mask)
>>   #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
>>   #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
>>   #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
>> +#define cpu_preferred_mask ((const struct cpumask *)&__cpu_preferred_mask)
>>   
>>   extern atomic_t __num_online_cpus;
>>   extern unsigned int __num_possible_cpus;
>> @@ -1164,6 +1172,12 @@ void init_cpu_possible(const struct cpumask *src);
>>   #define set_cpu_active(cpu, active)	assign_cpu((cpu), &__cpu_active_mask, (active))
>>   #define set_cpu_dying(cpu, dying)	assign_cpu((cpu), &__cpu_dying_mask, (dying))
>>   
>> +#ifdef CONFIG_PREFERRED_CPU
>> +#define set_cpu_preferred(cpu, preferred) assign_cpu((cpu), &__cpu_preferred_mask, (preferred))
>> +#else
>> +#define set_cpu_preferred(cpu, preferred) do { } while (0)
>> +#endif
>> +
>>   void set_cpu_online(unsigned int cpu, bool online);
>>   void set_cpu_possible(unsigned int cpu, bool possible);
>>   
>> @@ -1258,6 +1272,11 @@ static __always_inline bool cpu_dying(unsigned int cpu)
>>   	return cpumask_test_cpu(cpu, cpu_dying_mask);
>>   }
>>   
>> +static __always_inline bool cpu_preferred(unsigned int cpu)
>> +{
>> +	return cpumask_test_cpu(cpu, cpu_preferred_mask);
>> +}
>> +
>>   #else
>>   
>>   #define num_online_cpus()	1U
>> @@ -1296,6 +1315,11 @@ static __always_inline bool cpu_dying(unsigned int cpu)
>>   	return false;
>>   }
>>   
>> +static __always_inline bool cpu_preferred(unsigned int cpu)
>> +{
>> +	return cpu == 0;
>> +}
>> +
>>   #endif /* NR_CPUS > 1 */
>>   
>>   #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
>> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
>> index 88c594c6d7fc..de789b274ba3 100644
>> --- a/kernel/Kconfig.preempt
>> +++ b/kernel/Kconfig.preempt
>> @@ -192,3 +192,7 @@ config SCHED_CLASS_EXT
>>   	  For more information:
>>   	    Documentation/scheduler/sched-ext.rst
>>   	    https://github.com/sched-ext/scx
>> +
>> +config PREFERRED_CPU
>> +	bool
>> +	depends on SMP && PARAVIRT
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index b3c8553d7bd6..376d297a6292 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -3103,6 +3103,11 @@ EXPORT_SYMBOL(__cpu_dying_mask);
>>   atomic_t __num_online_cpus __read_mostly;
>>   EXPORT_SYMBOL(__num_online_cpus);
>>   
>> +#ifdef CONFIG_PREFERRED_CPU
>> +struct cpumask __cpu_preferred_mask __read_mostly;
>> +EXPORT_SYMBOL_GPL(__cpu_preferred_mask);
>> +#endif
>> +
>>   void init_cpu_present(const struct cpumask *src)
>>   {
>>   	cpumask_copy(&__cpu_present_mask, src);
>> @@ -3160,6 +3165,7 @@ void __init boot_cpu_init(void)
>>   	/* Mark the boot cpu "present", "online" etc for SMP and UP case */
>>   	set_cpu_online(cpu, true);
>>   	set_cpu_active(cpu, true);
>> +	set_cpu_preferred(cpu, true);
>>   	set_cpu_present(cpu, true);
>>   	set_cpu_possible(cpu, true);
>>   
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 2e7cde033a31..a45f7c308329 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -8690,6 +8690,9 @@ int sched_cpu_activate(unsigned int cpu)
>>   	 */
>>   	sched_set_rq_online(rq, cpu);
>>   
>> +	/* preferred is subset of active and follows its state */
>> +	set_cpu_preferred(cpu, true);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -8703,6 +8706,8 @@ int sched_cpu_deactivate(unsigned int cpu)
>>   	if (ret)
>>   		return ret;
>>   
>> +	set_cpu_preferred(cpu, false);
>> +
> 
> Is it possible that this CPU would be the last preferred CPU in the
> system? If so, you'll make the preferred mask empty.
> 

Possible case is, say there are 80 CPUs and all CPUs are part of housekeeping.
driver marked 40-80 as non-preferred and before driver gets a chance to run again,
user disabled 0-39. Now preferred mask is empty. if steal time is low, it might recover
without check broken in the next sampling, but it stays in between or high, then that
check is broken.

I don't think there is any side effect in core mechanism since is_cpu_allowed will pass
due to empty preferred mask. In driver, further reduction will not happen. But yes, it
will break the design checks.


> In v9 you disabled integrity check while the steal time is withing the
> threshold, so this condition may stay undetected quite a long.
> 

I think simplest solution is do the design checks always and restore the preferred state
if such case happens. I.e drop the optimization that was done in v9 compared to v8.

> Can you add another integrity check here? If you're going to remove
> the last preferred CPU, you need to force-enable some alternative.
> Something like:
> 
>          if (cpumask_nth(1, cpu_preferred_mask) >= nr_cpu_ids) {
>                  new_cpu = cpumask_any_andnot_but(cpu_active_mask, cpu_preferred_mask, cpu);
>                  if (!WARN_ON(new_cpu >= nr_cpu_ids))
>                          set_cpu_preferred(new_cpu);
>          }
> 
>          set_cpu_preferred(cpu, false);
>                  


I think we shouldn't do such change. The design constraints are of driver.
Hotplug mechanism just ensure to set preferred after setting active and clear preferred
before clearing the active. That's all.

Driver runs only once in 100ms at the very least and enforcing design checks of driver
into core hotplug/scheduler mechanism is not right IMHO. It should be the role of driver
to either actively recover or gracefully shut.

That is user triggered edge case, i think simplest solution is gracefully shut the driver and
let user to load the driver again. Always run the design checks. I can add this corner case details
to the driver change log.

What do you think?
