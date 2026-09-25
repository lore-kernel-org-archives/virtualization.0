Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A52369D5C
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327796; cv=none; b=KdR85M/ZOfgnXWFcBDYRz/NRxANCRO6jhsUJPTmxArgOL7stN4VH8zMWvGpD9zlDLoPQmPXE7QDIrfjF/qnyKlAqzA4pqvQ1d09/jMfGdawMdUTeKN1h0TUURZ3xqXXaN/kQBlGifo2QtLJjmy3D/UZ+YR+S5xt4MpuO+637cEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327796; c=relaxed/simple;
	bh=f3slEILtnD6OfXYtDBQjn0ok7NXA8T7HoO7/8IG+DlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErjYImDU+JAD8pPp7iCDfwYP56/g3WNZPV/rCixg4EHDw4gqzkCvQ5QEBA0dt5VaWj2KgzPXwLPkpnJbB/3VW5a0rkaTT5WViI7cLkYgiDSyiysWd8cntPs7uYKEXV9Ry6qqXpIwhwlKBMj3ak2OQ+ybU9NmSNAKRmirTN1Jq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S34Fs4b5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S34Fs4b5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aLX3102642;
	Fri, 25 Sep 2026 09:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I4ylKH
	+2sasbHrbNdu3JuSJVulkGePegW++9GIzxR6g=; b=S34Fs4b5gYghWx3sleIzjs
	Vpmclg/ZAqH1JLHIucifBJP37R0950w3BRONnRgSCx1NUOADy9auf+UNPyS3jpGc
	yirFAg1ilh0MnF4e3FXZp5XnGOV3Ji4F6w8mF5+IprZMb2c/+1HKH0aBOTUfJa+b
	+5aeOcmReTs4yv/7zYsQV3LiyJilIegeo0GWiScznRI09dhsG3Z2MNrC3hafUb9k
	iDukDjKdsA87e7MNWvgVHza7uF20wVQ+IuRQjlywNGSS5gXENKYd5B2oswaEvrjb
	K2Bcg8v2tbiwwNqh8yFRbCdRtUpNUgsFrMl/k8HToOS3z5/NYbe2tjDAgkA3JJsQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvn9dt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 09:16:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lVYi3288190;
	Fri, 25 Sep 2026 09:16:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe21tp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 09:16:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P9GD2Q52035920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:16:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C87020040;
	Fri, 25 Sep 2026 09:16:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D91E20043;
	Fri, 25 Sep 2026 09:16:02 +0000 (GMT)
Received: from [9.39.19.124] (unknown [9.39.19.124])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 09:16:02 +0000 (GMT)
Message-ID: <3a509e01-6d50-47ed-a53e-2613f2aaee8b@linux.ibm.com>
Date: Fri, 25 Sep 2026 14:46:01 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 06/13] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, yury.norov@gmail.com,
        kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
        meted@linux.ibm.com, ynorov@nvidia.com, tglx@kernel.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com, seanjc@google.com,
        vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, maddy@linux.ibm.com, srikar@linux.ibm.com,
        hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
        frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
        christian.loehle@arm.com, tj@kernel.org, tommaso.cucinotta@gmail.com,
        maz@kernel.org, rafael@kernel.org, rdunlap@infradead.org,
        kernellwp@gmail.com, linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev, sunlightlinux@gmail.com
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-7-sshegde@linux.ibm.com>
 <20260925074314.GF4121339@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260925074314.GF4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: YVQjQS8n_el1P8wylsA1uh2GsLa7bi2V
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX5Wcw4Krc2449
 1EmLh5yThqVNqFfjMuzk9yQWQV7qeHekWzDhprSevZ67gYAa6JcThmfc/yxJF3r0gdwDIbTjUwC
 cYsyF7CpoPiVvvCtWC4P1iRgNXfeCVo=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab63be2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=LuPJPAu-xtmjmTxlju0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xrjdfTOlYSFchly5w9RSXeFp2lHqp4dZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX1BAoKHzEkdZl
 chgcqQsEqPipJ4xWe7Z+6ON9gLcm2pfTaEH0oSLNzXpC8rfKSiHt10wU/twwpq51s7WePYkonmU
 g3xP/zpq+1LXZchR34K10HB03L9loqleW8ZFRj7izGiefFm791hNA7yLbQXzJXinQKEsnxD+33H
 DfKoVwZhI6+A3JrcNGJkpZ4wOoahiaCuQD36yCpfGZ7RXKGJDPViW0hrb58AWj7w6kKBwWY3h5E
 gpuB+mK1y1kysTQME9NbK67KIvLAIt6d7c8D2qmOBFxzzEZgoDl1akGkDSp8aD2wog6KUAr4tIS
 Xt1HeSC0elmDx3Yen+c+9zSYXSn5qtV6FeQwxmbRGoTgawnEI4kGYJDrVUa+IYAdKrWfwLs0Pl0
 Roxw3h6fjhX++LBPfLflLq8+Fc8nPzh4G//zhEEu9Tkv04e3Gd2ptnTqfRUdEE4RHOlshyycWB7
 nmIWzJRtIw7vDz42CuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250036

Hi Peter. Thanks for looking into the patches.

On 9/25/26 1:13 PM, Peter Zijlstra wrote:
> On Wed, Sep 09, 2026 at 07:26:10PM +0530, Shrikanth Hegde wrote:
> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index a689a0cea4eb..b4ef2e92d786 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2504,6 +2504,23 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
>>   	return rq->nr_pinned;
>>   }
>>   
>> +static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
> 
> (somehow those arguments feel backwards)
> 
>> +{
>> +	if (cpu_preferred(cpu))
>> +		return false;
> 
> FWIW, this reads very weird. task_can_sched_on_preferred() returning
> false when task is on a preferred cpu.
> 

How about below signature?

static inline bool task_can_migrate_to_preferred(struct task_struct *p, int cpu)

> The question really is more like: can we migrate to a preferred CPU, and
> in that context it makes more sense. No point in migrating if we are
> already on one.
> 
> Perhaps a comment on top of the function can clarify?
> 

Above new function name is self explanatory IMHO.

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

