Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2B2FCC1F
	for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252269; cv=none; b=qy9B2s/WQ84r5JTFx2CPRqSEyK/yhZpkVoPLXJh2KwLTz4HFRajMWfkhWxTu6wBrIcTYPOJKNvI9sZjeughSFN6DTvXQv8Cuy7+GH5uPYshiVNUgw/dMdUJ2xSlwGDwhzSpAtwqIaBOPTGNUx45LBtc+Wy+qsW9Jb8vEu6/XCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252269; c=relaxed/simple;
	bh=I4oegnkbfcpHs/H9z0IPVadbUDUImw9xYjA1JUJPD64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dT+3+LNBAcwk5UveIfmE9pyqvJVy+kSxRopEZukxHx74NymjS/blBYn5WqnFc+WsaildeEFJSFNvgzzXKnbE2Luh+dU6R//z8QRLQr42WF8Mhd6pc+QLNpXSpdcoH5NzH18BmGLHfmZjobh8A3TamWPGnAmP99faK+2J16GKW70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6nStwk3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6nStwk3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755252266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiZGjpRLBMxUiCkW55ef9RLnzwIzt+xk1Pnx/5kDTNI=;
	b=T6nStwk3vUFmO8u/lU1WbQutcoke4j8eGuMAaZpW9FzlE5FugCH4DOQh+U+Dy1i3T8IQIc
	b3cCELS3CHQyY3bLN74XjJrg1mST3y0hfODWeFONrrwQmXCCS4lvdvvSNCtXpSzdd8tY1v
	2NLT5zfA4jvdyzF2crDRP8dJ3muabnQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-eYaN93-8MxSzaFlEZ2URsQ-1; Fri, 15 Aug 2025 06:04:25 -0400
X-MC-Unique: eYaN93-8MxSzaFlEZ2URsQ-1
X-Mimecast-MFC-AGG-ID: eYaN93-8MxSzaFlEZ2URsQ_1755252264
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b1015f8so8265025e9.3
        for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 03:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755252264; x=1755857064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiZGjpRLBMxUiCkW55ef9RLnzwIzt+xk1Pnx/5kDTNI=;
        b=COYvVxsUG3TXYuVfX4VyQMtlw2ww1tD4fi1dLfu1tgAa3fPCn9fvmXk2AIo+1h3t3R
         NY2nEHb0v0AG+A2lAfg1B8VaQBxwvFaXLO+bYzlPXAuAkV6HOoIxwj0JZrcCevtO7H6t
         rtqPN8HID+9FWpbZuef/IfqFgaTynUSn7qrH6MXv0cetAjdNWdhxv30zV9k6G+hPC0q4
         83pujQK00b5LYHo/qDAvM4FCMG+9/HaD8QT/1a3Nj/IkvNxna0VR6HZ8wvMuiO+sdA4z
         aZDb5Ku5PGeLfc1Qp+Njt5zl14SNQgmY3Imy7GR3HksB0nqpbibah6Mp35sTc4fRvDqV
         FNxw==
X-Forwarded-Encrypted: i=1; AJvYcCXFjzxzFjqBC/6TxrNfL8aVOJkc1OSk1KrIpiPx7FXo3GkS6BBabJGcD9hAGKUUTob0ahJ/0ziOYpqekbC5Vw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6q+sU6/MrkEK2wZOV70a4hgz5FHpDp9T8omKDDUgqH2c5LBEU
	jEHvQsMCO7YA28/iiaG5Tc/zBS7SC2a7qli8UXbylvptl5LVohT0SUGD8qKTO1mYd46Ep7HZg0u
	gZGXmT2Js8KcgSgpzIoZJk8K3yV00irLgDl0oJZkCgmZ7vHIAr5c/gO+RJYQF1CnMq7SXlfzHzd
	9i
X-Gm-Gg: ASbGncuQIrhXpun18pzQp65STzbNwDaXlngHm54eBezBxZx29GAYy/bLXr+/0Cz4Ch2
	CZRYfrCXO8UHg5IwWc7jTaY7ZBS3wEM5iuheHVQwWiweMM0ApDIEfsGB2/H2UqagFOIFjbnHSCy
	x5ChMhOcXv5Ih98BMD6raKsaDvkpIGFXkxUVHw1lTRxWyIA0YP01SX/q6N+R+Mk+ZyRQwTbpyWf
	kHGvCBRPN3Ov+diEYDH3KskcED4S9pAKtod2Meu75nIT9EcCekgN2k/nu9aFtUXnwmGr1ylz9i6
	na/y22PlwJfNN9lNC2lfjmHatdvMuc24CSQ=
