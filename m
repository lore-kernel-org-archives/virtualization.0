Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053723ABBE
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914779; cv=none; b=qWdzvx+RJj0EStNumcxM1MFAwjdKx8vDF6v6YfX+/r2Jf5+feFXn5JBbs6knaXBtxeEWbRr+l7EJgl2C0X4cFnXwNUfTpQFHziVyBaeonVoCIyiMZfOrqTRPg9hzD6jt5WsFftCgKRkRVtVH8lwbqDiqnx0Mw29/WYnoQzPcf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914779; c=relaxed/simple;
	bh=sqXgjMnxVwB5jLf9apmcEmcIdXimfaomrH44Eu1+ks4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDkLRz2UA2H1o5sIXu4f2M+fG3lQLEqclivuYPtoedFewteeUXQA00G/kky5rVns5yjXyBmCWuFL33X6JJt2Depe/BwI2678pYmSY+DvTN9wi7Zm1ZKpFA85twea8PFoTuiqv84bDws0D5USDLGwlHFJy22UL6Ca94qhktPnrQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L9UMjgQj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L9UMjgQj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SAWBmm603811;
	Fri, 28 Aug 2026 10:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mdNOCG
	9hVGkZSamZnF5xFjsv+4mSKtbF5oINtJxfMTs=; b=L9UMjgQj8XpI4/Pgm+I/Vy
	HJbfk3/K/UkwhO4ijUDvufngX9y8vP5EKkP0NABXY3n2i7vvqy+kVg2N9D/Tsx7U
	tYbnR277mgf3iEQmwpdqH33S5ip5Hx11CHLPZIq/UsSaZFtjSigngn6/VHjVBBQk
	Au1+GlpnQF0+0w37fVGOdw1GxkleFLa2NX3oxWvx8vjSBB0was5qYwY+S6CKxg4/
	JabENcgaKU5Iao7ueyevNF8e72SusoKwr/7L2ze7lWmN3/f4/KFH9fYXyYPdgcDt
	KBLVH8MHXAB49gA0CKViRsYyrQSSmopGbCKqozfu7zdS+V0ecPxu+h467MTWUP6g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726f3ga3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 10:59:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SAfF3w008413;
	Fri, 28 Aug 2026 10:59:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsynec4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 10:59:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SAxIE938994418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 10:59:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B149820043;
	Fri, 28 Aug 2026 10:59:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 671F120040;
	Fri, 28 Aug 2026 10:59:10 +0000 (GMT)
Received: from [9.124.217.98] (unknown [9.124.217.98])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 10:59:10 +0000 (GMT)
Message-ID: <621386ee-7147-4110-a027-6f2f83b4f1cc@linux.ibm.com>
Date: Fri, 28 Aug 2026 16:29:09 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/12] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
To: Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, yury.norov@gmail.com, kprateek.nayak@amd.com,
        iii@linux.ibm.com, corbet@lwn.net, meted@linux.ibm.com,
        ynorov@nvidia.com, tglx@kernel.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, maddy@linux.ibm.com,
        srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
        vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
        pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
        tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
        rdunlap@infradead.org, kernellwp@gmail.com, linux-doc@vger.kernel.org,
        jgross@suse.com, virtualization@lists.linux.dev,
        sunlightlinux@gmail.com
References: <20260825103855.721013-1-sshegde@linux.ibm.com>
 <20260825103855.721013-6-sshegde@linux.ibm.com>
 <8262d2f9-9f2f-4821-8497-991d7c8448a3@arm.com>
 <CAKfTPtB27-eFXGG9GcXdm4=YLZy6-vQMAQqoCbHa5xZxA3YBpw@mail.gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <CAKfTPtB27-eFXGG9GcXdm4=YLZy6-vQMAQqoCbHa5xZxA3YBpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a916a0c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=7CQSdrXTAAAA:8
 a=VnNF1IyMAAAA:8 a=3M5SV_LQqLPTHtQtqrMA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5MCBTYWx0ZWRfXzbDcEVGCL4JH
 wn5EIiMfIi1tsdHc4qfDlnE660KAf5b5AY3JwjGvgzk0/rnIx/h+lmHGs9QdyoGcWymtsqhM1Bg
 y+1dsYpWKHH4t9GQnovTh8Buc9eyZDU=
