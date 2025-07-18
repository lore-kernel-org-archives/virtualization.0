Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CFB35959
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804361; cv=none; b=br5IzRzVKIxm+JTv7nFCtTPjvOHypKKmvp7ayAQlaudU4VX/XX7GjGLuoGFNb6jiBcoAo1LmIH4wRs3+0gQO8gXuuU5rkTMQEr9hHb9ravO0aDUZMiMNNBJKcqkG2kPTpwxpe/FuNMR3dI1mUQqwfA3bsNxtBFPmbVWWDkeEPpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804361; c=relaxed/simple;
	bh=fAHgyOQPANZzLQwWznTfMsSn2S1XzZldRf2QHTb6MeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMCg4FD2bWaK6RPT0zMu5kQbjJY9LMUHGuRv4rtDMsKGP7/gCNr05/RLcLy+lyG7UKdA9FVk3irl0yuZqEzRfV1zdcS4WH6D2kU8cCYKL/rLFjUbvRuh1o4cXlih2kwGAo6QdYEKV7sAaqZ8LEIP4BWSaNcxUJ0yQeAlR5Ee8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ec+OVhO4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ec+OVhO4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752804358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fAHgyOQPANZzLQwWznTfMsSn2S1XzZldRf2QHTb6MeU=;
	b=Ec+OVhO4sltgnFFWKvzT5WoxRypGkWHkvKJnrJtaynZqvZ61dQf5ExEbgLd6dFx0SGAnFU
	JxxackuclU5XirIWPNUXpE997Y44sGRxYNdQv1yGgi/rbCaYlPgvVXuDnrDLDY5ze4gix2
	MBJ4/3ngGYgCrN/VcGHrlORS3eEdvVQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-sBXVaBwANV2-YDKPSsuwZg-1; Thu, 17 Jul 2025 22:05:56 -0400
X-MC-Unique: sBXVaBwANV2-YDKPSsuwZg-1
X-Mimecast-MFC-AGG-ID: sBXVaBwANV2-YDKPSsuwZg_1752804355
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso2716945a91.1
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 19:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752804355; x=1753409155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAHgyOQPANZzLQwWznTfMsSn2S1XzZldRf2QHTb6MeU=;
        b=sNmVrojdKSVlMFG4H5TUYGa1fO9oUfZHW9EPBus+SI0+ba1TwRiA9XneToaTD0pR6c
         bKhMMG211AKSikIXh8jFVoopOGPlPSSDqz8zNuwP7/I7i2POSdEJFUuvDGU/JvkX/sas
         2kKP8AIIGTxmta9O991/t6ogigRO9TwNmDgquPVsCw6RJ4r7Tb59EL+c1wzzrr+vpku+
         xDkT0nRV/2VL1zKrajJU5iPFfm1qhVmIWpSBrnPHBfOSeVEFDvQC5fGC3XbEsZzCIEAa
         fzv+pY9NNobIFJMOwz8L9g1lYCqRig354EkMenTMDFzJfbJCn4z5Lei5mPk0qGGtk3mD
         pl1w==
X-Forwarded-Encrypted: i=1; AJvYcCUbqBP9AltaOd+Zbs/9KlIPzAPSr7uoWtwiNky6nm+z9fn8Oox+a6AU9Z2iosSEUVkG6r6wpw72rgd+qLOw2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDYBh/G029/VWS8E2kxdC3ou6nyA94THcw7JfebFRORr+jAMK/
	l42jjx06h1WPW9n3aMH7MuKFZs881bQ4VroZkMalgwKnFkRFklXsBI8ESmjxdVjHGkA2LVZK1ov
	ZaNFN9mFH9nTbkfoI8X2JDI4Tw2of+MtJsigQcWpAZzY6Xe0f+pmDZalw73fzKsESAYP5xrC3KW
	E40vjcPElP5GwP7MSSgE6A0Skca/PmFu2WPWXDjpBHdXI=
X-Gm-Gg: ASbGncujc45ruxALRiqVSQ7dZstDcSVCulwrY1SdbZzPdXpKIn9KyL1xdqdqXyrWwFS
	gLo5in+frM3abYZYIMD3lAzamMMH+5ViYrxWnXzxcLO0PN7+QPhlFHh1m7gSjFUajIEB/riNcMP
	yLdHTvSu7d11xu07ZBALKe
X-Received: by 2002:a17:90b:1fc3:b0:311:e5b2:356b with SMTP id 98e67ed59e1d1-31c9f3fbc0emr13408236a91.11.1752804355411;
        Thu, 17 Jul 2025 19:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL1TUfRxt/IdYG3l63LrSrJkEjx9DHa/qYJZ06nlfGDaC+oJHOHHJe7dzrEYqyMA7a9frBCJpme911jDN0xC4=
X-Received: by 2002:a17:90b:1fc3:b0:311:e5b2:356b with SMTP id
 98e67ed59e1d1-31c9f3fbc0emr13408204a91.11.1752804354976; Thu, 17 Jul 2025
 19:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250717080237.6518-1-jasowang@redhat.com> <20250717080237.6518-10-jasowang@redhat.com>
 <aHj5wwaQHyRAcrcN@infradead.org>
In-Reply-To: <aHj5wwaQHyRAcrcN@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Jul 2025 10:05:43 +0800
X-Gm-Features: Ac12FXyjxASuha2XWxzxMZZCD6gqRjj7A3yFVHW0dnW-_bFAgvrLcIWM1Twh4N0
Message-ID: <CACGkMEvaHDLH=C2Z1mrUgZjBRiWUtE57A_kcSJDjhmC2v6Dy3g@mail.gmail.com>
Subject: Re: [PATCH V2 9/9] vduse: switch to use virtio map API instead of DMA API
To: Christoph Hellwig <hch@infradead.org>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QpumezgkN6JKNYGThJ8Oo5RhOngOZ8iulr6pPb1jT4M_1752804355
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 9:34=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Jul 17, 2025 at 04:02:37PM +0800, Jason Wang wrote:
> > Lacking the support of device specific mapping supported in virtio,
> > VDUSE must trick the DMA API in order to make virtio-vdpa transport
> > work. This is done by advertising vDPA device as dma device with a
> > VDUSE specific dma_ops even if it doesn't do DMA at all.
> >
> > This will be fixed by this patch. Thanks to the new mapping operations
> > support by virtio and vDPA. VDUSE can simply switch to advertise its
> > specific mappings operations to virtio via virtio-vdpa then DMA API is
> > not needed for VDUSE any more.
>
> This can now drop the depends on HAS_DMA and ARCH_HAS_DMA_OPS for
> VDPA_USER.
>
>

Right. Let me drop them in V3.

Thanks

