Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ABB3E7BB7
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949363; cv=none; b=WEd6nHW/l4HJDrws/BAoLsNhprskqu0qCCv7cKk7clPeLHOz6oDUUGunRTMh9GZ9jbiEpTGtIBFVcWATcCR/aHNA/pw1NLwWOOVJ62BqWlJiloonEVzNysgBFs3p+rB4ZCEl3vvuUD6O3ce7JqTz5qBCC380ywVQX2VGElvovqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949363; c=relaxed/simple;
	bh=nBNTZYDQ7i2r50wpd+udxDoC63MCPeXQfjOTnLrx3/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tBQOI0jtr4N87uszg+KTorQg5e3LjtSPkYhRhABp6hN00EGITaOvouBkYp7o0le1C1XelTlaVzlPc6jVuTPHCBcF+tip9TZI8eevGGY2fS5+onHCQG7imschHT5s2RIkaMRFfiXvqOiH2e0PO2DqtjiMT6Y8HlI/jQZq5o7aZcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xa1hvwLX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xa1hvwLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780949361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPGBC2/luUrvTKZA7fe3ursAMvj41Fm7p7HFv7E1PtE=;
	b=Xa1hvwLXvNthzU1ZpFP1Fxl+wP2uEGZzPbHgeupzZKvSSeNaKqsZ+Kv5jmmpbxToAcmehO
	2yTVrSYqMhvYVcldg5hUf17G5g0ILT5Hyo9xOZkNf4fyNK+k2APHAAIRfNdX/6vHbzbpFu
	Y9+0MYJ42NxoIy6emTHFHYXIPVOwBTw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-7on2uoIwNxepz5Xs_6ytXw-1; Mon, 08 Jun 2026 16:09:18 -0400
X-MC-Unique: 7on2uoIwNxepz5Xs_6ytXw-1
X-Mimecast-MFC-AGG-ID: 7on2uoIwNxepz5Xs_6ytXw_1780949357
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef5e38a18so2152513f8f.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 13:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780949357; x=1781554157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPGBC2/luUrvTKZA7fe3ursAMvj41Fm7p7HFv7E1PtE=;
        b=h8MNtvcZ7028NXubDIDumW2PgYby8D4xRIRp6sIkafpTqxZ5NUnoPdEJvkyyfjcl9n
         a59aRoqhWNVnDqXXt9myXkTRdqzD2bTJJ2QKYPHDrxbFtdhfHKos+fskrKZvv9Bww/28
         M2tq0UGw0B6MI92c9cuuGNuk3SO48aFLMzGsuYO/RvDDYUCXWjkATiDErR3acjyBXaYB
         pICvM6nwu/9A61jH3DWLUH7XunJceK2adO9Jy24hSDGN3rbclBu5EPiqvjrMQgMakMEE
         KinSUR/GdvTgXmJyj0CTGm5dXZktjhlVGzrQX5Kf66jer0krOD71NXcRZa5sxqO+hNqs
         L4fg==
X-Forwarded-Encrypted: i=1; AFNElJ+47+IpLM8Io6mD4j8wdaXy8YsPe6QjVTpjgUfJ/RYNU+glnKSiuV7FKNzLCNuwx9BE7qs3twbQlMVqouaijQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9UjdrP8XeNRiHOKjAC2lZf8LEDR7TPxFBeAcjcCOhyfrr7zfm
	CfbEyIXOii1pes7X66vmmrF/CrSsTaP/XX9ZwMqMzjtUDGjF1p+1pCTxtPpL+5m+LBaw3IHBxKu
	85ZV6IZY0aCXPFIQ6PERFvyOndCdRNu8elbKLu+U8wzFpde0TyhmiC7gz1xXxN3b9VnDi
X-Gm-Gg: Acq92OHgd0wpIlTarPHz8cka8gGCHdu8KwhPGTeXb7mxxbjiVhxa/30+mC5ccXztFqR
	02AlfaYvTV/oo1H828ojTWbxfRP1E+EseZWmiJgeQmZCm6wFHtAASmnCnH0linyQn93TGn99xN9
	qNUzKp5XwFn1vqdFCVKmNEGXOKOlmEK4atxv7c7ZIzfmojO0/cgFJ+N45mHUeYHyLPmMVnpi8WI
	1irgTpaThvB+dnf4j8nMKzcmXJinyaupW6FWvCvRPKXt5tqp0uSihBxIDAIjMK3Mx7nSgJzxHL9
	o9OXKPv9icLH/piX/0xyrFv2PtsUKSo8gE322U7vvXtimEonoGuqCLUPbNWk2HqbdcxvOB4WK77
	UmDGt3NEMS3SwS9k/LfAsl7uLUSQ9LSeClHngM6uw07nbfzABrsBhYQ==
X-Received: by 2002:a05:6000:468d:b0:45e:6518:3299 with SMTP id ffacd0b85a97d-460302dbd32mr18415846f8f.5.1780949356823;
        Mon, 08 Jun 2026 13:09:16 -0700 (PDT)
X-Received: by 2002:a05:6000:468d:b0:45e:6518:3299 with SMTP id ffacd0b85a97d-460302dbd32mr18415802f8f.5.1780949356252;
        Mon, 08 Jun 2026 13:09:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fb24sm58638802f8f.34.2026.06.08.13.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:09:15 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:09:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
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
Subject: Re: [PATCH v10 16/37] mm: alloc_swap_folio: pass raw fault address
 to vma_alloc_folio
Message-ID: <20260608160659-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <d2be78654e9dcc7cf5b8a542c2c8f331187c80c9.1780906288.git.mst@redhat.com>
 <aiapFvxPXuPd4-OP@lucifer>
 <aibm5OFmiFK6lCqH@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aibm5OFmiFK6lCqH@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cu5GtWdyf9riQyW298ykPiOBy9DSnmXRs-ASufBuQdo_1780949357
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 11:59:32AM -0400, Gregory Price wrote:
> On Mon, Jun 08, 2026 at 12:37:20PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Jun 08, 2026 at 04:37:41AM -0400, Michael S. Tsirkin wrote:
> > > Same change as the previous patch but for alloc_swap_folio:
> > 
> > Please don't say 'same change as the previous patch' :) explain what you're
> > doing here. It's a pain to have to go check otherwise.
> > 
> 
> MST you need to slow down a bit.
> 
> I gave you this same feedback 3 versions ago:
> 
> https://lore.kernel.org/linux-mm/agXUHItfxSwtriRF@gourry-fedora-PF4VCD3F/
> 
> ~Gregory

Ooof I do try but the patchset is just too big. Sorry. I need to find a
way to split it. Or maybe Matthew will tell me how to make it much
smaller, he says he sees a way that will make everyone happy. Let's
wait.

-- 
MST

