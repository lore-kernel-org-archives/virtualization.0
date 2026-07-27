Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60162347BD9
	for <virtualization@lists.linux.dev>; Mon, 27 Jul 2026 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785132648; cv=none; b=csNXlC+rB658k7A5tkyesdq8SIViPSlqlwZgoqv+KVGdH4U7TJfu6nTgMy2jVNgwPuYQE55JVyLL4VKiWXrxxpr+UHPcjILOJ8DtW4oBKpCW+q4ytRj/Q1N4r++EQaAL/+i+6Kp6kT4uf4/qOOuRPMuXY8JMRWprh3SxnOr9Hw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785132648; c=relaxed/simple;
	bh=2/HqORRDHMSzkF8W2BkwAFoBIHAHbcoddansYmdeBXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIV6L4FgUDAo+8ZzlUyiyhykN3wPkLldhzyYIGAAahgT4wQ8xdXnvde9S7CEPzvahnQhAVG+X68VyPmvnzCY8g+byoZVKfHu+hFJQuwbTYHmRTDIQPb29L5c+PR0KdoQ7zfnIv9Yp7CnSDCe0GkBY4qccq0dl55CCVZ5Hz0ynYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S/TnRj3l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S/TnRj3l"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1lcrw856021;
	Mon, 27 Jul 2026 06:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pxJBb8
	HV9egUp9ZAdZQSmmDykXwCBdfDMRrKIQ6T6/Q=; b=S/TnRj3lTSoZvkEiZAGxfU
	YTotL16NxH3J7ya7oeF+7w/gFiK0Ocv6PTGjcLOOn9zP8fnIs3f+nb+yX8rxX4Ky
	IOMIzQmMhfkdH+c0h33UOMoqS7kpBtlri4RUc9KScFaHvjt/FZUJBLRNO/qf8bNO
	OVep+Sub5trjqN8JWooaNGAE+18dHsWVxZuG/uB32LvlULKdgHvR3jihfymL94s5
	4P63ebQbZA4zvEZP+9h2sxd/pUoFfRWHd5DF7jOupCvr4DPvrOEmj0eGzEUXxI2P
	loF5tp18otg5nZlB+LgEkkFoHYaaqbvsCRMe1gH77OGBCKzhJFvuH77vQi1Yq2Ng
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw76dda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 06:10:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R5uJon011144;
	Mon, 27 Jul 2026 06:10:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjv435-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 06:10:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R6A8q316056624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 06:10:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CCF5200D5;
	Mon, 27 Jul 2026 06:10:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BC79200D8;
	Mon, 27 Jul 2026 06:09:50 +0000 (GMT)
