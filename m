Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC043170A3A
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727320902; cv=none; b=qa6LHLZJcVnWgzI7VYw9frY8YYA2FNY1ZTi044kJXHTimxGw81igGFgUC9mZ4mbAtQQB6ldPAKX+nD8izJO5GTbefxPjCAndvnEk1qo2sOsRweTl+Wua9LO01k/NzYAbOxmOja/uZXCs2/h6Pa7Yxp1bK12QO+zl0GR6s+jB67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727320902; c=relaxed/simple;
	bh=4CDnhpT/OhpNTb7hEbiCutfxBNfPq4uQEhSUnlk6a3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBDVVk4YcN7m+a6CwXMIJnr5+h012RIRYUZdXUiy8ccEYQs9cgGGBElRb6QX2ZKO0e9EciZnLv5JX9G1b+qixn0ypb5krlTqsOyZEHP6Mcqop0gCNH+sLJS5uGN2qmTpsI9XE2VeWw3tDo0mb+cy54vvCR+EyhAOWGX09zPFOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecIFW7N+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecIFW7N+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727320899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Bc4ouFpXmdQyZGkMNrFK1SqUMzTzJeHrK49fx3EOBU=;
	b=ecIFW7N+U/4Nj18BaQzyHnHLqRXFCod6wDfoDYwtdSAUFCh4whdnuy+AB99Df4pm+lZuxS
	6AvWVpCvOLb229I/eF5Bvw0oxwiNDDavJJP3ZjGQ9AmoLjB+/YY5otrj2gRD0zkDIkJu9F
	b8t19KL4DKAo2eaVXsSbhplyM5HvIl0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-6vNN0BROO8SOD8mpoZybNA-1; Wed, 25 Sep 2024 23:21:38 -0400
X-MC-Unique: 6vNN0BROO8SOD8mpoZybNA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2db5d285f7cso568834a91.1
        for <virtualization@lists.linux.dev>; Wed, 25 Sep 2024 20:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727320897; x=1727925697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Bc4ouFpXmdQyZGkMNrFK1SqUMzTzJeHrK49fx3EOBU=;
        b=jvRtPcr/OBhozqfvIv8/nYvwHWWpJXwKRclMU3qpYtjeYhcmpzvvWjh8dwTQcpASjD
         Wgrp1D64JEYeIrClePbzcwEt11BW7ez5ouv0Cz7hSOzHytciYO2TpaY9tIpV54DNQeif
         4urGTW0oGd8kjXJMOYNj2daGc47nZlGa3UoHfZN1PYay1Amk+kXtezuxQMIT961oLpaa
         ZkXd3arYVNHsBM9VNHQ7p/uiEcNWA6FoAdUPAI1xlecv49OENXUBUfxt//Ex7PIq1n4P
         dRZhubn/DTm2NVNYvt3mDfBiIS/I47/Tza9WgzCvJUeXusRSZB8gfFhRz9LJZ4ItahP+
         HXvA==
X-Forwarded-Encrypted: i=1; AJvYcCVUhC7ry5zA3JjAzNXAozVUISLJl/ET1vW7GvA1HfAfS11Xbt25Ps4dWtvkY/5DpqNbbv01XPeXYLcN3q4XZw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+8HOV3WRtxCTS/SSzLQjVYzCs0rtALav3FtxImPiNgm2eoOth
	yAdLShPVuUryHk4XmX0ONhVq0L/Sm2BbTitcj1NPFvcGVlQG7RAgnp4iOw1mWgcP+82YecUc0M4
	nQ5R4MgkBwk1ZBmo/GU2YXGbshVgMv0p6V1XsnRSiHP238ZXL7jCQHSh3/Fxtm13xXfvUUPfmGv
	onXBDTEK3rrTcG+WjNBiKgveAklobrDKMcLALunEs=
X-Received: by 2002:a17:90a:e64c:b0:2d8:8d61:8a50 with SMTP id 98e67ed59e1d1-2e06afc1b0dmr6712855a91.32.1727320897385;
        Wed, 25 Sep 2024 20:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA6i67AluzO/iHCK0PASZVHvo3CBR9hw5rx74kffdC7VwsoJZ9weFE1rf/TC/q7LBfpMvqFAV6wxuXuRrB1rY=
X-Received: by 2002:a17:90a:e64c:b0:2d8:8d61:8a50 with SMTP id
 98e67ed59e1d1-2e06afc1b0dmr6712824a91.32.1727320896832; Wed, 25 Sep 2024
 20:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240926022557.8771-1-quic_jianguos@quicinc.com>
In-Reply-To: <20240926022557.8771-1-quic_jianguos@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Sep 2024 11:21:25 +0800
Message-ID: <CACGkMEu-r2K1Xb-797YnK80-YeKEsErSe=BBP=xMbBvHcDv6qA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: Add polling virtio-mmio device reset completion
To: Jianguo Sun <quic_jianguos@quicinc.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, Sreenad Menon <quic_sreemeno@quicinc.com>, 
	Anant Goel <quic_anantg@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 10:27=E2=80=AFAM Jianguo Sun <quic_jianguos@quicinc=
.com> wrote:
>
> We write 0 to device_status to initiate reset of a virtio-mmio device.
> The reset operation itself may or may not be completed by the time
> write instruction completes. Add polling device_status to return
> 0 to ensure reset completion before reinitializing the device.
>
> Change-Id: If15d11d090dfd0d4972ad35f49af03e076872413
> Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
> Signed-off-by: Sreenad Menon <quic_sreemeno@quicinc.com>
> Signed-off-by: Anant Goel <quic_anantg@quicinc.com>
> ---
>  drivers/virtio/virtio_mmio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 90e784e7b721..cf1a4a3dd35d 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -70,6 +70,7 @@
>  #include <linux/virtio_config.h>
>  #include <uapi/linux/virtio_mmio.h>
>  #include <linux/virtio_ring.h>
> +#include <linux/delay.h>
>
>
>
> @@ -269,6 +270,11 @@ static void vm_reset(struct virtio_device *vdev)
>
>         /* 0 status means a reset. */
>         writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> +       /* After writing 0 to device_status, the driver MUST wait for a r=
ead of
> +        * device_status to return 0 before reinitializing the device.
> +        */

Is this copied from the spec? I can only see a similar description in
the PCI but not MMIO part.

> +       while (readl(vm_dev->base + VIRTIO_MMIO_STATUS))
> +               msleep(1);

Again, we probably need a feature bit to unbreak existing MMIO devices?

THanks

>  }
>
>
> --
> 2.17.1
>

