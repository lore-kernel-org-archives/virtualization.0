Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDA631E844;
	Wed,  9 Sep 2026 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973799; cv=none; b=FhQls1dzaWMHnfLx70JvbEgeReu8lcAar22gph5741MYf3q3JMiX+d9ayu8crbMbgNRiQOv5cuubeKyTW5OEdg2S2V3FLYWpYYJHA+mHwnCSwVKpKKoxk/+G9AHrZ9MuCeQlzjaq4lpenUJAi3RXcohIM+B+MSsSjj7H1Ch1RZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973799; c=relaxed/simple;
	bh=hNXwZdRgoUtC914kkJeJOH7tSapL/KdvUz7YGKYBGjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+CspuH2MpjGmriaZpKlaJX4jfnIRPJE78am+z3ESD1hTylzOFJYkzJdsgF51nqXix2URDAjn3ewqBm/oTX7K7BF7jiCDOboGZadyhuhpKpU/FtuIaya+Yg5BTsKsObcw9rEbv9/ux3Fz6n32dOiJ78WVqyqGRB+8H4xo6+xXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EnGATu78; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EnGATu78"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1aKm3839608;
	Wed, 9 Sep 2026 17:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2tqA/U
	vKtOzYQXl3d3IZAhpXw9zqSuq/7l0cVp3X4zo=; b=EnGATu78hOGB8+aRCpR+yl
	Ak7gmZ85PblUUUqC+Xz9V5aqQLYGkjPoQynXf+Tt056AL8HjQ9ssev61CFRQ6CcN
	78J4XiO+ohqaeFdX0wo1/25R7iP2FhzfwPGk2B4vCAsu1T5hKwLv0cYS/4VurmGr
	+SzLNgvUdXFNGHH+3lt80TRrcMFq+vw7Ma9SMNR65ONKbnE5ZuX7/hYmEDYv3qze
	1WLBoVNh822mw2qNEik9aRCf3Fbumk0Fl/3pg8EOOGpzn+A4vRXmPI1u6iMbWJaM
	DNvG0QauXJNQ4FH4uIpFX0PJ1NeymYi0E/fbpDDK5lWw2aL2xt453Ns4NXgcnI8A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf6wj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 17:09:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689GuEVM018356;
	Wed, 9 Sep 2026 17:09:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwhbe3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 17:09:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689H9qfp33358286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 17:09:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5D8F20063;
	Wed,  9 Sep 2026 17:09:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF70B2004F;
	Wed,  9 Sep 2026 17:09:50 +0000 (GMT)
Received: from [9.124.210.73] (unknown [9.124.210.73])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 17:09:50 +0000 (GMT)
Message-ID: <d01dea0e-884d-4c5e-8505-c73570284008@linux.ibm.com>
Date: Wed, 9 Sep 2026 22:39:49 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 07/13] sched/fair: Load balance only among preferred
 CPUs
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
        Eugenio Perez <eperezma@redhat.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-8-sshegde@linux.ibm.com>
 <20260909143301.46F121F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260909143301.46F121F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UypNtXxhDhkqhAPImpJm5v1Pvhln7A_S
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa192e4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4RbsDB8hjsO0hcpbCZQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE5MCBTYWx0ZWRfX2nsnb+rUy5br
 1T9ln4IWdrXCk1wP9aWA3CvS9hOriN7dBS6tWli1uz2ZTxPjb2abK6cv1Qk4zyfexa8zEhb6WlB
 soymUaO4gwarndZikuk4+PI7v0kHwFI=
