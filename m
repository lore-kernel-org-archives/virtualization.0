Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB82F872
	for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766777835; cv=none; b=q28lgk7KmGSvGuWohtfze40pvOrceVESMLySi2LaZ3QFo8rEfD7uQ7dFcihqY0rpZ6m4C3K7rei1niqBkUQMWv4d8cAPN90D13gjh+diFhQZi4QNiwTxN5Cz0VLGGxVLx86ZiJrk4iXSn14G1V32ikbVUltl2ddYy68DuI/n4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766777835; c=relaxed/simple;
	bh=MeLaV2gyn86MjigyVctCvpIsqyzRgBEDkK5Jno+cQDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lVcZwmMUDUDeaF2LnYfXGAHhS0ComyMJnOVLnHUUSFOLMpeeBRXGouJDATUCZw3RPN4Ebf9DIVk41yc14RvB3YZUf8ZlVvrRt4YYDTySiqmKB5H9J/QP+6NWvUBUh3SaijxWKeb5KYthDOjRt+KfX6HQtU2I0mluwi5+ZuTVAHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDI1cLKI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDI1cLKI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766777833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTuOJL+ghHD2rYugXkxXl1KmC02YdKASRSqPOvxtC4c=;
	b=gDI1cLKIM6SsZNOlDZ5sKH9pd8Ahe34qgxb9BMz/NPkzOtV7lBMpj2nNl7/E3L0WY5sU3Z
	CrrG1wy3zS9SBoWMMzyFU4K5N3NnQpKSA6sWrl19Kwk+HDMh54bG9cu30tVknHokZXA+db
	oLhCnGxRWtbDvtpiee0qjNCQ3dSpT+U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-fOv5tSiANNSCXkSTlrJYtg-1; Fri, 26 Dec 2025 14:37:11 -0500
X-MC-Unique: fOv5tSiANNSCXkSTlrJYtg-1
X-Mimecast-MFC-AGG-ID: fOv5tSiANNSCXkSTlrJYtg_1766777830
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-432586f2c82so3324598f8f.0
        for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 11:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766777830; x=1767382630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTuOJL+ghHD2rYugXkxXl1KmC02YdKASRSqPOvxtC4c=;
        b=gT2YKUhIEmEu0ndbJBVzQyqco6LE7UcU35WnuT/s0VsD+KetryODhvnMEy6gobKCa7
         gCd/dqKtkBaab38UcJz+0EfjAak6A+hLhQ8mzmANHPn/2HyIv+ZiOFBQECFP+WOdg6mf
         YVqWF7Vqn7iOV1FOR7ytj+cuV3VSbCsPIqSR0C8DN4199L68Zre2OACxxYF76afhCusk
         6b5ZTfc+sslK0X+mlNLrY59zgRfgn49X8hQvpKgjeG2Ik+1NFbUKj27kxy85mtv9J1Fe
         p1oG5m6Qy6zxP8LzxTk2TFvAr2I+8pbS7YGplQaFvqB5qBNRDtd+njzJ/92yeuTNxJok
         7i+A==
X-Forwarded-Encrypted: i=1; AJvYcCXptWMgn8z6TSjnxLUHyVPSF3ZIAMFlOhKsg2BwxtphyUB08FRmSpQnfUAN7wPt84Ie53TtqyfZiAZw0x8n3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDRWWdoHpxK6v7hLsFKnBd2aFnkBOTfVtexhHolTBweWluUoXw
	JkogJSRCtLoIEMfgQckmcpz8C5IVOszTsoFJNkCy3UqznJtAmnIvJu7YASEoOE19hDnjnI0QimC
	IIsrO+g/aZ3+s6GBX6a+1FYyZCO1JUY+BczQBDMxJzYY5KCuIN/xyrLV+c9Fa26ktjyEk
X-Gm-Gg: AY/fxX6FAn0Xy9C+8CyKtfMjg8fB9JlVyMeRtSZfYh1OjF/RfkUTyVncnZi1RAxB0l1
	+HLxAaAwBvhTNCoJWFAiYdZmsTumOhgRzTvu22Y1+zkv382Cp3SKiNPnblg8rXAZ6vk0nvA5Amw
	QyjBotuF52snhan2PN5boGGtOtzftms2lHLp8WVRUUcOY8F/2dOcP/Zv/aBHlSDt98IomMGYRJI
	+anlDSqAbaqU8QYJ7Hz7O28liWnmZiLxczGcJSkDbMfQOYz5lmGf5oyI82ursuIgbCiiXIeDWn5
	BrREL5WZjBc64cEicjmUotRgrq6mWSIC76l+SN4XYBA3n5jRRJIgWRaYS5BFTuzLjIzIS4aaPvr
	t3aEX1BnsxYmjgsddnqv3+aSjghDsncJ8tQ==
X-Received: by 2002:a05:6000:601:b0:430:fd0e:a502 with SMTP id ffacd0b85a97d-432448bf4f7mr32063397f8f.22.1766777830309;
        Fri, 26 Dec 2025 11:37:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQtXs2F76mu663pulYfE+dS9Faun4N/RAzLGBitQaOvqpvM1GC+nkac1oVWijG7Puy4F7chw==
X-Received: by 2002:a05:6000:601:b0:430:fd0e:a502 with SMTP id ffacd0b85a97d-432448bf4f7mr32063376f8f.22.1766777829910;
        Fri, 26 Dec 2025 11:37:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2278dsm47499940f8f.18.2025.12.26.11.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 11:37:09 -0800 (PST)
Date: Fri, 26 Dec 2025 14:37:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11 13/19] virtio_ring: introduce virtqueue ops
Message-ID: <20251226143433-mutt-send-email-mst@kernel.org>
References: <20251225042608.32350-1-jasowang@redhat.com>
 <20251225042608.32350-14-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251225042608.32350-14-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qx1qkpJMeJgd7nHf3vX8Na20W9vTnnbddB1LtKNeFS4_1766777830
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 25, 2025 at 12:26:02PM +0800, Jason Wang wrote:
> This patch introduces virtqueue ops which is a set of callbacks
> that will be called for different queue layout or features. This would
> help to avoid branches for split/packed and will ease the future
> implementation like in order.
> 
> Note that in order to eliminate the indirect calls this patch uses
> global array of const ops to allow compiler to avoid indirect
> branches.
> 
> Tested with CONFIG_MITIGATION_RETPOLINE, no performance differences
> were noticed.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 173 ++++++++++++++++++++++++++---------
>  1 file changed, 130 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f804c5c6975a..4e905dc7b6cb 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -67,6 +67,12 @@
>  #define LAST_ADD_TIME_INVALID(vq)
>  #endif
>  
> +enum vq_layout {
> +	SPLIT = 0,
> +	PACKED,
> +	VQ_TYPE_MAX,
> +};
> +

VQ_LAYOUT_SPLIT and VQ_LAYOUT_PACKED would be better.

and VQ_LAYOUT_MAX for consistency.



>  struct vring_desc_state_split {
>  	void *data;			/* Data for callback. */
>  
> @@ -159,12 +165,29 @@ struct vring_virtqueue_packed {

