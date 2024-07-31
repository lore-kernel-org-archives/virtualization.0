Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69D1AC429
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423485; cv=none; b=a9W+pjuNqxKsbYORZFpRpz7KAP8bp9KtDw/RzVrtQbeRKPf80qE/C5tf52/8R4CY7dK1+wpaTn6pnJiWzXe1nWcaVYH5QdrMO2CdsAFYg38TkqYcdKFtQX7Meo40rtvTZvv+JNNn5AMU9TULsXR0WA+kXeWNFwa7qdIDVCYdU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423485; c=relaxed/simple;
	bh=mFMK/Yff1UmrbRfUQE5L/I4nbFRNAQ+YOKWj3gQCi7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGZlDWeXKdh27hc/r98G34p9iTKOLfFvEclVNc6yVTqZR/gBR8r0fk1gToHmssnwbNF2JbSDq7RUO5sTyiIZqZJnHKcVzHaqISYBGKk2hv0KHCXLXvYj7kuqTxn5SXHRrziR4vqfajPsptc0R3cAWojfXosk5pTkHyOQ6FodU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEcRJZIC; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEcRJZIC"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-492aae5fd78so1481383137.2
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 03:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722423482; x=1723028282; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI2fOIWNIi8brIbdWyl5BAEku9ydAOxY7gLMn3uZQ7w=;
        b=bEcRJZICHhaR4KmcQBLM6pT5TEIDadFI7IW9fYFjOL16gWkhAa1v3xO/by2aPZEGO6
         pYVXxrW/cOSSa8RX6zlaDG3c3RKVUx+iJfjzZQ6iWGuPBMSCABlzfqFTbPE2xAgzxPdJ
         v8r+kROaMwswf1yIoORTbVAuylCZPfXN6OqhpY81ocAm+JNwd5hZTgmldLLQUm8vN1aO
         XsvioymUur1gsSPUXecvnVESJ8+MPiZ2UF4CgajuPAmMf9X/inxJtUaH7dVqdK5lHZKx
         S/9V4xCMVd5NYFD5R8CU+beRW8gyeG9KswqMfvjVg/NYgFDEJ+LLRVjWQYxq9E+dTpJE
         aarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722423482; x=1723028282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI2fOIWNIi8brIbdWyl5BAEku9ydAOxY7gLMn3uZQ7w=;
        b=HFwCglSemnkB/ZonVEIL2IeWN3XHZlMGP1S4N3MmrcsVcWs7d+AKPixuoQpm4az+st
         ij3/ZGS+tga5ehGRTtt/XcToYZ4K8Z9XUyDDmUeMdcHX32yRaiakKCcX1mNJMQMVct5D
         uCuqK46CC95dwx0moyJqnGQJQh6Oqh/GMLX+38Vae0kjXj0KE8nIhxKZsF31PWyx1Ofh
         VIqaHAU4ckMYvVRwyc5M06ywW2lUiNE8t4elC3dnfwhsn38JJ06JmJ7fTUYBn7OKBU7V
         q3s8JH78togKUhGueJEa+3b7V6RawMeOe4fr8JYqEqI7SwoXelO5qdFL5YU+M6FRqJRj
         GhMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaA1i/0oLk68PqMOggXVLr/DtiSN71bl0mBz+kmDOwCnhm0qo1KrTl9XQmnDqfIu/xaI2A1CWLNi6rWy+fLn/VyyedOZrLD+v0jQbcIx0=
X-Gm-Message-State: AOJu0YwznlR2wm20vwyw5jftD9e9t4vMEcEBWCbnqQgNQYpIRSCdO+I7
	SDHfUhkFT9QhWlpnMahL6OIPT+ufqdtFJgyFQKLHjTi/M+FIQFIoWXg3FEBFJPcs/WorLVgU6hy
	KEqJnHP00+x9xNJzP6hFHx9pni8Q=
X-Google-Smtp-Source: AGHT+IGLSySmlzUKevAJ5A1uSyXIxhv6Bs7IiI7BS9LrrJGdKas4ZhUKG/XVHehibb0M38m7WTz/cJjJo/NDW7/4bIY=
X-Received: by 2002:a05:6102:6d0:b0:493:c1f0:d46f with SMTP id
 ada2fe7eead31-493fad1516bmr17713978137.22.1722423482432; Wed, 31 Jul 2024
 03:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731000155.109583-1-21cnbao@gmail.com> <20240731000155.109583-4-21cnbao@gmail.com>
 <b1f4d2eb-ad6d-4ddf-91f5-f1ad0171789a@suse.cz> <9f1d0f2b-ee22-48b7-ba60-d7b886572670@I-love.SAKURA.ne.jp>
 <c20ea16c-e717-4bf1-92f4-cb5338d4406a@suse.cz>
In-Reply-To: <c20ea16c-e717-4bf1-92f4-cb5338d4406a@suse.cz>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 31 Jul 2024 18:57:51 +0800
Message-ID: <CAGsJ_4z6pHh7PSBO=AixWttXbR5gaz3P6PNVBZ-fgxE0Ewcp_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, virtualization@lists.linux.dev, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:48=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/31/24 12:44 PM, Tetsuo Handa wrote:
> > On 2024/07/31 19:29, Vlastimil Babka wrote:
> >>> @@ -827,8 +827,10 @@ kvmalloc_array_node_noprof(size_t n, size_t size=
, gfp_t flags, int node)
> >>>  {
> >>>     size_t bytes;
> >>>
> >>> -   if (unlikely(check_mul_overflow(n, size, &bytes)))
> >>> +   if (unlikely(check_mul_overflow(n, size, &bytes))) {
> >>> +           BUG_ON(flags & __GFP_NOFAIL);
> >>
> >> Shouldn't we produce some kind of warning also in the no-NOFAIL case?
> >> Returning a NULL completely silently feels wrong.
> >
> > Doesn't embedding macros like BUG_ON() into inline functions needlessly=
 bloat
> > the kernel size? I think we can call a non-inlined function (that is ma=
rked
> > as EXPORT_SYMBOL()) for emitting warning.
>
> Hm yeah we could probably make the whole function non-inline as it result=
s
> in a call anyway.

Although this might save some code footprint,  we will result in two
calls for users of
kvmalloc_array_node_noprof() with both Tetsuo's and your proposal?
