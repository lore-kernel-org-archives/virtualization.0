Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C713AD09
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308826; cv=none; b=uC6IC61YRu43L1AymgwhqJJaMN5xg1k6RxBmfSjS+TB6begqYeyCihmqIx1KXJbrd6wBApKo2qvzGV8NuIaV0oUAafms0vTNBeT8RRO9YtsoFk5G6NdixmPrwAs23VTwe15pzX2kWZATD3p4N03PqFp5vIVW0MmAKGNHPgmaZk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308826; c=relaxed/simple;
	bh=7uTH0tO+FEhg1y99XU1/GxNzFYFUfFBcoWEJtU38goA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjVpve5XSdIV2oGCZMOC+dT0llb1H8cyKPbOvGUzH0hJxsSSszSWtE+NuxGOiZQZ29BA1efzsdkoFQPLCAf2oNvuqeMQ7JKSkLXNp2zmYBPy17rSKUbizCqWRGtvF8Qpxg+M81nUz2qpX/YaKOOBLuvzb5dvp9o7BRPYXHmd7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AoivSOau; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AoivSOau"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so510052e87.1
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 23:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724308822; x=1724913622; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FV+CxgS7SBQNoCHIorUngjr+oE9e9INqSoC4Nwb3mnM=;
        b=AoivSOaur6P0J7X0HS8HBezsRq7MvAdpDqwuWMWOcPGTOODfEbs5qw+C41W8ynL+Uv
         kLaMmGBK0Su6fyz7mwPVtkg6BRN9n2i26SoG3UwoZszhwYYWOSu2InP/E4F91QMfKIry
         PRqpZrHuSHjuN5d+iqjPxCUd8HNOYEQSj4myQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724308822; x=1724913622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FV+CxgS7SBQNoCHIorUngjr+oE9e9INqSoC4Nwb3mnM=;
        b=ZfNXmRKlnye2tV1GkMCWoVdSC4skLrs1dn44Cc8yYN9MXRAROykZna9f5lVuGgvDfv
         TfiIIQgPBuGQPElCTpLDVUqr7wu0vP1BMZW+IR0NZqudIqU+L4a+TL1LP1kIqNecn2ks
         J5dt5wb7QxDHhRo0I7nrvW16Bz0mol8rNx2ExPoz/Gi4+q/CyTWDT7hSOCT9FGsJ+2qH
         6JKgX5Af0hq5xO/yqjU/fWgxo2VQe8gFUt7i0e3RWKHtUcwWNJKEau5EJffBfka0G3Dv
         lRfmH1NwSdPC0CP6Bfkz+OCVEFYw4qulI+enVcVboGAobaTbUPmY+lazMqOKmz7wAyKX
         Tebg==
X-Forwarded-Encrypted: i=1; AJvYcCUQmRsAdk5uV2FkDabxAGy+7WA+PWfzDvpuVDT9yZgc03U/u4GtnjOCHILKSWkI668H0+f4YYH1Vhm61mxUEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyseGS9R47/b+CEhEF5VP4zp7Bsb+8YKGrZvsgvCRn+ZcrK23/v
	ITkKcJ4xZB1ezEzPKqsW/4yU+QxQfDqISLAMdqY/g6/u77t9e6446jFxYUIrMXsk13+Ax7b7TtI
	r/6ikqQ==
X-Google-Smtp-Source: AGHT+IGGhJwy/MMuhHpiWzLW5HwKaomBiZblI1/UPm5rELs3yLrHOrzSS7VR0DAWZvETHwOxnLAQJg==
X-Received: by 2002:a05:6512:220f:b0:533:483f:957f with SMTP id 2adb3069b0e04-5334fd04c11mr379119e87.32.1724308822156;
        Wed, 21 Aug 2024 23:40:22 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5da14sm129301e87.206.2024.08.21.23.40.21
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 23:40:21 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f3f07ac2dcso4109021fa.2
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 23:40:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU98eBJtvYfRvRL2YUMkrKPWmELkpDHZm/wBbNPvbFE9mMMH1EZEfT+Xl3ScujqJ23XG415t6DzngLw6CTSug==@lists.linux.dev
X-Received: by 2002:a2e:9b14:0:b0:2f3:e42a:afc2 with SMTP id
 38308e7fff4ca-2f405f2517amr3488751fa.49.1724308820768; Wed, 21 Aug 2024
 23:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com> <ZsbY5pNhDqGoxJG_@tiehlicka>
In-Reply-To: <ZsbY5pNhDqGoxJG_@tiehlicka>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Aug 2024 14:40:03 +0800
X-Gmail-Original-Message-ID: <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
Message-ID: <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Michal Hocko <mhocko@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 14:21, Michal Hocko <mhocko@suse.com> wrote:
>
> The reality disagrees because there is a real demand for real GFP_NOFAIL
> semantic. By that I do not mean arbitrary requests and sure GFP_NOFAIL
> for higher orders is really hard to achieve but kvmalloc GFP_NOFAIL for
> anything larger than PAGE_SIZE is doable without a considerable burden
> on the MM end.

Doable? Sure. Sensible? Not clear.

I do not find a single case of that in the kernel.

I did find three cases of kvcalloc(NOFAIL) in the nouveau driver and
one in erofs. It's not clear that any of them make much sense (or that
the erofs one is actually a large allocation).

And there's some disgusting noise in hmm_test.c. Irrelevant.

Now, this was all from a pure mindless grep, and it didn't take any
context into account, so if somebody is building up the gfp flags and
not using them directly, that grep has failed.

But when you say "reality disagrees", I think you need to point at said reality.

Because the *real* reality is that large allocations HAVE ALWAYS
FAILED. In fact, with flags like GFP_ATOMIC etc, it will fail very
aggressively. Christ, that's what started this whole thread and
discussion in the first place.

So I think *that* is the reality you need to face: GFP_NOFAIL has
never ever been a hard guarantee to begin with, and expecting it to be
that is a sign of insanity. It's fundamentally an impossible
operation.

It really is a "Daddy, daddy, I want a pony" flag.

             Linus
