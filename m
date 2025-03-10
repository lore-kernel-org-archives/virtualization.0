Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19122CBD8
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616120; cv=none; b=Qrt99BMVfxwxg0sbOLzGbPRM23GQMhlomnrQWksWznKmKicEHt20p3DBxdusyBeIJKZiF9igikZmHJk0lyn4zMKKTTUA24/AXBlueCothV90VOWYiefAUSz27pDX6XwyZl/mztTYd/vWu00eBPlMem9OlWkCnHUk53HNKho1LvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616120; c=relaxed/simple;
	bh=jEa1MxsrpS1cHMT2RYO8VBbSWB07INDb5JSIrlBAMRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHWjkt7Cu2opFVrgHrf79EteR80Yy5A5nvv2E/SVWKNPfheUZ/MF3J6Q/uHwb/OYPLhutqKfqwda6RlQqM88zvCiWAay1N1UA6Z1pQO8L0ehdk0pMrtXRaQQCmVkjfT/FT3qTSasz7tLUN6VYdoOyqyUs0Yub35etnFqB63Ww+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlWBzW06; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlWBzW06"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 958F060860
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 14:15:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9TolpWa_yZwQ for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Mar 2025 14:15:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 772AE6081B
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 772AE6081B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZlWBzW06
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 772AE6081B
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 14:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741616115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMdCg2efbd0Qh20QNdOF7eXxFbnyvCBURzGryJnLYK4=;
	b=ZlWBzW06Bluy4VzExRaK4ayZYSiDs8LPwpkDguXTs3WbCVKv0CLgv4NBN1If9Jqgd9y8Vz
	/1oivDfpwE9bSDyNZ5vCeTJs6eaoe1ax5dowEMDTM1aAUpC2o+VWefHG/SypUK9GhZ2yba
	21phsvpvIClAKULi3wOPY7TmIQ/8iSQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-Lgkmsh75No23IOe77onZbA-1; Mon, 10 Mar 2025 10:15:11 -0400
X-MC-Unique: Lgkmsh75No23IOe77onZbA-1
X-Mimecast-MFC-AGG-ID: Lgkmsh75No23IOe77onZbA_1741616111
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6fed889e353so30738927b3.3
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 07:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616111; x=1742220911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMdCg2efbd0Qh20QNdOF7eXxFbnyvCBURzGryJnLYK4=;
        b=uoo3PGxRUZkdd1QOxEzcFRIEC/g+cqJ+NYCddB9OwfgbWS2Dj2J9L9B1mip+tBvWTk
         Bd2Y7GQP4q5K4NvpI+I90WmU/QhBmvsJ6CXVO/M2mMQLatzBQ5LaBuOTQiuhpxCmNnb4
         QLkL5bHZSq2TD5kS/21cPLkat3JueWELwx85fBaSgcoIf50H4AvtKt+XPr2m4DQDvzCt
         OsIWTcILLq9VyeiHuj9lPozY6WNjNpOOpsSo1wOyxzzgsmdM4vqnN9XgkJy3cIMhTqQ9
         72srijqxcEyFY+aZqxdH4LiOMinQgZc2u4OAgXN+jDL5qeEIdjzFIfNv2qoz1WO9r71T
         1NvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFt1D9N6Ibu+k4ChTLwzaes2L/zSseuGI9HvqyYpvLxP3yZbnCyuUqVxNvutXD4ovdbhIYUlXpi8Eg5Gsl0A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxi7aFbbqdohUCh+1WD0JXZMnAJH0pIHS01Is2ZXzrvGEodsvYh
	KikCFfq8W5vCDITA00i42WvfYOVKt2GWwUekqavtLALluP2XP4CZ/IZlXELbizbq5toVehN2g8+
	Wd5d+uUQed1xqwDykrhTik4xKqg0/u3aTuq0U8TqzIpo/K7amO6fcYSzGL8u74R6X0/EcquIgqK
	+6TpEDUjQEZWt0TV5LikA52fAjOobxE/a/fIcYP2PFAYYAQTk9TCROxw==
X-Gm-Gg: ASbGncsEwAf7KFTg7F8vl80jnLPfM3cOFRxJ5iUSVHJobH0KSaAVK6dgpL+/eJTOiTL
	XUrmY6zWnUY9ZzwYqzmp5AnfPkxwHKrNttnkNQ3Bgqa3xRGlV5j6L9b8846vyBzDLJLCMFuA=
