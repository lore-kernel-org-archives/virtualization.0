Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF6B34B1AC
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137760; cv=none; b=aVbAlHpWR2UrcidMf9GnyA2VVEfIbbODtqyJzX+KmsmYMUur2RFqPdf+J3ZzYNTiW3vEy1othab47D4EO16QsOPoptA3LuNu+i0NntGl9dCs/FnR9oNMG7U5Zps2rCfAL73FvXDxDmSX8Q8J6tRnmgoD6CTIs4YLuP4IAa3SRDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137760; c=relaxed/simple;
	bh=agmGfZLcCAQsl7JXQisFrg8u4h/rd1PShHvnrkyj1c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQUuDQCEV+9hN/o49/6dSjjtuk/gwJ4iMdKErlwAp0hoYgxxi1HMbKo4Uw/RQ52ieQZ87HrfcEPgBFoBYR84au5ffW5YSYOEoFTm/g45Nz0tW0tJVy/uRU8Ofqea0Kdmo3KQWLugLwHBNQ/TCmCz2jAF9EQKsapzjebHNClvth0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dk10KbK8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dk10KbK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761137757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agmGfZLcCAQsl7JXQisFrg8u4h/rd1PShHvnrkyj1c8=;
	b=Dk10KbK8YdsID3HRDcCxlrGhW9xrMbtrYIup99qtVGpLFlSB6gz9ozt+3/seAoYcqvwtAS
	L4N9hHgXVx8Fm4yBvMevvfBe1aRIhnRXOY3N4IxtRCQhQv7FxR6oyLQWzijGXSeu4xkFLi
	U+eEdd0m3i9w1KKeYk+TuNGJrWcvKVg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-lOgZi2_JPTiHiXaQm32vPg-1; Wed, 22 Oct 2025 08:55:56 -0400
X-MC-Unique: lOgZi2_JPTiHiXaQm32vPg-1
X-Mimecast-MFC-AGG-ID: lOgZi2_JPTiHiXaQm32vPg_1761137755
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-783bceedeb8so56342417b3.3
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 05:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137755; x=1761742555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agmGfZLcCAQsl7JXQisFrg8u4h/rd1PShHvnrkyj1c8=;
        b=bkysVr0N6w8KPo23f/xPaez4mgDHQK7w1L+MYxLcl0gpYhVb7iwehMxY6oPavi+hwQ
         QVRqsZfDGsnWZGkndOP+oxxaVHqhvRjUAO7nBF1noToKQiHXQeaQISaj0baGUT2iV2tc
         EW9WpU1cbG7e9CiEDxk2v+wTW+6IDiJCa82zaaNeWXKk6l/9mRT2m4TdrCElSmwJADlb
         +9Wmxmy9FQpZDQUqgh2WKSdotam4ukkgy1Fz2z2raF8C4YuwIucdATUrwQJ71ILkn5Kz
         WkKPseMx9lQyAz/gkpHchUG2ch5yW6bl0ticCLUwsxZ+QIpv6UefNeIj83ubLxvXmGVU
         77Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWwHCrMlizMvRtvZbS1yLQXFiDws6pLMpb2JR74i3bYVrN78HxZGVYKlgCBhcw8Cx9x88h0HbtEPE8Rh4vV2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQpginXfrGBeMBQLjjn1zys9rYCzgTRu8NRjmm/Lk+vT5V8Twe
	cuf9facZ4vIDOV1wEY58eShFenw42mjVVLqwzL8qBxjg4hCvVVKI7APFc7FxC4ioVqLAjB/pUVj
	8+V3jRJyo24mfLUQ7H3XVUSrc1dDrdwqDwETSzWZe2F00zmIbLQNqWjWIGn5gOAMUzzZuARJGvD
	uFQpmp/DHRcpUcpXaqPg+WI6ShLvz6Tl+02IoR5UCBTD8=
