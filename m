Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4315572C
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319309; cv=none; b=Ua9zNeKTMzhBIZWyBGnBW8/zHIZPmExej980Y1XxOJLzyAu/pKpPJWLD3tp6f6WEBnxt/bAPaOJyCbX9CmmXvNPrF/TPXhokBzUabq98AjLxVDHCfWbR5wM6RJwanMtI2/OphADRlT3oqg/fIhmZnBhIpE+XMq7tICZRAAHT5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319309; c=relaxed/simple;
	bh=R4j/MN8R0K1/1+HDwMcAjaHFIf3ZImlweV0q4XSaOtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnvR6xXUwLHhSIvjSh5RwepoP6fa7lt9dyv+8TJhkWfOHvf73XeIgkqVKeNlpksp86N5no280iWI3U2P+CWfNfDG/xpfrHjOu3G9c0YH9jk5S9fSo9zO9iNLhcchubXJv0149yk/kYA6rbqw73fYgXrU/ThmJYh7IoEup72t5Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=clWe43gJ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="clWe43gJ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso5201601fa.3
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724319306; x=1724924106; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=206zKTa+7G2AKzXndKK4zs3d1dKxAQyC6y/j0FklOC8=;
        b=clWe43gJ2JrMoT1EeFJ9f+OzUvbxEihq72iWyYLMarhRUgQgUWMfXu3XsdNh0yblIL
         IhWhxjyp2KkvMJSqmp7QyYIatw+FJ7U1zasI48zb65wOo3UYeEPWZhBru37ndvPOKApU
         bJ9AD4hFPiCiAjhjaVD8FdE+CyGaqEXeus31A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724319306; x=1724924106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=206zKTa+7G2AKzXndKK4zs3d1dKxAQyC6y/j0FklOC8=;
        b=caE6JDzoWcF7q8hKYRloIbw9RcvIlIFt7ul/1bEBJwxJ5osdUcN1OIBcQlCIB08Y+8
         59HxfzPjbEw0Si6SzxjIeTEfenZ7w2Qs4KJYUgeiUcegVzV6vjKCpMIOqJQJdi0Joelx
         OEBz59X0bC7wBM4V3UJl5cu8k3IoPzZa860ZQCNAaWYfzwa4c0sktJvfsrHQqJ442Bhi
         fYhDvgR7hcT8xXY9KvJ7tKZz24b9Rwr10IeOFmuEg3wpp4GZle4WnWJIo2pH5bIS42kI
         LKIGYA6ps43l7/bf1ANAeUBLMF7zPW4yfGLyoCmc0ZNJslPX/px4hrDzQL9GOe4ojPw5
         k1Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWPCnXoit1qK24Eflh4P7iZf+Q9zNX6XeH5zIdjMiSRIep2dVRsC7Nz82f5gwZtZSOR7cWnxXpK3sBXoVH7+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrIXtwQWAHD7S5UbDf5F2gOm8v/o4sYMd93ZJXlntiPURFqwSA
	RXgePhWkxGFaGEx9JKJbyl/Axh2QSP4rj3R05Zyts5jRUFpzNdNWWv3Hjj9F5dcefbcaPl7JtfR
	sMHmXAA==
X-Google-Smtp-Source: AGHT+IEQlTBAkVdJtvxiaNa8zGvWbnl3UkNiawG6jRglxIsEuCEKb/hKyMNWmIdUm7EiK4fz3B5J7A==
X-Received: by 2002:a05:6512:2811:b0:52c:d80e:55a5 with SMTP id 2adb3069b0e04-5334fd2fd70mr740383e87.41.1724319305504;
        Thu, 22 Aug 2024 02:35:05 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea36283sm182528e87.70.2024.08.22.02.35.05
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 02:35:05 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f3eabcd293so6677481fa.2
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:35:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWi5VBaYH4q3SWHXh7da3lUBwcYhIw80bI6mkR5sEwlO9j9Yu9qYuHbSsl0QII/J4CmVrOQN3FTCJyHH90/Q==@lists.linux.dev
X-Received: by 2002:a2e:a9a1:0:b0:2f3:f4d1:1132 with SMTP id
 38308e7fff4ca-2f405ee15b4mr8003701fa.33.1724319304600; Thu, 22 Aug 2024
 02:35:04 -0700 (PDT)
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
In-Reply-To: <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Aug 2024 17:34:48 +0800
X-Gmail-Original-Message-ID: <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com>
Message-ID: <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>, 
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 17:27, David Hildenbrand <david@redhat.com> wrote:
>
> To me, that implies that if you pass in MAX_ORDER+1 the VM will "retry
> infinitely". if that implies just OOPSing or actually be in a busy loop,
> I don't care. It could effectively happen with MAX_ORDER as well, as
> stated. But certainly not BUG_ON.

No BUG_ON(), but also no endless loop.

Just return NULL for bogus users. Really. Give a WARN_ON_ONCE() to
make it easy to find offenders, and then let them deal with it.

Don't take it upon yourself to say "we have to deal with any amount of
stupidity".

The MM layer is not some slave to users. The MM layer is one of the
most core pieces of code in the kernel, and as such the MM layer is
damn well in charge.

Nobody has the right to say "I will not deal with allocation
failures". The MM should not bend over backwards over something like
that.

Seriously. Get a spine already, people. Tell random drivers that claim
that they cannot deal with errors to just f-ck off.

And you don't do it by looping forever, and you don't do it by killing
the kernel. You do it by ignoring their bullying tactics.

Then you document the *LIMITED* cases where you actually will try forever.

This discussion has gone on for too damn long.

              Linus
