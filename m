Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB52798EC
	for <virtualization@lists.linux-foundation.org>; Thu, 15 May 2025 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289182; cv=none; b=WeEvWbFAdXpD1zjI9YrzTuwhLqdvm2ph29Q5gxjC1q9YdCJoM8feX7PdpB8bdtVCM+FrRAOOWQRFH1JdczXCienVBLuADt4Y1RhY3VJN+3S1DqsfGXtTlgC+4YScrsXjjMQN7NUWWSK782Ba0Bq3tsNtjIB53Zdl9MelwFALSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289182; c=relaxed/simple;
	bh=KgjVcgr/14LclEpcLsxeXxOySrceHDQLswBb2FensOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzxs0Y2NzmVsG1+8DKTU+e4O7qRN8g6uslj+EPaPu1cUOkUXuzx/oJtJVMyCVVctxmdzEEjI70sW10xcnhasrdbqZ/ZGs5DzZjAPyglslRlVX5VTeb9g8veCE81Wtn1FGJERkZxTKSDXXkGKkJmaXGas7GPxWMpIunMsclDrNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1U5PUoH; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1U5PUoH"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73ED983546
	for <virtualization@lists.linux-foundation.org>; Thu, 15 May 2025 06:06:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gjSxKXZSkIgy for <virtualization@lists.linux-foundation.org>;
 Thu, 15 May 2025 06:06:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1333783268
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1333783268
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U1U5PUoH
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1333783268
	for <virtualization@lists.linux-foundation.org>; Thu, 15 May 2025 06:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747289176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KgjVcgr/14LclEpcLsxeXxOySrceHDQLswBb2FensOs=;
	b=U1U5PUoH0bbeCkGohQfTVctokYS2Q2ih832eZZTaGgUGlNBJkiYsGjTf0CsEdXMAtD7jng
	iDY1N2RqLVE51WgbC5I7uVLHPkl/7ArDE35B9cmqOLy8HbNsiUgNvQ0f0eMc+OVeHApEsa
	smzDkb85ERCp00gQvGq2J8gl0G3mED8=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-rCK0sSxLPNmv7Zn1wx-Uqw-1; Thu, 15 May 2025 02:06:15 -0400
X-MC-Unique: rCK0sSxLPNmv7Zn1wx-Uqw-1
X-Mimecast-MFC-AGG-ID: rCK0sSxLPNmv7Zn1wx-Uqw_1747289175
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-52c463ada00so126099e0c.0
        for <virtualization@lists.linux-foundation.org>; Wed, 14 May 2025 23:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747289175; x=1747893975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgjVcgr/14LclEpcLsxeXxOySrceHDQLswBb2FensOs=;
        b=JW03T0oElK86A5miUMeVsjZySYtV61GCFUVNmbkypzC3Z7rKjC9YQ2Quu3vzFi+24m
         ysSA6SWS2tF4NHBTg6rstKcTsZgYEQTdy9jPJjKxpqjhOEsEVg4JsRF/6xHsdH3iIXsi
         DQ43UWbkASuqeUqafjU7YmMpDp1UKBimblmgtAYd/b7zxc1r5Z2d2FrUQr0DAqfAGAN8
         3FVMH/MeMztB1BWwQSNkvwtTAyKlzUVoFMYSUOiYjiS1Pxn25XCG/CieqkhM5LgCbVVM
         4OXeqJ7NGV1IIBJEcn7BlljaIeI7VO5B13o16s5Ph+Sgh5rHoylllC4F42qTM3e5mRWi
         D+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS5PYA/RL7adCY8tOfyu+Xd43MejPTtW7sw9L2tS+OXfdQ/gTJDiAUjyNANOkd6AYE9Lo/N14xyhXjp1VAzw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzhCrpxyPKox9umNx3Hxl5SRC1sMYyutiKhAZna7jP/CqzQVEmk
	eehBZ3nvBZWbWMApndPMFw5IZ7PiaU1osa55ctgbOKrb78DPX1TqT9IKVDreZCqiO6o6x7Owj2m
	c8aAxXkQWmjpUdTLtj5HcUkhIbaQ8awdu1ioWoihK/fGnKN3bld+R1y5cV+JdSbdUUMWiTgieOW
	wsxvZxoSTDupROhyBRyVXI91jAKWqOo99jB3ODYNvQBZ6a3+CxNRGsTw==
