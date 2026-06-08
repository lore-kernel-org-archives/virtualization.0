Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3C328635
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951999; cv=none; b=m0oE1SAqgCepI6FbmMtmI2+8+szq7BOZbHyXaEd5/WwVDosHjfdH14liu932od4w0IANGXo0Wu9Yd9xFH67ng8oEHv4jNxcfDCk7S9tunSnp/37pfzInf4MAyYVM1xVUZjmwPRKARw5PG7D6rWgRxwzBDA21vsMja1GFLqi4Pz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951999; c=relaxed/simple;
	bh=SdpiKtCKdhoaEnBfXDbmLiIpSHg5qspBSGRgBFRjCRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpUEvj0fFIz1R8SJe92olJP6f6o9uweIuFNXhtszrCbdxnz6gcwjVQGPFk6wsgCiTtiPLjbZPyl6+xptB4B1eTFTfFurXqLhqCtwD3IVe9k7hdRPW//HPTGjTKDVhgXzqOi3sT/+Vl3eE4UNC+/ubLudnKm1Rmo/D85MKg1D87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DDlVjXq6; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DDlVjXq6"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8cce87d7995so55416826d6.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 13:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780951997; x=1781556797; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay3/m/3X5+0dQjvVaZrZxESaXlBV8MmvxOSkVFCxjsQ=;
        b=DDlVjXq6KfDY75t9FNIyrIwax1k6PivdFsznBM6rN96A2T+g2b8/0T4cqEmVfP4A0c
         guEYQw7MmsHehouB6Vc5mSPWiq5viowaIxQvek2eA8oYoyArR3Y8TtIv0PKkIhZ8NvWr
         alYdUIuTPsUXxsI0mHbpQCiVOPnRkxaaWhnZXDdnA99tTLb8nSVp5AwBFrZqqH+z8cM2
         ivXHWADew+OHI+yvo4XA8+7AoeMBpOjpq+jf7JOlMAAgO9yuCJ3+8KgxiIv1Eds6O6om
         f000V0R423EgbnLyaJYGUv2WmNFzcpwJsBS2Oi8n930jnnLNMWCNHrSFUzJhSbInNeM2
         Gv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951997; x=1781556797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay3/m/3X5+0dQjvVaZrZxESaXlBV8MmvxOSkVFCxjsQ=;
        b=k95RflDmR5KHF3Xld2mxeUs6hYacGtia7KrfFWoGMWlsLUCb9ynCwl/4stVZs1UXJT
         lcm6qE14yld8zQ+4zhtnA79oRfa85E71kNM5skEiRnMvlJH9GjIy/RQG1B01mfulxx+2
         AUbEipjqYole5i7Htqwr1bD13EZR5ybJKD3yTARpNa3kQTSaQpskBxv6OA93l57ACI9g
         NxHYJNqnhpCo2vjwgdZGoKuuI64e7enCFERD/JCSXYHCmYyodtn9SuCxt7TM7psoQB3q
         H4KtGeyEh1mTPIqxqivsY1GzVdPGB82W7Qzg4UOPmRdCLdchUk/zTStZN2i7Hf3Y+d4m
         6qZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gzhSqvYT5d9W+uRG5UNL9NzP5d6ftY4SOaPgFypnalgo+4WWkf4VSk5TE5FhEm9l3eOvJSiUIy8BMh4HCsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyd1iHPAbFSRwwubGxrS7SdBntZELRIaf+vBZE98bNjZbj3ucd3
	AnVJIBg2Sd6f3XeH81awhgMFo6P7PGRPs4snZjzWcaTPwxoWMPmsWzsbLkBypX4Q2kU=
