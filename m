Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF1A2D193B
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515446; cv=none; b=fT3ncrH8/+gchnQRXUs2b7QK2TSa1KgXMdYcHWjGevE8vM5HumhgtAK9ykOZg2FL29xjW7SshMvrWmIc3dISM3JhCF/5z/MlnRrJfnLJPACW47zhVLmu2X7OytVgaxCfyvfEPoQKOqWdrKPTcfzaoSq0JmZpfxhfjyBPW2Tgb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515446; c=relaxed/simple;
	bh=vpVIYC+QuXykroOmjVEM4y8l5atcwna28pGVIgjZF24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEUvKyJwOSBDf6cnIm0bJTDCFp9TEBDaeyJfZ3MPryzgW+AUYWyVko7YXNWAiIWiSJrwl1VYyD9VWhryuBP6cpjIGcACKam7pqDBldIU6Sce02hx0z4v6+NDZxIK8xZRJmWyyFg1grRnZfbYYYQcTjyXzqm7ky/sTezwyW0Km8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOOJPlvR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOOJPlvR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760515443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXWohRz8B1VQgrvQtaHmJQvIEqtr1FgUvdL7GWQSIqI=;
	b=FOOJPlvRKrz8qcZdpkaNkeCAfVLmuRrnPXJQF8Mxp1/t5itUoiCaC5xVC8jVHuf1Kg1Otb
	vIsjULPOTl5hFuw9B7VSSfZWhviMmLWv1lHSPNwd2zJPbCJ7vu+iiCeoDwex5wy4lOBqMP
	k22jGxZwLf0nF+oxiZwuqc9Inly9JoA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-zIJ36SGuPzenVx0VH-LKFg-1; Wed, 15 Oct 2025 04:04:02 -0400
X-MC-Unique: zIJ36SGuPzenVx0VH-LKFg-1
X-Mimecast-MFC-AGG-ID: zIJ36SGuPzenVx0VH-LKFg_1760515441
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-336a6070642so23568651fa.0
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 01:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760515441; x=1761120241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXWohRz8B1VQgrvQtaHmJQvIEqtr1FgUvdL7GWQSIqI=;
        b=dePTgcBOiWKRpIxlI8P2KC/4CqShvpeJUfGqW0jz3lWqESLCxwN1PRYmcY3Wil5ewo
         I58lVhptr8o5WHYQolvbdX7v4MsGW1xWezkXZVv+pauO31fGMfeqdSTopsDt2G9Jeohh
         t+Rs68Po5pSAgGFiZYbr7VjrzUdD9VxYJ0CWo4QAQldplQex2pyuYErDBx3yJVaGIZoU
         cFSDP8suacEnriQr0p8/Lb+iD9FOtl2q3hfjBYaIZyxM4sDli3OYKoOhEqVefJtY1Uw0
         pL2EBQ97O6d2TJKPDx79ycXV0gR7HfNkeMtkXzSswgPZc/TzprYhU83+YTY+UbeZqoLF
         8fAw==
X-Forwarded-Encrypted: i=1; AJvYcCWyScDSXser12xD3udhQVies9r/sOGzXx09vo0OQClChe8Wvkv9AYOlET3UKzzZWUDCGV7fSeA4OgGGxVUUzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHpF2hJbGg25yxwuKeQInyMYghsaKUF888HNzggSaamLvt6sqp
	0xSkw6qROoTs4PWxyxyCvcOKpXOp/ckIMFOeWDnhk1z/v7MdwrXQs9LvLnJYU6+Zb7gXm90/bfy
	mKlVg/6wHsRqgqC9Q6TXt5PLNvs0n15zrxiyNjffxq7xPViBxvLFGzV64TFwJv3bl6AXzmOntA1
	WaJ1/wEsCEr+76lSloKiL5jxbgqU43c2ai2SfnqCczzBw=
X-Gm-Gg: ASbGncviOnhuj6ZKQ+s7ae237LmHrBatQS6+2wqD6/a9Qntcuiw0TaX0jhRC4/7crgs
	zWEdFWU7afCSeFHQVdONzrvaDizSIwwDU9neN/oSki/h1pgDI8jagA+JbX5ETHLspFTnFpFT5wA
	fYeGY+1TBmuzBnSAX70oA=
X-Received: by 2002:a05:651c:1989:b0:36c:ebb0:821c with SMTP id 38308e7fff4ca-37609cc1c2dmr68184411fa.7.1760515440733;
        Wed, 15 Oct 2025 01:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhU0DJPeVcVT2z0ZwoZKfqqQFiuVox9UrFqoWa0xY+/waqQcEh5FRk9TdO7Bs50oicZeyV3Es9MhjTHRog7TU=
