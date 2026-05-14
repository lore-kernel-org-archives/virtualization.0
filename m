Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA8282F1D
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773310; cv=none; b=G7w9IHgqIyq1q7cVqA20rHg7hFG7UpP7LK6ATypnTW5R94NWp7s3/qNShthMSHqaEOoG0gh5Pn5t44tojOdHFV8RuRh18Zm44W+Q/Dh4MPLY/tcK97zo3pDGlFNcpiWi0F/3Adi3g0lxL+5+m2fuVDXhiI6ib7XZ57GtwgeKDOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773310; c=relaxed/simple;
	bh=4rEOZ0HrD7dJ7NzHVHtoO3V+5JqJ9tvjNPtsAXMQwRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usk3HBerjvAhtfwBsYOyRm1tFGA3g8AFsaDnaCxj2ka47HRQgB2bj79mGWKlpF/bgxFQTaiQ1PuJfGb1gpeul9qs560AN2LzDmZDxxStzkmYS5VYB+rWak/aNAGOsRre55kdbd2olaxjl3MYBy+bzkAz9BK5xMSHyMiwiarNXZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Wa0kvbIr; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Wa0kvbIr"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9118b952e2bso17602185a.0
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778773308; x=1779378108; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgKCwvl8qCOC7UfBkBLgKxl3JgTAzl9p+k26wMt8Rf4=;
        b=Wa0kvbIrT56ACRQ6PGEnM8E0Mkt2yjxewYnvv8vU9VTIx2PwslSiNOqZWgzBraEM9A
         rzYWXyFEPQOKPDLOV4b7ZmFCEA0H2PaXYOOoxB+R/fkU4mG/nN/dq0B+9sK+qfi9SRmG
         rt3mOL1xJ4A+XXrAw32DYSgzTrZM/4h8GvVxN6SyUqQcfuib2dfQpNc+pDyzWMxTSbu8
         EFfHBqekn1a4/34bW/DoOsZDR76PL5yCw7t3rQmpZRIIRxwvN4gj8HOxFcFw4CnbLNID
         camT0GFvywmulPPRfc041EXekFrkCMyAHgV2/WA3a6PedEGb5gLDRmQjXyJtUdSRtTHa
         6jzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778773308; x=1779378108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgKCwvl8qCOC7UfBkBLgKxl3JgTAzl9p+k26wMt8Rf4=;
        b=g1rlIbvcVRHmf+uCXO9hkJfAf39CZLKuD/UHT39hSnbcO8CjpcHDjUzow0nzdvpswh
         CTjkbVLSS/ivdPdJPlNcRPzxn0ti+k8nFh1Ede4bym83lFwa7P2Gbe37jyiMyhIC3z3c
         eWJum3e5eoA9RWa7FXXNErlhTN6yXbzhByZfnQ25J743ilptFhFcLw9yqfkstIqD3VU6
         N+m2Zwj0L/MHl0upfUwiEkgGJq5IsClBQ3EqyqXOz2vdybBZ5T8KPK9m2/6VUmD2g2sD
         xeh1whYH08/y/JLR6HGPrPYFioV3TStef80T4dlbxvaBkKseBSmkJxBiu2H/ze6BQtnE
         +RFA==
X-Forwarded-Encrypted: i=1; AFNElJ+ilEiVYlOoVNNvFi48H3uSaunFiL2mQFpuz6kRn7nT52Eqzq3IVK4zRMMIRryzKsA2Lk4vRO9mfv4PohObBA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+G53p5kX8XzD9vXx/wy3ouyn2YHvpTHDy+0Oh4cvbtom/xesQ
	PCfSyvyG4EL/4s1XNC3gNm9ZE35BQ7Qi9jy48nal3TXSmkt3GfIQZL02vl0lvUJq46Y=
X-Gm-Gg: Acq92OESaxLA0jjZPMM+WlFxtFHxaeXosqB9FzYUtXnTq0c8jaL533C1W3uOfPSbn5g
	er+F8Nx6EV0G4/QyJOPqcznHE18Mxa+SKVwJOpr9XxpCo321f+zkF7BSyVC5gHuaDIQ+p8uu2vZ
	SclimfWHHs8xIKJ0fwWyq4IEeZFxpWLyYSEiWC7EoLoqTDZ7AH2D2rq9TnTOL4v4qtX8L8OWv8m
	Mqa/HDJr0AH2fN/+cGlMVqta0XppaZ1rbUWphTSrJO0z7iJkvCV379eLxaVLDBDQ2b1S6asPLcJ
	an///6i0P4LGgRGaioAlkGAeQ4iJLvlIONylz3PGkpmCRM59KAPbTuuWaGa3Cx0qqNICYvZttLV
	pkHgFVdNMjuiZsLFwbxBqfnSJps6Wfq6iETJOF4dVM3kAXSQRyXCb4bTPTCtQvirecuqM/QUIGg
	SfKUoHCQVy9v4VXRmMDM/8dcyWJ6e+Dr5h09bFcfo6ptlQpELln4wkCaM/v7mjge+DYHxlH+E9B
	AAI8gOn8+LI
X-Received: by 2002:a05:620a:6cc1:b0:910:d1cf:915f with SMTP id af79cd13be357-911cb72a697mr20518585a.9.1778773308288;
        Thu, 14 May 2026 08:41:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd02f12dsm279596485a.40.2026.05.14.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:41:47 -0700 (PDT)
Date: Thu, 14 May 2026 11:41:45 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v7 02/31] mm: page_alloc: propagate PageReported flag
 across buddy splits
Message-ID: <agXtOeuYNin9nYN8@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <feab82b370b3e66b58b9cfbc1efaf26fe6061d2f.1778616612.git.mst@redhat.com>
 <agW3JyLAwVsCZ2qR@gourry-fedora-PF4VCD3F>
 <20260514104735-mutt-send-email-mst@kernel.org>
 <agXrCinY2HmJmhT6@gourry-fedora-PF4VCD3F>
 <20260514113337-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514113337-mutt-send-email-mst@kernel.org>

On Thu, May 14, 2026 at 11:34:14AM -0400, Michael S. Tsirkin wrote:
> On Thu, May 14, 2026 at 11:32:26AM -0400, Gregory Price wrote:
> > > > 
> > > > Maybe mildly out of scope but worth asking:  Are there other flags that
> > > > should be retained/propogated on a split?  If so, rather than pass
> > > > was_reported, should we just take a temporary copy of the page flags and
> > > > pass them all in?
> > > > 
> > > > ~Gregory
> > > 
> > > 
> > > Not that I can see, no.
> > > 
> > 
> > You do this exact thing again later :]
> > 
> > https://lore.kernel.org/linux-mm/9a22e0f9bbe1278913754db6df76e291a006181a.1778616612.git.mst@redhat.com/
> > 
> > ~Gregory
> 
> I mean yes, reported and zeroed) Just zeroed does not exist at this
> stage in the series.
>

More of a forward looking question: if we already know we're adding
was_reported and was_zeroed, maybe we should just pass the page flags
through entirely and let expand() check them instead of passing it
through individually.

We end up doing something similar with post_alloc_hook later as well, so
I'm wondering if there's a general improvement that can be made here.

~Gregory
