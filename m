Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22B13D639
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484648; cv=none; b=o+gRicBG/WgV1QDXX6volf6SKJERHcp1Wdba5IETA+8SfJwqGNAJJrPTlzSXFgKJ7TffJEHlv/Y6va6Abr327yaJuD1JRtU12gos3i8zE4euAvWi8QpU0T8RvhAjWZNUt3aZ636gf8lmf8kqIxULCy7rqfXWySAkR2jXwMXw6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484648; c=relaxed/simple;
	bh=mWwfdGmaJI5/v599SuFLYqcN0BETsqK70kzkErBfIJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPmAXvhayOnKqEukQ1awEyONBrez2cydzDyqkWHCofSxdxwxUkLUyjK7//l1Q+B3pDn6NSJ8tUB1GqlJaXO/I+EmBfcgmxB9CR6UAPv/+BJVAo6enQX3OuzfO9UMT1yXWaU/ua/KgRUE4b4oBCtSOYNEUTMK7+91HiqIIzmvyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UIVdFEaa; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UIVdFEaa"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56bc8cfc19fso6636891a12.1
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711484644; x=1712089444; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnO3hfDzNJhG1W8n4621OnBzOy9cpmEtEz5rXGN5tRg=;
        b=UIVdFEaa65Hcekl+qMPbjfUB/I8rCOXfNlgvuiGTZpQLCOH0VYGFzwRYu4MRJlCvoP
         WImVVeweWDruWbmv5/dDpEna23bqwNfl5Q08nOXz+zhTzhtDOR5xG0WFeC79PWH5BaX7
         c2UJCye76kDTtPNQXacT196L3hn0n8oS5jQi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484644; x=1712089444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnO3hfDzNJhG1W8n4621OnBzOy9cpmEtEz5rXGN5tRg=;
        b=Al9usmVeiUgy20y+bMfoDKmVujvtbglcKfaoKB2umdNy0KtoUHs3poCPpyupQNY7MB
         oBE3CEaoB1p2S/i18VC7okXwPwICt1aqJQPBxPzy/0zckqGisobU3uoqknjCZFtCFIWH
         XOlLsE7Z9NG9JB+YT5YaUWQutPfBRc0yZ75Gkg8gxMO8cARgkVTdbPLvE1CnBGXaJ/wp
         W4ZwKHhi/iJJ/sh/oGPLR179UILi0pZy9LZZK4zTzp/DjSbBr4aKUfBfjY4PIxVij0/d
         G40ACzHZ2dUJ3x/Yb+OMe/OpyYH2pK7vxy1XMajYlhYOk1kNfDu5d0Aqhj6d2nyBTfMz
         TCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtHbh9+h8JPOWS4Sz4YtTojf9cFQEfRr67UxSXVgK4jbBlC6NYrs3dPaakS53O09CDzNg3gSLPggJjxudkVoRnm3LHBMvumtkOnQZfMbQ=
X-Gm-Message-State: AOJu0YzyFqI13HCf0619h7JBQPDm/c7mq67CxJLeNNXLOQ/HMRjpKHDS
	wGcxtkoArYfd2hRjTsmmVtdb7uFNuiA1hOT6SjKhD5lsx3ry8vfcxitwGHFAx6i1I624ZIHK4Nx
	LZQ==
X-Google-Smtp-Source: AGHT+IGprUp1Zpp54OJkDCdVvzDIsKZY14G+KNLC+ckEqBBkqc3mXcLETWLmnaQ1U1Y1FwHYUMXQuQ==
X-Received: by 2002:a50:9e65:0:b0:568:fb58:bc4d with SMTP id z92-20020a509e65000000b00568fb58bc4dmr1625835ede.8.1711484644420;
        Tue, 26 Mar 2024 13:24:04 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id ev17-20020a056402541100b0056bf7f92346sm4272481edb.50.2024.03.26.13.24.03
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:24:03 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4751063318so371429466b.0
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 13:24:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/42KdGzdoVNlLcCHWgGGeXg4s/E97Sq6uQOsz8+Sjuf9OcVk+tOE6FMWo9UAW/D4qjMkL8hjoCZoz6Ay3+ONEDClaMhSHNK8s5R9e4wg=
X-Received: by 2002:a17:907:2686:b0:a47:3c66:b396 with SMTP id
 bn6-20020a170907268600b00a473c66b396mr1888708ejc.64.1711484642859; Tue, 26
 Mar 2024 13:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com>
 <20240321101532.59272-2-xuanzhuo@linux.alibaba.com> <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
 <b420a545-0a7a-431c-aa48-c5db3d221420@redhat.com> <1711346901.0977402-2-xuanzhuo@linux.alibaba.com>
 <041867ab-6cff-4bd1-9a44-2ca847c1ad63@redhat.com>
