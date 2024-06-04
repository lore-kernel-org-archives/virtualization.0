Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0442114A0A9
	for <virtualization@lists.linux.dev>; Tue,  4 Jun 2024 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524591; cv=none; b=dPnsoRfiG9h50yGC+htlbn7kmlhKMnhDOaXnpPzo1imdVwRXOzjDtmQNVwT3HWH1GNsMUNxSxYzCZWyGNanew7R/h9f/6sVmKrAgpG/tJBKupeaUaomDvYzMgOEO6JqZ6IDIdOE4JZRUgTnlTCPJOWs2WH488xFx4k3mtxctCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524591; c=relaxed/simple;
	bh=Q/vqJhAwI6RsLZCudsHBw6Pj5sVNgMSrhmb9L69ADyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5rNm1tjn1743JCmeXY5gA/WZnYlSMnpOX5lOgqS18/xG3SJWaOskyY59Me/IA2rODgn/Xsb5BD+KqiEiheiH7glNDZhdlPTvxnRH/jIa6anpNz8+hoYLnla3dl/CQZqkpKmRZuj5kCOUL338ttqDz8GmlV+37Cv3XSA/aJEsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LbjDdtjJ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LbjDdtjJ"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e72224c395so52617971fa.3
        for <virtualization@lists.linux.dev>; Tue, 04 Jun 2024 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717524588; x=1718129388; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTkkByq7ZwISyvxejcvHZtm+hsmFHE1SVWn4MBX6fv0=;
        b=LbjDdtjJNEkbIcBpzMc/OELAn2nuVZiy1wiTOEV07Vtn1b3+jUgm+jBpM6DsDVHlv1
         j1iLp3vsHS9I9ue1efKTmRiEZEUvrOhpKwyuOUCMrqptMtI2Ng4elolpUk78LlM3UnJg
         BHc34oZEj0Jf7ROjzfH8ZkBlUU+cPKF2KnJ4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717524588; x=1718129388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTkkByq7ZwISyvxejcvHZtm+hsmFHE1SVWn4MBX6fv0=;
        b=BdcAfXvRFPxw2gFOYs99dfgVbByUFVbKELV0lmezL9qL3JidezOPXiS59i6LhnyftN
         v0TpmyUj8qVE4seWXrnsTAQFgy8pFp1NFT0WHoHlQ9gWkH9pPdP3maJJSd+umBAMT+A2
         oNl5dTaSzjEp33eY/UZEsEyGbXfMS8CjVEIvTLm5oa/orELu3zrJdYymMRY2QZwBnfRB
         3oOtfHD/ZqfTEcabcZckpHZ+pvxCWXnfqmx5K7Y3mprD8wUkNUM/FtohvrlG2ucFOwCf
         1eN+RoR1s4l+fA2rexAZK+bw0FCxyDQNhjFeG2M8GL4W7rda2WlKzGohJHoMYDs4ojBb
         DNIA==
X-Forwarded-Encrypted: i=1; AJvYcCUktF9KQYr6ba4aTDad8w30qLpBZEELFpqGvBSYCXGcHDjv+Zr9VP3euplcUnF3e1Kuq0SVb+BuOJOeQD3Y2ybYSQ+X9wrIkZUctvzaEi4=
X-Gm-Message-State: AOJu0YyakroOb9+/wnjWZjO7N/d4uAC167aVSiphZX9T9F82HawpU4rc
	w4CSEBZIWEdCnEPy1/TvELaW7otrqR4F8CRzRsQc502QKQWLJGTYW8QpeLS6MgQQHoLuuhEiAsu
	0Wfcs
