Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D15562612;
	Wed,  9 Sep 2026 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972753; cv=none; b=tCCogGiolt95z/dPiFEBMvcdb3cU/Zf55iKQ+FJaZPQQANrOpho40CIKWDnfGU1nXCqFst6QXeoELTuMz+be9uVvgoUQhBH1v4lgvOXqKjuuaeL/P9AV8ZioDO52gQvAfMvhBHKhivB/EJ+XnmWbLiNREcKty4i/+r1NYQ1d1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972753; c=relaxed/simple;
	bh=YK4imFw0iRMj7b8kVTo/+kB5gGn1NU1qDGYQC1kKOm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BM6nKpTJUyXB7kLA/XapU5u5m3/HTwRlNqSpkFmdRhWSB7PWQSEAiVCZBo5pMcJEyJo909HXInhw/yGnodXaql0IjIkXgVvzLz7+pEWGqHgd9oNaOW9mzhzkqTfy8U4IQ/lhLXbQYfrqW81/fjpcmnPUBQIZIw8G31hwAGxJoH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IB28g2LG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IB28g2LG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1maO3817830;
	Wed, 9 Sep 2026 16:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q/xLxo
	CnkyhOPRv2DO+nf0HjzQVcs6baLEfZW6ciW7w=; b=IB28g2LGhU5SJLU6pog40x
	SWZE1mPd8B86qQBvi+jBz06owMmjJGyyadYqe6YAHDFyQQbY3YkRu1ftMe7uvMr2
	cIzod2XKiwaiPUkByQFggdmHh6rPUg69p2kf0yj4E4oeWR9rChDboVtOUC8glf8T
	ZWgo6euo3fmyHqyKg6uKYf1aGu3D2IoqHo+Rpbyc1MgCsBgQItNFRd72sqQRxXIq
	PiFaofJoGULdiWahoWqgzQf+QKLv0Zla+IXjqd9DNAcLgvRJQZWUm0PMf2k6C5xm
	kZRGQGkYrLh4fSATOSxeC1RH053TBxnIkxD6bRLu+/y3WvvQqRlx/zgSAcnmDk+A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf477vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:52:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689GfD93016205;
	Wed, 9 Sep 2026 16:52:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgk8mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:52:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689GqQxx34341342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 16:52:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F46120040;
	Wed,  9 Sep 2026 16:52:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4479220043;
	Wed,  9 Sep 2026 16:52:25 +0000 (GMT)
Received: from [9.124.210.73] (unknown [9.124.210.73])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 16:52:24 +0000 (GMT)
Message-ID: <dcaf7252-677d-46b9-892b-bcb16918e5bf@linux.ibm.com>
Date: Wed, 9 Sep 2026 22:22:24 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 12/13] virt/steal_governor: Implement steal_governor
 policy loop
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, Eugenio Perez <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-13-sshegde@linux.ibm.com>
 <20260909141632.C7A4A1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260909141632.C7A4A1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xSfm8X7Dq6rg2TSL11zAIMD8x45zIfSL
X-Proofpoint-GUID: xSfm8X7Dq6rg2TSL11zAIMD8x45zIfSL
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa18ecd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=zlYNkZklyGC-dkrKnf8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE4NCBTYWx0ZWRfX9SdDnvZgFMKb
 BFvweAGqGLEVPJH3n+/sktEc2nub/2h6hsqAyaPoay3I0kzSgDTZ0jkAK2YkpYEgGM2wH/GCpLW
 0tQuKP0QIVhbXHU4HKB7aoOJpnjzqH7btoXU7Yi/WFNoqL+m9bfSGiwqFrCT+Hp+AlB4FKsicJg
 PM518LUD85Cj3Z2aSEw5sSXBIDGtUHe6k9bRRfFraElXjR6FXk1yrLboxXCfVOJW1aGFSkzWKLG
 V6wlbHQRKx1VzD0ZfXSybOr7Rhy3/I02kjD+MwCQL1KOHem5rsf0eNsC0nI76GhT5k+kvSbymRI
 X7PsfEEkcMf7cLuK6yZZyuQLpjW+vGebkTN+CeucI8nrF5QqF8kiU7NCRjdS4gA2Ophjl9XoOm2
 bLymIomARrwfWKztBXtmfyZj0SKgUhE9N4J7zKMV1rMy+Xwt8gBLFuHnsEkKcpnEnL5kY5BFsfL
 oyqQJUZg2qThiRP0F3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE4NCBTYWx0ZWRfX+VICGlImJn+K
 7FB3CKmwMSuMFE4XUQXpyWAZk0gVxEeDDew3yk2ClCoZ3yzgSzebm1sTtvDiXZIRUOrjcxefE8A
 3A5Z2uSK8fXMTrlJ6trOm0GznlaGsHw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090184



