Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE853DC4CD
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368269; cv=none; b=QTNMH7rON7c/doZX+Z7jO96Z+ESo1iuRiaBR8cOrDpDyBI79kXEiN6n7Q8CQGN5r8U/WW97uHI9Py9KbRwwEtBCR9rUmnFVub9Bz/wm2WiIU30Vnaq76o4b9q+ql+AFax/fpImhyfOPFlIiA0ojMfRma2Y6xX/ElR354TYgWZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368269; c=relaxed/simple;
	bh=4P+N0dmzp+E+cGX8207jgIViCCigjIHn+YfzZBXj4ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjGChmNjp+AixeflQIIZsSBmb/qigmejykuBvXQLFyW4C9LeyAPtON8NMI1YclFHrUIEy3gtWKlsG7MlDvKD+ViNHot1D7lU4woBAb465BeBMMMYJBxKy9FLV7oqKThkhHpnPu4nfCTM+watb7KHP0HbVkgkNcIIGXkutn5o6ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eVkCCWNk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eVkCCWNk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AD1cEh4027218;
	Mon, 10 Aug 2026 13:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J/G9MH
	op1bQdqm3o5hSuf6LyOSBCc7bsB1+v/bdl5Fg=; b=eVkCCWNk2wC9aKaGGSeDAX
	yFmvrovTv1vPasB2WRHpzODqekCr77AmmShkudckOM5FMCYl0yspmRSQo7FNeExz
	8GuuIKHpJraEdCm294DoS9YLubFxT7tO/8cEd9FSO/kbVw2zlEqwMH2wCftnCDog
	QX2Qlp+9AsbtDjPWTuCErFx4jbYHqLIi71S2h47a47OrPYKuM3xY7Kce83/uLN98
	kECLuPEuZblAW5rbmUOCJYRqlpQI5kBNxhfUpufik+fVo3UEWs2h9h7YEF/6ij7t
	83J438kZl7eF/GPJnYP7zOer13pX2anwOqV/yODdt4x8ElGMResK4lB8UI+jjPig
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyr3vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 13:24:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ADBIAx008472;
	Mon, 10 Aug 2026 13:24:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespw2n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 13:24:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ADO6pv49611206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 13:24:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B67020043;
	Mon, 10 Aug 2026 13:24:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64B7720040;
	Mon, 10 Aug 2026 13:23:58 +0000 (GMT)
Received: from [9.39.23.237] (unknown [9.39.23.237])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 13:23:58 +0000 (GMT)
Message-ID: <a02c8bfe-5bec-4d2f-9183-8a0f856d3247@linux.ibm.com>
Date: Mon, 10 Aug 2026 18:53:57 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/11] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
To: Mete Durlu <meted@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
        seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, maddy@linux.ibm.com,
        srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
        vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
        pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
        tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
        rdunlap@infradead.org, kernellwp@gmail.com, linux-doc@vger.kernel.org,
        jgross@suse.com, virtualization@lists.linux.dev, mingo@kernel.org,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, yury.norov@gmail.com,
        kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
 <20260724140732.2683314-5-sshegde@linux.ibm.com>
 <31646728-5af6-4f3d-b461-8992c213e230@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <31646728-5af6-4f3d-b461-8992c213e230@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDExMiBTYWx0ZWRfX2eQHCac+wRev
 80O/qJpE7GLgFnQRfOGfSZWdri56cwtSLYGhM16LheEcGEO2vWGTHbT8zkdifNiuBD7pbXOHCQm
 ESS2lEEu96JjkWg7QiPLqiVYZuEVrrEgbAsDNVqXabELo0cStzPW43rjXww6hTalmO6LoFqT1vB
 cdtgPpdqCV1+llhKnhC1eiPZFJJM7Mw+HrJNsM7UHXdPm8B2wqv8DV5DMkqWguTrO9M5rQmrOMd
 GiGwowHYrsLmDSeq5U+c0N1wW4/C9Qb86+HAFcLkAjWQHFo721ukVfWWKXZRTfNSIHP3hf8REQv
 8RpZl6f3AEph9tGCrA39CAtfKzvzquYipf3/SqU/pZeaYMv5/u+nSoOOeONnkHuEEYifyl2AakM
 wLBYJWTA0H6a2UFufIJ4HO/HG9S/uivdUTsD7iSnUUsgj1WrZ9OuIGvjMrlcP7orNcJYApncyv/
 Rh8V1IgWhHvln5lwWvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDExMiBTYWx0ZWRfXzrfM0ODdCebM
 bmjTR+x8LavNRsQVzwEHidJtIf4Gf1wqBIGTjK/XeHDe3bZCFEA3g7NgTHwfekzUOVMryxIKQm0
 DrfHuAfibmsV5kzmwarUqMAAnU6xyWI=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a79d0fb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=2eUty9qkGphTp3J6qE4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zTtBMhQId9jhfyaGKZchu1dPJTn-_J-r
X-Proofpoint-ORIG-GUID: Gkq1fUHav5AqOl8Y7R49E8MdhM85LY_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100112

Hi Mete, thanks for taking a look.

On 8/10/26 5:28 PM, Mete Durlu wrote:
> Hi,
> 
> ...
>> For majority of the cases this would still keep select_fallback_rq
>> as O(N). task_has_preferred_cpus which is O(N) is called only if
>> !cpu_preferred. Then task running there is expected to move out.
>> So subsequent it should run on preferred CPU. This becomes O(N**2)
>> only for tasks pinned only non preferred CPUs. That is rare case.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   kernel/sched/core.c  | 12 ++++++++++--
>>   kernel/sched/sched.h | 12 ++++++++++++
>>   2 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index a45f7c308329..9e8eec4451b6 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2509,8 +2509,12 @@ static inline bool is_cpu_allowed(struct 
>> task_struct *p, int cpu)
>>           return cpu_online(cpu);
>>       /* Non kernel threads are not allowed during either online or 
>> offline. */
>> -    if (!(p->flags & PF_KTHREAD))
>> +    if (!(p->flags & PF_KTHREAD)) {
>> +        /* Try to use preferred CPU if task's affinity allows */
>> +        if (task_can_sched_on_preferred(cpu, p))
>> +            return false;
>>           return cpu_active(cpu);
>> +    }
>>       /* KTHREAD_IS_PER_CPU is always allowed. */
>>       if (kthread_is_per_cpu(p))
>> @@ -2520,7 +2524,11 @@ static inline bool is_cpu_allowed(struct 
>> task_struct *p, int cpu)
>>       if (cpu_dying(cpu))
>>           return false;
>> -    /* But are allowed during online. */
>> +    /* Try to keep unbound kthreads on a preferred CPU if possible. */
>> +    if (task_can_sched_on_preferred(cpu, p))
>> +        return false;
>> +
>> +    /* Otherwise, they are allowed to run on online CPU. */
>>       return cpu_online(cpu);
>>   }
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 26ae13c86b69..6de6366f2faa 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -4230,4 +4230,16 @@ DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
>>   #include "ext/ext.h"
>> +static inline bool task_can_sched_on_preferred(int cpu, struct 
>> task_struct *p)
> 
> 
> Sorry, I glanced to the earlier versions but I couldn't find
> the answer to my question. Trivial one but still.
> 
> FWICT, task_can_sched_on_preferred() is only being used in
> core.c, is there a reason why it is defined in
> kernel/sched/sched.h and not in core.c ?
> 

Will move it out of sched.h. Thanks for pointing it out.

> Thanks.
> -Mete

Also, thanks for checking that s390 change.
