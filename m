Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE6722B586
	for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753703518; cv=none; b=DCe/bcLlck7JUFG5U7hyhbbaRSEcflUxEkSTLRwLzJTnzN3TtcynLyH6DUNXq/cDhllc/EJcAV76+LOcl0tY3qzFqL2IBUp3iDqEEzJwkhXZ66iovXCIYebKsUq+M+aHq2ECxvINZhyIxXUNltnSWjoCqm5sxlHC3q3TD6uqPWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753703518; c=relaxed/simple;
	bh=765Zg2kvdW9MEMLHWxxka94UDM3iWDfdwAN2sOe8HSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tj52EH6tlA68PLdt7UAdjl3phqd6o9FNUQPX/SrChhByjpL3tcLP2gkXITyot5/Y6A9iwfBLImWU3Xj7OZoQPGHgloLcXKiC6I/Xvn/t5q/HB2cFaG5ZiWZSvTQEpPhZmVmsW2haoAklCjhtrmt8tnimQGgplhFjKvW/E5yUfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTbLk+LP; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTbLk+LP"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4efbfe9c7a5so3469834137.0
        for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753703515; x=1754308315; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Likoa40Tg3Hu27n+cGt0OOu4O4FlIaVhlBXKe7cRGBI=;
        b=QTbLk+LP9bmeaY/l9cSvsBCoctPWNj/4JMWrS/bCixFecWPmlE6/k4rYvCobUg8gkG
         Cdl5lRh2czIGljMHryVjurI2I4YmEOoPt2TykvKXMNUlejxWoEfytm5ZH/3IfcNZjC4/
         RJOjVLxo3ODNtR4vz83IvTJoT0sTD8fn4T9WzTavVcpProHOjf3+gs1QIxKSN+sZPP/d
         t5UgHNzYtyRbulsUe/qcpg0soWSud7M5FaqWRXLF94q4B+6fWzdXz4dd3jhOdwOGkTYa
         NYKES+Dwv00p2dwLVVx9ybNIw2U5EHU4ehj3o57tSxUj49yxChGpeRkDMbsf1UAghKLr
         7+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753703515; x=1754308315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Likoa40Tg3Hu27n+cGt0OOu4O4FlIaVhlBXKe7cRGBI=;
        b=XuKlUKT7byLu/4BuVXnMyAXmrKMSnxPwHx7ura16ZD59QORpep5Xybn5M4DbiFdBsT
         eAZ7KNVm+zpvARQNQ4rYNB38vc71Pxh7FdttWYCaEObqL+3a7i7qof0cH7E5BACBYN/b
         11ldXw7NBFyEkGyjwv4xO6wJVk1o61gvIRgQZ0Zu5/yihhHXwHtP6hIQU2d9rjMhXRvq
         PkbU17k69QHicZCEnIwtIHdP3jez1w6VDaTArfcpTxAhV7no3LdT8TYyu+vmvCDpuy5R
         Ojl/VOYWBCnrUQxg7VqvGZycSM/5XFyM07qUxPdVnwtV8CBe9WDLvDGXX9+vlL5RN/Sf
         +Ipw==
X-Forwarded-Encrypted: i=1; AJvYcCU5nIA+VsvD4o3pPT3lzKshfHoeihfpS6v0vnV4sXfjtzfbvUg/vCly2jXlyCOHqzSbkPhZu0pD9DHyG1xhZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjnuuEO75sYclFhfyGoQMFQJWUrlkcZ/zYy88l92bwx4WCubym
	T9u7GbgJ+k9aNJ8nN2GFC/bxpe1bzmTc8mnyN7000fj8+Y60vB2Lv3ALzHoKhyOV8+KXpK/kJYx
	6ckaPPs2Z/l+b1LZe3AAFdid9Tm2kFPs=
X-Gm-Gg: ASbGncsGCXTiQVUJINwW1q3pn1N8MD5vwO0KlH0OgEYwHGVRZmHR6OUQynYuVhuwtIm
	hUauKvbEK3NBV0rpHp/tk9kEVtNUs9EwT5k+YY/fN3Yz2Qk+BA3/iMgej+AvVcBcGrP8+lfnFP/
	ve+en5swZESSrmoHgisqFL6Uo/yV2mkIQ1sNbt7/ZKmKhYy1m3l3JP0YTWldUjHjbY18+8n3LbB
	ZQn+RJx7Oq2OncKJRpp4bjv5GtI+EQbbk0PR2LZ3VWGmTTZ
