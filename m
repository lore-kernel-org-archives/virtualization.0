Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2395230596F
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768186473; cv=none; b=QHYRCxi3NYIQi7f1/j3qqjROstrXa7pbQQ0yZgOTxhxqSClYYihfp/qFb3zMTKBWg5jyjcMRfIH9E1kL5bXYfzzmLT12K3EM0Uy7XwGabqZNT1dZeqxNZX1H7bUZruMxprBhOTgkaFR7xvUhqky3UvM7zKrawYNgUAPk17QowYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768186473; c=relaxed/simple;
	bh=zGRMpYKy7NCfokFDjEXNjbo5Ew8CX3dBTGlMCpqTu7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkfZeyhACSDp5/nuxKYK16SimZa03F28I4YHXLQKpAJrJkJ6mmmSmB5E2nNc3pQvSB50Vvzq+Umr6jR34PQBZVUIGrpaRz58yUuxZr9Z17BwEnZdvM5XQzHU9rjmSWyjGYdoKlOWO2CY9XNM8wFZFeRnpbeFp/NV76KoS8MoVX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtEWCeJ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtEWCeJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768186470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDyfAYjuPwMDl+ZxFK0vKOD/U0p/YZ18QWUvbiOWh/A=;
	b=HtEWCeJ/1nLI6Kq7HfVVa7ltOlwwFEW9qLLltd5rCeI6PMJtkOfNPYSR70qCJhtyqG3HvD
	wWP4c3l48ifSrsabnkM+0D68deWQZTSxf1bGUX+PRtvPlwI6YjmVO+df8BI70hxbVVC0ZQ
	2D8lhhBy12szZglQoHthlcda+plbBOU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-qfgF_Lq-NZm8DF87JsFBIQ-1; Sun, 11 Jan 2026 21:54:27 -0500
X-MC-Unique: qfgF_Lq-NZm8DF87JsFBIQ-1
X-Mimecast-MFC-AGG-ID: qfgF_Lq-NZm8DF87JsFBIQ_1768186467
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34cc88eca7eso6388015a91.2
        for <virtualization@lists.linux.dev>; Sun, 11 Jan 2026 18:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768186467; x=1768791267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sDyfAYjuPwMDl+ZxFK0vKOD/U0p/YZ18QWUvbiOWh/A=;
        b=PxgRDbAMhnsWYmiICTBILxd24fYDEMQSQxgCb1dVVCYjkaMKll1bCeIOzBFmcOMMri
         Uy93lu4Za0tTn3pRL11UZRkP06zx/BY82SdwtaieTIyfGF3Lfyy9KkIZIRPPQnmC/jNo
         ciZ60jqCBTmB1Q7cvPcPgr2GvACB/vpAcZhBpoTxcqOV3G0locsn0jBTE6i482dxkuTq
         iFtmDf+PUbRqHpKpQGP2jYm4TGYeJcWRuz4+dpUXTjmndFZkyurr1EODUckjgEdqa7Vo
         imeFcKXZMiVhwItnT5wxSUr1fQt5/Lbtt4rMryj4wQk9X1JZ9rGxGAO2lvdAnM5dlorg
         b3+g==
X-Forwarded-Encrypted: i=1; AJvYcCWYiBIO/okIIRTCkei4E2uR8II4xVn7RO2jzjB9bKoP1Xw+7aY12clT581J+8OPxaPeFa9Td+l3pkrdwSWtaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/bTEnUnqN36i9Fzpw/b2UhTOS16ONCjv67XESy68R/RX2u4VP
	k52yJoGrmUdulO7ax8Sw1tBoBrePQhe4ThubPF23WJ9XDPvUaj2PVEOYvompjYYAiUxOSi6NXfI
	AQth+TsdjDLM4kffdIDtxOUBSiye/oKU+ZcmkTzgw+7PobuegwQWuKMfkdPfZRkb1LBhEsKM3w4
	m9YAkwL3azLT8HA+0UDPZ8ELeR7lYJmsxBw3cTCkNF4aQ=
X-Gm-Gg: AY/fxX6ig+8vjzl58JeV8KRIcQ9NZyTIw6IT7DN/8t8G1IOug94+IkPG4finOro32MV
	Yz4mI60W5PNXgGC+IydGOlwaI0AMjBcZSG6bd/fqGqXOfvPuePpQKgLPEwTDUeJC4I9QD7viyRD
	5bxFCXYLbT+15CcwXIuL6RZPMpVhcByYk7NvkcwbdXXDQgR9kPMSIRvMcdgXaPYZ4ZQno=
