Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE322EE5
	for <virtualization@lists.linux.dev>; Sun,  9 Mar 2025 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741507697; cv=none; b=OvgqqmdUyfLHfk4M1sxt+V29NDtHCHT95QPbNcn+n5Mtg9sfyh+b6TTwDxG4U67nmzuXMFSMn+qP+hF+tZkmf32De5lqFWBslag8TkySE/TfJuvBGm7cg21CEP6ZSq5DfQdn3jdJYmZwTj6VY+Fo67vRYsPX3/zHhwUm7AEARO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741507697; c=relaxed/simple;
	bh=FKHhyL3OuVCU3EdS9Al1za9nRRl4Esv4q+DeXoi0CzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYW7n2f5bX8a1+2TrqtohAKPjrRjofkbY+DSL8bX6hOkQQGHKGZMVJcCeBjrCfXVbYvLFTHSzBWZ6kHnB6RlGFLvJlW2MONWRs0gXAqlsmbD1RSK6xrGj/tZFOkWSxKi79vWXtiiDL4Am1FF0+iCL+4SN6lUOl4xOW5mDNhDjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbNsWys8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbNsWys8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741507694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMLbs4g+4S3w8PTcwZhqCiZ4jHgvhgmMpYzifm6s+EY=;
	b=SbNsWys8uYmuQELkadRLZhHt2ajZxt53tjndRg5kh2twPvKMzb43TO8NCsZSiSZ7Qiux6d
	ZTpV/GWIqq94nOI2WRno+sdIl1GqzNeKv5FLd77JY5YdPDo2y47UkU3uy15vEvoTcsllBz
	20UgQqlt4TCc3CZdCmNaSeN+e9aoqWM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-halrpeGgP7CnoQUTj80pDQ-1; Sun, 09 Mar 2025 04:08:11 -0400
X-MC-Unique: halrpeGgP7CnoQUTj80pDQ-1
X-Mimecast-MFC-AGG-ID: halrpeGgP7CnoQUTj80pDQ_1741507691
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac27d8ac365so58196066b.2
        for <virtualization@lists.linux.dev>; Sun, 09 Mar 2025 00:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741507691; x=1742112491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMLbs4g+4S3w8PTcwZhqCiZ4jHgvhgmMpYzifm6s+EY=;
        b=lsoSnme2xesGhYyYNF3ryBgrorXG7z+EaZOCOP3f5vD0aR556fKTpdGlqY+Gm5xvep
         abgNX/NfD86DJa3DTBGzvnQByVukuuspx8zQKcVG3mP2eUIitfV65GNXvQkl3gPWYwoa
         TpqVXpbRVFG80MUKL3dWRB5KR18oMEYiw2dPgHgwF37N+IiTR2cby0mcsd6m9qqkDMPl
         XnTIdXSu5PlEwrLo9a8dEnv68zpW1by0YNZzyHar6yN56SAX45q1R4PPycbzJT4+ce/P
         xXGReqAulYQ5RoQtDmHgm6B2Crv6AjPiHU/Qz3kwETlwPdEy1btnsBVlQZ0FAwAhN7hm
         nOgg==
X-Forwarded-Encrypted: i=1; AJvYcCX/RD/2gH+SQQA+wdDVIMC+GcnlbXknCI94tAupuA5Qsk9Yo2qRbU73c+W2pFMCVY+GdjxI8qocowXarwQVyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxMevNb6Xy+B4QyIeEoNT95QF1hRo6Q9z8IDYM/92y5JUJLamA
	m6xDs9ildv59ns8b57nsM1XPEb2B/NqrhFGlSlWKwqywyhPHiyZGgCEKZflqOhsGTCn1BpZE7Up
	AOV8EkbLy7SCi/0Imhh86BQftKkSvU1fplTIxR5b+/Y8eXEEcTNQCsZrpEfPZ2OMKB+k5YDhRa5
	CDvoyu8jkG72Sz4SF+6B8sXQVbtHqdR7C3AUBRkK4=
X-Gm-Gg: ASbGncuUY7PEgaBwcIeeG1DwX87sdDvkajTWNIOig49Gzclm/hU1HgEHsWo2nIw4Q45
	VMxL888vE7lgzfWCG7FVqy1acRzhftEEf+MiSup77nAYnAHi5MKBMhF2G0DeniBshmKjSDyHYye
	EVaGDEwYYTKd8OKL2JSi0PoXt5jY2f
X-Received: by 2002:a17:907:c99b:b0:abf:5778:f949 with SMTP id a640c23a62f3a-ac252e9ebd1mr767361866b.42.1741507690639;
        Sun, 09 Mar 2025 00:08:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7U1iyGgohuKugYCzgXBl6WixJZcBRcoUmHFNJf08mvE/aZ1aJlHcdE0jtRjcmbMxi9Sw/rCbNZ3E/zzGi4b0=
