Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E95E556
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059602; cv=none; b=rINeCJdPQ5qA/NnLsg7e0BC4FBkz8pBA0qOBXBx5Rah2z0IwNaBnHoNBIECToYjHWBu2WDeH6+PyOMjUPfhFdLC45sQl5ZFTZW0ngtfEowlT79Bz72UJ1/9aNT2euykBVKZCYL7ySWSoqUMc8VFYJ5HELSjTc44NtC3sucuSzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059602; c=relaxed/simple;
	bh=nVJErrZ//1r4XL6T+FXabMaKJmvrVSEn+GA2yva9hEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YtpzLTBl16PURhezMSxw+KG5hXXaPHy/wgqpMdilBSTfzuVGvQAFBq6QZHp4IPIuyNH5kqlvnCh6LvTQOXLA+vXW0tHvlnwLpSJALQIKt4jamPaBKuHqioJUjYGjw8Ol8dctZTDi2tK2VPbUojhtg85ZipiZlKGP3tPSBGK39YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKVMH0H/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKVMH0H/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721059599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mn15R8rtXfVFJKMERfdjiCQjtLwKw0bzDlM9jNSz4Oo=;
	b=SKVMH0H/1tzoi2N4+JjI2E96Fg4oVugRVJHTjSru0Kq2WyvH5dZxR+m2DQb+HZ5DX9g7d7
	ReCsvK2JoIV2Lf98pE691eARTOEb1gxrj0Wes5CeRUUaaFt+11ppXrQSakmpNn0Sw9EpsG
	qAqSB4tbaLZ0yTvWS/JigPdC5b/x/lI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-SiMqCBbKNsG9erzmj4m9Mw-1; Mon, 15 Jul 2024 12:06:38 -0400
X-MC-Unique: SiMqCBbKNsG9erzmj4m9Mw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42668857c38so33224795e9.1
        for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 09:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721059597; x=1721664397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn15R8rtXfVFJKMERfdjiCQjtLwKw0bzDlM9jNSz4Oo=;
        b=KnhjjRPrSOk38zDDuFj35eDu9v5hbw2CoRCdG0WmW4nKVNrM74e1oVPWud7t7bh12k
         kCO/CqloO98aZM8DKIgJYpgaUsQS4k2w900jAJXzQovVWWf/rI7gH3tSVoUgxHBQPZvR
         BHMfZ6ibeui1uTElGxaavyotOM5KdTZilHGODbvDdDsKZgr2AfuSKbQPUfyBvg/JIlw5
         kRTeq7mU0B14KJpWLf5mX3DqhJ1V3IGk+2F+AGF30MZfzVFi2i0vZ2qscJxQZMc9rp46
         ey/WfJlMAXunv9mafHtfiM+qVijO/pjU4np5ZTsUE7Bckt8ojtzHk70XiypXOuWr9nEy
         8w7A==
X-Forwarded-Encrypted: i=1; AJvYcCU4Fj1NPvhSN/5KJW62OUGEsLP0p+9qopaly7jmuZvJ0oXfOm4RZqe29hpnz3mYO7NimI27wHu4MprVNYegPPvy6gkAb4wpG5gLRhxWkP0=
X-Gm-Message-State: AOJu0YxKUzt3i8sG/4KVBDy++2tIolTWV8xUAoZYbNaK/Jklfu/hINNT
	ITy7Iaqucg8ctP5ASuTkOgJx2RyhZukdv0SJrlFjYgfayUtgoJ4rbA2Pn5dTq/KZoCdefQKeZVi
	fmarr6Usjm01baWbr9fijNGXFdE1RwDFqg/yqjRNkv9hW62MNbjhHtYOYd7x1eWDU
X-Received: by 2002:a05:600c:450a:b0:425:69b7:3361 with SMTP id 5b1f17b1804b1-427b88a3acemr647265e9.18.1721059596944;
        Mon, 15 Jul 2024 09:06:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKz6I7/eIwPn0Sv/69tDmZkyqzoKkhMHuA4FZ7v+hZy6NReYklWjAycvV/CFd3+nXr/vsISA==
X-Received: by 2002:a05:600c:450a:b0:425:69b7:3361 with SMTP id 5b1f17b1804b1-427b88a3acemr647075e9.18.1721059596389;
        Mon, 15 Jul 2024 09:06:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:243:da88:7ff9:68fc:2f43:bcdf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3b2bsm6774227f8f.20.2024.07.15.09.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 09:06:35 -0700 (PDT)