X-Received: by 2002:a17:90b:578f:b0:34f:6312:f22c with SMTP id 98e67ed59e1d1-34f68aed27bmr14111544a91.0.1768186466686;
        Sun, 11 Jan 2026 18:54:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGXzUyZmp1tWX++x0G65O3OR3ED7oEjlI25F4JANfILTteUWkwPCmSotiUwilA3S2tZsCRJQcG1meJ8mKehq8=
X-Received: by 2002:a17:90b:578f:b0:34f:6312:f22c with SMTP id
 98e67ed59e1d1-34f68aed27bmr14111529a91.0.1768186466287; Sun, 11 Jan 2026
 18:54:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-8-simon.schippers@tu-dortmund.de> <CACGkMEtndGm+GX+3Kn5AWTkEc+PK0Fo1=VSZzhgBQoYRQbicQw@mail.gmail.com>
 <5961e982-9c52-4e7a-b1ca-caaf4c4d0291@tu-dortmund.de> <CACGkMEsKFcsumyNU6vVgBE4LjYWNb2XQNaThwd9H5eZ+RjSwfQ@mail.gmail.com>
 <0ae9071b-6d76-4336-8aee-d0338eecc6f5@tu-dortmund.de>
In-Reply-To: <0ae9071b-6d76-4336-8aee-d0338eecc6f5@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Jan 2026 10:54:15 +0800
X-Gm-Features: AZwV_QiDbqKshtfzYu2XaNQcD4zIgEOkEtzvAYmkzLCTpPxpz5hLy6ho4yA73K0
Message-ID: <CACGkMEsC0-d4oS54BHNdFVKS+74P7SdnNHPHe_d0pmo-_86ipg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 7/9] vhost-net: vhost-net: replace rx_ring
 with tun/tap ring wrappers
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IYWbbn9mr2-Zn_Ph_L9taQ9WGhYnD8WFs6mhrO3gEUQ_1768186467
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:57=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/9/26 07:04, Jason Wang wrote:
> > On Thu, Jan 8, 2026 at 3:48=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 1/8/26 05:38, Jason Wang wrote:
> >>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> Replace the direct use of ptr_ring in the vhost-net virtqueue with
> >>>> tun/tap ring wrapper helpers. Instead of storing an rx_ring pointer,
> >>>> the virtqueue now stores the interface type (IF_TUN, IF_TAP, or IF_N=
ONE)
> >>>> and dispatches to the corresponding tun/tap helpers for ring
> >>>> produce, consume, and unconsume operations.
> >>>>
> >>>> Routing ring operations through the tun/tap helpers enables netdev
> >>>> queue wakeups, which are required for upcoming netdev queue flow
> >>>> control support shared by tun/tap and vhost-net.
> >>>>
> >>>> No functional change is intended beyond switching to the wrapper
> >>>> helpers.
> >>>>
> >>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Co-developed by: Jon Kohler <jon@nutanix.com>
> >>>> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>> ---
> >>>>  drivers/vhost/net.c | 92 +++++++++++++++++++++++++++++-------------=
---
> >>>>  1 file changed, 60 insertions(+), 32 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >>>> index 7f886d3dba7d..215556f7cd40 100644
> >>>> --- a/drivers/vhost/net.c
> >>>> +++ b/drivers/vhost/net.c
> >>>> @@ -90,6 +90,12 @@ enum {
> >>>>         VHOST_NET_VQ_MAX =3D 2,
> >>>>  };
> >>>>
> >>>> +enum if_type {
> >>>> +       IF_NONE =3D 0,
> >>>> +       IF_TUN =3D 1,
> >>>> +       IF_TAP =3D 2,
> >>>> +};
> >>>
> >>> This looks not elegant, can we simply export objects we want to use t=
o
> >>> vhost like get_tap_socket()?
> >>
> >> No, we cannot do that. We would need access to both the ptr_ring and t=
he
> >> net_device. However, the net_device is protected by an RCU lock.
> >>
> >> That is why {tun,tap}_ring_consume_batched() are used:
> >> they take the appropriate locks and handle waking the queue.
> >
> > How about introducing a callback in the ptr_ring itself, so vhost_net
> > only need to know about the ptr_ring?
>
> That would be great, but I'm not sure whether this should be the
> responsibility of the ptr_ring.
>
> If the ptr_ring were to keep track of the netdev queue, it could handle
> all the management itself - stopping the queue when full and waking it
> again once space becomes available.
>
> What would be your idea for implementing this?

During ptr_ring_init() register a callback, the callback will be
trigger during ptr_ring_consume() or ptr_ring_consume_batched() when
ptr_ring find there's a space for ptr_ring_produce().

Thanks

>
> >
> > Thanks
> >
> >>
> >>>
> >>> Thanks
> >>>
> >>
> >
>

