Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF681DB34E
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 05:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153634; cv=none; b=Ct7Pf7Oybq9E/71/fOu1XKkf4BxYJ2mdyiutgP6NSyXaHuta9X9m339lBNgqk9WTiHZdWXfv1arSAd3RdLKAz54TRyW+Ghe/oxPU69xTEBS3WHTfiAdcQBFQX0OoAMpZXOtcr8gwFN0LNLQ98WeMhgF9sT9ryDFscR+SgoSGFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153634; c=relaxed/simple;
	bh=Yr2zEleQP5OB9VQnCOvN96Nz1sM+C0j+qfjDSd3R7qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mogadVfdLKtduH0R+FrHWTZcmdcKY9ZoM277KSjlAYdxmB9YJ4zYqy6pxakSEkQeP/iA2Wzu2mGP2K7UfO6ckLSXlJCjIZ1YCW6xzKVuAyk7obrUMoAxCKjSuMVHnUmOWc9oCU+VjYTBWC2foSsDP4fx7+LiSRYeYphBu9NadO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MP4e13DS; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP4e13DS"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E325411CE
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 05:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SOFRhAwhIsgf for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 05:47:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 83389411CD
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83389411CD
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MP4e13DS
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 83389411CD
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 05:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741153629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TckiHzoidmvghQ6zu3pJdp/CUVWbSHOgWhuCociTv5w=;
	b=MP4e13DSP8GrWaJJOc1aGnMtzaCTvmRk3WFx1PSgx0UGjAn7Ro07JHfr0YhNBk/KMLTIiK
	x84/JOLp0f/SqOmwW+Wq+r+r1IkRGPwG/XzjA+jWjYxerSwMcm2L6/mf2u2SqBJ+JNkdSA
	+NETmOhvMQTN+k9/J2wzm/yGUiRTx04=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Dl4o2QioPsSN6cNL784HvA-1; Wed, 05 Mar 2025 00:47:07 -0500
X-MC-Unique: Dl4o2QioPsSN6cNL784HvA-1
X-Mimecast-MFC-AGG-ID: Dl4o2QioPsSN6cNL784HvA_1741153627
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fee7f85d03so11007266a91.3
        for <virtualization@lists.linux-foundation.org>; Tue, 04 Mar 2025 21:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741153627; x=1741758427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TckiHzoidmvghQ6zu3pJdp/CUVWbSHOgWhuCociTv5w=;
        b=FbT8vWMJl1AItWJob3TtUpnlFuK6eF4kMVwIqrhaoN1rgLj73ajowehpC99ZSVdX9O
         rbngC/eYEOcFbwN6007Iuj4+7uU9jtDtMpWt6qq4TdGUh2+kguBLd8ROljrvlwy5oeGZ
         6cbLfx2YANL5vkycehdbMgO0veFhDgoJO8U/+YWIG4nMEAgIbiutvynrOGI6ywcaqCxj
         rfjHz3hoQ8C8wmtaCfXXCWLdjCnzi6ZsTvxoPnNf+yMGuwFpWbt/F2ICJuNuj2RQnUhX
         e1Nq0OIhmyTBc+6HukiiAn8QLJsGJVK22iYkK4tMO9IyosFouzWzfvzzWd6Zdl2z8hUM
         cGNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx9W8SDDwXCDU4vGoL8VBpyHfoZrDtQBAXyjXiOesHEY0RabOYnRYn00iCqZkyZXAa6/5+eEsYkElduHY7Sw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzZP5W3GRiTRg2xokfU7HjKVUxN7QwtnGFev/mzThrTOp6zVp/+
	UjylzMNO2klsAGUUMvhrBdoM7jxq20amRFkz6xRqX1hagHWCiseeQR7eofuflkC4ri4oqdpvBvo
	yuUDud5YqUfbbD6X1JLQ80yRWVsAKCRGKVd6AKDHaKsIBRCEXz2saHI3oWjhFuUI6uFb6E/d+iC
	M7oT2VC4VFpk8iFITe5wq5GgTMPoBw7PhH00oBudsbyxYbKRg+lJiO0w==
