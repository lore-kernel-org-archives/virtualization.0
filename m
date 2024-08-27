Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777B14F126
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741854; cv=none; b=aNVyAc2uzi+3RumK7cjzccjSeMTu/YMj7YdWGeGQqVt3C7wC37M5P2tE1qj58/dEdjaxnCaMpdklGRP0KzyuNMDTG+Rhhdo8OWXn1AsUUPiQ5UpKPewrDfKCgKQ6Wbxt6MxaD9r2lXb+HlxyKaJVbwdz95GPhEnCEUJ32k5EzvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741854; c=relaxed/simple;
	bh=fgw/wLQTV8lwPxuIJ/vLEpUSQ0pR+CTaZYjq1x56vjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eq7soxiySLkJaDL5GpLczt49tLrquM6FgTAIfI54poAQsuLbAsS3n2FXBN+ogcJWv5e1LpRLeHTPALbBcLQO9/D56asNalFezrJOjTiSNbX7RHX7FSXyY0sVlShfwYLw5tYE5EOq1cI2kiPKQAhau8rEacpITFlWmgR0OQViBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WMw8TqNg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WMw8TqNg"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a81bd549eso390728666b.3
        for <virtualization@lists.linux.dev>; Mon, 26 Aug 2024 23:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724741850; x=1725346650; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EOSx7xvzcnwSLI6LI+wjByD7ClNzVN+tzd31ZfRtcH8=;
        b=WMw8TqNgN9lAp+RnpGqrfycT3OhZrBaEad/4FfTHPNmt6bcjCeaYVThEzIJWHrG4Mx
         EYyoxDtdVE1YdkjPMpYlGoSQhi/Fe15arDCGkDSqT9cmGHfOQObQivl4qL6iKq6bugo6
         /DusxZM2EJLQGQxjxRalduWUtlX31M5F3U7yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724741850; x=1725346650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOSx7xvzcnwSLI6LI+wjByD7ClNzVN+tzd31ZfRtcH8=;
        b=krdE32tw3s8oldQ3luxF9xXZqk9f2USEhj2eDFeYXjo2oyC5fAUzOXNqK6lcZcl5gA
         eqC8LihJoP1iO4Md8Xs9vtVFooJ+U3CjAnI6uBwmMmoRw7aiePrQV1CuAIE/DBQpIK4A
         +tljazAer15cbdKOOxn9tWAhQnULqi0coCjUlQYQpqszaXTcp00zrashHcBen4VU3T9t
         QbPKsmYcgUTPELW4r2iSAyX+OtwjGOUvtSXFL3XRxu4D0OIOwzjQNZF+LgAEhKZGQ4RV
         IELIEAfCyTqr2c0L6d46v5A2CxxLyKV04BQSwhaWaXIOiS9MjDtA1uES6y+u6llRb+/6
         tZlg==
X-Forwarded-Encrypted: i=1; AJvYcCUk4Y0Xs1TDcoDQOY4B9llkSB0WRHpaLCNEU4By7lzPPCfWHfvtIZga0Uqt5GIlSjFrnj4hUbZnscOr26xZHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEsq4QSQSafT/rdP9vA+8ezyfKua4ZTBssDPcvcOgH9/ec0s/j
	Hyeuh+asTn0OQSRQYhTz4OMFqpAqA8bRMrHhVc5hb+fN+gMiguLilKcsjwV35K0IDPweEOAT7Am
	WOKX5fw==
X-Google-Smtp-Source: AGHT+IEdpXixVw0Y+ONGYzxENZV6PYZiJ5lMGx2ylJ6QSRAQM6Iq0ln8rI1F+cmFtBEDoR0lAdYKFA==
X-Received: by 2002:a17:907:6ea6:b0:a86:7513:4f9b with SMTP id a640c23a62f3a-a86a5488156mr926155266b.44.1724741849632;
        Mon, 26 Aug 2024 23:57:29 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5486a1esm71797266b.10.2024.08.26.23.57.28
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 23:57:28 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso7655316a12.1
        for <virtualization@lists.linux.dev>; Mon, 26 Aug 2024 23:57:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqbrs/8i1xfVUj1clM9cb6pPR2ZVX4GXZMjJlOZ6bh3S++XZdUAn9UWB35+uEWIFijHqiAmJTuhQ5xzX+wkA==@lists.linux.dev
X-Received: by 2002:a05:6402:518d:b0:5c0:99ff:7c85 with SMTP id
 4fb4d7f45d1cf-5c099ff84b0mr6792763a12.18.1724741847852; Mon, 26 Aug 2024
 23:57:27 -0700 (PDT)
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
 <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com> <be4c9110-72d0-4749-941e-797a861d8319@suse.cz>
In-Reply-To: <be4c9110-72d0-4749-941e-797a861d8319@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Aug 2024 18:57:09 +1200
X-Gmail-Original-Message-ID: <CAHk-=wg6Bw-83QoU5hOZapFDV0nfrBTFUywr6BQZd6v=VJ8wGw@mail.gmail.com>
Message-ID: <CAHk-=wg6Bw-83QoU5hOZapFDV0nfrBTFUywr6BQZd6v=VJ8wGw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>, 
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 00:10, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Right now we give the WARN_ON_ONCE() (for !can_direct_reclaim) only when
> we're about to actually return NULL, so the memory has to be depleted
> already. To make it easier to find the offenders much more reliably, we
> should consider doing it sooner, but also not add unnecessary overhead to
> allocator fastpaths just because of the potentially buggy users.

Ack. Sounds like a sane model to me. And I agree that
__alloc_pages_slowpath() is likely a reasonable middle path between
"catch misuses, but don't put it in the hotpath".

               Linus
