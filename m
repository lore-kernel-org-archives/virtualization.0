Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227735881
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529263; cv=none; b=p3Q3YVwzgsL8C9nqdTpEuHQDv50VbT13LzTo/X2I3rXki4JT0sImak+I4lGUn3TdvyE8xBwWE9qcQ9bXnI3UPBXzK+P/7t4YzsnzznO/rwPgbC51dMi108jJiCWtHNIgCEwf6gyxo0+JzQW1xI9Vm6BuCGl3FFQtikD7arMSlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529263; c=relaxed/simple;
	bh=BA/Ohgm2tqLkv6zejsJitO0xqF3Nh2KXSPJKj5saaR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kph3dmmkdq395xwSVMsnkEu3u3GnbNDgJmEQIGMEkAQeT1QGNDM26OyIquwh1gSHvWWEBTKJwKl0CeobreEnJSc9GIBafA880mbETRZ5qJ3Q0rYDMscerbXvCGUZQk5seTNX1RWrkV9/sFR+8BMEkZcUDXDlOWuMmWcC0UB2vdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByNribF7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByNribF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711529260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OPriJzHFcbgruVm0wxQE3Anoh7voeekbwHcm7qslgQ=;
	b=ByNribF7UNvA47Wfm7M6AYAuqiV+KL69sxRx+i/YrY+CaxUAVjD8bStceXQWgOPIEXEYb9
	St8LKmC0+cHysrdH1cWO9kV1bSrToohZzJxBXD2ZnoXlLqZvEA0kAw6bk+eLBD08PsYRfd
	9I8jzXcetzfEPqPXG30gF+GM1Ik6XVo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-lPMD7CPeNuWcG7wa01LQVg-1; Wed, 27 Mar 2024 04:47:38 -0400
X-MC-Unique: lPMD7CPeNuWcG7wa01LQVg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29f9bffaa42so4936201a91.0
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 01:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529257; x=1712134057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OPriJzHFcbgruVm0wxQE3Anoh7voeekbwHcm7qslgQ=;
        b=JdklbxSIA9pPmFC1uvwViFamx9ByQolePaxfo9TKxj1Iv3s/htWlm71DZGdxhDh7g+
         KuEEUkvBvFFmkND0iB0hzGWLfxpXksoeLAlTXNMNvnrCApO++uTb5LQB9uXAEDvDznQ8
         lxvhIPV/SlnZM6ofWKGD8g+3JAbLapIak0QR/hWUbd8sgQDRkk79en+/HLlS98wNns1C
         X1fLlnrS3RSlT7o3zogiS0RwGhytn3NsL7oMxDd+Dy6INIB4k6hZmvl38cfcLhmaW6ll
         Pj7UxYkae0/XZa3uBWatp9jOTu24S42+NsgFTC1Iv+ajokV6+5Rpz13MIqfhmmKvwLbF
         wABw==
X-Gm-Message-State: AOJu0Yyg+nyfmc8K5qnKmfuFQSS+I0M0eJBAKgqZ/vygAK//RMA7gVdt
	oSuyEdrPLP5LwrAUVeHDtyGFRH7ztydMyTdCs3PcG9WNuz2+fFx68Qw80r86eedmBzAsgAzUYRi
	kbo5nEO2OIiSkQsOOk0ucl22Stb+0IRtn2OSJ3LrKFfhS+ldo60IXkh8CGmiVZRG0ytQ1YXg7bN
	vgfGemoc3Qmek1sTk7Wln2T3SDDTOOK2WwT8A623I=
X-Received: by 2002:a17:90a:df0e:b0:29d:dd50:afe with SMTP id gp14-20020a17090adf0e00b0029ddd500afemr429931pjb.30.1711529257532;
        Wed, 27 Mar 2024 01:47:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8vOiUiDpGWyz4qAmLOyE7nYg/S6mVLmJSpUNkaZ0RyP2vnWJWzFN7cLQ5XnKO6n/bRJDKTxcC/JQ/1QAUeXU=
X-Received: by 2002:a17:90a:df0e:b0:29d:dd50:afe with SMTP id
 gp14-20020a17090adf0e00b0029ddd500afemr429921pjb.30.1711529257221; Wed, 27
 Mar 2024 01:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtEWCjb8+Zcfizij2+0ef-wb8YJD2bfyAvP_72hKZrGvA@mail.gmail.com>
 <1711523698.8996527-2-xuanzhuo@linux.alibaba.com> <CACGkMEvzMKyYTNwCwept1HJKLM8FZBa2FZq1oyQ0tFVL2TvMeQ@mail.gmail.com>
 <1711526642.5018039-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711526642.5018039-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 16:47:25 +0800
