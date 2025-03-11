Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCAC1DE4CD
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741654905; cv=none; b=OOtjn4eIPBpE8Pl7NUhwCa7j2b+4Xs4TV8MJyWRLMYYcywkyMZv05TJ0KZJrXi3cg1dAEbHXv0CJSdaLDaUcigeQKvrXB1u0ovVLFtfgFSlFwXOzfWoq6SyZCURSOOaW8TsXyNZsNmJ/qxwtFVDQCaNU6hCF4PbfUPeo1mmqUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741654905; c=relaxed/simple;
	bh=54oJMjM8shiRn1OnZ1JipCpRhpImJA6xO8ic278ve44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pT7yM6O2ysFjdQ1hD3k0I9oFAL6F7ovah88iYoeG00Oyh0nWqYYSI+figNFE/McCQW338MqIFmVxxlSeZq5tYrN/dwEeg9yhEJoq0ZJ8e+1z9FSo7+k2fQchDh9aRJYFvgyzYfG0By8JvFq+ECJW0aE088o77Cn6SUYb4pD3Kf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=daTc0b5K; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daTc0b5K"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28FCD40DB3
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 01:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kB7VMHYeJSnd for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Mar 2025 01:01:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DB4184096C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB4184096C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=daTc0b5K
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB4184096C
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 01:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741654901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otxChvBJUIl3nIMsETvBBdmY0LiFzMWWzPwOK3dbDlk=;
	b=daTc0b5KWUECtOzLJB2pae9xg8aHZNvp3TNI29FtmAKC+x1rxrDQZyqQHAJSI0c2jtM26o
	Y7ovZTkpBQ9fxXMNfR0QvuDmnhuSmVRQn0+tjBXXXxbU5XmKKVJMNMJv8nMCQL68C9ncyl
	FjUOdGX+0WRrGFi9lL6RzDJHp1D6bnE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-2CidhsipPlefmZ63GRcHIQ-1; Mon, 10 Mar 2025 21:01:40 -0400
X-MC-Unique: 2CidhsipPlefmZ63GRcHIQ-1
X-Mimecast-MFC-AGG-ID: 2CidhsipPlefmZ63GRcHIQ_1741654899
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff799be8f5so6690502a91.1
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 18:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741654899; x=1742259699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otxChvBJUIl3nIMsETvBBdmY0LiFzMWWzPwOK3dbDlk=;
        b=frSEhaCaSbFT5mKmJ0oMjCl483HCNSlT5rnlFFEMI2WgopgeCwG8nJUJ9AtpFxMAKW
         hq0qed+cG2/R3DVPeob1gl7WqYn7Fh44M8AVJYrPPWNiou5Br8EUbMnVfHG6/NS0BFnX
         IYi7HJ45gpV6Y0PaIce7j2MH72In+H0tCQIdFBMFoqi922C6wgKmpd+iSBjDOsQn11M1
         1tRCJeknMZQ0rGf7hyiPSRrt6cDBNDM/VwK3kFvkrzZg1pFtG9WLIq6bS5QJPFDG3IG3
         2MR7Ev9RobMMhaoedGhR43eanJjbcpadccjiEHiAx5KbxPxoPziTqFxdCLEmCHQkyk9L
         yltg==
X-Forwarded-Encrypted: i=1; AJvYcCVZpO+z4TNMRXZv/oKEEkuTxotGBPBLG8unCwRAEq6LzlgaKIlMoNK+o+V+x65OxUC+fP2FqRueAhodCHLYRA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyawAuFv1Z3MKYUWpsLLjHV40TCjZrjPhfMA5Fvz/dc0LaahyEG
	kh16TPXyrCEU4aySth1vauEUGgnXgN06JXGf44wY4qN8QKoSHD2QcHAOXHKNarahqaIXecRWCP0
	C9nJp2wACEfGTS0gyLRDxMm/YncKa5YXaO57q9I77G922qPkGnQRmNmFSperMROEf3esYiw9hqc
	0mULfi2PdLeD8ntuNBvo3hhsNIwkvxjyjDgSd/LUW38i3ByEoO7Ja+dw==
X-Gm-Gg: ASbGnctFITCsitXryZOqgnIJUKepRuQ2wi/WwYJObqSGph92ZvA1zB2Iej3hZkxdJ+D
	5zUkeNX18SXWuT8Ja9MdhuzuRHCIz7rPeQ0Hcya/70NCOxssBUkpXXLVEPcsDkXMZ0lt8kQ==
X-Received: by 2002:a17:90b:4ad2:b0:2fa:137f:5c5c with SMTP id 98e67ed59e1d1-2ff7ce59712mr22326091a91.1.1741654899123;
        Mon, 10 Mar 2025 18:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB3szA9e+qiTUX8D32Hw8wb313r3j65QyUK27BPoTVTn9q4ojSxaDQDQ9rIzvrEtlrS+WS7n5EOVmcp56KXhk=
