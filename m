Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372049;
	b=APGqHrv4yPfU2iGvMZfVt/r91CV0hMWgBP4ALPQJXwXL3yyJuPm8qvxYja2uka9JDBkZ
	 WrrOrMAOBvJdhgtJui47+omdIegGNVAsQBkeh1MsXPGmkiP4HUmcGRFimQzMmeWotJxHO
	 1q1XgsJ/4eC1uExxoEuviihTfJH0OYy9BxPVeNCvZoP49cRS0M9urjrUFuG/SGihWA4XQ
	 /gZ0KC2eoVa8hjRLgJeejObuXnA9921t932+qIDGHrYqXudgnTzMzhl/dO/f+hvn5mSFB
	 BLMDVWCB1P6Z2z5fcpDz/jXfKN9A+ocyjQ1QsSU4DU3TSvlZYnTjC3Huoxya74hbxVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372049;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=H9eLUfkkXk3rN8z33BkjptRVTbsFOrVizvCzkbGO2F4=;
	b=GJF+uXelWmuKKvEo8IGOWekUvi3NZcleTtO0kWLp8HvP226QOOvSv/MF2WEZpnk3fFme
	 HVHBrqmNVmylNv3BJzQsdIjm60k7pJjc4SbqFy5PPpGU+1hfYW1moBQuxdwXyQI1ahyg7
	 2eDvwXUdX2EklTLCBoBS+qWna4DePSCpCn7zN/Mg41vFIGYHT18RnD6Y8dH8lAFizJ/Tb
	 0UFNaPuSzJrFg4+sGM9Qk91k0tWFURpG5UVMQkYM6CijIZUzdB6MAQI1CeSEmhfsx8JAw
	 gCjdnf25QAj48vYb3oHVncRYzrK8o4K7/wKg3Q/bBAzzz7Xr128UozbxTFVQnVc0KuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LG5rx7k2;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0960A2604
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 14:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BA0960A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LG5rx7k2
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UEigKo2023720;
	Fri, 30 Oct 2026 14:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H9eLUf
	kkXk3rN8z33BkjptRVTbsFOrVizvCzkbGO2F4=; b=LG5rx7k2ZGi3UzhYmWiZhu
	EyT6ySS/ZxjEMgG7gjKFTgWqAa2Yro9evOiStnJmWPbwM6/8RLcRxVZKlD/XkMmG
	ixwo6FSUp3QozaRSZDBza8Tj+e6vUSZmu7yLkZ2POrQ1e6J31V3fuGuZoewuDFNU
	E57I33b8nlgyA9zZbxYl9vvAdwVnH7gTZ/yZCoSoRVJjA9Wt1+gBbxOQ4dOCgLvB
	PKSlx6WqMqsNccaqZwFtDaxnJ3uUl8N80hsk6FvfGbpvzDx7ln/VkuicEHxlbQ1K
	rL1GxxQSGzDynIBO1O+ABv9Kqnmo2564XEIa4U2aGZ9c/TU4i6jGF6aHvIFnAsrQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeayu89k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 14:53:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69UEnrS3673647;
	Fri, 30 Oct 2026 14:53:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pktqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 14:53:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69UErhZp30277974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Oct 2026 14:53:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A950320040;
	Fri, 30 Oct 2026 14:53:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94FDD2004B;
	Fri, 30 Oct 2026 14:53:35 +0000 (GMT)
Received: from [9.39.22.177] (unknown [9.39.22.177])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Oct 2026 14:53:35 +0000 (GMT)
Message-ID: <15083d2e-1c9f-4dad-816a-25cc2f3810b0@linux.ibm.com>
Date: Fri, 30 Oct 2026 20:23:34 +0530
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 04/13] cpumask: Introduce cpu_preferred_mask
To: Mete Durlu <meted@linux.ibm.com>, Yury Norov <ynorov@nvidia.com>
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
        virtualization@lists.linux.dev, sunlightlinux@gmail.com
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-5-sshegde@linux.ibm.com>
 <4605dad5-aab2-49e3-b919-bf9897181834@linux.ibm.com> <auN0GKVMNvXbNdCN@yury>
 <b83e2d2f-681d-4e19-a680-c076493b3edd@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <b83e2d2f-681d-4e19-a680-c076493b3edd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: zD7eqUoFVJX6qOWyoBOqTcljINbZh8Yk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX+OsVeVvUBuLP
 +kotTP+CNj8Mq8uADmGzUuBDJhK/UTwi175qFLQeUiFq1GqBit5zwImg4DfUbimsSg+RM4/0MK4
 BFdMuoyaiDQ8ZNc0mpoK6XjUK0DEpjs5Xd+ZK6Kcq18U4/eP9/cs5Yaqs2WqZtrzu2TtTFRJ7ra
 Nvp/e9Xqdk1FPfoxi0rcn5hWZfqizp9tpEQGAio+cWimQA6EVoVP9LhsHeNBBBosFZvyHcVjDpZ
 GgGp/oTZ8ImsZom58dt5WDhqrgQDPz0GS6gGPOTTdETfdZqx7HNgOGu31qmL9lHOZahYNaMlDc+
 htKmSLMubsG2y5F9Y4IQ6+t2g47RQpqNjLJHbUNUhwBngPSyl4QPtS0GKkASig8+xRUIF6kuyFC
 b7OuffOUPJa+CrSssjISvhi3SwmRiuxqX3RcDl6WYiNqWZv3fmJlto8a96qyb9lZIFw4Rj9Z56K
 9FW6BQs1ZjX+EusUhIQ==
