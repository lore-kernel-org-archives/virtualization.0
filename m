Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192A42A94
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741743923; cv=none; b=h1viyOxQTLKohCcmyxdWqWu3XbQDuFQrxxlowgN91+HL4q8lzmBmG7FIoFJUdZhSMJqkjh8d2eeZwQBiMJEUsqXAoETAsrXddMFSBBRFG1ImekU5aqPyI4SgHzvdbybhzpBKOuMslRqcqFfMwQft4xrnyjTZvwp/5764D6Gzq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741743923; c=relaxed/simple;
	bh=4Y06xikukVUFXhu/yWSYxg9Jt8t+JmAK+tfE6/N7nT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyLfC5SmjjWqkMBv3zLtfs+0ZeDzR09ifMy1Z/bM9W3PPt1KxGeFq1IGQJ3AwAJNVNEZSLY+Dh/6uIxrFzS4lodUg7onTAc45QuT/g/3znGdCe8pR0k999k12HE/zUrUl2CLvWHw7pNVUm5+7/EBBZCk1Dr8cDJurqUsWv6MRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d0swZMFO; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d0swZMFO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741743913; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pJsIAiBQwxxlPupaINFvaIjtvwWgE2QzMrLd5G9yQKs=;
	b=d0swZMFONYndRVShHlzlIbs5BprWlukz1ndComeKgAiY5+AXJD4ZTgLDtTK9tnpr0lK/CU6CNFXneNdi1Ci+f7pDsSQZEWVveHcUABEwU8+4jak2kcGVjHVB2bvHwIaY2qJs+taMQUouYvYJxaoP6LwGI7qM7eWQqk+nA3Db9B8=
Received: from 30.74.129.75(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRAiBpj_1741743910 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Mar 2025 09:45:11 +0800
Message-ID: <14ef70cc-beba-4abb-b206-e9fb29381023@linux.alibaba.com>
Date: Wed, 12 Mar 2025 09:45:10 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
To: NeilBrown <neilb@suse.de>
Cc: Yunsheng Lin <linyunsheng@huawei.com>,
 Yunsheng Lin <yunshenglin0825@gmail.com>, Dave Chinner
 <david@fromorbit.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Carlos Maiolino <cem@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Luiz Capitulino <luizcap@redhat.com>,
 Mel Gorman <mgorman@techsingularity.net>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org
References: <> <316d62c1-0e56-4b11-aacf-86235fba808d@linux.alibaba.com>
 <174173371062.33508.12685894810362310394@noble.neil.brown.name>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <174173371062.33508.12685894810362310394@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/3/12 06:55, NeilBrown wrote:
> On Mon, 10 Mar 2025, Gao Xiang wrote:
>>
>>    - Your new api covers narrow cases compared to the existing
>>      api, although all in-tree callers may be converted
>>      properly, but it increases mental burden of all users.
>>      And maybe complicate future potential users again which
>>      really have to "check NULL elements in the middle of page
>>      bulk allocating" again.
> 
> I think that the current API adds a mental burden for most users.  For
> most users, their code would be much cleaner if the interface accepted
> an uninitialised array with length, and were told how many pages had
> been stored in that array.> 
> A (very) few users benefit from the complexity.  So having two
> interfaces, one simple and one full-featured, makes sense.

Ok, I think for this part, diferrent people has different
perference on API since there is no absolutely right and
wrong in the API design area.

But I have no interest to follow this for now.

Thanks,
Gao Xiang