On 9/9/26 7:46 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Lockless access to `cpu_active_mask` in `preferred_cpus_valid()` can lead to a spurious failure of `cpumask_subset()`, causing the driver to permanently shut down.
> --
> 
> commit 77aa795bc87999089d7a60bf5b5985b2c580cbec
> Author: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> virt/steal_governor: Implement steal_governor policy loop
> 
> This patch implements the core policy loop for the steal_governor driver using
> a delayed workqueue. It periodically calculates the steal time ratio and
> dynamically adjusts the preferred CPU mask based on high or low contention
> thresholds.
> 
>> diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
>> index 27f53ea16498b..6e31f9923dea4 100644
>> --- a/drivers/virt/steal_governor.c
>> +++ b/drivers/virt/steal_governor.c
> 
> [ ... ]
> 
>> +static bool preferred_cpus_valid(void)
>> +{
>> +	if (cpumask_empty(cpu_preferred_mask)) {
>> +		pr_err("empty preferred mask. stopping\n");
>> +		return false;
>> +	}
>> +
>> +	if (!cpumask_subset(cpu_preferred_mask, cpu_active_mask)) {
> 
> [Severity: High]
> Can this lockless check spuriously fail and cause the driver to incorrectly
> shut down?
> 
> Because cpus_read_lock() is not held here, there appears to be a race
> condition with CPU hotplug operations (such as sched_cpu_deactivate()). When a
> CPU is taken offline, it is removed from the relevant masks sequentially.
> 

CPU Hotplug race is taken care. order of udpates are expected not to cause the
above issue.

> If cpumask_subset() reads cpu_preferred_mask while the dying CPU's bit is
> still set, and then reads cpu_active_mask after the CPU's bit has been cleared,
> the subset evaluation will spuriously return false.
> 
>> +		pr_err("preferred: %*pbl is not subset of active: %*pbl, stopping\n",
>> +		       cpumask_pr_args(cpu_preferred_mask),
>> +		       cpumask_pr_args(cpu_active_mask));
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static void steal_governor_loop(struct work_struct *work)
>> +{
> 
> [ ... ]
> 
>> +	if (steal_ratio > sg_ctx.high_threshold)
>> +		decrease_preferred_cpus();
>> +	else if (steal_ratio <= sg_ctx.low_threshold)
>> +		increase_preferred_cpus();
>> +	/*
>> +	 * else: steal ratio is within bounds. Still do design checks so that
>> +	 * module restores to active if CPU hotplug breaks those assumptions.
>> +	 */
>> +	if (!preferred_cpus_valid()) {
>> +		restore_preferred_to_active();
>> +		return;
> 
> [Severity: High]
> If preferred_cpus_valid() spuriously fails due to the lockless race described
> above, does this early return permanently disable the driver?
> 
> By returning here without requeueing the work via schedule_delayed_work(),
> the periodic loop is halted completely, leaving the driver non-functional
> until the module is manually reloaded.

That's intentional.

> 
>> +	}
>> +
>> +requeue_work:
>> +	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
>> +}
> 

