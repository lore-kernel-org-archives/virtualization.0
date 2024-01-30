Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03449376EB
	for <virtualization@lists.linux.dev>; Tue, 30 Jan 2024 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584826; cv=none; b=CZX3C5/y1ITZ9NQgngqWr2BTS1kBtkdD4DjU3mwbrZ8IwZ9CyUHueVToF5OkJvhiB9I2ydRnZntxhawMH/q77bNaoGhaEqliyWkLufPXN7J4qEC9cR4toBYsX02w9/i0Jj9hHTmy7WR4t+/CdCLQu+yCkkMyA60OWKaLGblp8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584826; c=relaxed/simple;
	bh=d9WP4hd/Fgxj42lnIKM1zOhi36+ZV09aVbpyPYfs59I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFreCBtmgcqxMwV71mi+N43bmWX871p1Bmw5xuDYid5uq+RvHmn/ovVgrz947/po3vfEcSPuJ92z3l6V9hgVY1o0eaJ7VoDrrkWoMtxZB/6Lbco7xF+/5/mn04j8W/d5GqUwpckuRxqG1JFvo5pClvz8iHWotyucD2JOBO2bKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5ChalmO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5ChalmO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706584824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9WP4hd/Fgxj42lnIKM1zOhi36+ZV09aVbpyPYfs59I=;
	b=J5ChalmOheO/JWEFdCKNhtk5aQsMsRPGxeL6E5Gfz1lgokBKUAC24/V7F+r5bWoxFJ9CCU
	s/pbIzhzYR4edV8N0nELTXO2kBFP0sR8qGDx1VDinxFGA9BQerDUzhf/iL47HGWkWG55TB
	Im+i2pUFDR+vTKxX/btRKLcKSYIWj5Y=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-9ZXYkx1FMLGUFgacdRaynQ-1; Mon, 29 Jan 2024 22:20:22 -0500
X-MC-Unique: 9ZXYkx1FMLGUFgacdRaynQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3be95c215baso225028b6e.0
        for <virtualization@lists.linux.dev>; Mon, 29 Jan 2024 19:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706584822; x=1707189622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9WP4hd/Fgxj42lnIKM1zOhi36+ZV09aVbpyPYfs59I=;
        b=DrIShhxnFd95YTK8Tqw6iWSCLosGupQOeG17V3FUO+tJn4J6v0NBPf6MBaqSwOvuHt
         YpP44R9Up5aX/Yv6/bVLKj5fLKiyWZph0C6Ih4+LS/+SF0fr4ishWwOnfeHR4V4M4Nyn
         7+MmzOBRb54s1LXtdmK3a3IoE+JKkEvaaT1gdqEQ5LtYSFqfN0TWnUqFtykYHjt5iG6U
         xO4Cmf+CL648TR+y3/3YnglMy8+Kw/YZ2nxda5P/LVakRaxNtsVnSVF2u9G6PLb0iJIy
         Ii5k3u0JWUnu1KM+uGdijNyzHlwzetV1cRZPm2yb2b6B/Ht6kJ4IJfj09iDl8qRzh/yd
         WXTw==
X-Gm-Message-State: AOJu0Yx8Cgte0iGw5ODI7X7NrCISEVh3a1+4x1LfzYtDzE68Yt+e2qL2
	yTh3oytv/vc9/u9m8VI3bhk5DCmTG5YZvIsoOPfRrX/0o4SstQrPakfKjxzzCeLNzeEtHGXOMEl
	3cQO5YpBHWgqvIATZfI68aEUwD90355ufzB15si6pEqDPptgaFFsPlTDeBhc7WL8gZd41AuRZOt
	JmRxxvtXUlXRCFaqKeHGo/iE+KyDLYUwv+3ulBP5Q=
X-Received: by 2002:a05:6808:1154:b0:3bd:c08d:91f6 with SMTP id u20-20020a056808115400b003bdc08d91f6mr8998038oiu.29.1706584822080;
        Mon, 29 Jan 2024 19:20:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuZW0m1kap/LxF2wEFM1hvLV2SMn42n3fITC1r2n7f5Wmal4bhgCfEoA8SCfS1utE4NY7HHhgI/uSaJBfNbvo=
X-Received: by 2002:a05:6808:1154:b0:3bd:c08d:91f6 with SMTP id
 u20-20020a056808115400b003bdc08d91f6mr8998027oiu.29.1706584821857; Mon, 29
 Jan 2024 19:20:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231226073103.116153-1-xuanzhuo@linux.alibaba.com> <1705384540.169184-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1705384540.169184-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jan 2024 11:20:10 +0800
Message-ID: <CACGkMEsOs5L6eU==Vym_AkomvhhkHN0O_G9SaPFThAtH9XVyJQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/6] virtio-net: support device stats
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, Zhu Yanjun <yanjun.zhu@linux.dev>, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 1:56=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 26 Dec 2023 15:30:57 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote:
> > As the spec:
> >
> > https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bb=
bd243291ab0064f82
> >
> > The virtio net supports to get device stats.
>
> Hi Jason,
>
> Any comments for this?
>
> Thanks
>

I see comments from both Simon and Michael, let's try to address them
and I will review v2.

Does this sound good to you?

Thanks

