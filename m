Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D62E414
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580768; cv=none; b=c4HugovmyY/7I7z2ZiGu6qNa+bmIzYEpcbqc01yZxVSDRGUfr+4OpHzYuyJHCICHia4NTqdld4lqlZTRC2NdvTmWJnYywAa7ZpBS9WS07mFXpcEhyA2Uz/hukvznsl5fIEwd9EEQfRmn88bpVTqKzrKZ13V05UF6wSfhPdJHcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580768; c=relaxed/simple;
	bh=EYv+drGfxgAVKA3MvkSYy/jUZ5AZKM8QAx68YvyMpMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBcR8BNljvIfMR6Xz/fE1J2/g78TCCgxkbG6XaDfX1/IUfH+el/YQmvLH0KF3RpUpzN9YwpGs3YaLgQu1AUpCftnBIBsEkY50bZ2uZobhRQk2BxPFguPxw9XqDjNe+GgiNiX4e/GBQ/urMT0MPmOZvjYjqFgJG5QrKwQkGRR8dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nf8k41nH; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf8k41nH"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D1AC413A0
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 03:06:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iTBnTX-obg1L for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 03:06:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F022141361
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F022141361
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nf8k41nH
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F022141361
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 03:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720580763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmCQNSPX5//DDrpA1NsAAhVFDFrTcMhRa+zaTiY1dwA=;
	b=Nf8k41nHsncZUbK6YkouU/dWGQXl96LiAG2Vf97Bizb+TPyFceynKNY3hXarTpKESl1o1W
	dmVjzrMTvkM8rh42yEn0WdrpqgjLZesYiRSoozlvQdSCvly0DzrJkdxtzfBmS1PabDLbaS
	53HNuTIbVTYpJjTwS2m4ZeibYQj5b6I=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-ciJOkfqzMfSpQe-0YuJOFw-1; Tue, 09 Jul 2024 23:06:02 -0400
X-MC-Unique: ciJOkfqzMfSpQe-0YuJOFw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-25dfc642fa4so4964199fac.0
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Jul 2024 20:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720580762; x=1721185562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmCQNSPX5//DDrpA1NsAAhVFDFrTcMhRa+zaTiY1dwA=;
        b=Dpm77ldQYP3lsWvzU5bCdVRANpWr8AHxF4Hc+wo1GgO29kmv8TwWqtgYJbFxASOkz5
         c5iK27BkzAvoF+WYUQpV8E5aUH/eQvzTod0LwBSsZNlZTGiOgumI7cJH0Q9TJn9UaXNc
         GKEeA9OHAH65qL+XpPFDrSyWHWDCd6ywUkS4PBAvj0c5xETEs9amkESgWBPOUYB65ZmH
         LH1TADSbaAJ1BzsEBF3sRvZa7lxE2neX0nS7E0b4ffoGISkiZDDqi4fvXN6c6LtrboQW
         T4R7+cTo3gdZ+WoJ87HsBqHVKJMaLz1gvpO0ignNPwTlmTK/TBN8bA5YHJqnowkjJdIe
         piMw==
X-Forwarded-Encrypted: i=1; AJvYcCVaeTI48ARu10Q3VZHXHU2IGoID9iO9BE/QBz01L7rEVGnLgK6jxzY5xgpuIhOfJjKWdJSybfZ5uIKrnZ64xNSgKt0DGbOdKY11JJnhlDt7UtNl9Sbbp7sqLQ==
X-Gm-Message-State: AOJu0YwSJs/nbQv7oaz+hi3IrbYT3F1/ncvBgyMvdzu/QK/E1JrQm1dw
	wflZPbsXbjMbRr4tnq96EXN8irIAMFKqhNMBnLwpsjv2fvob+vgQ5KTGbeR+S3cl/wMkRTS/xuX
	ekVhp2yozmhLx3EIOxXYdd66Qc2mh0LDMHenJEme32IJvBAv+xp9pPGw73aB0VdJb6hDHpc3Ebp
	UEv9o3/3yt56eev7Jhg7rTwO0yuCsUbzgNaR3j8o63NjyHx2FM3brGaA==
