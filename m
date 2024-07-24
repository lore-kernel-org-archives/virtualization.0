Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3730433B5
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815130; cv=none; b=V3FQfuvPw1YZ893w7ceTB59HNGToy2jqnr2pWigYH1PNGfUTcrj1/svKQo/ww/H6W1/tw2UVu3+00e/gkfmhCRtSFT9iOVexQIpQT95RNA9/kvk9BUiaU7Y2C3zOq3yLBm7/CGfHzdym41Gf6EKmGhKKao/eE+i2P770IBP3ydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815130; c=relaxed/simple;
	bh=ZIuy1KkPciQ06s/tvwPjFhX24nxwwKBRL2oselv5qB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJbEyXFt19KXgJdKZ+mdom1MAFXXCoidjeK/AoT8xHGlcEdd82I52mEjj64SW/wy3cEdCrtU8Vyw54Y9Z5xi4j6zcaEKdCVYLvyT4lIg/2cNeb4WEWXE4M0qxYhK5v3btlVV6fdVUefNv6xO4vYV0kLSH2lGWJL5HWsI9mepDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7L11mFC; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7L11mFC"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4f4cdb520f3so407225e0c.0
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 02:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721815127; x=1722419927; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icEcTqINznzODsWfdqc/Q8asd/h63sMaAFn10AYwBYc=;
        b=O7L11mFCVorQNLzT7bMN+q1jNJEUvpt1Y6PMchCYLncjU+qtMKU06LldsoHpd+vwuO
         4mMy1wkOjoOjd/OyslPR9guPHULnnGXglOO+o9oqAdpZ0nTzbHcyk/lqoDvsf7FOvKEW
         suf3AWBVFdFV1EqJkogTLU/wqHkLF68DM8THiDQX6WLrEK1louX6DMMLP6DEy6PFbIeZ
         OUhV0QorPeXMrXH0K647EUwTdDYiLLy2kLEss5NQ6q+YKOVk6gFkqVVVx/PXO+FZ2RQL
         +EW8t8lqQUAAHdp0mG2oKRMMZT0JvaW/rxya3FOPno3NkTfLrVJJTsAsIDLy528nhCpw
         dwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721815127; x=1722419927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icEcTqINznzODsWfdqc/Q8asd/h63sMaAFn10AYwBYc=;
        b=eCe9hZiAB7Y4NOc/1vrwZCYaGeQHZqYr88erpVZKDbv8rsvp+UQ9IClZqnxEawEAz4
         rCYZfzmJOvpYTQDq5Y+xS7C3J9+Aqj2v35Poys3r5UZshDDljXWI495LRP8sf7uNI3lK
         O5wbDTUIdmjuWDPi8BooxK7V4fs/lKoYVAjV3de7jcvJILq9vlArx4grszFvdm/1t3U7
         5FT673hQ638K/MeHDeRyhpTBZcLpbEUiuf+M8vOlS/HnVrDi7AsQxbmTMY3rcqAQoQN2
         0BjVjghC0WLQyBEBMvtrvYxpOUSWmkFBCX/RRh2kA9IGVxL2nq2BiGBlfgYyuM6BhdHk
         7Sgg==
X-Forwarded-Encrypted: i=1; AJvYcCW7w15ClxD7fEvUIdKWSh5x48vC5pJk+ZL6JzMhoSl4xwkZAQyRLW6DOpo38o7J72u2pNHYBSmIdJ50rOvsRzSbxwIuFai+HGgIwZtXutg=
X-Gm-Message-State: AOJu0Yy67k9Ol1s+Qqu8Ps6kNhoscSfshGBMOw9zZcRTbqcVYR9VRuIP
	h6IPAkv8oWzoDpfMQbcmQbFFD9p6V1mOqe5zUT1a3MHD+tWhiT7v1RYRBba79n1GlO6/vScNnmd
	6K9Vjj97EhpVM+EaPNQQ2BdbGw18=
X-Google-Smtp-Source: AGHT+IE4A4/rfIGsWG7h/GFLk7I52t/+PtQ1YnklxECswLZ63Y7dCMMBteobGf6eFHtUrClt1pRtRRtwA0W49WQ+RnU=
X-Received: by 2002:a05:6122:3c83:b0:4ef:58c8:4777 with SMTP id
 71dfb90a1353d-4f6b849f989mr451732e0c.4.1721815127606; Wed, 24 Jul 2024
 02:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724085544.299090-1-21cnbao@gmail.com> <20240724085544.299090-6-21cnbao@gmail.com>
 <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
In-Reply-To: <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 24 Jul 2024 21:58:36 +1200
Message-ID: <CAGsJ_4ywzECk0tE+HUHO-Em75hZ1gsDtbh9aN_XnYoJjecHRrg@mail.gmail.com>
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	virtualization@lists.linux.dev, hailong.liu@oppo.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 9:53=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 7/24/24 10:55 AM, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > GFP_NOFAIL includes the meaning of block and direct reclamation, which
> > is essential for a true no-fail allocation. We are gradually starting
> > to enforce this block semantics to prevent the potential misuse of
> > __GFP_NOFAIL in atomic contexts in the future.
> >
> > A typical example of incorrect usage is in VDPA, where GFP_ATOMIC
> > and __GFP_NOFAIL are used together.
> >
> > [RFC]: This patch seems quite large; I don't mind splitting it into
> > multiple patches for different subsystems after patches 1 ~ 4 have
> > been applied.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >
> > diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xi=
ve/common.c
> > index fa01818c1972..29eaf8b84b52 100644
> > --- a/arch/powerpc/sysdev/xive/common.c
> > +++ b/arch/powerpc/sysdev/xive/common.c
> > @@ -1146,7 +1146,7 @@ static int __init xive_init_ipis(void)
> >       if (!ipi_domain)
> >               goto out_free_fwnode;
> >
> > -     xive_ipis =3D kcalloc(nr_node_ids, sizeof(*xive_ipis), GFP_KERNEL=
 | __GFP_NOFAIL);
> > +     xive_ipis =3D kcalloc(nr_node_ids, sizeof(*xive_ipis), GFP_KERNEL=
 | GFP_NOFAIL);
>
> This (and others) doesn't look great. Normally there's just one GFP_MAIN
> that combines several commonly used together flags internally, with possi=
bly
> some | __GFP_EXTRA addition for less common modifications. Now you're
> combining two GFP_MAIN's and that's just confusing.

This is true, but I assume this won't incur overhead at runtime since the
compiler resolves GFP_KERNEL | GFP_NOFAIL at compile-time.
Only readers might find some bits are duplicated OR twice?

>
> So if we want to go this way, you'd need e.g.
>
> GFP_KERNEL_NOFAIL which is GFP_KERNEL | __GFP_NOFAIL

I actually considered this, but it doesn't always work because we have
many cases:

variable |=3D __GFP_NOFAIL.

>
> And probably also GFP_NOFS_NOFAIL and GFP_NOIO_NOFAIL (sigh).
>
> >       if (!xive_ipis)
> >               goto out_free_domain;
>
