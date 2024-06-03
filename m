Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A771812FF70
	for <virtualization@lists.linux.dev>; Mon,  3 Jun 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426593; cv=none; b=UpVbjKJSWQB6rkq6hi43X11S17DY5El4qiEHCKkG8Hl91vo6s2y7CFGvvtKLUBwT3V81CJf8eoVR9hSOLQg7USTZE1X9yuSsk43oqzV+ukJ5/UvjCOa56L8n6KcB7vk8TM8ysMYO3Rsi01wWNtYrwvnRub1qwLityHJm2UquszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426593; c=relaxed/simple;
	bh=zsunStNizZpH1wJCbjihQBz/Lf2Sb/tdk5WMo5Ik728=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpvW0JrddPSqu2X9lLBVpm2aA0n/UvVgvs2Ng911ggL8TCInDqAmCSvfGW+AeTrLEpKZaEe2jJRqmSogsiN4RuC8O2MLIXGBV5t/1paEibnQ3Rn7ZXX5uDKOTNOtJVMmYKRLMO2aaI8azBWFfduC7Fa8l9fL0FrcEyidereYCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSWidiit; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSWidiit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717426589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cggaNwi/VVDlA3tnNNTmKDDBi+NGhkQ+YrckBWZAHm0=;
	b=jSWidiit8U50q3Wb8CH8RSaSiNaC9xfOBbOPMJOQEPCCsCIidAT3wy54hkSZ2/b2MCjFJK
	a7n5tDSI8scSFCkVxZa7KodOBGlw9DT+0mMKlGkbVBMAZwKinn8PX39qDGmoI54nmUx3/g
	m0xiL/WlWRM/31shAzjfM5HiIE8baRs=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-MniqQzNdPlSJl_f7YV82Sw-1; Mon, 03 Jun 2024 10:56:27 -0400
X-MC-Unique: MniqQzNdPlSJl_f7YV82Sw-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3d1e57e647eso3047078b6e.1
        for <virtualization@lists.linux.dev>; Mon, 03 Jun 2024 07:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717426587; x=1718031387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cggaNwi/VVDlA3tnNNTmKDDBi+NGhkQ+YrckBWZAHm0=;
        b=GkrMY592OKXiIPRMRh5BT46RexaEKwZDzDr+0Q7mGzGVswjXvaRypLWerzcElLfzrt
         QAUnWuRTuAtp2SgoqLR1+RU3EH33QSHZrcPrYPh/gxkhzbeb1eAFFOfZTIjSCtTPOgjl
         upesN6ohfd9BJlq5ypzJqIPhLyfcOsKNkHZmLCGuoXIofF0MQWRhKhOwVTkrSYKN6k0l
         JbrPRsMlAQiMSaWUdISWYhcwvmehcpiHY3J1eBgjTzGVawNvtrWsmQRtV9UCBCD3oB9A
         YzCfeuFs5X0RZRFlOvLJz7ezUOdhYLQkefH84SPFwh2kCbPf0NynCkM9CPINyExjA5MY
         wceg==
X-Forwarded-Encrypted: i=1; AJvYcCXmCOlUiI8+pRV7+TLcp1qZepdpKF0RGGOPRja4Q07FXaMU11jhSn1IY3/1lCs4hczK0A9sXVu24XBjOI39BQpawYWJ5iXh3yqZ2iUTGKA=
X-Gm-Message-State: AOJu0Yz0aRx5/kgzVZ88A4XWZ+ZK7oEN9fi9URkPeKkBOPNisXFgTDuN
	t0tLOqKQno421IWAkAGA4EFEsGZ+VthQ96j3HqMYj+Ph5Mri6hvwwq8sqDbKkQIuK4qc4X4Phs4
	63BoVnmRewjmFZOp0sGTk5/KwWbZn/8cKaiLb8Te7quYCAaopKvUz4EyEetvDiO2E5isKvf+9wE
	dnDUGUAK4t+oQxFF/ZLDdYPn367eXVtZndtCj1gAE=
X-Received: by 2002:a05:6870:46a8:b0:24f:e6a4:9921 with SMTP id 586e51a60fabf-2508b827dedmr9787753fac.5.1717426587062;
        Mon, 03 Jun 2024 07:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/0baeTvo+mJQQjjuzQxRuwduq1k+gHDXHx300/tOtI0jM2UY0ltHW1JkmIEqDdZ9PIrecdy7zBJEB3paijE8=
X-Received: by 2002:a05:6870:46a8:b0:24f:e6a4:9921 with SMTP id
 586e51a60fabf-2508b827dedmr9787732fac.5.1717426586649; Mon, 03 Jun 2024
 07:56:26 -0700 (PDT)
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
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 3 Jun 2024 16:56:14 +0200
Message-ID: <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Peter-Jan Gootzen <pgootzen@nvidia.com>, Idan Zach <izach@nvidia.com>, 
	Yoray Zack <yorayz@nvidia.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Parav Pandit <parav@nvidia.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Eliav Bar-Ilan <eliavb@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, 
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>, Oren Duer <oren@nvidia.com>, 
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 3:44=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
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

How about something like this:

 - by default fall back to no translation for backward compatibility
 - server may request matching by sending its own arch identifier in
fuse_init_in
 - client sends back its arch identifier in fuse_init_out
 - client also sends back a flag indicating whether it will transform
to canonical or not

This means the client does not have to implement translation for every
architecture, only ones which are frequently used as guest.  The
server may opt to implement its own translation if it's lacking in the
client, or it can just fail.

We need to look at all the requests, if there are some other constants
that need to be transformed.

As for ioctl, the client cannot promise to transform everything, since
most are not interpreted by the kernel.  Ones which are, should be
transformed.

Thanks,
Miklos

