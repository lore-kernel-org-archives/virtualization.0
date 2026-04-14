Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81146237713;
	Tue, 14 Apr 2026 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157589; cv=none; b=P/8IWTqapMMyrVPnYK66ra9uPlf0ZA4FHKGIsE1k2AHcS1W/En6GPiYX5GgneHK3/ZpH5uLn615pADEuBkgl1fY050tjHdfPJsO9cfqeReGXnJEV+1kriReZ+2uHemxqLsHuRp4nxvZ0+ZiXHTYdud9HoBZLHoeznQDwyEAA2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157589; c=relaxed/simple;
	bh=0HFC6LCOCRUWWKTQwlg+7vyB5B5S9zxAroCeUQNKVzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQZuf/PrKNZB50NcJT1NnOK3DfvXetEMD5WUNE/Eggm5YTS+bdm5AkLIA9j6QL87t/Qon2q+2Accb4w1yKh6WyM81FYlhg+BJ3ToqcYxf52AjRKImaZCRnK0bSnSg0yfrfdNkk2GwO1vuEjIojcTQuIm5645TX7lk2s/7Y7RdaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEKOe/7Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEKOe/7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CBFC2BCB4;
	Tue, 14 Apr 2026 09:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776157589;
	bh=0HFC6LCOCRUWWKTQwlg+7vyB5B5S9zxAroCeUQNKVzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WEKOe/7Q4DyG+Sd0Uopd1VpE9hHy2EIMoKq1irldHH+xBpWvdSJssIybd7Vy9jHgc
	 8K2BoBZef1SgIOoxgFAsZVB9gR+04RauyXozQmJcMCJAJja+tF+vozv8xh7fbp3sOG
	 jV0eh7ApHl/s1PDIsjsCS5I98FxGNh/lxVw9ViZydRdaenFkiuD6FCSgv1a89fxfpW
	 a6KKEKTu6BhIP64FlymRJNOQsWXFCiW6qYmbsk70lxatU6M6+8FXQj61KecuQqjsID
	 EzOs7h9P1x5HU5Xz1Hq8Ngs7NH1IOkA6XnO6iu3SLxmUPkaEtkpc/ow8gvMnVR8iCH
	 LnN8QqPpZ891g==
Message-ID: <ccb1f5ef-20d0-4720-8904-f6af52b896c7@kernel.org>
Date: Tue, 14 Apr 2026 11:06:22 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/9] mm: add __GFP_PREZEROED flag and
 folio_test_clear_prezeroed()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Jason Wang <jasowang@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
 linux-mm@kvack.org, virtualization@lists.linux.dev,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>
References: <cover.1776033471.git.mst@redhat.com>
 <b21b0ba353330f24b9e10ee5bf01b60f32043327.1776033771.git.mst@redhat.com>
 <b258160c-5287-43dd-b56e-268c403b85ea@kernel.org>
 <20260413180303-mutt-send-email-mst@kernel.org>
 <20260413184022-mutt-send-email-mst@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260413184022-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 01:43, Michael S. Tsirkin wrote:
> On Mon, Apr 13, 2026 at 06:06:14PM -0400, Michael S. Tsirkin wrote:
>> On Mon, Apr 13, 2026 at 11:05:40AM +0200, David Hildenbrand (Arm) wrote:
>>
>> ...
>>
>>> (2) Use a dedicated allocation interface for user pages in the buddy.
>>>
>>> I hate the whole user_alloc_needs_zeroing()+folio_zero_user() handling.
>>>
>>> It shouldn't exist. We should just be passing GFP_ZERO and let the buddy handle
>>> all that.
>>>
>>>
>>> For example, vma_alloc_folio() already gets passed the address in.
>>>
>>> Pass the address from vma_alloc_folio_noprof()->folio_alloc_noprof(), and let
>>> folio_alloc_noprof() use a buddy interface that can handle it.
>>>
>>> Imagine if we had a alloc_user_pages_noprof() that consumes an address. It could just
>>> do what folio_zero_user() does, and only if really required.
>>>
>>> The whole user_alloc_needs_zeroing() could go away and you could just handle the
>>> pre-zeroed optimization internally.
>>
>> I looked at this a bit, and I think the issue is that the buddy
>> allocator doesn't do the arch-specific cache handling.
>> So allocating it is a fundamentally different thing from GFP_ZERO which
>> is "zero a kernel address range".
>>
>> So I don't get how you want to do it.
> 

Saw your new mails just now.

> Oh, wait, do you mean we thread the userspace address through all the allocation calls?
> Like the below? This is on top of my patches, on top of mm it will be
> a tiny bit smaller.  I can rebase no problem.
> 
> But: isn't it a bit overkill for something that is, in the end, virtualization specific?
> It's all mechanical threading through of user_addr, but should we miss
> one place, and suddenly you get weird corruption on esoteric arches
> since we will get memset instead of folio_zero_user.
> 
> Worth it?

See my other mail, we'd be forwarding it only for
vma_alloc_folio_noprof(), where we call a _user specific interface.

Then we can get rid of the user_alloc_needs_zeroing() hack and just do
the right thing in page_alloc.c

-- 
Cheers,

David
