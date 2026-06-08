Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070383E7BD1
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948748; cv=none; b=Q6jVGKJocH2DQ++qwJUSh6VF2Z6TtfQHFF2aVVJWsHjOYqv7TnLdLiMcbSl1r8ebI2X+MAH3TQHMnIHGdCeZ7CPFrO1zutcDclF3VoFtxQpZQeIo6pOxpb1JjuoFc7OZnCsN6eBJMoOOMU9ta3dTrkdUn/mSfQh09zJpOcTznqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948748; c=relaxed/simple;
	bh=qiwIhtw7NmMcaCXTfNudfYlEPNd416ZpKyvIlCb5FKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=diZ/TuBEcvYvcvxpnuts3eao8ksdyFuZ+cliWSltr925SvDSMyxEKxKZZMk1AcDdOjIELc9GLRM6v+fMYlT31ryiXpi9E0gIdJr7INjqDihv3Mgx5rw2s3ct0pr0mZa9bT/08VUzKhMNiMx11LCgQbDCuxU7KG1x4X1AXZMN77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANVxir9f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANVxir9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780948746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eqSTEGK8xl8EZeqE74tv6zlFs8hlnJlJcde7w58YuZs=;
	b=ANVxir9fcMIT1GsyACDXzgKdnGMuNNvbXe2Nkhcih/IT34yVzxKPJt4l+SEihwjKQCdycY
	S2pw7Hd8BjljhSp8v5AQp1hjBspk5FgPevpAspDjvUInUGaTC81wVToKhR3j+QAk9SfRKr
	HOniUHPtw3ndn/VEfwyQOx6s/5KbGVQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-Ok8b4068MDGwvm3OUBVdTA-1; Mon, 08 Jun 2026 15:59:02 -0400
X-MC-Unique: Ok8b4068MDGwvm3OUBVdTA-1
X-Mimecast-MFC-AGG-ID: Ok8b4068MDGwvm3OUBVdTA_1780948741
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4600c8cb13aso2844777f8f.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 12:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948741; x=1781553541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqSTEGK8xl8EZeqE74tv6zlFs8hlnJlJcde7w58YuZs=;
        b=XGqj6dcAIF25tO65zT/PIvZfR/JrgEMFUVgDf5avZC30PrTgL/CWMeTiSuqktpQSPF
         ckxvVthi6UApsYqOxD+gxIhCSB/koHzCZ5pinC7S+KLCVQFoYWg+Mi0Rb61l8zJL+qes
         l88JWhOCOrokQnJWOKPiuK7udnNESBCf9AdXROqGqYf5E3hRh3AHFOguIbc5cihnIgfR
         2b1goklUKTvlCwvDPyMuE3MvNgvfuZ+TudnVd1qLwGr82aYrZFbYT6sXnAvQrYxpUBfz
         fkeb1O1DrZeAH5NWfsSBcoSyejQESJkwrWYTjfLp+/thgFSykAu/aXHGJkXpFoAVJ5AH
         FkIw==
X-Forwarded-Encrypted: i=1; AFNElJ+7hWj8XYI7ZBUH2qsQ78mTOwyFbgVRfpxsmRWhJrEUXbjCahWknjYkDYm0cacESSz5uBKvj/GSq8UT5P8wkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzK+rCNXTMVenqoCSdK2xRewX3n+aJOfAYnGNcxKeW0pbFiDzd+
	CcQygnV7MWAZBFx8qpZjrVyLyYeDDrHtw1MakMZuWC9lrDXR2co/b1aAwX38v2TA7x9CH2fnqXb
	4Q6kSEJ0z/Yj8BfQ8vKuW7OxNFrUY/WLCgaS1OTnAPsIvYnuSGL4Bg1ugaKBawaKc8fDM
