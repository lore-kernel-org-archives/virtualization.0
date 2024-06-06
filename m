Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E913BC26
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675265; cv=none; b=pQmN0LoauCepFXu7jwDC9Rs1OQXN/hfVP8VLtkah3E1BMOMSiQ2SfQM975o9RL958m/PKVduzt6sgC5iYbcpZqIbzoXtGu4/jQHlJKjJ9QDUtjzf9nEZm8VV23c4fpblveJurbaIiKzX1lUBKEbvNHRGz4b4vrLXF+83rC+eN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675265; c=relaxed/simple;
	bh=VE9LD88tG1B8qpR9VqW3jtsJJ1umFxLdZM4g0IpzOAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u0TZxYRVXIpEjr6PBqx3wU8+ovPINKlx6c/7fRofrm6fLhiTV13a/7Ow0u8Loj1Wb8+eIzE8T6FMDwz84gYKkowmli+iwHIrMBH2ohsQ+8m81lNN6c/lllPgN9QxUUhBsAoDf1NbdGBFCQhJ0TnvHuRFIchdh8qqK9fgvqBH4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFK7woP3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFK7woP3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717675262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4S9PyIZ2WPPemiOD/j57hDL0LYoz1XGW158BpHw80Q=;
	b=DFK7woP39nLLH9iEevtgV1yu5IT9a5bktxCedokQdiXYpvb9FFn46EpWxpUeoegl4+R9EE
	2Kz0+q3Whprbe6ZE4gt82gMMhvAJjSvQ4JuQ4pjk1sVsMuNleWNfrXU819lZ6QKcqULCfN
	VSWqu72oKywTFCFDOvXiDK8ZaqVHPCY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-i7ckPS2ENPKss8Zg7ArLhw-1; Thu, 06 Jun 2024 08:01:01 -0400
X-MC-Unique: i7ckPS2ENPKss8Zg7ArLhw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-57a61b52181so268778a12.3
        for <virtualization@lists.linux.dev>; Thu, 06 Jun 2024 05:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717675260; x=1718280060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4S9PyIZ2WPPemiOD/j57hDL0LYoz1XGW158BpHw80Q=;
        b=PXWyXDPfmWP64pZ6tV45vw6cd895xQmu+U5lkFBWNLN1I6K5rerOKsf/mzHswej+Mv
         s+DqztAsgknHT3H0ArmmZR7pHRrS5r9Nhg9jXVtAgxzFxxuEPLIEC/Kbpcf6p8m1nbod
         r9hKk4RtSpzf0LfeOwAN8ESaO4vEYFKKxBqR+eox0jRZUkAa3sqjkNoIO/5YZe+9dsTw
         FtU6Uebp0TMhFq9abcecWzZggL+ph4/6qW8gWQpIS6PV7vILhNx4OzvgOpg8rwf85IXj
         el25D/2T0rEtaa4mJKkZwWu57+74putbOVAN3CkkuACZPBMUc5RR5FLLgpV3+vG2yPfj
         +tcw==
X-Forwarded-Encrypted: i=1; AJvYcCVUiNT3p0xZ5yM5Glw5AI7JYljpxG62JYFlu0Oap1qzGFKbAEU6qnz/tFmAsOZwHuUxBFXJLoyT78ZENbRHG0oppMlRRa83B8wICQw7QEY=
X-Gm-Message-State: AOJu0YxHo/24BdTJx6MjVg7XFX7sbByCHrbeJmTyTggmEWvg6m6b6OmO
	VvfsvOTXBsNrLaLz3Mgl82Q+jsPmiBlvnUMfdev7pYhoSQHx7TJucRLxz15XAs0N+V6dwwIE4FF
	SkJsIFRJModmDiYliSlGthfiy0XPniYzi5zp7cI76faRAKiA9s+ovovi4Gm78ExvpOYXvmYv8
