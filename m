Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AF31A314E
	for <virtualization@lists.linux.dev>; Mon, 17 Feb 2025 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827921; cv=none; b=riPx8rMJko3s/d8NwFjX1B5ruZXQO267I0gmj+VP6I9gYkITABNPccfig7NjOyMcnFWnLo7eS9/Wqo1xMqdGwH5rKuzqFXU9FZ5hxYvrZNCjzZ1EigupYDVkxsyQzRcDNt0FZ50qsfn9iyr/n6fWXPdn20/Oe2PksZctdIKikkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827921; c=relaxed/simple;
	bh=5Z3w6D6rLKLuQ6zEjNL6ikv+CipM0JHOZMCbXFfqNBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb9oc1IPBd9r+JJNtZGiP6Z59YB5TQyTENWAmThpsWZf5hfqWPaABebihCYswu9fh9u0fzJ5oXEN7aBt+MGXpo/nr07X/gKPG2WPP3uvilteTo98CuTAQSy+KxAT7HVO3dRf8jJEJmHC/vtXd7DxYcIpYgbyJxTRv7415Sj03i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=LJjzSIIN; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="LJjzSIIN"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa48404207so9604176a91.1
        for <virtualization@lists.linux.dev>; Mon, 17 Feb 2025 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739827919; x=1740432719; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QhTfy1/ybvgYfqGEX8d/5gFaFMopC4YNbC7hGVBL/4c=;
        b=LJjzSIINgTkKKBqRbJYO/Jb8iUQ5SCgka4Odq25WP2bDJDZv/AB4p7V2CmoQm2z/3J
         kV5u+mDJMiVYmyKVQqFg8v+SyRH+w8N9Kd2OfSpHxa60und0l+JbhQY1qcssoWYwHbyT
         NSutyAtaKTavELNIcLWZSNQ6SaGel5C1ZUgbKTJZB95ydxmpyvAOW7Qjv/KiqtNAWfGi
         v87XP55tKcmjdcJkR1wDEMV3h2V3j+SZRD/GwHwB2iaXlE5Ax/0bfWiBkDfo5O53GJZz
         W31ftttOKKXmGpNEmi47BwmWvIVwCentJ3hyoBHLFCp3/XgAwU9iSQzJI+Ir3MZEjaNr
         MXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739827919; x=1740432719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhTfy1/ybvgYfqGEX8d/5gFaFMopC4YNbC7hGVBL/4c=;
        b=adfYfNiAly6ZuHLcKX5Y1pp7QQYX1KnUruN3cp+g0lREtaO+pwMHIR6UnzHofiw1si
         y8YB+QNeB2EeiPDU/69VFQTeN0PLaQrNv72C+b0EJSa5JvkBTq1ZMOf99ubxJgIOzRDA
         JL27OpBY1m+Aq4J7sMXqMzMgYfRnY4QbDHMh9NY+yiXLbqBtA0D//H1M3vtquQIT218u
         k0cuYtKMKt2ZPKA/HBXUQJ7Pla+AIbHhps2VIEP6fVFjngi6MN9agvmqrrcYzZbFkust
         cHjiU70uAwzDHFz+ufjhEVn5bg68MbDwF5quApue5BVjnchm8MzyJKJaCX4Gwq21sQcv
         V1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXLBm84QyoNvAGrqArxqbMPiaOinmGmVm9zOS3j76qcYXrRRQ8dHxj4k1p2Fr9GcXZkmlVVdD/EIzxQa/FDBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvJfNe78RB2CrDTXJ12FxpEVQjGC8T2aBc7P7EtAjmJjVRGahM
	j3rVA+gnns6G+g6Ug0K6LTJCpkKzbLjtVBHjPtbKKgN4yj4y71RZQZWOGm+dGlw=
