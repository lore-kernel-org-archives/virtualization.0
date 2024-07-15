Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C971CFB9
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061219; cv=none; b=Wzb/qqbtP4tYkZaCohZDiUV0OUFdo+V2FoAiH9tah/3c5FrrKST6aLFKWG5ZLZlPLs1v/Aw5pqrOsTpPyFfNcnwHTNYTlruM1AoAAEeTNlTfG/jUzPL+10AYhcVyOLf2ZH2HP45On/uWSBcpyLqufgNOxVTuw1btbREMJJ+k2aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061219; c=relaxed/simple;
	bh=QgjsRk9F5uLKhUXKJMWEZ//4VD9D4eTMZrfeZWnzO/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sd0wYsmpyGd5BmVcJ2Okot5FGLzzwWjHt8lqxABMpr8OhE39jNt/LSkXf5aHZSpgelWWZDw4e2IdH74WdI5xhso5DCKbQ5fnGTZEuvrxJ7gv4FK7WD/CpqODOtNcR5h8rGdCX1TwZxMAVcQafO2a9IVifS846ZvdACq1UZiFjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y5Z+qvXl; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5Z+qvXl"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b77402d778so7711856d6.2
        for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 09:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721061216; x=1721666016; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhpE12l/9BhHYCshpfApXR3dtqM/vTsqSWxfzhqxJNs=;
        b=Y5Z+qvXlHx03817LCvbLPfiME3w/0BaTk5Jahl+AiJpPEngtzqsiQbkSgS6ynsduP8
         wb+SWwrYEB4tVkxVLNiL1aTasbuKgnT7YCeA/2+zrBCo8z1wZF4mp+47T2uRAeRBz1EY
         WPttX91VlB1GXqI6tyFxtuOgee6w/RscsCc4OW1X46j9VnC+uguU6NJn5FMnztJJok1y
         TPFBGRyJG2t7m46wmASodYxYsgEIWYysrvN8q9JmV7oKrh5ocGad7beAn7A1/F7+G6Gu
         QYUg/P6TVMK+jsSo62VHJ44AiOHMDi50NbvZkofqiGYszlRnTugkztPXELhfcsuc4IPF
         Pe7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721061216; x=1721666016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhpE12l/9BhHYCshpfApXR3dtqM/vTsqSWxfzhqxJNs=;
        b=uo3zcjxo2CDt6JpCClp2kXCWnNDNhj3FH/lrWbFwKdOVcGp36F+gglkg/jTVlktt+Y
         yk2aHllwm6nsLVv+Irby+ILy4IhA1ka+E1zZUtEJbkkoaq9YTrGey/o2YDstOUYylc/O
         xHrHmyN3blnFIrlUtmGyNXTQ0H+8MN7n4D/XKqRzCQu9AfFYgGCjrXzZyDKk+5bGZC1T
         HKrMifswxIM+w10KSM4UoU17YElO/fFLriK+viiGo2Y1mUKZfX+1uc4LdcI6qzRqqDKY
         TgjxZyXhEs107m5uA2ptLIDT5TgViZXRrJiZ+4GF+IzvWCGEabS/vz7F44rU/Pv5tppo
         nEUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaOZhfEfc7VA/9xN/FAqqrQHltHw8JSLYkxcrwcGYLXdN6bBfI1K6j/XlCZQJxJ2cWsk9y0qL/WbbSblj+uP+D8s40UFjjWtkWfnVXNDY=
X-Gm-Message-State: AOJu0YxRlnCissLjeZAcHmXFl+csTOeXOZyFD4Q5ffxsK3Gk4gpvYddK
	TIDRXlD5BIW+tW0ifjIMdeM5ukvIZZp1m29rAJgJRZYFjlk3Kxq8uLtTtktlEfP51qppJXz5VTP
	UXaGoeJGPUD5oguYzDSjQjJJX6x4QCcEglH1B
X-Google-Smtp-Source: AGHT+IEUfC//nvNFj4yA9pu1aH/bhG3c7F8Y3YA2ihjNK5ZQER9X4SmwQVYqS/lq30S/qH+8MDZdoN+QVV60ngsF0ko=
X-Received: by 2002:a05:6214:29e5:b0:6b0:7a5a:a3f9 with SMTP id
 6a1803df08f44-6b77de6ff1emr3057876d6.22.1721061216351; Mon, 15 Jul 2024
 09:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtZWJJ1TxnbDLio28M1_0mUZmDd_HbQrZOVB9ixKoLbMQ@mail.gmail.com>
 <CAG_fn=Xe+XQROUqZ9zy94BXVj8SRKprW3fUj_0rD3AhSAvtn-w@mail.gmail.com>
 <20240624095629-mutt-send-email-mst@kernel.org> <CAG_fn=VwB_EepsY7GcMM2ihz77vtWDR3tsxJ6iD0Sdx-wQVx+g@mail.gmail.com>
 <20240715102018-mutt-send-email-mst@kernel.org> <090a8152eab55555b23b1a7605520567ce0bffa3.camel@linux.ibm.com>
 <20240715120606-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240715120606-mutt-send-email-mst@kernel.org>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 15 Jul 2024 18:32:52 +0200