X-Gm-Gg: Acq92OGbFDNzaJyLSbyYSSUSUyK0sloMCuxPZaptA3z626uWNabXd3MLGOEKpTz97eA
	F8g/slDu4Cyz9rSOSm71Y9jD8Ji1ejb/RMxTd6PcEPCtvzCTOynZbPH3XbqgnRKeTyYuTK1rBU8
	jf++02+yzwGhVI+IIejlCEPSykGAaqY1NJy2AcDLl561KWXZweAfkeLklcEf6hm283znJeyHVlZ
	Ofl6kX8saKm5FlFDnR6//e2ry7heoSoRo6uK2BDo52VSbKZWtFEViP85VFSDyOXtKoReSdsOhLz
	/Xb7UpEPSsA73x/jceME+gYWyp4R8EgUCz0taoXv/rJnZ2llZ90jkEgz26VTlARHjPDcxjqHjM0
	6Sr/S8IEZydqeONHg8dtberfpIKIA+CbOX+tXkcRShiOTJibPJ80hXQ==
X-Received: by 2002:a5d:4d0b:0:b0:44b:5398:4e85 with SMTP id ffacd0b85a97d-46030502519mr19992709f8f.22.1780948741122;
        Mon, 08 Jun 2026 12:59:01 -0700 (PDT)
X-Received: by 2002:a5d:4d0b:0:b0:44b:5398:4e85 with SMTP id ffacd0b85a97d-46030502519mr19992648f8f.22.1780948740596;
        Mon, 08 Jun 2026 12:59:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d40sm54186487f8f.26.2026.06.08.12.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:59:00 -0700 (PDT)
Date: Mon, 8 Jun 2026 15:58:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
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
	Gregory Price <gourry@gourry.net>,
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
Subject: Re: [PATCH v10 24/37] mm: add put_page_zeroed and folio_put_zeroed
Message-ID: <20260608155520-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <fef7ca7bbf591865defef658b0792b58494aaed5.1780906288.git.mst@redhat.com>
 <aiazXE8pUDeCmP7c@lucifer>
 <8ec82477-b497-466c-902b-82e108ae2b7b@kernel.org>
 <20260608100602-mutt-send-email-mst@kernel.org>
 <497dff41-e831-43a1-a56b-a6ab98bc11a3@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <497dff41-e831-43a1-a56b-a6ab98bc11a3@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Kv5zsbskZQU2XtY9-zwFfAdSVOdI50i0R4YzRHqDxAg_1780948741
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 04:28:48PM +0200, David Hildenbrand (Arm) wrote:
> On 6/8/26 16:08, Michael S. Tsirkin wrote:
> > On Mon, Jun 08, 2026 at 02:46:34PM +0200, David Hildenbrand (Arm) wrote:
> >> On 6/8/26 14:25, Lorenzo Stoakes wrote:
> >>>
> >>> Do not put comments about specific expected races like this in the commit
> >>> message but not in the code. Subtleties need to be called out.
> >>>
> >>> The commit message also doesn't at all explain why PG_zeroed doesn't
> >>> suffice here.
> >>>
> >>>
> >>> I really don't understand why you have a 'zeroed' folio flag but need to
> >>> also have new API calls to detect that?
> >>>
> >>> They're also HORRIBLY named. Zeroed as in what? Zero page? Huge zero page?
> >>> Memory zeroed by kernel? Pages that userland happen to have zeroed? Or host
> >>> VM zeroed?
> >>>
> >>> Each are cases we address individually and relate to folios.
> >>>
> >>> You absolutely fail to clarify _which one_ you mean, and provide absolutely
> >>> no documentation and add an exported mm API with no description.
> >>>
> >>> This is just I think not something we want to add? Especially on something
> >>> so fundamental?
> >>
> >> I raised previously that providing a folio helper is odd, and that I suggested
> >> that we defer this change.
> > 
> > Sadly it's a dependency actually - without it memcg failures would cause
> > repeated re-zeroing where previously it failed without zeroing.
> 
> Oh, you mean that we succeeded allocating (+zeroing) but failed to charge?
> 
> I don't immediately see that to be a real problem?

Yes exactly.
I don't really know if any real applications live close enough to memcg edge
that repeatedly wasting cycles zeroing pages then discarding that
information will be noticeable.

I should be able to write a test to show the difference, if that's the
question.

So just writing code in a way that we are not regressing them seemed cleaner to me.
But I'm not a maintainer so hey. Just so we are clear.

-- 
MST