X-Received: by 2002:a17:90b:4ad2:b0:2fa:137f:5c5c with SMTP id
 98e67ed59e1d1-2ff7ce59712mr22326069a91.1.1741654898757; Mon, 10 Mar 2025
 18:01:38 -0700 (PDT)
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
 <CACGkMEvms=i5z9gVRpnrXXpBnt3KGwM4bfRc46EztzDi4pqOsw@mail.gmail.com>
 <CAGxU2F7SWG0m0KwODbKsbQipz6WzrRSuE1cUe6mYxZskqkbneQ@mail.gmail.com> <CACGkMEtptFWx_v-14e1LM31XH+fOh4U-VO7gZKyqb1J1KM4uag@mail.gmail.com>
In-Reply-To: <CACGkMEtptFWx_v-14e1LM31XH+fOh4U-VO7gZKyqb1J1KM4uag@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Mar 2025 09:01:23 +0800
X-Gm-Features: AQ5f1JryFKyYz4Qy5Qu0hBDkTUXYULGfbK0w_lAdgtos8tIuW3BVNWh2Ym_c4Mw
Message-ID: <CACGkMEsgRZr=FZLrMkkyDbEzDvUHNHsEK8y7_cGL16gLZh1+Nw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hzz-0kb1jlPSHQY6sLKnCTMR7EOXek-Kv7rj76lXm-0_1741654899
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 8:54=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Mar 10, 2025 at 10:15=E2=80=AFPM Stefano Garzarella <sgarzare@red=
hat.com> wrote:
> >
> > On Thu, 6 Mar 2025 at 01:17, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Wed, Mar 5, 2025 at 5:30=E2=80=AFPM Stefano Garzarella <sgarzare@r=
edhat.com> wrote:
> > > >
> > > > On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
> > > > >On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> > > > >> I think it might be a lot of complexity to bring into the pictur=
e from
> > > > >> netdev, and I'm not sure there is a big win since the vsock devi=
ce could
> > > > >> also have a vsock->net itself? I think the complexity will come =
from the
> > > > >> address translation, which I don't think netdev buys us because =
there
> > > > >> would still be all of the work work to support vsock in netfilte=
r?
> > > > >
> > > > >Ugh.
> > > > >
> > > > >Guys, let's remember what vsock is.
> > > > >
> > > > >It's a replacement for the serial device with an interface
> > > > >that's easier for userspace to consume, as you get
> > > > >the demultiplexing by the port number.
> > >
> > > Interesting, but at least VSOCKETS said:
> > >
> > > """
> > > config VSOCKETS
> > >         tristate "Virtual Socket protocol"
> > >         help
> > >          Virtual Socket Protocol is a socket protocol similar to TCP/=
IP
> > >           allowing communication between Virtual Machines and hypervi=
sor
> > >           or host.
> > >
> > >           You should also select one or more hypervisor-specific tran=
sports
> > >           below.
> > >
> > >           To compile this driver as a module, choose M here: the modu=
le
> > >           will be called vsock. If unsure, say N.
> > > """
> > >
> > > This sounds exactly like networking stuff and spec also said somethin=
g similar
> > >
> > > """
> > > The virtio socket device is a zero-configuration socket communication=
s
> > > device. It facilitates data transfer between the guest and device
> > > without using the Ethernet or IP protocols.
> > > """
> > >
> > > > >
> > > > >The whole point of vsock is that people do not want
> > > > >any firewalling, filtering, or management on it.
> > >
> > > We won't get this, these are for ethernet and TCP/IP mostly.
> > >
> > > > >
> > > > >It needs to work with no configuration even if networking is
> > > > >misconfigured or blocked.
> > >
> > > I don't see any blockers that prevent us from zero configuration, or =
I
> > > miss something?
> > >
> > > >
> > > > I agree with Michael here.
> > > >
> > > > It's been 5 years and my memory is bad, but using netdev seemed lik=
e a
> > > > mess, especially because in vsock we don't have anything related to
> > > > IP/Ethernet/ARP, etc.
> > >
> > > We don't need to bother with that, kernel support protocols other tha=
n TCP/IP.
> >
> > Do we have an example of any other non-Ethernet device that uses
> > netdev? Just to see what we should do.
>
> Yes, I think can device is one example and it should have others.
>
> >
> > I'm not completely against the idea, but from what I remember when I
> > looked at it five years ago, it wasn't that easy and straightforward
> > to use.
>
> Can just hook the packets into its own stack, maybe vsock can do the same=
.
>
> >
> > >
> > > >
> > > > I see vsock more as AF_UNIX than netdev.
> > >
> > > But you have a device in guest that differs from the AF_UNIX.
> >
> > Yes, but the device is simply for carrying messages.
> > Another thing that makes me think of AF_UNIX is the hybrid-vsock
> > developed by Firecracker [1] that we also reused in vhost-user-vsock
> > [2], where the mapping between AF_VSOCK and AF_UNIX is really
> > implemented.
>
> I see. But the main difference is that vsock can work across the
> boundary of guest and host. This makes it hard to be a 100% socket
> implementation in the guest.

Or inventing a protocol to make vsosk can be transported via ethernet
(not sure this is possible then).

Thanks

>
> Thanks
>
> >
> > Thanks,
> > Stefano
> >
> > [1] https://github.com/firecracker-microvm/firecracker/blob/main/docs/v=
sock.md#firecracker-virtio-vsock-design
> > [2] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vso=
ck
> >

