Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B41034A32D
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808608; cv=none; b=lLhPBF4c6A1DXIyqDnrvhI5+gAcahlIjDVeWW0KTIrttpteDV2eiV+pHRLrfU3KiLzMQWOz93XGVsyakPoWOzbcHlzXL35Q+04DA+VZ5Xq0UJQoMdvu3sok/fBfP4+ppbJp+pjfhRgQIT4V6+nzhSCvum7+ICIJLd2XeAqrY8aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808608; c=relaxed/simple;
	bh=yojduCRvPCmYgwaX7kfWJ1p+To4BJmiAMcPa2zQubFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzEi+LDcIr2tpWwEhsFLnhVize9mUb0eyGWlYsy2XZ3J9oHQWRW4vNKml8pH1oNXAgWiOv8D5gu4DRYLDqX+J0YG6cp00DfXtgBYpQ/8owZGxkgQrarUrB23/OlfEh+4iiYBVDeDIeGDuLsGe18VVbchmVcSrJaFHDnCIWoqGoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dH0p8QPi; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dH0p8QPi"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e9505d08ca2so1188367276.3
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755808604; x=1756413404; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=083PuN2wICwWm8iwB5WBlP6qyKXLyqdZEBdZ0ztp8l8=;
        b=dH0p8QPiJRuTPLIWkZyHvUxJ4oQ6fOcVlns9slr0+JkrrHOghmReWlaR/rXLv4pmWd
         trbwx1TOLCyJ4HE2IQQwK2IH+Xtp/PViI3PiAMNgAldEajWh1V/gUKv/YNm0tEZ/QBjq
         wgxICY2QnL77QhirRLK0vpGHg8L5XdiLzJUhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808604; x=1756413404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=083PuN2wICwWm8iwB5WBlP6qyKXLyqdZEBdZ0ztp8l8=;
        b=em6QEEm9DEf13SlWmf7Vb6tchb8HwAIv2PPWErN3/cY0NQEKpkz201QmtnyDvst7z3
         APa4uD74CeBm9IPZyCy2wSEs3VQ2+sl3GDsGy6Q9iNDbKBAFtYsmnj+POKqz+pval0T5
         oMwR6s58gYFB/ogb5A1vHiuVeBX2m3ihSldATyYC1saUFf3RPfGwXuhmrN2Qv+lCbu7d
         aJIt5uiBYF7Gj633AywvNEPXVcwx98jUADHeZAdlzSfVQUez1/YrQUK4Qg1yDKcXJDRC
         /ri0U4SEa5N/NiDM+OagT3WEXP9OLAxiluMxr52tVSgf16m41+VrixCpaD9fGZP6iD2q
         KH+A==
X-Forwarded-Encrypted: i=1; AJvYcCUtAWNfYRDGcND2ygVY+UcDHfUU7IAYVtlwz+L2Q6lKuT0QxyNsYQ8eHFDWgC0J46kpxdXvdOShtqp58mzWUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVgSvaQHS87zCdjLybP3RtrhjvLrc11ZRXDfGoJe2w2cdwiIiu
	DqdLgnz3hFPsYFVPC6z2E6LQ386Ye4l7IxiCjbaSRSfEpCHaNnNYy0QR6ZlsLxd7z8XbRDN67lw
	SnIWFNtlA2IQ20Fu6cJwZpIxkkKtdWx1tFbdMmEnwhQ==
X-Gm-Gg: ASbGncv5khZez9v4X0OeTISJ5zMxSrPBzSoO37wTYjbYiyxbGje8p1NasjlIUPbPjhW
	bCg0ZxRtSn4yo2jrwWafJHxUxN+naH7O1C0AFGXYTRHHY8dhmICP4mhcZry08K8finM3H2AqqUx
	f1SVn97JkFPujTLIuxzqchVZ63bAs1IBrxczJac5Ci4E87KaZYDGyv5ODatAKjfYEFe1uSHavMr
	bSXYwBd4Bmlql5kSqLkSQcQoK8=
X-Google-Smtp-Source: AGHT+IHnF0lVhm+1Tun1UWlMLnnSk/jF/jUOt69DP22IOjEUNxjHdHqCJTIRGjm6XM6hiUq/Axp7jnIGuYc/D1Y8ZZI=
X-Received: by 2002:a05:6902:4381:b0:e94:dea:b80b with SMTP id
 3f1490d57ef6-e951c365621mr715984276.40.1755808604080; Thu, 21 Aug 2025
 13:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-32-david@redhat.com>
 <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com> <2926d7d9-b44e-40c0-b05d-8c42e99c511d@redhat.com>
In-Reply-To: <2926d7d9-b44e-40c0-b05d-8c42e99c511d@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Aug 2025 16:36:32 -0400
X-Gm-Features: Ac12FXz8i_O0Dca-zCdGNOyRYVeCyfB9Z0ucQ3KoLazk0PNM2PIB2a_qe1sXKks
Message-ID: <CAADWXX81Y3ny6WvDN8EeYvBPa2qy10PKhWfZpj=VBcqczL6npg@mail.gmail.com>
Subject: Re: [PATCH RFC 31/35] crypto: remove nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Potapenko <glider@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brendan Jackman <jackmanb@google.com>, 
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	iommu@lists.linux.dev, io-uring@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, kvm@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-arm-kernel@axis.com, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, 
	x86@kernel.org, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Oh, an your reply was an invalid email and ended up in my spam-box:

  From: David Hildenbrand <david@redhat.com>

but you apparently didn't use the redhat mail system, so the DKIM signing fails

       dmarc=fail (p=QUARANTINE sp=QUARANTINE dis=QUARANTINE)
header.from=redhat.com

and it gets marked as spam.

I think you may have gone through smtp.kernel.org, but then you need
to use your kernel.org email address to get the DKIM right.

          Linus