X-Authority-Analysis: v=2.4 cv=Ms3HeGae c=1 sm=1 tr=0 ts=6ae4af7e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=E59y4fOkklvYIgKuzMwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX7nkNKVkVr8tJ
 /RPF/E2QmW/AQa/67zLfDZ7aipRcJLJYLmzEL37METL9n45XMtxgPSG68I97PRx96+7XjI9Ktuf
 WPFIGxLlg0rK5rxr5v8Rq5Z60BITo3o=
X-Proofpoint-ORIG-GUID: L-bQG4I8V72p5Lz-1R7e8SLFZACiUwJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300058

Hi Mete, Yury,

On 10/29/26 10:06 PM, Mete Durlu wrote:
> On 29/10/2026 17:28, Yury Norov wrote:
>> On Thu, Oct 29, 2026 at 02:32:08PM +0100, Mete Durlu wrote:
>>> On 28/09/2026 07:37, Shrikanth Hegde wrote:
>>>> Provide the preferred CPU infrastructure. Define get/set macros
>>>> which could be used to get/set CPU state as preferred.
>>>>
>>>> CONFIG_PREFERRED_CPU will be selected by the driver which handles
>>>> steal time values. It is going to set/clear preferred CPU state.
>>>> This driver will be called steal_governor and it is introduced in
>>>> subsequent patches. It periodically computes the steal ratio and
>>>> decides on preferred CPU state.
>>>>
>>>> A CPU is set to preferred when it becomes active. Later it may be
>>>> marked as non-preferred depending on steal ratio by the steal_governor.
>>>>
>>>> Always maintain design construct of preferred is subset of active.
>>>> i.e. preferred ⊆ active ⊆ online ⊆ present ⊆ possible
>>>>
>>>> With CONFIG_PREFERRED_CPU=n, ensure set_cpu_preferred is a nop and get
>>>> method returns the active state in that case.
>>>>
>>>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>>> ---
>>>>    include/linux/cpumask.h | 24 ++++++++++++++++++++++++
>>>>    kernel/Kconfig.preempt  |  4 ++++
>>>>    kernel/cpu.c            |  6 ++++++
>>>>    kernel/sched/core.c     |  5 +++++
>>>>    4 files changed, 39 insertions(+)
>>>
>>> [..snip..]
>>>
>>>>    #define cpu_is_offline(cpu)    unlikely(!cpu_online(cpu))
>>>> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
>>>> index 985aea617cfe..edc067a0c422 100644
>>>> --- a/kernel/Kconfig.preempt
>>>> +++ b/kernel/Kconfig.preempt
>>>> @@ -194,3 +194,7 @@ config SCHED_CLASS_EXT
>>>>          For more information:
>>>>            Documentation/scheduler/sched-ext.rst
>>>>            https://github.com/sched-ext/scx
>>>> +
>>>> +config PREFERRED_CPU
>>>> +    bool
>>>> +    depends on SMP && PARAVIRT
>>> FWICT, PREFERRED_CPU mechanism can work perfectly fine without PARAVIRT
>>> selected. It would be annoying to enable it and implement a dummy
>>> paravirt_steal_clock() just for that.
>>>
>>> Shrikanth, would it be possible to drop that dependency?
>>
>> Do you have a non-paravirt case in mind?
> 
> s390 LPARs are exactly that. s390 does not select PARAVIRT by default
> but enabling PREFERRED_CPU is strongly considered.

s390 may not have PARAVIRT=y, but this use case is still a virtualizated system no?
i.e you are observing steal time. By definition of steal time, it is a para-
virtualized system. Though you may be deriving the steal time not using the
paravirt_steal_clock.

Or my understanding here is wrong?

> 
> I removed the PARAVIRT dependency and gave the whole thing a quick
> spin. Builds and functions w/o any issues on s390!
>> I'm actually about to submit an RFC that drops the PARAVIRT dependency
>> and provides write access to the preferred mask. But I want to make
>> sure that we need it, and we've got no reasonable mechanism to put
>> unneeded CPUs on idle already.
> 

We might run into few corner cases quickly with write allowed.
But yes, this is a simpler mechanism not to run anything on few CPUs
in a dynamic way.

> You can mention s390 LPARs as valid case on your RFC if need be.
> Thank you!
> 