X-Received: by 2002:a05:6870:470a:b0:254:7a82:cb28 with SMTP id 586e51a60fabf-25eae9bc1a9mr3539205fac.35.1720580761739;
        Tue, 09 Jul 2024 20:06:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGkCsClUv5KuWRwpjkBgC/upvmj64D87aIsN1C0U4KlwhgMoVY/k1ysamyySaRMmvPvzejsu/eF6WXuQBTCRM=
X-Received: by 2002:a05:6870:470a:b0:254:7a82:cb28 with SMTP id
 586e51a60fabf-25eae9bc1a9mr3539189fac.35.1720580761338; Tue, 09 Jul 2024
 20:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <PH0PR12MB5481AE2FD52AEE1C10411F3DDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACLfguXk4qiw4efRGK4Gw8OZQ_PKw6j+GVQJCVtbyJ+hxOoE0Q@mail.gmail.com> <20240709084109-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240709084109-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 11:05:48 +0800
Message-ID: <CACGkMEtdFgbgrjNDoYfW1B+4BwG8=i9CP5ePiULm2n3837n29w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] vdpa: support set mac address from vdpa tool
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, Parav Pandit <parav@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Leonardo Milleri <lmilleri@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Jul 09, 2024 at 02:19:19PM +0800, Cindy Lu wrote:
> > On Tue, 9 Jul 2024 at 11:59, Parav Pandit <parav@nvidia.com> wrote:
> > >
> > > Hi Cindy,
> > >
> > > > From: Cindy Lu <lulu@redhat.com>
> > > > Sent: Monday, July 8, 2024 12:17 PM
> > > >
> > > > Add support for setting the MAC address using the VDPA tool.
> > > > This feature will allow setting the MAC address using the VDPA tool=
.
> > > > For example, in vdpa_sim_net, the implementation sets the MAC addre=
ss to
> > > > the config space. However, for other drivers, they can implement th=
eir own
> > > > function, not limited to the config space.
> > > >
> > > > Changelog v2
> > > >  - Changed the function name to prevent misunderstanding
> > > >  - Added check for blk device
> > > >  - Addressed the comments
> > > > Changelog v3
> > > >  - Split the function of the net device from vdpa_nl_cmd_dev_attr_s=
et_doit
> > > >  - Add a lock for the network device's dev_set_attr operation
> > > >  - Address the comments
> > > >
> > > > Cindy Lu (2):
> > > >   vdpa: support set mac address from vdpa tool
> > > >   vdpa_sim_net: Add the support of set mac address
> > > >
> > > >  drivers/vdpa/vdpa.c                  | 81 ++++++++++++++++++++++++=
++++
> > > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++-
> > > >  include/linux/vdpa.h                 |  9 ++++
> > > >  include/uapi/linux/vdpa.h            |  1 +
> > > >  4 files changed, 109 insertions(+), 1 deletion(-)
> > > >
> > > > --
> > > > 2.45.0
> > >
> > > Mlx5 device already allows setting the mac and mtu during the vdpa de=
vice creation time.
> > > Once the vdpa device is created, it binds to vdpa bus and other drive=
r vhost_vdpa etc bind to it.
> > > So there was no good reason in the past to support explicit config af=
ter device add complicate the flow for synchronizing this.
> > >
> > > The user who wants a device with new attributes, as well destroy and =
recreate the vdpa device with new desired attributes.
> > >
> > > vdpa_sim_net can also be extended for similar way when adding the vdp=
a device.
> > >
> > > Have you considered using the existing tool and kernel in place since=
 2021?
> > > Such as commit d8ca2fa5be1.
> > >
> > > An example of it is,
> > > $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu=
 9000
> > >
> > Hi Parav
> > Really thanks for your comments. The reason for adding this function
> > is to support Kubevirt.
> > the problem we meet is that kubevirt chooses one random vdpa device
> > from the pool and we don't know which one it going to pick. That means
> > we can't get to know the Mac address before it is created. So we plan
> > to have this function to change the mac address after it is created
> > Thanks
> > cindy
>
> Well you will need to change kubevirt to teach it to set
> mac address, right?

That's the plan. Adding Leonardo.

Thanks

>
> --
> MST
>

