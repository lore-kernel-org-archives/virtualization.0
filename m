Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142EB18130D
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320424; cv=none; b=lJ84Q2zJna4cmfgWxaFMPNP1w7z/c/YLxbXg3viVHyXIZKkPLPalSiYT9v7wTigXmpiE5Rb1WoXlcW7h78s0EAENb17LtZDuDmsORnHm3JiUdZt3GPpLQPwNBawz5m8ILSVT29VPiQFbhwbkYBfn79lDYiWaaEy8ndA/t67b8VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320424; c=relaxed/simple;
	bh=xeC9bLVX7XlR8PfPAPw1u2NV5M17xmefaivycVRTuGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsaUuMImylC8Hhjnm88SfqyNjisdA+EgUL2HJzXawH4HgCvF0eXfwEHz4S9Qspy+4ge+ldRcquRIa6QNfKyJYcv9Q3v5uYToQFYxybG25VuLfngyOxUvPvLpZg3p8a6VVMTBji/FRODyRagL7EeKtBUyyt5guhmiDTUpE/YpCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FLje0rEN; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FLje0rEN"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso5289251fa.2
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724320421; x=1724925221; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oLpKgCYbvBWwekM0JlyDj61dVStKz9v67XCf4n+KdkI=;
        b=FLje0rENjQg72p5PrLzkiyIbhGL3NCbWYlq3Y8blZlMzAkO68whvlmBHRU0FE4nsM9
         7Ar8IoZSIzFRAwyVRII4MflZFagVTVgR/cCG5Zdg+KlIaxv/AG97QvN8Wh9scRWq8mnD
         LU70r8Ji41TiOI9BE07OlKIoJMMjg94zpA28I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320421; x=1724925221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLpKgCYbvBWwekM0JlyDj61dVStKz9v67XCf4n+KdkI=;
        b=N1rmnoZPAATRJGUduoSdsNYRhZ8fwdpSyoJ2aNaAfvGHqGsJ6UPIauCnfdrii+I7Ui
         nc+xVsBrMuqSpXq2fraA9UQ4XPd4q5kaqT/cqMlnBdFETOxH4VnPtxzjv2SRxIicKWtA
         zSsHQSACMw/5xdLlTvnrArb3iPbG4/AJ0/I4lPeb/s+L30XxIRCjpD5zI7Aeip2stKnS
         i/OFPzaI5oxcS9NrassqnP1fxVFWx9ENCu8exqZFyzLb4BeCI6SnkILR0Vcgs8cs43k1
         JGuV0RGqScenSHVryKCNEILa4F6vyjC1FgJk3bsaWRX1eqeNsKD608pKFRjOvQnCQZiM
         074w==
X-Forwarded-Encrypted: i=1; AJvYcCX/zng7qk0R0ysqX4lROkMbHjBcwmHmMIx9LAkC7eaVCb2Y8rMSjyv2vtvlvllFHENyWrBHDsxhycsCHaMEmw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx92wvyWxBud59jlhRBOl4OQQ6KQGSGf3B5mKkZS2vmDL3fQNnz
	N6S8jBzPu3/Zwa7xlB9qWnE4qsClNo8KNmoYUiCNtyA1x5ewpfLFLIriLY6mYTycpXm333vffod
	4lD/Wvw==
X-Google-Smtp-Source: AGHT+IG5Qmie4qJDmpATuD+dspd517FbW9M00Vu1LmoNIKoNIpm2gKF1+U4qnuc23LdQkkn8F5+YvA==
X-Received: by 2002:a2e:8708:0:b0:2ef:2247:9881 with SMTP id 38308e7fff4ca-2f3f893e138mr34612431fa.31.1724320420638;
        Thu, 22 Aug 2024 02:53:40 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4047df48csm1529761fa.67.2024.08.22.02.53.39
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 02:53:39 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso5288931fa.2
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:53:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfn1XE23eX/KQzkUiakx7CLYUrvDXxSPplnS3nACXqHsBIFjkdF6nNPez/p5R3iTmhxZ0ZgtcM2YBcFNK/BQ==@lists.linux.dev
X-Received: by 2002:a05:651c:221b:b0:2ef:2b06:b686 with SMTP id
 38308e7fff4ca-2f3f8833529mr43486231fa.17.1724320419189; Thu, 22 Aug 2024
 02:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka> <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka> <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka> <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka> <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>
 <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com> <4df58ef1-b379-484a-aa5d-ef77a1200c63@redhat.com>
In-Reply-To: <4df58ef1-b379-484a-aa5d-ef77a1200c63@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Aug 2024 17:53:22 +0800
X-Gmail-Original-Message-ID: <CAHk-=whx7a6HTjLLDWz4Vi=ARqg+cReWoKAbrdH22a4=u4FKZQ@mail.gmail.com>
Message-ID: <CAHk-=whx7a6HTjLLDWz4Vi=ARqg+cReWoKAbrdH22a4=u4FKZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>, 
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 17:43, David Hildenbrand <david@redhat.com> wrote:
>
> So on the buddy level, that might mean that we limit it to a single
> page,

Actually, for many SLUB allocations, you probably do have to accept
the small orders - the slab caches are often two or four pages.

For example, a kmalloc(256) is an order-1 allocation on a buddy level
from a quick look at /proc/slabinfo.

So it's not necessarily only single pages. We do handle small orders.
But it gets exponentially harder, so it really is just the small
orders that work.

Looks like slub will use up to order-3. That smells like an off-by-one
to me (I thought we made 0-2 be the "cheap" orders, but maybe I'm just
wrong), but it probably is still acceptable.

             Linus
