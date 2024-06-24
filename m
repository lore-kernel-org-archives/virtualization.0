Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC261422DE
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237445; cv=none; b=gVyRRbUruztmRIHWFUdfNWl/wp6K+8TywT2w3n0V9K8inYQKpcmRSb7da8GF33mDdOAnk1qDPm+CVZiVtVU1cRUlUnJPCj//z/iWBtJIAaUfPK+vVNYI8fE6bu6fruG/+6JsLIK4CRlvdVYxDrZDbITHnIb1mN74jjRdDaj2Kjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237445; c=relaxed/simple;
	bh=YMHq1113qgM/Z2UbVq2yl6XeeYn661lEtM+Do7llRO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=buOjGZGOTLkaAfrCZAENzuifPZ2K2O0AYdxpq1QaMi/O4fniwlzpQl58vD1KU914Rqde6zNj04VMuUlqPN4XpSTLWqfaQ1EEXG8+/B9IAdAgeCfaVmh+RseyoAMsza8TikGwTMfbKDbIFbg+zsFS0vgPomQ/1UUNRT6q89J0BJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PD2kL/qt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD2kL/qt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719237441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+veyh1/hSAQ9m38oVJlZuUAg/3ZMQue227nUICJwWXA=;
	b=PD2kL/qtHFvIgHFMmATWK/lYxjicBq7yLlhQx8pFoNHoLPFjurr1JmANgmVXN0GvOxKHiU
	IxsxdHO3xPUa5fkGJBrnh234riG0bfVa9L9vaWYzzBIPAtko8xiO20zbCIqyRvxlfoDF2J
	K5QXiQ49ry3Bwn55FD/ZwRBDW3q26UI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-bASbq-RRMwG0YDF50rBwzA-1; Mon, 24 Jun 2024 09:57:19 -0400
X-MC-Unique: bASbq-RRMwG0YDF50rBwzA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6fe56470b3so212333466b.1
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 06:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719237438; x=1719842238;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+veyh1/hSAQ9m38oVJlZuUAg/3ZMQue227nUICJwWXA=;
        b=G7uQ4PfP66j7qshceovrLEFQWQ0lMM40htkq+o4+dnBsIZSpyXZifQlZEXuw7M7rUu
         WQYBo/VjYtGt+y3NfyJZakzHl4Rh+tiXYWxTSsuJ4PHjsUWeuE3gjD9H1Vsh8IQCwWxS
         NA+TXr7J7hjX8ivJ5YgJ8Z3aY42PV/1fggSrHJKNfDQBEfeM7KbXsFobhxmdwzhhvCQj
         8xRyUF7u7RdHJbDkDqnVfMBA4J40gQw0hisvYJnpe7UCDn4xCt2RmtZXfCNvR/WKVZyW
         +INVAS+b5ztNK0q5NGIVWW3VGQQ5t9kNiGYWYCBrOJ3dQMY+r2dBxcm8zcP6/MN2A93b
         QX+g==
X-Forwarded-Encrypted: i=1; AJvYcCVJ87HycxztbphT8tQs4EIzj/ge+OINHUcuAOtlJ8QQeotFxfi3NGGsYxDLBv3GNfisC/MXQ5ztujja3QqCZEakldZqUFMjFf7qukqhtvo=
X-Gm-Message-State: AOJu0YxMGSMazf5tw1qMtUWq4UZ2ZPfPM6RZ5Lkqkr2xUA7WHg/hn4p2
	DQ3h7N5kjLIPCbBGH+gvODH2oejshC5RFO76jNkMbED5C8pr5gIiEAvYHvhlFsGJTD49MrTkTJM
	vX+sHEjsZ3WqeICLNvvAFdU/vipnWQZgcqcV6ZHVwKGSVcVJzrKDHMroHEe7ibEqI
X-Received: by 2002:a17:907:208b:b0:a6f:881a:cd52 with SMTP id a640c23a62f3a-a6ffe3ccd23mr473011166b.17.1719237438294;
        Mon, 24 Jun 2024 06:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhnyU27DrGZzp+l1CQR2TZUG3M5S++wQElISYHMgmK4zQXLP8Ivw7AGG9dx7NN9JevzrZA2A==
X-Received: by 2002:a17:907:208b:b0:a6f:881a:cd52 with SMTP id a640c23a62f3a-a6ffe3ccd23mr473007966b.17.1719237437420;
        Mon, 24 Jun 2024 06:57:17 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72457301a8sm215631066b.90.2024.06.24.06.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:57:16 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:57:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Potapenko <glider@google.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [PATCH] virtio_ring: fix KMSAN error for premapped mode
Message-ID: <20240624095629-mutt-send-email-mst@kernel.org>
References: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtZWJJ1TxnbDLio28M1_0mUZmDd_HbQrZOVB9ixKoLbMQ@mail.gmail.com>
 <CAG_fn=Xe+XQROUqZ9zy94BXVj8SRKprW3fUj_0rD3AhSAvtn-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAG_fn=Xe+XQROUqZ9zy94BXVj8SRKprW3fUj_0rD3AhSAvtn-w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jun 24, 2024 at 03:51:50PM +0200, Alexander Potapenko wrote:
> On Fri, Jun 7, 2024 at 8:34 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jun 6, 2024 at 7:13 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > Add kmsan for virtqueue_dma_map_single_attrs to fix:
> > >
> > > BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
> > >  receive_buf+0x45ca/0x6990
> > >  virtnet_poll+0x17e0/0x3130
> > >  net_rx_action+0x832/0x26e0
> > >  handle_softirqs+0x330/0x10f0
> > >  [...]
> > >
> > > Uninit was created at:
> > >  __alloc_pages_noprof+0x62a/0xe60
> > >  alloc_pages_noprof+0x392/0x830
> > >  skb_page_frag_refill+0x21a/0x5c0
> > >  virtnet_rq_alloc+0x50/0x1500
> > >  try_fill_recv+0x372/0x54c0
> > >  virtnet_open+0x210/0xbe0
> > >  __dev_open+0x56e/0x920
> > >  __dev_change_flags+0x39c/0x2000
> > >  dev_change_flags+0xaa/0x200
> > >  do_setlink+0x197a/0x7420
> > >  rtnl_setlink+0x77c/0x860
> > >  [...]
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Tested-by: Alexander Potapenko <glider@google.com>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Jason, Michael, any chance this patch can make it to 6.10?
> The bug in question has essentially been blocking KMSAN on syzbot for
> the past month:
> https://syzkaller.appspot.com/bug?id=2819883f3d376b703e686e700fde00a01eec62fa
> 
> The patch should probably have
>   Fixes: b6253b4e21939 ("virtio_ring: introduce dma map api for virtqueue")
> 
> , but I am not exactly sure why syzkaller only started triggering the
> bug this year, given that the patch dates back to 2023.

Yes that's probably a good idea. I will queue it with this tag.

-- 
MST