X-Gm-Gg: ASbGncuoZJzO4KSxzaBsDsWq6Kg00Pm7zCXcmkNJGyP66w3uDx+dZuRq8GFOF7q9Kbd
	WERiAa4qRzFb6BqysWpNAQ7dX9GOB1dLyWgzPGAaFk52hyUn1d0tgQvTzyMWw+A5L7ZXtOgKvm9
	g1IV1LoxaXewq8t3/IAlozeMHN2GHxGmia6V0STUVmYRmVHD3P/p3NIeiRTGsaO7httJ8aJXmx6
	S5Hkv8ej4iPQPoFbJnDhWskwl140sNamc8niqlIowtIiRt/EIXoKGX0aKYzX0NcT7RhRLWirA4L
	hqI=
X-Received: by 2002:a05:690e:1598:10b0:63d:bfd0:5031 with SMTP id 956f58d0204a3-63e16191e4amr13783820d50.39.1761137755402;
        Wed, 22 Oct 2025 05:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBThLL/CDEifOBjmgpwLAX6oowmGdmpckH0U0YYgejlBayo5T+YJPbfD4MrrYiIYTzwBSSG3y9DhXU8dQQH+M=
X-Received: by 2002:a05:690e:1598:10b0:63d:bfd0:5031 with SMTP id
 956f58d0204a3-63e16191e4amr13783801d50.39.1761137755003; Wed, 22 Oct 2025
 05:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org> <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org> <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251022073231-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 22 Oct 2025 14:55:18 +0200
X-Gm-Features: AS18NWAUH_f342K_ZMx6R3lW2cujGDSAHLzCd_wu_8uGgqhEaiKKLDFfVlyNY4Y
Message-ID: <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JcBb6F9zng5Ow6CX6dvl_XWWtGSIrt72P49NmM1a_fg_1761137755
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wrote:
> > Let me switch to MQ as I think it illustrates the point better.
> >
> > IIUC the workflow:
> > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > b) VDUSE CVQ sends ok to the virtio-net driver
> > c) VDUSE CVQ sends the command to the VDUSE device
> > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET 1
> > e) VDUSE CVQ sends ok to the virtio-net driver
> >
> > The device didn't process the MQ_VQ_PAIRS_SET 1 command at this point,
> > so it potentially uses the second rx queue. But, by the standard:
> >
> > The device MUST NOT queue packets on receive queues greater than
> > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> > command in a used buffer.
> >
> > So the driver does not expect rx buffers on that queue at all. From
> > the driver's POV, the device is invalid, and it could mark it as
> > broken.
>
> ok intresting. Note that if userspace processes vqs it should process
> cvq too. I don't know what to do in this case yet, I'm going on
> vacation, let me ponder this a bit.
>

Sure.

>
> > And, what's worse, how to handle it if the device now replies with
> > VIRTIO_NET_ERR to the VDUSE CVQ?
>
> this part does not bother me much. break it, probably.
>

To "successfully break it" we should implement NEED_RESET, or would it
work to just stop forwarding messages?

> > > > If we wait for the device to reply, we're in the
> > > > same situation regarding the RTNL.
> > > >
> > > > Now we receive a new state (A, B, E). We haven't sent the (A, B, D)=
,
> > > > so it is good to just replace the (A, B, D) with that. and send it
> > > > when (A, B, C) is completed with either success or failure.
> > > >
> > > > 2) VQ_PAIRS_SET
> > > >
> > > > The driver starts with 1 vq pair. Now the driver sets 3 vq pairs, a=
nd
> > > > the VDUSE CVQ forwards the command. The driver still thinks that it=
 is
> > > > using 1 vq pair. I can store that the driver request was 3, and it =
is
> > > > still in-flight. Now the timeout occurs, so the VDUSE device return=
s
> > > > fail to the driver, and the driver frees the vq regions etc. After
> > > > that, the device now replies OK. The memory that was sent as the ne=
w
> > > > vqs avail ring and descriptor ring now contains garbage, and it cou=
ld
> > > > happen that the device start overriding unrelated memory.
> > > >
> > > > Not even VQ_RESET protects against it as there is still a window
> > > > between the CMD set and the VQ reset.
> > >
> > > Timeouts should be up to userspace. If userspace times out
> > > and then gets confused, kernel is not to blame.
> > >
> > >
> >
> > I meant the virtio-net driver will be confused.
>

