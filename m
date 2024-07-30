Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74261CD25
	for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722308019; cv=none; b=KxmDqx8Y3s9GyYTtLuWHbq5LYOQCsO3xCRUeTncLxpjSituj79gu9CO1eRll4i+en58CD4YP88Vh+SumDbnWgho5Mmj2DDhNE44OkTBDF8fudYxG8Ik1LFFJxFhJNHpUk4RtaDQLP4XyxBXpPNMmt3AGCWV9H/Se+Ndx0aq4D5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722308019; c=relaxed/simple;
	bh=UgXyxPACJTmYK1zqo8XzWIxH4H8JZmM3sk4Q+Eo9xko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATy74apY4hg1zm0AAoeyNNJq2tI7VqdZH52B2n8YyP1xnBD8yX3CsTagV39/32oD3t9rQkz6TWfAJEzHJY2y9buyAobxWu4di5zfV50NfIz+w60XU8Nc1ZoymAwxG1FrKW33xGrUlX5GkcmIzjJwNusMeURMpX5+w1y7CoNGa/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlMVdZm6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlMVdZm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722308016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pf2oNa15UgzsDOJ7PYKJ01ICO7giqCRwFUISFTWMV2c=;
	b=VlMVdZm6VV6ufx6wrWpKMKU6J3RN+6UiS8fBAeGat62a2T+O2uc1oWrpdqB4Wtpiy7sNLj
	mkDWydqqtt6Vf2fHvZWViKBVwCaKYQf2s+r+q16zMx+1O8TfMZy4luZSuSVtbuvXn6ci7I
	pXrv5iub6V0JAonRwWsnLvyG5pjzAys=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-FpvIfmitNK6rNs0EVoKQTw-1; Mon, 29 Jul 2024 22:53:34 -0400
X-MC-Unique: FpvIfmitNK6rNs0EVoKQTw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c96e73c886so3718302a91.3
        for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 19:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722308014; x=1722912814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf2oNa15UgzsDOJ7PYKJ01ICO7giqCRwFUISFTWMV2c=;
        b=Q4WdRmiW/Mf+IwWLuCsfVESh/de6h+598nNsUjbB058mzsTRf5gzLmilwEfeUziuK/
         Y6JtPJVAK7CNc6ZMZ6aPA09/O9mDn59oyww3ymQ7Tphgj6m6wyf3hOmBrBwGatQ8g43M
         IQeluENVpkOUZ9K22w1YehJCWlQ9A2RhHVj/OKiLcX5m6vJ28P4Dj1k6UJRQKqhqpLMa
         nnZFC/i1ZimYfJHAl7mmPNGxmsFEwfOX7+zekXSG5C9Len3+PNmBrx8eqBO/m/dQbhXa
         zWBEpmWUqzVbHWy5Ge18mtzvhoKQmwVjG0clyjFvdsWTUkdPKNy7n5oYwvL2cYBfZo2Z
         CcDg==
X-Forwarded-Encrypted: i=1; AJvYcCW48Zhkp83nE7hJuwNiZrXoWev4/N7nlJ/+kc42/2sUTm0sLxlWtKV9mJwhJbDGDVOJFN4izzrHKsWCEdIcfufzKcyRnB/z7g1M/oCKa2o=
X-Gm-Message-State: AOJu0Yz4Gh2Rf1ql+lh7eIHGUyNVFfk2ObgGki3oAPZd2ayy9Bvfe7xr
	Z7If8V3QR5DsB09lEitdM4qpOK691j5bS0Oq3PD6VaxgtCieL+GHaq4+JQ6hnvAUeVl+iaspNNj
	U//AIxCkJITytblG80WEahp8jypG4Awr6syuZqra/g81RWA7hdoNg9BRoTFB6tPAi9g1BKnsn87
	atMGooC4vShAiUh2QNRbC3OO0atnvobxmdV1/IzC8=
X-Received: by 2002:a17:90a:f481:b0:2bf:7eb7:373b with SMTP id 98e67ed59e1d1-2cf7e5eee82mr7428400a91.33.1722308013821;
        Mon, 29 Jul 2024 19:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBMYzwmCiSjP8qVr171TTbIYCW39PgB4Y7cr4qfYqHe4U3QCp8OBifcNExr4HI/xSxOXGs6Kn/N+2O/OGqqc8=
X-Received: by 2002:a17:90a:f481:b0:2bf:7eb7:373b with SMTP id
 98e67ed59e1d1-2cf7e5eee82mr7428373a91.33.1722308013272; Mon, 29 Jul 2024
 19:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724033816.GD492231@quicinc.com> <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
 <20240726124211.GC723942@quicinc.com>
In-Reply-To: <20240726124211.GC723942@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jul 2024 10:53:22 +0800
Message-ID: <CACGkMEu03NQ7ez72Gr5tmBb2+28g-kFC0ADEKx8TQwFFwpn8Fw@mail.gmail.com>
Subject: Re: [RFC] vduse config write support
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: xieyongji@bytedance.com, stefanha@redhat.com, virtio-dev@lists.linux.dev, 
	virtualization@lists.linux.dev, quic_mnalajal@quicinc.com, 
	quic_eberman@quicinc.com, quic_pheragu@quicinc.com, quic_pderrin@quicinc.com, 
	quic_cvanscha@quicinc.com, quic_pkondeti@quicinc.com, quic_tsoni@quicinc.com, 
	eperezma <eperezma@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, mst <mst@redhat.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 8:42=E2=80=AFPM Srivatsa Vaddagiri
<quic_svaddagi@quicinc.com> wrote:
>
> * Jason Wang <jasowang@redhat.com> [2024-07-26 10:47:59]:
>
> > > 2) For PCI pass-through devices, we are concerned of letting VMM be i=
n charge of
> > > emulating the complete configuration space (how can VM defend against=
 invalid
> > > attributes presented for passthr devices)?
> >
> > Virtio driver has been hardened for this, for example:
> >
> > commit 72b5e8958738aaa453db5149e6ca3bcf416023b9
> > Author: Jason Wang <jasowang@redhat.com>
> > Date:   Fri Jun 4 13:53:50 2021 +0800
> >
> >     virtio-ring: store DMA metadata in desc_extra for split virtqueue
> >
> > More hardening work is ongoing.
>
> I think above change is not sufficient for what we are looking for. In
> particular for pass-through PCI devices, we are concerned that a untruste=
d
> (compromised?) VMM can return invalid attributes when the confidential VM=
 reads
> the configuration space.

Yes it is, virtio specific hardening can't cover this, it might need
help from the PCI core.

> These are PCI devices that may not support TDISP.
> Hypervisor, being a trusted entity and controlling the PCI bus emulation
> can ensure that the confidential VM sees valid attributes for all devices
> (physical and virtual) that are enumerated on the bus.

I think I need to understand the difference between hypervisor and VMM
here and which one is trusted and not and why.

> That's a key reason why
> we want hypervisor to emulate access to configuration space of all PCI de=
vices
> enumerated by VM. That I think necessitates that hypervisor handle access=
 to
> virtio device configuration space as well (even if MSI-X obviates the
> performance arguments of hypervisor doing so)!

That should be fine, but it means for PCI you need a lot of emulations
(e.g Qemu emulate q35)

Thanks

>
> Thanks
> vatsa
>

