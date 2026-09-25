Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B14A2061
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790353842; cv=none; b=SoHYgqa1kUBHTgroFdNtf8HQFtD8QWMBcxXpifdNqoL5wBolnBsGOUtKw5Wlpx+4Q2+okIgL0GC/9GnVrJXocKTLwlyb4ystFuwJDmhk0dQbviGIN7BrNoPQd7myuoih5UzepseWV209HJkulawoKV9+gC/eB483vmBtfrDjZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790353842; c=relaxed/simple;
	bh=hjotuWDwKis/0QrPguUJayQseX5Dwc63i6QTU+Fr+bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6iOpqDuwjxqDci/YjuAr588zGNxtQfqPZVLBPoUMD7EQ+LCfZC9uUWeVL6fCCcRgwJhqTaAIAnGAs/jlBL3jaytDgMM7MATBLDq2sjV6l463JBITC8lrCMtKzRCrDIDvAowu1MlvhRZ4/o/0JvKvRz5K68ccZX3leGSkggElS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IDQqZMSI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IDQqZMSI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5e7a1530169;
	Fri, 25 Sep 2026 16:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p1GuRp
	iVq4WNX+C4amTFedEsaHNDruqtsxMJVaqb6g4=; b=IDQqZMSIrBMTe0p5mJZ/2W
	MjlQqZ8PGO02rABxcsRae/+NToE6rgyA6twzVuyDW9JBkr3seD4zkJBLm1OZtRc1
	PIAzurz2HgIv1jba2hMeG4OVwte8NQGuHb+7UgYnHPFoEiDIExvSCUYn83LmlHei
	CCcOKEBAIlk1DITg01VA66LpxninyY9SfY+MiuAX19oc+jgn17+mzNNGRikma9WU
	XlAB9+tFbuRjpwNTiFLBo/Yg3b2I5pd9xO7+d0W04VXPRx0oWowTgzhAqsJeiz0O
	qAA4kMXsNhX3q7KzBJDHYyyRGMipqj7QIWJiTMGRXE0ltSev4qafXtrQyKqKi8sg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg3065c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 16:30:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG3L5C4140688;
	Fri, 25 Sep 2026 16:30:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu9310n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 16:30:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PGUDpv50725284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 16:30:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A752C2004E;
	Fri, 25 Sep 2026 16:30:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E3422004B;
	Fri, 25 Sep 2026 16:30:03 +0000 (GMT)
