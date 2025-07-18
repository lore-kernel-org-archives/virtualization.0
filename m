Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695E1E98E3
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831579; cv=none; b=VIbYIqdKm9mYS46tT9JiABTeP9elUtekaEwBm/AklceQB2rE/sz0K3uNwum5sgBrgrXlUtPa4fsCufiP0mAipjUxS6ZFsJULS9Q+hAhagje3vMsUHcYto473oy9BYwPhvPaw/vXzHHdf5w/TqyTbrgZhfAWXkGIGXOZumRmOfEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831579; c=relaxed/simple;
	bh=mf0yCfPKkRGOVplHS0SQoIIUU/0iFTb5cFc7pArcyu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=P9yVHB5FUAaG9JECpi3MayiEaCtXhR20JiCk22F/tW8kOFb10lvHYxkrYm0u0LIZs6os3XYTTdXMdZMGKgGkklOwjw69oXd5DrTQ102fIBVz88pAgj2Fes2JVkmjZHekuC0xR9Wsnupx9IIdssocu3QSEt/QPJd8jelLHg0QrFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbIYvd2G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbIYvd2G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752831576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygJds1MRVsIzZ948/gYpR1h8Zu+noO3s0UE9s/y9QLU=;
	b=AbIYvd2GVVMPPeOQ9tBwvegC4HS+09BRKR2f2WP9j5F4hZOkDsodgPZWO96iS2HqWQAhLr
	EXP8IgRmEiKDSAYoSzGEZGSX58i9Ttm9J64mPzu7LOZ5P37pMukgRo3giyzPdKRZ52ta9R
	5jRdKIIShsiHnhwSwJQD1nlEYzLBPC4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-aO558z_jPwShhQjb-_l2mw-1; Fri, 18 Jul 2025 05:39:35 -0400
X-MC-Unique: aO558z_jPwShhQjb-_l2mw-1
X-Mimecast-MFC-AGG-ID: aO558z_jPwShhQjb-_l2mw_1752831574
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45639e6a320so6452335e9.3
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 02:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752831574; x=1753436374;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygJds1MRVsIzZ948/gYpR1h8Zu+noO3s0UE9s/y9QLU=;
        b=C6l9HceX3bGawIvplZpbm/Qf6fjDLDEqZT3WweAugWNIjhG9/hlVCYyJ22gAKqBwKo
         qcMQY7n8Nyou4SoHB0PkkitcOh49+gI0ZEOZRwh42dHCzbAxHUjTdemHei8dhheY/T5d
         Sd4V0m2otEzSAXLfSYF+DrmvINsKSNPcA4RLFBohWeWb0Csf7x0zMUK1eyf4Ft4sh053
         yZKxc4MBJgF/Z9SjZsPdIR0L2t8SQhybU13hOeFU7uDLtovt6ukhFCOECaJGhh7dGZ2d
         vocN/CPxZz/0sqsIHDlobEuaa3OU1r9WMXRGd7A71xIw6iNR0CQSA3SreCcFcVJhtrBc
         0e+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjkF6kvykFzklJkgJy6DQujJ0qlaW4vYSVHVouVa1aj4Ib+CAMe1K10mex+L/+1VjCapKaajNFkhH7CX1oYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyI4m/5pdEd4j4hzPRquDg5JIoYCKq8fFBm6oIcGRiPiF6IoglE
	Vws9nbnfv6dkZ9aqEN7P9zuSF3FK73fyKdhCa/EmOt6hMyHJrcoMEu9lRn3S2Kdl9Hx5VcfHYNL
	YgiB5ahFDxTLQQrPcC5EKaDqMzzdJonLgJBopMwiRA4/KNaQfgiMYeMYPPf9xCWseAaV6
X-Gm-Gg: ASbGncsjzSTJwE5YE8aL/lXf3fvU/A3BL114uMj/TcPDOv7W4gjqq/Y8z5yCJA1Rrsx
	ZJfwvFNYkWfI/7m/mWoyxIStyD/27N4Z15OqOF1uwQjaSx3CCuicamIGg19bDjNvTZdL672taB0
	5CIjE/ElyA3REgUPIQ87kYPbJGO9rwiGmtRzKAR4NEjWeHvZOv97X6P+DZPUFA+NsT2pgYkAOMA
	btBGnKD6tkSTCXRgndNV2SEZUmgexiqjBIGarWMSVX1+8SrrTv3BFj6V0nbnW34dEpSruDiasTs
	8za25AefE5T+fRg/4fAkvxAuzXLR9Pwx
X-Received: by 2002:a05:600c:4f08:b0:450:ceb2:67dd with SMTP id 5b1f17b1804b1-4562e38afc4mr86287135e9.33.1752831574232;
        Fri, 18 Jul 2025 02:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLF2VldwQM20+jr5Cr6x9jQnUuydBgX/ut1owM2hOw6VtVri0BsTstH/cebrIeedCfsqCBnQ==
X-Received: by 2002:a05:600c:4f08:b0:450:ceb2:67dd with SMTP id 5b1f17b1804b1-4562e38afc4mr86286935e9.33.1752831573846;
        Fri, 18 Jul 2025 02:39:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bf4bsm1326001f8f.31.2025.07.18.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 02:39:33 -0700 (PDT)
Date: Fri, 18 Jul 2025 05:39:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 1/9] virtio_ring: constify virtqueue pointer for DMA
 helpers
Message-ID: <20250718053749-mutt-send-email-mst@kernel.org>
References: <20250718091616.6140-1-jasowang@redhat.com>
 <20250718091616.6140-2-jasowang@redhat.com>
 <20250718052707-mutt-send-email-mst@kernel.org>
 <CACGkMEtbWu2VEQ5FXJ54TvbND4e-dgwn067NrYyoUODOGX=jUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtbWu2VEQ5FXJ54TvbND4e-dgwn067NrYyoUODOGX=jUw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DRQOWU-LeUuaf1j13lYF0FJmJljy_QACIIA2mfnlbdA_1752831574
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 18, 2025 at 05:28:53PM +0800, Jason Wang wrote:
> On Fri, Jul 18, 2025 at 5:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jul 18, 2025 at 05:16:08PM +0800, Jason Wang wrote:
> > > This patch consities virtqueue point for DMA helpers.
> >
> > point -> pointer
> 
> I'm sorry I miss this.
> 
> Did I need to repost?
> 
> Thanks

The issues made me review it again and I am having second thoughts about
map_token. I think this needs a bit more work, let's give people
time to review.

This is just a cleanup with no new functionality so I think there's no
rush to defer this to next merge window. Best focus on getting new
functionality right in this one.

-- 
MST

