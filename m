Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5036B51A14F;
	Tue, 29 Sep 2026 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685877; cv=none; b=XN3rrW+LWClGIQUNzcelIG1bahdu0otaA83IAMSaD9B+o0wucEuWbyiolLimZl+4x/bmfauN0zKRKgzJFt0xWNKEdNsoZciEXF/y62sxDBnvicofLsN0qcWT8NttlSvhYEVd/YXfB9P7fT0UrICrNj5zgI5a//FQZcGDRqHiFS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685877; c=relaxed/simple;
	bh=7zCbF+GpwDZQ+pFSCsOJspW29PsvmAYHAjabl9nsyhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgEOrfhuTPj3QR1peS6nLEMobIiDquroCO7H98J+6lmLWOdor7xZLpIsVnN0Hu5YRpLyJBuV+BZkx9aUut1R7fEU1JByP/K+59TcS9EK/iTMexkJ5XorKgtsHqp6T5/LqAuUxH95XDnVMxUuAQAlPxTBMhx4UWQiT8UqEMAXCeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CC9TfELS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CC9TfELS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5LpF4059980;
	Tue, 29 Sep 2026 12:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RjSlzM
	2R9aIL6cDN07DKGdujqs1Abkvok6iYg663e5o=; b=CC9TfELSHSpvuJUf+qTFhV
	7jn+SciJ9rvtC0Nore2qWTSDYdVbGXGmp9c35tmn7umhF5E28bmcmV9pIYvoFdJ3
	4Iod/mXFHSYZv6THmWCRKijVdgvR4AAQCjVCIirDdZtXdmQGNozWzXEvMFRDBS9P
	jB1mV/9yIUA+/c+X+z7lD0MiKQactWj726JEwTNxY42yPcSVy/MnRTdI4tvx4NAr
	geMnNxImTOnPajvImMdL26zMb5PCVK6Zf3fIRCZZz7Q+jCep7008tWPXjCiP4ogS
	kA6bebs9mR9pMstfcRb04ww1Ad0HC/d9HXrFdnU4ei3y+7Z8TtqXTia/eZJhOpQA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5743q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:44:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlrZo1657706;
	Tue, 29 Sep 2026 12:44:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpsw37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 12:44:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TCi9iJ48038178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 12:44:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E77B2004E;
	Tue, 29 Sep 2026 12:44:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49AC42004B;
	Tue, 29 Sep 2026 12:43:59 +0000 (GMT)
Received: from [9.124.214.246] (unknown [9.124.214.246])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 12:43:58 +0000 (GMT)
Message-ID: <2964a7d8-8765-435c-af9e-a38024fca877@linux.ibm.com>
Date: Tue, 29 Sep 2026 18:13:58 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/13] sched/debug: Add migration stats due to non
 preferred CPUs
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
        corbet@lwn.net, meted@linux.ibm.com, ynorov@nvidia.com,
        tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
        seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, maddy@linux.ibm.com,
        srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
        vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
        pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
        tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
        rdunlap@infradead.org, kernellwp@gmail.com, linux-doc@vger.kernel.org,
        jgross@suse.com, virtualization@lists.linux.dev,
        sunlightlinux@gmail.com, Marco Elver <elver@google.com>,
        llvm@lists.linux.dev
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-10-sshegde@linux.ibm.com>
 <20260929121838.GA1814129@ax162>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260929121838.GA1814129@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MCBTYWx0ZWRfX+ViTAVSY9C6d
 Zh0y9/HMm55PExuQ9TJYLIo+RkAoxM619VhzjRtApFwP/DLPkb+/S25VG7vOjSV052bxFXe5mNg
 ESlE7zXQmfoOw7gs+RWGmrdl/teSQ1s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MCBTYWx0ZWRfX0TkZHcNRl/Iq
 KytfmOj6R1bmuveywVoH5xN8IWcLEBFb7NPO1GTxq+V+rm/Z1t3RUPFGFPSrReWe07FiKR9/cvx
 t9Cs3GIAAHL4HomcmXHt9g0qc6pYAi8VYS9ZrHmApZ8leJe82I+ZlUnSCxM+6csoM+Z7wMOLMss
 XinnxIBU/ZbT7LqBqH8MlzZyGGu3v3Q2nPD6YCzJksL6jVgUrd41yURw76JeaBoHuNR6YV2Ni6d
 DWQHnmBlKi16GjpTtXF/k9kUFmAfAsuIEuWAyBGAvWf/eWU9mxJSDrnPRrJAR6k1UNGnHp0xGZP
 c0H7+SJSyeMdENXUJeTJ/m91XKMr8m81oZAbqdJXeQLT2s3L9RAOie/iSPaOBs4wqAMzRsIsHbn
 s99WBKgrgbEWL0mcWqPyWqlE/vrvoBdl8T20devzd6AnUd+1Tt8llQGugX/WBwx8VoRPbbyOBmg
 u3vpLW7VvlgK0jRrZLw==
