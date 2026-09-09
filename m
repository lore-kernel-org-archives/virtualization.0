Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8857C718;
	Wed,  9 Sep 2026 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973096; cv=none; b=YyiMBqz7UovxB+uxr8+U7D6TvP1oOZphdDWuGuxUGgm1FcgcjkWOPiWQ37h+HCf0DTB+rBXv9HAtEzZJgq5+juVZwWT0rfWOjBZhvSGmLha3GHvTHZOTpSQsQDk+n9KwpGb0L2Hgsoj5i8pZ1EM4y2yXSeccNCBOmI7VluT+qV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973096; c=relaxed/simple;
	bh=FWUDyjpOAJDha7Vu8017ZxgTpqmdQjvsTVGQML/X4Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOUs7sPEc/IZD3Z7ECH3m1cq5PIv9zIal1SSQANbZxfIYWyCb4YlE3SMeQpaZkrdf2jm65GR4tXaDydyDYBSIqkVvwKyKf3ZP2CRAdkRSiJBgz3+3x/xpFstnTdWKivQidTT4BAN4blxq3sHpJdISkfRe1+X//G0dbk4pxls4ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A5d5/kxy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A5d5/kxy"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1PJk3801833;
	Wed, 9 Sep 2026 16:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oZgf3n
	uyBiuBq4H3gbLSmPyC2uPolHqL9v8YJ0hMZSM=; b=A5d5/kxyqeOOPSDUe4iM/E
	uxuhLm+wWxOmdeflfizLAjTLPK75UhiuZpSiddVZCybiN87IvA3MCkpRjfcvtAGf
	sh5ERtfoybtj9Qmsmm1GGF5Ln0yN4WKtGE6/tMenn0JD1CuLKXv3vqGZCx0TAP+n
	K7ApiMAorFFbm4mfLa4wX8TlmRmDY1yW8MxpVv6Qgwj00xQv+UAJVWoxlidPZP6U
	iiR0LiiBHIRuhIRx2/3feKvaeP8ghGGWY9nSRaOtrr8JwwU+2ikex9hKXh5QM1Sw
	khoqQMw4p3CPWrgYuwAkUnXQQLBCO3QLfPOfGIRn6FXVNn5oMv+fhtdNsT+wyjUg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhky9yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:58:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689GuDjE030543;
	Wed, 9 Sep 2026 16:58:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yk7kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:58:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689GwBDf47382886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 16:58:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 503BA2004F;
	Wed,  9 Sep 2026 16:58:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FE6320040;
	Wed,  9 Sep 2026 16:58:10 +0000 (GMT)
Received: from [9.124.210.73] (unknown [9.124.210.73])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 16:58:09 +0000 (GMT)
Message-ID: <9fb85c37-a886-46ae-b738-f0eadf3dd468@linux.ibm.com>
Date: Wed, 9 Sep 2026 22:28:08 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 13/13] virt/steal_governor: Enable the driver
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, Eugenio Perez <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-14-sshegde@linux.ibm.com>
 <20260909141723.AF5971F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260909141723.AF5971F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE4NCBTYWx0ZWRfX2D0UpvvQunv1
 02gxzEpAuJCv7zo/KxeLbEDkJXz5jwQ3SXjS9zTT1kR7ZeCbOXCs3dDDDxhFBZbHLf1o3EILr0H
 rL3PVDVWye6TheM4Cpn20XcAnapVPzA=
X-Proofpoint-ORIG-GUID: U_sr4he5tjIksa6ki_BCvlI30-AcBamb
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6aa19026 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=OTirsOXZMFwpxx0ZspoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE4NCBTYWx0ZWRfX9oYDa6kQHf4s
 qaLt6d9GPFnHEp8GxZe3haXJzHVpf3ZUuDAr0JDkXptTsUx1WhYwrPHRZTPuITJ0Eg77nHBBIp0
 o2uLUzUzE38lolJhLcqfh0rPHl1Rt2T3vw3fAHzJoTdz8Oe6UDEzGQu84+7xkzN1AszB2Xpl8mh
 T7iwgaCCLlI4+qO4vDyOT6zAnb0ukB250DsoDIGFTVmBoojChwHJnwRzsbF5vfoe4MEB1ZfoBBK
 OmV6BHugBzGdjcTvEVMiuzvgg6+qNNfm666hvWI7Wvn96mAgjRo4sJnHGfPqDV1LbcN8lFiLKjt
 IUhtPXAH6TIlAZeLgNgz9vCwqqEUkgHNkTDnqvKd99Jk3pgaeFFxf4vkX2T3j23dDomRXd2qN1N
 lX9a5R5RXrSkRpC47/iUkNeH67Rtct3tBeKA3z9ydKtgoSJSSjzEGAhaPMWyYebbuTS9EVir9Zx
 7zFS33Wa2+D6woYekRA==
X-Proofpoint-GUID: U_sr4he5tjIksa6ki_BCvlI30-AcBamb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090184



On 9/9/26 7:47 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] preferred_cpus_valid() reads cpu_preferred_mask and cpu_active_mask without holding cpus_read_lock(), creating a data race with CPU hotplug that causes the governor to permanently shut down.
> --
> 
> commit b0d791ea69ac4f874448d3baf935e4825cba622f
> Author: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> virt/steal_governor: Enable the driver
> 
> This commit provides a configuration option to enable the steal_governor driver
> for paravirtualized environments. It enforces PARAVIRT and SMP dependencies and
> selects CONFIG_PREFERRED_CPU for core scheduler mechanisms.
> 
>> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
>> index 52eb7e4ba71f6..eeb84e578ddf9 100644
>> --- a/drivers/virt/Kconfig
>> +++ b/drivers/virt/Kconfig
>> @@ -41,6 +41,23 @@ config FSL_HV_MANAGER
>>             4) A kernel interface for receiving callbacks when a managed
>>   	     partition shuts down.
>>   
>> +config STEAL_GOVERNOR
>> +	tristate "Dynamic vCPU management based on steal time"
>> +	depends on PARAVIRT && SMP
>> +	select PREFERRED_CPU
> 
> [Severity: High]
> While this patch enables the driver, can the background loop in
> steal_governor_loop() permanently terminate during a concurrent CPU hotplug
> operation?
> 
> If a CPU is offlined, sched_cpu_deactivate() clears the target CPU from
> cpu_preferred_mask and then cpu_active_mask without memory barriers. If this
> happens concurrently, preferred_cpus_valid() in drivers/virt/steal_governor.c
> might observe a torn state because it evaluates the masks without holding
> cpus_read_lock():
> 

clear_bit is atomic operation. It cannot happen concurrently IMHO.

> drivers/virt/steal_governor.c:preferred_cpus_valid()
> 	if (!cpumask_subset(cpu_preferred_mask, cpu_active_mask)) {
> 		pr_err("preferred: %*pbl is not subset of active: ...\n",
> 		       ...);
> 		return false;
> 	}
> 
> If the check fails due to this race, the governor loop permanently shuts down
> since it returns instead of requeuing the work:

Even if it happens, it is safe to shut down, rather than continue in weird state.

> 
> drivers/virt/steal_governor.c:steal_governor_loop()
> 	if (!preferred_cpus_valid()) {
> 		restore_preferred_to_active();
> 		return;
> 	}
> 
> Would holding cpus_read_lock() during these mask checks prevent this race and
> keep the loop running correctly?
> 
> [ ... ]
> 

