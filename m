Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8003148B7
	for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766992705; cv=none; b=ANHlLp3gIRyWF/0xR3r+BJkSdlUHsn+BhTDR0XoWSw5i1M09HeB3TLfO8CBIUmfRG0dzbn1BP+eFuxk42cFakQWii/l60HHC+CrAF3b1NuBAVa4YzFvTO+rUnqstYS1DqqhXlwA6vaKbUwloocW3NaRNn7Bk9p2hkovPbF/MSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766992705; c=relaxed/simple;
	bh=p/M3tGyPDIXCxuTiCHyHmUr/YXwQeaGNEJJYsR632GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btJdYYWs+ynNgH8ePxuqI33P/qXNQzaL7Cdf98Dyf6PXd02At/Af/Lyo/zFJVmfu8VXn5r2IubqnbsAVlUo4mgRDBE1SKcrF4pfDMWG4V13//FNWDuyKxoO1gsJ/yjMMxzdpwiVBKuee0oospM2jFM/Elq42hIGDlxcAESJ1Uco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQ7WmLOL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQ7WmLOL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766992702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlCNi950y6nC/QzwiS4iG67JeiGCGi+GshLA8xEoYPE=;
	b=eQ7WmLOLr/mgSHbtg2GJutIl1WXRBZG2YP9ETAzf2nAotOzEuZwQWXBWG62eCLfo+yrYrW
	FYvE98i8GeMg4VtmpHfXIGGj2AhBACl5wM3lDU+DGKdwvg7suCUvEbQVdjuljq6bD5uXEv
	i5Bns8LzNpBwj+rDrA0rJq5l7bjnbAU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-btYYTK4-P3KAEA_dPE6gAQ-1; Mon, 29 Dec 2025 02:18:20 -0500
X-MC-Unique: btYYTK4-P3KAEA_dPE6gAQ-1
X-Mimecast-MFC-AGG-ID: btYYTK4-P3KAEA_dPE6gAQ_1766992700
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c213419f5so8350889a91.2
        for <virtualization@lists.linux.dev>; Sun, 28 Dec 2025 23:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766992700; x=1767597500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OlCNi950y6nC/QzwiS4iG67JeiGCGi+GshLA8xEoYPE=;
        b=ZQmCv9MCMvpJVls6/pNjnWsAJ82LXK0XYqUMCgVFLwj2wWOMW7Y2ju7RIUu3d1ymfo
         wwKq7Rwo5IrATCtzoY7n4zU+NhBo5HcRrFcxQh+p7LWty8tN9TjCAsqupJ3aBpNuSQaQ
         L29JEkMPA8DAlZbBAt9WwV45mh3Z+TllvDJmv6yZDgY1vl15yNvED3YgbYdsHHW9SJNf
         PCYKsJ0B7ZSIx3UeShywHz7aK1EI29CM1ivEwjS0k34hJulb+aL/ieAFx7rkYZQUwOXm
         OIZXYjRNnUBus7UxEm8PnWYGrSR7mqRC8iIv2yl16IxAJmnTXunQE6OiZGnpZZtnF60u
         2/xA==
X-Forwarded-Encrypted: i=1; AJvYcCUwyzREqymHNsfCbLxrm1nlKgOwyMJaSULU6DLKFNlc4RJzEy/zTAkc3UpcNlHNJlyrKqi4A2+hvmkcaicW0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzr8QmQ13EKkCbkV6zFJh7aC4jBPkR/0xk/ROUonsjs83vP/PuH
	OvxHw1lrotjFLYgaqAYGM3ZUtJ2/iPAk6L7bdxFMHEXFkTD7R8/BjThv3/Zu1VzIbS6mmHG06Sz
	rLOr/EO/AwelQgUOYGiBQsvnO7F63ULtzeTCCLCsoWVMSFL8Vld1pYACHwsekE8BsnJ3Cioxae7
	N4aF9xONay9uQ57H98gvpKz/XdbF7lTfTx35KSiPceam4=
X-Gm-Gg: AY/fxX41LRuGYVg5MBSGpwA6CsLdX2SQ7yNu58sbmmeavobkmWgMM8V/ChWFQckODqV
	KwtoPp/XNgPu74r6yqtMza3tbxIvAa3bQ8cPNYV7xPP2q1RG9691rOJqItLLFVUEXItYOEP78uP
	D5sAlS911Dls6XacWaIxnDIcNn+Dl495/I3ZLZkAYVAfIyKzuXW/NaNvN9H4ptf8km/AA=
X-Received: by 2002:a17:90b:54c3:b0:34c:2f3f:d27e with SMTP id 98e67ed59e1d1-34e92113230mr25141436a91.3.1766992699829;
        Sun, 28 Dec 2025 23:18:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGixgnG3FlhDzVQcNBONbnt2VaxLnKj5pegXz2c+fq8jQ3DFw9CfqC7s0Vudio/oMzFA5JrnLpxj/t2SYyChho=
X-Received: by 2002:a17:90b:54c3:b0:34c:2f3f:d27e with SMTP id
 98e67ed59e1d1-34e92113230mr25141426a91.3.1766992699447; Sun, 28 Dec 2025
 23:18:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251225042608.32350-1-jasowang@redhat.com> <20251225042608.32350-20-jasowang@redhat.com>
 <20251226145001-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251226145001-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Dec 2025 15:18:08 +0800
X-Gm-Features: AQt7F2qpMZ8yqOoPXDwD20stFdvFlEBJTPPf5wYkCjIBr-WPBLQ4Aqhy9yX_TVk
Message-ID: <CACGkMEuH0x1xxC1+yHg3A8hdEz=XMRCnSM9zarEFa=8=BcnsyQ@mail.gmail.com>
Subject: Re: [PATCH V11 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8qE-n2PKiE1xCoKtPwKSDC3luXz9WMbcNaNtryF6lok_1766992700
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 3:57=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Dec 25, 2025 at 12:26:08PM +0800, Jason Wang wrote:
> > This patch implements in order support for both split virtqueue and
> > packed virtqueue. Performance could be gained for the device where the
> > memory access could be expensive (e.g vhost-net or a real PCI device):
> >
> > Benchmark with KVM guest:
> >
> > Vhost-net on the host: (pktgen + XDP_DROP):
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  4.51Mpps     | 5.30Mpps    | +17%
> >     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> >
> > Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> >
> > For split virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
> >     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> >
> > For packed virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
> >     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> >
> > Benchmark also shows no performance impact for in_order=3Doff for queue
> > size with 256 and 1024.
> >
> > Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---

[...]

> > +unmap_release:
> > +     err_idx =3D i;
> > +     i =3D head;
> > +     vq->packed.avail_used_flags =3D avail_used_flags;
>
> Hmm. But this does not roll back packed.avail_wrap_counter.
> Shouldn't it?

Fixed.

Thanks

