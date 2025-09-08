Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407F1DF26E;
	Mon,  8 Sep 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350046; cv=none; b=czivLqtzcxXj5YOBaup/w/NmDbCqVwPAV7KnyqDMiG+ILK93DWDgJR+oKHFzRwZU7RMA4ftvd2mw5U1bQzj5ykEa1tMnkEZk7nyJoLNuF4l8YdY8EaSop/+2FK7l1/3oHPOHsZTlyXDE9znFI4dbr556KhC/OkIe2TnY5lijwRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350046; c=relaxed/simple;
	bh=lHuXjtnGIwA8Zzr3bT7RPQh03xIe4TvMRJ0gk9Qtcas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAakN4speymXtgqTjpZRe6aItVUe1nLllDdY7UffJsRz6/xsRD8eS10EYHMB8kbGESFMOj5vO8julZxluSV/CU04kDtT2Zi54Gu5PCxRatDclJ12LW1JO+F36bVgRMwEY9kNZZOdvQG0M+R4HTvu9VW1B7Q/cc/htOYCzMR5rX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Xljewnqu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Xljewnqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF76C4CEF5;
	Mon,  8 Sep 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Xljewnqu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1757350042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lHuXjtnGIwA8Zzr3bT7RPQh03xIe4TvMRJ0gk9Qtcas=;
	b=Xljewnquq+YctTo5JATPHR1MZHDXoI79+kGomlCc1eCG+TF1KFpPNGPjgGgJ2eyL9t7Zjn
	9biPRJbSKpqslyEKR3leW33R1mqvnTuz7Lwht5N6SjYJEP2YGAgAppqfCHzPAnVKAINjLL
	MsEGjyeUnvWaxgUSVvlw0rheoasfYJI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3267e227 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Sep 2025 16:47:22 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74381e2079fso4510302a34.0;
        Mon, 08 Sep 2025 09:47:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6gvVNdsLG7gHBhviy1S9RX21ue1Mh0txlbwZq4wkFO9rBXHBXlMRs8xGGQX3Jmu8nybH9XQ==@lists.linux.dev, AJvYcCW96dk3ST7ukKcYNWtIrGT+BQ36xEIHpGW3gM6+h0izGjo+KQvr7afsecx0hAJdhjqODREKcdIDNx2DiMkKQFE=@lists.linux.dev
X-Gm-Message-State: AOJu0YyX9Op4yoy4LXMb4cqZWhgGxfy0LM2rmTRwZ+jya30AonJCye4N
	FbGj4/ab/GOYiVsybBwpHMxVuMsCzOxyuo3mWNoDy5DvpZS6HXb21EbSImBAXja1/FZSdmL8ExA
	1oSfBM5dzukyj2UnFBXCd8FcJWwhj4+4=
X-Google-Smtp-Source: AGHT+IG1lksSpt4e4b7wpOLuoBOgU4CtzIVFITSYKRy7vIMNnTgG60R226zI8so9rVaf/KD14awSBHuCM8l64s4kZfU=
X-Received: by 2002:a05:6808:2e4b:b0:438:37eb:62b2 with SMTP id
 5614622812f47-43b29b952ffmr4287499b6e.44.1757350039548; Mon, 08 Sep 2025
 09:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-6-david@redhat.com>
In-Reply-To: <20250821200701.1329277-6-david@redhat.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 8 Sep 2025 18:47:08 +0200
X-Gmail-Original-Message-ID: <CAHmME9pO-g4qUUsbF+XZqcPcwfP3-N7AxR+MX6G73adc2-NAkA@mail.gmail.com>
X-Gm-Features: AS18NWDayNVnEOpkO7Cmy5o2hUWkz6cio8gfE7ZsOxyaASSZD8l09i-KslFVPvE
Message-ID: <CAHmME9pO-g4qUUsbF+XZqcPcwfP3-N7AxR+MX6G73adc2-NAkA@mail.gmail.com>
Subject: Re: [PATCH RFC 05/35] wireguard: selftests: remove
 CONFIG_SPARSEMEM_VMEMMAP=y from qemu kernel config
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, 
	Dmitry Vyukov <dvyukov@google.com>, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, iommu@lists.linux.dev, 
	io-uring@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, 
	kvm@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com, 
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

Applied, thanks.
