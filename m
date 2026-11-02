Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606494;
	b=V7mLTJ1olKWBtXPiATJhsZb43BCA/UMFUcoVF3gkab1Z+3X6MPp999RzAZ0f+XnzBZK0
	 afwF6JYajk3mPJRCFotMn/JLOIPbqmY/qf36uAznUrW2Mm/8lBdIAkAb+kacCYc0PTjNC
	 GDmszBjOL976nkl1unF83nvhSiN54sXcIbnAXNI7Mnc5qS0USw+cjfD0U1VNTwAkBOsKT
	 kM+lGZjmdPrHGNcmVyvg0rFo2XJmsoR4Zui88W5gcZ3S6M2kvzBTJebOTGfBEbDIOXn/d
	 gvZ0iBR53OyeQnwl7Ikun9TooSET4LgGQViloFDciXaZmlYYynww5ytEh5js+WfwCEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606494;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HBnD11gMSZpLVfr+vR9u0GimaEXWjeLtUh8hd5opuf4=;
	b=5sSowSP9lyg4mWqvRNUe1XXkTg1Xccy2nsDYvqnviWlSzMrd/sD07QA8WhXQbzYm02pS
	 dn/27vribM4Suj94hvXLsOtWPt9inHN68vjyMG1wppCuiVOPgR8sm9hwMQHp+OxypmIcB
	 fqXM3nOx7mYpjzz0qXZ4HilsGpO0GqhiaR+BeOYdCxPN+aOVRbcrPSF7CXGuzpY+OYXd3
	 cQteE0xrNw1XkMOF7xqMJiCweVkcgHjibLUc0c4+DdTPyOJ42cTKuf1oApPIknErRvYgZ
	 bGiNpc7f3xBgluNkDCjOGXBuYom0i1mFQf/oViGHZ5VBi8liQF1+bcak2UUeDYg3jrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GVi985Fx;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7481606A324
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 08:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7481606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GVi985Fx
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A24EBHK1895532;
	Mon, 2 Nov 2026 08:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HBnD11
	gMSZpLVfr+vR9u0GimaEXWjeLtUh8hd5opuf4=; b=GVi985Fx81FXaLN/zhVL8E
	67lr+VFKj8a4CAVz80ht3+ABtWxDiKRSwvbaNznYCs7/8z8HpkHJETPyEPn6uAvK
	LhTxLukt6QE43gF+ut2DZ+nwW91AiZsfbhvGMQJLsDRZeMS2vawEhCVNdSUIk7kT
	HvqR5M0SGlrJDEppmB/ShTqq5aoUoJl13ns1YfYzdE2PTIYJS2+WG52/nlncaXFu
	W4ksiidEKuafaB4afFQ38V3omT1u+96wiRcbDEBDNDGiz9AbJkdYh/tGJfy3PvHc
	UFGqoD2ADRvb1q+7lGo8u01QTMjZcGqZsP4qeNpTNPS+P6KZ19CugbELrjiEIvNg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yrqa9w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 08:00:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A280NPN394430;
	Mon, 2 Nov 2026 08:00:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnwbxvkpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 08:00:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A280ghv49283404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 08:00:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3222420049;
	Mon,  2 Nov 2026 08:00:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1026520040;
	Mon,  2 Nov 2026 08:00:41 +0000 (GMT)
Received: from [9.111.42.133] (unknown [9.111.42.133])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 08:00:40 +0000 (GMT)
Message-ID: <62c7faba-3f9a-4ab8-a3b2-dce4f748cff7@linux.ibm.com>
Date: Mon, 2 Nov 2026 09:00:40 +0100
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
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Yury Norov <ynorov@nvidia.com>
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
 <15083d2e-1c9f-4dad-816a-25cc2f3810b0@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <15083d2e-1c9f-4dad-816a-25cc2f3810b0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6ae84330 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=cLjWqlLnyS6TRyV_P9wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMCBTYWx0ZWRfXxc13DqFV7AON
 iE1R7zP+9t82qywmbI1AiMPzcm3Mnh/0qfdZ13fEwNU21swUrBAiCap0EQTJGXGh+vj04pXCplE
 RTZEmvmLcYk2CyeSsfIk3v0pd89V3I4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMCBTYWx0ZWRfX6r3qhuOgUIiW
 BrZWH8aCRIEmtFLzolcE3ed8rArIUROlGKFh8344mFHYCNCi6qyLT8S6q9ZikaX0qMo5ikOwfAN
 E8IlrAj4Yu41zIvVIt177dJexvaF6uNMyPYpIEnuDNYXogENgsSVUbumurdUhqnS5jAa0d/m1Nz
 guBAsFHVCUtuik3ARxFFlvgmfgo9+XzaBwrlgPSaw4tEeNwJFUw3HgJYXzWVSHfKjYes0Z7ewWL
 PqFeaJx//byaTWrBg9tl2LTn1W96xF8Opv0MRALUCw9XJL4gF0Bvd1lVq9nB2WhpYFTdnFoLf4c
 qo3lf2MEwkLeCsFJ0w82kXi/WA2DZGjk0cQs5uxiBHxzxi6GE9BhwTBZLBNqijA9u1Mv2CVYmTF
 KoY30WRynrv837PdyfR+hGEiDrAHzPfiBV2bzyzNcDfONG9z1bAMbRemiUTuk9xVlPl7GYIwJvj
 BSM/6ajTWXxUMnGqPiQ==
