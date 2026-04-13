Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B11D6195;
	Mon, 13 Apr 2026 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067265; cv=none; b=nPAXwYm/F7WhhT541soFBJFnfJWmC5sWdZUkzd399vrDG/zO/WCZt/mJf5KZaIRtw6D9TK0kUfziZ57/hPCOL0M6US9K61DuT/GC0NYM7sD3nLKdFTQ8LtLZrkVMr2oBKykGf51Y36AV566Krld7IxO2NUX9z6FUh+q2bLAaH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067265; c=relaxed/simple;
	bh=Dv7rLgRxaQyaXKOhIrU9lBrg6emFdyTCNfKJQnzziRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcQBbIKUA1+t85DRtXwC6akwhZCHGNrqm3SCg+CXoiSxKxOrMdZ+4ipVhMu5u/02WglB1tPBbvp2dpp/tXHYt52X3t6UNmQ64rRrQdQfY/J10DH5rRTbV9dANufHBD2fm+E6gFU5/qgCE8VtYZ4iGx91xoAlAauMug9+Lr1A8iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLi6fXK/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLi6fXK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71EBC116C6;
	Mon, 13 Apr 2026 08:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776067264;
	bh=Dv7rLgRxaQyaXKOhIrU9lBrg6emFdyTCNfKJQnzziRE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SLi6fXK/84wyujeUHZY6lqwyBwzqkfbzveBT2343+SH7OI4D3tVRv9VPjdLXbTmPL
	 mJvfJKna2E7lpCtWszw4jYS1FPMJSLrY3y05xfLE5FkvtwofhmIQfKWx1/b///ht9U
	 TL4P+7auOiqCmnDhy255YWGWvKcwpH2c3RSUyaz3506/WZZDJ46y4PTttAKZUHn6k1
	 bxqFSzqsUFpucssvV1a+yXNUJBYbDmOSja/WAUD7CjMq5cnKqzI16hjSaZ0vcj+7dy
	 OLOFEyzRTFPBzAH7exsVIn/acrZTaXTj3mTB3EAwcklO5i4RFTa/xo9ryTzUngvUIb
	 Q3VC4cphQRNUg==
Message-ID: <2155527a-e077-4b71-80ee-d735f9984f60@kernel.org>
Date: Mon, 13 Apr 2026 10:00:58 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/9] mm: page_reporting: skip redundant zeroing of
 host-zeroed reported pages
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Jason Wang <jasowang@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
 linux-mm@kvack.org, virtualization@lists.linux.dev,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>
References: <cover.1776033471.git.mst@redhat.com>
 <ea67e39bc3aea1b0b491908f851ffce25154cd26.1776033771.git.mst@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ea67e39bc3aea1b0b491908f851ffce25154cd26.1776033771.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/26 00:50, Michael S. Tsirkin wrote:
> When a guest reports free pages to the hypervisor via the page reporting
> framework (used by virtio-balloon and hv_balloon), the host typically
> zeros those pages when reclaiming their backing memory.  However, when
> those pages are later allocated in the guest, post_alloc_hook()
> unconditionally zeros them again if __GFP_ZERO is set.  This
> double-zeroing is wasteful, especially for large pages.
> 
> Avoid redundant zeroing by propagating the "host already zeroed this"
> information through the allocation path:
> 
> 1. Add a host_zeroes_pages flag to page_reporting_dev_info, allowing
>    drivers to declare that their host zeros reported pages on reclaim.
>    A static key (page_reporting_host_zeroes) gates the fast path.
> 
> 2. In page_del_and_expand(), when the page was reported and the
>    static key is enabled, stash a sentinel value (MAGIC_PAGE_ZEROED)
>    in page->private.
> 
> 3. In post_alloc_hook(), check page->private for the sentinel.  If
>    present and zeroing was requested (but not tag zeroing), skip
>    kernel_init_pages().
> 
> In particular, __GFP_ZERO is used by the x86 arch override of
> vma_alloc_zeroed_movable_folio.
> 
> No driver sets host_zeroes_pages yet; a follow-up patch to
> virtio_balloon is needed to opt in.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  include/linux/mm.h             |  6 ++++++
>  include/linux/page_reporting.h |  3 +++
>  mm/page_alloc.c                | 21 +++++++++++++++++++++
>  mm/page_reporting.c            |  9 +++++++++
>  mm/page_reporting.h            |  2 ++
>  5 files changed, 41 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5be3d8a8f806..59fc77c4c90e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4814,6 +4814,12 @@ static inline bool user_alloc_needs_zeroing(void)
>  				   &init_on_alloc);
>  }
>  
> +/*
> + * Sentinel stored in page->private to indicate the page was pre-zeroed
> + * by the hypervisor (via free page reporting).
> + */
> +#define MAGIC_PAGE_ZEROED	0x5A45524FU	/* ZERO */

Why are we not using another page flag that is yet unused for buddy pages?

Using page->private for that, and exposing it to buddy users with the
__GFP_PREZEROED flag (I hope we can avoid that) does not sound
particularly elegant.

Also, if we're going to remember that some pages in the buddy are
pre-zeroed, it should better not be free-page-reporting specific.

I'd assume ordinary inflating+deflating of the balloon would also end up
with pre-zeroed pages. We'd just need a (mm/balloon.c -specific)
interface to tell the buddy that the pages are zeroed.


-- 
Cheers,

David
