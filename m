Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291839;
	b=bVx3E7nK/MTQsNfxBiq7OmpTn4u7nzdDnI6L5naITXurKkxMuPFUy8wdDnT08tUVfZjE
	 jbJl2s7GGiEkOrF99Ex/VB5VBk9SC2Nw/4wtpNJV1NBnpb47s2wKBkeEiNsZsc+Xj4uyO
	 /XUOPsYcVwZw4bC5KL1s3ad3dTkIEFjSnA6aR0JRuV9rDNaIh9wCHtLeJC5R5FxX4/+7a
	 hNm6BKTybdnWRu9fX+RqO/XbN21qJ0eg6ORurFt1lzKUsZ8pk9deH3lj95y3z8CPNchjk
	 ABn8urEsGvmojSsQo2duRmFtrtCXprjCyAkeRjbv5FN/b7ijSm0jh1BwkVcSZPiqCtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291839;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CZ8plerL2syrMlfnumjH2jJdKKGHOC/035TXmxh2S2I=;
	b=iT7Qv2cprAOmgH/W48OXWMLIK1eFp6f+wDwNoK9yonrR7SJOhM2hSpBp8N3rg5FQptOM
	 Dz7nYAO1impL1wf+z2hfH9r3DcfPdnsmYlZyyDGsAoBlYFNOWCRNaRCEOx2FyJks4ZwQH
	 f4yaKcZmxD+pg0hy5kUhxUAtq7G1ij0DJWT45HYS1aYTaOK6PQDsuwqGjYepYfV/5rkkG
	 5V9VEGoDyAl6yfYDWsCH4zCXSq9p67RlW7DFKpTD2DdexzhpHPTU1eX4Zev10GpRqx5y4
	 4r7SGNLT/SEwUI+n/9jb/tIuT7xVjHsvRzx65lMjDaKMl8hyVpo/ZZOVp/Iw7NCwLsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nCGH2zWV;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32B606A31D
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 16:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D32B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nCGH2zWV
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGEBEr3505090;
	Thu, 29 Oct 2026 16:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CZ8ple
	rL2syrMlfnumjH2jJdKKGHOC/035TXmxh2S2I=; b=nCGH2zWVl/QFsd6CvM+af8
	A3chTRPpnZpiID2fFo8Pnr6pmnQni8LmJgPLkKkuQ5iPEEDbObktE3FRH8U6yBXU
	AI0tqR5nLc7tYzkqpFYvPOT3fBHd7oPLYTvzqAaadYVlUdqUlCNmj6nEfcOi/YOq
	3PkQqz1n210WhlgucoJUn6YyLW+V/O/+fFn8ojfo2Pg28r+0GsAZNQ9r6qTrVkQ8
	MuR0ntWvM60rHaEbUCr6i0Xp5zx5p8KF8uoTmPW0dXubd/LDjKy2ynkvNR0Z7ZE+
	fLIkOCzxxzJ6fntYhSL2VSGY7E4MuoihUsvpnTAf0y/LMCGCW8J2+i9biqIkGxVA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3gb89c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:36:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGJtve2213552;
	Thu, 29 Oct 2026 16:36:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010s3mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 16:36:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TGaYp845285848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 16:36:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49A242004F;
	Thu, 29 Oct 2026 16:36:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF8CC2004B;
	Thu, 29 Oct 2026 16:36:29 +0000 (GMT)
