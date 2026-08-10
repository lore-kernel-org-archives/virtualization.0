Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091A3D3CF7
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363954; cv=none; b=PIt0YUc6MQca26NBU8cLJKaikgX05a4PJyS/TSV3nSUdvKmH67OVhHj/4nILAlc1rZt3kI777nP7m4gNJO09TPlm9JWvDD6IAtRLApXQNisKMklGLp29M50cQlei/t7BrDFZmubUJ9FpZ+MhR+ixGFo4H4RkjujqXXrYR7x8zvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363954; c=relaxed/simple;
	bh=dIPyDEB/cW5VCCWLlYlPUMGmsUr9+irWujmR0rAZ0So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFFZN2jzHZgcq2RuoffjB3ueXVC8VjZ1zqkdYlQmst2NN81f/9yJq/xLA/8FJjJ9BG9PUZDvYYPGjzjbDkI9hOzMhFgUp+d9jZCKaW5VKK6KSzIFIZswFilnwZ5tTYTaHzulcmZFHW5eKhpfe8XfrDdB/TCm9r8YO7mKpOh416I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WdaiOpNu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WdaiOpNu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9Vri2157137;
	Mon, 10 Aug 2026 12:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rsnV3L
	RMaraTYgo0wJ/PM9LCV+tF3mHthX0fEe8e/bA=; b=WdaiOpNuPVJEQoxK78ncWN
	UIp0JBmBK+y4d5GVcUttMXIGM/eajMnXqtQVpgQAxaoCjNO8cifzBDSy08278Am7
	khXd2Qz8Nou1f8OsRvV7yP7xDWTzOBilYRX9ag8WHILxJEFfB+UqHncNz9Zahp5V
	FhCB8rAJl+NTTdTzMhyhpnIBLo6VfhGDYqFsGUsbp4suLoIZNSVpqO3BdJbagkdj
	kC6FI7YOA0oDS9qpkiLUa5CuTGdTpht8Ey80otDRXpkouC936HFq5nMQBVgDeAc9
	dGsUSJhs0q52gqhSYNkN/G4ooH0PB1se03MHB8t99kP1EMqs+bQC1B20mJFm/sog
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23gt9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 12:12:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ACBJ54002791;
	Mon, 10 Aug 2026 12:12:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g4hk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 12:12:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ACCACi35520948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 12:12:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 978842004D;
	Mon, 10 Aug 2026 12:12:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F8DA20043;
	Mon, 10 Aug 2026 12:12:09 +0000 (GMT)
Received: from [9.111.54.108] (unknown [9.111.54.108])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 12:12:09 +0000 (GMT)
Message-ID: <69fe90e5-9288-4a36-8599-205e9a061b7d@linux.ibm.com>
Date: Mon, 10 Aug 2026 14:12:07 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/11] virt/steal_governor: Implement steal_governor
 policy loop
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
        virtualization@lists.linux.dev
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
 <20260724140732.2683314-11-sshegde@linux.ibm.com> <amPTg78qsOw4WpqB@yury>
 <d3533cdb-d32a-4d75-84d5-a2908ecc7bfa@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <d3533cdb-d32a-4d75-84d5-a2908ecc7bfa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a79c01f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=4jQyYO4Id7rgjPpGlYcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwMyBTYWx0ZWRfX8DCm7BhRcDjm
 uKcHIHY0q8GURwiY7QTNl1opl13EsOzQAcpdlCnckTly+FQ0aQQQOs+FsM/Ws11FKTp0y6DBCfS
 XJriVyrSusyKRkPXS267L2dPgXwR6jndmoXOTKQ3PHB5Wb+dAR4xsC8IsxqkgEP+CvMiU0pKkdp
 WS6qYDd8pHua8WOfS6aEOAJSTwFcGd1fVujklAJXO0G6NcYQDiOp9JD+qzCH5k/Y2K3vl37Z3XL
 mlEflB/F9Tb6hHY7BqHj+ig/FfNU9MeEPMG3iIcV7C5Y8bUytbgwfoJ7l9lZepssgZyvDktAuas
 nRkEW6IkFiC/w5LDg71qXUsapthSCD8L8QgHqebGXdRjp4dvAfS/+Ve5aQIyEXistQ03wdSip5W
 hey2SvjCwVyjxS0mn91XQutjtBMb2PvhDU7ssq0JpMUuCpE5Pj1bMYKbYfzupAt36zfqxpVZ/6T
 k8JukH5NGyVz1lobzKA==
X-Proofpoint-ORIG-GUID: VHuIP8-nzRSaetE1KmPe3BYo8a3Vjg7X
X-Proofpoint-GUID: vPJ7KtsPyZb6_v7UGbebunOfFMr81WUd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwMyBTYWx0ZWRfX0/8OIBwCyxey
 fDi4mCmPc/L38heCRSBmngKMVxegXEH4F2X92cLJDzpD72+vFAVPhunDG76euHkL6w4ouO8MSMH
 6eiuxv2VyoxZNUX2Bc6EV4E8+hmrufY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100103

On 27/07/2026 16:42, Shrikanth Hegde wrote:
> Hi Yury,
> 
> On 7/25/26 2:35 AM, Yury Norov wrote:
> 
>>
>> In v8 I pointed to the identical function in s390 code, and you agreed
>> to unify them, but that didn't happen. Please do that in the next
>> version.
>>
> 
> This is diff i have now. I assume this is what you had suggested.
> Let me know if it differs.
> 

The chunk below for s390 looks correct to me. I don't see any
difference functionality wise.

> 
> diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/ 
> hiperdispatch.c
> index 217206522266..0c658f229b17 100644
> --- a/arch/s390/kernel/hiperdispatch.c
> +++ b/arch/s390/kernel/hiperdispatch.c
> @@ -210,13 +210,10 @@ static unsigned long 
> hd_calculate_steal_percentage(void)
>          int cpus, cpu;
>          ktime_t now;
> 
> -       cpus = 0;
> -       steal = 0;
>          percentage = 0;
> -       for_each_cpu(cpu, &hd_vmvl_cpumask) {
> -               steal += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
> -               cpus++;
> -       }
> +       steal = kcpustat_field_total(CPUTIME_STEAL, &hd_vmvl_cpumask);
> +       cpus = cpumask_weight(&hd_vmvl_cpumask);
> +

[..snip..]

> --- a/include/linux/kernel_stat.h
> +++ b/include/linux/kernel_stat.h
> @@ -196,6 +196,17 @@ static inline void kcpustat_cpu_fetch(struct 
> kernel_cpustat *dst, int cpu)
>   }
>   #endif /* !CONFIG_VIRT_CPU_ACCOUNTING_GEN */
> 
> +static inline u64 kcpustat_field_total(enum cpu_usage_stat usage, const 
> struct cpumask *cpus)
> +{
> +       u64 total = 0;
> +       int cpu;
> +
> +       for_each_cpu(cpu, cpus)
> +               total += kcpustat_field(usage, cpu);
> +
> +       return total;
> +}
> +


