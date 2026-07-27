Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB45288B1
	for <virtualization@lists.linux.dev>; Mon, 27 Jul 2026 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142568; cv=none; b=bHEvZrfS3PHg/801Bg373bCGrSgIx2+ThaU1n6M49gyfftyr4C6DI+MrxUgn6oK3WK+vkpG90KsXPWJw7RCfQAtB6VCkTF6Sv7LGWbelQykNMAzKaTdXB5x4Pg+8FfT2w7Y+NTFAte3DAibgORGEzgroiM6js9QpR2BLq+DZa6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142568; c=relaxed/simple;
	bh=EwdRi4tElG+0qe0BnhMKaMjXX3+o9ZAFoaBHoLX+/oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nqd0NYtjISHbC3eH5h2YSfY7xVNLRnf5EjoopxNdvrz8g6p22XUIjC9+k86mGEPDP7WCuVjmD1+e589gDILiF4PuKnoXSDGpRSWt7v3NxtZlsqZuglVka+KPoX/+AF098jPGnthfUzGatuAAJ+MJZ+3BaGpIT8omJyyfepV+xYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aXXNMFWI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aXXNMFWI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R7lgs43931632;
	Mon, 27 Jul 2026 08:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XgvhRK
	XymUWn+Gm165KKZq2jgPIfLqjBSMLXta5XzNQ=; b=aXXNMFWIf/uytlBtAQz5az
	9ZrSldBrLhOi0qpVxEclUcHr2C/pq/sVevomBxWh/zAJzgc1c8sWjmZ8pW3AdFd4
	Vi6E6+bjs7MGtjFvK8QFghBrSorkERn4lElT1Kd41PbI/BmdFCpLF80msoMesptN
	ZrIkeQs6g6aZjYn22527IeA5O/qji4Eabqfzjg3gTQo62jrTbi5aMtzzsXyCHvCp
	tMgwBV8JbZHYDcs6lpWSTVa35BlBz4GRfJU6E4uhyQa6T7taR2LIPS4ndMvfhcLl
	OhDlduGOGJV/0L2xQXypGKlT26MYXyGR8cM0NU+2kdtrJmBLbJZTFxAOXZ6uXr+w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc73rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 08:55:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R8fGAT018737;
	Mon, 27 Jul 2026 08:55:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvvr5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 08:55:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R8tj9c33423760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 08:55:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 963032007A;
	Mon, 27 Jul 2026 08:55:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13B4820075;
	Mon, 27 Jul 2026 08:55:36 +0000 (GMT)
