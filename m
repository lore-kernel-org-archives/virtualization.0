Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC5D10A1F
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724724261; cv=none; b=q3LdNqLYm/sSsjLP/Y53UeRpCtj4KzjwWdW7QgZUZzY6WEQ+Cx9D51bz30xnlbu7qby2QYBCgRqV7zlld1tt3yCxGSFCsus3X9delCqHzZ12LwQB2rDH93/GeDQxeFoBUS5WhLRQmT92Yia88ZVchs+sUn+5Vj+CbU8hnd86V/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724724261; c=relaxed/simple;
	bh=swaa5zYl6o+vIR+x0tmOoO5wF06p/pSj7OJ8IiW3bAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cb+JpnU9op+z+yDsmkr/vA+HFVNvqFWHzQPojCSwMZG/JyJiqzIAROBIaZiPOhsKOhpXw/xa7DiBLFddO+sIkU/SxM/8k0cQ1+GmFQsUywML1330J49KEzZ1WONfeDvsQunJwcb9gs97+7AlyIyYsC0m8dTgCADp9aIy8z5CYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Id1wfntd; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Id1wfntd"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5C4D40167
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uC2bj3fTp7Uf for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Aug 2024 02:04:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9D3B5400D7
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D3B5400D7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Id1wfntd
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9D3B5400D7
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724724256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xm6HzpS7UlYIAXiVXt9nj1Lc28PYtI0g7QjUz7c0dEA=;
	b=Id1wfntdQL6ZyLX1TzBEuv6GGKymnjLMmUoWppcTp8byA4XSSGfWg+rJMCjCZ5eBEL2JCI
	Nt3kud7eq2ZQYE8RFwewQVh5q7BGQnI34gjgkeL8guYqQX+g5WXIai52E4N0Ze/sTqKw0/
	u0vxKglKlJrDfYsp9SzSfc0ELqQ/6zs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-1Cn4zFKcObGDn_3xsgDH1w-1; Mon, 26 Aug 2024 22:04:15 -0400
X-MC-Unique: 1Cn4zFKcObGDn_3xsgDH1w-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d3c0088813so5084097a91.1
        for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 19:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724724254; x=1725329054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm6HzpS7UlYIAXiVXt9nj1Lc28PYtI0g7QjUz7c0dEA=;
        b=s8arEcQThJjbp58Y9jDroZvxyyS8K/Sgtx0sZmv8rA5rmcExgDceukyauIhXKRWUTb
         r4fTUX9bEejnpsdBz5sdrtt8MStK3PSa310hmNgQvygvfWgJjTC52XDoAS5ZfrVIcpUF
         K1uSEtS6HtWb5CI5GqeQ8GfENtY2cRxq9PNnktXXKiPRn+Qbk4fohrarkYHz8qfrXOdi
         5s1vo7/OgZ56JJ1KAhYuxG7mwKPkO4wAs/E+F1lfKKQ6opGY6QDlPGiD0xpnRYEBXxEW
         DsuPSPVUPLWlGKYOwaM2Ufo556zqd9IR46mIfE0YhnoZhA+0tROHfn1bQUb5eC8XFfZ9
         gmtA==
X-Forwarded-Encrypted: i=1; AJvYcCUM+LAq+fv74PoXluJQCnxUJcjNVo6vZ/5vfOt1pgFI4LRNNxq2j8hrQSlMH+Od2ehZCzlBKGJ7IwsO52yJ9Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz3G/NGL67dAKdmLbMvjEoGhtYN25ycUPIu25nHPd0PKFMr2BmX
	rSe6k5ExezLJ4OLOkmETKelbeSd1QhX4Qr1qWzC22NoBeZ6gKF3Nmu2IpnheF8rHq6YocM/b06w
	jtNeWe7g7ppwP4uo27IfvoigsOq3xCkm8NXpgVecym+BB+X2NniyPlll1rWq5qlhGgedfCPfi+l
	yiK1WWfhHYTnS+EPCyZxGpkb3l0hnJKxIdWQ89rJvXpfb+qMCCXVh9ZQ==
X-Received: by 2002:a17:90b:4a46:b0:2d3:ce76:4af2 with SMTP id 98e67ed59e1d1-2d8258125d5mr1626211a91.18.1724724254163;
        Mon, 26 Aug 2024 19:04:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtAMqps7U0xYEX+Wmp+vbiju0Pr+o74vzRd/75xZsN+NnAH2VQA/vUI9rjXQkYWiSphld5fdo8Pn1F56iVa1c=
X-Received: by 2002:a17:90b:4a46:b0:2d3:ce76:4af2 with SMTP id
 98e67ed59e1d1-2d8258125d5mr1626181a91.18.1724724253585; Mon, 26 Aug 2024
 19:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
 <afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com> <fd8ad1d9-81a0-4155-abf5-627ef08afa9e@lunn.ch>
 <24dbecec-d114-4150-87df-33dfbacaec54@nvidia.com>
In-Reply-To: <24dbecec-d114-4150-87df-33dfbacaec54@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 10:03:59 +0800
Message-ID: <CACGkMEsKSUs77biUTF14vENM+AfrLUOHMVe4nitd9CQ-obXuCA@mail.gmail.com>
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

On Tue, Aug 27, 2024 at 12:11=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
>
> On 26.08.24 16:24, Andrew Lunn wrote:
> > On Mon, Aug 26, 2024 at 11:06:09AM +0200, Dragos Tatulea wrote:
> >>
> >>
> >> On 23.08.24 18:54, Carlos Bilbao wrote:
> >>> Hello,
> >>>
> >>> I'm debugging my vDPA setup, and when using ioctl to retrieve the
> >>> configuration, I noticed that it's running in half duplex mode:
> >>>
> >>> Configuration data (24 bytes):
> >>>   MAC address: (Mac address)
> >>>   Status: 0x0001
> >>>   Max virtqueue pairs: 8
> >>>   MTU: 1500
> >>>   Speed: 0 Mb
> >>>   Duplex: Half Duplex
> >>>   RSS max key size: 0
> >>>   RSS max indirection table length: 0
> >>>   Supported hash types: 0x00000000
> >>>
> >>> I believe this might be contributing to the underperformance of vDPA.
> >> mlx5_vdpa vDPA devicess currently do not support the VIRTIO_NET_F_SPEE=
D_DUPLEX
> >> feature which reports speed and duplex. You can check the state on the
> >> PF.
> >
> > Then it should probably report DUPLEX_UNKNOWN.
> >
> > The speed of 0 also suggests SPEED_UNKNOWN is not being returned. So
> > this just looks buggy in general.
> >
> The virtio spec doesn't mention what those values should be when
> VIRTIO_NET_F_SPEED_DUPLEX is not supported.
>
> Jason, should vdpa_dev_net_config_fill() initialize the speed/duplex
> fields to SPEED/DUPLEX_UNKNOWN instead of 0?

Spec said

"""
The following two fields, speed and duplex, only exist if
VIRTIO_NET_F_SPEED_DUPLEX is set.
"""

So my understanding is that it is undefined behaviour, and those
fields seems useless before feature negotiation. For safety, it might
be better to initialize them as UNKOWN.

Thanks


>
> Thanks,
> Dragos
>