X-Proofpoint-GUID: STRPcxzn_YxRri8O88Y7Azr011y4-RGd
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abbb29f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=MBmL4KyaN2R1Ztbd2Z8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 70JjiqjWJBATLuNceMBWnv0wpvJ1SX2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290050

Hi Nathan. Thanks for report.

On 9/29/26 5:48 PM, Nathan Chancellor wrote:
> On Mon, Sep 28, 2026 at 11:07:24AM +0530, Shrikanth Hegde wrote:
>> Add a new per-task stat,
>> - nr_migrations_cpu_non_preferred: number of push migrations while the
>>    CPU is non-preferred.
>>
>> Since this new stat is per-task, it changes only /proc/<pid>/sched.
>> It doesn't update /proc/schedstat. Hence increasing the schedstat version
>> is not necessary.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ...
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 5049eff58fb7..7465c983e6f6 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -11236,8 +11236,13 @@ static int sched_non_preferred_cpu_push_stop(void *arg)
>>   		update_rq_clock(rq);
>>   		context_unsafe_alias(rq);
>>   
>> -		if (task_rq(p) == rq && task_on_rq_queued(p))
>> -			rq = __migrate_task(rq, &rf, p, cpu);
>> +		if (task_rq(p) == rq && task_on_rq_queued(p)) {
>> +			struct rq *dest_rq = __migrate_task(rq, &rf, p, cpu);
>> +
>> +			if (rq != dest_rq)
>> +				schedstat_inc(p->stats.nr_migrations_cpu_non_preferred);
>> +			rq = dest_rq;
>> +		}
>>   		rq_unlock(rq, &rf);
>>   	}
> 
> This breaks the build for me with clang-23+ (which have context analysis
> enabled by default), although it bisects to the final patch of the
> series since this is under CONFIG_PREFERRED_CPU and it is not selected
> until then.
> 
>    kernel/sched/core.c:11292:25: error: calling function '__migrate_task' requires holding raw_spinlock 'rq_lockp(rq)' exclusively [-Werror,-Wthread-safety-analysis]
>     11292 |                         struct rq *dest_rq = __migrate_task(rq, &rf, p, cpu);
>           |                                              ^
>    kernel/sched/core.c:11298:3: error: releasing raw_spinlock 'rq_lockp(rq)' that was not held [-Werror,-Wthread-safety-analysis]
>     11298 |                 rq_unlock(rq, &rf);
>           |                 ^
>    kernel/sched/core.c:11303:1: error: raw_spinlock 'rq_lockp(__this_rq())' is not held on every path through here [-Werror,-Wthread-safety-analysis]
>     11303 | }
>           | ^
>    kernel/sched/core.c:11286:3: note: raw_spinlock acquired here
>     11286 |                 rq_lock(rq, &rf);
>           |                 ^
>    3 errors generated.
> 
> Not sure what the proper fix for this is, maybe another
> context_unsafe_alias()? cc Marco just in case
> 

I suspect it is due to using of dest_rq = rq and rq is changing context.

let me try locally and see the fix.
One fix is use rq->cpu instead of rq comparison to see if migration happened.
