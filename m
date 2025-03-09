Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9910B2576
	for <virtualization@lists.linux.dev>; Sun,  9 Mar 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527670; cv=none; b=NiWsOPgOM9rKi+vmRHHNaHJTMYDA200cjmCBmGExozqPt7A7H+8gtQ5J1JHoMetMghK0kf6zV/yZbjja58SOdrdivikO3voLcx3BoHd21koTLfRUqgET4g7WPEJ/V0QcdiMuw34XwQhX4quzWsqlX+GjV0ZlcfXK5g/eAYyfV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527670; c=relaxed/simple;
	bh=fLQGO5wiRlZUKjdUjb206YTBiUBA4D9ukOUBp9rUGdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVZdJh3pH/MJCkmowACkVdNLpbYBHA+fKCFcWVxGl041bWcPoFfDnWYZKAw2gQJfCEpeAqXHT8Ypl/rlxaH8GVEyqRLNdHA3nlbdNbTFW2bIat+CmH30Psg4NLFO3eB0nRFP9UHC5GGOEEhRwzneTnrMYylUUdUXpqWsklq6pJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnq9ggbj; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnq9ggbj"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-223fd89d036so64907605ad.1
        for <virtualization@lists.linux.dev>; Sun, 09 Mar 2025 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527668; x=1742132468; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbqFVYGZKiXAHZ9rqZe+rnsj7EpBf3DH/8Ue+vs/s7U=;
        b=bnq9ggbjjCqvH1rLgW9lI9I+rK/ClUHmHPb9FFzLRStwOBeYIwsCtIkUy6XQj9U/bH
         2K+CP3I5dNYdKSLL2TBueqa0tHQvwIQx4aJPAGkXS285/T1x8NiBuH+E4thN5NPANXwp
         sur8lQxPljaZqbN38fPrZkK8epEQ2DOUmpKXHRLzGOwiCGEZAL6eAU/J2nlHa2b+x8D7
         wlP/UUQRQwGjOVodbMM2wkQQut+SyFDe1bMIt1Ha2VIOVMXSC4Yj2bxZyKIpWLuQmIua
         Vqd//O16ll2yUtJC6KwYodEkeQO8kSAeEXvDOjE9ylossmXWaz+/6RvFfgp5UVQDCV/4
         PrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527668; x=1742132468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbqFVYGZKiXAHZ9rqZe+rnsj7EpBf3DH/8Ue+vs/s7U=;
        b=w3Xeh0woeqDuWnuuL/BhoxqA9SHzaU/wVvYG2LuZsGIbjqgfiMiavFfD1EZHB6fKMm
         Gctt5/zdRP+TKcTlIWh7nKJctwEzbGzBJllHCO6opZ4+/WPf1sKIcYO6FccygeaCok5S
         HgWauBmb7vMa9eaBR/uqaAymSUWL8q4Lzo7RmTKo6Tylo8hg+b81izfSUjA21Tl6dEZQ
         km9LfHJtVl9wuffzBF76vuX0tQ4w4qrGnDlSL7getZ2RbABDR1Tm/KTNCgDdCSaT1Uhb
         gCZi7Dr67Igx9KNAMm5QvsS7FZ3Iyj/T1JAtrn7ZXrcRlCf18LYi9pzIAkd7debNuh5f
         hOvg==
X-Forwarded-Encrypted: i=1; AJvYcCXyzzTRgqDoOQFvDC2q301k57wKmCEjCtXdkK63fU4v/6BROZApVYgcgc13MgLeSGp/E8P11JZK6EUVFpeKXA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yww1L6b7/UFchdMXRJL9p9496TDNWKTkIJ+NokDpbUdOAzoCP+S
	ha+1HNS+KQxMPNop5kE+lzNKPiQq1pV2v0BdZbVzVfc+QW6Vyhqk
X-Gm-Gg: ASbGnctFKj2QhkfBPvYXR7QSFtE6qLSk/LYRz1Y02uw7EqAZfeZ2hxPo7N14TNH3psW
	sbt1r1zsn7OQzXXSSIMk1TzqIIaepKaLQ8hQ34UDmdZ5lym7qq23OQ6qX4dVXdnD3nUqC7XJF6K
	ft/SOAHLnw6SNHl7ElmfNeDZCzdyic2WqnYdNvRaGUNwLRAPAf9nzWbYATarMu392vbYgpim1zY
	22wLEmMJUGDT/Cc8sJvLwbE3CHkEHoDdm4+HSfFlPgad5hqsVEuUD8I3V2/ceeiI1OWw/s6j3jl
	D8iZp15um7WW+147V9nEG2FsCeVJVmPLpkPlZwFRkPwsuE6GBezhFEhOJgCzZGQtUmNZzdAbPrO
	E5B4PHH6DI3LmQ1nKRMf9DRXLyPcY5Q==
X-Google-Smtp-Source: AGHT+IFypNCMIn41ibdTDNx4lnj5ojm64dR+2U0xpw0STk3CxsR4PZycEa3AfGJqpDAqBoyMWdx6gQ==
X-Received: by 2002:a05:6a00:2e17:b0:736:5c8e:bab8 with SMTP id d2e1a72fcca58-736aa9c1effmr17581861b3a.3.1741527667817;
        Sun, 09 Mar 2025 06:41:07 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:c508:514a:4065:877? ([2409:8a55:301b:e120:c508:514a:4065:877])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d4d14f66sm619646b3a.82.2025.03.09.06.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 06:41:07 -0700 (PDT)
Message-ID: <cce03970-d66f-4344-b496-50ecf59483a6@gmail.com>
Date: Sun, 9 Mar 2025 21:40:52 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
To: Dave Chinner <david@fromorbit.com>, Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Luiz Capitulino <luizcap@redhat.com>,
 Mel Gorman <mgorman@techsingularity.net>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-nfs@vger.kernel.org
References: <20250228094424.757465-1-linyunsheng@huawei.com>
 <Z8a3WSOrlY4n5_37@dread.disaster.area>
 <91fcdfca-3e7b-417c-ab26-7d5e37853431@huawei.com>
 <Z8vnKRJlP78DHEk6@dread.disaster.area>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <Z8vnKRJlP78DHEk6@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/2025 2:43 PM, Dave Chinner wrote:

...

>> I tested XFS using the below cmd and testcase, testing seems
>> to be working fine, or am I missing something obvious here
>> as I am not realy familiar with fs subsystem yet:
> 
> That's hardly what I'd call a test. It barely touches the filesystem
> at all, and it is not exercising memory allocation failure paths at
> all.
> 
> Go look up fstests and use that to test the filesystem changes you
> are making. You can use that to test btrfs and NFS, too.

Thanks for the suggestion.
I used the below xfstests to do the testing in a VM, the smoke testing
seems fine for now, will do a full testing too:
https://github.com/tytso/xfstests-bld

Also, it seems the fstests doesn't support erofs yet?

> 
> -Dave.
> 

