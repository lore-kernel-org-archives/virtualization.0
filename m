Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C181480DC1
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027083; cv=none; b=PblcwK0QTHf46K5UrbP46//qTOexiAnWgWoAbwM8MuIPNBjvi77oje862h3QswCBHbw1M8UNmA8DioKJNBkv1AE9AOastpPbc42m+/cIQNBXV1c+q27c02XHWNAlj7K4Yk5q+kH6dmSBGofun2tS3MAYjvYfpOMsh33yj/Df5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027083; c=relaxed/simple;
	bh=OWhqozJogc4m0bZyL7rRg35X5SMI57nY2eOTetEs3aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmK4+rWmbW43t0Cvs52sQBSqRRL17ekpIlmI10MEawOOFnXF1gjY4WtuYapT0BccLf5ZqIm9i9ZOsKjzM9/kvIHzyVHE+EsWiBDOFhHa73haVHwRoKV33n+As91AJjVAYvVvj6zaW6DDDefR9+wvBemNG4KbOw5HvCilZyPCiR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gpA0SAo8; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gpA0SAo8"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8cce87d7995so66301756d6.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781027081; x=1781631881; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=taYzpL3NOUpJl8K0/+Ucx7wOW5hZPsWROMd3M/VgR5g=;
        b=gpA0SAo8zI5fhQt7sFP+5UEj98ZyGU04e8ONMpql7qNamDFIjGEum0CE53rM7gBWvF
         sNWfMSFg0ktHMC4SGV9Bd48tz5qKNeupNkMVp5fuoSG5Y8zKP+hQ0vmBRem+S8Yb+FcG
         A6PXr8NlJ3WomXe8sLSt4znlT3g14TCsbNsWehi51Ya2cmR7vwUin5FTREi1P3nCaEdz
         aEJ61lMGTxhSf4WUovqxCp7LbpHdosUij82r0SQPss9/SH97TSE92M2s+TDhamOEMoPW
         rbhdK8kLPzKZkVtL4IUGZBJU0msnvLhiAQlmnfEHR5w3J8bUNcCaWZ3NMrzbtLBcn63b
         +sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781027081; x=1781631881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taYzpL3NOUpJl8K0/+Ucx7wOW5hZPsWROMd3M/VgR5g=;
        b=dtGgvFSptkN7qzgmC2kp7qQIb8PD9XQGBu+lhmfgsmRBopB7a/feKFRECjN04Oe4iH
         kxKjqYOVIF6QFU7d8n0dImO1Cxs8sKDOgJJKkUX/ud8n/Buba2QzcxOrp6xF2F2u4ot/
         EJtVjfuumZQx7gPuxPk24D+98yNMwooh9O0UcZcVg139TwiVcMB3xPgg5QQ0aFY8+Ihs
         qwG/32tP01/5ng/PObvH6ySnCt6suaxh+j6TfqQeDIUkkEo3SXtPywIypSLra2mpZ88Y
         cO8O/tNrQqb6yp4tz+73lZZaXviH/cqJYij7HaPuE25l0I73R7eMF035pAJiFyIuPFhB
         37sg==
X-Forwarded-Encrypted: i=1; AFNElJ+GRx1b0aw8EDsgb05tLOIRLVES84kqHon9KfvQD2yKpad4izx1RQAT1YkRaKrfype9Awdi+pLgUmacTIsZnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzErqTlh74o/3Uwvi5Vt7EfZHTuzqSf67rDbtfFJ/InhjK9piW6
	9N21/NUsHMYqGsKCzRzICX2Xf49q9HlF8b9VyFEV8PVaxErSWNfmaxECpelc6M7mDAA=
X-Gm-Gg: Acq92OF+nJE3W0paabVmy/Cbk75N552NsodXyGr6Bk46MCpVkGAUhPk5UVT5M6Cxcx5
	8SojlpdXGt4m3STCv3L6LXFbik6oCWtnVd97r0jsCTPPnoGO4KSWwItd5RVNYslM2ryk4USoVww
	u+/5MuMYcnoXZJrKJN3QFtyZWXhc6JrVlbUb7K+Pdsd1cgWULxUP0wmmCB159KSPqdLcNpogbcs
	NNrsV979YpM2yNw/FxlmP4zni9ChzX3mJ7uZ8j3KqWpzx3wCeAxak9tga8K42Ry0fr8ej3NZ3FY
	nuJAWkATYDuhO+21edEZdhH27fnAs7RD6le6Hr9jgQYUzQWBWShqR+OAAlQDTcDYc+kT41yZpY6
	LF09TdCwQcas8g6miEj/kpukFpmc5MD9wjaWc33nF9pzk82fmGkb9mvut1F4MviXpI9MviPmqry
	y3C1x1stHM61gmbaxNYvxq/+EmgBefiUHEt5wBMUYekvCQ3ZI+TcR+OjewttEIbVu0hwhFWjs5d
	6OEAuePnvKgurGb1Q==
X-Received: by 2002:a05:6214:262a:b0:8b3:fb6a:d370 with SMTP id 6a1803df08f44-8cf1dcfe9dbmr56987546d6.37.1781027080849;
        Tue, 09 Jun 2026 10:44:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb915csm211312426d6.14.2026.06.09.10.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:44:39 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:44:37 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH splitout] mm: page_reporting: allow driver to set batch
 capacity
Message-ID: <aihRBTaTUmgYmZfX@gourry-fedora-PF4VCD3F>
References: <b25ea6c63503f24c8b5b64910a44dc03b5aa610d.1781020302.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b25ea6c63503f24c8b5b64910a44dc03b5aa610d.1781020302.git.mst@redhat.com>

On Tue, Jun 09, 2026 at 11:53:20AM -0400, Michael S. Tsirkin wrote:
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -174,10 +174,10 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>  	 * list processed. This should result in us reporting all pages on
>  	 * an idle system in about 30 seconds.
>  	 *
> -	 * The division here should be cheap since PAGE_REPORTING_CAPACITY
> -	 * should always be a power of 2.
> +	 * The division here uses integer division; capacity need
> +	 * not be a power of 2.
>  	 */
> -	budget = DIV_ROUND_UP(area->nr_free, PAGE_REPORTING_CAPACITY * 16);
> +	budget = DIV_ROUND_UP(area->nr_free, prdev->capacity * 16);
> 

Initial look - is there a div-by-0 here?  I noticed the old check
prevents this from being (0 * 16), but i don't see (on first pass)
the same check anywhere.

Unless this line below always forces the above to be a
PAGE_REPORTING_CAPCAITY if it's set to 0.

> +	if (!prdev->capacity || prdev->capacity > PAGE_REPORTING_CAPACITY)
> +		prdev->capacity = PAGE_REPORTING_CAPACITY;
> +

It's worth making this corner condition a little more obvious.

The code intends for 

if (capacity == 0)
  capacity = PAGE_REPORTING_CAPACITY

but that's not reflected in the changelog as a default value.

When happens if a driver sets (capacity=0) either on purpose (???) or
because there's a bug (???) and then page_reporting.c forces it up to
32?

There's something to improve here.

~Gregory
