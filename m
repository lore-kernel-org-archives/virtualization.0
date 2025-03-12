Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1924293C
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783285; cv=none; b=Zvy8XS3CWJ4/TaFQVfKFIVU+wUU9FcRvIl0TwHGHj+nhvcj1VMJpsxFHm91E0IssBLms1jThJO/OKiyKpW25GsoFHsSjAgR+Sh+nQuf4jOmoPy1mgFFef6E2zmwRYoDEAlAbfhwQXLZWH+DEt99qReiOV3n40TZ1sC3/hQNJxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783285; c=relaxed/simple;
	bh=/gFBfjP5wMjeSlpjUQ0wcsO/6jE1wnulS8MRvTH6J/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAaD8Fm6hPYNYaKL1OgXByCFFlJ2/7GdZczCaUUQ55WiS/DTrTj8SqF2TK4H5QXgxmYjQ1g3B7QchdBnWpOGAXmeLUGQaDoyhjEAAiznQxAPnSPn0P5/92FFYY8hofI/vnO4luS6qhO0blbZmfbhjmCMqVxDuYY+9DNhlYckY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cEi5E9jL; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cEi5E9jL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741783278; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=byoy4lGPHlk+/7jnyQFo8ZlkUybA3oGJHC4262MlS70=;
	b=cEi5E9jLFprm8Xw8VE8tUeXpIaz/jyq7/J8QPl5WgDvZQhLhhNKBIyxh0YFlgwo4iMgTXREp/QrQwJPFq0dlARdvuC4Sp3YvviEtRgob/qWas8gHg0wf+gUQJypmlfMo+stc6MNLoR4D8n61F/kR45byqdJ4lmpeM8jQk4mr0lE=
Received: from 30.74.129.75(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WRCvGy4_1741783275 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Mar 2025 20:41:15 +0800
Message-ID: <0ca82e20-1424-4564-972f-4f7ffb73ccaf@linux.alibaba.com>
Date: Wed, 12 Mar 2025 20:41:14 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
To: Yunsheng Lin <linyunsheng@huawei.com>, NeilBrown <neilb@suse.de>
Cc: Yunsheng Lin <yunshenglin0825@gmail.com>,
 Dave Chinner <david@fromorbit.com>, Yishai Hadas <yishaih@nvidia.com>,
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
 <14ef70cc-beba-4abb-b206-e9fb29381023@linux.alibaba.com>
 <c5cdd730-1e11-4440-849d-8841b5ce86ef@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <c5cdd730-1e11-4440-849d-8841b5ce86ef@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/3/12 20:05, Yunsheng Lin wrote:
> On 2025/3/12 9:45, Gao Xiang wrote:
>>
>>
>> On 2025/3/12 06:55, NeilBrown wrote:
>>> On Mon, 10 Mar 2025, Gao Xiang wrote:
>>>>
>>>>     - Your new api covers narrow cases compared to the existing
>>>>       api, although all in-tree callers may be converted
>>>>       properly, but it increases mental burden of all users.
>>>>       And maybe complicate future potential users again which
>>>>       really have to "check NULL elements in the middle of page
>>>>       bulk allocating" again.
>>>
>>> I think that the current API adds a mental burden for most users.  For
>>> most users, their code would be much cleaner if the interface accepted
>>> an uninitialised array with length, and were told how many pages had
>>> been stored in that array.> A (very) few users benefit from the complexity.  So having two
>>> interfaces, one simple and one full-featured, makes sense.
> 
> Thanks for the above clear summarization.
> 
>>
>> Ok, I think for this part, diferrent people has different
>> perference on API since there is no absolutely right and
>> wrong in the API design area.
>>
>> But I have no interest to follow this for now.
> 
> Just to be clearer, as erofs seems to be able to be changed to
> use a simple interface, do you prefer to keep using the full-featured
> interface or change to use the simple interface?

Please keep using the old interface because I don't have any
bandwidth on this considering no real benefit.

Thanks,
Gao Xiang

