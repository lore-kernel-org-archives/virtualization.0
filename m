Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2252DB788;
	Fri,  8 May 2026 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228597; cv=none; b=i1Z1UZsMamUMOrAeY+EU5cjyS1anSsroDpoR+Kval12qQ0wXVLpbMjGAfHa7Qs6Ik3TtvaIuRi2YTgx2pPXLca7/4I1++wSEjNnoOSZpcv3I1zHPhUk3WpZQF0xHFsLlVOcQjXaD9a+olM4XhQlKskfCDun125wcAfx5JGEBeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228597; c=relaxed/simple;
	bh=AZSH1aed+aRyFeiqpVQVKh2ig107hRMsr9gFf+iwgm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4ho3tsB1ej01OuQ+UcsX+GksHJ/0vNYdhaW1+bSBLkZKPJgx9kW4i1WHJC03F0MOfoD4za5scM+L6yNQJ9Ed3Z70zhOn6zt74SYHYozS3RobcrGKtwBEpBkNp9NceGG5Bvy2nVVuJZA3N8vaSSjMuc4w4ukeOOvlXCVx5fhk3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtNX58a/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtNX58a/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E5FC2BCB0;
	Fri,  8 May 2026 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778228596;
	bh=AZSH1aed+aRyFeiqpVQVKh2ig107hRMsr9gFf+iwgm8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HtNX58a/tSIDk8w+CiRfG+uyCqk6W9935tHeKXz6YCrbVb85fakiGpQ09N4BTtw0/
	 kr70kIdHjuZETsFlKhcgjpFc6OYxanEg0qHkvDDZtyM1mGNaQiHga6Z0nhYO7UNKSd
	 IwxDoPQ1oBM7NxeaXtYcnkULDiycrIBQntzj0TQ7CyDAwNx05Fac+jJRMi0NKjYilr
	 xw7F2VNs40zDXbne5VwaRnVORXWItFMFCCRzCsvXjSHfTvjxKQEyz0ZUxuDAQNJJef
	 ShT29tCp+BPJgLMc4djicSDhIEMeqD1CU9PnQs7lx/0kg057ZNjw6IpKZ6VcBaRAo4
	 2AzkLuFTwd+Hw==
Message-ID: <731d7324-4eb7-44d2-bb7d-62b6fbe11c52@kernel.org>
Date: Fri, 8 May 2026 10:23:11 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/balloon: expose per-node balloon pages in node meminfo
To: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260508015316.25722-1-hao.ge@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260508015316.25722-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 03:53, Hao Ge wrote:
> Commit 835de37603ef ("meminfo: add a per node counter for balloon
> drivers") added NR_BALLOON_PAGES and exposed it in /proc/meminfo.
> However, the per-node view at /sys/devices/system/node/nodeX/meminfo
> was not updated, even though the counter is already tracked per-node.
> 
> Add it to node_read_meminfo() so users can see balloon usage per
> NUMA node without having to parse the raw vmstat file.

Using ballooning with vNUMA is rather rare. But sure, why not.

> 
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  drivers/base/node.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index d7647d077b66..53f4e51d6d82 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -513,6 +513,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>  			     "Node %d Slab:           %8lu kB\n"
>  			     "Node %d SReclaimable:   %8lu kB\n"
>  			     "Node %d SUnreclaim:     %8lu kB\n"
> +			     "Node %d Balloon:        %8lu kB\n"
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  			     "Node %d AnonHugePages:  %8lu kB\n"
>  			     "Node %d ShmemHugePages: %8lu kB\n"
> @@ -543,7 +544,8 @@ static ssize_t node_read_meminfo(struct device *dev,
>  				    node_page_state(pgdat, NR_KERNEL_MISC_RECLAIMABLE)),
>  			     nid, K(sreclaimable + sunreclaimable),
>  			     nid, K(sreclaimable),
> -			     nid, K(sunreclaimable)
> +			     nid, K(sunreclaimable),
> +			     nid, K(node_page_state(pgdat, NR_BALLOON_PAGES))
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  			     ,
>  			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),


Shouldn't it be placed under "Unaccepted:", just like for /proc/meminfo?

-- 
Cheers,

David
