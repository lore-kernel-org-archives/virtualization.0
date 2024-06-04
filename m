Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07F1487DF
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Jun 2024 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517908; cv=none; b=h3vXbrURY5OJYtxZLrlr9d3AXW6WRqhEDHnBhNYLJkWSx5cf2EKdEMipZHiBbZm6uxZ5mWuEdrQFzyPm7PjRHcSQCWeh7+i1phSUNU/7xDSlmbd99Nq6k9epy0DZU3spXXvItZ6eTUdgn7+BNz4W+rriqK+mPXATJXx9CRBlVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517908; c=relaxed/simple;
	bh=nPqXATH3gJO0xG3OcvVlRB8VrvjY/FhA0oPoFQeHE5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4BHqdLTurbo3e7UXeJC6UTCr8Q47pGvlvg5m/1KIA2vx+wJexAIRPfqEIPIpJxGIuBxvSzTC/lSCee4mA85JFhs3sAwtoTZggsh9XRrjaew+yU+nmxuo3YKfovtGNT21A1Nu781b+Xp0mjC76n1kwN5V8859N61RsBMEsMeLns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4PaUa4S; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4PaUa4S"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E74396074F
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Jun 2024 16:18:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -17.601
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I8lss8rrBQBF for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jun 2024 16:18:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=glider@google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8B6C66106C
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=google.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B6C66106C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=f4PaUa4S
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8B6C66106C
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Jun 2024 16:18:24 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-702442afa7dso3750515b3a.2
        for <virtualization@lists.linux-foundation.org>; Tue, 04 Jun 2024 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717517903; x=1718122703; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdfqg+XI8I+MI3h2wU8ZL/dAxG9QlNacDO9P7kZI7gM=;
        b=f4PaUa4SHesGO+380FJskWrjtWA8PfZexq9cgaBVgvJbEUB/h7dFXh2A2Qx16qchPX
         QvCbRkdnCQtW+nxnE1jGnrSIYQso05d1UEyr7/Gv5rXnDRxU9EJ+AwGmUU8BGYxU9sB/
         nPIi4OLS1kVlmclTQQch0whito24piFCiokeI3Mp0j72hdS92qeSoUhHYUMJb3SbMTcm
         q20gv32SdNCZ9Vy2KfYhq7O9/P71tjTrnZsNvgjV9Fez/Rv65T6U+BrR5QvUPEVHp8aK
         4HOANpMB+n/jF7zz8qbPsThGkOV3AkqQNuPQmRIVWBx9vvsm26uvjXUlZfOmZ2fhUijc
         WCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717517903; x=1718122703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdfqg+XI8I+MI3h2wU8ZL/dAxG9QlNacDO9P7kZI7gM=;
        b=fOtQdlQyo9mU913Rljxsn1eqzuPt9Ti4N0s8cqIrOTaiySFqjWipgNusudmGwfjTXb
         MLhmtUu8jAnLlulR1m2xope5brlcQV4dSU6WbEJCmBkYsdr4wKUDLNcYqWxwGOYLM460
         gcO7vjxHGx7nqsTsL2bBuH6Gq9UYY2h9LxBDZK89swOSMMMVTrpOLxcxUOwPWpaxu9I2
         MWgT7uUePHwyHg4HVcSCjynhuPrLn6Lv9C8+B14UEudXJuncpRYLOWzT5HtPijQLjqDU
         TxxexVINcyS4UFiFmwSHl5roFH8e8hM1sBpSzJOpykB+3xb115NleGNzHSPxRf/dLvqc
         WRdg==
X-Forwarded-Encrypted: i=1; AJvYcCXcBcGtudnB0lnjFfAFsaw1hqsyhgZjQarUbMB1ZyG1JHeFbmpV/ufg9jdp3DDh96RiDn6c/66uhsmUh7wq+K9Pj1g1RJ8DvAW2730bRrXfvODIbNqAkk97nw==
X-Gm-Message-State: AOJu0YzAHMb+GfjxRJX4Z8l0+51F+wKjJAHxbowHTrer5pEQgRr36FNv
	WkYdNFoYZsnFF/1lBUyD9KkvTzhafCRp/vdfOu/UAKc4dwnEfK8R9i/cDdCNnQ4DPC+cNGNBWB6
	qviI67u1H7v7UL50FQCVC5kvQ+jFNMsOU/iYX
X-Google-Smtp-Source: AGHT+IHH8BcDT51//iJobaXt0VIzNrVR1B4YFM/qgQyKNVEvfCFBn+scD7t29ulO1UCUwWCXKi767BV3CuTLWi/kpUY=
X-Received: by 2002:a05:6a20:3d94:b0:1ad:90dc:4a65 with SMTP id
 adf61e73a8af0-1b2b6fba62amr92507637.27.1717517903068; Tue, 04 Jun 2024
 09:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-5-xuanzhuo@linux.alibaba.com> <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
In-Reply-To: <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 4 Jun 2024 18:17:44 +0200
Message-ID: <CAG_fn=Wv4Tw8guW=mFYyV9T18C_qPZOxr3fwKcRkDVXm1e+iXg@mail.gmail.com>
Subject: Re: [PATCH vhost v13 04/12] virtio_ring: support add premapped buf
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 6:07=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com>=
 wrote:
>
> On Thu, 2023-08-10 at 20:30 +0800, Xuan Zhuo wrote:
> > If the vq is the premapped mode, use the sg_dma_address() directly.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c
> > b/drivers/virtio/virtio_ring.c
> > index 8e81b01e0735..f9f772e85a38 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -361,6 +361,11 @@ static struct device *vring_dma_dev(const struct
> > vring_virtqueue *vq)
> >  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct
> > scatterlist *sg,
> >                           enum dma_data_direction direction,
> > dma_addr_t *addr)
> >  {
> > +     if (vq->premapped) {
> > +             *addr =3D sg_dma_address(sg);
> > +             return 0;
> > +     }
> > +
>
> I wonder if something needs to be done for KMSAN here, like it's done
> by the next block in this function? I'm looking into what seems to be a
> KMSAN false positive on s390x:
>
> BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
>  receive_buf+0x45ca/0x6990
>  virtnet_poll+0x17e0/0x3130
>  net_rx_action+0x832/0x26e0
>  handle_softirqs+0x330/0x10f0
>  [...]

I think there's a similar problem on x86 as well:
https://syzkaller.appspot.com/bug?extid=3Dc5336dcd1b741349d27a

I was going to look closer this week.
