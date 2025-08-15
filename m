Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9A634
	for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 01:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220085; cv=none; b=oHR1upCaNvLbw0/reXmzTifrwaqsmidfs2Ktw4Mn8DQBkM4gWqfhuFnzPoA2SXILoZU8fbddZfifbMQUUYC61N88W9epbB/K7qmlWRpLRACsbDKaPIWXPfhGDRn7henVxruR9ExQFbBSlvXoqNCI+lceDuRzFX0WjhWq/7EmcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220085; c=relaxed/simple;
	bh=A9xsVum7dE9cWbv/MJuU42/Tx4JVGra8ML3nMEneZOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njoDJP7xDLmKlPUmOTrR4E3QLzSMl/x8WbVunFwlOP0swWUvsdCIkSSA47Ila0W1KwvxN414wFs1etJN+kadAl5S7YKul7VIm/99bNFgkMjpR50zUh6MFkk5l2MMegTsGk1LVrP4IyvWenEuKdX655vsvmen6MtxV3kKao79VQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5klw+ij; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5klw+ij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755220082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9xsVum7dE9cWbv/MJuU42/Tx4JVGra8ML3nMEneZOM=;
	b=g5klw+ij3/INbpzbGcPKsNa7dR+PzKe98C2diyiFsD927zzMPaaqFG3nLJxnuYzkVfLewo
	ZMl6kfXwvW8dkrzlhT8Jl+JoXbQzSppFeUvFCuc73A5F68r0kAwZmie8mvL4R1ZoOT+vk7
	x2yhM0reZg8bzf6E9nbV00G+JhG6tfw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-88F-jdx7OpCUfGUZ3ur0jQ-1; Thu, 14 Aug 2025 21:07:59 -0400
X-MC-Unique: 88F-jdx7OpCUfGUZ3ur0jQ-1
X-Mimecast-MFC-AGG-ID: 88F-jdx7OpCUfGUZ3ur0jQ_1755220079
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-323266b700cso2935464a91.0
        for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 18:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220079; x=1755824879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9xsVum7dE9cWbv/MJuU42/Tx4JVGra8ML3nMEneZOM=;
        b=QxVMSDdWs1FGyT9Ju6RqgrkYFmKuxZwQWl6uRB19JkBnQnNN+Z3o+Albh7xRDF0W3M
         B6UXFhtzDpx3hKVvWcI4aQHnUe3AbBQwOgVddL5QYU8EQsb8FfHw7MRnO/A7ULD0qsZW
         zqe1LZpS5WtS12dBqf51Ovw/GCWw2mJlyTBKTVVDKNtSUV7REyacO7rxRQjjpyI7zC9c
         9U+dSewsJwHXCmKgHcc06Ix7M5YWAWqyjjTCDFFD20mebKpRWCurueGRTSU83m8WBQ3H
         4SozqxZQDSoWPy2FTRQYfDvJSYMwCi55Gcmki3/tOQ+rOE1tBksuZ8OMDh0jsurYZWLb
         JctQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW/oitscMTz3yX9wCGPumXXqzNwzBg2KGvbN0Bj6WIRFfPTmKJ4HIlGtO2SMKJqDsFtHRrJM1Hlvo45PTo5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLOjpCS0Qfqk2KGSEkD6qu2H/8FXhHu7VHohiwupSFNAis+c3y
	y2rzX41/EgtNeWklhAuo1R6qsGZ8BhNV58xhIwh1ackOx65ZjN73rZAlhMYWTqiHciwQAhZPm+L
	WIdym3ZqxHreMiOmDK/iKsm/J4uTqDFuSEKsiFz8bePGNikgSfZtuLRXuToC5uvwrIp6fpnPCsq
	7P1jBe2S7sIym6N6xacBwQM33wKd3fQvHV5gBj+BgVejo=
X-Gm-Gg: ASbGncuR+WD95M2+8Nk5zDvz0HlVM3/Vq3126fRVaeNta1yqiFfU2pHe8zoPL/SWj2c
	hB0WmqwecpR1M27QWeryW4gbwRs4BIrotCn7CyXGu3yborlaQE0JSMCGWX24hfVo+tmoKKZLqmh
	AvFhmk1N0abtwWdxvxgrVdAg==
X-Received: by 2002:a17:90b:3c10:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-32341e213b1mr438756a91.15.1755220078811;
        Thu, 14 Aug 2025 18:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFftEd7ZpwZlhPeUYgWI8U5PeEZpBHT/0Rw+KUFajkX3bgGwgq+MWu5X1o7e1+IYTjAp76m3/T46kYaLuJcso=
X-Received: by 2002:a17:90b:3c10:b0:311:9c1f:8516 with SMTP id
 98e67ed59e1d1-32341e213b1mr438714a91.15.1755220078289; Thu, 14 Aug 2025
 18:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20250814054321epcas5p1dd83614241a15c78645e7f08d5e959c3@epcas5p1.samsung.com>
 <CACGkMEs+RCx=9kun2KwMutmN4oEkxzW4KDNW=gwXNZD=gpetrg@mail.gmail.com> <20250814054333.1313117-1-junnan01.wu@samsung.com>
In-Reply-To: <20250814054333.1313117-1-junnan01.wu@samsung.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Aug 2025 09:07:46 +0800
X-Gm-Features: Ac12FXyMnzmmCYkHkvMnS0G6q-NfxdLkSUe4o0bafIE3pCtKzUtrQtDJ_G_v9cU
Message-ID: <CACGkMEv2wMm_tb+mbgMFA2M2ZimVr1OBKre3nrYrBDVPpqVoiw@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, kuba@kernel.org, lei19.wang@samsung.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, q1.huang@samsung.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying123.xu@samsung.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ljVoman5vUWiKKHdHJw1RpuQGDh3S6xLKJB5pg0UVnk_1755220079
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 2:44=E2=80=AFPM Junnan Wu <junnan01.wu@samsung.com>=
 wrote:
>
> On Thu, 14 Aug 2025 12:01:18 +0800 Jason Wang wrote:
> > On Thu, Aug 14, 2025 at 10:36=E2=80=AFAM Junnan Wu <junnan01.wu@samsung=
.com> wrote:
> > >
> > > On Wed, 13 Aug 2025 17:23:07 -0700 Jakub Kicinski wrote:
> > > > Sounds like a fix people may want to backport. Could you repost wit=
h
> > > > an appropriate Fixes tag added, pointing to the earliest commit whe=
re
> > > > the problem can be observed?
> > >
> > > This issue is caused by commit "7b0411ef4aa69c9256d6a2c289d0a2b320414=
633"
> > > After this patch, during `virtnet_poll`, function `virtnet_poll_clean=
tx`
> > > will be invoked, which will wakeup tx queue and clear queue state.
> > > If you agree with it, I will repost with this Fixes tag later.
> > >
> > > Fixes: 7b0411ef4aa6 ("virtio-net: clean tx descriptors from rx napi")
> >
> > Could you please explain why it is specific to RX NAPI but not TX?
> >
> > Thanks
>
> This issue appears in suspend flow, if a TCP connection in host VM is sti=
ll
> sending packet before driver suspend is completed, it will tigger RX napi=
 schedule,
> Finally "use after free" happens when tcp ack timer is up.
>
> And in suspend flow, the action to send packet is already stopped in gues=
t VM,
> therefore TX napi will not be scheduled.

I basically mean who guarantees the TX NAPI is not scheduled?

Thanks

>