X-Gm-Gg: Acq92OGAzwPWPj4bHE06VH50/5tLZoJOQIHD45mZrqAmAKeydGWZwNib1NLLOqOjGjF
	F1smphXS0FJIZJw5qQx2f2GbAdCU6eAH1DZhJgZOd/9coArcMCQJGymgIdsBDdoVjzt4SCwy4Ut
	bZ4cQlNqmMQL/YkgZGtCJaQ/sw9AKzVPwNvQytluyr8vCnvFGOLFDg3bIrKLWHvu2D3Yybmuvuy
	ypz6Jxr1w3EtTYj3heBSR3r97cZAn/fa2C1zgvmoLsLFsQ63rg3SATj//3aoOjnQbQdYDTBUvKw
	UlzGL8futw34m+Wb9CGWox05BnBJQaW65CQuFw/PWwaZ+Z1qoyGY1rJbuEUHZhot6w8oKvdMljr
	XvYisyGkxYPszX3X1hqEzR53rVfVB3ejiej0GuotirjA6TzCNBAIRfsvaQCn6TNxnMGsQrFURbb
	G2Li0C6tIdC6aJeRVixQ5A9vVb6qFUjcbgT1qRun/30Choj94hMknDQfHwEfiX0m7x2GamWXgE3
	TBXvJbloYJNNy60Zw==
X-Received: by 2002:a05:6214:4809:b0:8cc:e8f4:1636 with SMTP id 6a1803df08f44-8cee6131695mr193150026d6.25.1780951997212;
        Mon, 08 Jun 2026 13:53:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecc8222bcsm179103816d6.0.2026.06.08.13.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:53:16 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:53:14 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v10 12/37] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <aicruns_4nOx0hD-@gourry-fedora-PF4VCD3F>
References: <cover.1780906288.git.mst@redhat.com>
 <f92f6f06e5804b4ea7f68b8664b7e69953b50f4e.1780906288.git.mst@redhat.com>
 <aiacZ6_7SG3nvVjM@lucifer>
 <aiblhJv_BvMn_8XY@gourry-fedora-PF4VCD3F>
 <20260608154354-mutt-send-email-mst@kernel.org>
 <aicjNRrHYOOBt0Hx@gourry-fedora-PF4VCD3F>
 <20260608161810-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608161810-mutt-send-email-mst@kernel.org>

On Mon, Jun 08, 2026 at 04:30:46PM -0400, Michael S. Tsirkin wrote:
> > 
> > Please consider that this is arguably the most fundamental interface in
> > in all of mm/.  All we're doing is going through the process of figuring
> > out what changes here are reasonable while trying to meet your goal.
> > 
> > ~Gregory
> 
> I don't mind discarding all of this and doing something else completely,
> but I dislike it that multiple people are apparently now angry that I

I wouldn't say anyone is angry, I think most folks are tripping on the
complexity of the set - which has increased (at the request of others).

> don't address all the contradictory comments at the same time.

Such is life in mm/ :] - it's hard to known the entire state machine,
and sometimes the contradictions aren't even wrong.

> I thought just sending a patchset to show how the result looks like
> is easier than arguing about architecture, and would be helpful.
> 

Notice: When folks argue implementation, they largely agree the
end goal is useful.  I haven't seen anyone say your problem isn't
real or that it shouldn't be addressed - just opinions on a particular
path forward (which is utterly normal here).

Getting the right incantation of an API is really hard when the
API being changes is something that underpins the entire kernel.

> I'm not pushing any of the mm rework, I was asked to do it,
> myself I just want the ridiculously effective optimization in there.
> 

As Lorenzo, David, and Matthew have said, the focus of the patch set
does seem to have become unweildy (in part at the request of folks
asking something be done differently).

What needs to be done now is to break it up into some pull-ahead 
sets that are easier to review.  Having a brief RFC doc that lays out
the set of patches might help clarify the confusion going on here,
especially as new folks come in to ask "What's all this about?".

As a start:

  1) the user_addr and zeroing piece seems like a discrete
     improvement worthy of its own set - aside from end goal.

     This is needed by your patch set, but was requested to
     try to push us towards a more reasonable pattern for
     folio_zero_user().

  2) There are a handful of patches that seem able to pull-ahead
     (some of the mempolicy stuff), either as prep work for #1 or
     just on their own.

     Some of these patches seem like latent bugs that aren't hit by
     current users, but do seem to be doing something subtly wrong?

  3) the final virtio piece seems like it should be entirely separate
     once the core pieces are done.

It's not uncommon for core changes like this to take multiple prepatory
sets over many major versions before the final feature lands.

~Gregory
