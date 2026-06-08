Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F63CDBC4
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927721; cv=none; b=BT22rA4DhsXJkyuIDdtOQDdfIlj5UWJt8/Mtef4IcC3wSemvHiumG+8KQyr5lJt7wX6NdZr3v2NfmO6JTsYmXrIMzOsLJAwKnctDusK8FwggLocJ6uI7RSS02DB4Tcc6fw2umepuNoLHgk8dHVpKRHL4XsiVVTYBtUhUEcyRqYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927721; c=relaxed/simple;
	bh=U9oxgLYNM6iJKQyHOiyERv6zkQrC0pfJMLIHEKQ4Yo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gUysGTlmn0W7nRHCB6p6viPq5ul+i8/WL+EApKY2OKADGQjhC+PaLEIcvANBfjgqAcC9fD5MUXsyPR8+i7fuliwFMH7t/DuEX1vj7iD7l6IAI0fPkCBkGx2hUwtO6xrzstqzy5BE9XHX2npCUlHVRZj8us7Igkb+q9I/3XJnKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOrj2oxv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOrj2oxv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780927719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LB5rudO5SFykOh7GP1yRj9jRlO/AUIWutNzfIO1MaUA=;
	b=gOrj2oxvkDPylw34j9+/y1iofNnEHs6bbj42juSGBfVBk6zbJLloZ5ysn3IYi3k3hxQlth
	F9a9p0n5GxSejXfF8KFZXrgV3nAsthtKDfDyYZeI3PiBLE6uIfixvClbEuSBdduFr/dy06
	zwcp4X9/jKBntD96KZpP0W24vT9Y6kQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-mjcsKnw4NHubIVT6CQWZlQ-1; Mon, 08 Jun 2026 10:08:33 -0400
X-MC-Unique: mjcsKnw4NHubIVT6CQWZlQ-1
X-Mimecast-MFC-AGG-ID: mjcsKnw4NHubIVT6CQWZlQ_1780927712
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490ae4d89e2so44236085e9.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 07:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927712; x=1781532512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LB5rudO5SFykOh7GP1yRj9jRlO/AUIWutNzfIO1MaUA=;
        b=GrjtiiCzMkpV3B+Lpn2qCt78cg35O+dsu87OB4PfFxaHyOjh/NUlehsrAcLb5j3ps8
         OMabD0vCUcqRK7l7n23b3xLk1W01AEFPlnTcyNMB9I5yBLBqRQLa+9pXrDcREBERGSUX
         AmzBpH50tqEe6pIG5jP7qEusXPHzIObva/W9q/KI5qV9L+gFuR+5ZAyAH/AyehTNJGH7
         JrMuD9GDJwIA/8flHjZoEzEj/MD4vBze6hwjb7WyXUmLfjV8x3cGiRF73zHfnVPObCA1
         aKoWpMdSlTNBI7e4taScGQefALdlCK3Er0sLyp/kRZmnpMmH4Qwq368Rx2B1o8mlC/4i
         0vdw==
X-Forwarded-Encrypted: i=1; AFNElJ8W7VvKsYRkEkq+eTKsHHIk6jawac+rjCE15xG3dX2G+ICKyUdMtLac+4UZSUXsI1fH+3kQmF6VOqBH55Z80Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9hNMOVj6Sr/2uRZXLsL+lBm9pbyOZCfwIdgEr1+eyyLp7VEPC
	/B3J0mD8b9vgiGMsm5gOMAiZvWEtJGoxX7eyYoecdSZSfnAHVAKl0wwsQH2yXzggKNCpAUCzD6j
	s9oJCQwFYdqmMdFfcQvQVr+7kB2Vl7Z/ezDabeO1TBrHNaiPsvIKMS+Lw1AaX8z9VJR6R
X-Gm-Gg: Acq92OH5CdkQdE6zfS10k/NeBetl7HCDkrJA7G2RPtORWnoTMcPABGWbRX5tYxpCseV
	rOwk0WF1VuI6xE+CLAtZufdPjIi3Zl3IBbMC707Nu+Vmzy8f4g4a5B5TzCRn4hfJcU2ZQAPmHVz
	owLI2u5TIma60GuczRLm3sEkeaMqiOvW3oXkPs+49zGosa4pdaVF0vrUam0/cQwSJ0sZvQary7u
	jqJb3O1kc2nrxCdOaxUvH15HXKCjKCasaqBY+JA6sJ80buJDi6MU24RESqGL0ND/32PSaZSsSHv
	SKoXKwjWvN837DKEkq5VnCvvWyypAMQ3aAh/NQw3B2o818bWDZ/Fto6fIezj6NdGXE3AxzH9JP7
	PIDLMzulRMYg59x56pcvuIgY=