Date: Mon, 15 Jul 2024 12:06:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Potapenko <glider@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [PATCH] virtio_ring: fix KMSAN error for premapped mode
Message-ID: <20240715120606-mutt-send-email-mst@kernel.org>
References: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtZWJJ1TxnbDLio28M1_0mUZmDd_HbQrZOVB9ixKoLbMQ@mail.gmail.com>
 <CAG_fn=Xe+XQROUqZ9zy94BXVj8SRKprW3fUj_0rD3AhSAvtn-w@mail.gmail.com>
 <20240624095629-mutt-send-email-mst@kernel.org>
 <CAG_fn=VwB_EepsY7GcMM2ihz77vtWDR3tsxJ6iD0Sdx-wQVx+g@mail.gmail.com>
 <20240715102018-mutt-send-email-mst@kernel.org>
 <090a8152eab55555b23b1a7605520567ce0bffa3.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <090a8152eab55555b23b1a7605520567ce0bffa3.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 15, 2024 at 05:30:49PM +0200, Ilya Leoshkevich wrote:
> On Mon, 2024-07-15 at 10:20 -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 15, 2024 at 03:24:17PM +0200, Alexander Potapenko wrote:
> > > On Mon, Jun 24, 2024 at 3:57 PM Michael S. Tsirkin <mst@redhat.com>
> > > wrote:
> > > > 
> > > > On Mon, Jun 24, 2024 at 03:51:50PM +0200, Alexander Potapenko
> > > > wrote:
> > > > > On Fri, Jun 7, 2024 at 8:34 AM Jason Wang <jasowang@redhat.com>
> > > > > wrote:
> > > > > > 
> > > > > > On Thu, Jun 6, 2024 at 7:13 PM Xuan Zhuo
> > > > > > <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > > 
> > > > > > > Add kmsan for virtqueue_dma_map_single_attrs to fix:
> > > > > > > 
> > > > > > > BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
> > > > > > >  receive_buf+0x45ca/0x6990
> > > > > > >  virtnet_poll+0x17e0/0x3130
> > > > > > >  net_rx_action+0x832/0x26e0
> > > > > > >  handle_softirqs+0x330/0x10f0
> > > > > > >  [...]
> > > > > > > 
> > > > > > > Uninit was created at:
> > > > > > >  __alloc_pages_noprof+0x62a/0xe60
> > > > > > >  alloc_pages_noprof+0x392/0x830
> > > > > > >  skb_page_frag_refill+0x21a/0x5c0
> > > > > > >  virtnet_rq_alloc+0x50/0x1500
> > > > > > >  try_fill_recv+0x372/0x54c0
> > > > > > >  virtnet_open+0x210/0xbe0
> > > > > > >  __dev_open+0x56e/0x920
> > > > > > >  __dev_change_flags+0x39c/0x2000
> > > > > > >  dev_change_flags+0xaa/0x200
> > > > > > >  do_setlink+0x197a/0x7420
> > > > > > >  rtnl_setlink+0x77c/0x860
> > > > > > >  [...]
> > > > > > > 
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > Tested-by: Alexander Potapenko <glider@google.com>
> > > > > > 
> > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > 
> > > > > Jason, Michael, any chance this patch can make it to 6.10?
> > > > > The bug in question has essentially been blocking KMSAN on
> > > > > syzbot for
> > > > > the past month:
> > > > > https://syzkaller.appspot.com/bug?id=2819883f3d376b703e686e700fde00a01eec62fa
> > > > > 
> > > > > The patch should probably have
> > > > >   Fixes: b6253b4e21939 ("virtio_ring: introduce dma map api for
> > > > > virtqueue")
> > > > > 
> > > > > , but I am not exactly sure why syzkaller only started
> > > > > triggering the
> > > > > bug this year, given that the patch dates back to 2023.
> > > > 
> > > > Yes that's probably a good idea. I will queue it with this tag.
> > > 
> > > Hi Michael,
> > > 
> > > Looks like the patch is still stuck in the limbo :(
> > 
> > It should be in linux next. Don't you see it there?
> 
> FWIW I ran linux-next with KMSAN today and this fix was already there.
> 
> But in the meantime another similarly looking issue crept in:
> 
> https://lore.kernel.org/netdev/20240712195759.GA2972562@myrica/T/

I remember picking up that fix for next, too. Not there?
Not at the testing box right now.

-- 
MST

