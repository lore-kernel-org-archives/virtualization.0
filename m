Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA25332EA0;
	Thu, 18 Dec 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046899; cv=none; b=rewexHNwVmr12fwaCbRihKkBlcHrsAf6LBCm78R3QLl2CrbV+rLF7OfKc1LHqnaFPE6p5Z6IFymIQeFGDYXtC0d1Hk9AVfLlqq/TGYRHpwo50iP2y1een5w5iBONISvg129BZHY4VMN0Thh0h/jHkxee9MV0UZSzIhEP63UfCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046899; c=relaxed/simple;
	bh=Rve+k5ouwDO8Ts5aGhR1C0iR3jDtoVi/hUyKruMxUlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKbAWJTOhpfKAd4ZvtCvcmg/K+32arNn/Rfm0roOTLrQ4anBPy9Zmc33wjfG/NONUUD/SPEQrTYF5S5Gd8dtUQHhvyfgcB2fMafRQvb8+YppRpI3NAS4jrqsJLQwC8Nw8kp1p5muxkbqmgYzBoPJj6oDJ0X5KP6n5sPy0X6+CVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d64qoccb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d64qoccb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43800C4CEFB;
	Thu, 18 Dec 2025 08:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766046899;
	bh=Rve+k5ouwDO8Ts5aGhR1C0iR3jDtoVi/hUyKruMxUlY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d64qoccbo4VdAqJdwzCQWYFiyi/rzFsAdBm8s/RjL1cRJCVN5DzwU+8Ni186Aai/1
	 LiPZ1Aou5T7AxvlJg7CQ343DR4MXd+WhbOZ9ldHrVW6qNeUXPNtZgc3/nZP5G8hXoT
	 rHcB4yLGOBNTDERlP0LDcqoXbgBwoZ3R980h7uyGttHZXCcgJ0tedbLtiJk2G1yYkm
	 DTR5WufwCxIfQ3hbLGTUv62SHxr2I7caXxc6EmikDFtDV12janDtl+CRSbHhHTyylp
	 PVYvG8MW89x9eoO6xqHVSQ23ctvHtS3J4t+KwBXd+3qbee818kxiuYsT5VaCz0owdy
	 p2vsmQ6RnCt5w==
Message-ID: <591e102d-e8cc-4e9b-9fa2-cf5a782ed40b@kernel.org>
Date: Thu, 18 Dec 2025 09:34:55 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] virtio_balloon: do not set pr_dev_info.report
 unconditionally
To: Michael Kelley <mhklinux@outlook.com>,
 Dongli Zhang <dongli.zhang@oracle.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251209212311.64885-1-dongli.zhang@oracle.com>
 <0d9f302a-301c-4335-9c78-bcccab824a9f@kernel.org>
 <38ef7c75-195a-4145-bf35-3955aea8dd0d@oracle.com>
 <BN7PR02MB4148C75ACA806BAEEEC4351BD4ABA@BN7PR02MB4148.namprd02.prod.outlook.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <BN7PR02MB4148C75ACA806BAEEEC4351BD4ABA@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 05:52, Michael Kelley wrote:
> From: Dongli Zhang <dongli.zhang@oracle.com> Sent: Wednesday, December 10, 2025 11:10 AM
>>
>> Hi David,
>>
>> On 12/10/25 12:09 AM, David Hildenbrand (Red Hat) wrote:
>>> On 12/9/25 22:23, Dongli Zhang wrote:
>>>> Do not set vb->pr_dev_info.report unconditionally if
>>>> VIRTIO_BALLOON_F_REPORTING is not available.
>>>
>>> Can you share with us why you think that should be done? Please document the
>>> "why" and not only the "what".
>>>
>>> Without VIRTIO_BALLOON_F_REPORTING, we'll never call page_reporting_register(),
>>> so it will never be used.
>>>
>>> But the compiler cannot optimize it out. It only happens during driver loading,
>>> so I am not sure it is worth the churn?
>>
>> When I was reading about the free-page reporting feature in virtio-balloon, I
>> was confused as to why pr_dev_info.report was always configured unconditionally.
>>
>> Later, I looked at the implementation in the Hyper-V balloon driver and noticed
>> that it even resets pr_dev_info.report back to NULL if page_reporting_register()
>> fails (see line 1669).
> 
> The Hyper-V balloon driver does this because it uses the NULL in pr_dev_info.report
> to indicate if page_reporting_unregister() should be called when the driver exits.
> See disable_page_reporting(). Unlike the virtio balloon driver, the Hyper-V
> balloon_probe() function succeeds even if page_reporting_register() fails, so
> some indicator is needed on exit.  I didn't look super carefully, but it appears the
> virtio balloon driver doesn't need such an indicator.

Nothing is broken AFAIKT.

The patch description should be updated to reflect why we would want to 
do that given that nothing is broken.

No strong opinion on the patch with an updated patch description from my 
side.

-- 
Cheers

David
