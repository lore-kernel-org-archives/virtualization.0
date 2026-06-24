Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06D3C199A
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311011; cv=none; b=RindPYc3DCPUdr457JK37AN9QUoAHWtQ1OcmuvRRoFGOt70bfW3b1MEsNk1rA9GU4elfTYt/tQxoOll4oQqYCAaJ2DZbNStEFcUZ3fJA9GKF76mQZ8Mx/DObOFcEqql+qHvDeCflV2Yc6gxRp7Z5L/l2O1Vd5cT4OjGDFceuT1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311011; c=relaxed/simple;
	bh=ANcnDbJl1GrE6afhpUmaNktn53Zw0TE+IUnQR7Lyflk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZe0F+CEM0Y+FcHXOnXA1y8Bbjw1BQRnTBQ77X5SUt5miWe/2UFu2z+MZboMk9NsMLfCO8JYbth9xgUrgBIB0+X1MdKy5UxIITLZ8XQBU61SIV+Opda4BLb4fxPsL1CrVGS24uiXZGJmabfAgXc4KMNnRswyqq5TgSsSO9nX0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPPsldMu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPPsldMu"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4631679f204so1146816f8f.0
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782311007; x=1782915807; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Per6MI6n5CBZ4jce2Yah0coKW3mXxHCaIKwWKmwmsgQ=;
        b=SPPsldMuVWaGiF050fuVxnnw33dWV70IYrgCZj18IVzqBIrp8NOeZvf04oY5AH9Tot
         /z0JKFPHgCBN5LaLKr5NKLy3RnTpqQlf0Pk/sQ9zadUDLE2qJ2WNSZAQqMhjVBCBrHf2
         /5GZHDEwehEsFg71weD67uRigMLpV++JUQf8Gw8J2ENwz20CA2n22cKefKMp2gydgpMK
         j0rT8J34zRRj75fz2WbQfpOqUo3xfCy+/H0mbLVFfHawVcOL++u3i7hQ/0odTxUbXgjm
         5JcgTGPoUw+I7Pj1Vc/atynXzepOiuWUX3viQuXZSGEw765ta2oGHqexNSTTgBid+rHl
         610A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311007; x=1782915807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Per6MI6n5CBZ4jce2Yah0coKW3mXxHCaIKwWKmwmsgQ=;
        b=b/4U9IjwU9tYoJUbfCWqlCyXZj+DZCmC6BHTZaqwi/f8GhFT3dKJEnNZG5Q1qQ34/7
         O+R3U0GYjcCrb6OBjBy7XPGGZTBd19hm+jpuj6OBFN43W8+BreSFFJZwwhnfkGcm4SHA
         oxge48/gFELJi8S7I0NNTS/rBz5nyWErkhO6xI8Oku7GtksAJq3Cjh4MdMGcdIwkJeuE
         J/3LxHK+1fJT6OaCGVtbJrub5Zh1T5oaFF/ObExpSaJ/LRR/B02UvZhzQTgRHu9AIZLi
         66F2/58ZCB/LCCK6jLlrHlSP8oDgssb0cCJzk7CC1wZboFpxF+7iKS+ZLV5CNmafGyGn
         h5jw==
X-Forwarded-Encrypted: i=1; AHgh+RoLTvxoFRlXkoc4Bq+D3fCnavmJ/jw77T9qz9w+Y0RW3uZkyrNd5a2doXdA68Be7nl4NEddHEcDKPbphNiNxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJpKvemP53jl0J47y1cHpH6ohhbioytqxGxEnE47CEDF4M6DcT
	jxVwDerHRJI0UitYqVYXh68bOvgeODqVmIh29xM3bx/s2c0hWo+mRgF9
