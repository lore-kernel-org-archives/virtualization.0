Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC31C27
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 00:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220230; cv=none; b=c2OvUlEZXvnlWgKLltRHt1x3EzLI3xJKZ32/P1MgHXUbEkb5fXLlDGMUqBrkYNJVp7wuKvp4jzwL6zeIaAXdPmVwLEwNvR2eWx7kOD+Xp9nZ5YET21gCzQL880LZ8w83NcpFV4MWxvAgDg9YNeSdqEblEl2/mItT8cm7e8+Sw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220230; c=relaxed/simple;
	bh=+Wwm78y9BnVLdWm8RFuREOENXYM1SpKDISYy3wFQGr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeT/rEnaMxxnDie7nkKouOXuQpwvcNYEZoTBsJBg5VJetenSInAfsS9XfQAl6DaFytp7wFO5y66PjmIG/IfSFUcLC/LQrfLX24kYmxz9WPbML7JeW50N/bR1kCYq0i9wb1KsP+TLUSxZ9ESJCckW2niFruX9/viC3T80vispcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Md3Q9TmV; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Md3Q9TmV"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C96E40167
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 00:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pMxsqIG6il8e for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Mar 2025 00:17:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2B73E40184
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B73E40184
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Md3Q9TmV
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2B73E40184
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Mar 2025 00:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741220225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYivC87WhRU5jPCfxZzkS7AXzckjBFGkdKstv7mfD7c=;
	b=Md3Q9TmVityAB2uhe8EQS9ZXZwbzRq5PZH1qqXY6T5FoKp/X53OZSgAwWUmdDsrUPzlaZd
	+rBfnVAy2YEUVxufdBKtYUs9VZFB7QZZ2ejNtf/d6cdbYx97imzsG2oFDv2mQ8BAsYMkFm
	p9mRg/ihuQ+iomn+dOCXM7e+pl0SW2o=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-v-2T-CNkPTWOquVNvjLpiQ-1; Wed, 05 Mar 2025 19:17:04 -0500
X-MC-Unique: v-2T-CNkPTWOquVNvjLpiQ-1
X-Mimecast-MFC-AGG-ID: v-2T-CNkPTWOquVNvjLpiQ_1741220223
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso409721a91.0
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Mar 2025 16:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741220223; x=1741825023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYivC87WhRU5jPCfxZzkS7AXzckjBFGkdKstv7mfD7c=;
        b=MDDuv5r77NIF/eaqoFM+49+Jj5kfC2ugheU6iIbJQNBaXEPG21BTwfn6gRwk8wBrd4
         MI7mhsrPMfxC61+t23zk2jjBDPHPlegxiNiKOuwMM/SgyCHacuGHp1cymoQPqMVh75bv
         c5LIIZZN9OLWP591Jvz419WoeDddwm2RI3b7sLAOt7UQn9mWbfyGtBR60Jb4Rok+IKXA
         4pbDvrgT0KcISxDqMx4eKI7nxYlM2tD3ygdsqTfWAc2Bb29/PEn7HPl713vR0QAfOLeF
         zL+qK7GvbKHbsSwUVrODlgsn+dlkH+A9bEIacyldNZzdzBFVkDRllizRElNfQqOS25Zb
         JZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX61LEpyP96Nt0GnpStJhItYgFKgBRzH4EJFiEWEJw7p5vqJVkgELXDnZer0PkmyKq7joZzG2K15YS5frq/SQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyEH7+CxCHDiqzuETqZRsM7U8lg7FQ5gJK+ghnWMQeN3/TW4q/J
	5xKbnPkVtzTSnbrzQa/5xMlfq2/hpGsi0h0E/31jB+0QI2HCJbDFxmAG/4P5MXg5Z/IWRm+bMrv
	+xHs+5vW0tFQfNjY7cFEeeS5BsNAG4uO75cj4uoR5qilwZ+IdGzTXjzaUSTUGfccsla+hxxs7Pk
	pIr6tpY8cEdwgTkgf2UQ9S0eG7G2v5zKd64+NTRKBupansjYHmncDRZw==
