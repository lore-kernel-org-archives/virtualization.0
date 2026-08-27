Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE22B440A3C
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787827868; cv=none; b=TESLUrQCo4YHrVlDctJYlwK2jhZGFsMZV4F0rmP1CGta77aJX+idSwO+wMsTRD8xhBpkloVl+M6a/LXjUUVU8UeSo3Mh7ILRHhgpIP7/36Cm4P0rYe6PYXbDK6WJEl+jitQIhT3fK3jjrXuCVJZ03acW+yV1zzdqqFTP0p/oTH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787827868; c=relaxed/simple;
	bh=LP22HDODCkZHPeH4FpOwO3Mk7kTKmdf8HwzvL7sav5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVb03mMKpAU+191y40oH9THPwAwbwZeVHDAuL+hBv5dgaI+Ov+5jy3CEzABjfAlPSYQxQ4a4au/5pnVmUy62yBeSV7GnrSzH2mH+09RbEFAAjee0hi4L6GV4nZQcLMZAOnEW30mVX6QEodltAKadIzMmMhc8b3+0DU/XGxQLK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mcJrugKI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mcJrugKI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FAB31688;
	Thu, 27 Aug 2026 03:51:01 -0700 (PDT)
Received: from [10.57.71.2] (unknown [10.57.71.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 591513F85F;
	Thu, 27 Aug 2026 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787827864; bh=LP22HDODCkZHPeH4FpOwO3Mk7kTKmdf8HwzvL7sav5k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mcJrugKInPQ71+ALzXeCcSmZEqvrcDGreb7B/5NPIktkZkREpEnwfxuVm9FyqqGR1
	 hRtjKRiX057Clj957dX8tdHZGWuOq3Un/Mk813wBi83LEdP5miZGeMAGTp78UY0iO6
	 r1WlaDof7Uh5K8Uv8RT2LZ6kTsqDMCIQcbW8XNzY=
Message-ID: <2e1085f1-82f2-42dc-ae72-0bedffb414f3@arm.com>
Date: Thu, 27 Aug 2026 12:50:57 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/12] sched, steal_governor: Introduce preferred CPUs
 and steal-driven vCPU backoff
To: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
 mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, yury.norov@gmail.com, kprateek.nayak@amd.com,
 iii@linux.ibm.com, corbet@lwn.net, meted@linux.ibm.com, ynorov@nvidia.com
Cc: tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
 seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
 rostedt@goodmis.org, maddy@linux.ibm.com, srikar@linux.ibm.com,
 hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
 frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
 christian.loehle@arm.com, tj@kernel.org, tommaso.cucinotta@gmail.com,
 maz@kernel.org, rafael@kernel.org, rdunlap@infradead.org,
 kernellwp@gmail.com, linux-doc@vger.kernel.org, jgross@suse.com,
 virtualization@lists.linux.dev,
 "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
 <0f3307c8-6fc9-49b6-93e4-7ffd85dd0c16@linux.ibm.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <0f3307c8-6fc9-49b6-93e4-7ffd85dd0c16@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Shrikanth,

On 17.08.26 09:39, Shrikanth Hegde wrote:
> Hi.
> 
> In addition to what's currently planned for v11 which was posted here,
> https://lore.kernel.org/all/895a058a-475e-42ca-
> a7a3-2c854598eea4@linux.ibm.com/
> 
> I was going through sashiko's comments at:
> https://sashiko.dev/#/patchset/20260812054033.95658-1-
> sshegde%40linux.ibm.com
> This has revealed some gaps. Thanks to some really nice insights too.
> Report quality improving day by day!
> 
> 
> Vincent, Dietmar, please check the 32-bit task issue fix on ARM64.

See below.

> On 8/12/26 11:10 AM, Shrikanth Hegde wrote:

[...]

> Issue1: Possible crash on 32-bit tasks on ARM64.
> =======
>>> +static inline bool task_can_sched_on_preferred(int cpu, struct
>>> task_struct *p)
>>> +{
>>> +    if (cpu_preferred(cpu))
>>> +        return false;
>>> +
>>> +    /* Only FAIR tasks honor preferred CPU state */
>>> +    if (unlikely(p->sched_class != &fair_sched_class))
>>> +        return false;
>>> +
>>> +    return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
>>> +}
>> Does this intersection check need to account for the architectural CPU
>> mask?
>> On asymmetric systems, 32-bit tasks are architecturally restricted by
>> task_cpu_possible_mask(). If a 32-bit task's mask intersects with
>> 64-bit-only preferred CPUs, this function might return true, causing
>> is_cpu_allowed() to falsely return false for valid 32-bit non-
>> preferred CPUs.
>> Since 64-bit CPUs are rightfully rejected by task_allowed_on_cpu(),
>> all CPUs
>> end up rejected. Could this regression cause the select_fallback_rq()
>> loop
>> to exhaust all options and hit the BUG() case for 32-bit tasks?
> 
> Fix:
> ====
> I wasn;t aware of this case, thanks to sashiko for bring it up.
> Yes, it could potentially cause a BUG in select_fallback_rq.
> 
> Do a simple check if mask differ from possible mask which indicates we
> are on 32-bit task on 64 bit
> kernel. Do the below. I think that should solve it.
> 
>  static inline bool task_can_sched_on_preferred(int cpu, struct
> task_struct *p)
>  {
> +    const struct cpumask *valid_mask;
> +    int i;
> [...]
> +    valid_mask = task_cpu_possible_mask(p);
> +    if (likely(valid_mask == cpu_possible_mask))
> +        return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
> +
> +    /* 32-bit task */
> +    for_each_cpu_and(i, p->cpus_ptr, cpu_preferred_mask) {
> +        if (cpumask_test_cpu(i, valid_mask))
> +            return true;
> +    }

I assume the question is whether task_can_sched_on_preferred() would
have to be changed:

- return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
+ return cpumask_first_and_and(p->cpus_ptr, cpu_preferred_mask,
+                               task_cpu_possible_mask(p)) < nr_cpu_ids;

so that cpu_preferred_mask can play together nicely with the 'asymmetric
AArch32 EL0 (executing 32-bit Arm userspace under an AArch64 kernel)
support' feature on some mobile Arm64 Socs.

IMHO, this is not necessary since for those tasks p->cpus_ptr is always
a subset of task_cpu_possible_mask(p). 'p->cpus_ptr ∩
cpu_preferred_mask' already cannot contain an architecturally impossible
CPU for those 32-bit Arm userspace tasks.

[...]

