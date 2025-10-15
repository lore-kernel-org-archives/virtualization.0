Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF96248893
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515753; cv=none; b=D9V0qM8BECYhFjmgz88TBeYs5SodI0GPYuVXg3neX79ZZjRRKWwcTWjfNntCuQlnFbA7m464LO7VVWIrdkuJRfQVBNCkcn9MELDIFJ0TDxV65hSXEUNxAsIfH9MnrLZ7jhBDyFB7WB/5KXWH+nAYlDLNWoJrvjF+1wHx5dw58aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515753; c=relaxed/simple;
	bh=Bp2KX7ytxkHuVuPESpUWA2hLtp4yHoQ+zo3q+JOjV1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k4qs/406VxL+DHdEt+jVVerjlhrXNw83M1BNENM/k4xbKdH/ESmf1aRqiPruo4MTuORiPLE44k7RRGRzxviQvoNIF1o/VvvVVgBtkPbhOPu5KhoosEew+VoVszaR63GILe6LeJkmtWf4tduppRxosd7JsEQFah8nAbQDzeAeHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHp3f0T8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHp3f0T8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760515751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSYriq0cvXoIE3Z2j1WOX3qlPwrgXWcVASIuUgZ48jU=;
	b=bHp3f0T852ihH0vMA08ki3Ye19jUZbXiUAkEvZqolr+8RGW/SVEgMV8aYa8/1D76Feczq9
	+TwRlOVfAv/OA4/NjHbWUYIMiiKZnWCzRykZbgBn71bOdJ6IqApiHnYaF3RE/lDazeJzZE
	9jZxat+w/bD4goTb7kJlCBfaum5qq30=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-HnJIEWJANwC0GdqD_ASyvA-1; Wed, 15 Oct 2025 04:09:09 -0400
X-MC-Unique: HnJIEWJANwC0GdqD_ASyvA-1
X-Mimecast-MFC-AGG-ID: HnJIEWJANwC0GdqD_ASyvA_1760515749
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee13baf21dso5088417f8f.0
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 01:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760515748; x=1761120548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSYriq0cvXoIE3Z2j1WOX3qlPwrgXWcVASIuUgZ48jU=;
        b=sQOSqKhoii6o6MMOhPUuBOpnEZVLpXaYBSQMi2RzqRh/YYNRkH5lXYhO826gnvezVi
         155DapQkxaEVM7q5j+xkxWlJiEj/+bChzi8aRDZBRsIQVjE6zrwGMJsd+73yy/R/UKhb
         LXgYVO5hUlMy0c4lECqj2WRmYupOLS7LXakdOskTuaEiBqGyfH3UaOaItm6NYqRYEp3b
         NxXB5aNfLAJ0oFpVKuzM3l76SUi+a6ccHQHI7sji0yFGuZqbbq0vq72gFT4TGHz7EV5m
         bNgkM+PRlnhwyALbbJcKEoqwQtu6ZQjgIFIhp1F5yTFgAxfrg42vYJjxNKNh8sFkQ6sU
         7YaA==
X-Forwarded-Encrypted: i=1; AJvYcCVGP02QPDOR1mNzKO6PP6JoWmBjno7wVIvjapCkqN8asMWWX6Ve3aV+GmmyqezspWRGY0U9qpj1cE3c/zAd3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVYCmk71NUEjXjWuPZGlwL6ZJnlX6v64SEgTv7i6lwoE06tk7H
	nEKugekwOvr7otWOhqapPZBZDEblZigtlNTWE3HDCkAFGBBVb/+bS6RkQQkywhCjBj5bWRKyfTw
	j7GRNf2G4G/Odo+uz5R0/Q5GzkwVM+9MLyeeSLU4qDbdlnZYtFntUGLQtQWDKECfHLoYQ
X-Gm-Gg: ASbGncsPOTbCmp0vDMaMtJ288NVrMKQ40m77Kv7fvz6gzgZdyHvFutXvE4GmDPVffSo
	Qs7AReT1DlOGTQ+4auYM3wJzYwnxEJirFrLsTIBfNj2zQbrpdVPPd7dmxqG8f9ZVkDGSXvOBK8L
	glWNKgSOE+Lqwhe7Q3dUCKz59NNYJvpfIrDWKbLLqVC1GYOQAMrttrM0stXdVrd1LEgIvpAf9u4
	T+2I07mtfv/AknlzZYpEriurAqHedK5cpmxJBicezywYb6eHK9UmymPvnyu63aU3cs4/PYvK9AS
	PrMm/kkbuK+O61+9/ZMK9bZjirbHatpOwg==
