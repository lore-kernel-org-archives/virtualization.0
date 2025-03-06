Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4111185B73
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741225062; cv=none; b=pRf19v10ZausGkxgKpzGbcqZDAv4bep8vvxD1PFb6R1l3Xe6QxGwNhEmthztMYnwHpbsAVJNbH660DWsuilEsxR7zah+sk+t+s86loxlYnz5yyPJNjFfH0r8DrZsJbhxXiyRQCgzn2IS9kLZ5YrquOmKwp7hmPNdNUWfPLiCwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741225062; c=relaxed/simple;
	bh=jt8oE1DDukSHhfGAEncsuyQqx3ir3OOa0dHNqoKOelY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTN17aPeQrcdBQzIVoTNQm0zg4SLHUyM877W/tj00iTiN/v8sg27agz0dMfLzq+edY2pzs8RtDJdVXYySNVzOmiiSPsiqYNz8etO8CvCfsA+GdtmChzRlAztCx8ffuTrxXQ24GMsXwOlys38Fiu+tlIM/BwQrdSDV2B6MkKwoAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmRjlZWK; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmRjlZWK"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29A9340794
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 01:37:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uaAilhT_4jXa for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Mar 2025 01:37:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C3FDE407A7
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3FDE407A7
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VmRjlZWK
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C3FDE407A7
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 01:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741225057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwJDzSbLHHnbA7u1yktm23jopFFzMjn7g9N2Exf0cfw=;
	b=VmRjlZWK2YZtElGV344lcd+z+gwzitqf91ScAoE0YwcnPMc/JFrUItM+ElWRWlZeO3C/LH
	Rw8OFPrhe+1Rffs0VFnUgmCijFPxRSnZ3Zt9fW5kctubeNEe/qVjF01Nu9urO8FBLN7saW
	84DLxwlWTYuwMQDvodHdAV2GMufkZm0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-cSJNmGkOPtCYhJfwLw3Q6w-1; Wed, 05 Mar 2025 20:37:35 -0500
X-MC-Unique: cSJNmGkOPtCYhJfwLw3Q6w-1
X-Mimecast-MFC-AGG-ID: cSJNmGkOPtCYhJfwLw3Q6w_1741225055
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abf5bf52939so13609466b.3
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Mar 2025 17:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741225055; x=1741829855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwJDzSbLHHnbA7u1yktm23jopFFzMjn7g9N2Exf0cfw=;
        b=IuSKgeSldH3GzKdn1UbiSsPOTwE+ojhMjCPyMm0+Oi+wp9Pvf/zGvExl9IAnSLFAyA
         Vxf1Qk3KVzFgIdmT1NgpTnw65YpMr3FYOeF4MkzAJhjTT6Ujlq0fJGOXsL7sPVR1LEho
         VptiC64J8gsKykAS3F+aGspyVBQ0VYzQiPp4zK9OHThstALUViUFe16EAeS0WzrQEH9M
         h23SDPxMVPYprbOe2v4MD6NDRD3Ut56P6HTP9DZrNNSJNDtDCP6d4L/iZ/YLJ2QEsnKe
         t2i5VaDyoP9RxzhBNXWByM2Rmc6Pf74aGCzLn+R5KM++38pa/vjVvVV/1gDYpePh+Jb5
         QVBA==
X-Forwarded-Encrypted: i=1; AJvYcCUxWDZfI0nBXcQKUSenGC+ITC3bz/8D0TriwSqPfHpeSI2HIAjNk86JUcCFS3LwLz5lAQ9A11xTI3WJDYNMlw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx0RQpNJgDFytR2kcUaUiHfEteWfkvU4oqUAxwXX/4lJ+07+isV
	35N8iTX3cTVdbncHvkFEhfQiaOuuKrPev7S2OrPWKxEo3Kx35sLVnBN0fPyoJvnCGZfH3Gd9q0O
	yR9iWOn8vCO9LMYNJBX96x8oSm1OaZDoEGnfS6JWufUDsGWL18fRYWRrjXGh93DmhgUGygPV8Qg
	b0EzsER58+RFszXq82kB70pGK/3QdV343Mm2VvCux57xSexfALVKg5pQ==
X-Gm-Gg: ASbGncuAoC7rk/bt+T23hffIszmwNeNyQIu3kKEy2PRj5ydz4dd9DRKvrBnJUbXCyby
	Y90KLvnAHPfO3awR+iWFIqA3UqGN8j+xmeZVfRuYGmSP2VV13S8s2DEe+paVXJ0n6qChubFVp5A
	==
X-Received: by 2002:a17:907:3f97:b0:abf:6225:c91d with SMTP id a640c23a62f3a-ac20db5625bmr437490666b.34.1741225054604;
        Wed, 05 Mar 2025 17:37:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9H1qhwvkDgDybNE5sW4VnwbCiQQmLm0SVfn0Ji7BN3QvZ4moN9FmVfiIH9jslgkkvztcXACeXl8wpC1dBMno=
X-Received: by 2002:a17:907:3f97:b0:abf:6225:c91d with SMTP id
 a640c23a62f3a-ac20db5625bmr437488266b.34.1741225054236; Wed, 05 Mar 2025
 17:37:34 -0800 (PST)
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
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 6 Mar 2025 09:36:57 +0800
X-Gm-Features: AQ5f1JoJEUufAEkLHWWULXhaNHkiqHvkFGZFpeTeSZ026lfQ3NJ0WwfBHHNypzs
Message-ID: <CAPpAL=xsDM4ffe9kpAnvL3AfQrKg9tpbDdbTGgSwecHFf5wSLA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1oMbCH6TmjaXCtsahj62lIUwBX1g1dAOFykimsP-S1s_1741225055
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series patch with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Mar 6, 2025 at 8:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
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
>
> >
> > I see vsock more as AF_UNIX than netdev.
>
> But you have a device in guest that differs from the AF_UNIX.
>
> >
> > I put in CC Jakub who was covering network namespace, maybe he has some
> > advice for us regarding this. Context [1].
> >
> > Thanks,
> > Stefano
> >
> > [1] https://lore.kernel.org/netdev/Z8edJjqAqAaV3Vkt@devvm6277.cco0.face=
book.com/
> >
>
> Thanks
>
>

