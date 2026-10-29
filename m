Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280757;
	b=AN8RatUtHBX0lzytIxVoM9i4iH5bAko1cXgrurYNUzUMJCy1lv3yNMG0/96WdALQTFwp
	 1AmG3zvxLgFM9ZIWJ4WH0CLRhbUDLDArWhB6CS03PLuSi+5plereJ4Nua2m2GHgDeFiBl
	 MhOY0B+PVQx4c8DbLlelU5NFWQRxj3GZ2IItzRse9Nv43GKT9KAK/7bNntXU/6DHp10i/
	 0dXx8MIZR0CLOguuaVzCzXb3o0/WsQh7HSo6oorN16csttL8EeoFG2MS+KyG98xznZSqI
	 34n6wRkL8VGce5C206XDQSrMMvdWdxygPcBnX6kaouYaUcTh3vVuNDHnU+lby9M/vgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280757;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=d/d3yGImmhA5Pa1MeHR8lgTc0tfl6qkT6DVrelhpVq4=;
	b=GbPVChJ9A4tnoKwHprKVqSTANEjTMBUCcvv6SCQX/17782pP7kso77QBhW6663CTaMRR
	 uJxEnmqFxWTJqxqCiUsQaJE/aQxFQBSRz9tjgHegwg4Ja0vyVyxcsQa4+8RpzFCaZ6l9I
	 2QuPDxGA2FOPocoNqLvy3BRBMcMiIR8JOuoEZXG0qvRMJup5451tmEhJ17ctz63G4D81/
	 cLr7ceARHm2Az8ELF/FSkncWO/jWDUiyYhO2OAHzyZHYFtDdvuCiXt1ESgbpDVakjLzRv
	 qGVAVf5oX6wC3DyDnTmLtgg0B1MDEfeEI317XJy6WZ5qVTC34LPp7TM7w7I7+LPqVfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=osCaFOwX;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDD3606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 13:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DDD3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=osCaFOwX
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCi7LI212081;
	Thu, 29 Oct 2026 13:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d/d3yG
	ImmhA5Pa1MeHR8lgTc0tfl6qkT6DVrelhpVq4=; b=osCaFOwX1RX+0p+Uwb5xz/
	yzXjc4tYzkIM6ZJ+j+x/uom5s3/y2nJlQDK88I/ea2o35ridblABxgMTxuEMvzO0
	130e1xEmeCaGg6rCqB7kLKcBrePLpgmOCIVrAeqoQ+eigv/MPfwvrBFqABjaMdZe
	4d3SNKsS9gxmpn4ilUfKzAmkgAJQ+dvPds1u0hjS/9Dyyb1b7ALeR4nNCtXHj6Jt
	LjbOirJ0zxookb5R0crCw2An4pgjRsAIkLE0DqIMPPjU8osJ8N+e8aMl3VhjWpCR
	mHLIPKfDn4bLwqCNqXt2Fkq+qdDEa9Yl+Xs5o8aLrqIViaJPOhE1UmksnDQfsqKw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm64af46-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:32:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCnxWx3085026;
	Thu, 29 Oct 2026 13:32:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnnhtke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:32:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TDW9dh15598032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 13:32:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 988B620040;
	Thu, 29 Oct 2026 13:32:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9399C2004B;
	Thu, 29 Oct 2026 13:32:08 +0000 (GMT)
Received: from [9.87.137.195] (unknown [9.87.137.195])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 13:32:08 +0000 (GMT)
Message-ID: <4605dad5-aab2-49e3-b919-bf9897181834@linux.ibm.com>
Date: Thu, 29 Oct 2026 14:32:08 +0100
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
To: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, yury.norov@gmail.com,
        kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
        ynorov@nvidia.com
Cc: tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
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
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20260928053728.797539-5-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MSBTYWx0ZWRfXwmENVi6yd30m
 07V81Q7TAzyI70EmBlMbSyhJibr/vBMCR3p69dzoTwMzg3WlgGqOZ7218XblEKPIWVQZkYJXhvZ
 dl8RuRBMg3G97/xgM8SFHznqf1PgPPU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MSBTYWx0ZWRfX7IFz0/EFbET9
 DhCeQyXGvf0cHYHHCtm2NUt1Tni0JxS5yIPCAsN9SRm1k8ZOobEuOERw6IZ3ypcoMhr3/D7a42q
 rmU3NgCu5LsSvVnizIEcVo67i72G9tSxp9NZmVeH/N18S7XdtL0tkPccE1oSgmk7tKYWJQeKYVD
 2j8rgW3bKwHLqy4Fp7iBu4JOAkJB3IUBjSSorwu5jW11gJIzmyLoi2/ACMa9z7kMKCTkHJONjXF
 c0d4+cZnWKV01rUZNROjHwUgbuIh0U9eAapow3AMc10fNwkCzCPsqKpbim3tSwURP+gBCkAYjUa
 ki01BF1JbiLWDiijV0OqwRoraGqfDJVzohLpqPgyjArMQAz3quD479FQWSgeLswKK9BforJlb5O
 XxtjbwWGGEE6lASI5nuBimQYTYyn0Hc1juwwek4Mc4fncM5yhd7lcA7BCVCe7DUp/hdMGp36Iry
 CP0bl0o2F7AHa6q5Kcg==
X-Proofpoint-ORIG-GUID: YjLDRhwcO4SdktYbavYUvtEdxGpgFOL4
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae34adf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=mP_uidrk0wjRY6XPjW0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: s7PRJQE60tIN94dBRZ_PuUEFzyRxo7Y1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290051

On 28/09/2026 07:37, Shrikanth Hegde wrote:
> Provide the preferred CPU infrastructure. Define get/set macros
> which could be used to get/set CPU state as preferred.
> 
> CONFIG_PREFERRED_CPU will be selected by the driver which handles
> steal time values. It is going to set/clear preferred CPU state.
> This driver will be called steal_governor and it is introduced in
> subsequent patches. It periodically computes the steal ratio and
> decides on preferred CPU state.
> 
> A CPU is set to preferred when it becomes active. Later it may be
> marked as non-preferred depending on steal ratio by the steal_governor.
> 
> Always maintain design construct of preferred is subset of active.
> i.e. preferred ⊆ active ⊆ online ⊆ present ⊆ possible
> 
> With CONFIG_PREFERRED_CPU=n, ensure set_cpu_preferred is a nop and get
> method returns the active state in that case.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   include/linux/cpumask.h | 24 ++++++++++++++++++++++++
>   kernel/Kconfig.preempt  |  4 ++++
>   kernel/cpu.c            |  6 ++++++
>   kernel/sched/core.c     |  5 +++++
>   4 files changed, 39 insertions(+)

[..snip..]

>   
>   #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 985aea617cfe..edc067a0c422 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -194,3 +194,7 @@ config SCHED_CLASS_EXT
>   	  For more information:
>   	    Documentation/scheduler/sched-ext.rst
>   	    https://github.com/sched-ext/scx
> +
> +config PREFERRED_CPU
> +	bool
> +	depends on SMP && PARAVIRT
FWICT, PREFERRED_CPU mechanism can work perfectly fine without PARAVIRT
selected. It would be annoying to enable it and implement a dummy
paravirt_steal_clock() just for that.

Shrikanth, would it be possible to drop that dependency?

Thanks!
-Mete
