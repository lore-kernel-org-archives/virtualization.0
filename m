Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A354738
	for <virtualization@lists.linux.dev>; Tue, 17 Dec 2024 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734401566; cv=none; b=fV8bXMq/cnZWK4AdzkmWDduVd6W4IE+KhJs5kgw5SlYjxTj+Y5hcpw8cPJHjacI3qobui1FDsicJgZXl4vxwpSwYrVT9/IdCpsVGnvkzscPZlANDRf8IitVmZm9sWSI2xhUXMJuXgNWy+M7OO1Lbr3WMMGdN4Tkfpjosf7U+1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734401566; c=relaxed/simple;
	bh=yLTlIFC32POHxZiPY9cw5QEBfX1gSNNQz6nVW4ixP5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpeULAlrYlew85Tx4fy5R/eXgvoSjhpKBI7kjW8jHf6b+6W7Y+K2/129VmmcYftTF2xRmg8nXbZMDVBkDTOVSU637mc+guWSvbD4bNJJPcWNgX2EMmbBYPuGxL/eED3P6mAVr3AdJ0zM3b0uwCZgWg3uGBX5HCj7sSbAc3Ixrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFNZ/0Vn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFNZ/0Vn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734401563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lx1OsaaoolFeL7wbx64aXWvFu5/zVMeLGy2oXijyrkI=;
	b=HFNZ/0VnyL0w7EUkNQCjmIxT4xuIb/TURW/q1uHMvzHztRIUgI2b4UuLwf8f618rn5Hzkl
	IKewVlb5DfLVw0AOqwDfEoisACHTxkL2bYs7GH1oZkZ2avsgTMO03p2q111jeh2/9jFhsO
	Jr9B5hViivwu8XWKvF8W+s4DUWjI8a8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-PwCDJe6AP0257U3IPjiN3w-1; Mon, 16 Dec 2024 21:12:42 -0500
X-MC-Unique: PwCDJe6AP0257U3IPjiN3w-1
X-Mimecast-MFC-AGG-ID: PwCDJe6AP0257U3IPjiN3w
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee86953aeaso4232746a91.2
        for <virtualization@lists.linux.dev>; Mon, 16 Dec 2024 18:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734401561; x=1735006361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lx1OsaaoolFeL7wbx64aXWvFu5/zVMeLGy2oXijyrkI=;
        b=HZz4e1iP355pLLL5RO/eQCA8Zk8awriMTYpvcmT4E5TsIctC4CYqzv8GbMMah9YNld
         PdP+6kUbku6gTmlGBNJte5p39+wS2n6iM6pSKAmQOCIQfdfp5b8b10YbqYa8+9MxYaEu
         Ht+t7al4YJzWhB4abaAERq/1X8SZ4vA0ETHz8HImmNj6NhqGhSLVgpj1/wPLDiayJcii
         P/qwR6JRsOv8lH3V2SV9mbZjQjCPuQfwpdlYYYH84IaTLwFNoTMuUdxKRFTMwrG6X/+7
         5rdK6LWj9RqTG6tFxt9JNV76b/+KZdYhBWG/XCnyJrZuvQZfkc89ImyOW7P6LSI0tpNv
         MzSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG2Zk08dL/qTq++wT4uKnSFGQeIYQwIk+SzhA2f8AWwn5qREiuzUV98Yr22MYB/HnVuP905fGgpOTysHwiyA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxxz05f6Xt03MWCJCJO1WWL2ZIcVJ4fijI1LCHic//cq+KVjhP3
	AvNIYRG97L0brOfLc/SWNsUGO845H5BKsPqm8/rSdeVTdiDQx6e7ZGR91G4bIcfSKCHGvPgC4Qr
	BcOETmGC7uC0T+u1ugr7NSe5bB1F3WAADAPjRdPr/95DxWvU4A4sleA8msoU6EtbJrhemnKTBxP
	AgzIdREa9GjEzgF6E0/q6cdBqFOFg7w9GiXCIiBqY=
X-Gm-Gg: ASbGncu9dvFUa/kqUTMe+4b69yHbE05WfMlpZsSYmYUjpQlEC3CkVWxxinJIC8c5Zgm
	S2d1I3OHCwxjOT7OrI9gSRYd/Lq6USmUOW8eZGiU=
X-Received: by 2002:a17:90a:c2c6:b0:2f2:a664:df33 with SMTP id 98e67ed59e1d1-2f2d7d6d6c9mr2562034a91.1.1734401561235;
        Mon, 16 Dec 2024 18:12:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWfOMwLE4xN7EgIgUmoj8RBxxJhD+t49TCaL2tr59Vru/vF26Eb336KxLuaGzGJG7u8TB7F89vPmau4TDvCMc=
X-Received: by 2002:a17:90a:c2c6:b0:2f2:a664:df33 with SMTP id
 98e67ed59e1d1-2f2d7d6d6c9mr2561996a91.1.1734401560849; Mon, 16 Dec 2024
 18:12:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241203121424.19887-1-mengferry@linux.alibaba.com>
 <Z2BNHWFWgLjEMiAn@infradead.org> <CAJSP0QXU_uNqL-9LmLRkDdPPSdUAGdesQ2DFuCMHnjyEuREvXQ@mail.gmail.com>
In-Reply-To: <CAJSP0QXU_uNqL-9LmLRkDdPPSdUAGdesQ2DFuCMHnjyEuREvXQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Dec 2024 10:12:28 +0800
Message-ID: <CACGkMEtPdhrXnTYgF4eCC7x7fbh53hgOJ9TytYmZR=z+nFexTQ@mail.gmail.com>
Subject: Re: [PATCH 0/3][RFC] virtio-blk: add io_uring passthrough support for virtio-blk
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Ferry Meng <mengferry@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	linux-block@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e1zmIci-LdTYnOMRrvu1I-4cAbdcFhlzw-ZerWSE1rk_1734401561
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:14=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>
> On Mon, 16 Dec 2024 at 10:54, Christoph Hellwig <hch@infradead.org> wrote=
:
> >
> > Hacking passthrough into virtio_blk seems like not very good layering.
> > If you have a use case where you want to use the core kernel virtio cod=
e
> > but not the protocol drivers we'll probably need a virtqueue passthroug=
h
> > option of some kind.
>
> I think people are finding that submitting I/O via uring_cmd is faster
> than traditional io_uring. The use case isn't really passthrough, it's
> bypass :).
>
> That's why I asked Jens to weigh in on whether there is a generic
> block layer solution here. If uring_cmd is faster then maybe a generic
> uring_cmd I/O interface can be defined without tying applications to
> device-specific commands. Or maybe the traditional io_uring code path
> can be optimized so that bypass is no longer attractive.
>
> The virtio-level virtqueue passthrough idea is interesting for use
> cases that mix passthrough applications with non-passthrough
> applications. VFIO isn't enough because it prevents sharing and
> excludes non-passthrough applications. Something similar to  VDPA
> might be able to pass through just a subset of virtqueues that
> userspace could access via the vhost_vdpa driver.

I thought it could be reused as a mixing approach like this. The vDPA
driver might just do a shadow virtqueue so in fact we just replace
io_uring here with the virtqueue. Or if we think vDPA is heavyweight,
vhost-blk could be another way.

> This approach
> doesn't scale if many applications are running at the same time
> because the number of virtqueues is finite and often the same as the
> number of CPUs.
>
> Stefan
>

Thanks