X-Proofpoint-GUID: 7UovIHcq1KSAQeTYkkIgdfqZRowbP1sH
X-Proofpoint-ORIG-GUID: d84bnssgdydiY2r8BSVpPufsVQRAAWaX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5MCBTYWx0ZWRfX1m/DnaIUeYGa
 wG+G9rSol9wfBMSF27GlsO22KKPUmtrCX/Kk0YyLyS78qyRLCyJqWR8bRAE+mdrKQMd50F+q/gI
 f5VKTxKczSIc9zZfMhsMBa59myUigPAmFgC0Gp+n17UH3FJKFYcJ7W65hs5I9T5rZa959DqnJyc
 Yx5oRqNTOjohls5aC10TdWcD6UFuPko+5VXdQ/tr+TV+ER+e8pTyhxL1LFAjucN0M/MNQby3WIz
 dhuxibRnwexZFhJjjDV2pIfeGdiq3A7kuPHinG+pVXk4RgJqNLadUF3yObjCIfdqA8ij3mcy9OC
 +sscL7Ukaz/ENAVfaxpRQyEzrdqYKNnL25kK4CSYqcRJiH9NADX2VgqY0nn7N0S4GxMMFrLi9O6
 qpaO19YLG8px9oEFqrRTXM6tneVS4rjtY2117vm1IVMrMvw4C5P9mWSJGz1LOgbXbXx8i3u1Aqn
 tFLhAIZfkByRbWAAW6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280090

Hi Dietmar, Vincent

On 8/28/26 4:08 PM, Vincent Guittot wrote:
> On Fri, 28 Aug 2026 at 09:51, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
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
>>>        return rq->nr_pinned;
>>>   }
>>>
>>> +static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
>>> +{
>>> +     const struct cpumask *valid_mask;
>>> +     int i;
>>> +
>>> +     if (cpu_preferred(cpu))
>>> +             return false;
>>> +
>>> +     /* Only FAIR tasks honor preferred CPU state */
>>> +     if (unlikely(p->sched_class != &fair_sched_class))
>>> +             return false;
>>> +
>>> +     /* Ignore preferred state if task affinity is changing */
>>> +     if (unlikely(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr)))
>>> +             return false;
>>> +
>>> +     valid_mask = task_cpu_possible_mask(p);
>>> +     if (likely(valid_mask == cpu_possible_mask))
>>> +             return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
>>> +
>>> +     /* Tasks with arch-specific CPU masks. e.g. 32-bit tasks on arm64. */
>>> +     for_each_cpu_and(i, p->cpus_ptr, cpu_preferred_mask) {
>>> +             if (cpumask_test_cpu(i, valid_mask))
>>> +                     return true;
>>> +     }
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
> 
> +1
> This is the best way to check that there is a valid cpu
> 
>>

Thanks Dietmar, Vincent for checking it further.

It is good to know that there might be a very narrow window.
The three-way cpumask check you suggested will handle that case safely.


>> IMHO, you want to know whether there is at least one CPU that belongs to
>> all three CPU masks?
>>
>> [...]

With that task_can_sched_on_preferred essentially becomes this.
I will put that in v12 and probably send it out after 7.3-rc1 lands.


static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
{
         if (cpu_preferred(cpu))
                 return false;

         /* Only FAIR tasks honor preferred CPU state */
         if (unlikely(p->sched_class != &fair_sched_class))
                 return false;

         /* Ignore preferred state if task affinity is changing */
         if (unlikely(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr)))
                 return false;

         return cpumask_first_and_and(p->cpus_ptr, cpu_preferred_mask,
                              task_cpu_possible_mask(p)) < nr_cpu_ids;
}


Thanks again for checking and for the suggested code!