X-Proofpoint-GUID: diq5pX26PNT8Bm1BrVRQ0Sx0Cm9WmTwW
X-Proofpoint-ORIG-GUID: q2xB-e3zYjJaIp0j0NLZWRkX-ciZF6xG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020030

On 30/10/2026 15:53, Shrikanth Hegde wrote:
> Hi Mete, Yury,
> 
> On 10/29/26 10:06 PM, Mete Durlu wrote:
>> On 29/10/2026 17:28, Yury Norov wrote:
>>> On Thu, Oct 29, 2026 at 02:32:08PM +0100, Mete Durlu wrote:
>>>> On 28/09/2026 07:37, Shrikanth Hegde wrote:
>>>>> Provide the preferred CPU infrastructure. Define get/set macros
>>>>> which could be used to get/set CPU state as preferred.
>>>>>
>>>>> CONFIG_PREFERRED_CPU will be selected by the driver which handles
>>>>> steal time values. It is going to set/clear preferred CPU state.
>>>>> This driver will be called steal_governor and it is introduced in
>>>>> subsequent patches. It periodically computes the steal ratio and
>>>>> decides on preferred CPU state.
>>>>>
>>>>> A CPU is set to preferred when it becomes active. Later it may be
>>>>> marked as non-preferred depending on steal ratio by the 
>>>>> steal_governor.
>>>>>
>>>>> Always maintain design construct of preferred is subset of active.
>>>>> i.e. preferred ⊆ active ⊆ online ⊆ present ⊆ possible
>>>>>
>>>>> With CONFIG_PREFERRED_CPU=n, ensure set_cpu_preferred is a nop and get
>>>>> method returns the active state in that case.
>>>>>
>>>>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>>>> ---
>>>>>    include/linux/cpumask.h | 24 ++++++++++++++++++++++++
>>>>>    kernel/Kconfig.preempt  |  4 ++++
>>>>>    kernel/cpu.c            |  6 ++++++
>>>>>    kernel/sched/core.c     |  5 +++++
>>>>>    4 files changed, 39 insertions(+)
>>>>
>>>> [..snip..]
>>>>
>>>>>    #define cpu_is_offline(cpu)    unlikely(!cpu_online(cpu))
>>>>> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
>>>>> index 985aea617cfe..edc067a0c422 100644
>>>>> --- a/kernel/Kconfig.preempt
>>>>> +++ b/kernel/Kconfig.preempt
>>>>> @@ -194,3 +194,7 @@ config SCHED_CLASS_EXT
>>>>>          For more information:
>>>>>            Documentation/scheduler/sched-ext.rst
>>>>>            https://github.com/sched-ext/scx
>>>>> +
>>>>> +config PREFERRED_CPU
>>>>> +    bool
>>>>> +    depends on SMP && PARAVIRT
>>>> FWICT, PREFERRED_CPU mechanism can work perfectly fine without PARAVIRT
>>>> selected. It would be annoying to enable it and implement a dummy
>>>> paravirt_steal_clock() just for that.
>>>>
>>>> Shrikanth, would it be possible to drop that dependency?
>>>
>>> Do you have a non-paravirt case in mind?
>>
>> s390 LPARs are exactly that. s390 does not select PARAVIRT by default
>> but enabling PREFERRED_CPU is strongly considered.
> 
> s390 may not have PARAVIRT=y, but this use case is still a virtualizated 
> system no?

Yes, it is virtualized.

> i.e you are observing steal time. By definition of steal time, it is a 
> para-
> virtualized system. Though you may be deriving the steal time not using the
> paravirt_steal_clock.
> 
> Or my understanding here is wrong?
> 
So you propose s390 to enable CONFIG_PARAVIRT *just because* s390
fits the "paravirtualized system" definition, even if s390 would not
utilize any functionality comes with the config option? (even worse
it comes with deadcode...)

That sounds a bit wrong to me, I would really like to avoid
enabling a config option just because it's name suggests that
it is related to our platform.

Yury already sent the patch series he mentioned. I suppose we should
keep discussing this there.

Thank you!
-Mete
