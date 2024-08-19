Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC12E165F10
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073592; cv=none; b=mLaYDX+8/mjqi8xAnEyias1YKABwxIZlFcs8dX77h3FrUf61spjKCcbSsXhwat/s995fgC/C7CqJIY1y714c36RpqZ7y80twC3ALVeicbmTBveXbceeOjQJbTszSvdShNb/5bLpPtqbrYnRfIrsC/nVVDrbVMhuANFPvYtqAA8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073592; c=relaxed/simple;
	bh=jzxM9ZjrSsanMkucQIg3xfup4ZQDD+z4YkmSeVibEjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nusmp4vTikhwkXV6o4fgZDUUL2d5hYbj6zyTRs35NOGE2AYd1BBP3Xwu/oTYdUad3RfYVZk7lh4vqjGgUFTMLO4ltC6vRvA0AApKhXzcPaJQnSKTk8/xTtfGkXZOR7OtjdGkYPepo8qofutMdM7hsq12XgAzGhgeDf+cAuIhaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFU+9A+f; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFU+9A+f"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a3574acafeso275398385a.1
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724073589; x=1724678389; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9cBvtpI693vgnPvfCeM9ZnZwQY5t+/0DMSD6dNvCO8=;
        b=NFU+9A+fCoxFlF1LdRGfK0bj6C0ISx3oczmzKbdtlpL2c9lfopcV31X6UFrw5tam3I
         mg08Q01Z1WCQAWjP8UbQ8iUdZc+Q/w4ionrbpFCNLsqLEF0OS6/d/NhkCfCX/lhlZFez
         nAdMl4BeJeSXHuZoVL+JC5ZzJuXM9KIiyNifvpxo4iJTFISKE+T0O9eZ5icJKRSAMNtb
         Bk/rKvisXlXGGCU9sIZeFT5lKgRMN7QlWqRhSw317ts1gsmuM6k6hWwi9FKuPXpT+PLy
         g8IWkL48JGZ5hKJjjrLHpZzLi6LajEIffJ7f2Xbr3n/pimKfGVTqMCGCK4QXcva2Pw6l
         u17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724073589; x=1724678389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9cBvtpI693vgnPvfCeM9ZnZwQY5t+/0DMSD6dNvCO8=;
        b=WaxcgX/0JhDsoiP3FRJsCP4Wj3yaL3I7cuUqmwgeKBvPN0v1xtpCvFhrXEkMbLs13D
         yA4JQodGxpvEOm43NEzYoaR6efjBpum1ylmWsYhAk3BjYBsDO3j97dtV1ZaLTeHRjNwx
         Aui9MpSnuji/N2iT0bPEDgygD6IMP7Mv+y5OHDWXsMmbbwXeXClvqfZ0efJZ+vYV/bcm
         OYf8jdWfbMyfQlcWnBknyf7VViMCXJX2zPy6iS5Ar8ZrBVJRofmZieoFF9YKkNarWuQl
         RIy2fRmQm2e5t/zl/x0Xcks/sYL3xebNZFtfWP0mcTznFDyUjSqbeJ+p4tI59yoxkC84
         WWGA==
X-Forwarded-Encrypted: i=1; AJvYcCXxix8rOMYUbsqU/rdZIWDf2FG/L3FjWmGrG0DAHrldqFXh5JA+P8aNzuW+4eKDm67F/Rc0HfH42YiCSqxQAcA+Eey8bMVkD+RG3YvrIcA=
X-Gm-Message-State: AOJu0YwNl/VgHVIiy121QZmVM7GPUONXeL+A8EzQKr4LtR43ikQhQ6ZW
	/GBi2VhoPKkoE1RTGOttEIGp7ydLtH+XGQ15dlT+mOLGMoTNvPfbAc6BuN4faCAUKqaZlTABTId
	L9JXAfTVILioefEwjXYQwJZ2P/Ro=
