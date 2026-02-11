Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569AD1E832A;
	Wed, 11 Feb 2026 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770841331; cv=none; b=QR4fOR99Z8Z2B+JHwGhtzvhU3JLLHO7/MqeBG9ondeQ6+TKye5k4v+JCY/5uVU587vzL4MMPvt5nHucejNFfqjy5kYZxUDD0YG2n7gZ6A+/PhVhchi26FUUw/OEDBZLbbrwi5iN1M6QoLaaCOza4V0JE/QMyMmdmPxx9ml5qBuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770841331; c=relaxed/simple;
	bh=Nryt9yR8IWQszMc/xT3oiDaSlzo8zN5v512alL9SgEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSLYCeYJ075mHbOgaZuAeZ4S7ReUp/ZeoTBJ/cPR2YGTk1YypCXjPJA9ZhwtyPGVZYkY61HbcQDKsoiOpK/lVOPcw5+Vj7EMx8l4QYFG9dkYwZ8jM+JoDZaLv0K3TE97/QXioi7FkvGMa4bg/zgZRRDHRVM7Qwa4vm/i3cF9IAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJTIo0Vy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJTIo0Vy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F98C4CEF7;
	Wed, 11 Feb 2026 20:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770841331;
	bh=Nryt9yR8IWQszMc/xT3oiDaSlzo8zN5v512alL9SgEw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BJTIo0VyYEGQzEBJ0QNnoAG4V6AlsdBwAS2dno3lc6h6LDXHiTWbvnCNHF1k3X8wL
	 lMpRp7cfUX3XKQObnOhtnWFSCrFHx09N8Lr/fZSwaTmwld0xW8TW1GEpYtU2WYqoNJ
	 H2ncR7NZLIcTD8ihzE3NEPtv/QaC43i1mjhk9md5rxYqy73UwoCNFM5NOSwbbBEmnj
	 5aaYQE+yxX8U1ZpV+BLyFTaQIgR+R0elcXgKeI1mOPoHIbSljuxt4nTe9hXLDykjek
	 mTr3aWSBgg3eXSPppHjRp/iZWZ+twYYHLKvkdkkgs69gniz1ZtNrNSb8gYTquHXmHA
	 MjrxeTZJ/YNsQ==
Message-ID: <7ace0c7b-6a3d-48c4-94ee-de5c91af02c7@kernel.org>
Date: Wed, 11 Feb 2026 21:22:05 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] virtio_balloon: Support wait on ACK for hinting
To: "Thomson, Jack" <jackabt.amazon@gmail.com>, mst@redhat.com,
 jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kalyazin@amazon.co.uk, xmarcalx@amazon.co.uk, jackabt@amazon.com
References: <20260119154236.39412-1-jackabt.amazon@gmail.com>
 <6c3f8061-302e-40c1-829b-2f8555bee70c@kernel.org>
 <dae84252-1d61-499b-8297-54ad41d9a518@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <dae84252-1d61-499b-8297-54ad41d9a518@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/26 17:30, Thomson, Jack wrote:
> 
> 
> On 19/01/2026 3:50 pm, David Hildenbrand (Red Hat) wrote:
>> On 1/19/26 16:42, Jack Thomson wrote:
>>> From: Jack Thomson <jackabt@amazon.com>
>>>
>>> This RFC patch adds a new virtio feature for the virtio-balloon driver
>>> during free page hinting, which will wait on device ack before
>>> committing the range to the free_page_list. The reason for the change is
>>> it allows the device to modify this range without it being reclaimed
>>> from the free_page_list before the ack is sent. As expected, testing
>>> shows this adds overhead to the hinting run duration, increasing it by
>>> ~30% with our Firecracker setup. Currently free page hinting is used
>>> mainly for live migration, but this would open it up for a new use-case.
>>>
>>> We would like to leverage this with MADV_DONTNEED to reduce RSS of a
>>> guest. We'd like to use hinting because of the flexibility of control it
>>> brings compared to reporting, allowing memory to be reclaimed in
>>> deterministic periods. 
>>
>> Can you elaborate in more detail why you don't simply use reporting, 
>> like QEMU?
> 
> Ideally we'd like to use hinting as the API allows us to control when
> this reclamation takes place so as not to impact active VMs. For example
> if we know a VM is idle we can reclaim memory but also cancel the
> reclamation quickly if the VM receives new work (something we can't do
> quickly with the traditional balloon.)
> 
>> Could you instead see optimizations being done to reporting that could 
>> make it fly for your use case?
> 
> One thing that I considered was having reporting running but skip
> reported ranges during active times. But this may lead to missing
> reclamation opportunities.

We could implement a pause+continue option for free-page-reporting 
option. So the device could tell the VM to pause reporting and later to 
restart reporting.

> 
>>
>> Hinting is a rather special case thing only used for reducing VM 
>> migration time in QEMU AFAIR.
>>
> 
> Yeah, its API allowing direct control was what interested us. With this
> extension it made a great pairing just needed the synchronisation to
> make it safe.

Sorry for getting back to you only now.

So, right now the thing is that hinted pages can get reused by the VM 
any time. The hypervisor must detect if that happened and not discard 
the pages in that case.

While that works for live migration with bitmap dirty tracking (and is a 
bit confusing ...), it doesn't work when you want to MADV_DONTNEED that 
memory, because it could be the hypervisor issues MADV_DONTNEED just 
after the VM reused the memory.

So you are proposing to let the VM wait for the ack before possibly 
reusing the pages.



One thing to note is that free page hinting in Linux allocates memory 
through

	alloc_pages(VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG,
		    VIRTIO_BALLOON_HINT_BLOCK_ORDER);

Meaning

a) Limited to MAX_ORDER chunks (e.g., 4MB on x86). This is even bigger
    than the free-page-reporting granularity (pageblock order, 2MB on
    x86)
b) Cannot free memory on ZONE_MOVABLE or CMA in the VM (as these are
    unmovable allocations)

So it's a bit suboptimal.


Also, in contrast to free-page-reporting, these pages are not going to 
get reused unless we run into the shrinker, which is a bit suboptimal as 
well. Free-page-reporting is a lot more optimized for that, as it just 
returns reported pages back to the buddy immediately.


So if possible, I would suggest instead to extend free-page-reporting.

-- 
Cheers,

David