X-Proofpoint-ORIG-GUID: UypNtXxhDhkqhAPImpJm5v1Pvhln7A_S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE5MCBTYWx0ZWRfX8oTkpQCsnFwd
 h+R1Ibsc5CmuR5BiVl3NKWmv5rzTq/cmpDbGkSODInEQmTUX3NYuIuHChb6d4OlUJbzU0ckLU3T
 02FWqEqMvMouz9KwmeIC8MFT0djRb7eL+dhHP2931a7HUQ3+NDjfxcWcHZDoH6ALJJEjfoOo8Ik
 y7qJ2nxb/6F6exGiPQuONuGDHGsyZFHWO0qvYD5nWEVKmPjrB46/FafWALP1346v0aKP4CrDNZT
 C0Yhw76RUPupkBAUJn/0CCjjWnNdUpF+GH3VZin4ZxwRWqh2rKXOuEK0iIoqNfc7pU166ljgrrs
 dcOxVt9RXfJvA5/nOKeNdSrk/hre/zM0+8/0jq9pENt82qI46yuhzIBYAQCmNvbHVMbA4Du0OIo
 indpLFOaNweLdbvt746BIPt4gcqNu1O5gOw48MEEgWT1WQfpyxgi58sY5DpdkPFnpihmhpJ+a5x
 i71PoRbpD88nykg2iGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090190



On 9/9/26 8:03 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Group statistics (`avg_load`, `group_has_spare`) and load balancing math are corrupted because load and utilization exclude non-preferred CPUs, while group capacity and weight incorrectly include them.
> - [High] Periodic and busy load balancing can be completely disabled for a scheduling domain if the statically designated `group_balance_cpu` becomes non-preferred.
> --
> 
> commit 2dcc3be382ec42f554b59dc47da29e35996ce2d6
> Author: Shrikanth Hegde <sshegde@linux.ibm.com>
> Subject: sched/fair: Load balance only among preferred CPUs
> 
> This patch modifies load balancing to only consider preferred CPUs,
> aiming to prevent balancing against the push task mechanism. It
> updates sched_balance_rq() and sched_balance_newidle() to restrict
> operations using cpu_preferred_mask.
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index b8bd308c2d5b1..4ef1167b8c73f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -13473,7 +13473,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>   	};
>>   	bool need_unlock = false;
>>   
>> -	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
>> +	cpumask_and(cpus, sched_domain_span(sd), cpu_preferred_mask);
> 
> [Severity: High]
> Does restricting env.cpus to cpu_preferred_mask here corrupt the group
> statistics calculation in update_sg_lb_stats()?
> 
> Looking at update_sg_lb_stats(), it accumulates load and utilization by
> iterating only over env->cpus:
> 
> kernel/sched/fair.c:update_sg_lb_stats() {
>      ...
>      for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>          ...
>      }
>      ...
>      sgs->group_capacity = group->sgc->capacity;
>      sgs->group_weight = group->group_weight;
>      ...
> }
> 
> Since it assigns the full capacity and weight of the entire group, but only
> accumulates load for the preferred CPUs, won't this artificially deflate
> avg_load? This could cause the load balancer to perceive mixed groups as
> severely under-loaded and aggressively pull tasks to already overloaded
> preferred CPUs.
> 
> [Severity: High]
> Can this also completely disable periodic and busy load balancing for a
> scheduling domain if the statically designated balance CPU is non-preferred?
> 
> Looking at should_we_balance():
> 
> kernel/sched/fair.c:should_we_balance() {
>      ...
>      if (!cpumask_test_cpu(env->dst_cpu, env->cpus))
>          return 0;
>      ...
>      return group_balance_cpu(sg) == env->dst_cpu;
> }
> 
> If the statically designated group_balance_cpu(sg) is non-preferred, it
> will abort immediately because it is excluded from env.cpus. All other
> preferred CPUs in the group will also abort because they fail the
> group_balance_cpu(sg) == env->dst_cpu check.
> 
> Does this mean no CPU will perform the domain balance, potentially causing
> severe starvation?
> 

CPU are marked as non-preferred in decreasing order and group_balance_cpu will check
in increasing order. So likely first cpu in the group will be preferred in case of mixed
set.

Also, at least one core is expected to be preferred always. that will drive the load balancing
in the worst case.

I have kept this implementation simple. If we see a sever imbalanace/starvation
additional code changes maybe worth.

At this point I don't see they are necessary.
