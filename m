Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FAC3E959C
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265319; cv=none; b=fvaZMihllGD2ZdZzFlbaHyDgm8HiHCu8J1ew4sFgdPDZx4hxasdWAHtZCucAHSRWGnbwC7jZVoJViGqTT509hDXAtYd+sGJ88Jy8jOWgkUtUWQXNdsOfNlXcNo70NIE/BiWOqj7KaWCo3yuwRT1eHSVho3zpeQttUQhAqBOI6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265319; c=relaxed/simple;
	bh=GTAV1btrciy8QWORbwi47W3ulx/1ZieXdXfDbZrZxsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IInOFpHSLHpHcpifuEGX0j0lFArLgf9ePbsb3jfGWCnGo3xqVYTAj/OW79gQnXjpVjjA3RFeQjtn0uEVnkLuH+69GVeJwk42+xf7YXO3LKqxdehYDp/ELGJAaJRAV1UJQE/kqoAgRk+MO1Gy5Pu2f6B3EvghTNvlxaqkThRdDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fTQWBEmy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fTQWBEmy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8F351756;
	Tue,  1 Sep 2026 05:21:51 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68BBE3F85F;
	Tue,  1 Sep 2026 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788265315; bh=GTAV1btrciy8QWORbwi47W3ulx/1ZieXdXfDbZrZxsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fTQWBEmyPuLjDIFIOCsXXBnQ6v5dqPWKi5VUWTFfbkkypETbpDop7Xbd0kaRH7EON
	 /M7epJ8PP7scyLzzpTqJSvL6JOuikn59kEtFuQqudt4R8rEQinSRDadvhPXOKsqu6F
	 9/2xo6l5xY0mb4wZQFr8kq6RHiln9PGVi2UeGvJs=
Message-ID: <3368b089-32ce-4521-ab19-e37c9f029b8b@arm.com>
Date: Tue, 1 Sep 2026 14:21:40 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/12] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Yury Norov <ynorov@nvidia.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
 mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
 yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
 corbet@lwn.net, meted@linux.ibm.com, tglx@kernel.org,
 gregkh@linuxfoundation.org, pbonzini@redhat.com, seanjc@google.com,
 vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org,
 maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com,
 chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org,
 arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com,
 tj@kernel.org, tommaso.cucinotta@gmail.com, maz@kernel.org,
 rafael@kernel.org, rdunlap@infradead.org, kernellwp@gmail.com,
 linux-doc@vger.kernel.org, jgross@suse.com, virtualization@lists.linux.dev,
 sunlightlinux@gmail.com
References: <20260825103855.721013-1-sshegde@linux.ibm.com>
 <20260825103855.721013-6-sshegde@linux.ibm.com>
 <8262d2f9-9f2f-4821-8497-991d7c8448a3@arm.com> <apMziCV_8y0xeIBT@yury>
 <53035ba4-53ec-4907-93b8-c8b957d1fa61@linux.ibm.com>
 <CAKfTPtA5Bdw89hezn1wi_p0m0dJgJJ1GYg8H93PsvsMC4bVJxA@mail.gmail.com>
 <apWxmL_brfi4fa4z@yury>
 <CAKfTPtA4zmD=0Es2cXSHAodTZGLJPvv88s0_4QScp745PxFVMw@mail.gmail.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtA4zmD=0Es2cXSHAodTZGLJPvv88s0_4QScp745PxFVMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01.09.26 08:21, Vincent Guittot wrote:
> On Mon, 31 Aug 2026 at 18:54, Yury Norov <ynorov@nvidia.com> wrote:
>>
>> On Mon, Aug 31, 2026 at 05:09:41PM +0200, Vincent Guittot wrote:
>>
>>>> Dietmar/Vincent,
>>>> Do you think it makes sense to enable the driver on ARM64 now?
>>>> Or you think it is better to delay it and once the feature is stable
>>>> ARM ecosystem can enable it?
>>>
>>> It's always better to support all arch by default, unless something is
>>> missing which is not the case here.
>>
>> ARM64 testing is obviously missed.
> 
> But the cpumask is already available not like if you need to create a new one

IMHO, when testing the steal_governor on arm64 w/o
`allow_mismatched_32bit_el0`, I wouldn't expect much difference in this
respect compared to the architectures already tested.

Also, AFAIK, `allow_mismatched_32bit_el0` was mainly relevant for
Android devices up to Android 13 that supported 32-bit userspace, so I
wouldn't expect it to be commonly enabled on recent devices.

As Vincent pointed out, `task_cpu_possible_mask(p)` (which defaults to
`cpu_possible_mask`) is already used in `kernel/sched/core.c` and
`kernel/cgroup/cpuset.c` to support `allow_mismatched_32bit_el0`.