X-Received: by 2002:a50:c88a:0:b0:57a:321f:cc4f with SMTP id 4fb4d7f45d1cf-57a8b6f1b0emr3501160a12.19.1717675259565;
        Thu, 06 Jun 2024 05:00:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB7Vks4wFFWfi34BdrVfF+Y5s/7VwpN5xp0R8MpdVPxup8WU6P2hYMotoXBQEc2co8tC+S0Q==
X-Received: by 2002:a50:c88a:0:b0:57a:321f:cc4f with SMTP id 4fb4d7f45d1cf-57a8b6f1b0emr3501139a12.19.1717675258923;
        Thu, 06 Jun 2024 05:00:58 -0700 (PDT)
Received: from redhat.com ([2.55.8.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae202396sm973075a12.74.2024.06.06.05.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 05:00:53 -0700 (PDT)
Date: Thu, 6 Jun 2024 08:00:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240606075842-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
 <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <CAL+tcoA3JpS3S6Hzwpc5F0dzm92AnfYfqj-4uLmTsgQ5hj1fTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAL+tcoA3JpS3S6Hzwpc5F0dzm92AnfYfqj-4uLmTsgQ5hj1fTA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 06, 2024 at 07:42:35PM +0800, Jason Xing wrote:
> On Thu, Jun 6, 2024 at 12:25 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jun 6, 2024 at 10:59 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > >
> > > Hello Jason,
> > >
> > > On Thu, Jun 6, 2024 at 8:21 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Wed, Jun 5, 2024 at 7:51 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > > >
> > > > > On Wed, 5 Jun 2024 13:30:51 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > > > > > Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
> > > > > > >Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wrote:
> > > > > > >>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > > > > > >>> From: Jiri Pirko <jiri@nvidia.com>
> > > > > > >>>
> > > > > > >>> Add support for Byte Queue Limits (BQL).
> > > > > > >>
> > > > > > >>Historically both Jason and Michael have attempted to support BQL
> > > > > > >>for virtio-net, for example:
> > > > > > >>
> > > > > > >>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
> > > > > > >>
> > > > > > >>These discussions focus primarily on:
> > > > > > >>
> > > > > > >>1. BQL is based on napi tx. Therefore, the transfer of statistical information
> > > > > > >>needs to rely on the judgment of use_napi. When the napi mode is switched to
> > > > > > >>orphan, some statistical information will be lost, resulting in temporary
> > > > > > >>inaccuracy in BQL.
> > > > > > >>
> > > > > > >>2. If tx dim is supported, orphan mode may be removed and tx irq will be more
> > > > > > >>reasonable. This provides good support for BQL.
> > > > > > >
> > > > > > >But when the device does not support dim, the orphan mode is still
> > > > > > >needed, isn't it?
> > > > > >
> > > > > > Heng, is my assuption correct here? Thanks!
> > > > > >
> > > > >
> > > > > Maybe, according to our cloud data, napi_tx=on works better than orphan mode in
> > > > > most scenarios. Although orphan mode performs better in specific benckmark,
> > > >
> > > > For example pktgen (I meant even if the orphan mode can break pktgen,
> > > > it can finish when there's a new packet that needs to be sent after
> > > > pktgen is completed).
> > > >
> > > > > perf of napi_tx can be enhanced through tx dim. Then, there is no reason not to
> > > > > support dim for devices that want the best performance.
> > > >
> > > > Ideally, if we can drop orphan mode, everything would be simplified.
> > >
> > > Please please don't do this. Orphan mode still has its merits. In some
> > > cases which can hardly be reproduced in production, we still choose to
> > > turn off the napi_tx mode because the delay of freeing a skb could
> > > cause lower performance in the tx path,
> >
> > Well, it's probably just a side effect and it depends on how to define
> > performance here.
> 
> Yes.
> 
> >
> > > which is, I know, surely
> > > designed on purpose.
> >
> > I don't think so and no modern NIC uses that. It breaks a lot of things.
> 
> To avoid confusion, I meant napi_tx mode can delay/slow down the speed
> in the tx path and no modern nic uses skb_orphan().

Clearly it's been designed for software NICs and when the
cost of interrupts is very high.

> I think I will have some time to test BQL in virtio_net.
> 
> Thanks,
> Jason

