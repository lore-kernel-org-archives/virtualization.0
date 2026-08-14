Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D1645A285
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705783; cv=none; b=pU08PBotqlVku6Rol/0UKW06fuSNuAdJ+7LZhXkqbIB2iIdSYWvzoaIytXiY3G/DhmlzlJNxlVlQ1x2UMII4CyreASyReq1bSA5FRA0nIY2PjEedCV0J2423U0dLejC4Vn726JRayWnmJ9o36A24Gko1b6ciRkVwD3jue6nJMSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705783; c=relaxed/simple;
	bh=8gC49fhOs/Y6E3C/jTySXcFFoYnfoSiZA2pNDN0JBtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8+xhNpeFKemdq9Au597IMyucQyfvJsGK1FDBZmZUuM4AwsEN0w14L3DDxVJR9uZBQzJrsTsNUp8B2BalmWFEdlvy27BRWJZiH2FGxky2q4JOesASxN8VGj+rrgRwgPLD74KQiN1UFRp6IALNFdY2aPOvtsdIAWUTNz0rhwEyR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O3k+yD/T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O3k+yD/T"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB1bVG956491;
	Fri, 14 Aug 2026 11:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OGjN6K
	tvoiJiQnnQbwyMjCSC3X9A0IR2CH8QSd+zQ3w=; b=O3k+yD/T2rvCm9CG+6rLxC
	f09EVLSPF8bubGM6+we0LYILmy0PB6P3LjBUhhSRUO02WUnN6n0riMrYiPqoH/qA
	dSgdPuNonKq0qCzQ6WAc9zgCwBDdzFBOf+DyhI4NNWmw9Ez4Nra1ryujfJKB6fMR
	IgxOd5D4d7QLHkPiQQE3HOldXCv0tJezwXyKGbYkil/VxMWcODBTRgYPLcm4BkDe
	7ifHmy0Zs56BTK7nIbrjV1+MnIih0BIVpfFcWFbqPoClCnzELOV2KPt2VtIsAU3R
	+LgsioEVoSp6O5Oz1n3bKWgdPESBrDZuupsXsr7hF0pH+k36tsKh6m2zfy0rI8Bw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma4h78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 11:09:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EAuP24016829;
	Fri, 14 Aug 2026 11:09:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hey25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 11:09:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EB97JF42271168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 11:09:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D8A52004E;
	Fri, 14 Aug 2026 11:09:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DF9420040;
	Fri, 14 Aug 2026 11:08:59 +0000 (GMT)