X-Gm-Gg: ASbGnctNHFu2CnMOGRX31ZySGx7lE2hiuOk8WSeTtNqDpwRdUUN6eOiTKrrbDpaaRDI
	2GbOWXzHHZ7nKsVw00DHtpVE2v1zwx85JSrbPVJYdQLO5yRJsX7rtk9WaxHobUaShbAN8Kg==
X-Received: by 2002:a05:6102:3e26:b0:4d7:11d1:c24e with SMTP id ada2fe7eead31-4df7ddd4266mr6046456137.21.1747289174763;
        Wed, 14 May 2025 23:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIP+CRMt7SY3lS0FZeE06/dgVCIbatM2gkAuNCY5+ReAryTvEEPpoJydTxKcT2SH/Us6iz+8kk5C0x0X/14DY=
X-Received: by 2002:a05:6102:3e26:b0:4d7:11d1:c24e with SMTP id
 ada2fe7eead31-4df7ddd4266mr6046447137.21.1747289174433; Wed, 14 May 2025
 23:06:14 -0700 (PDT)
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
 <20250513030744-mutt-send-email-mst@kernel.org> <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
In-Reply-To: <CACGkMEtm75uu0SyEdhRjUGfbhGF4o=X1VT7t7_SK+uge=CzkFQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 15 May 2025 14:05:37 +0800
X-Gm-Features: AX0GCFsXKSChOXDfZIrQa40yvOWdPl0wYiICvr05EheIP_f5Oktdl93IFH2XEdk
Message-ID: <CACLfguVGmQ3FzhheCfe55m+SG-kvNXsJ-YopkiBAyLCvkp81dw@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K4I6YRvFL5JyLBFPFdj-RqfwIN2kfymWcKeCjyOkOnI_1747289175
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the comments; I will prepare a new patch version.

Thanks,
Cindy


On Wed, May 14, 2025 at 10:53=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, May 13, 2025 at 3:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Tue, May 13, 2025 at 12:08:51PM +0800, Jason Wang wrote:
> > > On Wed, Apr 30, 2025 at 5:27=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Apr 30, 2025 at 11:34:49AM +0800, Jason Wang wrote:
> > > > > On Tue, Apr 29, 2025 at 6:56=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > > > > > > On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jasowa=
ng@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@r=
edhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_O=
WNER_IOCTL`,
> > > > > > > > > > to control the availability of the `VHOST_FORK_FROM_OWN=
ER` ioctl.
> > > > > > > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, =
the ioctl
> > > > > > > > > > is disabled, and any attempt to use it will result in f=
ailure.
> > > > > > > > >
> > > > > > > > > I think we need to describe why the default value was cho=
sen to be false.
> > > > > > > > >
> > > > > > > > > What's more, should we document the implications here?
> > > > > > > > >
> > > > > > > > > inherit_owner was set to false: this means "legacy" users=
pace may
> > > > > > > >
> > > > > > > > I meant "true" actually.
> > > > > > >
> > > > > > > MIchael, I'd expect inherit_owner to be false. Otherwise lega=
cy
> > > > > > > applications need to be modified in order to get the behaviou=
r
> > > > > > > recovered which is an impossible taks.
> > > > > > >
> > > > > > > Any idea on this?
> > > > > > >
> > > > > > > Thanks
> > > >
> > > > So, let's say we had a modparam? Enough for this customer?
> > > > WDYT?
> > >
> > > Just to make sure I understand the proposal.
> > >
> > > Did you mean a module parameter like "inherit_owner_by_default"? I
> > > think it would be fine if we make it false by default.
> > >
> > > Thanks
> >
> > I think we should keep it true by default, changing the default
> > risks regressing what we already fixes.
>
> I think it's not a regression since it comes since the day vhost is
> introduced. To my understanding the real regression is the user space
> noticeable behaviour changes introduced by vhost thread.
>
> > The specific customer can
> > flip the modparam and be happy.
>
> If you stick to the false as default, I'm fine.
>
> Thanks
>
> >
> > > >
> > > > --
> > > > MST
> > > >
> >
>