Received: from [9.87.137.195] (unknown [9.87.137.195])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 16:36:29 +0000 (GMT)
Message-ID: <b83e2d2f-681d-4e19-a680-c076493b3edd@linux.ibm.com>
Date: Thu, 29 Oct 2026 17:36:28 +0100
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
To: Yury Norov <ynorov@nvidia.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, yury.norov@gmail.com,
        kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
        tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
        seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, maddy@linux.ibm.com,
        srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
        vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
        pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
        tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
        rdunlap@infradead.org, kernellwp@gmail.com, linux-doc@vger.kernel.org,
        jgross@suse.com, virtualization@lists.linux.dev,
        sunlightlinux@gmail.com
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-5-sshegde@linux.ibm.com>
 <4605dad5-aab2-49e3-b919-bf9897181834@linux.ibm.com> <auN0GKVMNvXbNdCN@yury>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <auN0GKVMNvXbNdCN@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 9lqEBvvs7gzC6DkqD5lU8d1OxFLpQkgh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MyBTYWx0ZWRfX6WBcxdgMKUDo
 h37iJT9VaH2+Fmruih3d4KNT0Zga7F3Gibbjuh0KNOmbApUASxzZtRvpEpTlpgg+eyIz2i6hfEb
 XghuijwKrgEm2i4mYxCZZWZpA3l4aW/5indrmbiHu7bK1EQtbBNbl0rQXU9BmTZT65O1Vt48LXa
 Z5O0sqvTZnfQXdETjBBW+cn0FTr0I1863s+Kgky6OReCDmCkSNQunhhngLEDh+GiAnbUOsXdtB3
 pnwpoDCDu0ehYRZFK1eqsBw6eYapRfBdJAJtG5wfP31DRwloUIFnw+DLAlRXl2xTuPKflSvRSeZ
 fGiYUuNbLk/9+pxLDAmv2fHKjIbcANeX5RgRuSgfeXjzclxpVPuEsVpK1ni0gK3d4+KikV3BSl/
 9BcKG7SwDFL4o3Ndh70ey3WVua/rhw==
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae37617 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=PUpFx_WVMNND69PTjbIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uH0D07jxJuGJFGnKTapMZ_5XyfkvOLip
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MyBTYWx0ZWRfX6XDD5fdTB6UU
 cs7G/bBoZ1HXKQ0mH4vrVLQZ5GfhU6ZjpKzHByV1hGfwOTgPNBjX4/rAzvVk5p4xN6MpEvRb3p9
 PgekaDfWJI62/C+qhhptARwaIiMhZbM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290063

On 29/10/2026 17:28, Yury Norov wrote:
> On Thu, Oct 29, 2026 at 02:32:08PM +0100, Mete Durlu wrote:
>> On 28/09/2026 07:37, Shrikanth Hegde wrote:
>>> Provide the preferred CPU infrastructure. Define get/set macros
>>> which could be used to get/set CPU state as preferred.
>>>
>>> CONFIG_PREFERRED_CPU will be selected by the driver which handles
>>> steal time values. It is going to set/clear preferred CPU state.
>>> This driver will be called steal_governor and it is introduced in
>>> subsequent patches. It periodically computes the steal ratio and
>>> decides on preferred CPU state.
>>>
>>> A CPU is set to preferred when it becomes active. Later it may be
>>> marked as non-preferred depending on steal ratio by the steal_governor.
>>>
>>> Always maintain design construct of preferred is subset of active.
>>> i.e. preferred ⊆ active ⊆ online ⊆ present ⊆ possible
>>>
>>> With CONFIG_PREFERRED_CPU=n, ensure set_cpu_preferred is a nop and get
>>> method returns the active state in that case.
>>>
>>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>> ---
>>>    include/linux/cpumask.h | 24 ++++++++++++++++++++++++
>>>    kernel/Kconfig.preempt  |  4 ++++
>>>    kernel/cpu.c            |  6 ++++++
>>>    kernel/sched/core.c     |  5 +++++
>>>    4 files changed, 39 insertions(+)
>>
>> [..snip..]
>>
>>>    #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
>>> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
>>> index 985aea617cfe..edc067a0c422 100644
>>> --- a/kernel/Kconfig.preempt
>>> +++ b/kernel/Kconfig.preempt
>>> @@ -194,3 +194,7 @@ config SCHED_CLASS_EXT
>>>    	  For more information:
>>>    	    Documentation/scheduler/sched-ext.rst
>>>    	    https://github.com/sched-ext/scx
>>> +
>>> +config PREFERRED_CPU
>>> +	bool
>>> +	depends on SMP && PARAVIRT
>> FWICT, PREFERRED_CPU mechanism can work perfectly fine without PARAVIRT
>> selected. It would be annoying to enable it and implement a dummy
>> paravirt_steal_clock() just for that.
>>
>> Shrikanth, would it be possible to drop that dependency?
> 
> Do you have a non-paravirt case in mind?

s390 LPARs are exactly that. s390 does not select PARAVIRT by default
but enabling PREFERRED_CPU is strongly considered.

I removed the PARAVIRT dependency and gave the whole thing a quick
spin. Builds and functions w/o any issues on s390!
> I'm actually about to submit an RFC that drops the PARAVIRT dependency
> and provides write access to the preferred mask. But I want to make
> sure that we need it, and we've got no reasonable mechanism to put
> unneeded CPUs on idle already.

You can mention s390 LPARs as valid case on your RFC if need be.
Thank you!

