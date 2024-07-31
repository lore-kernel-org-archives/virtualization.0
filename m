Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E416A948
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422727; cv=none; b=MI8bvFirck16NA8nB8JSnM0ydH5BB0XvbMm3W3S3wTZ1mtThfoeM+1eWgdvuuxxb1DHayH0DG2WuPM1bD0+KlBgBzdJF4nHDpoMva6DIJMrnxvCCPtqFZuGVvqnQ6VbCwsEQGyaykpOKwryvpOo7pNOxHBYz6hF0jXouo+QfyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422727; c=relaxed/simple;
	bh=wM20x3+hPXUVoeB4tNx6BSWwkFCyTBfaSpgcFMnLKII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxBo6PdH3COkeW7tT315eb2UOp8aU69t7dMtQZXjpPmmU2IWaUEm1ZD8iOYFi0FlMl/ctzQc89M3t2QqmdmVLCzPRaWXFM8AtCe2PRwsSEpOgBxw598z1RCci+CZMtx7PmjjVOQ8n+o4Mip7YaqOvpidRxMaSCoZjmrA8P6fYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46VAigo9018357;
	Wed, 31 Jul 2024 19:44:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Wed, 31 Jul 2024 19:44:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46VAifOL018354
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 31 Jul 2024 19:44:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9f1d0f2b-ee22-48b7-ba60-d7b886572670@I-love.SAKURA.ne.jp>
Date: Wed, 31 Jul 2024 19:44:41 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
To: Vlastimil Babka <vbabka@suse.cz>, Barry Song <21cnbao@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org,
        iamjoonsoo.kim@lge.com, lstoakes@gmail.com, mhocko@suse.com,
        penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
        torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com,
        virtualization@lists.linux.dev, Kees Cook <kees@kernel.org>
References: <20240731000155.109583-1-21cnbao@gmail.com>
 <20240731000155.109583-4-21cnbao@gmail.com>
 <b1f4d2eb-ad6d-4ddf-91f5-f1ad0171789a@suse.cz>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <b1f4d2eb-ad6d-4ddf-91f5-f1ad0171789a@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/31 19:29, Vlastimil Babka wrote:
>> @@ -827,8 +827,10 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
>>  {
>>  	size_t bytes;
>>  
>> -	if (unlikely(check_mul_overflow(n, size, &bytes)))
>> +	if (unlikely(check_mul_overflow(n, size, &bytes))) {
>> +		BUG_ON(flags & __GFP_NOFAIL);
> 
> Shouldn't we produce some kind of warning also in the no-NOFAIL case?
> Returning a NULL completely silently feels wrong.

Doesn't embedding macros like BUG_ON() into inline functions needlessly bloat
the kernel size? I think we can call a non-inlined function (that is marked
as EXPORT_SYMBOL()) for emitting warning.

