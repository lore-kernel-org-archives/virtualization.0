Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC659158A36
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 20:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099744; cv=none; b=VYQwVVPodE5nUJsC5qamzJhTlg+35MZDqIdp2ftDyE0YsVQa44ODu+iXQFUQbX9xPZojrkkIVcUwBnWRJRUoVLYdjAHSlSXwfVzUbNi+HYs05Md0gqRtKQGBcogBdk81mJsfxmGupyy0eHczEu5oD4ItRCO4kczzuDrZRml0CLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099744; c=relaxed/simple;
	bh=6nantcWvl4cSK6c6YYuqvNtwHPoo6xFMl7jxgWyUS3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhgHLovYnfX0QoA1HMtaVcWac/9VzAAPzAZ2xjZl2sxqXYnMh5Go1xqhievYuQK2WIiGe7/IQb7jldLCv3q+cXH/PhtoM/6kg49UU3sYICM+lATfLkeH/eT4q9xEvV9QexQJV9iK4V2QbOLom8pnwL3a5BZArXYpcCLDBjT+Jx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gs3vmiqh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gs3vmiqh"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso648664866b.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 13:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724099741; x=1724704541; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/pVNYLOMNJ5i8IARyTldtKIoyBXjN1J3Q4VX2TRBps=;
        b=gs3vmiqhW/rySCg5AHFlT0AaMxob7tmpU9d2RXHIAyE+SzFPGOshxx4Xsp34NLtgZs
         M7dLQ3C4phq01BJhOHLvOxsOOdU02uWhlKvMjgmcSA1YadjVFI4byruaRceHBw5UTh+N
         DwICCoy4oHnb+k5csk9QD4xGfGh96jd1e0sgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724099741; x=1724704541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/pVNYLOMNJ5i8IARyTldtKIoyBXjN1J3Q4VX2TRBps=;
        b=OXwvdBDa1xqDZNBQOmFDaq3E0WAjtoC2caPMy/sY18nW2lNE3yp4cDgk/N2sW/f++M
         Lc8CTSCqTmnT0vW2ZaWPbUwSRJ2MVeyZmgQ2E2vmBW3p99G4rlu0finR9Tjt4oyY4ix2
         iloz4Sks9QiP8wMQ4tML5VxMmBGYrBC+PnRDI1sazrUALeQz7Sg0SUnGuFHypKfiEr8X
         bRHgN6TwHfc1f8R46In3PiMWdVFPrmAJbDCoqfER/Rcz8IHujyyyCDT+RmA2+A33CWVB
         ieqx3oppd5Noib6OGh1fPWyumo62LtBdJwYsLPTq4RCTfVUoQopZE1u30IQ1xZCsDj1s
         YZ9w==
X-Forwarded-Encrypted: i=1; AJvYcCWnZcJNqETT9Giu7SPdzr+znxKP51DkZW2kXWNERB3PcieIoDS7OGGVsGuji6K0BttxGFakRFtK05P1O3IPZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvCyhT8etTyVA9ppBW93LIkkhG6ENzt244Yij4JEOuL1VjvlJd
	IqgBV0HjM5W3MhRNK4R76dLW4gjKbOv/KgFKcW1EcGkAtlpA+oqWqLxu3HkygwAXlV1PuRT1cQp
	t1EYuAw==
X-Google-Smtp-Source: AGHT+IFxVLJMblNyknIv6Pk/Yjt/+OLObJZLcJwws++EdE67qfFn4+g8LXK/KOK4oyXAmkr5cvn1lw==
X-Received: by 2002:a17:907:e249:b0:a7a:ab8a:38a with SMTP id a640c23a62f3a-a839292ffbdmr950309166b.27.1724099740599;
        Mon, 19 Aug 2024 13:35:40 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839359f7sm672266766b.131.2024.08.19.13.35.39
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:35:39 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-371941bbfb0so2260642f8f.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 13:35:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAUhQUHOyeKxZdZzWchzNmsOpZfPeyNNuoVYh9S06OzHxu/1SXbLtpBful8DoqjVsS3xffM6qn0wq4Sba22w==@lists.linux.dev
X-Received: by 2002:adf:fa4f:0:b0:368:37d0:c4ca with SMTP id
 ffacd0b85a97d-3719443c779mr7296213f8f.24.1724099738889; Mon, 19 Aug 2024
 13:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-4-21cnbao@gmail.com>
 <5654b71c-1d9d-4c48-b28b-664662da8897@redhat.com> <CAGsJ_4xF0YVS4TiaJwQ=YDeTTXg7hhNJOxzTYWy1cwu1YmLd5Q@mail.gmail.com>
 <416ac265-ced2-4f90-a347-0a256edf7fdf@redhat.com> <CAGsJ_4xNmi9nuZaLVjWgBA4cVqyDYVupQ1Hzygbnq98OiP9p8g@mail.gmail.com>
 <54a4619d-e826-465e-9a0f-0a8f37798e15@redhat.com> <CAGsJ_4zWNgA1OZJ-iAa4KhDY9TuGb2vji4=FJ=Vn7ve5uF6XzQ@mail.gmail.com>
 <5424dfa3-03db-4a82-a08e-fb31285774b3@redhat.com> <ZsN9Eo8HWdEgqpf3@tiehlicka>
 <a366907d-191f-471d-aa5a-fc8f3f88198b@redhat.com>
In-Reply-To: <a366907d-191f-471d-aa5a-fc8f3f88198b@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 13:35:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgGLFV4mkNGwhpTMYrR2sVJVbnJ8RrfaHihDwtR+Z5O+Q@mail.gmail.com>
Message-ID: <CAHk-=wgGLFV4mkNGwhpTMYrR2sVJVbnJ8RrfaHihDwtR+Z5O+Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	Christoph Hellwig <hch@lst.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 13:24, David Hildenbrand <david@redhat.com> wrote:
>
> Right, "warn + loop forever" is one alternative where you could at least
> keep the system alive to some degree.

Maybe. Or it might just lock up the machine.

For small allocations looping forever is probably fine, because in
practice there's always *something* that can be thrown out.

But anything larger than order-3 (handwavy, but that was our
historical limit, I think, and we call it PAGE_ALLOC_COSTLY_ORDER) has
to fail at _some_ point, and the caller setting GFP_NOFAIL is just
fantasy and "Daddy, I want a pony", and should be ignored.

With a WARN_ON_ONCE(), by all means, so that people can see who the
fantasist is.

            Linus