X-Google-Smtp-Source: AGHT+IEcdmyGrZtw5VDXV9FbD56QJbSUlXapDjkvC+i8qePb8Qd5ZVGu1LtH5mPqDJbnnaH2+E+sqm8/pGLD2xFiQxw=
X-Received: by 2002:a05:6214:428b:b0:6b5:e451:81d0 with SMTP id
 6a1803df08f44-6bf7cd85cb0mr103739856d6.3.1724073589522; Mon, 19 Aug 2024
 06:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-4-21cnbao@gmail.com>
 <5654b71c-1d9d-4c48-b28b-664662da8897@redhat.com> <CAGsJ_4xF0YVS4TiaJwQ=YDeTTXg7hhNJOxzTYWy1cwu1YmLd5Q@mail.gmail.com>
 <416ac265-ced2-4f90-a347-0a256edf7fdf@redhat.com> <CAGsJ_4xNmi9nuZaLVjWgBA4cVqyDYVupQ1Hzygbnq98OiP9p8g@mail.gmail.com>
 <54a4619d-e826-465e-9a0f-0a8f37798e15@redhat.com> <20240819124924.GA7642@lst.de>
 <a31af580-f420-4b34-8945-0269914a901b@redhat.com> <CAGsJ_4z-5ypPGoG6JDwRZGDt5Dby9r1tvh-txFdnkhQaKq8zGA@mail.gmail.com>
 <9f4fa8cf-df02-463d-9715-087a7cd6fc88@redhat.com>
In-Reply-To: <9f4fa8cf-df02-463d-9715-087a7cd6fc88@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Aug 2024 01:19:38 +1200
Message-ID: <CAGsJ_4yYEP6t+e=Q-Vr68S9Rgy=bdqLp34N_Gt_3_fSdNcGCvQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
To: David Hildenbrand <david@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, mhocko@suse.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, torvalds@linux-foundation.org, 
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	virtualization@lists.linux.dev, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Kees Cook <kees@kernel.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 1:10=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 19.08.24 15:05, Barry Song wrote:
> > On Tue, Aug 20, 2024 at 12:51=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> On 19.08.24 14:49, Christoph Hellwig wrote:
> >>> On Mon, Aug 19, 2024 at 02:33:06PM +0200, David Hildenbrand wrote:
> >>>> It should all be caught during testing either way. And if some OOT m=
odule
> >>>> does something nasty, that's not our responsibility.
> >>>>
> >>>> BUG_ON is not a way to write assertions into the code.
> >>>
> >>> So you'd rather create exploits than crashing on a fundamental API
> >>> violation?  That's exactly what the series is trying to fix.
> >>
> >> I'd rather have a sane API that doesn't even allow this level of
> >> flexibility with NOFAIL.
> >
> > yes, i have already sent a RFC enforcing direct_reclamation:
> > https://www.spinics.net/lists/linux-mm/msg394659.html
> >
> > somehow, it is not ready yet. i think Christoph prefers scope
> > api rather than GFP_NOFAIL which definitely has
> > __GFP_DIRECT_RECLAIM set. I guess you know I have
> > at least  5 series running, so it will happen soon though.
>
> That really sounds like the right thing to do, at least with the "direct
> reclaim" problem ...
>
> >
> >>
> >> But probably I'm missing more details here why this all has to be so
> >> complicated ;)
> >
> > enforcing direct_reclamation is right and will work for a reasonable si=
ze.
> > but for this overflow size, even if we enforce direct_reclamation
> > in GFP_NOFAIL, we are still failing.
>
> Right, someone requested something completely impossible. It's harder to
> do something here that doesn't return NULL. Except WARN_ON_ONCE() and
> loop for all infinity.

Returning NULL can introduce security vulnerabilities. While I=E2=80=99m no=
t a hacker,
it=E2=80=99s hard to predict how they might exploit this. If we want to avo=
id using
BUG_ON, an alternative approach could be as follows:

while(gfp & __GFP_NOFAIL) some_cpu_relaxed_job;    ?

>
> --
> Cheers,
>
> David / dhildenb
>