Received: from [9.124.212.213] (unknown [9.124.212.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 16:30:03 +0000 (GMT)
Message-ID: <eb2369f7-a17c-434c-801f-1a8afaac4cad@linux.ibm.com>
Date: Fri, 25 Sep 2026 22:00:02 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/13] sched/debug: Add migration stats due to non
 preferred CPUs
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
 <20260909135617.871006-10-sshegde@linux.ibm.com>
 <20260925154540.GO2009045@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260925154540.GO2009045@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pFrzE615uP6VuCwj46bYJwXdDGlrKMb3
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab6a19b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=zd2uoN0lAAAA:8 a=VnNF1IyMAAAA:8 a=9ZvGxey6vKc89ag3T2oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2NCBTYWx0ZWRfX+AOconJROmIF
 V5UtIUaUw/HxCx/NRS1TMQn8u2y9TMhyNCZ9mPvxkuRkTO+ZoyTa2nfDgWL0aDiBclURQhUOSQO
 NKm61IWliwUdjIQ2KL+5+0lkXpf2XJB3JBzsb4iEVaN/UH+EP4AGWOY41akh8wNIZ6/AjdRv4+1
 +qtMdkPhhvsfO0XkMTnyr7Ebq8uQzR6PY75zFlsJG0pX24sP8Ti3IUoz3uWIzrx7sRQAbPp1U9m
 hBRziKTZSc1ldf5Qb1rHryfZQ1YiZ+43zfs3/Sjdi5nIzNEno95KiMm9kNL+/1HkJ1rnvS16q09
 9z75GnVd4Mr+KY781uHIB+/plh8rtb4rgVvPEJSnwyVD0pMx0QLRJNIrPldpdijOhFxG0MZ0Cfw
 tlGRyaDWDqvEllWfp1iCx4yPPNaUn5aKY2PSES2u08sstYsoTzVEhT6LRoihtWdU1AHg7+TBCv6
 YaEx+lUknk0e4eKdp6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2NCBTYWx0ZWRfX9sQPAea2QESS
 U3QbADy7nLyswSn5NnsvR4tQi7JJ+NrwuiDVDANVNluuAMWNpmm5mWPtTzoiv2AW5I+juMxVO3Z
 QYRjXaRVCh3sXao/0lQZF06ZVmVVzV8=
X-Proofpoint-GUID: 2to-3PhbuOtBMR0r1JaJPS7GDfkId0e_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250064

Hi Peter.

On 9/25/26 9:15 PM, Peter Zijlstra wrote:
> On Wed, Sep 09, 2026 at 07:26:13PM +0530, Shrikanth Hegde wrote:
>> Add a new stat,
>> - nr_migrations_cpu_non_preferred: number of migrations happened since
>>    a CPU was marked as non preferred due to high steal time.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   include/linux/sched.h | 1 +
>>   kernel/sched/core.c   | 9 +++++++--
>>   kernel/sched/debug.c  | 1 +
>>   3 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index d7cc77181ef9..48639b0c75d0 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -554,6 +554,7 @@ struct sched_statistics {
>>   	u64				nr_failed_migrations_running;
>>   	u64				nr_failed_migrations_hot;
>>   	u64				nr_forced_migrations;
>> +	u64				nr_migrations_cpu_non_preferred;
>>   
>>   	u64				nr_wakeups;
>>   	u64				nr_wakeups_sync;
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 458b8c6fd9af..fb8404bd47e2 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -11239,8 +11239,13 @@ static int sched_non_preferred_cpu_push_stop(void *arg)
>>   	context_unsafe_alias(rq);
>>   
>>   	if (task_rq(p) == rq && task_on_rq_queued(p) &&
>> -	    !is_migration_disabled(p))
>> -		rq = __migrate_task(rq, &rf, p, cpu);
>> +	    !is_migration_disabled(p)) {
>> +		struct rq *dest_rq = __migrate_task(rq, &rf, p, cpu);
>> +
>> +		if (rq != dest_rq)
>> +			schedstat_inc(p->stats.nr_migrations_cpu_non_preferred);
>> +		rq = dest_rq;
>> +	}
>>   
>>   	rq_unlock(rq, &rf);
>>   	raw_spin_unlock_irq(&p->pi_lock);
>> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
>> index fda10b3fa249..e6a3b516c703 100644
>> --- a/kernel/sched/debug.c
>> +++ b/kernel/sched/debug.c
>> @@ -1440,6 +1440,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>>   		P_SCHEDSTAT(nr_failed_migrations_running);
>>   		P_SCHEDSTAT(nr_failed_migrations_hot);
>>   		P_SCHEDSTAT(nr_forced_migrations);
>> +		P_SCHEDSTAT(nr_migrations_cpu_non_preferred);
>>   		P_SCHEDSTAT(nr_wakeups);
>>   		P_SCHEDSTAT(nr_wakeups_sync);
>>   		P_SCHEDSTAT(nr_wakeups_migrate);
> 
> Should we not also bump the schedstat version? I forgot the rules, but
> you do change the output. And did we ever merge that perf schedstat
> thing, then that probably needs 'fixing' for the new format too.

This doesn't change /proc/schedstat. Tt does rather change in /proc/<pid>/sched
which isn't defined by version number IIRC.

Also i don't recollect that perf sched stat using anything from /proc/<pid>/sched

I skimmed through this.
https://lore.kernel.org/all/20260119175833.340369-1-swapnil.sapkal@amd.com/

So I don't think we need to update the version.
