Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082431DED63
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741654803; cv=none; b=uQpQcHH7/l3icvBrbRXKG9elj4S0wtwBGOvvgctlbI7I5Zk7OV9vsgppnW9R8LmNCbW2qK8k3xPvdNXs58I7x8yX0wH+U+9UrSlltoQfH1qo2yVtmgoNryRGVHH/qFReMti6p+arkYWZKYRNQR+vJz9E5gEK9FC7nc03V7zwW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741654803; c=relaxed/simple;
	bh=Km4o/Cc79mmhwdF+oF0aFF700HfRG8KdNxIhM+VCGqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPvFUePImqrIF9mcMs2jXTe6W2MfKFSRcX9//V0topod+GBHbVL1zFzFwG/goF2o0Vk5o3KOUPH3MMU/Ldz6sJuA7upW9Wqgg84XJm/5Y14UWLvByrc8dl5Ffe0k7ym8RM4DcXtvtjh25jCF0xdaQHbTZQbkq6/y2vK8NzVx9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5vuH2sc; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5vuH2sc"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8584540794
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 01:00:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AZiUfV-WReO6 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Mar 2025 01:00:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2A35F4076D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A35F4076D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K5vuH2sc
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2A35F4076D
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 00:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741654798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Km4o/Cc79mmhwdF+oF0aFF700HfRG8KdNxIhM+VCGqU=;
	b=K5vuH2scG1keLRLWgmZ2iLSKG9vNNPx2vtDxVn7pCptzPZTU777VzNaTYur+OWdV9gkZUL
	T7hpsz/1Iv75kNvcVHD4CE0DscDs19mcJ2FeV7pK3kw7HfJQRenngERqZCiDoX+T5hlPmK
	ixyowv9MLSSmg85oiDXqakOHE1YqDsc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-wVrZ6b8AORS_MH5zNFxT0w-1; Mon, 10 Mar 2025 20:59:57 -0400
X-MC-Unique: wVrZ6b8AORS_MH5zNFxT0w-1
X-Mimecast-MFC-AGG-ID: wVrZ6b8AORS_MH5zNFxT0w_1741654796
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso11573121a91.1
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 17:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741654796; x=1742259596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Km4o/Cc79mmhwdF+oF0aFF700HfRG8KdNxIhM+VCGqU=;
        b=cGPxCXX97PG91iHNG42iz1vKZpfDw7JMpIXy4KCpEZ8pZYryKWbcJz8PmIaf8Y8cZs
         fsPmBx5ljaxkAkeNreyqn3Yk2ryShJQovh9ALRWmAufX1tMTAM89g3nBBbSR7yzHP0vO
         TMLPNsD/Bqgrg0dnjSZpCamR59U0kiRQX/HYWZBdYloN4uagoIpHs8J79kFX32F4Y3ik
         2AvA7EDT9pSRmusFLq0WFb3u27CeVqgWhqDoSysypitSHqL7pgSYo9cJQjkNni1sMTv1
         5OjVsZg45y9hxrD/4qnczfuJn7jvEzZkR2oFM7ApXg4Us/2HBiyeS0JtO1A1t1Afxq2h
         FOSA==
X-Forwarded-Encrypted: i=1; AJvYcCVQM/x0NRjwkFsHMCNT2V4H1s0nEBCtFW16fmB3WcIIiuYSXQDX+ypBVOVjV6jnNeRM/4009HJcIBZmDXJ5/A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwmgSLJ/jEowTL/tVk4iOl+BLowYHG+ulX9VSFfO1dktLmFRj4+
	AsYzkKtnM9Lsmeq6fP2l+sAufbM8ZyzD8p2bdFhQItf7TNjDhh/T7D76p5xVWTT9qyCLcoRuEX0
	ff0MlcLy+kXXikUt547CG7+eFB5ppqb0d+AXE/9jNpNpea+xyYO+4KWQsbrdNO2KI2hbxDVYzX2
	CT34DzFV1uM18dgdZ09E3NHaOzHY+yMyjI0wDw9WgXr3YrZyxhVSyYtA==
X-Gm-Gg: ASbGncuqE3ORxmyLUx4BmlZNiE9UcKJs9hN9DdYoHI4oiI8gDUjjKKM7WYKxUB+NnlX
	7Ahyy6TkYVs9iVpW4ijNu6Y5zSfBgpVRi39sW+iR2tmyYfZCaDYymVquCCXv1Q8IDedwkqA==
