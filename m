Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B744C86
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809977; cv=none; b=tlwrDtOHGZsoEimFSYvpog/hx9LXyTFmnWqmrgwzmX8m356a5hHRHL8114ExdgG0TG3m1fT07YuWFVlwugos/n9xJaU0XebQ6Ny/6U8a5eEZqEdsdoWwJK9KF1yYO/Fgmg39OIXsrT92wtAroqM9TWh2OP7oq0frU2VEwyro9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809977; c=relaxed/simple;
	bh=CRar9WZIfyaGhyQ5AaPWKz0Q/05MgwL6ZvuPnpv6hGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MItqLv9L+gNbW/HPfccPCYmd9Fw7UE9RIievD0L1nhlmJ4VNRTBIefMtR0e2nZpnFsH+EqoNpJMIkO/S1jevEH7QI+mMr/fcVKiermdgmZyCyahA5q/K4H1xIZD7wPb2nBn+swv/+2KAIwV/DdjBGGT5ORhQU2SUEgvhNXzdH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KV2gQsyH; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KV2gQsyH"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FF80608D5
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 01:52:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qhZOhw2IM-zw for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Aug 2024 01:52:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 614AD608CA
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 614AD608CA
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KV2gQsyH
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 614AD608CA
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 01:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724809973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWve6JE+0NypiSakiytBRnv/JlBTqmmXFs55kVgYTbU=;
	b=KV2gQsyHztuuMIxEV1Uc5N8wNpTTr9mZzAXQ/O3aZTqhAdiqVloWEU7VRNFi1+/X+oZ1+K
	lC51kFTnr3N/cyOHyxgYZtRm6soFHrApYI4Id5HcZYfqNyTryIbozo8//KUkTgdedAotgc
	85sNCv2XJG1eGQOW6Cska5E/bNTs4eY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-BI0h5LEnPgyYm-CXez00qQ-1; Tue, 27 Aug 2024 21:52:52 -0400
X-MC-Unique: BI0h5LEnPgyYm-CXez00qQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d3c0088813so6319811a91.1
        for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 18:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724809971; x=1725414771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWve6JE+0NypiSakiytBRnv/JlBTqmmXFs55kVgYTbU=;
        b=jcYkPM5lDPnSU1z3WrshedTOLpn0dP3DqFOaw9mFAtDrfCmBvAQgU3VDmpDDdnEEHW
         meNTmFfT4Yu5TZhtBcKduHVFlhelNRs8e7/mc2x6F57LnN5TXxlynsavbfCqbucMLrrB
         JELvw1AsO0S9dFVZbYor7G5ibQ+K+cAjJWHqZY8GH8zod3V0RN2mInpYIjHDmbMXf6+E
         +51foVNeScKrHwVJDx6NCuWagVRjR6FXprW15cPpasnQjVFJ8ZxEdT+4LjgMquHd2rgm
         Mb+Ik2+08hpVRsE2oafEayCEWfWGmLSQcSnDjnVunWIDUzuQL6pz8apNxNYH5AeWHkS8
         mLsA==
X-Forwarded-Encrypted: i=1; AJvYcCVumTwA5t/BPuAzZm9+2Pi2mSTqtQ6vu55KRIIxB1xShlDdvVgM+Kty5Wc6SWej7Vzc2FkTFY8Shq0NMtCyCw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyyNakfKAQR3WDfZcLeCnxW3rMssIUXLdvLv0ifL5Qtn1wV4ue2
	ZeL80fNRqsMamw6zCYDosvdKjxOzK0N4FEaF5yy1FVs3aDg/a3VX6c180oimJzlGq2osCWD0MAV
	l8UTmTNbdypTV1ilaIyvVi0t8MFjuKH5iRps41/3qfaMui30d8HrMKNMYiKPK6ZrFiSANl/g84K
	RuUdy+WuYiUEHEVMGBMMdIVWlXGqdv12zfF7JNjrA2SUB6N0AXX7j5dQ==
X-Received: by 2002:a17:90a:ea98:b0:2d3:cb10:ca20 with SMTP id 98e67ed59e1d1-2d8441dd433mr574479a91.42.1724809971167;
        Tue, 27 Aug 2024 18:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2WaxTQnck0F64/2Byf20IaMxKhRaCFgCZwbA5SnsjM2N5t2pQkjRTImPTJ5eVtBvKRqTzoXEmmHP+0WAM8Is=
