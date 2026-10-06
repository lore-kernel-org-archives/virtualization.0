Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2A3B27F0
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280200; cv=none; b=Zptk4ZtG0fCjLP2ofIYsuEIP9sqjmO8Bvuk4TRBnqV8n0VEiGLIUyOUU3WpLYvrpH1Yko7NFNUB+09pPdXfQbCwjfkpfopqijHjdkxiEapz9vpmqnYiEe+OnzoRKO5KutlP9mI0QZKNIcY0I4KshwkwNCvtvBgnP/NtzL6ioNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280200; c=relaxed/simple;
	bh=N3hn6QbtIdIIFPeRYp8HqA7gKHKr1qmaPyk2pNKf27c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ppr1m24sTN5pXw6Mp1Fb0TTZ6picaoIyg/rDZP8kOETjd2mNhljRsR6GmHv9fQ8xUoaNSJv7WUj5LZ10adJ8W8CE1W7MoQPSPwBMxxQGLcnZqKxEE8VmIapnQxDv/eCmgxpd+3Kj4hfHcAIMiVk6fmyM0aXCcvmjj4/7XGwNC5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gC7Ofk6K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gC7Ofk6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791280197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTOEhug/kDsTgsg0MW8NZpuSM30bTStxylqUNCEJaPk=;
	b=gC7Ofk6K7DkRVlowELmCqyKmpUpKGEZX4K+F7Fid66RMw8geZkeIWh4/4atQL2XklUvEO3
	grHtS0eGto3vkBPX4XDtjRelBd75nvSS6WYRGmX2sq7XrLXLyeFvjr8o+tfBxMFtse7KuC
	Oq/T5ar9SmrW7gO3mOAJHGdiFwnvVNs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-duMbBn3nOduLbWvRTi-3Ng-1; Tue, 06 Oct 2026 05:49:56 -0400
X-MC-Unique: duMbBn3nOduLbWvRTi-3Ng-1
X-Mimecast-MFC-AGG-ID: duMbBn3nOduLbWvRTi-3Ng_1791280195
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a16fefb7acso14473995e9.0
        for <virtualization@lists.linux.dev>; Tue, 06 Oct 2026 02:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791280195; x=1791884995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kTOEhug/kDsTgsg0MW8NZpuSM30bTStxylqUNCEJaPk=;
        b=KZAf5fv2itRaERMOGXrFPGaWUSvs3WuGo/QQ76+JpH5p2stocilGcYDLHI9xnl1sT5
         gp2lyX8R6i01uDYjcV+uv6PnIWsP3XWK2GdC8InnZJc/if4pg7AbUua1f9oMLJE9Lz3i
         htKvgeB7Ov6IUd0/BJp4J+/3TVoqPSlLd5MlYFdPBi1VycpBSgfSXp/2S1dR5ndsm4Ak
         eWp/+GSUY2jsrncUa/zPL0PMNGRxiVqk9dMA/AhMOp5lzz3Uk1abuBUzl1NomuXPJ0LK
         P1TUSKTExMgEevjkUWPchDl4QXKavJ/XOJiY2MfRnDPxxUx7PB202b4BqXEG/QpPIg3c
         UYeg==
X-Forwarded-Encrypted: i=1; AKwUvBwZ/wy9LX04+xyEY3+UCgnv0TlZ/kabLiUv5dRseq7ErG1buseduH95qU1bt72cmJyFMgXnWVeMWXppGnLVUg==@lists.linux.dev
X-Gm-Message-State: AFuF++nURhvKRaFZMHB+NkQnZFl+QtBtWYsGd69s14L1gbez7Nf67WjL
	/xV8ytRpov06urkk5xv4UXehqaMnrKvhO63/KnrpOq8IWrq2FmjkdTmNAYwz873f5eHxUndeqHe
	dtSdRi4Ncs7s/PG+S9c8Z+MYLtpnZ4o5/zGPqkg8YSai7EClMnWwKicp/91wUdpP92G1O
