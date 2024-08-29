Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715218DF8C
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932427; cv=none; b=MSbgT+5xO3wOMd4oVFOTSjo02rTvY3jybAYgcKFc16mO5OFsvXqaL6S/rxqz1/G/gx06r+cP/UpMEzNBMqSh8GPHyy/P8Iqux/XxdQXfr/ZpOwcPO9pEY+SOYKHzbfCrb+PgaYT96NbFt+rAScLtObWC6VfTF4tglcaWpybQOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932427; c=relaxed/simple;
	bh=czZ1dOQVLY8OB5JMNo/yLksck3ZTgdf6lscTaUaWhyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+w+yhJ4p/g3bEoiiKpxDd6Mp8ty2ntq1ybElc87Xqt6z6vVsErfwts2DHrJaij9scyZ+UlBIsilTzqGUA9C3l/4v9tGUvlOkedtAWeuRr5ZinpFW9+Yj0k4pBNsU0BwhIJmwAAmO2EY4FB78kLt0bhA8/kakTE/pAhpsB4C4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoxtsvXs; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoxtsvXs"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-498cf14a848so222380137.3
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724932425; x=1725537225; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8n1UFj1Q+wM5iePo02UkDVC+29Y7BUbYM34gTWJxTE=;
        b=EoxtsvXswD/1vnQo8+a9bofdBnR9ulRPORj3i+XZejQ3fQ8MqY4uNeivU7IJK4moqq
         N0PYAetZCVQ0H4r2pEWBy56m8ZYnK+KGi22CaU9kibGWGL21OUzjSfOmuK4GaCPESA0e
         dBM0RKw1a+8vqcIXffrUK7vO3iEJAxeSHqUx0vKb7KpYe9+rcU5UB2W8kiD8Jd9GSby9
         XQHXN/suGgurCqmuLwbF87oNrnUpQxLbMJEjoPUmDJVKBTnKfDklCUnvNvxl40qOnPrd
         A6KUr+AQsY2irpxcHktsFu9M2h2yR0vH0zI/BoiX/hE5+xd9MA4EPnhEpwB2Zh5rKRZJ
         BpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724932425; x=1725537225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8n1UFj1Q+wM5iePo02UkDVC+29Y7BUbYM34gTWJxTE=;
        b=ce+Vd0FbIeMbmqzgeDwcZLAf9J92prm27n57CmYh2NWnv9VP4JGkMdXn3V7olzbkg0
         1OG9pDwz6ccnexSc/loyWBWu6NYHbuuLgp0MPXr13ihFQArCargF4YbFEiRKQJgcmgoJ
         KAhqhU2TiLzhXs9kWqzIYHfBWBat4QZxmulh4/VQWaqacbBwxHAL8aPQ6RGlS1gUzEcA
         mvRHcZ7LLR9or7tFMCqKTJhQRGP1CIJrklC5OzgZYnDzoNaK49Qfwt15X3JNQ0VK6gPT
         VSCDASlfipMfhApxE5MY7tUiWq06g/zQ0thBERMU4kFe0LX1I8oEog3z1f9yRkVHcafC
         cDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbi86gMigHgm3pVaR3gpElNP9f8nnztIiPnQts52wXW35K2AjtM9bAGfBfErilJxUmSHYP2zv62OLEmX+YVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnP30uZHzLkhYh5ImSQ25PSdKfeifYe/B50pW17qIl6tEi7xtY
	bKA7U47MpG//lrs8SoTHbR5d+Co12dlAzblY/ZqGPgMvmc8Kl9b/nJqElOIoGrCaFocmsVKukSG
	ZVg3O495ZlSJhypa4T3hj+BFuX3c=
X-Google-Smtp-Source: AGHT+IFRqcSUwe4ES9Z3J6iwBOoWu0IKyMK1mGG/uCxzyYADeSDjgNDnl/+yRGY4XWsjM+0Q8viLj81bGzymvDCeYqw=
X-Received: by 2002:a05:6102:50a:b0:498:d3b7:be39 with SMTP id
 ada2fe7eead31-49a5af7bae1mr2287830137.29.1724932424886; Thu, 29 Aug 2024
 04:53:44 -0700 (PDT)
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
 <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com>
 <be4c9110-72d0-4749-941e-797a861d8319@suse.cz> <CAGsJ_4znRBscU8FWMZL7Z9qLUMxCPtupRcJqu+PXz260p-S6MA@mail.gmail.com>
 <c258403c-afc5-4969-b7c5-fa2a6c257371@suse.cz> <CAGsJ_4wu3theWe0iyXdBK-JvLfuBh7Qw-B+9Wztm2XyrU1Uzeg@mail.gmail.com>
 <2663352f-ecef-4e5b-bee5-e31d2b286c63@suse.cz>
In-Reply-To: <2663352f-ecef-4e5b-bee5-e31d2b286c63@suse.cz>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 29 Aug 2024 23:53:33 +1200
Message-ID: <CAGsJ_4zY5jwCsJh94OFMi1UqzFu5Ji3OeJZz91p2YKT5jxBc5A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Michal Hocko <mhocko@suse.com>, Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, virtualization@lists.linux.dev, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 10:24=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 8/27/24 09:50, Barry Song wrote:
> > On Tue, Aug 27, 2024 at 7:38=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >>
> >> Ugh, wasn't aware, well spotted. So it means there at least shouldn't =
be
> >> existing users of __GFP_NOFAIL with order > 1 :)
> >>
> >> But also the check is in the hotpath, even before trying the pcplists,=
 so we
> >> could move it to __alloc_pages_slowpath() while extending it?
> >
> > Agreed. I don't think it is reasonable to check the order and flags in
> > two different places especially rmqueue() has already had
> > gfp_flags & __GFP_NOFAIL operation and order > 1
> > overhead.
> >
> > We can at least extend the current check to make some improvement
> > though I still believe Michal's suggestion of implementing OOPS_ON is a
> > better approach to pursue, as it doesn't crash the entire system
> > while ensuring the problematic process is terminated.
>
> Linus made clear it's not a mm concern. If e.g. hardening people want to
> pursuit that instead, they can.
>
> BTW I think BUG_ON already works like this, if possible only the calling
> process is terminated. panic happens in case of being in a irq context, o=
r

you are right. This is a detail I overlooked in the last discussion.
BUG_ON has already been exactly the case to only terminate the bad
process if it can
(panic_on_oops=3DN and not in irq context).

> due to panic_on_oops. Which the security people are setting to 1 anyway a=
nd
> OOPS_ON would have to observe it too. So AFAICS the only difference from
> BUG_ON would be not panic in the irq context, if panic_on_oops isn't set.

right.

> (as for "no mm locks held" I think it's already satisfied at the points w=
e
> check for __GFP_NOFAIL).

Let me summarize the discussion:

Patch 1/4, which fixes the misuse of combining gfp_nofail and atomic
in vdpa driver, is necessary.
Patch 2/4, which updates the documentation to clarify that
non-blockable gfp_nofail is not
                  supported, is needed.
Patch 3/4: We will replace BUG_ON with WARN_ON_ONCE to warn when the
size is too large,
                 where gfp_nofail will return NULL.
Patch 4/4: We will move the order > 1 check from the current fast path
to the slow path and extend
                 the check of gfp_direct_reclaim flag also in the slow path=
.

If nobody has an objection, I will prepare v4 as above.

Thanks
Barry
