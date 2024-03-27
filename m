Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3542C6A7
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525833; cv=none; b=f3QFbRmyQpCQFapucgTfrZYjssZaFV0EhTWj99oefdLmND/BrkJWA0b4rpPK6tg5XTbGq7Y7qpcQTHMgoOx5VbhjCtCCtq3XrEu7/hofhx6BxtkeKcO0LNJNmYIE4fHFOJ0sQc+jRKK7QY2h/N0hd/m/AAtL9pQZGqoLF+xCPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525833; c=relaxed/simple;
	bh=G4gBxI9rnfFMlIO3v/jwuSxookG3kaOjTJgRf/Y/wfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUGnyLx17aJmr8Ki2MD7ik0QtLph63KE9hUr2NYMyoGG/mj1RiNOUD8VWu4FGVvoUZqNeIHBdkEQ5r6uNMKJT9+AmBcon10RD2MvCMVZ9CF28B4rxnmGHg50tVG9IQM57yH1ndzUF9p7xDBPcyKO4M9aJvf68gfo0OLFfc4G3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e29rVE4D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e29rVE4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711525830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=leNaeVEeegZNAyCWujLBBYSGN9KTxodCNVdWyzvOBB0=;
	b=e29rVE4DGAsb8gx/2KGhx9Oo8fLRIGKyUObm4nN7d3QWaCWk0XkplDCyeu19BA9vFDXitO
	8MEdiPdK20Qs8fgBRDReHAr5OSLBjlg52lhAxeAO3VHtGQlomH05lPjtW7BrTyNay7M/vj
	orliHBt3CMngdZzfHyAVNN2uVMV+rBo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Hj7BvR-YON-f6UETJ8IJGg-1; Wed, 27 Mar 2024 03:50:29 -0400
X-MC-Unique: Hj7BvR-YON-f6UETJ8IJGg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c3d67078ecso1415321b6e.2
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 00:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525828; x=1712130628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leNaeVEeegZNAyCWujLBBYSGN9KTxodCNVdWyzvOBB0=;
        b=cfv30idTVCYvplKdtRZGbOPk7xdIgX8H0ZBCVaDwVnmdT1RkxdSRckPaHIcjLs3tSf
         VO/YZdiGei2hrP4edRvEIX1WE82WhKD+BFff3XLPU/cLroCel1RoJcMfXSPV+rAWqdeg
         5xxicfYEW+Yr/68gWwNSiaoz0vFzOMd6HQ0NgS46uo9aaO8aEK3w5U7BeIAEh/DUfcoe
         yogUdPBGpCjHUH5eZXbZzSFQf0+2/MMCstXwZR5mlhNFudE+MtbEFLks412RuRKs+s4r
         Dzp22T4EoSt0ZJiY/Ne0s3LWGNtHK8ks7lGPsCTajO8uOOi1vevUyXq8nFHd5MLJfNB6
         Q/jA==
X-Gm-Message-State: AOJu0YxKMR4hbdGdtxCWAv7XnwHScEE73Mu+mH7NwAu6Xgd+yLSgeI7y
	4x8aeFS2O/xA4QKFRZJ8b/aWycjO0gLw3rTqpIDWptxj3UuMBphKjKqHxsXOH+OAdKEuws75F49
	v5CfxI0fvQB4pciBgtThksHCQGdZNTrq40xtb0016ue7i6zcX2fsTdoS6MbCWCLnfNhYrdEoHvt
	mfvbLA4UN5rR1bGz0r5FNwBNJaf3PDNenAwKcCmzo=
X-Received: by 2002:a05:6808:3a1b:b0:3c3:d459:d849 with SMTP id gr27-20020a0568083a1b00b003c3d459d849mr2463792oib.27.1711525828328;
        Wed, 27 Mar 2024 00:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIwlaV3wv9ZkE1tKICeIHrGUIEjqVJum9I6Gwneza/2HcRBp/yllRKFNMqZogdirZl+9w0LsR5VG9mSD4vDXQ=
