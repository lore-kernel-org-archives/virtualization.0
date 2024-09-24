Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C214D6F7
	for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163618; cv=none; b=IAsrERXn7JP0BGUlBgLh7T8Y/nKxmhS8MKMeC/F86/iR2ioArPfe0XMXFsAa6OxteUjxpyZj6ZLa9tMyE2ih1+F1mNw8/qiQ+3DefOA1XfPiee8qrPfgbSAT1QwNr3aXZN+RmeOm7NmmsuxNAaW3+pvmnGTCN4TvhspcBM3bfNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163618; c=relaxed/simple;
	bh=2njAe6QvoaHxFO69PDYK9tdZp0nbpRgWkWBOBrBjOog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmUmjPbKnoPua3SfeAjTrL4/TW5Ndj+SSZk0q9uKPDE8he92ImeXXzkdtMVZnJA3KD2YfbkEtMb8VsiwIwPvI6DxBqlw/eLe5opR3EJ8WoDZRirpipsMtn73cvC1y27PsSjn8I+V5/NFWYoGC9ZMoewFLzQB/531x8I8hDVyMg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+WQqMRh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+WQqMRh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8lQHIfaWPFUe3zSF47wFo/UFEzkkp7M1o89AhJkkBE=;
	b=N+WQqMRhT7HaYubud46mjjTszd5JwzWplae5nG9wUrtbGEu3KTyR/fDfTNYouzr7gtseFY
	3A8L1ARGwAmA3snkxHPgRoi5gte3A49TWsrJUvw8ncqEDwDWWWGaxI9HVGKFg+HJ37+tor
	SmncPPAPTF/wqZW7M1x9bbd+FjWK72c=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-IF0EIP4-MZCrzwV7V_6vnA-1; Tue, 24 Sep 2024 03:40:14 -0400
X-MC-Unique: IF0EIP4-MZCrzwV7V_6vnA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d877d2ad3fso6654116a91.2
        for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 00:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163613; x=1727768413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8lQHIfaWPFUe3zSF47wFo/UFEzkkp7M1o89AhJkkBE=;
        b=niM2ZSZqRBOuxh2sXrfSbPwNONXSgCTx1NCW1+KTkPtYaMwVG9YWPO5VknkibG/E5p
         aV/tdEf89wMcBKlFo5fEBSOq9f8DQh9EUcYgjIRAZntEcZH9Q38zHx7lGJSPQJmcN39T
         8vNKK4v797SY9rS59GbPMy2BXj/g3x4eYJ00F4EDglDgFh5bUuJ6lzBTT8ZrcWo847w/
         k88qWlzCg5o2yitEXbWihe7sHHedA49mArGtteP2CKhk2VROLYmbk/SnNMVV89i6NEEB
         1NToYdQxjt/nf02ndfpeIWzdyTmlsg/yNDzNZUX9pbKALFtwVdQPgnh4CG/enG4HVbO9
         rl5g==
X-Forwarded-Encrypted: i=1; AJvYcCU6DA+VWGHnlzfb7XX1SjFKXDPWd12AaOCWdeKdURP+je/i0VI2dDkCvyM7sTT5LZIOThD32m1r5KiHG+JvLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyV4PbrIPdG7HidQDdxfqTdPGdh1faHgQ1HyYP9Pq1+ShZekmXA
	qD/JwnsLen+l2lDtqpMxo5QsHhfe1GLDn4g4IlBcpjPk66zu/rz5cxX/sQzWLRq/MTk9r+QpshR
	mlFTdjoS7ttzbRLjIyf34ED+NNxxnJ4y57WGzKgVYSRul8McyT/ZytQ3qe+/ttuAS9I8rfSlww0
	WIf/7rFzS8H/9ZHE3SxMuSIrMInG5XcwPpJLbQ0eI=
X-Received: by 2002:a17:90a:b310:b0:2dd:6969:208e with SMTP id 98e67ed59e1d1-2dd80c05478mr17580809a91.3.1727163612949;
        Tue, 24 Sep 2024 00:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ2Im43UOhl6GhIdMfutmf4/33jVfrqegnRqlvIn7wldAWk22gHtGBGE/bKOO/QD+zm+wbXUvBpjVJ4bkzcy8=
X-Received: by 2002:a17:90a:b310:b0:2dd:6969:208e with SMTP id
 98e67ed59e1d1-2dd80c05478mr17580785a91.3.1727163612540; Tue, 24 Sep 2024
 00:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240922123435.17946-1-quic_jianguos@quicinc.com> <20240922123435.17946-2-quic_jianguos@quicinc.com>
In-Reply-To: <20240922123435.17946-2-quic_jianguos@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Sep 2024 15:40:01 +0800
Message-ID: <CACGkMEvK9F60FM2v5EW6OOtHP__-nAH087oUX_UM09df2LXvXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio: Add polling virtio-mmio device reset completion
To: Jianguo Sun <quic_jianguos@quicinc.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, Sreenad Menon <quic_sreemeno@quicinc.com>, 
	Anant Goel <quic_anantg@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 8:35=E2=80=AFPM Jianguo Sun <quic_jianguos@quicinc.=
com> wrote:
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
>  drivers/virtio/virtio_mmio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 90e784e7b721..c34ad1782145 100644
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
> @@ -269,6 +270,13 @@ static void vm_reset(struct virtio_device *vdev)
>
>         /* 0 status means a reset. */
>         writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> +#ifdef CONFIG_VIRTIO_MMIO_POLL_RESET
> +       /* After writing 0 to device_status, the driver MUST wait for a r=
ead of
> +        * device_status to return 0 before reinitializing the device.
> +        */
> +       while (readl(vm_dev->base + VIRTIO_MMIO_STATUS))
> +               usleep_range(1000, 1100);

I think we can just use what PCI did, which is msleep(1) here.

Thanks

> +#endif
>  }
>
>
> --
> 2.17.1
>

