Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1310533B6CB
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924104; cv=none; b=VR3hEtgndoxJ+h028gtX6SNqt1dLxhXybz96pkRUUGEIU5/HvlBlYnjhHgVyvPc6PAkiRHcDxKoVp8p/naUEWuVflHn06mOM1chTojwqHYVkR8tCs16KHg3lyVRsokTQokcWBLq547psrT49N/7CZYKUZJ0ciq/EJSvVt0nBtoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924104; c=relaxed/simple;
	bh=UX7BsPpFPlt1VMUdhE59QDNev/i07gtVU+9QAO0cJKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzT/tEriV9zx9dVACnaKQ4q3z/o/SrVgkPzP5OSrNASac9odtcnOFrnxbBN8qHAuD0muuieP922RUoxsJjIREb1/lZGusb/kNAriM+ZVSoTJQQyr0qEIKk1P17+lqKjMANVdR9kGgpcHh79sV/OTLtTjKPU9vYosrq/Ur2H9Loo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=co+qSGno; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="co+qSGno"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1aaN1116393;
	Wed, 9 Sep 2026 03:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Tx1tRz
	HMmjxoWB0XRU5PrfU6Tn6piNZAICNmYKakpfw=; b=co+qSGnoOOaXW1f63+cfqs
	5EmkJlMhlNtzWHkVhCHXTFRjSWYvQlovHKCaSwi7rItIM7ZWtO4TVB4Ghuxd0dkH
	s2ve9/ISk+3cF/fajBadd/6blNtGhm7QDIrjs9w/AMx81riCTzjQ0y3eZdjYh5lE
	/kueA8FE/Ls7g8WnkckBnVGDBoT18HDMhjuLopbsZq/kxI56yrny8rA9/epF+eM2
	oa06FPGelCWUyuYG8+OhpHGZOWXzWXYuraKQUYpC5LDzuDIFdwGdCcXEgj1QXn/x
	d9HzIRwdE+TeHuL3eHcb547pDJtQt0w7Hp9CmvrWKfC3XKMRCQEXM6K9WfAxgDmA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrtyvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 03:21:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6893BG6t026303;
	Wed, 9 Sep 2026 03:21:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdjyw4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 03:21:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6893LCKT42270994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 03:21:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBD5920043;
	Wed,  9 Sep 2026 03:21:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7851E20040;
	Wed,  9 Sep 2026 03:21:01 +0000 (GMT)
Received: from [9.124.210.73] (unknown [9.124.210.73])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 03:21:01 +0000 (GMT)
Message-ID: <ee949902-1158-456e-af4d-b1fe6c42ac61@linux.ibm.com>
Date: Wed, 9 Sep 2026 08:51:00 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/13] sched/core: Push current task from non
 preferred CPU
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
        meted@linux.ibm.com, tglx@kernel.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com,
        chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org,
        arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com,
        tj@kernel.org, tommaso.cucinotta@gmail.com, maz@kernel.org,
        rafael@kernel.org, rdunlap@infradead.org, kernellwp@gmail.com,
        linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev, sunlightlinux@gmail.com
References: <20260903063240.268775-1-sshegde@linux.ibm.com>
 <20260903063240.268775-9-sshegde@linux.ibm.com> <aptiJP_8SWwZWju6@yury>
 <7d88a3c4-a7e4-4814-9e29-84955b69a5b3@linux.ibm.com> <aqCTMREUoCmbtygK@yury>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aqCTMREUoCmbtygK@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa0d0ad cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=3M_7tuKeB1Q08gyT34IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDAzMiBTYWx0ZWRfX7+zN5KCOgWvS
 WIO/ohdoKa3ppvYVw8YZoMX2/MKxR2nyYx/EZsWptxzxkP5eDEj2UduGXHEqjJWdwD+hGGNteo8
 IMu75u+E5pj3VaTWYsadik7uqJM89Io=
X-Proofpoint-ORIG-GUID: IQtoWIe7xxP2pPV3Ho3_KDvFTVumLClD
X-Proofpoint-GUID: QmZufsrH_Y7quNHkHfj5yuMZRrVyVqhK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDAzMiBTYWx0ZWRfXxaOMyIB+D134
 Mv45fMFsgEQR/4su0lq9GG1+OlOst0NxWokOPdi+YCXPWSvsYnf6h+60XVPY2Q7tUuKTTqBT+Q+
 TMVmnTSS3+nWSCDcyPiQZKKw3FsJ85qUfFaPlUuUZOYvOm3EnmgaaT44iZ8UtR/hJMaU9PeM+x3
 kDjMiCpnjRp9ryuJPIm/kq4fTed/gK+aFdkR+kMn/P4U9FQKtV36mBnkTycP/xTYqcrIZd5xe/3
 XiP/DuV/03ApiS90jRWzOR4jUzRqb0+Ehs+LZ0+6rkBo6nsU5qc29pbc5Izqd0fSFwh49HGrLGP
 te3YhDCOFV8aOUNlZ6fMtRFapRz/7PQEhVnVHq7tt/8bbadCr8OS8qredhlQhr+f/0lLAp6QvEe
 aVA5hENhw+8dIZNl4ZOXJKMpsXxTcOGNWM94E2Ufr+FkUxMfu1WdmQ1Sx2Y7q8aMoibDZpt07d2
 PVMFw/iIYchdEiFo/xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090032