X-Received: by 2002:a05:6a20:6f88:b0:1f3:3c5d:cd86 with SMTP id adf61e73a8af0-1f544aeda95mr23372512637.11.1741654796477;
        Mon, 10 Mar 2025 17:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFAjXRLPP+KLwqouY2d8xVCf5YkchPJTuZnlD8oM2zbnnMfHxkuX6t5KA0j3l2vfmnWt5WtbXtWP67UCxPLOE=
X-Received: by 2002:a05:6a20:6f88:b0:1f3:3c5d:cd86 with SMTP id
 adf61e73a8af0-1f544aeda95mr23372488637.11.1741654796116; Mon, 10 Mar 2025
 17:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com> <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com> <CACGkMEtTgmFVDU+ftDKEvy31JkV9zLLUv25LrEPKQyzgKiQGSQ@mail.gmail.com>
 <Z89ILjEUU12CuVwk@devvm6277.cco0.facebook.com>
In-Reply-To: <Z89ILjEUU12CuVwk@devvm6277.cco0.facebook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Mar 2025 08:59:44 +0800
X-Gm-Features: AQ5f1JoCYAYg3sSzAq1y95KxGgfuxvQDmD7hYAz9zEwdTX_uuQgCUXsFfxfhrfk
Message-ID: <CACGkMEskp720d+UKm_aPUtGZC5NzH+mp_YKoY2NQV6_YBbRz9g@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1xfVB-yxdIuxNpoEIv4xFfgs1-Qr55nVj5Wo49BFfj4_1741654796
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 4:14=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> On Wed, Mar 05, 2025 at 01:46:54PM +0800, Jason Wang wrote:
> > On Wed, Mar 5, 2025 at 8:39=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gm=
ail.com> wrote:
> > >
> > > On Tue, Apr 28, 2020 at 06:00:52PM +0200, Stefano Garzarella wrote:
> > > > On Tue, Apr 28, 2020 at 04:13:22PM +0800, Jason Wang wrote:
> > >
> > > WRT netdev, do we foresee big gains beyond just leveraging the netdev=
's
> > > namespace?
> >
> > It's a leverage of the network subsystem (netdevice, steering, uAPI,
> > tracing, probably a lot of others), not only its namespace. It can
> > avoid duplicating existing mechanisms in a vsock specific way. If we
> > manage to do that, namespace support will be a "byproduct".
> >
> [...]
> >
> > Yes, it can. I think we need to evaluate both approaches (that's why I
> > raise the approach of reusing netdevice). We can hear from others.
> >
>
> I agree it is worth evaluating. If netdev is being considered, then it
> is probably also worth considering your suggestion from a few years back
> to add these capabilities by building vsock on top of virtio-net [1].
>
> [1] https://lore.kernel.org/all/2747ac1f-390e-99f9-b24e-f179af79a9da@redh=
at.com/

Yes. I think having a dedicated netdev might be simpler than reusing
the virito-net.

>
> Considering that the current vsock protocol will only ever be able to
> enjoy a restricted feature set of these other net subsystems due to its
> lack of tolerance for packet loss (e.g., no multiqueue steering, no
> packet scheduling), I wonder if it would be best to a) wait until a user
> requires these capabilities, and b) at that point extend vsock to tolerat=
e
> packet loss (add a seqnum)?

Maybe, a question back to this proposal. What's the plan for the
userspace? For example, do we expect to extend iproute2 and other and
how (e.g having a new vsock dedicated tool)?

>
> > >
> > > Some other thoughts I had: netdev's flow control features would all h=
ave
> > > to be ignored or disabled somehow (I think dev_direct_xmit()?), becau=
se
> > > queueing introduces packet loss and the vsock protocol is unable to
> > > survive packet loss.
> >
> > Or just allow it and then configuring a qdisc that may drop packets
> > could be treated as a misconfiguration.
> >
>
> That is possible, but when I was playing with vsock qdisc the only one
> that worked was pfifo_fast/pfifo, as the others that I tested async drop
> packets.

I guess it should work with qdiscs with TCQ_F_CAN_BYPASS. Or if it
turns out to be hard we can just bypass the qdisc layer as you said.

Thanks

>
> Thanks,
> Bobby
>