X-Received: by 2002:a17:907:c99b:b0:abf:5778:f949 with SMTP id
 a640c23a62f3a-ac252e9ebd1mr767360566b.42.1741507690308; Sun, 09 Mar 2025
 00:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250305152555.318159-1-ryasuoka@redhat.com> <20250305152555.318159-2-ryasuoka@redhat.com>
 <Z8kp9Z9VgTpQmV9d@casper.infradead.org> <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>
 <Z8nEqDQhjU-Ly8Js@phenom.ffwll.local> <51c11147-4927-4ebc-9737-fd1eebe4e0bd@redhat.com>
In-Reply-To: <51c11147-4927-4ebc-9737-fd1eebe4e0bd@redhat.com>
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Sun, 9 Mar 2025 17:07:59 +0900
X-Gm-Features: AQ5f1Jom-CKnJdgtaquTd67G5uzgxxqs44dKctiQ9yfQQxkLNniKi8t6ppg6oo4
Message-ID: <CAHpthZqn7ZZW1ekFQe7nN0+xfsNvMQMKhjMNcB3EyQ18yfQhiA@mail.gmail.com>
Subject: Re: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com, 
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org, 
	dmitry.osipenko@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-mm@kvack.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MnM0_7LD7BL4lJcFKntwHhl2wvCy9ZbvyVsIq4CA3hg_1741507691
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:55=E2=80=AFPM Jocelyn Falempe <jfalempe@redhat.com=
> wrote:
>
> On 06/03/2025 16:52, Simona Vetter wrote:
> > On Thu, Mar 06, 2025 at 02:24:51PM +0100, Jocelyn Falempe wrote:
> >> On 06/03/2025 05:52, Matthew Wilcox wrote:
> >>> On Thu, Mar 06, 2025 at 12:25:53AM +0900, Ryosuke Yasuoka wrote:
> >>>> Some drivers can use vmap in drm_panic, however, vmap is sleepable a=
nd
> >>>> takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
> >>>> requests pages with GFP_ATOMIC and maps KVA without locks and sleep.
> >>>
> >>> In addition to the implicit GFP_KERNEL allocations Vlad mentioned, ho=
w
> >>> is this supposed to work?
> >>>
> >>>> +  vn =3D addr_to_node(va->va_start);
> >>>> +
> >>>> +  insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
> >>>
> >>> If someone else is holding the vn->busy.lock because they're modifyin=
g the
> >>> busy tree, you'll corrupt the tree.  You can't just say "I can't take=
 a
> >>> lock here, so I won't bother".  You need to figure out how to do some=
thing
> >>> safe without taking the lock.  For example, you could preallocate the
> >>> page tables and reserve a vmap area when the driver loads that would
> >>> then be usable for the panic situation.  I don't know that we have AP=
Is
> >>> to let you do that today, but it's something that could be added.
> >>>
> >> Regarding the lock, it should be possible to use the trylock() variant=
, and
> >> fail if the lock is already taken. (In the panic handler, only 1 CPU r=
emain
> >> active, so it's unlikely the lock would be released anyway).
> >>
> >> If we need to pre-allocate the page table and reserve the vmap area, m=
aybe
> >> it would be easier to just always vmap() the primary framebuffer, so i=
t can
> >> be used in the panic handler?
> >
> > Yeah I really don't like the idea of creating some really brittle one-o=
ff
> > core mm code just so we don't have to vmap a buffer unconditionally. I
> > think even better would be if drm_panic can cope with non-linear buffer=
s,
> > it's entirely fine if the drawing function absolutely crawls and sets e=
ach
> > individual byte ...
>
> It already supports some non-linear buffer, like Nvidia block-linear:
> https://elixir.bootlin.com/linux/v6.13.5/source/drivers/gpu/drm/nouveau/d=
ispnv50/wndw.c#L606
>
> And I've also sent some patches to support Intel's 4-tile and Y-tile form=
at:
> https://patchwork.freedesktop.org/patch/637200/?series=3D141936&rev=3D5
> https://patchwork.freedesktop.org/patch/637202/?series=3D141936&rev=3D5
>
> Hopefully Color Compression can be disabled on intel's GPU, otherwise
> that would be a bit harder to implement than tiling.
>
> >
> > The only thing you're allowed to do in panic is try_lock on a raw spinl=
ock
> > (plus some really scare lockless tricks), imposing that on core mm soun=
ds
> > like a non-starter to me.
> >
> > Cheers, Sima
>

Thank you all for your comments.
I understand adding atomic_vmap is not possible as vmalloc is not compatibl=
e
with GFP_ATOMIC. I'll re-implement this by pre-allocating the page table an=
d
reserve the vmap area while the kernel is alive. It'll might be
allocated in driver
codes so maybe I don't need to add any features in core mm code.

Best regards,
Ryosuke

