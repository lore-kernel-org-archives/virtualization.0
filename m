Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E691E9B06
	for <virtualization@lists.linux-foundation.org>; Wed, 14 May 2025 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747191198; cv=none; b=O0zq3jEuC+yhvzsqAeKfiyizsVyFkzi/NnF8Ltny9Osfk+5flNK/J/zws4ec7V7BHiVycOpt4JONjlWhtxUHoOnNKWXunOLwiZA83feMJGkw8AWuDi8egTrgv15QOztIp7zaINxbyUrz7192D1lsFbxjsfMFEKA/+yNNRSk7vDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747191198; c=relaxed/simple;
	bh=xYePPpPHItj0zqjq4MOZdgAxeW4nYpts1pf20lbhHIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jl/ucX3YdVIDL9lfnOCqt5pPv/NSAJFx8xQB6xSXhod5PO5HZpI53OBPwL6AdALYoe7PSR1ZMy1bTt2n1l4Af+jxobEuQXyISOVxNBAUApLyfMMV8MtjoLkM8Qac54HZKG0L3Yh7e//zR6oPc7rQ9tuVDbWLE4dUxGLicfYMrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKljr2X0; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKljr2X0"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DC0581E0F
	for <virtualization@lists.linux-foundation.org>; Wed, 14 May 2025 02:53:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T4zT7QqpXPNR for <virtualization@lists.linux-foundation.org>;
 Wed, 14 May 2025 02:53:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 801C88125E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 801C88125E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gKljr2X0
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 801C88125E
	for <virtualization@lists.linux-foundation.org>; Wed, 14 May 2025 02:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747191192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYePPpPHItj0zqjq4MOZdgAxeW4nYpts1pf20lbhHIE=;
	b=gKljr2X05hpo2MZUkwvznELECYemO2XSW9nT4xj/lBN+rp3aqGH0DcGSYIvnd4ja1w+eD0
	IRzDMvVaqgP68AiWPEHx3l/7b74O60u0TgNeWXIqmTYq9McINSpuzMkg9b6VqckiTQe6EI
	DqE68A7/0TtetMpOelAlgiIbfKf0SUQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-FyNctiEGPAuhNasQ8LNq7A-1; Tue, 13 May 2025 22:53:11 -0400
X-MC-Unique: FyNctiEGPAuhNasQ8LNq7A-1
X-Mimecast-MFC-AGG-ID: FyNctiEGPAuhNasQ8LNq7A_1747191190
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7410079c4a6so4297889b3a.3
        for <virtualization@lists.linux-foundation.org>; Tue, 13 May 2025 19:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747191190; x=1747795990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYePPpPHItj0zqjq4MOZdgAxeW4nYpts1pf20lbhHIE=;
        b=cLNlBtjM7bu7uGecV+KjiHlQOvGVkQawrg2CiZkFZSA+NSFnPkq7OMZnijwVMOiC9q
         x5ZA8rusQNWNiTVCOaiBs9Fi26iWD5FgOctzVI86BnL8sqOQTITOh3iiiN7rS+QxCEb1
         uBVVMYDrUuTrZGE002ZauNiQ6cx0P96WbzSpYqLWjd8voz/hSyCt68aGJuqXlHB9yuqD
         l3a7lAdAToPFTQKvF5vTLK4guoQP5CpDwlxY6ZtJT2RFKM5+gYdsubFUIKkshOPJynfC
         QpNKse6OE9f3bxw5u0tuA0LjJTwAc01BSfNnYjkhk4wocLVaPA1z7YVk6cYK75zdXIWh
         fonA==
