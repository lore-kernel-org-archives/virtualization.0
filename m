Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90467262A
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247935; cv=none; b=KfYE7z3rZvusldrnMkImtf3zfTS4Kz3kynGfFGNoMH4ZaackwwHkShKeN0cXHV33lHaOQdd4C4Mo5lvCzxaZYMB02YmnsR/BIOfm+ZUOKlxC5vTk6ygtHa4lJ/EMW1P+pcJorgRD9F2Pyp1ahWoqO62t0Rzju0c4KQ8//s4whSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247935; c=relaxed/simple;
	bh=VuBGy/Zu/mySTTTY3L1RI3B8W7Q1gIBkN5jQ/zIOlc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7G8+rRob3riRHHvAbjXp8zKFxtoqs34fBrN7RVftm5KSvxRyAxnPXUPhCvFRHs4u4aNtuk55pdkmGQvjfDbAi7TTraXWb/GFo1ouBOFDTmSWfZoXmjZiq7edeSeqjmBAASNq7IHq+C4Z5tEnE+YrHLo7XYDjaIZoWfcDLbeXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QbbgAQE4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbbgAQE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758247930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDgjUaWucf5m2XRF5I2ikU7gc9TowCe3ao+cs/ZTo2c=;
	b=QbbgAQE4gOt8Duicz7GEmeOYrlpzQccMRqWuNH08ujNMDRH1YQu1UPpGKiFSMFEfah8ElD
	30kzvVCn97kFbQcvODCo3mgbAbBOdT86xUL6tDwG6vuH5hb8M94Qf98tdAJHEw9DpVUojJ
	pTzaU1l9grgRzpwzwLFQvRvcPIHgciQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-KIm01iyrN1SXiC441fztSA-1; Thu, 18 Sep 2025 22:12:08 -0400
X-MC-Unique: KIm01iyrN1SXiC441fztSA-1
X-Mimecast-MFC-AGG-ID: KIm01iyrN1SXiC441fztSA_1758247927
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4f87c691a7so2419956a12.3
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 19:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758247927; x=1758852727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDgjUaWucf5m2XRF5I2ikU7gc9TowCe3ao+cs/ZTo2c=;
        b=Y0RGoKFrcCf+4RuRGlQucVBW10vTxJ/SmjAN2fL57ElaxotKqoZpGs44n1gyNWMjqc
         K0MiClDVsUSM+YwNwk5x/XbX74wOX4XLR8Dfgx+5YfAOQhp/od7CqK1y+r9WnxIW8P8X
         9KZbM30+HZLNCM21KbtOKw03FPnV851KJte4Ce5IYKekSrp9CqwJ5q6/xJxCvDnK1koQ
         gyU+1tEEjqa/P+Mq+R03Uoau7j6P3unOQQXgd/550DyIz1exVdxCyxOSsl1IjW+Tu5Ff
         CHOolceiW2OxVv2awlcN5V27XUNaIzdyvQ7p4LtkMAbRMRAm/vgc0etrEiaaiW6Chxh4
         yHfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuFl08B+EQO4E0dFLOXnZYQIeEGParnAxcY/MQw94+STSge+ro4Qlz4hSCtYF4RubOL3PUMaoqUgmRK7LeaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx15rvLcWSXW/oU9TTex1jOYQtfSH3uvCPkpe5j/IXlss4cJxHd
	83OpYNzggD3NnDgrsJiX4Cyn2/LWcbOIfF7WbxFLwdcQVjf9wMjeMSK2YFuYBeQku+hoDqoAfuH
	0nuoJ1PDS9yh4r0ljBQpEQ4nS6BUE1RPVsUaKuNdiyOTXA1af5Ml6Yzn51jjhsCwN1mPz9I6q2B
	50ZWYSnW8KmVlLXoth1UKuI/UhQ2FI4CP7/c5OdsSZxKk=
X-Gm-Gg: ASbGncvgugoahSA/b6OvW90WoIFllCo2mIryQr57lwrAEMxigVBn7z0NyfrJlQOi/Q5
	OKxxsFcJ6XYvizW7+eDJ+gzA7Avnpl7TGepCgdDah2wNex0ADtEMGrpHbW+m+jzyZh/SzW17mfv
	jiJr0JspN7sxzhhkQmMQ==
X-Received: by 2002:a17:90b:2787:b0:32d:90c7:c63b with SMTP id 98e67ed59e1d1-33098372be8mr1834591a91.30.1758247927367;
        Thu, 18 Sep 2025 19:12:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0dA6uOL8zBSD4ifIfanjSRCgJfG2G7xQhezPfql9HN4fAQL3hx5mizJh0fKSXGQHgP4VGfWBEjqgiGhANTmc=
X-Received: by 2002:a17:90b:2787:b0:32d:90c7:c63b with SMTP id
 98e67ed59e1d1-33098372be8mr1834571a91.30.1758247926875; Thu, 18 Sep 2025
 19:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Sep 2025 10:11:55 +0800
X-Gm-Features: AS18NWB0qAf9gkfL6TujRcG_tVjSEKwQSfq6IiG9N7XzHSpu5Nco7jPOo01Et1U
Message-ID: <CACGkMEscCsCf8RC-xQzfTNMp94Ty4wTrBgLkF50OAQ+yF8xD-A@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix incorrect flags recording in big mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Goo7Y8XcY6ljR0yzr7HISC8xZ7FDrZyxSqzeyvqZo_o_1758247927
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 9:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> checksummed packets handling") is to record the flags in advance, as
> their value may be overwritten in the XDP case. However, the flags
> recorded under big mode are incorrect, because in big mode, the passed
> buf does not point to the rx buffer, but rather to the page of the
> submitted buffer. This commit fixes this issue.
>
> For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
> buf address when unmapping for small packets") fixed it.
>
> Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packet=
s handling")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 975bdc5dab84..6e6e74390955 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2630,13 +2630,19 @@ static void receive_buf(struct virtnet_info *vi, =
struct receive_queue *rq,
>          */
>         flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>
> -       if (vi->mergeable_rx_bufs)
> +       if (vi->mergeable_rx_bufs) {
>                 skb =3D receive_mergeable(dev, vi, rq, buf, ctx, len, xdp=
_xmit,
>                                         stats);
> -       else if (vi->big_packets)
> +       } else if (vi->big_packets) {
> +               void *p;
> +
> +               p =3D page_address((struct page *)buf);
> +               flags =3D ((struct virtio_net_common_hdr *)p)->hdr.flags;
> +

Patch looks good but a I have a nit:

It looks better to move this above?

if (vi->big_packets) {
               void *p =3D page_address((struct page *)buf);
               flags =3D ((struct virtio_net_common_hdr *)p)->hdr.flags;
} else
               flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;

To avoid twice the calculations and reuse the comment.

>                 skb =3D receive_big(dev, vi, rq, buf, len, stats);
> -       else
> +       } else {
>                 skb =3D receive_small(dev, vi, rq, buf, ctx, len, xdp_xmi=
t, stats);
> +       }
>
>         if (unlikely(!skb))
>                 return;
> --
> 2.32.0.3.g01195cf9f
>

Thanks

