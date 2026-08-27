Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D7456DF0
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837826; cv=none; b=RUAMRKKfuOiabEV2P/co4xmbEmbA8BFHpefAuyltCEQ5GJJ5uFnh6gXC8SWxGpJw2ZAcT0aCOOb5cUksdIwbjVI8IlA1ZnignBKZWBf+VPQgRKIN92kj1IypG56Oocyomg/VPPIDyYomwJocZL7lCOEqbbTJ+xQ9AZ+ypqoRH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837826; c=relaxed/simple;
	bh=LqJgBmDOQ1LG3LaNhUmRwZ2veh5Z168guNPJTWnTZw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjlrKdunOv2sT/BIPbFdUwYo1ZACljcZFAnyx1iA8D8MZ5tjj2Tc23BR2mCP55k1DhZD2+aNI82YTXArnjuelNn8hmTfghNGWhZJSgwiGLC2ZStDS5TSR8EF6oZQ+zK1Q8LBh9Sk2aemkqB/wz6BpisImfgqWpWZ/4OoEMtb9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OAFT2pto; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OAFT2pto"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCVY6Y1126149;
	Thu, 27 Aug 2026 13:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QWywEV
	5XG7SYEGf+hf5Kx484qrYYwrU7s/T/Cwx3JGo=; b=OAFT2ptoPJwfCbO7Ovoabh
	hyGFTyiC7tMuHWjtM6Dts16DRfzXnxfyzyO/cWHUCZtJI3LOLSCBAwVALOLA33f+
	HQqXd3VkWjLxBfQq3XW4OAUIgmNDYl19nQ5dzsIRRR9k4vry9i3v5AT6JcdekqcW
	82N/jpnFF8hwI0iWA2kLvdUyl+AKXngRe3osGNLVYefls1X9ZeVqkeEYcYLTWSER
	li7wcqo4WTaE6YxZlLZZrUV1F2iZwAukrxhBsbLwIrMv2E3IZdkB578A6YhTcCXG
	xyQXZtWxy9PLrVpsmmbvI2gMpgRS9t2LrLmiwe6SX1Ou1fZAQeWks5gBiZWwLUNQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er5kr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 13:36:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQI9i027466;
	Thu, 27 Aug 2026 13:36:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k8a66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 13:36:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RDaZmP42664410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 13:36:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C44EE2004E;
	Thu, 27 Aug 2026 13:36:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A2482004B;
	Thu, 27 Aug 2026 13:36:25 +0000 (GMT)
Received: from [9.39.21.111] (unknown [9.39.21.111])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 13:36:24 +0000 (GMT)
Message-ID: <0a62143d-6d8d-46a4-ac92-f8ca7268e555@linux.ibm.com>
Date: Thu, 27 Aug 2026 19:06:23 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/12] sched, steal_governor: Introduce preferred CPUs
 and steal-driven vCPU backoff
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, yury.norov@gmail.com,
        kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
        meted@linux.ibm.com, ynorov@nvidia.com
Cc: tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
        seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, maddy@linux.ibm.com, srikar@linux.ibm.com,
        hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
        frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
        christian.loehle@arm.com, tj@kernel.org, tommaso.cucinotta@gmail.com,
        maz@kernel.org, rafael@kernel.org, rdunlap@infradead.org,
        kernellwp@gmail.com, linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev,
        "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
 <0f3307c8-6fc9-49b6-93e4-7ffd85dd0c16@linux.ibm.com>
 <2e1085f1-82f2-42dc-ae72-0bedffb414f3@arm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <2e1085f1-82f2-42dc-ae72-0bedffb414f3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: GNkNoyaP7R-XV0vc-jkB0SRU52ylNKEd
X-Proofpoint-ORIG-GUID: 3sZQs5z622aU_2AblTGosj3ABFGT6lRt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfXzqtJ8d3xzNFc
 JmK+ORvd2KVsqVUoV798k5hLW1/qzQILWau16ymVrHyG5GJTEqQM5y3H+rNJBKjvmodA2KzIlpD
 hICu8GKnRUVhU9EjlEJyrvCy/oOjrbk/7OcddXst5QVkO7ukS8ypINdnlyj5aqpIjg0sAD3kdR/
 i+jJwKFfj0EFX1JE/WyrXnI5gGGe75Q1BvcpIKcObKSnzdMHfscQ9iDe4ur2mb7qPWKivNXrJLU
 MxQIU/drlRHWPPl8ZKUv3r4XHuKEWx0FWLzv5d4C6FOglMkS1v2DSsEWyeIeqw4MQuTT63bwxQN
 X2f96bScGTFw1ylT83F5wNntO7z3yvR5hMyIVPXt91wHIuEtGMWFunge84/TZ92PXz3s7JwO/re
 /9gmvIwPSVqyz5fRd9BcbHUlkST9Mdq3ayFJo9cD+yb8o8oSSb0ue234oVihp3vmYedqLzxJ7mL
 m60almwDqWZkDv0wUbw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a903d6a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=RITs98ljX8s46FUaRsIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX4VGsz3rhje25
 uJETd9epERXNMq+ybJd+lfkOhwAvQdBOve+Ne2nSGNBH2gw+6unvMcSzUClDVB+zqEZ0SvmNeLR
 Gbw6LcA1tUUKNJm7nKAJwK1pJk+IlL0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270113



