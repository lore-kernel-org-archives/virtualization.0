Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480F1C8619
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190857; cv=none; b=XDRGVrfjPrKKUlE17bfYO/DsL/lmNnCWqnJsNtraKp88UBUYRL7GHJj0MpNU8kcoE+WO34B0ggiXiVZtoJF5imsxk3/zT1vzbISp3btWW6OFUEVJMKrdP2PtZs+vTW37A8cuWy59Fo8cW6u7j0t8GxlF97AtpGQI7o7zkTWx+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190857; c=relaxed/simple;
	bh=kq/Og+wt7HP9ZImJr8Q41zTRnAZqrVJ2k+Jm/8grxEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hta67UmfWTSef8uOlO6cAb2nRCh9nSCllJV3BgM4qpnyrsyyY5ja1GaGXh2q7VrAPyRLfUSunwsRN9lMzzSH8OysdZ38G1Cr+HdLglFSqy1qQKctG/mhc2rYgxFt5qRFSvSe6h75AuPCSZKNmVXor6LSN+YubZJ/z8UazOHPm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1MmtfAl; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1MmtfAl"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3173E83829
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 16:07:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yh1xGF1jEiCi for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 16:07:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 48BAD8380E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48BAD8380E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M1MmtfAl
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 48BAD8380E
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741190853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ryWkCCG9U7D/clkcoHvgWHB1rXveT/dQOyD5wDCrVfA=;
	b=M1MmtfAlpSSzENd4M0RL9GskuCVgDQ/fQEqBQ2jxLCE9OIhrbOnu8oo6FQL4nhAWUEEqDV
	BYZLj7k1UzR91Yk82Zxgfphm1RpfVPnMK+mtTl4hmigG8WN1kzErI3EnfQdTLmCVdd2XEH
	RVwzLXp/ciFD7CNrpEH/cqJqOXHWkJg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-o62VMZFVNwGilRxvW70WvA-1; Wed, 05 Mar 2025 11:07:27 -0500
X-MC-Unique: o62VMZFVNwGilRxvW70WvA-1
X-Mimecast-MFC-AGG-ID: o62VMZFVNwGilRxvW70WvA_1741190846
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6fd36a398cfso75582497b3.0
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Mar 2025 08:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190846; x=1741795646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryWkCCG9U7D/clkcoHvgWHB1rXveT/dQOyD5wDCrVfA=;
        b=rtLg5Z9cwasZCJ1qHFrAIVPfHImgPmH6+kYJfbIP7fyyXItKeUiWVIvjXah7NCiLDn
         D46VzMeAVnSzPEX3X6IEzsyNCYp+3qXRZJfv594gtzHC02nAL8uzEXOf+WLoMgEoqmqu
         exMxbMKPCC5hWR/aJH4lWC2aziZjmTC1E1ll4eR6bnebxM4z8fpkvNW2DPibwADFGCZ4
         VOkZCYj0bbWrld7k7NWLZwiPhHpRQEGoFxF8ctQiZNle90b/OWdT2j1EXLASup+0B/qF
         tlF7TVd1YqNUPTWsYFyyr4uUwLL3g6IwaRMN6GRCTi+JHy68LLlBFci10H5McTnE6dHv
         0ETA==
X-Forwarded-Encrypted: i=1; AJvYcCUvVgTk+cbnyvEg/t/XgHs34zxM/LKG8WbIF6+GRHe6J8RD0dG2Wr3mB6ufQMRmYgnOWQB0ZKpijelAu1oeVg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwrZxkkA3iZThTw6DaEK+MQ+72eMgxcCGxpPXNfB7SkaxhHZBRZ
	2E50umSVi+HgUtk+Xe9Ma3y/g8969g91tIdOKuzyKrYnJ+4E6Y/HuOtW1GSIl/WwaIjx7WtLE7G
	4RZ0gz9fZZHQZpTaHEyEt4XAQmz3AmrG8rFT64u1v1pYbhwFGOqsxzBWuLlgWcrQN/ONKlOxPza
	Ai1Yqk6CuOz8sbqAcOrwadO+hGhBLCPIbN2NtgnueT9r9gB7A6q3Hm5w==
X-Gm-Gg: ASbGncvUVhqFqRQsJfFVahOGNKG1vB41k7LbIz6hwNch2e3l3oUpq9Cw1yVaABaSryo
	M7G88motn4zur6Gy+h5HF2IqqsRq5V/IIFBKuJzo7ePpguKGChaWZJHlw0bk6ofHms+8k5Is=
X-Received: by 2002:a05:6902:2b04:b0:e3a:228f:b6ae with SMTP id 3f1490d57ef6-e611e31b361mr4939467276.28.1741190845406;
        Wed, 05 Mar 2025 08:07:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUAS6WwP66wpVRH9zM8tONfKYOINgZVsEogrnYLnEVbUemjVXbmLZS/WKWOoZP10KvvEaRYVNTgnvohXgwyFk=
X-Received: by 2002:a05:6902:2b04:b0:e3a:228f:b6ae with SMTP id
 3f1490d57ef6-e611e31b361mr4939380276.28.1741190844684; Wed, 05 Mar 2025
 08:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200116172428.311437-2-sgarzare@redhat.com>
 <20250305022900-mutt-send-email-mst@kernel.org> <CAGxU2F5C1kTN+z2XLwATvs9pGq0HAvXhKp6NUULos7O3uarjCA@mail.gmail.com>
 <Z8hzu3+VQKKjlkRN@devvm6277.cco0.facebook.com>
In-Reply-To: <Z8hzu3+VQKKjlkRN@devvm6277.cco0.facebook.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 5 Mar 2025 17:07:13 +0100
X-Gm-Features: AQ5f1JpJL5yP-_Z0xQeVD2Y1zot7Sg-rzWoskaP0DYpCjrRwMKzDiyskEoI2Ozg
Message-ID: <CAGxU2F5EBpC1z7QY1VoPewxgEy3zU7P1nZH48PtOV1BtgN=Eyg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, 
	linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y0lMc5RI-TP0APLaIFjJwJTRESmxk2FcsTmRb6Vj4NU_1741190846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 16:55, Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
>
> On Wed, Mar 05, 2025 at 10:23:08AM +0100, Stefano Garzarella wrote:
> > On Wed, 5 Mar 2025 at 08:32, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
>
> [...]
>
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
>
> Do you know of any use cases for guest-side vsock netns?

Yep, as I mentioned in another mail this morning, the use case is
nested VMs or containers running in the L1 guests.
Users (e.g. Kata) would like to hide the L0<->L1 vsock channel in the
container, so anything running there can't talk with the L0 host.

BTW we can do that incrementally if it's too complicated.

>
> Our use case is also host-side. vsock is used to communicate with a
> host-side shim/proxy/debug console. Each vmm and these components share
> a namespace and are isolated from other vmm + components. The VM
> connects back to the host via vsock after startup and communicates its
> port of choice out-of-band (fw_cfg).  The main problem is in security:
> untrusted VM programs can potentially connect with and exploit the
> host-side vsock services meant for other VMs. If vsock respected
> namespaces, then these host-side services would be unreachable by other
> VMs and protected.  Namespaces would also allow the vsock port to be
> static across VMs, and avoid the need for the out-of-band mechanism for
> communicating the port.

Yeah, I see.

Thanks,
Stefano

>
> Jakub can jump in to add anything, but I think this is the same use case
> / user he was probably referring to.
>
> Best,
> Bobby
>