In-Reply-To: <041867ab-6cff-4bd1-9a44-2ca847c1ad63@redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Tue, 26 Mar 2024 13:23:35 -0700
X-Gmail-Original-Message-ID: <CABVzXA=QHxAbkN5qorb5e8gKtd-c9P61z_ft07PPkkzaDMxB_A@mail.gmail.com>
Message-ID: <CABVzXA=QHxAbkN5qorb5e8gKtd-c9P61z_ft07PPkkzaDMxB_A@mail.gmail.com>
Subject: Re: [PATCH vhost v4 1/6] virtio_balloon: remove the dependence where
 names[] is null
To: David Hildenbrand <david@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:11=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 25.03.24 07:08, Xuan Zhuo wrote:
> > On Fri, 22 Mar 2024 22:02:27 +0100, David Hildenbrand <david@redhat.com=
> wrote:
> >> On 22.03.24 20:16, Daniel Verkamp wrote:
> >>> On Thu, Mar 21, 2024 at 3:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> >>>>
> >>>> Currently, the init_vqs function within the virtio_balloon driver re=
lies
> >>>> on the condition that certain names array entries are null in order =
to
> >>>> skip the initialization of some virtual queues (vqs). This behavior =
is
> >>>> unique to this part of the codebase. In an upcoming commit, we plan =
to
> >>>> eliminate this dependency by removing the function entirely. Therefo=
re,
> >>>> with this change, we are ensuring that the virtio_balloon no longer
> >>>> depends on the aforementioned function.
> >>>
> >>> This is a behavior change, and I believe means that the driver no
> >>> longer follows the spec [1].
> >>>
> >>> For example, the spec says that virtqueue 4 is reporting_vq, and
> >>> reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set,
> >>> but there is no mention of its virtqueue number changing if other
> >>> features are not set. If a device/driver combination negotiates
> >>> VIRTIO_BALLOON_F_PAGE_REPORTING but not VIRTIO_BALLOON_F_STATS_VQ or
> >>> VIRTIO_BALLOON_F_FREE_PAGE_HINT, my reading of the specification is
> >>> that reporting_vq should still be vq number 4, and vq 2 and 3 should
> >>> be unused. This patch would make the reporting_vq use vq 2 instead in
> >>> this case.
> >>>
> >>> If the new behavior is truly intended, then the spec does not match
> >>> reality, and it would need to be changed first (IMO); however,
> >>> changing the spec would mean that any devices implemented correctly
> >>> per the previous spec would now be wrong, so some kind of mechanism
> >>> for detecting the new behavior would be warranted, e.g. a new
> >>> non-device-specific virtio feature flag.
> >>>
> >>> I have brought this up previously on the virtio-comment list [2], but
> >>> it did not receive any satisfying answers at that time.
> >>
> >> Rings a bell, but staring at this patch, I thought that there would be
> >> no behavioral change. Maybe I missed it :/
> >>
> >> I stared at virtio_ccw_find_vqs(), and it contains:
> >>
> >>      for (i =3D 0; i < nvqs; ++i) {
> >>              if (!names[i]) {
> >>                      vqs[i] =3D NULL;
> >>                      continue;
> >>              }
> >>
> >>              vqs[i] =3D virtio_ccw_setup_vq(vdev, queue_idx++, callbac=
ks[i],
> >>                                           names[i], ctx ? ctx[i] : fal=
se,
> >>                                           ccw);
> >>              if (IS_ERR(vqs[i])) {
> >>                      ret =3D PTR_ERR(vqs[i]);
> >>                      vqs[i] =3D NULL;
> >>                      goto out;
> >>              }
> >>      }
> >>
> >> We increment queue_idx only if an entry was not NULL. SO I thought no
> >> behavioral change? (at least on s390x :) )
> >>
> >> It's late here in Germany, so maybe I'm missing something.
> >
> > I think we've encountered a tricky issue. Currently, all transports han=
dle queue
> > id by incrementing them in order, without skipping any queue id. So, I'=
m quite
> > surprised that my changes would affect the spec. The fact that the
> > 'names' value is null is just a small trick in the Linux kernel impleme=
ntation
> > and should not have an impact on the queue id.
> >
> > I believe that my recent modification will not affect the spec. So, let=
's
> > consider the issues with this patch set separately for now. Regarding t=
he Memory
> > Balloon Device, it has been operational for many years, and perhaps we =
should
> > add to the spec that if a certain vq does not exist, then subsequent vq=
s will
> > take over its id.
>
> Right, if I am not missing something your patch should have no
> functional change in that regard (that the current
> behavior/implementation might not match the spec is a different discussio=
n).
>
> @Daniel, if I'm missing something, please shout.

Thanks for digging into that - I think you're correct in that the
patch does not change the behavior, due to changes elsewhere in the
generic virtio and virtio-pci code. So in that sense, I guess this
should not block this particular patch.

It would be good to have the spec situation cleared up, though - I
guess in practice, all relevant drivers and device implementations are
already following the model where there are no gaps in the queue
numbering, rather than what the spec seems to indicate.

Thanks,
-- Daniel
