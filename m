Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D326ED59
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699402; cv=none; b=OnLa2146B/4+u94Qilf2kj6BqalnpOcUZkgxBVSqbbfImHZxLWYvsOh9yjupTjIZYJaDwXFG6ZdzZBUVJxGabYJc2NfBYy9q7xTU/8Yq5Hc70j9SSw2jtW3mXANt/vq/7HVIedxJEbfo7FJ00jH7Aj+2MHMKwQUsOAgjT3B4uRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699402; c=relaxed/simple;
	bh=3YU1+xVRfKx5qBRIcphqt7A1+Xw00RyfTPyo5Z3oZ0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jwaf3lJqDnWNe0NmBBZSx3YZViTUWZY7WBgi026t5iIT8pPaDEpYA5yk+5c67SAmoAAajUdG6YaNIhrod8Dqe0LuOkk6BA4VexKjn5L429LUla95jz1iNtJH6tPR1d71n5oNTe7mYe/yddJoGkk1+2pgQLcQIlhvajO5nXxqyqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O9pkMVva; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O9pkMVva"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E81cCX3666516;
	Fri, 14 Aug 2026 09:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5S4LWf
	ZTljW0+6S8xXzRv4HO9XntKLgDkWOhhWJKADU=; b=O9pkMVvaulDiTm9mA/YcHb
	c5dGpdlAJeODI/wtrw+uNnny4K8Qydk3/CWS4GUxSYiZIUN8KD/03wUNMcHWpyok
	+Su4T8cgDb/29/+Aa05TpkswdBfyQTORXdxb+dabkiZAtsEm/zbFQ+GOZSB1o+tE
	gKSivSL6Ghh5rEaBKUW01JgGxlmarVfcGy+qaB6FKS4lj6dMVLpqS6XVyt8c+Zru
	f2IZX/oB7o3WoQtBw/NPz90AcIDz7giC+SCRaM3MPf3gSvZwI5CJYXYPAcZGQkRA
	quk4IqM0sRjBUm8RvXIM+ppuJLP6ZNYqrBLbrZLHp4fycqlsqHX9PjsDvXSMZrzw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb244at4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 09:23:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E9BUHB006650;
	Fri, 14 Aug 2026 09:22:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpv9ex4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 09:22:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E9MtUk42402254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 09:22:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F9C120040;
	Fri, 14 Aug 2026 09:22:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4683D20043;
	Fri, 14 Aug 2026 09:22:54 +0000 (GMT)
Received: from [9.87.144.6] (unknown [9.87.144.6])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 09:22:54 +0000 (GMT)
Message-ID: <3668e964-4605-43e6-b528-07aa74dc231e@linux.ibm.com>
Date: Fri, 14 Aug 2026 11:22:53 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Re: [PATCH v10 00/12] sched, steal_governor: Introduce
 preferred CPUs and steal-driven vCPU backoff
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Yury Norov <ynorov@nvidia.com>,
        "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>,
        frederic@kernel.org
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
        vschneid@redhat.com, yury.norov@gmail.com
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
 <20260812194600.52516-1-sunlightlinux@gmail.com> <an0MMNBkyeeZEa8f@yury>
 <a4478425-1914-47d1-b5ec-5e11dba048dd@linux.ibm.com>
 <20aa609c-6b11-41a1-875e-3aaba2809883@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20aa609c-6b11-41a1-875e-3aaba2809883@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7ede75 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=LadJ6kx9KbSmSrQeYN8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2OCBTYWx0ZWRfX3I0IpsQCL+Rq
 wIN1DDX3LUgQ8E/FeCFdcHZyYNjonWdXY9VKcCmeqj7dkqIYADl0sBMH3WOCaqdjM8txSjU9JYk
 b+8Zowd0NCpHrZLYEpSArWYVjaPQcmQdtRHyHG2M3aHLC74N3482sXcWg2Lz/ciPVMQVvpqvLYN
 EAKoBeX3oIRFbKB8N7Lxrcitw8FEbSv6aQPDSSnw+H9J9tRMPqk9d7yvQj7xndBkIdm6RYRgeYs
 72Kl+CN+KFX9A2+8FvpYefXOekMaSqVvww4EriRezX+tC+hBpcqvNkYdzuX8Sou7haalE+X+LJN
 WhznXOwQyr0EfjwQBUbApmC2mawxxnfKzcqVQBgR4QnjRWPjbuwSdaUjKurP1YLYYNlLOAd7PZu
 jll/oLMssS3C5PxSQUBDIQum4XHgqGvEyIG5d68SrOURcih85FY0lRYvd/CDgOttj6qwGnfovTZ
 N/+rmQZ0LDcMFZW0AcQ==
X-Proofpoint-ORIG-GUID: OSaUYcjHR2WmtNLQ5HhOmOKecKIbLBzd
X-Proofpoint-GUID: EHV-i2egFJe0awM3-d7NKMToDbWtAdK0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2OCBTYWx0ZWRfXyfuVV8UXODpN
 lyFOfvwT3Zwq2DgGDr0KYPPt1wIrPJYToWL14kyHLiRxb/h52YgGpM8j24+qSs+OR249J5bIgfH
 diOKvT/1/YzXpq71lWKErPEpBAuAD8U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140068

On 13/08/2026 13:12, Shrikanth Hegde wrote:
> Hi Mete, Thanks for going through the patches/discussions.
> 
> On 8/13/26 12:20 PM, Mete Durlu wrote:

...

>>
>> I think all of these points can be addressed better if
>> Xen used said framework and implemented their own governor
>> module. That way we wouldn't see an overinflated single
>> steal_governor but instead nicely separated arch/platform
>> specific ones, that are tailored best for their needs.
>> The current implementation could be the fallback option
>> if platform does not implement their own and would also
>> serve as an example.
> 
> For now, I prefer adding a defensive check for dom0
> and keep the driver simple.

Fair enough.

...
> I prefer we defer the arch specific hooks for now, until there is a need 
> for one. If you guys insist it should be done, then i can start looking 
> at cpuidle framework. But it will be a bigger rework.

s390 plans to adopt and start using the preferred CPU approach along
with the governor. The concern is that there are some enhancements
planned which would not really fit into the current governor.

Later on, s390 will probably introduce its own governor module and
for that I was hoping that there would be a framework similar to
cpuidle drivers.

What I mean essentially is a common infrastructure to initialize
the basics required for the preferred CPUs management and maybe
the update loop mechanism. That should ideally leave just the
decision making part to the individual arch/platform to implement.
I imagine the whole thing being much more simpler than cpuidle
drivers as it had a lot more moving parts involved.

...

> If the driver eventually outgrows a single file, we can work on a 
> modular framework post-merge. But for now, let's keep it simple and get 
> the simple version upstream.

I understand the concern and I think it's the right approach to keep
it simple initially.

Thank you!