Received: from [9.124.210.249] (unknown [9.124.210.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 11:08:58 +0000 (GMT)
Message-ID: <78ded4e9-d771-40a0-b28c-3ec984f6b5d0@linux.ibm.com>
Date: Fri, 14 Aug 2026 16:38:58 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Re: [PATCH v10 00/12] sched, steal_governor: Introduce
 preferred CPUs and steal-driven vCPU backoff
To: Mete Durlu <meted@linux.ibm.com>, Yury Norov <ynorov@nvidia.com>,
        "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Cc: arighi@nvidia.com, chleroy@kernel.org, christian.loehle@arm.com,
        corbet@lwn.net, dietmar.eggemann@arm.com, gregkh@linuxfoundation.org,
        hdanton@sina.com, huschle@linux.ibm.com, iii@linux.ibm.com,
        jgross@suse.com, juri.lelli@redhat.com, kernellwp@gmail.com,
        kprateek.nayak@amd.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com, maz@kernel.org,
        mingo@kernel.org, pauld@redhat.com, pbonzini@redhat.com,
        peterz@infradead.org, rafael@kernel.org, rdunlap@infradead.org,
        rostedt@goodmis.org, seanjc@google.com, tglx@kernel.org, tj@kernel.org,
        tommaso.cucinotta@gmail.com, vincent.guittot@linaro.org,
        vineeth@bitbyteword.org, virtualization@lists.linux.dev,
        vschneid@redhat.com, yury.norov@gmail.com, frederic@kernel.org
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
 <20260812194600.52516-1-sunlightlinux@gmail.com> <an0MMNBkyeeZEa8f@yury>
 <a4478425-1914-47d1-b5ec-5e11dba048dd@linux.ibm.com>
 <20aa609c-6b11-41a1-875e-3aaba2809883@linux.ibm.com>
 <3668e964-4605-43e6-b528-07aa74dc231e@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <3668e964-4605-43e6-b528-07aa74dc231e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4MyBTYWx0ZWRfX52l32pcpBtte
 5eNE8GsS6YDtxvTpRxHLReElEfUDLRLJ+Mb8Sq7TflH6WqY4kSevkBkMFUUis60gHtKXzhBJnV2
 J/2acrOf7GrmM4DBxn0/uKE7JO9WfIbxj7s3DzCltv1MKHQEkYdSqt1R6MoKu14SZDkGoNekqVd
 YgTY6XYuGRDwkVsG0CKD7nBfQOd3HozJo30BhSwCDFE40QnzmngAHyahLJC/pwWvVSG6H/1XFtw
 YrqyLKNiKi168H53VnOhmlyD5dqh4E2cl5tWVR95B86X3lsJujQAJe/ZSMPm4g0CZNi8ZNZWGic
 IeZar2pm9nYtszc2oLDZnsqxr8XRJO/W0YYKnf2rryyayq/w14dUAkyFioaXuwi3b17DxmoN/Hs
 GcFcCkILUkU299sju8CH3oa9kpUMO7lu2XyBc5ZZV2YCzklubhx7t49jtvoLuShH3wS9muCpdih
 4QQ2w+WvBnK7kD/W1CQ==
X-Proofpoint-ORIG-GUID: pdqfbQFSZg1dg3Ai7wf3-Gy4Q0PB4tij
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4MyBTYWx0ZWRfX8/onPxoy5UYg
 gHX75sUAeY3OCm5vX4ZFpriOkvs6beqNdWMo/FMpU6E1CYBCHKTNyonhzg+5cNW5eRLeTER6mr3
 FKtNU8MxLJjG96N2/nci9i9fROYrCZ8=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7ef759 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=n9_rAbJGXIc-qClgv6MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OKNvbkaBH1lBUQVXIIFRA_lG2AM1nKzO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140083

Hi Mete,

On 8/14/26 2:52 PM, Mete Durlu wrote:
> On 13/08/2026 13:12, Shrikanth Hegde wrote:
>> Hi Mete, Thanks for going through the patches/discussions.
>>
>> On 8/13/26 12:20 PM, Mete Durlu wrote:
> 
> ...
> 
>>>
>>> I think all of these points can be addressed better if
>>> Xen used said framework and implemented their own governor
>>> module. That way we wouldn't see an overinflated single
>>> steal_governor but instead nicely separated arch/platform
>>> specific ones, that are tailored best for their needs.
>>> The current implementation could be the fallback option
>>> if platform does not implement their own and would also
>>> serve as an example.
>>
>> For now, I prefer adding a defensive check for dom0
>> and keep the driver simple.
> 
> Fair enough.
> 
> ...
>> I prefer we defer the arch specific hooks for now, until there is a 
>> need for one. If you guys insist it should be done, then i can start 
>> looking at cpuidle framework. But it will be a bigger rework.
> 
> s390 plans to adopt and start using the preferred CPU approach along

That's nice. I am happy to hear that it will come in soon.

> with the governor. The concern is that there are some enhancements
> planned which would not really fit into the current governor.
> 

> Later on, s390 will probably introduce its own governor module and
> for that I was hoping that there would be a framework similar to
> cpuidle drivers.
> 


I was skimming through cpuidle logic. The problem with steal_governor is that,
it is not a built in module. For loadable modules, core_initcall and
device_initcall will evaluate to the same thing,
which makes a direct cpuidle-like approach tricky.

However, as you mentioned, we just need a common infrastructure for the
init/exit/methods leaving the decision-making to the arch.
I've thought of a few ways we can cleanly pull this off post-merge:

1. ifdefs and ops function pointers:
   We define a struct of function pointers and a bit ifdefs for init etc.
   The core initializes ops to default or s390 depending on the config.

2. __weak Functions:
   We define the main routines as __weak and let s390 simply override them.
   This is the lowest boilerplate, though its usage is not preferred.

3. Multiple Modules (The cpuidle module approach):
   We split it into steal_governor_core.ko and steal_governor_s390.ko.
   The core exports a steal_governor_register_driver() symbol, and the
   s390 module registers its specific ops when loaded.
   However, this would still need elements of the first approach to
   handle Dom0-like cases natively.

Depending on users and adoption of the feature by different archs,
we can go about it which is more appropriate.


> What I mean essentially is a common infrastructure to initialize
> the basics required for the preferred CPUs management and maybe
> the update loop mechanism. That should ideally leave just the
> decision making part to the individual arch/platform to implement.
> I imagine the whole thing being much more simpler than cpuidle
> drivers as it had a lot more moving parts involved.
> 
> ...
> 
>> If the driver eventually outgrows a single file, we can work on a 
>> modular framework post-merge. But for now, let's keep it simple and 
>> get the simple version upstream.
> 
> I understand the concern and I think it's the right approach to keep
> it simple initially.

Thanks. Yes. Lets keep it simple for now.

Once this series is merged, We can work out the
framework for s390-specific enhancements.

> 
> Thank you!
> 

PS: I will wait for few days to hear from Ionut/Yury on the patch addressing
all the comments. If i don't hear anything back, i will post v11 next week.