On 9/9/26 4:28 AM, Yury Norov wrote:
> On Mon, Sep 07, 2026 at 08:53:19AM +0530, Shrikanth Hegde wrote:
>> Hi Yury, thanks for taking a look.
>>

>>>> +	/* This could take rq lock. So call it before rq lock is taken */
>>>> +	cpu = select_fallback_rq(rq->cpu, p);
>>>> +	rq_lock(rq, &rf);
>>>
>>> If select_fallback_rq() grabs the lock, then when it releases the
>>> lock, there's a window for race between the other process and the
>>> subsequent rq_lock(). Or I misunderstand it?
>>>
>>
>> select_fallback_rq taking lock is for any state change that needs to happen
>> such as fallback to possible CPUs etc.
>>
>> Most of the time it won't grab the rq lock. Even if the task got pulled by load balancer
>> before grabbing the lock, Below (task_rq(p) == rq) will catch that, and it bails out.
>>
>> So it is safe.
> 
> OK... Can you please explain it in the comment above?
> 
> ...

Ok.

> 
>>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>>> index 6c3ad70e58b8..678e44134acf 100644
>>>> --- a/kernel/sched/sched.h
>>>> +++ b/kernel/sched/sched.h
>>>> @@ -1298,6 +1298,8 @@ struct rq {
>>>>    	struct list_head cfs_tasks;
>>>> +	bool			push_task_work_done;
>>>> +
>>>
>>> It should be protected with CONFIG_PREFERRED_CPU. Also, the name
>>> doesn't look correct. You set the variable to 'true' even before
>>> calling the stopper. Maybe need_push_to_npc, or similar?
>>>
>>
>> ok. npc_push_work_pending is probably a better one?
>>> Why did you place it between cfs_tasks and avg_rt? If no specific
>>> reason, maybe place it next to CONFIG_PARAVIRT-guarded fields.
>>>
>>
>> I don't see a common empty space there. I could increase the size.
>>
>>> What about pahole?
>>
>> I did check pahole on powerpc which has 128 byte cachelines.
>>
>> 	int                        online;               /*  4524     4 */
>> 	struct list_head           cfs_tasks;            /*  4528    16 */
>>
>> 	/* XXX 64 bytes hole, try to pack */
>>
>> It was empty space. Now, that i check 64 byte cachelines it may not be the
>> optimal one.
>>
>> I do see, a couple common places for both 64 abd 126 byte cacheline. I believe those
>> are better places. It won't increase the size or cause any existing fields to
>> misalign. It also makes sense to guard it again CONFIG_PREFERRED_CPU. I had not
>> done to avoid ifdefs. But it is used only under it. So i think that makes sense too.
>>
>> 1.
>>
>> 	struct balance_callback *  balance_callback;     /*  3608     8 */
>> 	unsigned char              nohz_idle_balance;    /*  3616     1 */
>> 	unsigned char              idle_balance;         /*  3617     1 */
>>
>> 	/* XXX 6 bytes hole, try to pack */
>> 	long unsigned int          misfit_task_load;     /*  3624     8 */
>>
>>
>> 2.
>> 	unsigned int               ttwu_count;           /*  5276     4 */
>> 	unsigned int               ttwu_local;           /*  5280     4 */
>>
>> 	/* XXX 4 bytes hole, try to pack */
>>
>> 	struct cpuidle_state *     idle_state;           /*  5288     8 */
> 
> The struct rq is highly configurable. Depending on your config,
> the holes will migrate to different places. I'd not rely on just
> 'optimizing holes' problem. Just put the new field next to logically
> related existing fields.
> 
> You've got paravirt-related prev_steal_time and prev_steal_time_rq,
> and you've got the /* For active balancing */ section. Maybe one of
> them?
> 

Ok. Moving it after prev_steal_time_rq.

  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
         u64                     prev_steal_time_rq;
  #endif
+#ifdef CONFIG_PREFERRED_CPU
+       bool                    npc_push_work_pending;
+#endif


I checked on 128 byte cachelines, it didn't increase the number of cachelines
with the change as well. So we are good there.

base:
         /* size: 5632, cachelines: 44, members: 104 */
         /* sum members: 5022, holes: 15, sum holes: 502 */
with above change:
         /* size: 5632, cachelines: 44, members: 105 */
         /* sum members: 5023, holes: 17, sum holes: 533 */


On 64 byte cachelines too, there is 16 bytes hole a bit below. So it should absorb it
as well. So we are fine there as well.

	u64                        prev_steal_time_rq;   /*  3960     8 */
	/* --- cacheline 62 boundary (3968 bytes) --- */
	long unsigned int          calc_load_update;     /*  3968     8 */
	long int                   calc_load_active;     /*  3976     8 */

	/* XXX 16 bytes hole, try to pack */

	call_single_data_t         hrtick_csd __attribute__((__aligned__(32))); /*  4000    32 */

I will make this change and send out v13 today.
> Thanks,
> Yury

