Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB31153565
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313475; cv=none; b=BB3K3shxPEc/3UpUK6lgUpiFQxK3pTB2lIMn6iQSDUU3B88hxYfnXIH3pwP25LKnbhwGYRtE87Z11VR0FFVVr5q6iAjeGWmh/TocA8HBsJu9lrf0oxmnLGpZT6TTIvf+WI0qLsiMqIrlVELRDhpifxrRuLV5aG8CbZaCQfGVo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313475; c=relaxed/simple;
	bh=8KXtPHsjFoj3uv2wva509wGKTEUBoElOsas9eq9UJPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4w+98ywdXYScytw/upXzIzA7NH/WS2vz+Gp9Jx/tX4cWpgrGaeKVKEy4JPxLe9h+LbEDTNQTEpYV24EjwoHSxy2DgZom6b7Z18EFmKoDCswEK3q+B0NwqfZyzfaSmjTUdGcpRjZNsxlovaWG6qMeeGkgpvKo4v4WKaIry5TQhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l19NylLj; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l19NylLj"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-842f00b72e4so174112241.1
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 00:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724313472; x=1724918272; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vx7goW6BrSZt6yvtR2KIlQz0YFwTgKAn18ohH71KEoQ=;
        b=l19NylLjddpqcXwrbxF19E42H/H7R4OJVoCpGsvKk82rH0zfW2Bq3MjvNNUrI0eQ0e
         bDpDymtlpKRNVNI17iEIQixPY5nqGtahWt4wFhqF8wopl8V/YGTGdsCJ2TvlaE/DO6Dl
         i6TVB306uMmEcIrM7U5IWi0fw40aE8jg6g1m2QM+b4lHjtU7nbx/WYckfcUP8od5u5G1
         3odbQjbUzlNAQjMTJNVFoGk7vZgWrRzgr8+uLi9WvrPI9j7/2ZW7QW15ipTMzk1K9qkG
         7GANAY0AUlQ2Kdl2eNOIVv5qrNinIHe5jf5wHrdr26/U3du3nSBa2UIFgg3SFM7Ia/n2
         Hgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724313472; x=1724918272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vx7goW6BrSZt6yvtR2KIlQz0YFwTgKAn18ohH71KEoQ=;
        b=k7mebbuXy3xbN2zxzO/uo5Yb8q42nSatBByssgpUmMLBgUMYkyVlwozS27YSzxhb1B
         G9NiRyrxGIBeUOLRq+eM88P4YeGdD0T45SQdx+riBsMQgliFb/XxPQR9a+JFQevJ8KeC
         L7rlfU+abFFNbkiQaJoxVWr6ECnrNAyOz5KklBj2gUsN53eUauyPlYBZoihom9qojlgo
         tIWHSs2QKSqQfJxRTXpRJkHCb0Rz8zR8m424rjftK9Kim2AoBUGaUlZ633SrlBkeWY5L
         Y8vTVTJpCJ7hidXoLkg9PJjy/S+H9UWsyQO+YBl0TnlX9gK1nlAISAg1KGWdm0h1nI42
         u9IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNjvn+OL4y0uTQiNoduKQULqNHYyvKVV99fGNRzd32VnJZdCVEOMdmrU4ITnPEabyXBUSImSrphkhUVi54+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YztLNVr+Y0xZcfv4yHNp4eDHDyXj3IDHIBffbeAhp5eEsivPemN
	WOqdsW8zdkmyWmfE7kjkDfq/ItC5o01hPWyAnpZzXPJrofAcU4/CrET6JVC7ThK8Uy/AjKp/oFM
	HHmlKXo0r37CyhoMhrb6NkXuvq40=
X-Google-Smtp-Source: AGHT+IG/r3gSQhEjKBouSZKmUHqM+wdKZI9hDk06nNlLc2wizZHza8wUPODMHmj9HOZQ71Koaobz4K6VSNPlcbCmWm4=
X-Received: by 2002:a05:6102:3914:b0:497:5e68:887b with SMTP id
 ada2fe7eead31-498d3e4c254mr5477927137.16.1724313472348; Thu, 22 Aug 2024
 00:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka> <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com> <ZsbtGClLMtaeakdo@tiehlicka>
In-Reply-To: <ZsbtGClLMtaeakdo@tiehlicka>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 22 Aug 2024 19:57:41 +1200
Message-ID: <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Michal Hocko <mhocko@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Yafang Shao <laoar.shao@gmail.com>, 
	David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 7:47=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 22-08-24 14:56:08, Linus Torvalds wrote:
> > On Thu, 22 Aug 2024 at 14:40, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > I did find three cases of kvcalloc(NOFAIL) in the nouveau driver and
> > > one in erofs. It's not clear that any of them make much sense (or tha=
t
> > > the erofs one is actually a large allocation).
> >
> > Oh, and I missed one in btrfs because it needed five lines of context
> > due to being the allocation from hell.
> >
> > That said, yes, the vmalloc case at least has no fragmentation issues,
> > but I do think even that needs to be size limited for sanity.
> >
> > The size limit might be larger than a couple of pages, but not
> > _hugely_ larger. You can't just say "I want a megabyte, and you can't
> > fail me". That kind of code is garbage, and needs to be called out for
> > being garbage.
>
> yes, no objection here. Our current limits are too large for any
> practical purpose. We still need a strategy how to communicate that
> the size is not supported though. Just returning NULL is IMHO bad thing
> because it adds potentially silent failure. In other subthread I was
> contemplating about OOPS_ON which would simply terminate the user
> context and kill it right away. What do you think about something like
> that?

Personally, I fully support this approach that falls between BUG_ON
and returning NULL. Regarding the concern about 'leaving locks
behind' you have in that subthread,  I believe there's no difference
when returning NULL, as it could still leave locks behind but offers
a chance for the calling process to avoid an immediate crash.

> --
> Michal Hocko
> SUSE Labs

Thanks
Barry
