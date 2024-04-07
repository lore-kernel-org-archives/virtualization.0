Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6F717C9
	for <virtualization@lists.linux.dev>; Sun,  7 Apr 2024 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712463856; cv=none; b=BxK8L5BNHT8HMVYQW3isw60VqRDMi+7jmEiQJ9UujE45ebb5WH7+JBOoO5X9e7T287H2r97sig/Sj+4pSI4vM6CZZGU4Zicw/j3jt+Xwm0Wy9JCYC+tYjfClYaToOpKKjH/CBUIz/5rricsKsixGzoVh9oClKiCBD22UAgWHjI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712463856; c=relaxed/simple;
	bh=6OATBPOVpS/ms3tqzNZDFhOAZJq2v3CoGie3cCKXJbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7a1ZeQHWCvFkIdBN+DU9pOwLczkg01Rf6c4Vp5H5cG3dxLTDCf/OXh5VnVeG8A4aGhMtrJhC2goDN5rIfgesikF/joCbHIgR41Hx2XxQ4wvdndVVZZfg4/6zh35ECeqgiiCiCGeXdUjvG9/QowEsYfG6OHrAXCFrhc2JzNIT18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJzGvJKJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJzGvJKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712463854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OATBPOVpS/ms3tqzNZDFhOAZJq2v3CoGie3cCKXJbA=;
	b=WJzGvJKJ907sv6fHU1FeZicx6wwkdmI5jGlqFgaVK4mmOm17gEfLjmqXhnGGCy9oW+H/E4
	y0Kw08o0QqUvUbGH5/VRcnKa5hOutzT/kv09DxlaDCm7rgvB8nTBwF5mgMDaFp4nzq7i9e
	Z5/rq3xh+KVyx8fed0gAJpNJbSJ8gB8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-r9Ka6UbnNIuEEQn5glW5bg-1; Sun, 07 Apr 2024 00:24:12 -0400
X-MC-Unique: r9Ka6UbnNIuEEQn5glW5bg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e278ebfea1so31614595ad.0
        for <virtualization@lists.linux.dev>; Sat, 06 Apr 2024 21:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712463851; x=1713068651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OATBPOVpS/ms3tqzNZDFhOAZJq2v3CoGie3cCKXJbA=;
        b=JCaDvrzVWKUMugAlU5Mnrd/fN5DXUgmRtHj1L67sjEnl/QcDic0Et09XYMdSJ+m2rn
         Y1yMO2ES9fLYHuodHSbKRVBZdn9O8j6NBuaZL51zKedhWuNBVvcD5/iCsZrYdVOJb20Q
         YFA0jmI1PqQN0Zf+ZpLYObowMsHp40nPF3bObPUPNKUGsIXjSEpH/j5FNHJ8F085yTbV
         S75yfjbuWyveAeI0TYPLmCrCqdKsaaDctLFPeQd28tyE4lKms+kWo+k107vqNxlpz+8O
         8J90srVexGcUW0CI7aLCA6PwVJE/IaGSNS8iN2fWtpgWJYEAO1Xl+/Xp+uTrCHbZOenk
         YhdA==
X-Gm-Message-State: AOJu0Yxb82EOEXdn3oDXV4CAXkjlcgEVUwj7XxAnrKjJzW8MBaSWOfiw
	pFyThPvWsknPeZ+5R3YM/2CAEv0w5t7sxPUyFaMNvByKcX0tDjF1TbQQq5nvhwj6Eb8gPAcdY3c
	ZdfksdynzYkfaoD1uc11bCdZxV4zvUGtpDI652uAjszwSU4q/3NnToYca/w7ZYDWd0FIha/Y6rF
	zU3+IIQLYK8mmB8LOpBhDp3pdZDz5Tt05gStcWllU=
