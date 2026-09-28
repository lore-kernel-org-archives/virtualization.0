Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EDF3644DE;
	Mon, 28 Sep 2026 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578361; cv=none; b=f+10Kamc7441aAjv8qoT9gE8uBpLgGyULU8XMcS7MhhTL8c4CEffuU4L8V4vxgD+HdQ+iMMvQE9Fxucm3VgTj33dHodl6+9UPqHHujogfBeS3ZyK7rQTR9/qCqte4q9mgUKVzjFB+BasMgJ/7FUZFYZtI+VNtm1a0AbA4MOb0r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578361; c=relaxed/simple;
	bh=sdTg1U2puapRaR8eLpB7x6OfSTi4QkbY9ByolJZeQiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lI8VEZdaSd0ebHh6qcfY+R7Ri/O019eLO6LxYvpK2ydmx67zQCa6E7XqOVK4xxBArFTXgwWYfKeqjisUCNKoPIVKy0CvCujSYWAWyxEIQY9x3rRQI/1Sar0uc0mbZxo984Dvml0Aymrjc0aWzogGKZ1wZQvGo8AfBBtaGWis8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KsPY1/EE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KsPY1/EE"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RFrUhq1679474;
	Mon, 28 Sep 2026 06:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DvSnFG
	QsVB082QYsFhoHxKbTBQkQsQQlr7XSnm69V3Q=; b=KsPY1/EEvp9g4tecKAZCh6
	AnJgN7WaLSXipeAXflLYVL79Ad2o2ZBHiIVxGRdPsC5PtX+YNefk03R7Pf8Ypg86
	WL5oVLVtgZ7dff/VLSZZ5yuQg9byXwQc0WQXYSnfRCj/Hf16y10LRfdSM3IFFsnX
	Ss/002E1PzTOTI6yrGXUC1kqJ7rI540/Dm9v2gVVQ43BlOQoJkxolW9MMAGPbHZ+
	cwmUin1pLbqGWI+7V2rQYGzzMsryHxV3JTp9MSW5H5UT5NxD1V3eSb61vXbQ/PX5
	iA1VERknhfw5BkabPT2HCi9jSWbFRXi/TzWB2lIUmLsBw0hqILYQC/EH61quaupg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fdyjv4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 06:52:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S34NCS2071091;
	Mon, 28 Sep 2026 06:52:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck42va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 06:52:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S6qa2h38142284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 06:52:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1616B20040;
	Mon, 28 Sep 2026 06:52:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5C2320043;
	Mon, 28 Sep 2026 06:52:34 +0000 (GMT)
Received: from [9.124.213.68] (unknown [9.124.213.68])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 06:52:34 +0000 (GMT)
Message-ID: <6b1cf626-0be2-4f97-b038-43d666a69ec5@linux.ibm.com>
Date: Mon, 28 Sep 2026 12:22:33 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 12/13] virt/steal_governor: Implement steal_governor
 policy loop
To: sashiko-reviews@lists.linux.dev
Cc: Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-13-sshegde@linux.ibm.com>
 <20260928055157.15EFF1F000FF@smtp.kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260928055157.15EFF1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6aba0eb6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=9_nvp-p3nIUC6TNtRAkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNiBTYWx0ZWRfX3KBY1rXbjkKt
 exmx2IC/3P+P6BotW2nKjXMJ6hOW+MH+c/FK4d7yP6Q2BODRFzqF8vU5wB2cycdt/1iiM3UifCK
 GsctTOw1N57OGOdKggbMoRj3LaF6jtg=
X-Proofpoint-ORIG-GUID: 0--sdgD619UEW-4gQDWQcigF3qRW7YLH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNiBTYWx0ZWRfXwIiDxLke19LF
 QL9SKzlcAfw0OE4bGEyyJnVpmaStL27BWlop5vca78I8soGTtnhBQrIkGHi5R9pIjYVDJxqg+QW
 T3p4rCdjrn2mlpD5LhWek8zCKMekhvoRZuQa4eHT53yfVsPYS9OtwtnMRtia8QTUAdBFqlrQ5AR
 /TN0t8X5goaiW1JQoZtkJWOVMBgUx5Zr25S33/OTip9VNcyj2Jpecb3/j4jIScm9a94s9YuvOZv
 YwkHayPYrQDI9zLGNKRZWXgbgG5vgKOIXHyhqA0FThjEhr193xWtujnal7HbU5eQWD9j0kVD4Du
 CxZjhfBSskNzc+juxAcfwUAb1sgLHrsQ52mMZtT4nz78hC3Dx2mkP2elJ0ZS0KFhXt5XOJmFc4q
 nuipoJxPuS2WIupPy43o260MLDdvFsIfLfNZL8kfJsmK6vxmxrBIil7OhqQfX513yMmoW7P6mad
 bRG2lAYxYJSYAolBXQw==
X-Proofpoint-GUID: 0--sdgD619UEW-4gQDWQcigF3qRW7YLH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280026

I don't see any real concerns so far. Some optimizations yes, but they
can be deferred post the merge if they are necessary.

