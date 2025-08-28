Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254612D7390;
	Thu, 28 Aug 2025 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366558; cv=none; b=LJuDRffjVTliNpt+MSTGhYFASNMShdCrk0KL+dojWxbic4kmA/Fnsy7btP8OB6vLtmgzcUmf0OOpugHGgOWRnAUEmHWVEbZPUBJJG8OygD1pto5+I5EbK0HjrM01TJT2RI9guXEPg+ChZBQolh2HydyNydKSDN1sJij3epoGGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366558; c=relaxed/simple;
	bh=hI4MNrNhgd37xtYxr2d1D8SpHFCU2xcnAfxMIHmVPQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAatPv3avThPuVtDFO60x3x+O+YGOSdSjhdFFv4hK+dhJsX6eJ7wAhbZFWVGTgKI1j1YgVCzZSz9oPO78eO8aJAcklpG6fku5CRMI7lX7WEY5m3ZkU3aJ3yh3BcMR+/9W4zUWdGILUC2cC+Uo+3YVlaxUvH/WPKXxgbmloxyzhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxsNdkf5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxsNdkf5"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61cb9f6dbe7so1128628a12.0;
        Thu, 28 Aug 2025 00:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366555; x=1756971355; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0BfjvXaX7EhpBrJcO9diF40ujDlSeO28TY40tQufFs=;
        b=CxsNdkf5LIVp0faNUUTGrzH3VAykQtsRSYn1ZytwJKxOcxo3G0iCE0Kt+G+aXcE7Ey
         tnvb8bncxBYov8KOmtX7c3K2XYutKpBGZpjAY5/ID4BwZ64lSW6ngvblvpm14ZVtBaX1
         fIlfP1bK1iE3Uurot/13HCiWM2R6+qjPiX2Lfw1TWPSZz+2rrI3DFHRKOS5y5lYnR3Z+
         oPP1PXOn6VOvqqmxn5I6OP50kRMjLkaHNTkdWKwPrJ5mc4azJmdjeSjwM0u23Eq8bRQe
         GUub+xNlARhwgv70MEQveqEjy74IeurHtDpY6nv/UIcUNiWHjDZJ15GzluR1SA2bIPT8
         GmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366555; x=1756971355;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0BfjvXaX7EhpBrJcO9diF40ujDlSeO28TY40tQufFs=;
        b=vUXDfeZaXQqeeGxtnykOUtCWilos5hRxoCar1n2ePvlH9ExQdhCqOwY8tbMx+f0+h/
         UWcThVqTuAC0JITZhwLQnVd1Ni/PYvD1Ho9Y2fXkW5I6HrnUDwg5i3jYKMJ/AXm739bV
         BAiJvJy294jKA3is/1ehuZZO4e8mjLgtvL0W+U2rij+XTnueC19bmPmb8wH2OJaoe1pW
         ofr498m8UnO4QLPYp++OOvS+KeLw625fHJYxw9a42pNsWU+EH9c348oj/1aLs5G85Cxm
         7HqNSdPi7dfzNw5L3ORpU/PJZRd4h3o9B5kIeF64s9hKxdPaZjnoLkW0bTgY+SIwu4kW
         cCtg==
X-Forwarded-Encrypted: i=1; AJvYcCUVY4YULchPd0cr91yV1g16GaRX0RxpVhsvJOqrXy0T+aOvxbbByzqSvEDK1+ZgVApK1dfURmNNg09rT7Nq7Ks=@lists.linux.dev, AJvYcCUiiqfN8YPa6AlE6lpqmSUWgi4W044xdjxTBM0F2socKl/xN2CgYnvZjK6owwtAb598TnZxvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzeDP3iAT3O5F0F5Mi4QuI+nFc8FodVw4bVn2SctRPV1TDx3xb
	1jECkHsqrE4cec9HBq/pAPHWq5IYECkJ3jXXz16F2j1Jdf58/CQtffYtfETsU+6K
X-Gm-Gg: ASbGnctMolhD1nrEcCX4VE3MUp19E/FbRGYgDzQP5Yead91PjnmWhUDpxvRuyQtint7
	FgMCcgZ4GC8B6928CFhyE3x8l99x+zWsm1aSue4dJZGX1D7V06gGjl1ZGtOIcbpTDSuUoRX6lIW
	/zdr00ucLRl/pVBZ0DqV7qfqIQAW/c47gsw5UuvRlu0I9P0xHWwVKQgbVz9+o2HRwq/T6A5Qv8V
	Qe/ukSoM5jEVNNVjIq0XlvYw9dACRbWTLW/nBjTjI5nBOLenykPbcX8T0U5WhfqS2StiV5lw7Q6
	rP/qIj3l0wgfLBwQ2p9zPV0K45cMCsTByjlku4qVAeervfWpxlwHq9T/6FiWDckffwbFPnlb2v7
	SrXBopffOfTGq+ckh3qzomdOGFA==
X-Google-Smtp-Source: AGHT+IETTLjGc3PPKg04ncd1zRzcObVAV207MWaWJmOCZt1EmbrBQuEK0aAe9NGL4LI6P2OcE9HkdQ==
X-Received: by 2002:a17:907:fdc1:b0:afc:aa44:bda1 with SMTP id a640c23a62f3a-afe296bcae4mr2097332866b.54.1756366555363;
        Thu, 28 Aug 2025 00:35:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe68891cefsm988052566b.66.2025.08.28.00.35.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Aug 2025 00:35:54 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:35:54 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, iommu@lists.linux.dev,
	io-uring@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com,
	kvm@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com, x86@kernel.org
Subject: Re: [PATCH v1 10/36] mm: sanity-check maximum folio size in
 folio_set_order()
Message-ID: <20250828073554.evipmbkxrint3tbs@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-11-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827220141.262669-11-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 28, 2025 at 12:01:14AM +0200, David Hildenbrand wrote:
>Let's sanity-check in folio_set_order() whether we would be trying to
>create a folio with an order that would make it exceed MAX_FOLIO_ORDER.
>
>This will enable the check whenever a folio/compound page is initialized
>through prepare_compound_head() / prepare_compound_page().
>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