X-Gm-Gg: AfdE7cnS/XD+ywkSViBCPku3z4VZ4++6p6ULUq33n9ms0Vj9FuN7N3yghpudaLVNagp
	pa60ZXxhdC3QNhVjSWckNs3pEQIoGC//YLP3npKQ14R8lyaoXc46enAg5le2l+RLi0OT1/hl3z3
	zZiBiPmO43Kw5Hd9LbLJyIxwGrx8GHbP+IFN5rkx0vPKymfdFWMjCCfiEMQXQ6l7nDAxV4fkK3K
	tyNGlyr2tmDDuYOtNxW4gbK6HGOdJ9soYI2Z6h4RVM+u0mXFYoTLSgTHcmAAS5Fhq0WjYXpkf5e
	VtrORZBPcqRZizn1tUrf0mG+AWVJIaNeqG4vu6SuaaOlS+FKC1N7DMk2KK94lVCdEhLt6nMEP4F
	2FWTFlzBz7zgUiR0M8Riq73+lG3qC8PqUpn33jkr3nHX6jDOm6acMYH4WDch3wEV/YL4XAdaS5T
	Bzu+K5EIIxrhnl585B1qVzYiXdGBCn05yRoOau3BEGzuN88jA2yQ==
X-Received: by 2002:a05:6000:471a:b0:460:2e53:a6f6 with SMTP id ffacd0b85a97d-46d04583b35mr1261972f8f.12.1782311006854;
        Wed, 24 Jun 2026 07:23:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9405sm8183744f8f.22.2026.06.24.07.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:23:26 -0700 (PDT)
Date: Wed, 24 Jun 2026 15:23:24 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Kaitao Cheng <kaitao.cheng@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Paul
 Moore <paul@paul-moore.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, David Howells
 <dhowells@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>, Randy Dunlap
 <rdunlap@infradead.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Philipp
 Stanner <phasta@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, audit@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kexec@lists.infradead.org, live-patching@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pm@vger.kernel.org, rcu@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-mm@kvack.org, virtualization@lists.linux.dev, damon@lists.linux.dev,
 llvm@lists.linux.dev, Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: Re: [PATCH v3 1/7] list: Add mutable iterator variants
Message-ID: <20260624152324.3def88ce@pumpkin>
In-Reply-To: <cf8467c7-b98f-44a5-9cf9-60b43b5da711@amd.com>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
	<20260622040533.29824-2-kaitao.cheng@linux.dev>
	<20260622094242.64531b9a@pumpkin>
	<351a6b67-b394-4c58-aee2-88b6c8089ad5@linux.dev>
	<cf8467c7-b98f-44a5-9cf9-60b43b5da711@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jun 2026 15:23:47 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> On 6/24/26 15:14, Kaitao Cheng wrote:
