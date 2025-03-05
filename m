Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CCA2045B0
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167489; cv=none; b=bk2LPjrA+S/ZluGCSDbfED8BQ6FckbpEmXnHpCC+Sbi/UyHhj3A1FOkIHvzVdF9ij/nDQ5WUkOKJaDDRUqUv3QCaYCmqu9ck4yx8hEAMla0J9y8RjC3S3sJV2vEj8bd6HKLzTLQfJF5WDsrQ9EoDTXAo54EnhuTH7q95dDDBs8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167489; c=relaxed/simple;
	bh=exY4ZR3eJixCKGY9RcS0uPA/+XbPIVQfPexC74yCyy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLGNbjwAHYbQerXp7pJ6LiKJinlhEo0OB4Qt99Z5yhkKtkT33QNpKK68yLFgirKn4l1qHXFO3RCfeHXfN3/4Fy7KVHnXebzhk9T8SD/0GgdqX7Y1V/rLbwKEPQswZZ7kArWCHz4LvAPDB+VmPAEeddxUVKaPHLEk/BoW/Su1n28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFhFGBz4; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFhFGBz4"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C17AA606BA
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:38:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LjZNJa1YnDao for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 09:38:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 899906068A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 899906068A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TFhFGBz4
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 899906068A
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 09:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741167484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0FrWMD0bRhsF9/9bE85tn6Gl17O/CsmNiRx1oo/Ojac=;
	b=TFhFGBz4w/AT9QUFE7MBx6/mO0Tg5mulhqjOYIn/mMlExSDndVEMlgx5n+nmBx/xgjXfCs
	uQYeQUZHPkP5wGk/AL2sBbiRcuKB+U+oiQ8uFPmFtFcET1Q7ZvR+twIm8HlPuqWd1bi6bc
	y+cxVWtmruIFtcJL4DsFNiGCTmnEvnU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-dqHuSStFNF23n-iGk3HtLQ-1; Wed, 05 Mar 2025 04:38:03 -0500
X-MC-Unique: dqHuSStFNF23n-iGk3HtLQ-1
X-Mimecast-MFC-AGG-ID: dqHuSStFNF23n-iGk3HtLQ_1741167483
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e5798866415so13490341276.1
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Mar 2025 01:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167483; x=1741772283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FrWMD0bRhsF9/9bE85tn6Gl17O/CsmNiRx1oo/Ojac=;
        b=WqTvngjD0WDGUP73WHQl+cjdW10D2qDca8HO4gWbUWQlWa/SI81MOP5xKld8YNlyYE
         A2xWvfZWkUsdrIEz8lsoX2ZNPudu6hz9AJIKg21CWYUrZKbhjfcJBYZZAovSL2hrpBpM
         cfstUfGNeNi1E3A26FDGijxoDylWrXLCzyL8tGqk2HFlH7kfD3FtFcQWysxovxbKrOkP
         kUUkiMXupakAac4VTd/JhuVLCY1hzj+lRwsnu886KvmSr/5GkBaYCAyxcZZSAr3S+jey
         25ql+1qlXVtRFeckAiJ163Unii9Nqwo4dldE/ySbez3/92vfLMZr+jUvZnrbBI2iCwhq
         POTw==
X-Forwarded-Encrypted: i=1; AJvYcCUXeo8fkXV+qeHBRX+nsUIYIrZ9U4NuO5EbROkQG6XfhEkHdIZl/T0uj8CrR1NN3tUWUybZ/+HA1ju0BNJf2g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwZvh1RFKvVlWdwQvKv2XS4HLB54zP0btYMfvUZfEYMdKwXJlaT
	R+CenmtuHijOIGRS7z6XHTzBTg1lEXLOL3w3sXEXcACiRRLPIC55fnMl6H95ijMpdHS8/eCXvSp
	trbbUqrEutGF8SUs+VQyQJYJlzvfCEM2WhrbtH7Q7tKhw/25pS55AXj/652DtFnetO37VUK8ziX
	77SOGRfxuLNfWo+44G6MxCYWLEUMvWX6ddUzwnUZ4VS/R1XUk9Wx+ySQ==
X-Gm-Gg: ASbGnctDKwo2sUA2+knr3w7lB+BZlku1ZL3Yi7YB+s9VKbyCZ8yGPRmGAuGdrNm5/1n
	N41b31l8isjCnpa7kio+c2VyKIZJuGoNU8CZ418vFCkX5vf4hz5h4lx7volwIK8sYjxdZ9v0=
