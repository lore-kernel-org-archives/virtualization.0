Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B2529C32C
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752833392; cv=none; b=MTw/E0KECGHFfPI2b7WUfy333VC6E/U8OhvbnzvAcyHM3q+AP59ic35BPJtXUmg11Da/sdZ/oDa3C1Su/LTsmZ2DNMlIB5zbA+LUlhlBk7gCDsU7qnY7LKIGoaFa9Rdi3kjCvRZXzNE8g+30friHMyn4l75pN/9ldYwFaFvH5Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752833392; c=relaxed/simple;
	bh=ctlCGKGs8G/73yMJcXOMmayiep3EzQ3+xghnEDl9aTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcPmvwfkcyi1y97F3DRwEeAa89DD5j4kYNbohnWp/zHrt3RNxmX5+aUcO0nBY8m8sVRog/0eKEv7GmR3kF2kXsXeQj3FdcBCXXC2F1Gvjh/Sxv5K8JB1FAYdsGJaBEcAiKSMuHf7QuXDVuLUHP2eQa50NJ2PRiXefR99sZIbRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIXuJEFF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIXuJEFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752833389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctlCGKGs8G/73yMJcXOMmayiep3EzQ3+xghnEDl9aTU=;
	b=jIXuJEFFuNd21uSmlXIJRLme8V660QD3BWZktRB1wSmLp4UedPO95vNstVREBfjXny1737
	oyRBAdR8a8lGl0we6JY0e3JWJL4vmy73ynJ5Uls9iMTPBH7cGM4w8TxIZ8/z043IZGMT1M
	7fZMaH14rTXYVyPXgL+z4IsQkK/sUM0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-UBo5AH4EOHqVPrQVFkTPSg-1; Fri, 18 Jul 2025 06:09:48 -0400
X-MC-Unique: UBo5AH4EOHqVPrQVFkTPSg-1
X-Mimecast-MFC-AGG-ID: UBo5AH4EOHqVPrQVFkTPSg_1752833387
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so2691513a91.2
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 03:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752833387; x=1753438187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctlCGKGs8G/73yMJcXOMmayiep3EzQ3+xghnEDl9aTU=;
        b=N7Qoo55/ujTkGEzJPZFkWs44VbX6DpYhGB7rKPEFmV256rHHEje93W/npH0/eYj4f2
         Pai7lo3FJESKIL8t9Pca1s6q6p8jAtHXxs0sm963xRUoYnQQpgixyXqSCfY8UrIMs8T8
         CHDdhCHL1ySkQOLRbS/dDYUz6anIRBCGniwRuzTSTTtPOrywThrDXeh7AKLIUIV7GpuK
         qSId05t2dnX9iTKcy/WmllA8Dv2seyyzfaR6C9kg5x6sqXpxwNLAeLzbu/Hx8kXp/LEw
         SP/f4SgbtX+CUSdR62vbSpAzMXN6UX0VStclO4OC03qtlKM/SwIxHFGYG2EqvMBxk1+/
         mTgw==
X-Forwarded-Encrypted: i=1; AJvYcCXmVOSC3+kVbhevaGr/2+WNbU/fdytj9tXObeHKmMT/AOaAXaIXeBaQ/uP13B3Ig58jntTqDNMaF0xLaR+gZw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyn333/e0QDdnCUSsSN0cOJ9WQXqsFzQ/vK8NbryrY5ZP0TUK6D
	rROgH86hiH9It+eIqHPbkmkT2TabsJsIERvAOxmj6bGwn+zihI12x3GasE/EgmZv11cqSMAxBJf
	jbpvQ26xYYbZ0uJXqWQly5Cwbw86KbDJLfTCd++0erkneWkXKff2dvr3yGqfQqvHhR9xZqXSrBj
	jIz87tCvqFUj5d9NqS3BqomfMoqElf13nTwpUhbqVE4u0=
X-Gm-Gg: ASbGnctFZI3GtcC/ldhwHUqbKdcB1kd0BCsWAZq06f+LHV7GQ7SMAl2mGhEgb8ZkhUO
	Q1nuK5pEnBmZ89MS9ZsP+qiNBXOY10shEXDCIQwPXC/x4Wm13mFAJUB3/XsE0/yrQm46e5Y5jrC
	F6tytcH6EVJKtm/erEpRY=
X-Received: by 2002:a17:90b:380f:b0:311:a314:c2ca with SMTP id 98e67ed59e1d1-31c9f398d36mr13984148a91.6.1752833387336;
        Fri, 18 Jul 2025 03:09:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5RYKqHnTauNryCtc3dIhE431HKTwwsn/bJJN2W1g/LNzYcywCp8S3qRz3FUJvplozLFoFyjeMytjWPwHyYRQ=
X-Received: by 2002:a17:90b:380f:b0:311:a314:c2ca with SMTP id
 98e67ed59e1d1-31c9f398d36mr13984115a91.6.1752833386946; Fri, 18 Jul 2025
 03:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718091616.6140-1-jasowang@redhat.com> <20250718091616.6140-8-jasowang@redhat.com>
 <20250718053156-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250718053156-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Jul 2025 18:09:35 +0800
X-Gm-Features: Ac12FXwHR1sN1y1DpfX9qqmgTEuRWZjK6eAXhjAxne1BebM98OF_goG595R79UY
Message-ID: <CACGkMEue4Wh3ocM2Pmn5E_nMzjHkJqd-MhYbPDY9pXdwMtqgXQ@mail.gmail.com>
Subject: Re: [PATCH V4 7/9] vdpa: rename dma_dev to map_token
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OraVS5HBejf8ELWR5K5HNvQpOZ_mN7R5IW61tr37ojk_1752833387
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 18, 2025 at 05:16:14PM +0800, Jason Wang wrote:
> > Virtio core switches from DMA device to mapping token, let's do that
> > as well for vDPA.
>
> Pls switch to imperative mood.
>
> And add explanation about what is going on and why please.

I think this has been explained in patch [PATCH V4 6/9] virtio:
introduce map ops in virtio core?

"""
For the device or transport that doesn't do DMA,
they can implement their own mapping logic without the need to trick
DMA core. In this case the map_token is opaque to the virtio core that
will be passed back to the transport or device specific map
operations. For other devices, DMA API will still be used, so map
token will still be the dma device to minimize the changeset and
performance impact.
"""

>
> At least, document what are the actual types stored here.

It is opaque to the virtio core and will be used as a token to be
passed back when the virtio core wants to map/unmap a buffer. So it
doesn't have a type.

> I checked and it looks like vduse actually returns struct device * here, =
too?

It's just a token, vduse can return anything that can be used to
identify an iova domain. For example, it can return a pointer to
iova_domain which will also work. If you prefer to use iova domain, I
can change to use that in the next version.

> So why do we need this, why lose all type safety?

If you worry about the case that assumes map_token as dma device in
virtio core. I can keep both map_token and dma_device and make the
mutually exclusive, then:

- when transport reports dma device, use DMA API
- when transport reports map token, use map ops

Does this work for you?

Thanks