X-Received: by 2002:a17:90a:ea98:b0:2d3:cb10:ca20 with SMTP id
 98e67ed59e1d1-2d8441dd433mr574455a91.42.1724809970678; Tue, 27 Aug 2024
 18:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
 <afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com> <fd8ad1d9-81a0-4155-abf5-627ef08afa9e@lunn.ch>
 <24dbecec-d114-4150-87df-33dfbacaec54@nvidia.com> <CACGkMEsKSUs77biUTF14vENM+AfrLUOHMVe4nitd9CQ-obXuCA@mail.gmail.com>
 <f7479a55-9eee-4dec-8e09-ca01fa933112@nvidia.com>
In-Reply-To: <f7479a55-9eee-4dec-8e09-ca01fa933112@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Aug 2024 09:52:39 +0800
Message-ID: <CACGkMEvUeHTKu8+=sPLz-ddr3xb7dD29bwNex=xvyRdK1gBrgw@mail.gmail.com>
Subject: Re: [RFC] Why is set_config not supported in mlx5_vnet?
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Carlos Bilbao <cbilbao@digitalocean.com>, mst@redhat.com, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com, 
	sashal@kernel.org, yuehaibing@huawei.com, steven.sistare@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:55=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
>
>
> On 27.08.24 04:03, Jason Wang wrote:
> > On Tue, Aug 27, 2024 at 12:11=E2=80=AFAM Dragos Tatulea <dtatulea@nvidi=
a.com> wrote:
> >>
> >>
> >> On 26.08.24 16:24, Andrew Lunn wrote:
> >>> On Mon, Aug 26, 2024 at 11:06:09AM +0200, Dragos Tatulea wrote:
> >>>>
> >>>>
> >>>> On 23.08.24 18:54, Carlos Bilbao wrote:
> >>>>> Hello,
> >>>>>
> >>>>> I'm debugging my vDPA setup, and when using ioctl to retrieve the
> >>>>> configuration, I noticed that it's running in half duplex mode:
> >>>>>
> >>>>> Configuration data (24 bytes):
> >>>>>   MAC address: (Mac address)
> >>>>>   Status: 0x0001
> >>>>>   Max virtqueue pairs: 8
> >>>>>   MTU: 1500
> >>>>>   Speed: 0 Mb
> >>>>>   Duplex: Half Duplex
> >>>>>   RSS max key size: 0
> >>>>>   RSS max indirection table length: 0
> >>>>>   Supported hash types: 0x00000000
> >>>>>
> >>>>> I believe this might be contributing to the underperformance of vDP=
A.
> >>>> mlx5_vdpa vDPA devicess currently do not support the VIRTIO_NET_F_SP=
EED_DUPLEX
> >>>> feature which reports speed and duplex. You can check the state on t=
he
> >>>> PF.
> >>>
> >>> Then it should probably report DUPLEX_UNKNOWN.
> >>>
> >>> The speed of 0 also suggests SPEED_UNKNOWN is not being returned. So
> >>> this just looks buggy in general.
> >>>
> >> The virtio spec doesn't mention what those values should be when
> >> VIRTIO_NET_F_SPEED_DUPLEX is not supported.
> >>
> >> Jason, should vdpa_dev_net_config_fill() initialize the speed/duplex
> >> fields to SPEED/DUPLEX_UNKNOWN instead of 0?
> >
> > Spec said
> >
> > """
> > The following two fields, speed and duplex, only exist if
> > VIRTIO_NET_F_SPEED_DUPLEX is set.
> > """
> >
> > So my understanding is that it is undefined behaviour, and those
> > fields seems useless before feature negotiation. For safety, it might
> > be better to initialize them as UNKOWN.
> >
> After a closer look my statement doesn't make sense: the device will copy
> the virtio_net_config bytes on top.
>
> The solution is to initialize these fields to UNKNOWN in the driver. Will=
 send
> a patch to fix this.
>

For "driver", I guess you meant virtio-net?

Thanks

> Thanks,
> Dragos
>