> >=20
> >=20
> > =E5=9C=A8 2026/6/22 16:42, David Laight =E5=86=99=E9=81=93: =20
> >> On Mon, 22 Jun 2026 12:05:31 +0800
> >> Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
> >> =20
> >>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> >>>
> >>> The list_for_each*_safe() helpers are used when the loop body may
> >>> remove the current entry.  Their API exposes the temporary cursor at
> >>> every call site, even though most users only need it for the iterator
> >>> implementation and never reference it in the loop body.
> >>>
> >>> Add *_mutable() variants for list and hlist iteration.  The new helpe=
rs
> >>> support both forms: callers may keep passing an explicit temporary cu=
rsor
> >>> when they need to inspect or reset it, or omit it and let the helper =
use
> >>> a unique internal cursor. =20
> >>
> >> I'm not really sure 'mutable' means anything either.
> >> It is possible to make it valid for the loop body (or even other threa=
ds)
> >> to delete arbitrary list items - but that needs significant extra over=
heads.
> >>
> >> It might be worth doing something that doesn't need the extra variable,
> >> but there is little point doing all the churn just to rename things.
> >> =20
> >>>
> >>> This makes call sites that only mutate the list through the current e=
ntry
> >>> less noisy, while keeping the existing *_safe() helpers available for
> >>> compatibility.
> >>>
> >>> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> >>> ---
> >>>  include/linux/list.h | 269 +++++++++++++++++++++++++++++++++++++----=
--
> >>>  1 file changed, 231 insertions(+), 38 deletions(-)
> >>>
> >>> diff --git a/include/linux/list.h b/include/linux/list.h
> >>> index 09d979976b3b..1081def7cea9 100644
> >>> --- a/include/linux/list.h
> >>> +++ b/include/linux/list.h
> >>> @@ -7,6 +7,7 @@
> >>>  #include <linux/stddef.h>
> >>>  #include <linux/poison.h>
> >>>  #include <linux/const.h>
> >>> +#include <linux/args.h>
> >>> =20
> >>>  #include <asm/barrier.h>
> >>> =20
> >>> @@ -763,28 +764,72 @@ static inline void list_splice_tail_init(struct=
 list_head *list,
> >>>  #define list_for_each_prev(pos, head) \
> >>>  	for (pos =3D (head)->prev; !list_is_head(pos, (head)); pos =3D pos-=
>prev)
> >>> =20
> >>> -/**
> >>> - * list_for_each_safe - iterate over a list safe against removal of =
list entry
> >>> - * @pos:	the &struct list_head to use as a loop cursor.
> >>> - * @n:		another &struct list_head to use as temporary storage
> >>> - * @head:	the head for your list.
> >>> +/*
> >>> + * list_for_each_safe is an old interface, use list_for_each_mutable=
 instead.
> >>>   */
> >>>  #define list_for_each_safe(pos, n, head) \
> >>>  	for (pos =3D (head)->next, n =3D pos->next; \
> >>>  	     !list_is_head(pos, (head)); \
> >>>  	     pos =3D n, n =3D pos->next)
> >>> =20
> >>> +#define __list_for_each_mutable_internal(pos, tmp, head)		\
> >>> +	for (typeof(pos) tmp =3D (pos =3D (head)->next)->next;		\ =20
> >>
> >> Use auto
> >> =20
> >>> +	     !list_is_head(pos, (head));				\
> >>> +	     pos =3D tmp, tmp =3D pos->next)
> >>> +
> >>> +#define __list_for_each_mutable1(pos, head)				\
> >>> +	__list_for_each_mutable_internal(pos, __UNIQUE_ID(next), head)
> >>> +
> >>> +#define __list_for_each_mutable2(pos, next, head)			\
> >>> +	list_for_each_safe(pos, next, head)
> >>> +
> >>>  /**
> >>> - * list_for_each_prev_safe - iterate over a list backwards safe agai=
nst removal of list entry
> >>> + * list_for_each_mutable - iterate over a list safe against entry re=
moval
> >>>   * @pos:	the &struct list_head to use as a loop cursor.
> >>> - * @n:		another &struct list_head to use as temporary storage
> >>> - * @head:	the head for your list.
> >>> + * @...:	either (head) or (next, head)
> >>> + *
> >>> + * next:	another &struct list_head to use as optional temporary stor=
age.
> >>> + *		The temporary cursor is internal unless explicitly supplied by
> >>> + *		the caller.
> >>> + * head:	the head for your list.
> >>> + */
> >>> +#define list_for_each_mutable(pos, ...)					\
> >>> +	CONCATENATE(__list_for_each_mutable, COUNT_ARGS(__VA_ARGS__))	\
> >>> +		(pos, __VA_ARGS__) =20
> >>
> >> The variable argument count logic really just slows down compilation.
> >> Maybe there aren't enough copies of this code to make that significant.
> >> But just because you can do it doesn't mean it is a gooD idea.
> >> I'm also not sure it really adds anything to the readability.
> >>
> >> And, it you are going to make the middle argument optional there is
> >> no need to change the macro name. =20
> >=20
> > Christian K=C3=B6nig and Jani Nikula also disagree with the variadic-ar=
gument
> > implementation approach. If we abandon that method, it means we will
> > inevitably need to add some new macros. If mutable is not a good name,
> > suggestions for better alternatives would be welcome; coming up with a
> > suitable name is indeed rather tricky. =20
>=20
> I don't think you need to add a new macro for the specific use case that =
people want to modify the next element of the iteration.
>=20
> If I remember your numbers correctly that is a really corner case and kee=
ping using the existing *_safe() macros for that sounds perfectly fine to m=
e.

IIRC currently you have a choice of either:
	define               Item that can't be deleted
	list_for_each()	     The current item.
	list_for_each_safe() The next item.
There is also likely to be code that updates the variables to allow
for other scenarios.

Note that if increase a reference count and release a lock then list_for_ea=
ch()
is likely safer than list_for_each_safe() :-)

list.h has 9 variants of the 'safe' loop.
The bloat of another 9 is getting excessive.

It has to be said that this is one of my least favourite type of list...

	David

>=20
> Regards,
> Christian.