X-Received: by 2002:a17:902:d386:b0:1e2:aa62:2fbf with SMTP id e6-20020a170902d38600b001e2aa622fbfmr6062727pld.45.1712463851640;
        Sat, 06 Apr 2024 21:24:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKJ9h6aWFRS908/Qz7yqmKf6aKfGWv/jyE2JG7Z9q5DRXsyL7vtatY26Z0jM6vN9jB1rSm9kjSYvAmi7qPeUk=
X-Received: by 2002:a17:902:d386:b0:1e2:aa62:2fbf with SMTP id
 e6-20020a170902d38600b001e2aa622fbfmr6062713pld.45.1712463851383; Sat, 06 Apr
 2024 21:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-10-xuanzhuo@linux.alibaba.com> <CACGkMEs=NZGkkA7ye0wY7YcPBPfbKkYq84KCRX1gS0e=bZDX-w@mail.gmail.com>
 <1711614157.5913072-7-xuanzhuo@linux.alibaba.com> <CACGkMEuBhfMwrfaiburLG7gFw36GuVHSbRTtK+FycrGFVTgOcA@mail.gmail.com>
 <1711935607.4691076-1-xuanzhuo@linux.alibaba.com> <1711940418.2573907-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711940418.2573907-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 7 Apr 2024 12:24:00 +0800
Message-ID: <CACGkMEvPZKa-au=2XaXrjT4t1vpPF4mPRNYNZ6uTPNyUpT8dfA@mail.gmail.com>
Subject: Re: [PATCH vhost v6 09/10] virtio_net: set premapped mode by find_vqs()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:10=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 1 Apr 2024 09:40:07 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com>=
 wrote:
> > On Fri, 29 Mar 2024 11:20:08 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Thu, Mar 28, 2024 at 4:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Thu, 28 Mar 2024 16:05:02 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > Now, the virtio core can set the premapped mode by find_vqs().
> > > > > > If the premapped can be enabled, the dma array will not be
> > > > > > allocated. So virtio-net use the api of find_vqs to enable the
> > > > > > premapped.
> > > > > >
> > > > > > Judge the premapped mode by the vq->premapped instead of saving
> > > > > > local variable.
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > ---
> > > > >
> > > > > I wonder what's the reason to keep a fallback when premapped is n=
ot enabled?
> > > >
> > > > Rethink this.
> > > >
> > > > I think you are right. We can remove the fallback.
> > > >
> > > > Because we have the virtio dma apis that wrap all the cases.
> > > > So I will remove the fallback from the virtio-net in next version.
> > >
> > > Ok.
> > >
> > > >
> > > > But we still need to export the premapped to the drivers.
> > > > Because we can enable the AF_XDP only when premapped is true.
> > >
> > > I may miss something but it should work like
> > >
> > > enable AF_XDP -> enable remapping
> > >
> > > So can we fail during remapping enablement?
> >
> >
> > YES.
> >
> > Enabling the premapped mode may fail, then we must stop to enable AF_XD=
P.
> >
> > AF-XDP requires that we export the dma dev to the af-xdp.
> > We can do that only when the virtio core works with use_dma_api.
> > Other other side, if we support the page-pool in future, we may have th=
e
> > same requirement.
>
> Rethink this.
>
> Enable premapped MUST NOT fail. No care the use_dma_api is true or not, b=
ecause
> we have the DMA APIs for virtio. Then the virtio-net rx will work with
> premapped (I will make the big mode work with premapped mode)

Just to make sure we're at the same page. Rx will always work in the
mode or pre mapping. So we can easily fail the probe if we fail to
enable RX premapping?

>
> AF_XDP checks the virtqueue_dma_dev() when enabling.
>
> But disabling premapped mode may fail, because that virtio ring need to
> allocate memory for dma.

That's kind of too tricky, what if we just allocate the memory for dma
unconditionally?

Thanks

>
> Thanks.
>
>
>
> >
> >
> > Thanks.
> >
> >
> > >
> > > THanks
> > >
> > > >
> > > > Thanks
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > >
> > >
> >
>

