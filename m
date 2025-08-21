Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF82374294
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807889; cv=none; b=SjG8LI3TurH+I0P57F9VuxpKaKojAGZPUppewZvW+9W+rmozw52NAlKeCfoa2d6J7gFDMrMxAn1XlOaduK0brNz1Fzw2rn21n13s7hDxA+b8Llc2y3HxbvkkHEivv1GDrLdKkN0H8MYYh6hcv7ivLbSNKWHwfXsOvCMoLdTn2JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807889; c=relaxed/simple;
	bh=oA3XFTq+X9InxrtY53OI1FqTpqPTKR+1uoMqvtlA0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABpzs2iQydAl+kT909YdeZ/0zgcCwwlr/K1pfM8yCsBldULqApFD1xC8Hdicq3Jo1gf3ZAxh+ieHn5XaywtwLMwAPm0gYjcLAPs41lu/qGBOc7CnLBS1nF6f2tQu007vczbBH9xKMVUiZMqqZ3R9YAvaDlKFNI3bS3ddraWLNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FFyTczFP; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FFyTczFP"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-89226ff4772so106502241.3
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755807886; x=1756412686; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=FFyTczFPJsbW97d/IuCofSLETM8tlcsbDrAlV/kRHLJauOxJMy4AyO2kxJpwT/YTQt
         BvkzUjyUsQTQpmrVpLTWkUfqTNxmeUHe2qc1AGjMobUwgEJ0YigeNBuI5c8OmPh9AzD9
         6GfLrEFcpBWp8NydXR8w7jwOXd0CNvDbTK0js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807886; x=1756412686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=bwHLIt1ouCIyBjf4cAOX3hUA3nMklCWTCgiojpjPHeqfp+lT4C0ZQR6yV7Ckqrfp7V
         lPgHPdqBMDWbhOsleXesQoyfuDspYmGfTV2a3NR2PwxU/AQTOV5mUsF5n7IfRhsOUB/6
         425rzUDgcCc3RV+/WGd8kJSyluYjtCuIsgnH6dqwKlwhaOSQRMDRLUq2Zn2dmHlw60dy
         kkL4HdH2tsLAVg/K2qL4z+6WoA9pfpseY99phiJEpEoS4wsU3lYikU0uXxjmPTzpsPtn
         84zbbkSLKLwh94tAtFxpe16+Gmm7lpWf/Rb2pY6au6+jKEMN9dR7hnx3vhbgCVkL+VwG
         vcrA==
X-Forwarded-Encrypted: i=1; AJvYcCV/JyCFSTLwzY5c8OrLkvLp6x1vgbNJ0YYR1fxCrMpER3VFJde7yNkeEjObr50x5rfL72l98MWkuPZDry/7WA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRB7qA2cuW9B5uCQU9A/rkdW9YEMOlHWAcx4PMPm+Trzeo+8wo
	eXo9wPeUUqW8+b/BoIFqn0XHJUoW/Uy79xfpFgv7j4t//s+0pMGcbcmGeN3u1FdJFGBuGd5O6t/
	ahjinlfE=
X-Gm-Gg: ASbGncug7tahK0IcnWee2r0XprHvxrMFDP29a5Z1SwyzByRYcC03NRYsKkzraGMpVAd
	b1MMWjrOaLKlAp7AXu5zD0wDQHBuK3qzbIJUr0CjWohvZly/vVRJKWv/ZEGAs6nSygZNKfXjnf5
	i39c6jEr1z3t6Zrn9h2Z4Ps7uhgT97nLFhcqqtJgDOSvVpKa+CNdUtAPSE65osiYRwEPQWQe9+J
	T6qYk4lxAlaZaBjeUwW3lTK/TpaFNezzb7u74L+GwZq392CQ5JY2cSi6Aozi43Rg7xbYpjCl0in
	BH0TU/R1cdZ19/WPPJDZsLrYtBNsBtF6T1HqdfPAvUjxGrbDAAcNxPMKzDN+8RsfoaKHw1I9CsR
	W3C86Bgc2OpnEogP3D4PhdbQdRq+s2pA14E25KIBcn7FdDhBM+LS4wn36r4GC8bJmtlJpOfXbCL
	PR
X-Google-Smtp-Source: AGHT+IFk9jCuorh74g1czwZ4fWv1DykIRWb3+S48lgG4ZlbRK0pNb7gh2BWAMUdziMHYBV7MMpqNbg==
X-Received: by 2002:a05:6102:2ad2:b0:519:534a:6c25 with SMTP id ada2fe7eead31-51d0f9244famr209509137.35.1755807886449;
        Thu, 21 Aug 2025 13:24:46 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5127cff4717sm4186140137.1.2025.08.21.13.24.45
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:24:45 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-53b1718837dso603897e0c.0
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:24:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOgammzrAmU6p/SXO2Par6jXRpq/37hxAs0c/cC/dVljQPGZPat5oIa1wpPzab3trN35laU97Pbw0SK4Fp4Q==@lists.linux.dev
X-Received: by 2002:a05:6122:1ad2:b0:53c:896e:2870 with SMTP id
 71dfb90a1353d-53c8a40b923mr212315e0c.12.1755807884664; Thu, 21 Aug 2025
 13:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-32-david@redhat.com>
In-Reply-To: <20250821200701.1329277-32-david@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Aug 2025 16:24:23 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
X-Gm-Features: Ac12FXxaZhwn04a0gbwY6rjh9UGLxnRlGOG0Jy0WjRbVAG0UxLDqNy0Wydj0GQk
Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
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

On Thu, 21 Aug 2025 at 16:08, David Hildenbrand <david@redhat.com> wrote:
>
> -       page = nth_page(page, offset >> PAGE_SHIFT);
> +       page += offset / PAGE_SIZE;

Please keep the " >> PAGE_SHIFT" form.

Is "offset" unsigned? Yes it is, But I had to look at the source code
to make sure, because it wasn't locally obvious from the patch. And
I'd rather we keep a pattern that is "safe", in that it doesn't
generate strange code if the value might be a 's64' (eg loff_t) on
32-bit architectures.

Because doing a 64-bit shift on x86-32 is like three cycles. Doing a
64-bit signed division by a simple constant is something like ten
strange instructions even if the end result is only 32-bit.

And again - not the case *here*, but just a general "let's keep to one
pattern", and the shift pattern is simply the better choice.

             Linus