X-Google-Smtp-Source: AGHT+IHsqmvDN1OFlcp19Q+AvY6FXGJmsuYKzkKxh4r8EMVJpKypY+COSUIzdrhQaRKNH1fBxdx0oolMl9lsOpkidVQ=
X-Received: by 2002:a05:6102:548c:b0:4fa:3547:2d38 with SMTP id
 ada2fe7eead31-4fa3547343cmr5831280137.10.1753703515441; Mon, 28 Jul 2025
 04:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250412-virtio-media-v3-1-97dc94c18398@gmail.com>
 <CANiDSCsmbiveo4GHX54_q7-1CeKiDAVaGnb8+jsCybM+pyA7Fw@mail.gmail.com>
 <20250601113425.4d5a3d89@foz.lan> <CANiDSCt9nGP=r8VxkZH76a1i+xEd+RCJ71=6qx0_iPYdrn+GoQ@mail.gmail.com>
 <20250724191833.253b8f40@foz.lan>
In-Reply-To: <20250724191833.253b8f40@foz.lan>
From: Alexandre Courbot <gnurou@gmail.com>
Date: Mon, 28 Jul 2025 20:51:43 +0900
X-Gm-Features: Ac12FXzLrdinDNy_ff-eOZ_xxvjLB4Bph9uh3DCpSNYBsMQAHaG1vHziQkM_kmQ
Message-ID: <CAAVeFuLPAwMyq7cTDE4Fp3+i883RdDWkg=GOMGDzMxZz6rgSuw@mail.gmail.com>
Subject: Re: [PATCH v3] media: add virtio-media driver
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Albert Esteve <aesteve@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	gurchetansingh@google.com, daniel.almeida@collabora.com, adelva@google.com, 
	changyeon@google.com, nicolas.dufresne@collabora.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	virtualization@lists.linux.dev, Alexandre Courbot <acourbot@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

On Fri, Jul 25, 2025 at 2:24=E2=80=AFAM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Sun, 1 Jun 2025 12:01:22 +0200
> Ricardo Ribalda <ribalda@chromium.org> escreveu:
>
> > Hi Mauro
> >
> > On Sun, 1 Jun 2025 at 11:34, Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > Em Wed, 28 May 2025 18:23:02 +0200
> > > Ricardo Ribalda <ribalda@chromium.org> escreveu:
> > >
> > > > > +static int scatterlist_builder_add_userptr(struct scatterlist_bu=
ilder *builder,
> > > > > +                                          unsigned long userptr,
> > > > > +                                          unsigned long length)
> > > > > +{
> > > > > +       int ret;
> > > > > +       int nents;
> > > > Could you initialize nents and sg_list?
> > > > old versions of gcc are a bit picky
> > > > https://gitlab.freedesktop.org/linux-media/users/ribalda/-/jobs/770=
42562#L4381
> > >
> > > Please don't. In this specific case, ret is always initialized:
> > >
> > > > +       struct virtio_media_sg_entry *sg_list;
> > > > +
> > > > +       ret =3D __scatterlist_builder_add_userptr(builder, userptr,=
 length,
> > > > +                                               &sg_list, &nents);
> > >
> > > nents and sg_list may or may not be initialized at the function,
> > > but initializing it is wrong, as, when they are not initialized, the
> > > ret code shall catch it (and if not, we *do* want gcc to warn).
> > >
> > > So, if our CI is warning about that due to an old version, please upg=
rade
> > > the version at the CI runner.
> >
> > The main version of gcc works fine. It is the minimal version (8.1) req=
uired by
> > https://www.kernel.org/doc/html/next/process/changes.html
> > that  complains.
>
> Ricardo,
>
> gcc 8.1 was released in May 2, 2018. I don't think it makes sense to
> address bogus warnings with that old gcc versions. I would just disable
> WERROR for such versions on our CI tests.
>
> ---
>
> Alexandre/Michael,
>
> I need a couple of full days to properly review virtio-media.
> I was planning to do it during this Kernel cycle, but I ended
> allocating too much time just to be able to create a crossvm
> that would allow testing it. Afterwards, I got sidetracked with other
> issues. I won't be able to review it in time for this merge window.
>
> I'm planning to do it at the beginning of the next merge cycle.

Not a worry at all and I appreciate the time you are putting aside to
review this properly!

Thanks,
Alex.
