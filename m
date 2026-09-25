Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58748662E
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329709; cv=none; b=aHfA4DKzaQcbt5qY79MGTPr7hjK0i1Bv7ZMYEJpf2SzolOr3Lt7Snq+/MdFKRv95w1iRVhxD18Xdhm6L1pFOJ8MFrDWBOcUTdZBrWVjGAQHugQOEVbiQz+o/u4rj9yyUY9dDnZsVpcUrPemTeutmg7UZPJbx4PktvTx1C5PPO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329709; c=relaxed/simple;
	bh=hqExfXTHIcTcyEHklVRM0BzpUqrw+4faYEwu8KNKxog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T17PxQ/gLqgEw3GKzKvIX5jZIi/7yZ1uB5KIUad5XgDr21p54jhz6UZ3J1a5oE/T88K+jR28ZaAIY9maQUz1odmcgQTS44oGc6SgsDY9aoeJ33AlrZJFXRYGp133OkWZmYHZszF8Ws60SgZCsrPmtSQqjcrqU9bpNG4ONIcdHUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cWNcGIlT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cWNcGIlT"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4acrZ061841;
	Fri, 25 Sep 2026 09:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BAMPiq
	7qxEpN74mGPM819vspDrfZEjaehxE6QVIsFAY=; b=cWNcGIlTcJiSZH8xq8QVzR
	DBWvc3wHTz4K5AsLqobBuIMiqkb8zBib7yyWzCB5vMixov2YXWrt9UukppXXwTHI
	oWM+OYwGfj92WqpgGSMkucBqBP4A7jkhvjR8TZzuiMqhN9FGac4+SwXfW+lRax7d
	Rkd6oU+vDpb8TIxqBWyLIMYGVckp08SCa2c4pGv+j1ccRXGnnx8/ZHEjhH0NH349
	wpKM7O83vGE8+5evNYytgTyYC9sX25YiilXJaNYFhje9373s06ZgKJOfCFCWW/GZ
	VLndvWBf+v+iqtmQPaadicoVD1xdFKzH80iNJ5K38qJ4JMeJaa7yRFsoB3XYYVig
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsp8mr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 09:48:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lU8e3288179;
	Fri, 25 Sep 2026 09:48:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe21w8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 09:48:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P9luMD52298060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:47:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8458D20043;
	Fri, 25 Sep 2026 09:47:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ACFF20040;
	Fri, 25 Sep 2026 09:47:48 +0000 (GMT)
Received: from [9.39.19.124] (unknown [9.39.19.124])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 09:47:47 +0000 (GMT)
Message-ID: <4e2421fe-4b26-4d92-8709-bfa8d3a4114a@linux.ibm.com>
Date: Fri, 25 Sep 2026 15:17:47 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 08/13] sched/core: Push current task from non
 preferred CPU
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
 <20260909135617.871006-9-sshegde@linux.ibm.com>
 <20260925074953.GG4121339@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260925074953.GG4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab64352 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=sB9Cf5MOR3c-l3nHmB8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: c6kA6vVibaezv8Rv_91wlU8f0HEHy6qR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOCBTYWx0ZWRfX4f+Zfj0ioizA
 jpZIE4/2mClgZ0mgNK0bSZx94Z9rkRWX3MWF8WkbE2KrwQGyeR+l/bzGcElKIfmJGpvXBmfEzKw
 dSB2l/pjQtyry8I/Ds56AeKM60fCWIkPn2EUq//OTXFNXWqMFBqX8Iu90Fy3rl9Ta7Xkh7Jl9W8
 crM11vO5fltbLTGpDcaEBM7K8CoMmVsa9uAF0OoKMatndXBwlWSkjfFaaql/y08cGVcxdA84/fY
 +ydoOTY49JdrDswoGeU965d/MZYJd91+/Ch5YnXZTQzFfUEP2W5SHyZnpOVbFwpoePkquHR4gJ0
 PTIDVCqKHxPO+4RvkiAz1o2xWxjqhjfB5CO1nju+BuHgV/HIvgRjtT8AV5mtraUgcZH3U3U4eKY
 fYzNLoQCBOkarWrjspdXdhFxFk0ast7abNyZzTDSi05cnlxoMdw2Sh71l7pAjyqN/vz7vhQfJ4l
 uPQc/xGnI8o72UUzWoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOCBTYWx0ZWRfX0g2S1LbZbO1G
 z6t6UEMCkVPe7mHymTr+wKCNHh/9kWcQjlzCKRWEFpRI6cqtPCFrdyKuoVvv10BXq4g1vyDV6nu
 REE6VLPbS7QKg/jJS7RKvmr32upXzN8=