Received: from [9.39.23.10] (unknown [9.39.23.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 06:09:50 +0000 (GMT)
Message-ID: <0c8ac2ad-f1f3-4d44-8812-069126fd47f6@linux.ibm.com>
Date: Mon, 27 Jul 2026 11:39:49 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/11] sched/fair: Load balance only among preferred
 CPUs
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
 <20260724140732.2683314-6-sshegde@linux.ibm.com> <amPbythM-IBt6j_e@yury>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <amPbythM-IBt6j_e@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 840i94e8tkH3uGBT-AAl3J8mPyml5lQu
X-Proofpoint-ORIG-GUID: lcOu_lQvPIHC-2O1WnOpDEC2TB-Wotl7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA1NSBTYWx0ZWRfX6Q/tvC2Yyy17
 KfY78NZGc/miGi49NeKrSOXP++S6QqrWvKCV+hx8OqtPiJd4xwJ1E9LS9I4NAZm4NBX6Kmh1fca
 bP1/ZKlcfTKwZrojLSyZnayJuWeeaaNLJ00LMmhPnRZVO02tGC/SmXMYkQtV4uFit/RXAJ3NGj3
 ExI/G19Q0rJZLkNvXwkXM30PMa7UBOSy9QIBwqFbN1VljIrhZN1Hbl502Ar6yws0jcPcsmfaoWk
 mquSIIGxNysODyYHMS5JCGzQngi4NQJUc0e5fPdWLIcUTri4YRZF8HzeFXSKOEG4LlqwioH6IfA
 Ydn7z7bKavvK91zyJfuUkHBWiWrQLv1jo7YazbzgpONwW2j5AiiDqoWaQd/TW0cjESRQnp7atxo
 dnX2nCCEM2CE3+n8mtyssM2Qw40hDssDSA6qTjVwXomIwmWRMC+dC9vw/ZlnmyTGfLB64P2E/YN
 GH3wHqoyAfafbSVqqiw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a66f646 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=DaLd6QIzbGPc3mM302UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA1NSBTYWx0ZWRfX6qw3xOEPHcId
 6X2SrOOfI4ODhxR4vX0ZtNridFpyt+b3hGz9201vN0wwZJe4YDsrx2/2hCVj3x0fKMVjA/Fdbjt
 /qgP+BwBTaoPcTRKc5NGfaw9snU0pyA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270055

Hi Yury,

On 7/25/26 3:10 AM, Yury Norov wrote:
> On Fri, Jul 24, 2026 at 07:37:26PM +0530, Shrikanth Hegde wrote:
>> When cpu is marked as non preferred, any load pulled towards it is
>> pointless since in the next tick task will be pushed out again.
>> So, Consider only preferred CPUs for load balance.
>>
>> This makes it not fight against the push task mechanism which happens
>> at tick. Also, this stops active balance to happen on non-preferred CPU
>> pulling the load.
>>
>> This means there is no load balancing if the task is pinned only to
>> non-preferred CPUs. They will continue to run where they were previously
>> running before the CPUs was marked as non-preferred.
>>
>> Bailout early for NEWIDLE and IDLE balance as load balancing is done
>> only on preferred CPUs.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   kernel/sched/fair.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index df8c9c2c7918..12f5b7de28d2 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -13399,7 +13399,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>   	};
>>   	bool need_unlock = false;
>>   
>> -	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
>> +	cpumask_and(cpus, sched_domain_span(sd), cpu_preferred_mask);
>>   
>>   	schedstat_inc(sd->lb_count[idle]);
>>   
>> @@ -14337,7 +14337,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
>>   			update_rq_clock(rq);
>>   			rq_unlock_irqrestore(rq, &rf);
>>   
>> -			if (flags & NOHZ_BALANCE_KICK)
>> +			if (flags & NOHZ_BALANCE_KICK &&
>> +			    cpu_preferred(balance_cpu))
>>   				sched_balance_domains(rq, CPU_IDLE);
> 
> Here you skip the sched_balance_domains() for idle non-preferred CPUs,
> which means you don't re-calculate the rq->next_balance.
> 
> In the following code, we update the global nohz.next_balance
> depending on the new rq->next_balance, which doesn't happen if
> the sched_balance_domains() is not invoked.
> 
> So, you propagate an already-expired per-CPU deadline back into the
> global NOHZ deadline. It may lead to unneeded asynchronous IPI in the
> nohz_balancer_kick() -> kick_ilb() path.
> 
> I think, you need another helper, something like:
> 
>          void sched_balance_domains(rq, idle)
>          {
>                  __sched_balance_domains(rq, idle);
>                  advance_rq_next_balance(rq, idle);
>          }
> 
> And then in the code above:
> 
>          if (flags & NOHZ_BALANCE_KICK) {
>                  if (cpu_preferred(balance_cpu))
>                          __sched_balance_domains(rq, CPU_IDLE);
> 
>                  advance_rq_next_balance(rq, idle);
>          }
> 

I looked more into it. Removing this check will solve it naturally.
This happens because:
- In sched_balance_rq - env->cpus is masked for preferred CPUs.
- In should_we_balance - fails since dst_cpu isn;t part of env->cpus.
- In sched_balance_domains - updates the rq->next_balance based on intervals.
So the above check is not needed. I will remove it.


While there, it makes me think it is probably a good idea to put check in
kick_ilb path in find_new_ilb. So that it find a idle CPU which is preferred. If all
idle CPUs are non-preferred then chose first idle cpu which is non-preferred such that
time elapsing still happens correctly. performance numbers are similar.

Something like below?
---

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 12f5b7de28d2..ccb18834fbfa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13964,6 +13964,7 @@ static inline int find_new_ilb(void)
  {
         int this_cpu = smp_processor_id();
         const struct cpumask *hk_mask;
+       int first_idle_cpu = -1;
         int ilb_cpu;
  
         hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
@@ -13972,11 +13973,16 @@ static inline int find_new_ilb(void)
                 if (ilb_cpu == this_cpu)
                         continue;
  
-               if (idle_cpu(ilb_cpu))
-                       return ilb_cpu;
+               if (idle_cpu(ilb_cpu)) {
+                       if (cpu_preferred(ilb_cpu))
+                               return ilb_cpu;
+
+                       if (first_idle_cpu == -1)
+                               first_idle_cpu = ilb_cpu;
+               }
         }
  
-       return -1;
+       return first_idle_cpu;
  }
  
  /*