X-Received: by 2002:a05:6902:2805:b0:e60:9d12:c1e5 with SMTP id 3f1490d57ef6-e635c1d8d02mr14992230276.36.1741616111109;
        Mon, 10 Mar 2025 07:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUqWrvAukg1iFDpO6ExBXHje3cw437GoWuPupbevVNTptRCcjP/uO3Bp+OM9ocpYHlDfKvsiQX6/BEdrkJbTU=
X-Received: by 2002:a05:6902:2805:b0:e60:9d12:c1e5 with SMTP id
 3f1490d57ef6-e635c1d8d02mr14992171276.36.1741616110694; Mon, 10 Mar 2025
 07:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com> <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com> <20250305022248-mutt-send-email-mst@kernel.org>
 <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt> <CACGkMEvms=i5z9gVRpnrXXpBnt3KGwM4bfRc46EztzDi4pqOsw@mail.gmail.com>
In-Reply-To: <CACGkMEvms=i5z9gVRpnrXXpBnt3KGwM4bfRc46EztzDi4pqOsw@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 10 Mar 2025 15:14:59 +0100
X-Gm-Features: AQ5f1JosWWXY88zUmFjBrkclv9qmpGDLsUUZ5bj0pBV0c8sMAT4CMg2t-YayKWI
Message-ID: <CAGxU2F7SWG0m0KwODbKsbQipz6WzrRSuE1cUe6mYxZskqkbneQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gr6P9MVfn3OOX7MSG2rg0AgbkFgFF4hW9TuTUhvuhbA_1741616111
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 at 01:17, Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Mar 5, 2025 at 5:30=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
> >
> > On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
> > >On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> > >> I think it might be a lot of complexity to bring into the picture fr=
om
> > >> netdev, and I'm not sure there is a big win since the vsock device c=
ould
> > >> also have a vsock->net itself? I think the complexity will come from=
 the
> > >> address translation, which I don't think netdev buys us because ther=
e
> > >> would still be all of the work work to support vsock in netfilter?
> > >
> > >Ugh.
> > >
> > >Guys, let's remember what vsock is.
> > >
> > >It's a replacement for the serial device with an interface
> > >that's easier for userspace to consume, as you get
> > >the demultiplexing by the port number.
>
> Interesting, but at least VSOCKETS said:
>
> """
> config VSOCKETS
>         tristate "Virtual Socket protocol"
>         help
>          Virtual Socket Protocol is a socket protocol similar to TCP/IP
>           allowing communication between Virtual Machines and hypervisor
>           or host.
>
>           You should also select one or more hypervisor-specific transpor=
ts
>           below.
>
>           To compile this driver as a module, choose M here: the module
>           will be called vsock. If unsure, say N.
> """
>
> This sounds exactly like networking stuff and spec also said something si=
milar
>
> """
> The virtio socket device is a zero-configuration socket communications
> device. It facilitates data transfer between the guest and device
> without using the Ethernet or IP protocols.
> """
>
> > >
> > >The whole point of vsock is that people do not want
> > >any firewalling, filtering, or management on it.
>
> We won't get this, these are for ethernet and TCP/IP mostly.
>
> > >
> > >It needs to work with no configuration even if networking is
> > >misconfigured or blocked.
>
> I don't see any blockers that prevent us from zero configuration, or I
> miss something?
>
> >
> > I agree with Michael here.
> >
> > It's been 5 years and my memory is bad, but using netdev seemed like a
> > mess, especially because in vsock we don't have anything related to
> > IP/Ethernet/ARP, etc.
>
> We don't need to bother with that, kernel support protocols other than TC=
P/IP.

Do we have an example of any other non-Ethernet device that uses
netdev? Just to see what we should do.

I'm not completely against the idea, but from what I remember when I
looked at it five years ago, it wasn't that easy and straightforward
to use.

>
> >
> > I see vsock more as AF_UNIX than netdev.
>
> But you have a device in guest that differs from the AF_UNIX.

Yes, but the device is simply for carrying messages.
Another thing that makes me think of AF_UNIX is the hybrid-vsock
developed by Firecracker [1] that we also reused in vhost-user-vsock
[2], where the mapping between AF_VSOCK and AF_UNIX is really
implemented.

Thanks,
Stefano

[1] https://github.com/firecracker-microvm/firecracker/blob/main/docs/vsock=
.md#firecracker-virtio-vsock-design
[2] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock

