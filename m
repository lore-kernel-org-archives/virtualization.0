Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D01E89C
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053256; cv=none; b=p16HF2bGB7MzAweUw1RJ3ubchbztdNNd4XJW2p4/OfzMst4RYz9vgkjxzfO/AzzK6BA3mVK2fY6s2MW4cElU4vltrlDBPYF+2OqiXJByK7DiRDIFiSspvVVsxnid6zatmL1dgqT7m6kxlp6QCMZ6t3TQFvjFokHwD/XJoMN9yBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053256; c=relaxed/simple;
	bh=2ggk4xKNT1+ApWslBESqk6gxPnsQn/QMZUTvnCEi7Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=paDbFuOkpTr42kiKcsEdpji7gcr9wZwIaAHhBVxFPTK7SnY8ZzXUFH8A/pLzzSu4PvY4lHv4klPAqIeu+8OyCyAlVptLceZYvXnE5si6t5rt3aUNr10cQuoBe/Ch32CsiQHdG3QoSaWa0cYtiHnRVk06zQoGV/r/ZqsMDXaepIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S66b7f0w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S66b7f0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721053253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGLpZ7NtdE3uPAqBXwBuMmagy4eF2zWRhZi0SMbEUAI=;
	b=S66b7f0w0QazATo/2QPOZ/e1h9PXlEi1aqjYfpgQbpXQSk1Oi86pvvjUjgb5yXO/haBqDj
	w6QM6zBHbZNFbOOH8EskmAKcs/MZfuwBNhTZxIXmELue+16X9wiFt/lQaOCMbTKucM3GYW
	UfdenSJcupOliufX1Ys5hMz8guTzDPU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-Qyt4hTVWM1-fUmhTeAbrDw-1; Mon, 15 Jul 2024 10:20:51 -0400
X-MC-Unique: Qyt4hTVWM1-fUmhTeAbrDw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-426d316a96cso31360195e9.0
        for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 07:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053251; x=1721658051;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGLpZ7NtdE3uPAqBXwBuMmagy4eF2zWRhZi0SMbEUAI=;
        b=gp138o9DdWyL2WGEWbdSAT6defl4051pUK01uDRr6+rEn0m7UWObkDoLwpBfkVRUXn
         oerqdJmNGTtwDwWmTY/+ChQto3+igKoxGHqM0T/lnIDH9qqWyxn4g2r//RcQsEtxhN32
         g2s2m/pm8yWKeVjKp9X6pUps+CMC9u7JOBl5pOWMfVwoshJRrQOCBMndyXhy/xuydi6d
         T/6mOh3LR07YUWHZo3vqWrJqqctDVCH9lVrhiL58nZsvVEAKwWnP9uktGqupaOABYJmI
         xYyvO1aJcgTiD4T7LHJRHEJ2swEuJHB72ONlgz4qw9d8kwzqeIPN5mZjYQQ/wLedaQna
         QQlw==
X-Forwarded-Encrypted: i=1; AJvYcCVFv7kfumET5wh/vdRvM8+Bh30hz75VKTEbMyJuHeq/vhNZ1Vn06aHEZriyuVv0Ira+7jWw6KjKceudg0yp/ZptAzC5hVe6n17JkKwkmUo=
X-Gm-Message-State: AOJu0YyRPnmHCFGHNmSPM8atBFV/2nBlgoN6CH/aBMjEjOozci3zmVsE
	v2+qFo166z/2nqHUQjVXbJjouvK6qNwAMy0wSrnKp/o6Y3CmWuoE1lDLa+iXzvjE4sIc56I66hy
	KErLhCl/TSJBhif0OVSuQNDi5N7oArgWTk+9JM6vh0ziNdWRUMBpe+kXGyTE/ISF2
X-Received: by 2002:a05:600c:4c8a:b0:426:6e93:4ad0 with SMTP id 5b1f17b1804b1-426707d7977mr137011605e9.17.1721053250824;
        Mon, 15 Jul 2024 07:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtzMonv2giNTKuuYLslBsaEfDAbwb6kfSAxK7UmMoIWvkNWt8Iovsi6qjRPZDAJ7ktwgA6qQ==
X-Received: by 2002:a05:600c:4c8a:b0:426:6e93:4ad0 with SMTP id 5b1f17b1804b1-426707d7977mr137011385e9.17.1721053250224;
        Mon, 15 Jul 2024 07:20:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:243:da88:7ff9:68fc:2f43:bcdf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafb99fsm6537872f8f.84.2024.07.15.07.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:20:49 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:20:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Potapenko <glider@google.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [PATCH] virtio_ring: fix KMSAN error for premapped mode
Message-ID: <20240715102018-mutt-send-email-mst@kernel.org>
References: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtZWJJ1TxnbDLio28M1_0mUZmDd_HbQrZOVB9ixKoLbMQ@mail.gmail.com>
 <CAG_fn=Xe+XQROUqZ9zy94BXVj8SRKprW3fUj_0rD3AhSAvtn-w@mail.gmail.com>
 <20240624095629-mutt-send-email-mst@kernel.org>
 <CAG_fn=VwB_EepsY7GcMM2ihz77vtWDR3tsxJ6iD0Sdx-wQVx+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAG_fn=VwB_EepsY7GcMM2ihz77vtWDR3tsxJ6iD0Sdx-wQVx+g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 15, 2024 at 03:24:17PM +0200, Alexander Potapenko wrote:
> On Mon, Jun 24, 2024 at 3:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 24, 2024 at 03:51:50PM +0200, Alexander Potapenko wrote:
> > > On Fri, Jun 7, 2024 at 8:34 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, Jun 6, 2024 at 7:13 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > >
> > > > > Add kmsan for virtqueue_dma_map_single_attrs to fix:
> > > > >
> > > > > BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
> > > > >  receive_buf+0x45ca/0x6990
> > > > >  virtnet_poll+0x17e0/0x3130
> > > > >  net_rx_action+0x832/0x26e0
> > > > >  handle_softirqs+0x330/0x10f0
> > > > >  [...]
> > > > >
> > > > > Uninit was created at:
> > > > >  __alloc_pages_noprof+0x62a/0xe60
> > > > >  alloc_pages_noprof+0x392/0x830
> > > > >  skb_page_frag_refill+0x21a/0x5c0
> > > > >  virtnet_rq_alloc+0x50/0x1500
> > > > >  try_fill_recv+0x372/0x54c0
> > > > >  virtnet_open+0x210/0xbe0
> > > > >  __dev_open+0x56e/0x920
> > > > >  __dev_change_flags+0x39c/0x2000
> > > > >  dev_change_flags+0xaa/0x200
> > > > >  do_setlink+0x197a/0x7420
> > > > >  rtnl_setlink+0x77c/0x860
> > > > >  [...]
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Tested-by: Alexander Potapenko <glider@google.com>
> > > >
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Jason, Michael, any chance this patch can make it to 6.10?
> > > The bug in question has essentially been blocking KMSAN on syzbot for
> > > the past month:
> > > https://syzkaller.appspot.com/bug?id=2819883f3d376b703e686e700fde00a01eec62fa
> > >
> > > The patch should probably have
> > >   Fixes: b6253b4e21939 ("virtio_ring: introduce dma map api for virtqueue")
> > >
> > > , but I am not exactly sure why syzkaller only started triggering the
> > > bug this year, given that the patch dates back to 2023.
> >
> > Yes that's probably a good idea. I will queue it with this tag.
> 
> Hi Michael,
> 
> Looks like the patch is still stuck in the limbo :(

It should be in linux next. Don't you see it there?