X-Forwarded-Encrypted: i=1; AJvYcCXhNHJAnYZpGhLKIdPFF2xEhLHA5c5axBI9loxUzekR8Bo2XP2KklDxjyR9fSexyzwzZ9Kw4jDXzhtVLlSBaA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx3Zd6/NZQX2W41EdGE890tzgf/SX6kdQt66Vdsqz4LDUHXeW8A
	/7889C8snX9GTibcJD+KM8UTwSuVQfU3LxYqwdBeZlf9vBQuLAssSEPws1T/ekNoJooz279Ab4N
	yodrtVREWJu4RrZoRoMKjHsN6jtzTlB1psf5KO/jiTmndF0hGq5PGaa1x5swiY5JU2+VPeLnami
	D7AQZKofZ7QXsV3lIXo7cltFZs+vLmNvYqhOrQ0Rm/YcKOU1OL4/tgmg==
X-Gm-Gg: ASbGncvfNBksk8bzmiLQpABhKSCAUvHa39BLY+hJJQho7RmHGtp4gi3vhiAu5r19pjk
	4ym8RMyA89gjMotfaFpsdL83Ve4Z3BXQ8LFg8AZxO1p8+E0+Iz54GtIqzxmqjVoLQyNkn
X-Received: by 2002:a05:6a20:914e:b0:1f5:591b:4f7a with SMTP id adf61e73a8af0-215ff1b7394mr2148407637.38.1747191190489;
        Tue, 13 May 2025 19:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2O008aj4wY4jbfsuG0wQx0LXJQV1rEC9uHaXpFHGz1hfmWDBVT1BMyztM8wnp7Gb2O/DG75zfCtDsXFNVRAs=
X-Received: by 2002:a05:6a20:914e:b0:1f5:591b:4f7a with SMTP id
 adf61e73a8af0-215ff1b7394mr2148385637.38.1747191190148; Tue, 13 May 2025
 19:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
 <20250429065044-mutt-send-email-mst@kernel.org> <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
 <20250430052424-mutt-send-email-mst@kernel.org> <CACGkMEub28qBCe4Mw13Q5r-VX4771tBZ1zG=YVuty0VBi2UeWg@mail.gmail.com>
 <20250513030744-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250513030744-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 May 2025 10:52:58 +0800
X-Gm-Features: AX0GCFtQFTgm4lfPZmx2Tv2n376ohKx-feV8h7AANGb3bjp34mVypcbh1YB90e0
Message-ID: <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LUCm94XddSQfmSyN-sRFWt44F9mzzep_1mO3uFIkH5c_1747191190
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 3:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> > On Wed, Apr 30, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > > On Tue, Apr 29, 2025 at 6:56=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > > > On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@red=
hat.com> wrote:
> > > > > > > > >
> > > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWN=
ER_IOCTL`,
> > > > > > > > > to control the availability of the `VHOST_FORK_FROM_OWNER=
` ioctl.
> > > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, th=
e ioctl
> > > > > > > > > is disabled, and any attempt to use it will result in fai=
lure.
> > > > > > > >
> > > > > > > > I think we need to describe why the default value was chose=
n to be false.
> > > > > > > >
> > > > > > > > What's more, should we document the implications here?
> > > > > > > >
> > > > > > > > inherit_owner was set to false: this means "legacy" userspa=
ce may
> > > > > > >
> > > > > > > I meant "true" actually.
> > > > > >
> > > > > > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > > > > > applications need to be modified in order to get the behaviour
> > > > > > recovered which is an impossible taks.
> > > > > >
> > > > > > Any idea on this?
> > > > > >
> > > > > > Thanks
> > >
> > > So, let's say we had a modparam? Enough for this customer?
> > > WDYT?
> >
> > Just to make sure I understand the proposal.
> >
> > Did you mean a module parameter like "inherit_owner_by_default"? I
> > think it would be fine if we make it false by default.
> >
> > Thanks
>
> I think we should keep it true by default, changing the default
> risks regressing what we already fixes.

I think it's not a regression since it comes since the day vhost is
introduced. To my understanding the real regression is the user space
noticeable behaviour changes introduced by vhost thread.

> The specific customer can
> flip the modparam and be happy.

If you stick to the false as default, I'm fine.

Thanks

>
> > >
> > > --
> > > MST
> > >
>