X-Gm-Gg: ASbGnctuSEiLFSNJfxHCBNnS3YKN06Fv49wxgh/xL4qRNcGEwpoT1+go8DY+K73+Qls
	1lO/bPFQsaYlxMkQQ2JCrjVYssPZNPMwOrKUvWdRCf5rnebAmWLHhUcthYuKCvM3hsY6Tx02qRQ
	==
X-Received: by 2002:a17:90b:1d52:b0:2ee:dcf6:1c8f with SMTP id 98e67ed59e1d1-2ff497cb040mr4004283a91.16.1741153626852;
        Tue, 04 Mar 2025 21:47:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7tLwkzpVQv2Fhj6KJP/g5jr88+NKViP8f9P/MLEqloHXqeIoNFWMkg7gOLyvweXjBE7QjXpxFd7/tryglpqM=
X-Received: by 2002:a17:90b:1d52:b0:2ee:dcf6:1c8f with SMTP id
 98e67ed59e1d1-2ff497cb040mr4004247a91.16.1741153626527; Tue, 04 Mar 2025
 21:47:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20200116172428.311437-1-sgarzare@redhat.com> <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com> <20200428160052.o3ihui4262xogyg4@steredhat>
 <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
In-Reply-To: <Z8edJjqAqAaV3Vkt@devvm6277.cco0.facebook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Mar 2025 13:46:54 +0800
X-Gm-Features: AQ5f1JrNByKY7PtEfXG0ORfP7FScyD2MAlIYCt0mdU5F_0VbeZRH2Dv5bfH1am0
Message-ID: <CACGkMEtTgmFVDU+ftDKEvy31JkV9zLLUv25LrEPKQyzgKiQGSQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, davem@davemloft.net, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t8xSRuxxrHSZtX8Mc1WYZ6y3OJZY0mwBvKoUbAziAg4_1741153627
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 8:39=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> On Tue, Apr 28, 2020 at 06:00:52PM +0200, Stefano Garzarella wrote:
> > On Tue, Apr 28, 2020 at 04:13:22PM +0800, Jason Wang wrote:
> > >
> > >
> > > As we've discussed, it should be a netdev probably in either guest or=
 host
> > > side. And it would be much simpler if we want do implement namespace =
then.
> > > No new API is needed.
> > >
> >
> > Thanks Jason!
> >
> > It would be cool, but I don't have much experience on netdev.
> > Do you see any particular obstacles?
> >
> > I'll take a look to understand how to do it, surely in the guest would
> > be very useful to have the vsock device as a netdev and maybe also in t=
he host.
> >
>
> WRT netdev, do we foresee big gains beyond just leveraging the netdev's
> namespace?

It's a leverage of the network subsystem (netdevice, steering, uAPI,
tracing, probably a lot of others), not only its namespace. It can
avoid duplicating existing mechanisms in a vsock specific way. If we
manage to do that, namespace support will be a "byproduct".

>
> IIUC, the idea is that we could follow the tcp/ip model and introduce
> vsock-supported netdevs. This would allow us to have a netdev associated
> with the virtio-vsock device and create virtual netdev pairs (i.e.,
> veth) that can bridge namespaces. Then, allocate CIDs or configure port
> mappings for those namespaces?

Probably.

>
> I think it might be a lot of complexity to bring into the picture from
> netdev, and I'm not sure there is a big win since the vsock device could
> also have a vsock->net itself?

Yes, it can. I think we need to evaluate both approaches (that's why I
raise the approach of reusing netdevice). We can hear from others.

> I think the complexity will come from the
> address translation, which I don't think netdev buys us because there
> would still be all of the work work to support vsock in netfilter?

Netfilter should not work as vsock will behave as a separate protocol
other than TCP/IP (e.g ETH_P_VSOCK)  if we try to implement netdevice.

>
> Some other thoughts I had: netdev's flow control features would all have
> to be ignored or disabled somehow (I think dev_direct_xmit()?), because
> queueing introduces packet loss and the vsock protocol is unable to
> survive packet loss.

Or just allow it and then configuring a qdisc that may drop packets
could be treated as a misconfiguration.

> Netfilter's ability to drop packets would have to
> be disabled too.
>
> Best,
> Bobby
>

Thanks

