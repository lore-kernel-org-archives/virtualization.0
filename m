Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917DF3A1AC
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872203; cv=none; b=MJRQlZ552WHIRZgSBe2uAOuy2RjZBV96Y7pyeUBMGNxtpXrsSLGnrKUshv4Ft/TQi2x2Z23K9HOAsxO6WhrwLQqCv1XF+HsvoBl19+v8AfenSBU8qRu03soQUGCfaF6ava1v0cIVdVuFprUonwclyHC+5n4u1ERUfFcnL+SoP/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872203; c=relaxed/simple;
	bh=JGZFuJ1BGCs5lhhVARlia/ZbTK9I2R+6a7gVuPvH+es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cV/OScm8+RZ1sACAxDxugyS0w7AQ0QukVwyEcwijg+kzqiDdHwFnyPZky7mO7vnvIgnb+MFc68IWauuUCVej00fIiT6Ap9ZXDfP2cK1jWBrgXInWVvZ5n7iHsMahdYwJE7uFRCNMCnkEy1AzccbxQP5DEhQP8ESvCvJwSVkAu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIm/quM2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIm/quM2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718872200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGZFuJ1BGCs5lhhVARlia/ZbTK9I2R+6a7gVuPvH+es=;
	b=AIm/quM29Jw/4Y5N6KIXS+ke5HWLzt5dJr9Vfgw7HamK+QTrlDvkeqQaTUlWK/QQRPZQ1L
	ripAl1tDnJgUld1RGthWUwZQO4DWEYt7K8Odqz6TIsQ4lbtjPwLQBUmObj7AvTYoTM3Lz8
	Ny2hDeajcjHLXcQ9wleDFGCZ4II5LEE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-eALtEy5SMI6NG5XNh-fqTw-1; Thu, 20 Jun 2024 04:29:56 -0400
X-MC-Unique: eALtEy5SMI6NG5XNh-fqTw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-66c3eace6efso753455a12.2
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 01:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872196; x=1719476996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGZFuJ1BGCs5lhhVARlia/ZbTK9I2R+6a7gVuPvH+es=;
        b=pjy7bXRncn0bJuTqs3eNxaVpis8jWfK30v/9geVTgRDuOYqYrqHKv1zttlFAlp7pRD
         VwJ+Q3gA8L+wqhFTHGsp/koN6t8ikCzBDaxE1MqPGiJ4rTIqT2Cone8754nJqueQ0qIr
         Nm15I9We6DReGMEimQqs5UpwVjZlwsS5pl4jqrO6Gqh8uWPJMlWMt1X7KnqS23Iy/zTC
         USlh/jwYNh/8hfXYmFQTpZhqwMkDxxEjYL0Nx7jDpA70g6VDu/2nYrb74dkE6zzgrzJF
         RAZKBIgVYmeWza0dAcvgq6trdyIe7kmW1Xj1yE12O38gNTFFAO6rAkl6d/8CY29jUE0Q
         ggXA==
X-Forwarded-Encrypted: i=1; AJvYcCUKnScC6sqrVUS8CloDMo3n5G4mwO8bo1beM1wweFBFOV20q1m4zjayY1VtDjBK6QoFemDIYIq1baJ7L1F0aS5OeuIrCc+PkUW9AkHFMNQ=
X-Gm-Message-State: AOJu0Yx98Nvqyo/3la/QOCm0wQSqwqZzpmagX0UNEJSDQ5J2oU0LuxoF
	qur7H90G4VFJPmqmr8VJdkpDkjz76f3x6vKy8FnO4QZoyWY3/BL2tj2Yw+7kN+T4lUvV5W/E2c2
	U4xXXzUQrd636H3IKGsB/50jOiMpOMehjUGdHTcgv/6jgW0LLBYl4GHKJVKHY01triIOzEP/AOz
	nRliIWuPQiQQzCKkYo5AmIOav92+aFnvslQlbD9sY=
X-Received: by 2002:a05:6a20:ba08:b0:1b4:f581:23e1 with SMTP id adf61e73a8af0-1bcbb14da2dmr4345360637.0.1718872195908;
        Thu, 20 Jun 2024 01:29:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF85/UJY37FatqbRbzaKijLCbd6FNTx+yAG3Qno4IThT0VNKeJXp8HH5a+WWVuJ6oGKz1acfzDBjAi/BBBmMvU=
X-Received: by 2002:a05:6a20:ba08:b0:1b4:f581:23e1 with SMTP id
 adf61e73a8af0-1bcbb14da2dmr4345341637.0.1718872195524; Thu, 20 Jun 2024
 01:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
 <20240617131524.63662-2-hengqi@linux.alibaba.com> <CACGkMEvDUcVmaT1dBoWnFx0CO5kH+HYp9je5bJ1dFR1+EEdyWA@mail.gmail.com>
 <1718680142.7236671-11-hengqi@linux.alibaba.com> <20240618181516.7d22421e@kernel.org>
 <1718762578.3916998-2-hengqi@linux.alibaba.com> <20240619080802.07acb5ac@kernel.org>
 <c4b2d4a9-2fe4-4822-a5ab-57d1bb98f0b8@linux.alibaba.com>
In-Reply-To: <c4b2d4a9-2fe4-4822-a5ab-57d1bb98f0b8@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 16:29:44 +0800
Message-ID: <CACGkMEsf-5mA-C+2=Qjm6C=QpBrWOooxOMGHgE=rowYZKB=4SQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_net: checksum offloading handling fix
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Thomas Huth <thuth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:44=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
>
> =E5=9C=A8 2024/6/19 =E4=B8=8B=E5=8D=8811:08, Jakub Kicinski =E5=86=99=E9=
=81=93:
> > On Wed, 19 Jun 2024 10:02:58 +0800 Heng Qi wrote:
> >>>> Currently we do not allow RXCUSM to be disabled.
> >>> You don't have to disable checksuming in the device.
> >> Yes, it is up to the device itself to decide whether to validate check=
sum.
> >> What I mean is that we don't allow users to disable the driver's
> >> NETIF_F_RXCSUM flag.
> > I understand. What I'm suggesting is that you send a follow up patch
> > that allows it.

Exactly my point as well.

>
> OK, will do it.
>
> Thanks.

Thanks

>
>

