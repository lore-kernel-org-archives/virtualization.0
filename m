Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA6207DF0
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249405; cv=none; b=o+XGSPxXMvVUe1glbtRGMRzgNxe29qtTD14ABTiC4dmyA5yURSrtdyIMN+hi2KmAjkXdGMSD3XHcKqGXE3/BFeuXGCCeNZpIVktf03sVtjgZ6ZI7FvYM81h44YHLqphl1V0DPFGvlo1iAuxYjHb8gj/6ftr1QaHEZESEL2chWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249405; c=relaxed/simple;
	bh=LAESgKwjsOolqILQ7EFqXdhdFKselMeHOYpzQPd3EDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Li8iqrARA2zW8Xu9zBHPGli72rm2Pu8MjpFzu8bOAZL5+h1KkLo8LSBVKoYhJS7FIIUsVBiZZ1WfyNOPh1fnyscNDX1eI4YMu05TCEl/njBn3PPH/CV4urn6XA2cCKpqttGamD9LYZhAlHdyVVVNltnnP6lKPP1L80dV4tXYrkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCMvjh/s; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCMvjh/s"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 852E7412BF
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 08:23:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uqtsl00G655Q for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Mar 2025 08:23:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 28BE6412BA
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 28BE6412BA
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OCMvjh/s
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 28BE6412BA
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 08:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741249399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7r18lDDaYnSU7d2JOl6qmtUJzAYao+io6UYl9OANnk=;
	b=OCMvjh/sVRVOPWqAt4l3U1SaxvT/BqqVRc8rQgcPwkDDap7t8sb+bmvqf49PbCKlhKP9dS
	zPtlf50FUttDRWhtmqnCjbjxoosks/43aod2vYy2TZwpsVY1T1JkcmnX2jzTeWqiknqleS
	Fn+IrJEzfQ0cpEFliS2XvhGmt4R/iJI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-UyKGaWLON-qjrlTBqYuovA-1; Thu, 06 Mar 2025 03:23:18 -0500
X-MC-Unique: UyKGaWLON-qjrlTBqYuovA-1
X-Mimecast-MFC-AGG-ID: UyKGaWLON-qjrlTBqYuovA_1741249398
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6feb222677dso5611207b3.2
        for <virtualization@lists.linux-foundation.org>; Thu, 06 Mar 2025 00:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249398; x=1741854198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7r18lDDaYnSU7d2JOl6qmtUJzAYao+io6UYl9OANnk=;
        b=kmoV2c5boqM+F3OanJP7lIzPGKO4d7coHXearK/fmNRvggLBzAB6r6rh9+a41jjuGA
         SOiQkr2e3vbJfmX9kzjHWjs87unnJ7P7AWO5mEO9LpXA1qu2ooWCGdf5bjuOoD2bwLNk
         K++5AxpxjN5tjSJW9hkvvCeR4Q4wWmTr0ePGG7g1+ZM9SApG67TdeTw+2DbpAb7XnA2i
         wxjkWRqzM4n9Xj3mf9L87zod/GDPKi6ELhB1FDLywSof/YtY64bHArHO2qbSJmX1WrlA
         5Q9QsE2uBycGUQcTQXUYLisCJe0e8EttfsbeUFsqdFIf+HyO7a7VcXN5AQxEh3+yen1Q
         +0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUweW64WqJlpex0rLzIxrwLRytMozxmOq/EOJe+LKmmOCLxmV88yCb+drcs10PZ1ZdSnDEdVKUQjHB9SgQ/6Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwMSpJ6YsNrffsL8o8zeEL8R2+5iC37gycj7z47nmvck343Ikje
	FT7J3g+hqgs69BdLS/hTfMW8IpxozGakKKmYxt4vDAYUYv62dtTSUPj9CSFLtmMbtzb+9TpQAFH
	TIpE5zkk3SoOLo/vGLNQDvDJ7E06a4ZKcygvzaIKUvuJ32f2Nauyw+0AU1bxY9/GuzbMgN8bh+7
	Amlo6gq6zlFpisjTr4ATnbX5dOlxPFQsY8OhP3BGAf5ufKvcqHkHfgOA==
X-Gm-Gg: ASbGncvdFM+JzLqsZiJ875e0YTHboIo3X6ezqkHkTTp1sYUTaBGH5o/Yn1TGEBhKEIp
	4//KJFT4zXLNoJ0SKDLj0eNiWS4MrLxOgIFJp//60XRdH9ZjvMKjeEX69P1AVFjvexzqjyBE=
X-Received: by 2002:a25:1ec2:0:b0:e63:474e:c861 with SMTP id 3f1490d57ef6-e634eef0b1fmr718509276.25.1741249398214;
        Thu, 06 Mar 2025 00:23:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7nJyNaHwTKfCFf2zsd6PiaEGoXlfFh+yzGhdtdq5/XYd3bHYtIZ0oKB/mltmXYT1qA2ZSl8TLqva2zRpXEPU=
