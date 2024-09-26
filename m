Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E051171C
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727330967; cv=none; b=rApNOoyuJyCMKO83zJuRk7ns9A8obDw5qs0baidRFcbhsn1obOXSi7e//AQi7+H3RcClLh6mI7oYlNJmuYRIvOI+aEvYLk0zOYIiTe0HzXtRXHs1S72x6ZSO6oaIVh4CqueRtMCgJKWs97nfa8UBm/TM+qwHEN43+ta6TKqqdog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727330967; c=relaxed/simple;
	bh=C6m2FS5TtlnSHNWeVHluF6MQlZ/ld5ffn93qT/GpKlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OUnuxhZOrC993R4FoZ661uRXZvp4h+XgC6iQNSW2jsLO1QEp6yiLhJNOvuwXXrU3+atZ2l94ojBx51u+ddKcY+bttvN1sukZUowxUi7wEDdyGdKymgLWKvdeH6pKtQzHmxeTJn1zylijdYgipAOrECBFb3kjfSTA6ga/l5xpANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g3yt/qql; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3yt/qql"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727330964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMQwGza9ZFK8ZdSoFU1ztpqg6TJC/q/KXVB1OJf6aSo=;
	b=g3yt/qqloGjbOHUUjxcI0BOAPdBW3Sd1x+U7zZinfsBHkaoJPhiKcLnKc+t2v1MyGsjEGo
	+IJns8iwjqZFd86hA7TDYJ5NahbMRdPK7dr6fSZJWwFDtRBCAXMUVLb0oTy2eeIZE/ZdpV
	FCTdO7neih3SwuSLBc6/kQbmtgVN3zc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-8f86ewcuMS-o7qh0BHnMJg-1; Thu, 26 Sep 2024 02:09:23 -0400
X-MC-Unique: 8f86ewcuMS-o7qh0BHnMJg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374c3402d93so283814f8f.0
        for <virtualization@lists.linux.dev>; Wed, 25 Sep 2024 23:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727330962; x=1727935762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMQwGza9ZFK8ZdSoFU1ztpqg6TJC/q/KXVB1OJf6aSo=;
        b=HlLC36aMu3rC0kSd2FtyJlfy/zJzslwbqYbz6JBVmtCwGKx/3LDR8d7dhIJDI/claS
         gy/26c4lgTYkCtPVadYag2QTvtIz9Qp7RVaLCzFvdUMiOHH8t6TXsKYVfybt+nEpOYdw
         caVYmagleoKLDzIvB5PYkzEkrhicwhp1BGjd+p1vlmA9Huqxg18OI791isu77P68ekVI
         tKA85XfhaLXTbDPKu/BrWE9QVFKj7S9/zjZAgudlC1ApVNfIwnRejApwTPfwCmFGavHl
         /FNl7kpD/mTlzCkeyINzUeuJVQSmFA7AvHK/lxjrDLZt74yISGW+qWnomynpeZbXejnH
         6Blg==
X-Forwarded-Encrypted: i=1; AJvYcCVqNjJ25988XFPoLz5M26RbM+rVymiNzsHiSJUAJbbnoWqIQ3GnnHRy3g6SbYefi58sPaNpsXMBxaCn4ewOsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhJSNTLEcIuT5rjxDVib55BtC1AG/AkKDEMEuQ6w9592nMhPPY
	dLidBfTt3TJX3/+duJQKLBLp0OWZnptfpD2kqJxVDWxZ2+7uVaFusekFeta4dwU8jQmBjDno6RC
	XSmS4Xe3zIdqd4ygrqsx9+304D/+VImyhhM3DDMfXQ/IiJ0sYCJBW/AntyB0YhvP+
X-Received: by 2002:a5d:4341:0:b0:371:8319:4dbd with SMTP id ffacd0b85a97d-37cc2467664mr3595465f8f.17.1727330962153;
        Wed, 25 Sep 2024 23:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAU9mY/oJ2N7aq1FbKqNvOrr+w0NOcakpXu2sWX7cSSyPcZK2h+EzFqi6y1H0b4AOcapEMng==
X-Received: by 2002:a5d:4341:0:b0:371:8319:4dbd with SMTP id ffacd0b85a97d-37cc2467664mr3595448f8f.17.1727330961704;
        Wed, 25 Sep 2024 23:09:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:1ead:3828:4c0c:a50:df14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a55336sm36758585e9.47.2024.09.25.23.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:09:19 -0700 (PDT)
Date: Thu, 26 Sep 2024 02:09:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jianguo Sun <quic_jianguos@quicinc.com>, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, virtualization@lists.linux.dev,
	Sreenad Menon <quic_sreemeno@quicinc.com>,
	Anant Goel <quic_anantg@quicinc.com>
Subject: Re: [PATCH v2] virtio: Add polling virtio-mmio device reset
 completion
Message-ID: <20240926020709-mutt-send-email-mst@kernel.org>
References: <20240926022557.8771-1-quic_jianguos@quicinc.com>
 <CACGkMEu-r2K1Xb-797YnK80-YeKEsErSe=BBP=xMbBvHcDv6qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu-r2K1Xb-797YnK80-YeKEsErSe=BBP=xMbBvHcDv6qA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Sep 26, 2024 at 11:21:25AM +0800, Jason Wang wrote:
> On Thu, Sep 26, 2024 at 10:27 AM Jianguo Sun <quic_jianguos@quicinc.com> wrote:
> >
> > We write 0 to device_status to initiate reset of a virtio-mmio device.
> > The reset operation itself may or may not be completed by the time
> > write instruction completes. Add polling device_status to return
> > 0 to ensure reset completion before reinitializing the device.
> >
> > Change-Id: If15d11d090dfd0d4972ad35f49af03e076872413
> > Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
> > Signed-off-by: Sreenad Menon <quic_sreemeno@quicinc.com>
> > Signed-off-by: Anant Goel <quic_anantg@quicinc.com>
> > ---
> >  drivers/virtio/virtio_mmio.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > index 90e784e7b721..cf1a4a3dd35d 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -70,6 +70,7 @@
> >  #include <linux/virtio_config.h>
> >  #include <uapi/linux/virtio_mmio.h>
> >  #include <linux/virtio_ring.h>
> > +#include <linux/delay.h>
> >
> >
> >
> > @@ -269,6 +270,11 @@ static void vm_reset(struct virtio_device *vdev)
> >
> >         /* 0 status means a reset. */
> >         writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> > +       /* After writing 0 to device_status, the driver MUST wait for a read of
> > +        * device_status to return 0 before reinitializing the device.
> > +        */
> 
> Is this copied from the spec? I can only see a similar description in
> the PCI but not MMIO part.

Not in spec. We can add something like this in spec, but it
can not be a MUST, has to be a SHOULD.

> > +       while (readl(vm_dev->base + VIRTIO_MMIO_STATUS))
> > +               msleep(1);
> 
> Again, we probably need a feature bit to unbreak existing MMIO devices?
> 
> THanks

We can do this unconditionally since legacy devices return 0
immediately, feature negotiation happens after reset, won't be useful
here.


> >  }
> >
> >
> > --
> > 2.17.1
> >