X-Received: by 2002:a05:651c:1989:b0:36c:ebb0:821c with SMTP id
 38308e7fff4ca-37609cc1c2dmr68184291fa.7.1760515440268; Wed, 15 Oct 2025
 01:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org> <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org> <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org> <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
In-Reply-To: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Wed, 15 Oct 2025 10:03:49 +0200
X-Gm-Features: AS18NWAl5_ajgWsgU8LCHBFRWWZaGW7vNOkzRONDWy-hOfTBe0S7p4M1TJ9202c
Message-ID: <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QW0qoVuTz4O-gCnfl8T-zNba2vLZBzrA4CjDf0KHeRk_1760515441
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:45=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wrote:
> > > On Wed, Oct 15, 2025 at 8:33=E2=80=AFAM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin wrot=
e:
> > > > > On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin <mst@=
redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote=
:
> > > > > > > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirkin <=
mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=A9re=
z wrote:
> > > > > > > > > An userland device implemented through VDUSE could take r=
tnl forever if
> > > > > > > > > the virtio-net driver is running on top of virtio_vdpa.  =
Let's break the
> > > > > > > > > device if it does not return the buffer in a longer-than-=
assumible
> > > > > > > > > timeout.
> > > > > > > >
> > > > > > > > So now I can't debug qemu with gdb because guest dies :(
> > > > > > > > Let's not break valid use-cases please.
> > > > > > > >
> > > > > > > >
> > > > > > > > Instead, solve it in vduse, probably by handling cvq within
> > > > > > > > kernel.
> > > > > > >
> > > > > > > Would a shadow control virtqueue implementation in the VDUSE =
driver work?
> > > > > > > It would ack systematically messages sent by the Virtio-net d=
river,
> > > > > > > and so assume the userspace application will Ack them.
> > > > > > >
> > > > > > > When the userspace application handles the message, if the ha=
ndling fails,
> > > > > > > it somehow marks the device as broken?
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Maxime
> > > > > >
> > > > > > Yes but it's a bit more convoluted  than just acking them.
> > > > > > Once you use the buffer you can get another one and so on
> > > > > > with no limit.
> > > > > > One fix is to actually maintain device state in the
> > > > > > kernel, update it, and then notify userspace.
> > > > > >
> > > > >
> > > > > I thought of implementing this approach at first, but it has two =
drawbacks.
> > > > >
> > > > > The first one: it's racy. Let's say the driver updates the MAC fi=
lter,
> > > > > VDUSE timeout occurs, the guest receives the fail, and then the d=
evice
> > > > > replies with an OK. There is no way for the device or VDUSE to up=
date
> > > > > the driver.
> > > >
> > > > There's no timeout. Kernel can guarantee executing all requests.
> > > >
> > >
> > > I don't follow this. How should the VDUSE kernel module act if the
> > > VDUSE userland device does not use the CVQ buffer then?
> >
> > First I am not sure a VQ is the best interface for talking to userspace=
.
> > But assuming yes - just avoid sending more data, send it later after
> > userspace used the buffer.
> >
>
> Let me take a step back, I think I didn't describe the scenario well enou=
gh.
>
> We have a VDUSE device, and then the same host is interacting with the
> device through the virtio_net driver over virtio_vdpa.
>
> Then, the virtio_net driver sends a control command though its CVQ, so
> it *takes the RTNL*. That command reaches the VDUSE CVQ.
>
> It does not matter if the VDUSE device in the userland processes the
> commands through a CVQ, reading the vduse character device, or another
> system. The question is: what to do if the VDUSE device does not
> process that command in a timely manner? Should we just let the RTNL
> be taken forever?
>

My understanding is that:
1. Virtio-net sends a control messages, waits for reply
2. VDUSE driver dequeues it, adds it to the SCVQ, replies OK to the CVQ
3. Userspace application dequeues the message from the SCVQ
 a. If handling is successful it replies OK
 b. If handling fails, replies ERROR
4. VDUSE driver reads the reply
 a. if OK, do nothing
 b. if ERROR, mark the device as broken?

This is simplified as it does not take into account SCVQ overflow if
the application is stuck.
If IIUC, Michael suggests to only enqueue a single message at the time
in the SVQ,
and bufferize the pending messages in the VDUSE driver.