Received: from [9.39.23.10] (unknown [9.39.23.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 08:55:35 +0000 (GMT)
Message-ID: <93f57732-f110-4289-a9d3-b760da566bff@linux.ibm.com>
Date: Mon, 27 Jul 2026 14:25:35 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] sched/core: Push current task from non preferred
 CPU
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
 <20260724140732.2683314-7-sshegde@linux.ibm.com> <amPhfyyVK-5g1PV5@yury>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <amPhfyyVK-5g1PV5@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: EWLXC-aeMlQ2WNURWcx9pbvyfgqVEuZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4NiBTYWx0ZWRfX8busp0i0RAij
 ysue37k04cjlIISuH8nSqOrmdezAJblJUPQETxz/PCF2aWVe8y1hvlk3bAQlS6QnnYZwWZYMs9b
 LIc8jbJzQL8G+gTQ9E53VKsu2Sutazyrg+NN8kHhs25NHtLkbA37i+3nYAVeoiBWwB1pbzKrQGP
 rWifLPRhMABn9YrZkLmc6tfB/DE1LkoZhTvQh1WHIZO9L18EQU1gfFlrGJRUXNp0+eBShVdOTBq
 WkFfyZ3TZji/2NGdI/R68kmAbsKOpS/eEVcy4yhEL0ekj8nvsmYiTRgdRKtuKLycXDQQPSg6PDd
 lr7GkXn2ni8KIGrAYvOmUuan48CflmUFCsZ7z9HlGjp8WJrz4ZpnfC4NOLwcu73mQ+7FM7e40kM
 tc61wmnbfOri8gcwSdCXkMsdwNTHpXSCMIrvfLVIjOtQ2egeSf/ERD3mS7dqchHEVpGlErfZITh
 rDx2IfFVVGSCTFdOT3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4NiBTYWx0ZWRfX7gNrW14KdPcE
 EMaLp/lv2OFb98Ynmd+znDp0adEN8ZxEoHdrtUDZQDQojf8YnxJ/dLrS/QrMOA3il/6hPgHdMyE
 OdO/dy/134YshUKAdHsRpXGjpEcFirc=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a671d17 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=iZAcCB8-FdyIZWZutlUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UIhXhdUf10bfwPHIA7vSQY3EhEl32iZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270086

Hi Yury,

On 7/25/26 3:34 AM, Yury Norov wrote:
> On Fri, Jul 24, 2026 at 07:37:27PM +0530, Shrikanth Hegde wrote:
>> Actively push out task running on a non-preferred CPU. Since the task is
>> running on the CPU, need to stop the cpu and push the task out.
>> However, if the task is pinned only to non-preferred CPUs, it will continue
>> running there. This will help in maintaining the userspace affinities
>> unlike CPU hotplug or isolated cpusets.
>>
>> Though code is similar to  __balance_push_cpu_stop and quite close to
>> push_cpu_stop, it is being kept separate as it provides a cleaner
>> implementation with CONFIG_PREFERRED_CPU.
>>
>> Add push_task_work_done flag to protect work buffer.
>> Works only with FAIR class.
>>
>> For now, only current running task is pushed out. This keeps the code
>> simpler. In future optimization maybe done to move all the queued
>> task on the rq.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   kernel/sched/core.c  | 78 ++++++++++++++++++++++++++++++++++++++++++++
>>   kernel/sched/sched.h |  8 +++++
>>   2 files changed, 86 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 9e8eec4451b6..704043531b24 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -5774,6 +5774,9 @@ void sched_tick(void)
>>   	unsigned long hw_pressure;
>>   	u64 resched_latency;
>>   
>> +	if (!cpu_preferred(cpu))
>> +		sched_push_current_non_preferred_cpu(rq);
>> +
>>   	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
>>   		arch_scale_freq_tick();
>>   
>> @@ -11292,3 +11295,78 @@ void sched_change_end(struct sched_change_ctx *ctx)
>>   		p->sched_class->prio_changed(rq, p, ctx->prio);
>>   	}
>>   }
>> +
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
>> +		scoped_guard(rq_lock, rq)
>> +			rq->push_task_work_done = false;
>> +		put_task_struct(p);
>> +		return 0;
>> +	}
>> +
>> +	raw_spin_lock_irq(&p->pi_lock);
>> +
>> +	/* This could take rq lock. So call it before rq lock is taken */
>> +	cpu = select_fallback_rq(rq->cpu, p);
>> +	rq_lock(rq, &rf);
>> +	rq->push_task_work_done = false;
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
> 
> You always return 0, and don't test the return value. Just make it
> void, or return (and handle) some error, please.
> 

Currently all the function callbacks of stop_one_cpu_nowait return 0.
This can't be changed to void today since signature mandates int.

typedef int (*cpu_stop_fn_t)(void *arg);

Also even if return value is of some error, it doesn't make any difference.
This is because in cpu_stopper_thread, return value is propagated only if it
wait for work to complete semantic. stop_one_cpu_nowait sets done=NULL.

bool stop_one_cpu_nowait(unsigned int cpu, cpu_stop_fn_t fn, void *arg,
                         struct cpu_stop_work *work_buf)
{
         *work_buf = (struct cpu_stop_work){ .fn = fn, .arg = arg, .caller = _RET_IP_, };
         return cpu_stop_queue_work(cpu, work_buf);
}

cpu_stopper_thread:
                 ret = fn(arg);
                 if (done) {
                         if (ret)
                                 done->ret = ret;
                         cpu_stop_signal_done(done);
                 }

If we really need to return void then we need a new function signature for nowait
variant. Adding separate function signature just for nowait isn't probably worth.
What do you think?