X-Received: by 2002:a05:6902:1183:b0:e60:99d2:cbc2 with SMTP id 3f1490d57ef6-e611e1d985bmr3487857276.25.1741167483053;
        Wed, 05 Mar 2025 01:38:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdMsgj9Ydu4+cefxVYhObOl86/wGnTsK/HesSGO3ed6Vl99uqasl92wWHUDOUB2G4pt/8bHopoWWjG9JBFIQE=
X-Received: by 2002:a05:6902:1183:b0:e60:99d2:cbc2 with SMTP id
 3f1490d57ef6-e611e1d985bmr3487834276.25.1741167482716; Wed, 05 Mar 2025
 01:38:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200116172428.311437-2-sgarzare@redhat.com>
 <20250305022900-mutt-send-email-mst@kernel.org> <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>
 <20250305042757-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250305042757-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 5 Mar 2025 10:37:51 +0100
X-Gm-Features: AQ5f1JrrYEAMMHf_xixI6yuzRilW5TDux-F3sq2MEJ4u_iOmeJJo3IO5_LvXWgY
Message-ID: <CAGxU2F5D=nx8V4d+iDyQvfJvhASMOM1c3AsRZT0R3TqnAVUhUQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, 
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4siWkEGnKBf0yA2vG4jjeERxvhbk__KIaBCrqX1B0KA_1741167483
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 10:29, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Mar 05, 2025 at 10:23:08AM +0100, Stefano Garzarella wrote:
> > On Wed, 5 Mar 2025 at 08:32, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Jan 16, 2020 at 06:24:26PM +0100, Stefano Garzarella wrote:
> > > > This patch adds a check of the "net" assigned to a socket during
> > > > the vsock_find_bound_socket() and vsock_find_connected_socket()
> > > > to support network namespace, allowing to share the same address
> > > > (cid, port) across different network namespaces.
> > > >
> > > > This patch adds 'netns' module param to enable this new feature
> > > > (disabled by default), because it changes vsock's behavior with
> > > > network namespaces and could break existing applications.
> > > > G2H transports will use the default network namepsace (init_net).
> > > > H2G transports can use different network namespace for different
> > > > VMs.
> > >
> > >
> > > I'm not sure I understand the usecase. Can you explain a bit more,
> > > please?
> >
> > It's been five years, but I'm trying!
> > We are tracking this RFE here [1].
> >
> > I also add Jakub in the thread with who I discussed last year a possible
> > restart of this effort, he could add more use cases.
> >
> > The problem with vsock, host-side, currently is that if you launch a VM
> > with a virtio-vsock device (using vhost) inside a container (e.g.,
> > Kata), so inside a network namespace, it is reachable from any other
> > container, whereas they would like some isolation. Also the CID is
> > shared among all, while they would like to reuse the same CID in
> > different namespaces.
> >
> > This has been partially solved with vhost-user-vsock, but it is
> > inconvenient to use sometimes because of the hybrid-vsock problem
> > (host-side vsock is remapped to AF_UNIX).
> >
> > Something from the cover letter of the series [2]:
> >
> >   As we partially discussed in the multi-transport proposal, it could
> >   be nice to support network namespace in vsock to reach the following
> >   goals:
> >   - isolate host applications from guest applications using the same ports
> >     with CID_ANY
> >   - assign the same CID of VMs running in different network namespaces
> >   - partition VMs between VMMs or at finer granularity
> >
> > Thanks,
> > Stefano
> >
> > [1] https://gitlab.com/vsock/vsock/-/issues/2
> > [2] https://lore.kernel.org/virtualization/20200116172428.311437-1-sgarzare@redhat.com/
>
>
> Ok so, host side. I get it.

Now that we're talking about it, I also came back to a guest side
case, again related to containers and possible nested VMs.

If you launch a container in a L1 guest, for example to launch a
nested VM, maybe you don't want to have it communicate with the L0
host, so it would be desirable to be able to isolate the virtio-vsock
device from it.

> And the problem with your patches is that
> they affect the guest side. Fix that, basically.

My main problem, IIRC, was making sure to allow the old behavior as
well (but that maybe we had solved with two /dev/vhost-vsock and
/dev/vhost-vsock-netns).

The other problem was really in the guest, on how to tell that the
virtio-vsock device (thus communication with the host) was reachable
from a netnamespace or not.

Stefano