On 8/27/26 4:20 PM, Dietmar Eggemann wrote:
> Hi Shrikanth,
> 

Hi Dietmar. Thanks for checking it.

> On 17.08.26 09:39, Shrikanth Hegde wrote:
>> Hi.
>>
>> In addition to what's currently planned for v11 which was posted here,
>> https://lore.kernel.org/all/895a058a-475e-42ca-
>> a7a3-2c854598eea4@linux.ibm.com/
>>
>> I was going through sashiko's comments at:
>> https://sashiko.dev/#/patchset/20260812054033.95658-1-
>> sshegde%40linux.ibm.com
>> This has revealed some gaps. Thanks to some really nice insights too.
>> Report quality improving day by day!
>>
>>
>> Vincent, Dietmar, please check the 32-bit task issue fix on ARM64.
> 
> See below.
> 
>> On 8/12/26 11:10 AM, Shrikanth Hegde wrote:
> 
> [...]
> 
>> Issue1: Possible crash on 32-bit tasks on ARM64.
>> =======
>>>> +static inline bool task_can_sched_on_preferred(int cpu, struct
>>>> task_struct *p)
>>>> +{
>>>> +    if (cpu_preferred(cpu))
>>>> +        return false;
>>>> +
>>>> +    /* Only FAIR tasks honor preferred CPU state */
>>>> +    if (unlikely(p->sched_class != &fair_sched_class))
>>>> +        return false;
>>>> +
>>>> +    return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
>>>> +}
>>> Does this intersection check need to account for the architectural CPU
>>> mask?
>>> On asymmetric systems, 32-bit tasks are architecturally restricted by
>>> task_cpu_possible_mask(). If a 32-bit task's mask intersects with
>>> 64-bit-only preferred CPUs, this function might return true, causing
>>> is_cpu_allowed() to falsely return false for valid 32-bit non-
>>> preferred CPUs.
>>> Since 64-bit CPUs are rightfully rejected by task_allowed_on_cpu(),
>>> all CPUs
>>> end up rejected. Could this regression cause the select_fallback_rq()
>>> loop
>>> to exhaust all options and hit the BUG() case for 32-bit tasks?
>>
>> Fix:
>> ====
>> I wasn;t aware of this case, thanks to sashiko for bring it up.
>> Yes, it could potentially cause a BUG in select_fallback_rq.
>>
>> Do a simple check if mask differ from possible mask which indicates we
>> are on 32-bit task on 64 bit
>> kernel. Do the below. I think that should solve it.
>>
>>   static inline bool task_can_sched_on_preferred(int cpu, struct
>> task_struct *p)
>>   {
>> +    const struct cpumask *valid_mask;
>> +    int i;
>> [...]
>> +    valid_mask = task_cpu_possible_mask(p);
>> +    if (likely(valid_mask == cpu_possible_mask))
>> +        return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
>> +
>> +    /* 32-bit task */
>> +    for_each_cpu_and(i, p->cpus_ptr, cpu_preferred_mask) {
>> +        if (cpumask_test_cpu(i, valid_mask))
>> +            return true;
>> +    }
> 
> I assume the question is whether task_can_sched_on_preferred() would
> have to be changed:
> 
> - return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
> + return cpumask_first_and_and(p->cpus_ptr, cpu_preferred_mask,
> +                               task_cpu_possible_mask(p)) < nr_cpu_ids;
>> so that cpu_preferred_mask can play together nicely with the 'asymmetric
> AArch32 EL0 (executing 32-bit Arm userspace under an AArch64 kernel)
> support' feature on some mobile Arm64 Socs.
> 
> IMHO, this is not necessary since for those tasks p->cpus_ptr is always
> a subset of task_cpu_possible_mask(p). 'p->cpus_ptr ∩
> cpu_preferred_mask' already cannot contain an architecturally impossible
> CPU for those 32-bit Arm userspace tasks.
> 
> [...]
> 

Based on the report, I thought there maybe cases where p->cpus_ptr may contain.
Specifically after looking at:

static inline bool task_allowed_on_cpu(struct task_struct *p, int cpu)
{
         /* When not in the task's cpumask, no point in looking further. */
         if (!cpumask_test_cpu(cpu, p->cpus_ptr))
                 return false;

         /* Can @cpu run a user thread? */
         if (!(p->flags & PF_KTHREAD) && !task_cpu_possible(cpu, p))
                 return false;

         return true;
}

If p->cpus_ptr is cannot contain an architecturally impossible, then check for
task_cpu_possible again is necessary? I thought there may be cases.
So i kept the defensive check not to fall into BUG later on.

If you think cpumask_intersects(p->cpus_ptr, cpu_preferred_mask) is sufficient and cover
all cases of 32 bit tasks, then i can drop that v11 change specific to 32-bit tasks.

What do you suggest?
