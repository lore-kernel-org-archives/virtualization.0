Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A11DF749
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 00:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741654516; cv=none; b=I3td27TLMSGVaI8Nair4GE+5B7ryxdqoC8FJ+/2sfvaL/B6aLXFVxqwlyGILJSgztWlPO8jHU/ZRqXqQdxZOxJfvPHFvw2adxLv96dLstmdx/iwXJ627QsZfpC95PpxDYLQhU2JcdxMi1yS4Es1G0RCEVTaiJM1tUOq3oIz4A5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741654516; c=relaxed/simple;
	bh=3fsAIf5wHFxnMvfeS5Vh1clVxlVj7KXR0xGOyiLkYaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3v0n1LrxfQFdZcTDtiBskHkS4u8+npuSecEKZIn6whnZAxYsffKjs69R55ckKV0mzBWaADR8BN6xxBXSsb884pxw0KjDYjLMFcClcZMIkIA45ls3BDXG6zdTQmkAnWK/Cdm71z4D/DezA0PTJ16DuZSDYGesO9jvyQNFKYnKds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6HryJSI; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6HryJSI"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A4F8402E3
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 00:55:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GtKGwer8goUL for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Mar 2025 00:55:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A1121400C5
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1121400C5
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C6HryJSI
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A1121400C5
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 00:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741654511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2Py8G36+UkX5eKsf40xMemSQMNbOrMlyvipkmsMT5g=;
	b=C6HryJSI8SIXnw/X1tBHfRwuwLZGU73VVuWuujp1PuOFh/XLM2Wvre5EDuJbNy1T8hgN33
	V7MSqDQCIsRP107NKJAkiwyzmvi2/mmWKMAHQqe1w9RagHngDnlX6cyeHdEJ1WjubMIx2l
	xQAMhLd+FKqwwq+yT5nC73VD24aDXSo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-06A48rsEMrGFjmEmyq_wSQ-1; Mon, 10 Mar 2025 20:55:08 -0400
X-MC-Unique: 06A48rsEMrGFjmEmyq_wSQ-1
X-Mimecast-MFC-AGG-ID: 06A48rsEMrGFjmEmyq_wSQ_1741654508
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fecd603bb8so8339699a91.3
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 17:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741654508; x=1742259308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2Py8G36+UkX5eKsf40xMemSQMNbOrMlyvipkmsMT5g=;
        b=l+8MtOgDFDiRfcttJQLTw1isI5qiRJmjTy4EwdCTGml12AcxIlUF4RIbf/Js59sBLB
         gWm1OfUgJ1/sXGwVSRsr4+7y5dg7K9qh05FpbqREtMbebO5fIrJ66jfMCnbrbaiTjqax
         QK4BUs6P0DG0G4ezMdbTqlaAusYWSNF/9ZhSmZJz32l2krpnqYDyeR9KFB0Oa0wBDWYR
         dzSSWzKMgwH5rp4ZaIUbM+GrxvTS1V3rnVlX7Rt5zsf7BQVWEV/3ULflhBxEMgkA/fBC
         dTOJ9FFtZeKBZmfJ9yTHdkc+jgB28JQMJ3qnFoy3Oh3aJeVR6VVaSmYY1YrG10Zd2B6M
         meHg==
X-Forwarded-Encrypted: i=1; AJvYcCWv2kX26Px2ApbTCzQvGQd/0vVA9ONAEMmRFXNwhQ+Le+wxHi9x54MGxo3P8Etd6B/GDUF+b4N36qMqqs1mag==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyQl30FT4wUZTHkDuQz0bgy2rbRsquKPyKD8VKLe0jNh6CZ7svG
	8Vs6y3mR+vEL05Apm4StLuMMUhvGS7EglYESg5iidLkn3Pvbdhqmds2N12BJG2ACVfa7GlKn44R
	xYlJw11Fd1OON+qVK63iIbsyk/gN5rWbuAqZmKZxjU1Brs4ZFIGARYdgtsgSXRO26xHDf/ushjN
	8pjOGWHmzObQrHRnzpJ8vjpdpdxLjWmpTI7KLtZJr4St28z4p9ErHC9w==
X-Gm-Gg: ASbGncvf5QTtAke6fuIY3VjwltsFdMEBXyFTtqWlW0tsOvqyI016g524JDj0wAteDLN
	t3eNdPMyVpr5SNOeHgJGYpTtrXPr+7+1tZAxjfSWU/lY3EorifByS3EqKh/QMQ+N2e//4yg==
X-Received: by 2002:a17:90b:4c4a:b0:2f1:3355:4a8f with SMTP id 98e67ed59e1d1-2ff7ce4fe20mr22950039a91.4.1741654507744;
        Mon, 10 Mar 2025 17:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6jfDj1tigsvwvzON4S5anyxLKOZz2BPa8XVtCqvLFOGsgfWbc5iRyHMwx3t03SpVWwyRAyxThSlPN83EQHbE=
X-Received: by 2002:a17:90b:4c4a:b0:2f1:3355:4a8f with SMTP id
 98e67ed59e1d1-2ff7ce4fe20mr22950006a91.4.1741654507280; Mon, 10 Mar 2025
 17:55:07 -0700 (PDT)
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
 <CACGkMEvms=i5z9gVRpnrXXpBnt3KGwM4bfRc46EztzDi4pqOsw@mail.gmail.com> <CAGxU2F7SWG0m0KwODbKsbQipz6WzrRSuE1cUe6mYxZskqkbneQ@mail.gmail.com>
In-Reply-To: <CAGxU2F7SWG0m0KwODbKsbQipz6WzrRSuE1cUe6mYxZskqkbneQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Mar 2025 08:54:55 +0800
X-Gm-Features: AQ5f1JqbKGL09EDs4AANVPKPpJR8e6B1lwdfdgUaMoGqSW4HxLXa24nFHlRYtEo
Message-ID: <CACGkMEtptFWx_v-14e1LM31XH+fOh4U-VO7gZKyqb1J1KM4uag@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AWo59fGV7q3eJKyfUf8-7rqWQAKNV7R-NpMFtHVkDA8_1741654508
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 10:15=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Thu, 6 Mar 2025 at 01:17, Jason Wang <jasowang@redhat.com> wrote:
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
>
> Do we have an example of any other non-Ethernet device that uses
> netdev? Just to see what we should do.

Yes, I think can device is one example and it should have others.

>
> I'm not completely against the idea, but from what I remember when I
> looked at it five years ago, it wasn't that easy and straightforward
> to use.

Can just hook the packets into its own stack, maybe vsock can do the same.

>
> >
> > >
> > > I see vsock more as AF_UNIX than netdev.
> >
> > But you have a device in guest that differs from the AF_UNIX.
>
> Yes, but the device is simply for carrying messages.
> Another thing that makes me think of AF_UNIX is the hybrid-vsock
> developed by Firecracker [1] that we also reused in vhost-user-vsock
> [2], where the mapping between AF_VSOCK and AF_UNIX is really
> implemented.

I see. But the main difference is that vsock can work across the
boundary of guest and host. This makes it hard to be a 100% socket
implementation in the guest.

Thanks

>
> Thanks,
> Stefano
>
> [1] https://github.com/firecracker-microvm/firecracker/blob/main/docs/vso=
ck.md#firecracker-virtio-vsock-design
> [2] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock
>