Message-ID: <CAG_fn=X4B6PJZpV15M4dAbxSb9euuCYpEr=8yZ0ak1C+bNzo3A@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: fix KMSAN error for premapped mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 6:06=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jul 15, 2024 at 05:30:49PM +0200, Ilya Leoshkevich wrote:
> > On Mon, 2024-07-15 at 10:20 -0400, Michael S. Tsirkin wrote:
> > > On Mon, Jul 15, 2024 at 03:24:17PM +0200, Alexander Potapenko wrote:
> > > > On Mon, Jun 24, 2024 at 3:57=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com>
> > > > wrote:
> > > > >
> > > > > On Mon, Jun 24, 2024 at 03:51:50PM +0200, Alexander Potapenko
> > > > > wrote:
> > > > > > On Fri, Jun 7, 2024 at 8:34=E2=80=AFAM Jason Wang <jasowang@red=
hat.com>
> > > > > > wrote:
> > > > > > >
> > > > > > > On Thu, Jun 6, 2024 at 7:13=E2=80=AFPM Xuan Zhuo
> > > > > > > <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > Add kmsan for virtqueue_dma_map_single_attrs to fix:
> > > > > > > >
> > > > > > > > BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
> > > > > > > >  receive_buf+0x45ca/0x6990
> > > > > > > >  virtnet_poll+0x17e0/0x3130
> > > > > > > >  net_rx_action+0x832/0x26e0
> > > > > > > >  handle_softirqs+0x330/0x10f0
> > > > > > > >  [...]
> > > > > > > >
> > > > > > > > Uninit was created at:
> > > > > > > >  __alloc_pages_noprof+0x62a/0xe60
> > > > > > > >  alloc_pages_noprof+0x392/0x830
> > > > > > > >  skb_page_frag_refill+0x21a/0x5c0
> > > > > > > >  virtnet_rq_alloc+0x50/0x1500
> > > > > > > >  try_fill_recv+0x372/0x54c0
> > > > > > > >  virtnet_open+0x210/0xbe0
> > > > > > > >  __dev_open+0x56e/0x920
> > > > > > > >  __dev_change_flags+0x39c/0x2000
> > > > > > > >  dev_change_flags+0xaa/0x200
> > > > > > > >  do_setlink+0x197a/0x7420
> > > > > > > >  rtnl_setlink+0x77c/0x860
> > > > > > > >  [...]
> > > > > > > >
> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > Tested-by: Alexander Potapenko <glider@google.com>
> > > > > > >
> > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > >
> > > > > > Jason, Michael, any chance this patch can make it to 6.10?
> > > > > > The bug in question has essentially been blocking KMSAN on
> > > > > > syzbot for
> > > > > > the past month:
> > > > > > https://syzkaller.appspot.com/bug?id=3D2819883f3d376b703e686e70=
0fde00a01eec62fa
> > > > > >
> > > > > > The patch should probably have
> > > > > >   Fixes: b6253b4e21939 ("virtio_ring: introduce dma map api for
> > > > > > virtqueue")
> > > > > >
> > > > > > , but I am not exactly sure why syzkaller only started
> > > > > > triggering the
> > > > > > bug this year, given that the patch dates back to 2023.
> > > > >
> > > > > Yes that's probably a good idea. I will queue it with this tag.
> > > >
> > > > Hi Michael,
> > > >
> > > > Looks like the patch is still stuck in the limbo :(
> > >
> > > It should be in linux next. Don't you see it there?

It's there, sorry for the confusion.
However the KMSAN builder doesn't test -next, so it will be down until
the fix(es) reach torvalds/linux.

> > FWIW I ran linux-next with KMSAN today and this fix was already there.
> >
> > But in the meantime another similarly looking issue crept in:
> >
> > https://lore.kernel.org/netdev/20240712195759.GA2972562@myrica/T/
>
> I remember picking up that fix for next, too. Not there?
> Not at the testing box right now.

I don't see the patch referenced by Ilya in linux-next/master either.