X-Google-Smtp-Source: AGHT+IECJddGAwiVlI9SSjnCJBv4bJk7UAVybviRskrXFIxSyEIegedHOCaYfnsNf4eDwKMFBI8LvA==
X-Received: by 2002:a2e:8943:0:b0:2de:cc70:2552 with SMTP id 38308e7fff4ca-2eac798e7eamr479321fa.10.1717524587994;
        Tue, 04 Jun 2024 11:09:47 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91b9d983sm16066461fa.7.2024.06.04.11.09.44
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 11:09:45 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b894021cbso5537761e87.0
        for <virtualization@lists.linux.dev>; Tue, 04 Jun 2024 11:09:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMTG2Ez7lWr9KrOY11PZ5nvkf1kJkjbQNl9YYll0OHVvpYMdblUYTcjjB0n9rVUJXCn3n3atQm3kfv966NbZafRUxJKNXvtRylsDHopic=
X-Received: by 2002:a05:6512:3ca2:b0:52b:8613:9d2d with SMTP id
 2adb3069b0e04-52bab4fa5d3mr197824e87.55.1717524584300; Tue, 04 Jun 2024
 11:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com> <20240603134427.GA1680150@fedora.redhat.com>
In-Reply-To: <20240603134427.GA1680150@fedora.redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Tue, 4 Jun 2024 11:09:16 -0700
X-Gmail-Original-Message-ID: <CABVzXAkJGjJyP1DCrh-r+ZeA1v8VV9C8BkqxzhLGyhYw8qhcaA@mail.gmail.com>
Message-ID: <CABVzXAkJGjJyP1DCrh-r+ZeA1v8VV9C8BkqxzhLGyhYw8qhcaA@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Peter-Jan Gootzen <pgootzen@nvidia.com>, Idan Zach <izach@nvidia.com>, 
	Yoray Zack <yorayz@nvidia.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Parav Pandit <parav@nvidia.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	"mszeredi@redhat.com" <mszeredi@redhat.com>, Eliav Bar-Ilan <eliavb@nvidia.com>, 
	"mst@redhat.com" <mst@redhat.com>, "lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>, Oren Duer <oren@nvidia.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 6:44=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Mon, Jun 03, 2024 at 11:06:19AM +0200, Miklos Szeredi wrote:
> > On Mon, 3 Jun 2024 at 10:53, Peter-Jan Gootzen <pgootzen@nvidia.com> wr=
ote:
> >
> > > We also considered this idea, it would kind of be like locking FUSE i=
nto
> > > being x86. However I think this is not backwards compatible. Currentl=
y
> > > an ARM64 client and ARM64 server work just fine. But making such a
> > > change would break if the client has the new driver version and the
> > > server is not updated to know that it should interpret x86 specifical=
ly.
> >
> > This would need to be negotiated, of course.
> >
> > But it's certainly simpler to just indicate the client arch in the
> > INIT request.   Let's go with that for now.
>
> In the long term it would be cleanest to choose a single canonical
> format instead of requiring drivers and devices to implement many
> arch-specific formats. I liked the single canonical format idea you
> suggested.
>
> My only concern is whether there are more commands/fields in FUSE that
> operate in an arch-specific way (e.g. ioctl)? If there really are parts
> that need to be arch-specific, then it might be necessary to negotiate
> an architecture after all.

For the purposes of virtio, it would definitely be preferable to
define the FUSE protocol in a single, canonical,
architecture-independent form. Ideally, this definition would be
sufficient to implement a working virtio-fs client or server without
referring to any Linux headers; currently, the virtio-fs spec just
links to the Linux FUSE uapi header, which seems suboptimal for a
protocol that is meant to be OS-agnostic (and has the problem of
depending on arch-specific values, as discussed in this thread).

One possible problem that I have noticed is that the interpretation of
the max_pages field in fuse_init_out depends on the value of
PAGE_SIZE, which could differ between host and guest even within the
same architecture (e.g. ARM64 with 4K vs. 64K pages); architecture
negotiation would not help with this particular problem. It would be
nice if it could be specified in a canonical way as well, perhaps
changing the definition so that it is always in units of 4096 bytes.

Thanks,
-- Daniel