X-Received: by 2002:a05:600c:3b09:b0:459:d408:d890 with SMTP id 5b1f17b1804b1-45a218646damr10823535e9.33.1755252263917;
        Fri, 15 Aug 2025 03:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoYj18UC8X1yoShsQNdmiBKvxfPbz7hgJI6IRwBN4v3CHMkvtV96lAG5uOXuRIZ6XgJoKFgQ==
X-Received: by 2002:a05:600c:3b09:b0:459:d408:d890 with SMTP id 5b1f17b1804b1-45a218646damr10823355e9.33.1755252263447;
        Fri, 15 Aug 2025 03:04:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73cf:b700:6c5c:d9e7:553f:9f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22328b5fsm13094175e9.20.2025.08.15.03.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:04:22 -0700 (PDT)
Date: Fri, 15 Aug 2025 06:04:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
Message-ID: <20250815060320-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-5-jasowang@redhat.com>
 <20250813043151-mutt-send-email-mst@kernel.org>
 <CACGkMEuKmn4f9spFT1YxjVPxBFkdGVCTQEUpNG=xHd6hcL-a8w@mail.gmail.com>
 <20250814063927-mutt-send-email-mst@kernel.org>
 <CACGkMEuOnDavQNw2113TWY-cziSpHWxLnL1isNTf9HcW+kmFBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuOnDavQNw2113TWY-cziSpHWxLnL1isNTf9HcW+kmFBQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lrWhBuNfhg5fV752XwCF1dgj2OjohLbvHKeuS4Gqm7Y_1755252264
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Aug 15, 2025 at 09:02:09AM +0800, Jason Wang wrote:
> On Thu, Aug 14, 2025 at 6:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Aug 14, 2025 at 11:36:22AM +0800, Jason Wang wrote:
> > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > index addbc209275a..37029df94aaf 100644
> > > > > --- a/include/linux/virtio.h
> > > > > +++ b/include/linux/virtio.h
> > > > > @@ -40,6 +40,13 @@ struct virtqueue {
> > > > >       void *priv;
> > > > >  };
> > > > >
> > > > > +union vring_mapping_token {
> > > > > +     /* Device that performs DMA */
> > > > > +     struct device *dma_dev;
> > > > > +     /* Transport specific token used for doing map */
> > > > > +     void *opaque;
> > > >
> > > > Please just declare whatever structure you want it to be.
> > >
> > > It's an opaque one and so
> > >
> > > 1) the virtio core knows nothing about that because it could be
> > > transport or device specific
> > > 2) no assumption of the type and usage, it just receive it from the
> > > transport and pass it back when doing the mapping
> > >
> > > It should work like page->private etc.
> > >
> > > Does this make sense?
> > >
> > > Thanks
> >
> > I fully expect most devices simply to use DMA here and no weird
> > tricks. vduse is the weird one, but I don't see us making it
> > grow much beyond that.
> >
> > So I think for now we can just make it vduse_iova_domain *.
> 
> It requires exporting VDUSE's internal data structure to the virtio
> layer which is a kind of layer violation.

It's just a forward declaration. You do not need the structure.

> And the iova domain will be
> soon replaced by virtqueue group in Eungeio's series that support
> multiple address spaces
> 
> > If we see
> > it's getting out of hand with too many types, we can think of solutions.
> 
> Considering we've already at it, I think it's better to have a
> solution now if it's not complicated:
> 
> I can think of two kind of solutions:
> 
> 1) Stick to the current void * pointer which is simple and straightforward
> 2) Eugenio's suggestion of having a virtio_map_head and let the
> transport/device get the container struct which is the real token.
> 
> E.g
> 
> struct vduse_iova_domain {
>       struct virtio_map_head map;
>       ......
> };
> 
> If you don't like void *, can we go fo 2)?
> 
> Thanks
> 
> 
> >
> > --
> > MST
> >

