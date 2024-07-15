Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4351850B4
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049900; cv=none; b=lJsAosEzmTCPuKTB1Jz9S3xkfFoP9zNLTyT1mAHAUmYUpgW/HXNN2FNtARW0HfLec8x/RiohZPvx1Alsc5G3gp1xNv9OkRab4j8Az1xC23uCGfTixSJRIBHOwQKgCbHYPKb356e5f/241TMSqrfHPRU8w27f7r3QXAubzdNhZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049900; c=relaxed/simple;
	bh=xk1pKpDrrJ4ME8nxWcd3e0eG7YK54L7cSIG2cINo52g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INiUvblE/AYKQmVCpF6iv6Wm8EFdWzn05b3cncPpJXMWkeuXBIuXmxKcDgBjqo4F5ij6du/JmPygdTkXjKqIkUVvV8d8a3vvmQmc58sNtn3xEJLzKbnUddKSieFYbG2m034N2CCtR6srbZJhK+q6KVjAisPDYAgKy3OuJXlh2xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJxjmwFD; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJxjmwFD"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b7734055d1so6123256d6.3
        for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721049898; x=1721654698; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7opJP8hZLo8A1Yz8YsvF6o/Qh3jQFX7aKd0c0LvybYo=;
        b=DJxjmwFDI8BM/ZERyYAy2Ph2BpvoOPWo4Ha8Zsx+JTl33ivbQ9Lk1GBdkIwgRSuvX5
         1apwujLb+Dh5aJeB9US2wW46jI9v7CZKIDPbnACx4cUV9n86l/QqY/obGv5fIBMmRhta
         MRrIDaSSq/ISJtP8mrHwjj+Ck7t2ex4ra4548GeH3Ow6x4rj403fCX6nhXpFHlfjfeT0
         MaHFxwuGP5BuQYAJyj8xyfNcZhheo6GweweAVNeOq9h7KfdpnZwQPdptd8ug3hu0+w9D
         nIBR/qlbIMGWCzMahJAFfnQO9UKUdyvwpRy6EVenAYEG1EBXlsTCZsnRYNljr4HTKm94
         S1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721049898; x=1721654698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7opJP8hZLo8A1Yz8YsvF6o/Qh3jQFX7aKd0c0LvybYo=;
        b=nx5Fhpug3wlhX5jZ7crabeCpyjNscH3L3JAJiD+d4RmXNfdkTXkyFOaU4QXW3XBBL7
         oxs10ETeqJLOL+ovWT+n3z5VZ6679qYPnBi0GlYeLVYaWBCr9J7YaD9xKK5k8+nkNpnK
         hOKRMHCuntHl+t2hhWRsuZ80lITXSBkGxRCYPP9O5AtQ7dmwaM+eF2ELRte7l2mRQSss
         ZGLaEp0DVHehfCbt8qtdUvjl0VJVIsBiCGJXCWFuly2//idBkArTYVBXP5Ygnt+KDm3+
         eLHYdFqXadebMo4JS1e29CQbJWeZ3TXlJQc+KBDYF9hlt6mp1T0ZRwtW3j4rmXzsucp1
         s/tg==
X-Forwarded-Encrypted: i=1; AJvYcCXke7vm7hERvcXWW+F5EcLTsli1aIBCWjL3o5QKe6uYE997GeSgJZ32vVoJftbAUc82Rb9BdaBqKNafjd/SbP5sI2u+YEtve7nMgi2sJrY=
X-Gm-Message-State: AOJu0YxYtE71DffYsrjqTeeoDr/ttWFOZbhz1axYyidRATcZ4UHRQTa1
	VHbpVzsX2jwcLP+/yKH/UKL+lK+iv2o/8p+YxERjJAtr8JrQxlpZ+JFG+WJ5+/5kD6YycwzBHIj
	LRrG3qTwGxwRmgPUx8Ss4KdNXZdx9ZtisUZpb
X-Google-Smtp-Source: AGHT+IFZYSfVrrrIO/5GSmnwoYYAwtFi16mDYrOGQA6Hf2wtpPbsxn0gn31sgtzjIkkCrqNNhziX282QCcdh0ckTb/8=
X-Received: by 2002:a05:6214:21e7:b0:6b5:7f56:e50a with SMTP id
 6a1803df08f44-6b61bf30075mr234321716d6.35.1721049897711; Mon, 15 Jul 2024
 06:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtZWJJ1TxnbDLio28M1_0mUZmDd_HbQrZOVB9ixKoLbMQ@mail.gmail.com>
 <CAG_fn=Xe+XQROUqZ9zy94BXVj8SRKprW3fUj_0rD3AhSAvtn-w@mail.gmail.com> <20240624095629-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240624095629-mutt-send-email-mst@kernel.org>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 15 Jul 2024 15:24:17 +0200
Message-ID: <CAG_fn=VwB_EepsY7GcMM2ihz77vtWDR3tsxJ6iD0Sdx-wQVx+g@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: fix KMSAN error for premapped mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 3:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jun 24, 2024 at 03:51:50PM +0200, Alexander Potapenko wrote:
> > On Fri, Jun 7, 2024 at 8:34=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Thu, Jun 6, 2024 at 7:13=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > > >
> > > > Add kmsan for virtqueue_dma_map_single_attrs to fix:
> > > >
> > > > BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
> > > >  receive_buf+0x45ca/0x6990
> > > >  virtnet_poll+0x17e0/0x3130
> > > >  net_rx_action+0x832/0x26e0
> > > >  handle_softirqs+0x330/0x10f0
> > > >  [...]
> > > >
> > > > Uninit was created at:
> > > >  __alloc_pages_noprof+0x62a/0xe60
> > > >  alloc_pages_noprof+0x392/0x830
> > > >  skb_page_frag_refill+0x21a/0x5c0
> > > >  virtnet_rq_alloc+0x50/0x1500
> > > >  try_fill_recv+0x372/0x54c0
> > > >  virtnet_open+0x210/0xbe0
> > > >  __dev_open+0x56e/0x920
> > > >  __dev_change_flags+0x39c/0x2000
> > > >  dev_change_flags+0xaa/0x200
> > > >  do_setlink+0x197a/0x7420
> > > >  rtnl_setlink+0x77c/0x860
> > > >  [...]
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Tested-by: Alexander Potapenko <glider@google.com>
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > Jason, Michael, any chance this patch can make it to 6.10?
> > The bug in question has essentially been blocking KMSAN on syzbot for
> > the past month:
> > https://syzkaller.appspot.com/bug?id=3D2819883f3d376b703e686e700fde00a0=
1eec62fa
> >
> > The patch should probably have
> >   Fixes: b6253b4e21939 ("virtio_ring: introduce dma map api for virtque=
ue")
> >
> > , but I am not exactly sure why syzkaller only started triggering the
> > bug this year, given that the patch dates back to 2023.
>
> Yes that's probably a good idea. I will queue it with this tag.

Hi Michael,

Looks like the patch is still stuck in the limbo :(