X-Gm-Gg: ASbGnct4XwsZDUg/7S8J1j1ha8nZLOsQ3r7EGsjsEMSdhKM2U5bplNdQxyLA3fqr/aP
	dN2bL3hEIBePDH0EnMwSdWUZrkeGsqFD7jH3+bZsZjeowVk5GefnhN11HUtl51qsePLoWb0/tPL
	Rdg9pahiqZVQQXQjeYsmcbJxricF/57ujxKKn8vfaXDeyWs5Uhce2uJxsGmFyJY+depIFjoiDEi
	ftnwJ2feGmQPoMpB5R5cwUluYiJUZRLMiEsaVa1neNcXrOPt6l7kUopJ5JQvwzjEq39v6r7MdWR
	BxvePlrH5izFx0auLjgwliIJqWUM5Ga3X50EtgvL6DT92wu2QlCErNILHp+Noy17Ptw=
X-Google-Smtp-Source: AGHT+IGWbBJAtL2UtKSWCS6Jd9Ns/0Md8Y1s79IB++xb28sgasLU0+0/qaH46F3zNCw25wym7QqlJQ==
X-Received: by 2002:a17:90b:3b4b:b0:2ee:fdf3:390d with SMTP id 98e67ed59e1d1-2fc4115087fmr15333822a91.31.1739827918683;
        Mon, 17 Feb 2025 13:31:58 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491d4sm76091525ad.4.2025.02.17.13.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 13:31:58 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tk8iZ-00000002XxN-2C1Y;
	Tue, 18 Feb 2025 08:31:55 +1100
Date: Tue, 18 Feb 2025 08:31:55 +1100
From: Dave Chinner <david@fromorbit.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Luiz Capitulino <luizcap@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC] mm: alloc_pages_bulk: remove assumption of populating only
 NULL elements
Message-ID: <Z7Oqy2j4xew7FW9Z@dread.disaster.area>
References: <20250217123127.3674033-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217123127.3674033-1-linyunsheng@huawei.com>

On Mon, Feb 17, 2025 at 08:31:23PM +0800, Yunsheng Lin wrote:
> As mentioned in [1], it seems odd to check NULL elements in
> the middle of page bulk allocating, and it seems caller can
> do a better job of bulk allocating pages into a whole array
> sequentially without checking NULL elements first before
> doing the page bulk allocation.
....

IMO, the new API is a poor one, and you've demonstrated it clearly
in this patch.

.....

> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 15bb790359f8..9e1ce0ab9c35 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -377,16 +377,17 @@ xfs_buf_alloc_pages(
>  	 * least one extra page.
>  	 */
>  	for (;;) {
> -		long	last = filled;
> +		long	alloc;
>  
> -		filled = alloc_pages_bulk(gfp_mask, bp->b_page_count,
> -					  bp->b_pages);
> +		alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - refill,
> +					 bp->b_pages + refill);
> +		refill += alloc;
>  		if (filled == bp->b_page_count) {
>  			XFS_STATS_INC(bp->b_mount, xb_page_found);
>  			break;
>  		}
>  
> -		if (filled != last)
> +		if (alloc)
>  			continue;

You didn't even compile this code - refill is not defined
anywhere.

Even if it did complile, you clearly didn't test it. The logic is
broken (what updates filled?) and will result in the first
allocation attempt succeeding and then falling into an endless retry
loop.

i.e. you stepped on the API landmine of your own creation where
it is impossible to tell the difference between alloc_pages_bulk()
returning "memory allocation failed, you need to retry" and
it returning "array is full, nothing more to allocate". Both these
cases now return 0.

The existing code returns nr_populated in both cases, so it doesn't
matter why alloc_pages_bulk() returns with nr_populated != full, it
is very clear that we still need to allocate more memory to fill it.

The whole point of the existing API is to prevent callers from
making stupid, hard to spot logic mistakes like this. Forcing
callers to track both empty slots and how full the array is itself,
whilst also constraining where in the array empty slots can occur
greatly reduces both the safety and functionality that
alloc_pages_bulk() provides. Anyone that has code that wants to
steal a random page from the array and then refill it now has a heap
more complex code to add to their allocator wrapper.

IOWs, you just demonstrated why the existing API is more desirable
than a highly constrained, slightly faster API that requires callers
to get every detail right. i.e. it's hard to get it wrong with the
existing API, yet it's so easy to make mistakes with the proposed
API that the patch proposing the change has serious bugs in it.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
