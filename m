Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633FB15359A
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742960; cv=none; b=iYJCHAlsT9wI86kFS3BQcngB/KisqiqOxaxbztyN3gcmqUKmXmV+RueSK0TSjut1/cHcZXFqP7N/2nHlef9MaVNrmRTWdPkwfzNpKPQ6LFENptwzhVOaPS/rUVemzDeY96+BYDm2AuaVGmMs8dL9ohpCNQ3uE0xZ+HFa16W3/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742960; c=relaxed/simple;
	bh=z8Ov6lVHTxTLociXAbhgX1GddR6eRbgZ8MBoiTFm3WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0WaBrdMo0ZAJAwrbqgF1nc4U0lglVWw1GxINyHke+rFOdYx4XHgFnsBcBFyGAwYhUbBcahsb4PNhmabe/cjv0eBeA5aZuwMHIhLwvuersINd8M92P7AZoWp+KXWtNWgptCBM4LM1OVprGbI0xtLkiHkR1DYYXdYR5zP2WQVpPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EppM+E21; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EppM+E21"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-498e1fea1a7so1449004137.3
        for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 00:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724742957; x=1725347757; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfWuviBxFJfV58v2V14NBfJBOrU5hN/q2Ap2CVzf5/M=;
        b=EppM+E21jpMiHnbrIUXPNdOqu8YJm5qU5Dy6JWJCJiSPc//EmFlNhTnBySS+5U2KDj
         9VyhoqVxY7emfru1APL8CrKR9jqGjWWxfkPwl0vibneSnqVLzPIxjKYoLKddUOHerTkv
         8jsHVDM1+eDoajyCqeNqE37s6NpueX9dttBrz8Zy7HxOipNINDW1szALfde4bUOxCZWT
         7cPZtm3IOjklW3iLNcx2Pgefr99mMVtAyUJ3gaBj5WdZG6b76yW4sMhK1ydzVjSid0Aa
         druz1dn0s1ISpjd0Cl2mt46ZtSy6mgSGENcoKiMwF9xCTrNedQUf4qfnvippIhQcnR9w
         cZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724742957; x=1725347757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfWuviBxFJfV58v2V14NBfJBOrU5hN/q2Ap2CVzf5/M=;
        b=gcsKzJz4dIptax+T3zw8Pod/3HebJsch0cQEV4nii0NsItvvASaKREHIwc21g2d1h0
         z8aEtwHeYjYgltrGwI9+zWd8qgZlQHTllIgfIDG+Gl68/eRxIfKPoysTQ/wTfxPyqsPi
         Wxluv+UcBUmRGni8MD+9s78E7UTiwRNqoR7oLP9BO6EDXZlGxCySn00/DQMBq9Gjia7Y
         AMgLTGWcnRWnO3OytaBFB3OtaUWvrwgg2ZGZOqquU6H50oSABfOS1WwkQM/vD23JAS2y
         OEKBBEqS6beTSgIuraclgNS79O6+qDPgICrcPCo6IeNirFgazyBudB4H0G0Z8UUj67cm
         lpOA==
X-Forwarded-Encrypted: i=1; AJvYcCUgRj4KN30Pyyn+Bgx0ScuTyYfbw68Tlv69ct5joTDDUHaGyphXQDvnVJoqqXBqL746kvIN1fDwr/RaKudGJA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywg8ojroGIueKAqOVgsNMRwkXAiAm3Ybe2CwSh1p7aMc3di9Ewc
	TK48wYCjofO7Eam9mB4AMUvP773AozuiSvzDlaQ+IvxswKn8S58F7GmqtRtSOrr0auTzqR0edT1
	Obl3KTJXRL+JR5t3DWFkTz2kEoEg=
X-Google-Smtp-Source: AGHT+IFOMrdGBPzB/Y23gbATO0KawTPc/T3RLt8h6VL3XTl25KGI/hvLQkpOjytPsxTrJiKvX/bCPttzTgY8gG++yNU=
X-Received: by 2002:a05:6102:3051:b0:498:ca87:ba49 with SMTP id
 ada2fe7eead31-498f47008ecmr9632852137.19.1724742957164; Tue, 27 Aug 2024
 00:15:57 -0700 (PDT)
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
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Aug 2024 19:15:45 +1200
Message-ID: <CAGsJ_4znRBscU8FWMZL7Z9qLUMxCPtupRcJqu+PXz260p-S6MA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Michal Hocko <mhocko@suse.com>, Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 12:10=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 8/22/24 11:34, Linus Torvalds wrote:
> > On Thu, 22 Aug 2024 at 17:27, David Hildenbrand <david@redhat.com> wrot=
e:
> >>
> >> To me, that implies that if you pass in MAX_ORDER+1 the VM will "retry
> >> infinitely". if that implies just OOPSing or actually be in a busy loo=
p,
> >> I don't care. It could effectively happen with MAX_ORDER as well, as
> >> stated. But certainly not BUG_ON.
> >
> > No BUG_ON(), but also no endless loop.
> >
> > Just return NULL for bogus users. Really. Give a WARN_ON_ONCE() to
> > make it easy to find offenders, and then let them deal with it.
>
> Right now we give the WARN_ON_ONCE() (for !can_direct_reclaim) only when
> we're about to actually return NULL, so the memory has to be depleted
> already. To make it easier to find the offenders much more reliably, we
> should consider doing it sooner, but also not add unnecessary overhead to
> allocator fastpaths just because of the potentially buggy users. So eithe=
r
> always in __alloc_pages_slowpath(), which should be often enough (unless =
the
> system never needs to wake up kswapd to reclaim) but with negligible enou=
gh
> overhead, or on every allocation but only with e.g. CONFIG_DEBUG_VM?

We already have a WARN_ON for order > 1 in rmqueue. we might extend
the condition there to include checking flags as well?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7dcb0713eb57..b5717c6569f9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3071,8 +3071,11 @@ struct page *rmqueue(struct zone *preferred_zone,
  /*
  * We most definitely don't want callers attempting to
  * allocate greater than order-1 page units with __GFP_NOFAIL.
+ * Also we don't support __GFP_NOFAIL without __GFP_DIRECT_RECLAIM,
+ * which can result in a lockup
  */
- WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
+ WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) &&
+     (order > 1 || !(gfp_flags & __GFP_DIRECT_RECLAIM)));

  if (likely(pcp_allowed_order(order))) {
  page =3D rmqueue_pcplist(preferred_zone, zone, order,

>
> > Don't take it upon yourself to say "we have to deal with any amount of
> > stupidity".
> >
> > The MM layer is not some slave to users. The MM layer is one of the
> > most core pieces of code in the kernel, and as such the MM layer is
> > damn well in charge.
> >
> > Nobody has the right to say "I will not deal with allocation
> > failures". The MM should not bend over backwards over something like
> > that.
> >
> > Seriously. Get a spine already, people. Tell random drivers that claim
> > that they cannot deal with errors to just f-ck off.
> >
> > And you don't do it by looping forever, and you don't do it by killing
> > the kernel. You do it by ignoring their bullying tactics.
> >
> > Then you document the *LIMITED* cases where you actually will try forev=
er.
> >
> > This discussion has gone on for too damn long.
> >
> >               Linus
>