X-Gm-Gg: AYBFou3S/Zby1908UzAMILD++E7uZumG4zMDwetscMcmcZgm6gDicG1gZKsF2LoNb5I
	4H2toW+ovliN98IURvpxuCSyClqcvlr+QnAoAiQ0TmmaiUvhz4JlaEzYvczWhR/eSerpKUzyDUa
	uN15mIYlc7t+RI3iyNuyUC/g9kgmyL1p0tJytF+2AnYLiYYxmzNT4E1SF6+TijXIlM94pBTffgI
	UTB4PSOH2siOviaDgSD7l59pTENIvRUvwzHOym5drs/XrhSpD6fRCHTU3M2Rxbab5B5d1fCNgJx
	esqLjOwdt8jXPChFR829OG3VRWQtyHo2U5F97MCL7MyKf+CLeGYedkAWspV+LKrBKpaNLcA=
X-Received: by 2002:a05:600c:1914:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a17b52d449mr14318085e9.9.1791280195246;
        Tue, 06 Oct 2026 02:49:55 -0700 (PDT)
X-Received: by 2002:a05:600c:1914:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a17b52d449mr14317745e9.9.1791280194697;
        Tue, 06 Oct 2026 02:49:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17bfeb65bsm13352265e9.5.2026.10.06.02.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:49:54 -0700 (PDT)
Date: Tue, 6 Oct 2026 05:49:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?7ISx67OR7LCs?= <tjdqudcks0424@naver.com>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <mkp@kernel.org>,
	Jason Wang <jasowangio@gmail.com>, linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: Re: [BUG] scsi: short virtio-scsi VPD response exposes stale heap
 data
Message-ID: <20261006054845-mutt-send-email-mst@kernel.org>
References: <20261006091138.827988-1-tjdqudcks0424@naver.com>
 <20261006052300-mutt-send-email-mst@kernel.org>
 <96622e4086e5fb77b8148631fa6ca16e@cweb003.nm>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <96622e4086e5fb77b8148631fa6ca16e@cweb003.nm>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bS50sl-eNgFqVN9j3L6KnbEP8i9EhyUz5t2Ixc7X0tI_1791280195
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 06, 2026 at 06:40:54PM +0900, 성병찬 wrote:
> Yes, that is a fair summary.
> 
> More precisely, a short successful virtio-scsi response causes the
> guest kernel to cache bytes that were not supplied by the device and
> expose them through the world-readable VPD sysfs attribute.
> 
> The guest-kernel heap disclosure is reproducible. I agree that its
> security classification depends on whether the virtio-scsi
> device/backend is considered trusted in the relevant threat model.
> 
> Would validating and propagating the actual virtqueue used length be
> worthwhile as a robustness fix?
> 
> Regards,
> sungbyeongchan
> 

I think so but please copy all relevant maintainers.

 ./scripts/get_maintainer.pl -f drivers/scsi/virtio_scsi.c
"Michael S. Tsirkin" <mst@redhat.com> (maintainer:VIRTIO BLOCK AND SCSI DRIVERS)
Jason Wang <jasowangio@gmail.com> (maintainer:VIRTIO BLOCK AND SCSI DRIVERS)
Paolo Bonzini <pbonzini@redhat.com> (reviewer:VIRTIO BLOCK AND SCSI DRIVERS)
Stefan Hajnoczi <stefanha@redhat.com> (reviewer:VIRTIO BLOCK AND SCSI DRIVERS)
"Eugenio Pérez" <eperezma@redhat.com> (reviewer:VIRTIO BLOCK AND SCSI DRIVERS)
"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com> (maintainer:SCSI SUBSYSTEM)
"Martin K. Petersen" <mkp@kernel.org> (maintainer:SCSI SUBSYSTEM)
virtualization@lists.linux.dev (open list:VIRTIO BLOCK AND SCSI DRIVERS)
linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)


-- 
MST