On 9/28/26 11:21 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Missing bounds check on interval_ms allows infinite workqueue spinloop
> - [High] TOCTOU data race in preferred_cpus_valid() causes erroneous driver shutdown
> - [Medium] Integer overflow in steal_ratio denominator when VM is paused
> --
> 
> commit 5f38399332407b64e0ce2da43681c27f1e1287d5
> Author: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> virt/steal_governor: Implement steal_governor policy loop
> 
> Schedule work at regular intervals to implement the steal_governor
> policy loop, which monitors steal time and takes action on the state of
> preferred CPUs. The interval is determined by the interval_ms parameter.
> 
>> diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
>> index 27f53ea16498b..6e31f9923dea4 100644
>> --- a/drivers/virt/steal_governor.c
>> +++ b/drivers/virt/steal_governor.c
> [ ... ]
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
> Does this lockless read of cpu_preferred_mask and cpu_active_mask race
> with CPU hotplug?
> 
> Since CPU hotplug clears the preferred mask bit before the active mask bit,
> it seems cpumask_subset() can read a torn state where a word is read from
> the preferred mask before the bit is cleared, and the corresponding word
> is read from the active mask after the bit is cleared, returning false.

Update ordering is taken care. Not an issue is clear/set bit involves atomics.

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
>> +	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
>> +	ktime_t now;
>> +
>> +	now = ktime_get();
>> +	delta_ns = ktime_to_ns(ktime_sub(now, sg_ctx.time));
>> +
>> +	if (unlikely(delta_ns < NSEC_PER_MSEC)) {
>> +		pr_err_ratelimited("work scheduled too soon delta_ns: %llu\n", delta_ns);
>> +		goto requeue_work;
> 
> [Severity: High]
> Can this create an infinite spinloop if interval_ms is set to 0?
> 
> If interval_ms is 0, the delay is 0 jiffies. When the work executes, it will
> take this branch because delta_ns < 1ms. It jumps directly to requeue_work
> without updating sg_ctx.time, which schedules it again with 0 delay. This
> will continuously spin and consume an entire CPU core.
> 

No. Interval can't be set to 0. Minimum is 100ms.

>> +	}
>> +
>> +	curr_steal = get_system_steal_time();
>> +	delta_steal = curr_steal > sg_ctx.steal ? curr_steal - sg_ctx.steal : 0;
>> +	sg_ctx.steal = curr_steal;
>> +	sg_ctx.time = now;
>> +
>> +	/*
>> +	 * steal_ratio = (delta_steal * 100*100)/(delta_ns * num_cpus())
>> +	 * To avoid possible overflow, divide the denominator early.
>> +	 * Note minimum interval is 100ms.
>> +	 */
>> +	delta_ns = max_t(u64, div_u64(delta_ns * get_system_cpus(), 10000), 1);
> 
> [Severity: Medium]
> Will this silently overflow the 64-bit multiplication if the VM is paused
> for an extended period?
> 
> Since the multiplication of delta_ns * get_system_cpus() happens before
> the division, a large time delta (e.g., a large VM suspended for a long time)
> can overflow U64_MAX, leading to a wildly incorrect steal_ratio calculation.
> 

Not a reason to fret about. It is way too long duration.

>> +	steal_ratio = div64_u64(delta_steal, delta_ns);
>> +
>> +	if (steal_ratio > sg_ctx.high_threshold)
>> +		decrease_preferred_cpus();
>> +	else if (steal_ratio <= sg_ctx.low_threshold)
>> +		increase_preferred_cpus();
>> +	/*
>> +	 * else: steal ratio is within bounds. Still do design checks so that
>> +	 * module restores to active if CPU hotplug breaks those assumptions.
>> +	 */
>> +	if (!preferred_cpus_valid()) {
> 
> [Severity: High]
> Does calling preferred_cpus_valid() here without cpus_read_lock() lead
> to a false teardown?
> 
> If a hotplug operation is happening concurrently, the torn state read in
> preferred_cpus_valid() will cause the governor to erroneously shut down
> the policy loop permanently.
> 
>> +		restore_preferred_to_active();
>> +		return;
>> +	}
>> +
>> +requeue_work:
>> +	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
> 
> [Severity: High]
> Does this immediately spin if sg_ctx.delay is 0, as mentioned above?

As said above, interval cannot be less than 100ms.

> 
>> +}
>> +
>>   static int __init steal_governor_init(void)
>>   {
> [ ... ]
>>   	sg_ctx.delay = msecs_to_jiffies(sg_ctx.interval_ms);
> 
> [Severity: High]
> Is it possible for sg_ctx.interval_ms to be 0 here?
> 
> The module parameter interval_ms doesn't appear to be bounds-checked
> before this point, meaning it could be set to 0 and trigger the infinite
> workqueue spinloop.

As said above, interval cannot be less than 100ms.

> 
>> +	INIT_DELAYED_WORK(&sg_ctx.work, steal_governor_loop);
>> +	sg_ctx.steal = get_system_steal_time();
>> +	sg_ctx.time = ktime_get();
>> +	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
>>   	pr_info("enabled. interval: %ums, high_threshold: %u, low_threshold: %u\n",
>>   		sg_ctx.interval_ms, sg_ctx.high_threshold, sg_ctx.low_threshold);
>>
> 

