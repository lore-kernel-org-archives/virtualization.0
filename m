Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC11F0985
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353143; cv=none; b=K9Q5kERHRBqofx54+upuA7/Rlyn1oQv3iHaelZbMMjAJorclZP7TKnEs8IWWZQuiHOkx+LbdNveUJSsRBHAPVcmlpEJ12uAiFP2kdCFXgZlifFeT3vrwunvD3qvnM5uPRBuKpt+aeakbUNjGVxxtleX6pTdciP0Tmn0yF6TPnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353143; c=relaxed/simple;
	bh=8IWAZwihcyMgNOqUo1jIrL+a9PnnaXKKk8vOvAd6M58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iyl5Mrzsb9hG9fz7jKSKU6884I4zQoWEyEqv4nFt6RHYuuhdVMuURNP426IOAh5GYUJZy/ndtUtQjKUsLrW6iCRbw0ivxDQlpHPZ2wNzU64MGYgLOL61Fp8XFqwV457bgXmd/DQcgUwkZAw7i6ptmRGa/pff5HIMot6bZyCxvFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrzH5gmu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrzH5gmu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751353136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/xX6Vj1UFoxmOqMARiAbHnNR0YGwcx4fQwDyXkDkaY=;
	b=JrzH5gmu/czwUJTimFwwHJArm1YIXNX2egKEwlmvqN0+ecI8YgWM5RI75FC333LRwnUAcf
	M3ePS9m/20ueNCEtd9mu1QK6i1DcugvD2lXR01BXo+DbwdtS2vMjVQjNUnxdNa2lKLb/W+
	avcpqd2h2/Bkz5H/Sgqq6iAOCIpQIA0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-pkbfb2JGNkePrBZWr-ScmQ-1; Tue, 01 Jul 2025 02:58:56 -0400
X-MC-Unique: pkbfb2JGNkePrBZWr-ScmQ-1
X-Mimecast-MFC-AGG-ID: pkbfb2JGNkePrBZWr-ScmQ_1751353130
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a58939191eso986966f8f.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 23:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751353129; x=1751957929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/xX6Vj1UFoxmOqMARiAbHnNR0YGwcx4fQwDyXkDkaY=;
        b=p6w3rqcV3sL2s/C6URHcN+eOMagcXLs/trDwHZ+gqfsFxlC4Qm4MA7mMJcT49Tb3eE
         UypdPgW7+RVUV6c9QVZl9/1H9cGZHpU+2xAU5gcvqKHQN8zsw7GYqe8iVnidMhpikV2Q
         KlA55qTv3Qc+iEFvFy75Vs6vdcHp1nykm0ZVWtIizUAmgxUS1JR8lSuyBU3uZzb4Klsb
         DL85QQH4SphsyG0QNovOO9WxeLn77KAnXyIF6skIRitdhFWDHIC+cNTy2ldjpxMkgkNd
         N15EMyQfz02mxUPe+poT0NSFx2ju2dlVQ+besZT5UEOGjSXBRShKqbF5s37a+vnO9XCt
         xTGw==
X-Forwarded-Encrypted: i=1; AJvYcCU0iw9p0d2KRkGfaOofeqDBX1QQRq7l02ROGUw+IRjPk5T4NdSQWjO+Vn8XWFxQ7uKgjZ8P/XzaS30T+2+8ag==@lists.linux.dev
X-Gm-Message-State: AOJu0YygNZ7OEOFX90VngO5dVMnkmu62BaNFswBtcLw9edtYMunGKO/Z
	TdsUajdw6E/zjwtHgqW0itB260B8LDX7+XCHGA/NMb6795PAhyZgB52rQeKlLFJsLxKA2onKw5A
	4KIBNMbd49C+B/0A3xsi+SmNuwHxQ2yZ23bsn57NFkPAGV2dnfCDjKs8RZ/ptvbVww2OK
X-Gm-Gg: ASbGncusXphFSDy+JUfnXSQEJ8QXFXl6Tc74mwnU2EkWVDic5udIcX/9pOsLIYF6er1
	GBYaVY8WUrd90pUU0kP9hCj0iaJ8Jv2dwsshtK75dw8/sI5t7ufKTy4PufPoD1dm6B7Ov/epcKy
	zCsxdrNhz1S4aOKd1jJ5WYEboutHP8ifSwVPX23jNAvqx3Rf24/6e0VbRhOdG7ccPNvmH1GTSlE
	+xHHLCZD+0lZ3AjPJtiTpB6Frbt/hBcj+DoFlZOsOVaAQy4j33sQmV5Df0La0iiT/DmjatADm3L
	D55kg8QyUszG2lId
X-Received: by 2002:adf:f44c:0:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3a9000a8138mr12229229f8f.59.1751353129529;
        Mon, 30 Jun 2025 23:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs9r/PJXYoXVnQuInmZ2C5taF6dc/FQeBFJwuoW0qiinCPLiV68OdDQjGkGS53kRHnNC0Pxw==
X-Received: by 2002:adf:f44c:0:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3a9000a8138mr12229211f8f.59.1751353129112;
        Mon, 30 Jun 2025 23:58:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e59720sm12293700f8f.73.2025.06.30.23.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 23:58:48 -0700 (PDT)
Date: Tue, 1 Jul 2025 02:58:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 00/19] virtio_ring in order support
Message-ID: <20250701025759-mutt-send-email-mst@kernel.org>
References: <20250616082518.10411-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250616082518.10411-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TWGXQAEDuDT8Z8-7Qy-wLbHYydbrSzzDwQNgMONxIzY_1751353130
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2025 at 04:24:58PM +0800, Jason Wang wrote:
> Hello all:
> 
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implemented on top.
> 
> Tests shows 3%-5% imporvment with packed virtqueue PPS with KVM guest
> testpmd on the host.

Thanks very much. I think this is going in the right direction,
though some things to improve remain.
Sent comments, thanks!


> Changes since V2:
> 
> - Fix build warning when DEBUG is enabled
> 
> Changes since V1:
> 
> - use const global array of function pointers to avoid indirect
>   branches to eliminate retpoline when mitigation is enabled
> - fix used length calculation when processing used ids in a batch
> - fix sparse warnings
> 
> Please review.
> 
> Thanks
> 
> Jason Wang (19):
>   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
>   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
>   virtio_ring: unify logic of virtqueue_poll() and more_used()
>   virtio_ring: switch to use vring_virtqueue for virtqueue resize
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
>   virtio: switch to use vring_virtqueue for virtqueue_add variants
>   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
>     variants
>   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
>   virtio_ring: switch to use vring_virtqueue for disable_cb variants
>   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
>     variants
>   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
>   virtio_ring: introduce virtqueue ops
>   virtio_ring: determine descriptor flags at one time
>   virtio_ring: factor out core logic of buffer detaching
>   virtio_ring: factor out core logic for updating last_used_idx
>   virtio_ring: factor out split indirect detaching logic
>   virtio_ring: factor out split detaching logic
>   virtio_ring: add in order support
> 
>  drivers/virtio/virtio_ring.c | 896 ++++++++++++++++++++++++++---------
>  1 file changed, 684 insertions(+), 212 deletions(-)
> 
> -- 
> 2.34.1