Message-ID: <CACGkMEvEkq-LH3vkx1uRZ5fDASn0Q=apXbOTK4jSaA=YU6ttHw@mail.gmail.com>
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

On Wed, Mar 27, 2024 at 4:07=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 27 Mar 2024 15:50:17 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Mar 27, 2024 at 3:16=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Tue, 26 Mar 2024 14:35:21 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Mar 25, 2024 at 4:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > As discussed:
> > > > >
> > > > > http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPa=
VmJ3rHYqRZxYg@mail.gmail.com
> > > > >
> > > > > If the virtio is premapped mode, the driver should manage the dma=
 info by self.
> > > > > So the virtio core should not store the dma info. We can release =
the memory used
> > > > > to store the dma info.
> > > > >
> > > > > For virtio-net xmit queue, if the virtio-net maintains the dma in=
fo,
> > > > > the virtio-net must allocate too much memory(19 * queue_size for =
per-queue), so
> > > > > we do not plan to make the virtio-net to maintain the dma info by=
 default. The
> > > > > virtio-net xmit queue only maintain the dma info when premapped m=
ode is enable
> > > > > (such as AF_XDP is enable).
> > > > >
> > > > > So this patch set try to do:
> > > > >
> > > > > 1. make the virtio core to do not store the dma info when driver =
can do that
> > > > >     - But if the desc_extra has not dma info, we face a new quest=
ion,
> > > > >       it is hard to get the dma info of the desc with indirect fl=
ag.
> > > > >       For split mode, that is easy from desc, but for the packed =
mode,
> > > > >       it is hard to get the dma info from the desc. And hardening
> > > > >       the dma unmap is safe, we should store the dma info of indi=
rect
> > > > >       descs when the virtio core does not store the bufer dma inf=
o.
> > > > >
> > > > >       The follow patches to this:
> > > > >          * virtio_ring: packed: structure the indirect desc table
> > > > >          * virtio_ring: split: structure the indirect desc table
> > > > >
> > > > >     - On the other side, in the umap handle, we mix the indirect =
descs with
> > > > >       other descs. That make things too complex. I found if we we=
 distinguish
> > > > >       the descs with VRING_DESC_F_INDIRECT before unmap, thing wi=
ll be clearer.
> > > > >
> > > > >       The follow patches do this.
> > > > >          * virtio_ring: packed: remove double check of the unmap =
ops
> > > > >          * virtio_ring: split: structure the indirect desc table
> > > > >
> > > > > 2. make the virtio core to enable premapped mode by find_vqs() pa=
rams
> > > > >     - Because the find_vqs() will try to allocate memory for the =
dma info.
> > > > >       If we set the premapped mode after find_vqs() and release t=
he
> > > > >       dma info, that is odd.
> > > > >
> > > > >
> > > > > Please review.
> > > > >
> > > > > Thanks
> > > >
> > > > This doesn't apply cleany on vhost.git linux-next branch.
> > > >
> > > > Which tree is this based on?
> > >
> > >
> > > Sorry. That is on the top of "[PATCH vhost v5 0/6] refactor the param=
s of
> > > find_vqs()".
> > >
> > > Lore-URL: http://lore.kernel.org/all/20240325090419.33677-1-xuanzhuo@=
linux.alibaba.com
> > >
> > > Thanks.
> >
> > I've tried that but it doesn't work:
> >
> > % git am ~/Downloads/\[PATCH\ vhost\ v5\ 01_10\]\ virtio_ring_\
> > introduce\ vring_need_unmap_buffer.eml
> > Applying: virtio_ring: introduce vring_need_unmap_buffer
> > error: patch failed: drivers/virtio/virtio_ring.c:2080
> > error: drivers/virtio/virtio_ring.c: patch does not apply
> > Patch failed at 0001 virtio_ring: introduce vring_need_unmap_buffer
> > hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> >
> > I'm using vhost.git linux-next branch, HEAD is
> >
> > commit 56e71885b0349241c07631a7b979b61e81afab6a
> > Author: Maxime Coquelin <maxime.coquelin@redhat.com>
> > Date:   Tue Jan 9 12:10:24 2024 +0100
> >
> >     vduse: Temporarily fail if control queue feature requested
>
>
> NOT ON the vhost directly.
>
> That is on the top of "refactor the params of find_vqs"

I meant I just did it on top of this series.

>
> "refactor the params of find_vqs" said:
>
>         """
>         This pathset is splited from the
>
>              http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@l=
inux.alibaba.com
>
>         That may needs some cycles to discuss. But that notifies too many=
 people.
>         """
>
> But now that is broken due to the change of the that patch set.
>
> I will post the new version of these two patch set soon.

Ok.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > >
> > > > Thanks
> > > >
> > >
> >
>