X-Received: by 2002:a25:1ec2:0:b0:e63:474e:c861 with SMTP id
 3f1490d57ef6-e634eef0b1fmr718493276.25.1741249397848; Thu, 06 Mar 2025
 00:23:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com> <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com> <20250305022248-mutt-send-email-mst@kernel.org>
 <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt>
 <CACGkMEvms=i5z9gVRpnrXXpBnt3KGwM4bfRc46EztzDi4pqOsw@mail.gmail.com> <CAPpAL=xsDM4ffe9kpAnvL3AfQrKg9tpbDdbTGgSwecHFf5wSLA@mail.gmail.com>
In-Reply-To: <CAPpAL=xsDM4ffe9kpAnvL3AfQrKg9tpbDdbTGgSwecHFf5wSLA@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 6 Mar 2025 09:23:05 +0100
X-Gm-Features: AQ5f1JohM_t7j7Fpc0COSkCeLVhsbQLpCfbrtS-97yp_c3OjYm5Amp7QVm4NzL8
Message-ID: <CAGxU2F7_0hXc-0hasa-_p_0z6nGCY6bsF_49ZRRN2mKZEJcziw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Lei Yang <leiyang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4XK6LoMLpXbF8dAwjEnCuFWwJUz-XebDOUSHoFaiahg_1741249398
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 at 02:37, Lei Yang <leiyang@redhat.com> wrote:
>
> QE tested this series patch with virtio-net regression tests,
> everything works fine.
>
> Tested-by: Lei Yang <leiyang@redhat.com>

Sorry, but this test doesn't involve virtio-net at all, so what is the
point on testing it with virtio-net?

Thanks,
Stefano

>
> On Thu, Mar 6, 2025 at 8:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Wed, Mar 5, 2025 at 5:30=E2=80=AFPM Stefano Garzarella <sgarzare@red=
hat.com> wrote:
> > >
> > > On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
> > > >On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> > > >> I think it might be a lot of complexity to bring into the picture =
from
> > > >> netdev, and I'm not sure there is a big win since the vsock device=
 could
> > > >> also have a vsock->net itself? I think the complexity will come fr=
om the
> > > >> address translation, which I don't think netdev buys us because th=
ere
> > > >> would still be all of the work work to support vsock in netfilter?
> > > >
> > > >Ugh.
> > > >
> > > >Guys, let's remember what vsock is.
> > > >
> > > >It's a replacement for the serial device with an interface
> > > >that's easier for userspace to consume, as you get
> > > >the demultiplexing by the port number.
> >
> > Interesting, but at least VSOCKETS said:
> >
> > """
> > config VSOCKETS
> >         tristate "Virtual Socket protocol"
> >         help
> >          Virtual Socket Protocol is a socket protocol similar to TCP/IP
> >           allowing communication between Virtual Machines and hyperviso=
r
> >           or host.
> >
> >           You should also select one or more hypervisor-specific transp=
orts
> >           below.
> >
> >           To compile this driver as a module, choose M here: the module
> >           will be called vsock. If unsure, say N.
> > """
> >
> > This sounds exactly like networking stuff and spec also said something =
similar
> >
> > """
> > The virtio socket device is a zero-configuration socket communications
> > device. It facilitates data transfer between the guest and device
> > without using the Ethernet or IP protocols.
> > """
> >
> > > >
> > > >The whole point of vsock is that people do not want
> > > >any firewalling, filtering, or management on it.
> >
> > We won't get this, these are for ethernet and TCP/IP mostly.
> >
> > > >
> > > >It needs to work with no configuration even if networking is
> > > >misconfigured or blocked.
> >
> > I don't see any blockers that prevent us from zero configuration, or I
> > miss something?
> >
> > >
> > > I agree with Michael here.
> > >
> > > It's been 5 years and my memory is bad, but using netdev seemed like =
a
> > > mess, especially because in vsock we don't have anything related to
> > > IP/Ethernet/ARP, etc.
> >
> > We don't need to bother with that, kernel support protocols other than =
TCP/IP.
> >
> > >
> > > I see vsock more as AF_UNIX than netdev.
> >
> > But you have a device in guest that differs from the AF_UNIX.
> >
> > >
> > > I put in CC Jakub who was covering network namespace, maybe he has so=
me
> > > advice for us regarding this. Context [1].
> > >
> > > Thanks,
> > > Stefano
> > >
> > > [1] https://lore.kernel.org/netdev/Z8edJjqAqAaV3Vkt@devvm6277.cco0.fa=
cebook.com/
> > >
> >
> > Thanks
> >
> >
>

