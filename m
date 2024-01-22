Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE0E1FBA
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705897148; cv=none; b=CZ4RH9S9J1L04MCiN3bqAe01d+X5unXbuoZ6bebvNAX8t2U+V7bdkdQ8b6vbnSSIBe+n2kf5WuGBvteZRp19n6yqHOW2rr8OIvt+0UQQsjjorB76eiGWKFDVkcDvEK3d1d4mS1NaqNUcsTB0LRoi+YNpmUw2PnkL/2Hp/VUKvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705897148; c=relaxed/simple;
	bh=Eec/WKAE2PzQjmyeeX450K95J0F0Wq+tXrRlsoNb/tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0OKP5XCWUdMWs2aSfqRBZhbRnZJ4w4Fxz1lsXp8Z9XGhAZqjIBTHi3fbTzzxtA+YfHkvCGuhiDUO+nUySWaqroN9/tXzfcK2xEbO+X1DTVywrMfoyfxDLKOMv9n/wzYgbbe/6IZ7Bp1m2r4wfifJzJFrmy4ZIYB4ZbLewVSA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3doD8YS; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3doD8YS"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8CFC60B0B
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 04:19:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8CFC60B0B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C3doD8YS
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q903zwVKahRA
	for <virtualization@lists.linux-foundation.org>;
	Mon, 22 Jan 2024 04:19:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0D81660AC9
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 04:19:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D81660AC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705897145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOra4+3WkvmQK52hu1wsPjdf+F8jne7oahqaHbNMAuM=;
	b=C3doD8YSoHGjDbTe6xLTAR7qU4yManhvd8U0/37Z6Kso2PZcVkBrawGxEPNOB/+92Y8CTX
	2h+XrvwwtEQE4pHX4c794wMSfkeub+J85jrBc5JMD95l/AXGBSa/t4hJau+meKU7By2yFN
	4VuhRXy3QzlfTRIOvduTDV115iWBhOc=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-5F9y2VZ3MoivYtgjx_rhLA-1; Sun, 21 Jan 2024 23:19:03 -0500
X-MC-Unique: 5F9y2VZ3MoivYtgjx_rhLA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bbb6fd2cceso3090817b6e.2
        for <virtualization@lists.linux-foundation.org>; Sun, 21 Jan 2024 20:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705897142; x=1706501942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOra4+3WkvmQK52hu1wsPjdf+F8jne7oahqaHbNMAuM=;
        b=kTumVxWBjNWqT3uw+n4KglT0d/2qayQ1flWono0610zLxiP/re1E7BxLscg8ayP1Xs
         Rlf+q5knvEnFYF38bw9JQQUR+mjD7wzBG40U4S4Js8ktpXATAWme19SEfHCCE+9xF9f7
         p1Ds+U7MDncGwZhiBO7utx0ZjfYYi0T2ybfP7IfzakpJoXhy1WYYtn4RKblPEi0sUfuO
         yZtA9F36keUQ/m0hO3UgBpQdquSarYhAwzr8jy6QHKi0kcMEivLIx3JrVasdm/Xta6Do
         4+vpdkqfXR+8SHyfNm/jE6sT+DpzeouUKArbh2Bo6zY+q10ZXvS2BBL53EZQrWiRfu7A
         hSjg==
X-Gm-Message-State: AOJu0YyeMt4Gf+1SeFXmuQ4+B7xe/MCn2qAM4FsNbC6NfYMlzLTncn/r
	FE32qLsWC7YkDVowvrju4Bye8jX9kAy7J7Nym6YVULbidY9bAdSRi2gayYbMHlCljQK+snLTUD8
	QnC/nfXzvsUC9XP/Nvy6i0H4pJRwtDsUtzVH5URkNvNmlTDEMWvQo9kWSb3uxe/neB2WgBM7UCe
	ZcFYC9Tl6jeUbOQJL7JgD2c3yb/uQlQtkKLNrW/ErAijoQVgq7CeoFpQ==
X-Received: by 2002:a05:6808:199e:b0:3bd:b503:90aa with SMTP id bj30-20020a056808199e00b003bdb50390aamr2297118oib.17.1705897142589;
        Sun, 21 Jan 2024 20:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF71j0bIeUwRrUjJww1p1VJ6O+pK4kbCDGkvc5YymXjMm81KRYqPckvaAIe2BEMr2jt2TgoQvfS1Xn+Olz+JI=
X-Received: by 2002:a05:6808:199e:b0:3bd:b503:90aa with SMTP id
 bj30-20020a056808199e00b003bdb50390aamr2297108oib.17.1705897142387; Sun, 21
 Jan 2024 20:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
 <20231229073108.57778-7-xuanzhuo@linux.alibaba.com> <CACGkMEvaTr1iT1M7DXN1PNOAZPM75BGv-wTOkyqb-7Sgjshwaw@mail.gmail.com>
 <1705390340.4814627-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1705390340.4814627-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 12:18:51 +0800
Message-ID: <CACGkMEuo7m82cTxFSeryyYemMP8AgeKgE6kKYqoFGChTZ7KNWA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/27] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 3:47=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 11 Jan 2024 16:34:09 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Dec 29, 2023 at 3:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> > > get buf from virtio core for premapped mode.
> > >
> > > If the virtio queue is premapped mode, the virtio-net send buf may
> > > have many desc. Every desc dma address need to be unmap. So here we
> > > introduce a new helper to collect the dma address of the buffer from
> > > the virtio core.
> > >
> > > Because the BAD_RING is called (that may set vq->broken), so
> > > the relative "const" of vq is removed.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 174 +++++++++++++++++++++++++--------=
--
> > >  include/linux/virtio.h       |  16 ++++
> > >  2 files changed, 142 insertions(+), 48 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 51d8f3299c10..1374b3fd447c 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -362,6 +362,45 @@ static struct device *vring_dma_dev(const struct=
 vring_virtqueue *vq)
> > >         return vq->dma_dev;
> > >  }
> > >
> > > +/*
> > > + *     use_dma_api premapped -> do_unmap
> > > + *  1. false       false        false
> > > + *  2. true        false        true
> > > + *  3. true        true         false
> > > + *
> > > + * Only #3, we should return the DMA info to the driver.
> >
> > Btw, I guess you meant "#3 is false" here?
> >
> > And could we reduce the size of these 3 * 3 matrices? It's usually a
> > hint that the code is not optmized.
>
> On the process of doing dma map, we force the (use_dma_api, premapped).
>
> if premapped:
>      virtio core skip dma map
> else:
>         if use_dma_api:
>                 do dma map
>         else:
>                 work with the physical address.
>
> Here we force the (premapped, do_unmap).
>
> do_unmap is an optimization. We just check this to know should we do dma =
unmap
> or not.
>
> Now, we introduced an new case, when the virtio core skip dma unmap,
> we may need to return the dma info to the driver. That just occur when
> the (premapped, do_unmap) is (true, false). Because that the (premmaped,
> do_unmap) may be (false, false).
>
> For the matrices, I just want to show where the do_unmap comes from.
> That is a optimization, we use this many places, not to check (use_dma_ap=
i,
> premapped) on the process of doing unmap. And only for the case #3, we sh=
ould
> return the dma info to drivers.

Ok, it tries to ease the life of the readers.

I wonder if something like

bool virtqueue_needs_unmap() can help, it can judge based on the value
of use_dma_api and premapped.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> >
>

