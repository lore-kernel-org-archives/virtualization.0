Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5A2417D9
	for <virtualization@lists.linux.dev>; Sat,  9 May 2026 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778289305; cv=none; b=RiyeN8vBxmNpjTzu/hOjNtt7ctBG7rUPD5fpqEW68mZhT+iarb1RsksadQWUEM3G0Qgxc/SprMTntKBd5OkitxVR50hliYUlBjSx0aM0sRU3ChpY26YrramKahGTnpdOY+a1XqgUOpSMvKryMGPPd9GoD+it5QIi3GWW5f/G350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778289305; c=relaxed/simple;
	bh=1FTzIP6XdlxlM5MValVNM2r92M1W6UqCZqQfTyfOvTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwAPpQapPSqyPbqr8YeGIfgZNqNfeVl4oakN3WehMxNNtdMK7knvS8bZeqVaf8g2LnxZ+r7Jusmuev+NHUnmPHlB4WKbm3/GJc95J2iiM8cq8pZKjLMNS55j4BM5YzHfx3VUOEafQKS4/XoO3JMGY8ZA/xMT/oYtdfysyUyxCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kE+1WHJ3; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kE+1WHJ3"
Message-ID: <00e55713-c79c-4389-a6d2-aaec95b3fa61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778289299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sarj65PYwDnpWFGzTavLfX9I3MyvSLzMLM5BZfpx3ww=;
	b=kE+1WHJ3l7qxs9SYsCeS5loiB7c1IS+rfUUzbf9tBfyAB7NQoAi3tNKKY2haeEvod2MFra
	qhUzWo/KxOqU8qi8OWd/U+jkmHXmfx3My9JFhjSutM3UIYlqzFuDu+auipz7CiTHByvhrJ
	HYk8RvEW5iZl5XW/cAd8Ammn2qgRCps=
Date: Sat, 9 May 2026 09:14:18 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/balloon: expose per-node balloon pages in node
 meminfo
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, linux-mm@kvack.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260508094736.142467-1-hao.ge@linux.dev>
 <20260508113123.c8e653484d39e76cdd6e142e@linux-foundation.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20260508113123.c8e653484d39e76cdd6e142e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Andrew


On 2026/5/9 02:31, Andrew Morton wrote:
> On Fri,  8 May 2026 17:47:36 +0800 Hao Ge <hao.ge@linux.dev> wrote:
>
>> Commit 835de37603ef ("meminfo: add a per node counter for balloon
>> drivers") added NR_BALLOON_PAGES and exposed it in /proc/meminfo.
>> However, the per-node view at /sys/devices/system/node/nodeX/meminfo
>> was not updated, even though the counter is already tracked per-node.
>>
>> Add it to node_read_meminfo() so users can see balloon usage per
>> NUMA node without having to parse the raw vmstat file.
>>
>> ...
>>
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -523,6 +523,7 @@ static ssize_t node_read_meminfo(struct device *dev,
>>   #ifdef CONFIG_UNACCEPTED_MEMORY
>>   			     "Node %d Unaccepted:     %8lu kB\n"
>>   #endif
>> +			     "Node %d Balloon:        %8lu kB\n"
>>   			     ,
>>   			     nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
>>   			     nid, K(node_page_state(pgdat, NR_WRITEBACK)),
>> @@ -556,6 +557,8 @@ static ssize_t node_read_meminfo(struct device *dev,
>>   			     ,
>>   			     nid, K(sum_zone_node_page_state(nid, NR_UNACCEPTED))
>>   #endif
>> +			     ,
>> +			     nid, K(node_page_state(pgdat, NR_BALLOON_PAGES))
>>   			    );
>>   	len += hugetlb_report_node_meminfo(buf, len, nid);
>>   	return len;
> This was prepared against a kernel whcih didn't have 2232ba9c7931 ("mm:
> add gpu active/reclaim per-node stat counters (v2)").  Which was added
> in February, btw.

Sorry about that — I failed to git pull the latest code before preparing 
the v2 patch,

so I didn't realize commit 2232ba9c7931 ("mm: add gpu active/reclaim 
per-node stat counters (v2)")

had already been merged in February.

I apologize for the trouble this caused you.

> Please check my fixings:
>
> --- a/drivers/base/node.c~mm-balloon-expose-per-node-balloon-pages-in-node-meminfo
> +++ a/drivers/base/node.c
> @@ -525,6 +525,7 @@ static ssize_t node_read_meminfo(struct
>   #endif
>   			     "Node %d GPUActive:      %8lu kB\n"
>   			     "Node %d GPUReclaim:     %8lu kB\n"
> +			     "Node %d Balloon:        %8lu kB\n"
>   			     ,
>   			     nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
>   			     nid, K(node_page_state(pgdat, NR_WRITEBACK)),
> @@ -560,7 +561,8 @@ static ssize_t node_read_meminfo(struct
>   #endif
>   			     ,
>   			     nid, K(node_page_state(pgdat, NR_GPU_ACTIVE)),
> -			     nid, K(node_page_state(pgdat, NR_GPU_RECLAIM))
> +			     nid, K(node_page_state(pgdat, NR_GPU_RECLAIM)),
> +			     nid, K(node_page_state(pgdat, NR_BALLOON_PAGES))
>   			    );
>   	len += hugetlb_report_node_meminfo(buf, len, nid);
>   	return len;
> _

As David suggested, the node meminfo fields should match the 
/proc/meminfo ordering.

So in the v3 I rebased on the latest tree and put Balloon between 
Unaccepted and GPUActive.

Here is the v3 patch: 
https://lore.kernel.org/all/20260509005631.17183-1-hao.ge@linux.dev/

  Sorry again for the inconvenience, Could you please replace the v2 
patch in mm-new with this v3?

Thanks

Best Regards

Hao


