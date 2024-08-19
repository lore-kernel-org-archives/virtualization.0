Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF20157E91
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096020; cv=none; b=ANmFWYbvqyy8CbTWxL7s9DXXXX+Sh0awb9pnw2ZzGMoqLVRKkgoN3PVOIca8wTty5kl8pPY0mytgaL2vwdT+aJUhma5YomeDL7js77hjWZikm5CfEHB+piHULKqxIj1mSS1QF12ka6AZTPHntIIikN+VloMFI23lr9MireeWhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096020; c=relaxed/simple;
	bh=I0CConYifRN4sCl1rpopn+uS3WXDaC4UI/h//qXTrBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMnXrYVnnbmLKm4Kb8YKhIdxittcNsuRwl/8EPaM71HyPL1zeAaEQYBT/PK07KOO5Heapve249k5Fboj4Cbn3xkw8V9HMWpbqHUfzHgY5tSIhXicAZ9SVgzDUE4kz/LfiJ2E7PzmvO4hsLcDish/cbE2W5CLAzGHKVGAYozibgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KOefOSsc; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KOefOSsc"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef23d04541so56247331fa.2
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724096016; x=1724700816; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVFvAEWSv/wRFsrp0jJ7YOpnPCVU5qMAAO3g2Hs2Ej8=;
        b=KOefOSscPSAWSvFMTSF5ZcbjDUxqwA8ZnjmS+YHcgs/a0dX3e6A8QQq6qee4IRT7UZ
         rgCgeE80ELIiqDThFUJZJx+hKCxSsms6dJxLho3oJR7IteNcRg3E1OfjKd3uGlarp2Q4
         mPmqp99wsICVw9v+LJrX07Lq4Cu3t5Mz6mDr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724096016; x=1724700816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVFvAEWSv/wRFsrp0jJ7YOpnPCVU5qMAAO3g2Hs2Ej8=;
        b=VGv8r5z+RWOxrs/232MBngbTnOUymp5th/onEYTh+gxb/x//RvH9A5DGpfOi4qLmBe
         tQ3MM5ThDGOYCcbrMwT4b4UgfOHyxSCjelqrPlVPbVKFtCN/ux1SH+OjziPh9NgARY46
         7pPvDHOi+aPGN40SNrIM70SBNZUmBNJD95XCOod578W/Ww+rdydgXatuktFqS1nPaUZR
         q5gtNjP7gwfRoewItnJ+cFQI/ZXzE2CjVyo2Ps+FljLSutKT8g6v65WU3/8+J9aWFZsj
         +rDMVTuKxX8UMnD+tz+LCf0nmS37dCkrsnGeaMSvaId8ABN6xi2SK+7b1wKbfKAXbLMQ
         Ao+g==
X-Forwarded-Encrypted: i=1; AJvYcCUZW9Ci7QWKcKNbjiol0FoR2Kb0KYMGH5ARGWZh9WGSkzgniMUs7RR/X55RiwMjTvYkQ5vRtT5Iw9WWih38nTBlhNANeEb/zh7fV9er21k=
X-Gm-Message-State: AOJu0YyQrq4dMwnAF8gcqgeggZd+gj8YMSfLuwOfvzjuDJb78CyABgcn
	nALlgQhEkVJNg+OiNwdcWagf4FNFkkgn5ZVwpJlXhLNzeVBXla1yTnpGjAkZ1iVWWWoFqdLh+YW
	DBg3ENw==
X-Google-Smtp-Source: AGHT+IHIm9Qu7vmrC5zVBjNYT0HNfWGBNXHUmqb8K1sU3Imc6aSjtnuS3d0uKGONLVrgrtWnNvlFDg==
X-Received: by 2002:a05:651c:33c:b0:2f1:5561:4b66 with SMTP id 38308e7fff4ca-2f3be5f3f59mr74733051fa.44.1724096015635;
        Mon, 19 Aug 2024 12:33:35 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3b77039ffsm15912271fa.77.2024.08.19.12.33.34
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 12:33:35 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f3ce5bc7d2so24188631fa.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 12:33:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGKUkLcUUeuaov8Bjt1a4Z9KmvidZ1N9DjL+ICxQCMgAEYeSA/g4rtV9Sdf+CvtRJdXwf6uAZrRU+k3bE9SJfOk1ip04H6/eIhuKRpHkA=
X-Received: by 2002:a2e:9595:0:b0:2ec:55b5:ed45 with SMTP id
 38308e7fff4ca-2f3be5978f6mr76523451fa.24.1724096014503; Mon, 19 Aug 2024
 12:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com> <CAGsJ_4xwj+trzpOS4b-RSHtqHkD4+0g1Sadr7YCiauOBgd35dQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xwj+trzpOS4b-RSHtqHkD4+0g1Sadr7YCiauOBgd35dQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 12:33:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=who4GDu0gXZ2xWdpmTOQ_OZaWfgVmcADUGo05Eoa-jKxA@mail.gmail.com>
Message-ID: <CAHk-=who4GDu0gXZ2xWdpmTOQ_OZaWfgVmcADUGo05Eoa-jKxA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, mhocko@suse.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Aug 2024 at 12:23, Barry Song <21cnbao@gmail.com> wrote:
>
>
> That could be an exploit taking advantage of those improper callers,

So?

FIX THE BUGGY CODE.

Don't make insane and incorrect changes to the MM code and spread
Fear, Uncertainty and Doubt.

> thus it wouldn=E2=80=99t necessarily result in an immediate oops in calle=
rs but
> result in an exploit

No. Any bug can be an exploit. Don't try to make this something
special by calling it an exploit.

NULL pointer dereferences are some of the *least* worrisome bugs,
because we don't allow people to mmap the NULL area anyway.

So just stop spreading FUD. We don't improve the kernel by making
excuses for bugs, we improve it by fixing things.

And any caller that asks for NOFAIL with bad parameters is buggy. The
MM code should NOT try to fix it up, and dammit, BUG_ON() is not
acceptable as a debugging help. Never was, never will be.

Worry-warts already do "reboot-on-warn".

            Linus
