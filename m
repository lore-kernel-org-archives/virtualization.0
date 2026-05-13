Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878633939AE
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690068; cv=none; b=c6Z8VchWjn9UKnq8+ociubq8LIbzpfudndEodI3g5T7vlR20WSJmWFFVlPzPVLhwqXUfAf48xky+4H/YkBryz0XhZQc/jT1oCNlcvUsUD9yYF7OH6HwhFNCPc2cQsHdQtCjyLU2ydEN9eF57fGb/UmKRMkY0k85KwT/4+ZxRYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690068; c=relaxed/simple;
	bh=OrGxMK5IgeLgMmIL9OUUMGzryRfyptrGuaaJwcYBniE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrFbJmQ68OtArNioFLoSfHaAlxeZE4qg49R9OdASOfUqqrelWbKxxzO0QM2h+u2lWEVBgNHKQtH2cBWaDKq902EDhzO3HOoWOgCyBrFoJyelRlV66cYEu+PJtB2oWEspv2jvoeXQ/PFKmgy2hSkQ+4wKV4AObJd2vXDBVeGOG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HO8OvUBM; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HO8OvUBM"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d7e7f48499so765043485a.1
        for <virtualization@lists.linux.dev>; Wed, 13 May 2026 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778690065; x=1779294865; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+BIQ14oFJRJRvF17iizm1a/CWsNJ6gKyfT66tKDwfg=;
        b=HO8OvUBMnq+jfSa3SUUj7bbFH6gNG42znQqk5zLq3Fmap9RRDvQVxgYKqXF6kNjat0
         DMY4aCeDdpHMv07/QdupCJ/oZGI1CQDio3Qhf6eSTp0I9tnLREQH7+wPnobv9WIOxLG4
         DIN8XgMyt9lCGA7mHYyjt/bCG+BaLm5cdTNJZ9gYMUisYjzCUV03ILHnxZZy4VQT+h9L
         R814dY3MrbZWJZr/xBzJJsgX9ISJ53Bn9BkhEgLTpIUjV6l7Sp7rY+CJONqBG+EShkgS
         t00iM+LVasXYByVaa48ozxhprKhqOmDA2nC6wpx/OBKVzLp+PMecfN1jE7upVdWtZf5r
         IBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690065; x=1779294865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+BIQ14oFJRJRvF17iizm1a/CWsNJ6gKyfT66tKDwfg=;
        b=R0tGDphZsAYN/6FOwikcWilFJQ8Z1JHA9Ydb++hmjIu08KxRdMjNR/oW5X03wpmhTH
         W1Ssoe1kIG/jSxUTtrUGiktr354/QKD/+XSolmTvYKqaXOST4aGYKAbwmItFbyvVHkIc
         IvEBAOa3Kzcpo+6Zc+xeJnhBB/XaxP6pQ3gkPz3o8o/9HYuluB0xis6j5Azw8P9OoBbz
         7GcN3x0MfFdOMFmBXF5sEFROulKsHEd2CjHvT1GWEnFJAkay7M4dv/fL0Z4ySeh63zZI
         xwQ8wufg9xKUH4dnNxna8/LwMB+RLsqFQ7DbF29ZPHYfFjD8UExMVgVX8e8CD+UHH1Io
         hXgA==
X-Forwarded-Encrypted: i=1; AFNElJ8oj/9usVCHnk6djER0GD9QCdtvBtU+Tv++YYZb4R4ZsvDNM2rMSfOJuK5m5alWbCZFOtsUC2cwu617hqM0bw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw50bkYpP2RuwN16DDEj6jRdT1c2hZrZ5uYVhaz/G8xShA6Jv3a
	vqVeJ4bb+0Sz/f0SA2Hv7fuNVOgQknKNUSJRIxAlhOfikyQT1kuDRUgio3qtvyy36Xw=
X-Gm-Gg: Acq92OHV6jT7nMXYx07Fq84R64/Rrv9njnaSPXHx4jFM8BcIjHWIPb5zcuUoRTaE8I4
	Fd84DSGSud91bNRMoklBi1MX1D8aMGicmwDpneD1m96sHgp34rriwdtARrxOxwKUmaR37uOgkEt
	tlCoh5eIQ9MVWURmgXRS090dmyHhNTVkKj8FmR5HKvSXQqBZGU499Snf3TFGGZV+ivv0INpeljE
	gYJHCI4Oi+iTfnnolUOlNtavHWpDbxBHVTfpdq41jNeJc54mNdORyEaoYMAhBfeLHKdxny6mJOL
	8A+s2SJ05OqEL8daKUPzTOYV1Xr3wOhnpDgcZktN797+UdfA+JFUMjAiBwq+50lQmqSClEjghdu
	fUm4Z2+u/Z80iwalFfrxrDQy2gcbUj4C/NBnasBTAnhD3GlgL0M4Xha2fOjQCNBsMt5fh7XbWmi
	RenkAYHbPS8WaVi0X1ySIM/3pgGe/gnEPSpezet/YCbIiRzzjrorSWU5DKgC8hvPpImkpv+3zQN
	sdIhYfHrYBP
X-Received: by 2002:a05:620a:d8e:b0:8ee:630e:351a with SMTP id af79cd13be357-90fabcfd5a7mr529500385a.27.1778690065464;
        Wed, 13 May 2026 09:34:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910b785935bsm7101985a.0.2026.05.13.09.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:34:25 -0700 (PDT)
Date: Wed, 13 May 2026 12:34:22 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
Subject: Re: [PATCH v7 00/31] mm/virtio: skip redundant zeroing of
 host-zeroed pages
Message-ID: <agSoDnbk5rjx9yM1@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <e7e9b30f-ee5c-44c4-b377-d70156be41e9@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e9b30f-ee5c-44c4-b377-d70156be41e9@kernel.org>

On Wed, May 13, 2026 at 09:36:06AM +0200, David Hildenbrand (Arm) wrote:
> 
> Please wait at least a week before sending out new versions of this size.
> 
> It's just a lot of noise in people's inbox, and as raised, a lot of people won't
> manage to review this before next month.
> 

Also I wasn't even done reviewing what you had previously sent lol.

I can only spare so much time each week on upstream patch review :]

(This is also the pot calling the kettle black, I am guilty of doing
 this same thing so uh... lesson learned, sorry David and Andrew!)

~Gregory
