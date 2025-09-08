Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410F1E130F;
	Mon,  8 Sep 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350102; cv=none; b=RPbyfmE79aYJxRgQba3/7ZtWLBDiI36E6anEut1F1uLRNoRy9IPnHXf+kANON1nA9wNdDoQ2oYiWSpkKEDHYbYlYAiIAF4OituyF23nnKUi2R/jhbSNNIHrRtw62LBATIw7J7AW/wd5//9dh1mvPnGnwQDoVCuwdgvotO1LIxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350102; c=relaxed/simple;
	bh=uSnlDYAkih0wYrWYP/wGKkJTrA/JIOiBaO0koXzi78I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AniKyCbsJ2vJIHEEaX05+tgSgBuULDTcqoPjXQbHim+pAJpxj4Eg7NGl2ccodJ6oOk7WXrlZ4TeEPSMJF8P1cR3XhS1CNaGTg31T7Sw0L5ll9AP45NFDFrn6IxFu1L+y1jBlu2n7TGhGjXl60fxwABLTNlgoHUBo+00X6ocM9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=XK8UCkAO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XK8UCkAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC213C4CEF1;
	Mon,  8 Sep 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XK8UCkAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1757350098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uSnlDYAkih0wYrWYP/wGKkJTrA/JIOiBaO0koXzi78I=;
	b=XK8UCkAOFuRTAaMghbMkYhV8T2QJaLjrkIRbiSC744iVovTaic60Zp5rZ+bImztc351gHd
	RfVyIShQIvu7iaNMFAfleIQgTZHVZIHMKALN8K7z4nH5u5CE2QvEyp5Ifj4Cu887WIjTUu
	PPaVKxR6lJFHUjNXxFZY/txccNFdWt8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3886edf4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Sep 2025 16:48:18 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74381e2079fso4511260a34.0;
        Mon, 08 Sep 2025 09:48:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+UVDmOub83VfgMc86UpHSHlX4YLLYAJ8Z9mu4IuLJs+Cavg4QDLEBaUnsDUuUladMeZ34lA==@lists.linux.dev, AJvYcCWhQUInYrLnyFayL/LKNN0OSeyHvCh4LqAQhPbr5ZV8lfhc0cR0zwKyxp4uUQaxL3krjRbCPC9VN+fFtvug650=@lists.linux.dev
X-Gm-Message-State: AOJu0YyGv98N5a9QoYod/0UquSd32wfZvoDQgPqS0xLyw5cS4ifjvwzu
	kTNxND8kkI3vfjanHkVJfvxkWwcE1h+KrnncnNqSZvlMFiNYdf6r3AxRkEEX+S+sf8lc19pltDS
	WXi81gDVfopvnpOd6L07pOqm98YYoy0Y=
X-Google-Smtp-Source: AGHT+IHX8XF6+e0fkSbHw/Gno/Iv8TyBoDNhQdZJKrK/fMw8uizEVVlHqvT1474ZbZbBOA/u0TsCp2SBgWidGOb2gVE=
X-Received: by 2002:a05:6808:3447:b0:43b:2976:6080 with SMTP id
 5614622812f47-43b29b4b108mr4340525b6e.23.1757350096055; Mon, 08 Sep 2025
 09:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250901150359.867252-1-david@redhat.com> <20250901150359.867252-6-david@redhat.com>
In-Reply-To: <20250901150359.867252-6-david@redhat.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 8 Sep 2025 18:48:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9okig=9NVGS_vSt525C-kR0mAyCnzSn9iypvu8uj0zA_Q@mail.gmail.com>
X-Gm-Features: AS18NWDEbovQfzN2Y035qma21yXmLeYwXyIh1FHAB52eeHDgW6bSgyj_MCTfArc
Message-ID: <CAHmME9okig=9NVGS_vSt525C-kR0mAyCnzSn9iypvu8uj0zA_Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/37] wireguard: selftests: remove CONFIG_SPARSEMEM_VMEMMAP=y
 from qemu kernel config
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Shuah Khan <shuah@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, 
	Dmitry Vyukov <dvyukov@google.com>, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, iommu@lists.linux.dev, 
	io-uring@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, 
	kvm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org, 
	linux-crypto@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Marco Elver <elver@google.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org, 
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, 
	x86@kernel.org, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Applied this one, actually. Thank you.