X-Received: by 2002:a05:6808:3a1b:b0:3c3:d459:d849 with SMTP id
 gr27-20020a0568083a1b00b003c3d459d849mr2463778oib.27.1711525828020; Wed, 27
 Mar 2024 00:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtEWCjb8+Zcfizij2+0ef-wb8YJD2bfyAvP_72hKZrGvA@mail.gmail.com> <1711523698.8996527-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711523698.8996527-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 15:50:17 +0800
Message-ID: <CACGkMEvzMKyYTNwCwept1HJKLM8FZBa2FZq1oyQ0tFVL2TvMeQ@mail.gmail.com>
Subject: Re: [PATCH vhost v5 00/10] virtio: drivers maintain dma info for
 premapped vq
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 3:16=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 26 Mar 2024 14:35:21 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Mar 25, 2024 at 4:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > As discussed:
> > >
> > > http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3=
rHYqRZxYg@mail.gmail.com
> > >
> > > If the virtio is premapped mode, the driver should manage the dma inf=
o by self.
> > > So the virtio core should not store the dma info. We can release the =
memory used
> > > to store the dma info.
> > >
> > > For virtio-net xmit queue, if the virtio-net maintains the dma info,
> > > the virtio-net must allocate too much memory(19 * queue_size for per-=
queue), so
> > > we do not plan to make the virtio-net to maintain the dma info by def=
ault. The
> > > virtio-net xmit queue only maintain the dma info when premapped mode =
is enable
> > > (such as AF_XDP is enable).
> > >
> > > So this patch set try to do:
> > >
> > > 1. make the virtio core to do not store the dma info when driver can =
do that
> > >     - But if the desc_extra has not dma info, we face a new question,
> > >       it is hard to get the dma info of the desc with indirect flag.
> > >       For split mode, that is easy from desc, but for the packed mode=
,
> > >       it is hard to get the dma info from the desc. And hardening
> > >       the dma unmap is safe, we should store the dma info of indirect
> > >       descs when the virtio core does not store the bufer dma info.
> > >
> > >       The follow patches to this:
> > >          * virtio_ring: packed: structure the indirect desc table
> > >          * virtio_ring: split: structure the indirect desc table
> > >
> > >     - On the other side, in the umap handle, we mix the indirect desc=
s with
> > >       other descs. That make things too complex. I found if we we dis=
tinguish
> > >       the descs with VRING_DESC_F_INDIRECT before unmap, thing will b=
e clearer.
> > >
> > >       The follow patches do this.
> > >          * virtio_ring: packed: remove double check of the unmap ops
> > >          * virtio_ring: split: structure the indirect desc table
> > >
> > > 2. make the virtio core to enable premapped mode by find_vqs() params
> > >     - Because the find_vqs() will try to allocate memory for the dma =
info.
> > >       If we set the premapped mode after find_vqs() and release the
> > >       dma info, that is odd.
> > >
> > >
> > > Please review.
> > >
> > > Thanks
> >
> > This doesn't apply cleany on vhost.git linux-next branch.
> >
> > Which tree is this based on?
>
>
> Sorry. That is on the top of "[PATCH vhost v5 0/6] refactor the params of
> find_vqs()".
>
> Lore-URL: http://lore.kernel.org/all/20240325090419.33677-1-xuanzhuo@linu=
x.alibaba.com
>
> Thanks.

I've tried that but it doesn't work:

% git am ~/Downloads/\[PATCH\ vhost\ v5\ 01_10\]\ virtio_ring_\
introduce\ vring_need_unmap_buffer.eml
Applying: virtio_ring: introduce vring_need_unmap_buffer
error: patch failed: drivers/virtio/virtio_ring.c:2080
error: drivers/virtio/virtio_ring.c: patch does not apply
Patch failed at 0001 virtio_ring: introduce vring_need_unmap_buffer
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

I'm using vhost.git linux-next branch, HEAD is

commit 56e71885b0349241c07631a7b979b61e81afab6a
Author: Maxime Coquelin <maxime.coquelin@redhat.com>
Date:   Tue Jan 9 12:10:24 2024 +0100

    vduse: Temporarily fail if control queue feature requested

Thanks

>
> >
> > Thanks
> >
>