X-Gm-Gg: ASbGnctu6UKjb3vpMJtfPCtBbHJ8kicbYNKwppeqzjlXslyehFdqRwXe9r4AZCZeiao
	NuNAYiDH1xsZM+I5yWF4Vn3fl4JFUP3kUQ3YOEXVVG40meDkKENqR+fdj8FdXC7UREd9j1y4OFd
	E=
X-Received: by 2002:a17:90b:3c87:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2ff497cce78mr9640212a91.18.1741220222889;
        Wed, 05 Mar 2025 16:17:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFm03yuBJCzHipb+u+/vxkatspEkUc/vBoHzZ9SJCyh2hxYSRGDOjw00zbfIsnmQnxOyJi4dQOkxCDXWDyfOC0=
X-Received: by 2002:a17:90b:3c87:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2ff497cce78mr9640168a91.18.1741220222504; Wed, 05 Mar 2025
 16:17:02 -0800 (PST)
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
In-Reply-To: <v5c32aounjit7gxtwl4yxo2q2q6yikpb5yv3huxrxgfprxs2gk@b6r3jljvm6mt>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Mar 2025 08:16:51 +0800
X-Gm-Features: AQ5f1Jql0yqolE1p-RM3zEM6LJujZ0qsyX-vhJHsLFPVzV7f1_y-mNi6DKL8tMs
Message-ID: <CACGkMEvms=i5z9gVRpnrXXpBnt3KGwM4bfRc46EztzDi4pqOsw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vJqsbnDfnZS7bw4YC9QVrCL2-B2M6vKsKLg3_NNh0sQ_1741220223
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:30=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Wed, Mar 05, 2025 at 02:27:12AM -0500, Michael S. Tsirkin wrote:
> >On Tue, Mar 04, 2025 at 04:39:02PM -0800, Bobby Eshleman wrote:
> >> I think it might be a lot of complexity to bring into the picture from
> >> netdev, and I'm not sure there is a big win since the vsock device cou=
ld
> >> also have a vsock->net itself? I think the complexity will come from t=
he
> >> address translation, which I don't think netdev buys us because there
> >> would still be all of the work work to support vsock in netfilter?
> >
> >Ugh.
> >
> >Guys, let's remember what vsock is.
> >
> >It's a replacement for the serial device with an interface
> >that's easier for userspace to consume, as you get
> >the demultiplexing by the port number.

Interesting, but at least VSOCKETS said:

"""
config VSOCKETS
        tristate "Virtual Socket protocol"
        help
         Virtual Socket Protocol is a socket protocol similar to TCP/IP
          allowing communication between Virtual Machines and hypervisor
          or host.

          You should also select one or more hypervisor-specific transports
          below.

          To compile this driver as a module, choose M here: the module
          will be called vsock. If unsure, say N.
"""

This sounds exactly like networking stuff and spec also said something simi=
lar

"""
The virtio socket device is a zero-configuration socket communications
device. It facilitates data transfer between the guest and device
without using the Ethernet or IP protocols.
"""

> >
> >The whole point of vsock is that people do not want
> >any firewalling, filtering, or management on it.

We won't get this, these are for ethernet and TCP/IP mostly.

> >
> >It needs to work with no configuration even if networking is
> >misconfigured or blocked.

I don't see any blockers that prevent us from zero configuration, or I
miss something?

>
> I agree with Michael here.
>
> It's been 5 years and my memory is bad, but using netdev seemed like a
> mess, especially because in vsock we don't have anything related to
> IP/Ethernet/ARP, etc.

We don't need to bother with that, kernel support protocols other than TCP/=
IP.

>
> I see vsock more as AF_UNIX than netdev.

But you have a device in guest that differs from the AF_UNIX.

>
> I put in CC Jakub who was covering network namespace, maybe he has some
> advice for us regarding this. Context [1].
>
> Thanks,
> Stefano
>
> [1] https://lore.kernel.org/netdev/Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebo=
ok.com/
>

Thanks