X-Proofpoint-GUID: ojXf-R95wBDJl8rQb_uFtSW0mjZyzSGF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250038

Hi Peter.

On 9/25/26 1:19 PM, Peter Zijlstra wrote:
> On Wed, Sep 09, 2026 at 07:26:12PM +0530, Shrikanth Hegde wrote:
>> Actively push out the current running task on a non-preferred CPU. Since
>> the task is currently running, a stopper thread must be queued to push the
>> task out. However, if the task is pinned only to non-preferred CPUs,
>> it will continue running there. This helps to maintain userspace
>> affinities, unlike CPU hotplug or isolated cpusets.
>>
>> Though the code is similar to __balance_push_cpu_stop and quite close to
>> push_cpu_stop, it is kept separate as it provides a cleaner
>> implementation specifically for CONFIG_PREFERRED_CPU.
>

> I would have preferred the code looking more like
> __balance_push_cpu_stop(). Now you're written more or less the same, but
> visually different for no reason. This makes comparing them unnecessarily
> hard.
> 

Yes. I will keep your version at the end and respin v14. Hopefully by Monday.

>> Add the npc_push_work_pending flag to protect the work buffer.
> 
> I can't help but read NPC as Non-Playing-Character. Too much RPGs, and
> that ain't Rocket Propelled Grenades. TLA are such fun :-)
> 

hehe. one more into the mix.
> 
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
>> +			rq->npc_push_work_pending = false;
>> +		put_task_struct(p);
>> +		return 0;
>> +	}
>> +
>> +	raw_spin_lock_irq(&p->pi_lock);
>> +
>> +	/*
>> +	 * select_fallback_rq() may acquire the rq lock in case of fallback.
>> +	 * So call it before grabbing rq lock. If the task migrates to
>> +	 * another CPU before the rq lock is acquired, subsequent validation
>> +	 * of task's current rq will help to safely bail out.
>> +	 */
>> +	cpu = select_fallback_rq(rq->cpu, p);
>> +	rq_lock(rq, &rf);
>> +	rq->npc_push_work_pending = false;
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
> 
> Anyway, I ended up with:
> 
>    static int sched_non_preferred_cpu_push_stop(void *arg)
>    {
> 	  struct task_struct *p = arg;
> 	  struct rq *rq = this_rq();
> 	  struct rq_flags rf;
> 	  int cpu;
> 
> 	  if (cpu_preferred(rq->cpu)) {
> 		  scoped_guard (rq_lock_irqsave, rq)
> 			  rq->npc_push_work_pending = false;
> 		  put_task_struct(p);
> 		  return 0;
> 	  }
> 
> 	  scoped_guard (raw_spinlock_irq, &p->pi_lock) {
> 		  /*
> 		   * select_fallback_rq() may acquire the rq lock in case of
> 		   * fallback. So call it before grabbing rq lock. If the task
> 		   * migrates to another CPU before the rq lock is acquired,
> 		   * subsequent validation of task's current rq will help to
> 		   * safely bail out.
> 		   */
> 		  cpu = select_fallback_rq(rq->cpu, p);
> 
> 		  rq_lock(rq, &rf);
> 		  rq->npc_push_work_pending = false;
> 		  update_rq_clock(rq);
> 
> 		  context_unsafe_alias(rq);
> 
> 		  if (task_rq(p) == rq && task_on_rq_queued(p) &&
> 		      !is_migration_disabled(p))
> 			  rq = __migrate_task(rq, &rf, p, cpu);
> 		  rq_unlock(rq, &rf);
> 	  }
> 
> 	  put_task_struct(p);
> 
> 	  return 0;
>    }
> 

Alright. Will keep the above. (without the additional migrate check)

> And note how you have an extra !is_migration_disabled() vs
> __balance_push_cpu_stop(). Either yours is superfluous or
> __balance_push_cpu_stop() should have one. Which is it?
> 

yes. It is superfluous. Queue side check is sufficient.
Will remove it.
1. Even if task got pulled by remote CPU before stopper got to run,
    the task_rq check will fail and bail out.
2. Since the policy is currently for FAIR tasks only, it can't run
    before stopper.