X-Received: by 2002:a05:600c:4e04:b0:490:cc1b:15c7 with SMTP id 5b1f17b1804b1-490cc1b1631mr114019705e9.30.1780927711859;
        Mon, 08 Jun 2026 07:08:31 -0700 (PDT)
X-Received: by 2002:a05:600c:4e04:b0:490:cc1b:15c7 with SMTP id 5b1f17b1804b1-490cc1b1631mr114017635e9.30.1780927710559;
        Mon, 08 Jun 2026 07:08:30 -0700 (PDT)
Received: from redhat.com ([185.16.164.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc0f8sm396828465e9.8.2026.06.08.07.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:08:30 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:08:25 -0400
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
Message-ID: <20260608100602-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <fef7ca7bbf591865defef658b0792b58494aaed5.1780906288.git.mst@redhat.com>
 <aiazXE8pUDeCmP7c@lucifer>
 <8ec82477-b497-466c-902b-82e108ae2b7b@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8ec82477-b497-466c-902b-82e108ae2b7b@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rlXdvgQ-nSRS5p0PtgTtM0BLk_w0WqJiy3M_B-ynNVA_1780927712
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 02:46:34PM +0200, David Hildenbrand (Arm) wrote:
> On 6/8/26 14:25, Lorenzo Stoakes wrote:
> > On Mon, Jun 08, 2026 at 04:38:54AM -0400, Michael S. Tsirkin wrote:
> >> Add put_page_zeroed() / folio_put_zeroed() for callers that hold
> >> a reference to a page known to be zeroed.
> >>
> >> If this drops the last reference, the zeroed hint is
> >> propagated to the buddy allocator.  If someone else still holds a
> >> reference, the hint is simply lost - this is best-effort.
> >>
> >> This is useful for balloon drivers during deflation: the host
> >> has already zeroed the pages, and the balloon is typically the
> >> sole owner.  But if the page happens to be shared, silently
> >> dropping the hint is safe and avoids the need for callers to
> >> check the refcount.
> >>
> >> Note: put_page_zeroed uses folio_put_testzero() which only
> >> detects sole ownership at the instant of the atomic decrement.
> >> A concurrent reference holder (e.g. migration) means the hint
> >> is silently lost. This is by design: the zeroed hint is a
> >> performance optimization, not a correctness requirement.
> >> Losing it just means the next allocation re-zeroes the page.
> > 
> > Do not put comments about specific expected races like this in the commit
> > message but not in the code. Subtleties need to be called out.
> > 
> > The commit message also doesn't at all explain why PG_zeroed doesn't
> > suffice here.
> > 
> >>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> Assisted-by: Claude:claude-opus-4-6
> > 
> > I really don't understand why you have a 'zeroed' folio flag but need to
> > also have new API calls to detect that?
> > 
> > They're also HORRIBLY named. Zeroed as in what? Zero page? Huge zero page?
> > Memory zeroed by kernel? Pages that userland happen to have zeroed? Or host
> > VM zeroed?
> > 
> > Each are cases we address individually and relate to folios.
> > 
> > You absolutely fail to clarify _which one_ you mean, and provide absolutely
> > no documentation and add an exported mm API with no description.
> > 
> > This is just I think not something we want to add? Especially on something
> > so fundamental?
> 
> I raised previously that providing a folio helper is odd, and that I suggested
> that we defer this change.

Sadly it's a dependency actually - without it memcg failures would cause
repeated re-zeroing where previously it failed without zeroing.

It's the result of the whole GFP_ZERO idea.



> Maybe we'd want to add such an interface for frozen pages later (to be used by
> the balloon), but I don't think we want that for folios.
> 
> [1] https://lore.kernel.org/all/5f76af6e-9818-42ea-a305-c0fc1d920dca@kernel.org/
> 
> -- 
> Cheers,
> 
> David

