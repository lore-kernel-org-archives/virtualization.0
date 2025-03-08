Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA08166F0C
	for <virtualization@lists.linux.dev>; Sat,  8 Mar 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741416241; cv=none; b=fM1RAJ0vf7loD9b0kVu0HkCe00qo6lEgMWYw12jdhwhogXzdm5cH2Ojex71CEEuvpCylXDaluNAnlXAr8odGIoKaRn5pDHDXnFdOFp7+gXy7daRfpGQh8YFjaj21soFujOKmqi8avRkZYwc3RMCcOWvxT2yEScOnDmzBjTAp8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741416241; c=relaxed/simple;
	bh=UtKF8Vg/8ur3x9ZZufYsKRKBGlH122N5R3zj7Hw67+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLriqvN8cZ06GS/YT3x6m+24vxxqKzOKLxiniHm6tL/hfcFrbxuTQAKDc84U/E8W+5CZDSTZov8uBoLaEzcXy8VJjtuGQslTII1CO84DoaMonseFvBvPkeETTTQSNPela3BgghW91Qg681zytrIB3rPMaa4jZMYYxGaoUjcYGYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1LlwFSxk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1LlwFSxk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224019ad9edso63813565ad.1
        for <virtualization@lists.linux.dev>; Fri, 07 Mar 2025 22:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741416237; x=1742021037; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7XYd6bILvV5S9oc7kfROdvIGE+piMUFy2TT1wDFAAs=;
        b=1LlwFSxkR2c3jk/cjSljOMq2GeZZ7ronKsHtl3/7ibdftaVHTKnQA7rx6/69LDfybc
         UaaId872WmF0rpE59LuIteowAAYx2cvtRjK+TLOwQFg0ZAAUnWMROTekmv1lMbKmH444
         GAm0D02v298WI5JqzppLOvNHO7/e2yRlJjTACaM+ZpwJMLpqp4xj/FkMtJ7+e3UveyUp
         RTMpdEXeQqR2Rnn9QlnRAjo5iCuDukhfJpDbT5o6qFccUqLPxYjJBLmLw6gGIe6zK+4B
         LJ0b8Dr7kHFfmZ2c/H76NOtQFv0lltcZZBq5Yug2oUrp/azsQBD88hTRRFteQcMclOL1
         nb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741416237; x=1742021037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7XYd6bILvV5S9oc7kfROdvIGE+piMUFy2TT1wDFAAs=;
        b=AzV5IzPrtu9f37lD2hMgTSMxXmZ4bFIXb0JPFkJ/KccV8rVmuuaIcwG0lBtQcQ4w24
         PztDe8hQUDSirLQcrzDPykQ0GmtWPuJcnHfwZg+c+v+nrPPuB/4WKPMuiXgDX0UyKHa5
         w2NPZsL8pfxystxkEHth0WjZMxWDDZLGVmqzu53YMkSgLeB8QqUxU/0oEhqGxcija6KJ
         hhWZM58IDuvDi6N/9BJ4DMlgOvU13uYxP4bVNQgNsfluk4kE6TbbSFXsm40C1Zc3wKOT
         w8gDIZD+E0S5idVtp60zNan60NnWgxS3vrSIzK92yy9URXgxYqTc4+TQ/Uym12anl/rT
         SzeA==
X-Forwarded-Encrypted: i=1; AJvYcCX15Oqi855sDJG/6aS+4kc+Bc9NrTUBlRi3bZOCAgBwpoF9tMBJ/Y/LCywAIXcW0yz0rjwykP9wTLjX8vhFhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTWOvtRxsQd3M0cBrt+T6FpVih3q0wcP1h1g2D/dCsLXHoSZHk
	iS1mxS8ibpYEMGHW5fYwAnFMZQRlp33oBkd1avJr9tpVHQw5BMRF+lDIbY4fi5k=
X-Gm-Gg: ASbGncuEESh07NCAf3GW/9PvK0+WmbxBc+Hc8g1KDO2WQN9TuGACfVdRr8eYtF2r4bQ
	HQSyyTFxTmJ+u43gaFe6frSxgh2eu5OBPh1Pp7wxHHverNT1XGeo6Kgi+HYV6gjtO9+NSsi7QWx
	MibBJkRWd5b+WDS6mqslpNOXwb3aoMBiHC8hcXGmA+HC83+zptYmwoC6ChQgH+gBF8ZV/J6QzFE
	3yGp14UygRfWWtkuNAj53psb0XFMg/WMoailXFJTZbTK/GaiC9fcY5wps4z9Rhut6jPhxQcSxZX
	UllZWVx8LsxgobcKk1ntazF1XxWidjj5NbfPNQ47+DzHDfIokLy/7Owcfu7/N2wQaPgJAFwn0bT
	gV/oyOPkFvckwUpQPaQzr
X-Google-Smtp-Source: AGHT+IF/hoytkHf/78nzK/gEIzqXnGG5MP6Y8FgGhVp8Zx6LE+l7N0K13IdyKh5Omm9Q6AhxhqYyLg==
X-Received: by 2002:a17:903:98b:b0:223:397f:46be with SMTP id d9443c01a7336-22428ad4a09mr106979815ad.47.1741416237682;
        Fri, 07 Mar 2025 22:43:57 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e816csm40661065ad.54.2025.03.07.22.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 22:43:57 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tqnuc-0000000ALct-08Dn;
	Sat, 08 Mar 2025 17:43:54 +1100
Date: Sat, 8 Mar 2025 17:43:53 +1100
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
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
Message-ID: <Z8vnKRJlP78DHEk6@dread.disaster.area>
References: <20250228094424.757465-1-linyunsheng@huawei.com>
 <Z8a3WSOrlY4n5_37@dread.disaster.area>
 <91fcdfca-3e7b-417c-ab26-7d5e37853431@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91fcdfca-3e7b-417c-ab26-7d5e37853431@huawei.com>

On Tue, Mar 04, 2025 at 08:09:35PM +0800, Yunsheng Lin wrote:
> On 2025/3/4 16:18, Dave Chinner wrote:
> 
> ...
> 
> > 
> >>
> >> 1. https://lore.kernel.org/all/bd8c2f5c-464d-44ab-b607-390a87ea4cd5@huawei.com/
> >> 2. https://lore.kernel.org/all/20250212092552.1779679-1-linyunsheng@huawei.com/
> >> CC: Jesper Dangaard Brouer <hawk@kernel.org>
> >> CC: Luiz Capitulino <luizcap@redhat.com>
> >> CC: Mel Gorman <mgorman@techsingularity.net>
> >> CC: Dave Chinner <david@fromorbit.com>
> >> CC: Chuck Lever <chuck.lever@oracle.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> Acked-by: Jeff Layton <jlayton@kernel.org>
> >> ---
> >> V2:
> >> 1. Drop RFC tag and rebased on latest linux-next.
> >> 2. Fix a compile error for xfs.
> > 
> > And you still haven't tested the code changes to XFS, because
> > this patch is also broken.
> 
> I tested XFS using the below cmd and testcase, testing seems
> to be working fine, or am I missing something obvious here
> as I am not realy familiar with fs subsystem yet:

That's hardly what I'd call a test. It barely touches the filesystem
at all, and it is not exercising memory allocation failure paths at
all.

Go look up fstests and use that to test the filesystem changes you
are making. You can use that to test btrfs and NFS, too.

-Dave.

-- 
Dave Chinner
david@fromorbit.com