X-Received: by 2002:a05:6000:288c:b0:3e4:d981:e312 with SMTP id ffacd0b85a97d-4266e8e51f2mr16811839f8f.62.1760515748413;
        Wed, 15 Oct 2025 01:09:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCYEbMZHqRxfg1VSwxLTgxZHiBhAkYhnsx+4h6lUKE87xBVOPm71dXz6S0eHcpwIqMZyaseQ==
X-Received: by 2002:a05:6000:288c:b0:3e4:d981:e312 with SMTP id ffacd0b85a97d-4266e8e51f2mr16811804f8f.62.1760515747614;
        Wed, 15 Oct 2025 01:09:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e83e1sm27796020f8f.51.2025.10.15.01.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:09:07 -0700 (PDT)
Date: Wed, 15 Oct 2025 04:09:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <mcoqueli@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251015040722-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org>
 <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org>
 <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org>
 <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yn-Z1oJxXxSbUa5i9C8-ShbDsyZ9TncG55P_z9G11LQ_1760515749
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 15, 2025 at 10:03:49AM +0200, Maxime Coquelin wrote:
> On Wed, Oct 15, 2025 at 9:45 AM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Wed, Oct 15, 2025 at 9:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wrote:
> > > > On Wed, Oct 15, 2025 at 8:33 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin wrote:
> > > > > > On Tue, Oct 14, 2025 at 11:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > > > > > > On Tue, Oct 14, 2025 at 10:29 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> > > > > > > > > > An userland device implemented through VDUSE could take rtnl forever if
> > > > > > > > > > the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> > > > > > > > > > device if it does not return the buffer in a longer-than-assumible
> > > > > > > > > > timeout.
> > > > > > > > >
> > > > > > > > > So now I can't debug qemu with gdb because guest dies :(
> > > > > > > > > Let's not break valid use-cases please.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Instead, solve it in vduse, probably by handling cvq within
> > > > > > > > > kernel.
> > > > > > > >
> > > > > > > > Would a shadow control virtqueue implementation in the VDUSE driver work?
> > > > > > > > It would ack systematically messages sent by the Virtio-net driver,
> > > > > > > > and so assume the userspace application will Ack them.
> > > > > > > >
> > > > > > > > When the userspace application handles the message, if the handling fails,
> > > > > > > > it somehow marks the device as broken?
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Maxime
> > > > > > >
> > > > > > > Yes but it's a bit more convoluted  than just acking them.
> > > > > > > Once you use the buffer you can get another one and so on
> > > > > > > with no limit.
> > > > > > > One fix is to actually maintain device state in the
> > > > > > > kernel, update it, and then notify userspace.
> > > > > > >
> > > > > >
> > > > > > I thought of implementing this approach at first, but it has two drawbacks.
> > > > > >
> > > > > > The first one: it's racy. Let's say the driver updates the MAC filter,
> > > > > > VDUSE timeout occurs, the guest receives the fail, and then the device
> > > > > > replies with an OK. There is no way for the device or VDUSE to update
> > > > > > the driver.
> > > > >
> > > > > There's no timeout. Kernel can guarantee executing all requests.
> > > > >
> > > >
> > > > I don't follow this. How should the VDUSE kernel module act if the
> > > > VDUSE userland device does not use the CVQ buffer then?
> > >
> > > First I am not sure a VQ is the best interface for talking to userspace.
> > > But assuming yes - just avoid sending more data, send it later after
> > > userspace used the buffer.
> > >
> >
> > Let me take a step back, I think I didn't describe the scenario well enough.
> >
> > We have a VDUSE device, and then the same host is interacting with the
> > device through the virtio_net driver over virtio_vdpa.
> >
> > Then, the virtio_net driver sends a control command though its CVQ, so
> > it *takes the RTNL*. That command reaches the VDUSE CVQ.
> >
> > It does not matter if the VDUSE device in the userland processes the
> > commands through a CVQ, reading the vduse character device, or another
> > system. The question is: what to do if the VDUSE device does not
> > process that command in a timely manner? Should we just let the RTNL
> > be taken forever?
> >
> 
> My understanding is that:
> 1. Virtio-net sends a control messages, waits for reply
> 2. VDUSE driver dequeues it, adds it to the SCVQ, replies OK to the CVQ
> 3. Userspace application dequeues the message from the SCVQ
>  a. If handling is successful it replies OK
>  b. If handling fails, replies ERROR
> 4. VDUSE driver reads the reply
>  a. if OK, do nothing
>  b. if ERROR, mark the device as broken?
> 
> This is simplified as it does not take into account SCVQ overflow if
> the application is stuck.
> If IIUC, Michael suggests to only enqueue a single message at the time
> in the SVQ,
> and bufferize the pending messages in the VDUSE driver.

Not exactly bufferize, record.  E.g. we do not need to send
100 messages to enable/disable promisc mode - together they
have no effect.

-- 
MST

