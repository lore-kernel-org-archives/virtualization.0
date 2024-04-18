Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B47282F4
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420543; cv=none; b=IJ1VmGFkM+pz01W5CpPgpVGdN5r77bOEY77oEHBNOMhtvDsvLvzaJjSchMSAL9NY/npvFvDRExD27kKvktdoYMJspUfmxV/cC3Bf+QaveBx4CsHKXGaj+PwnnioBUxhCzFTCAKwz0AGMeJTjHvI2uMOrjKTFJ4KlPovDyAI6Uec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420543; c=relaxed/simple;
	bh=SSUou10o2pDgMGqa3LTxveoMpsulBzmXgzKBkv/6KSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHYXNepWTPUdVKGDkQFD55lcYjem7G0mBwfpGJ2C1mVvb0V/9JH08YC1owdaTP8GHM5dzm5FDVuJ3bxXsTVi4OxJciNqtOL4Mox97Y7qpkI29F4RSomjWamhg5caJsepE+A4EKseYw1hb74gx6QRND/z4d1FgdJPv+hEjjZKtFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdwXqjYZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdwXqjYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713420541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5rAnqK45cddGOhhwEGJeeGo4xeCJaxK4G8w0kAzgPg=;
	b=EdwXqjYZL8WgWGue5z6sNxrG9Drx+4bkPhmtMCr1uhSyALjZsdFWi2xtzozztLcYcSRIa4
	ucyeKMEeAmtdWYu6kQwJpvU0DxsrDhfLDD8niw7rbiDGXgKbcefgqwDbavW/aBihEIsUkr
	WWcGOFR7WH20xChJcCf6QRw3v3i7v1k=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-qoO_4GdrPZuyI7Zmmmaqsg-1; Thu, 18 Apr 2024 02:08:59 -0400
X-MC-Unique: qoO_4GdrPZuyI7Zmmmaqsg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d8dbe37d56so563458a12.0
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 23:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713420538; x=1714025338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5rAnqK45cddGOhhwEGJeeGo4xeCJaxK4G8w0kAzgPg=;
        b=BqCcIGsOt/yy8F8dDrw0/KP5ACB7Y15lZf5dXzNP1BBTw43hfAZCIPiMrwWcGUJY5Y
         zrAigzTDOFxuA1BKxUiDZ0FcokJ7+Kuzy8UAZNfcKMAcUZc0hyrG95lKeGFHogTwWKh6
         SNGh7Teay6cr20k4QmUIOtuUfoWJzF+arR5xtOzUS4Fol1ufb/QioYCEQvmMe3GriBtJ
         MR6eriNUPPbq5v0/RLVaYbdIWkImiZp9Qw/I3QI8NAeXbD/dzenQB+NYLwgkO7svhxx1
         ZnbRi7sn9OAWkndbJGQ2lGIGKQTeIAKoZnjmxN9tAV1ZuF8m+tTsgtsKQkqBBBLm254l
         2piA==
X-Gm-Message-State: AOJu0YxhVMGrxxUdr/dlw5/9iBURvwydsZe1kLTO+wLEPyw41BPMPffp
	f0vCUa+33icHNJxiW0p49SOE14BqtQp3Huvup98JvsZ+IbCz6FDUFac5EqRLKSDGtbpT0Iu7kj0
	/Nn5BQzMMdgwzMXMN3S6Qaqal3t2782VXEKxBuZ3Z5lWcNZmJf1ZO937Mwxk7QHx6A7RzxfalGZ
	0a4ZSxobhRg28r+wWkIV5cr15TCfaG7U6UeJOYDk0=
X-Received: by 2002:a05:6a20:748a:b0:1a7:aecd:9785 with SMTP id p10-20020a056a20748a00b001a7aecd9785mr2293890pzd.25.1713420538545;
        Wed, 17 Apr 2024 23:08:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsJsT0x6OHZetDoaWQ1nKS4EkZBAC7JoKFrSyZxcWc2dmmPrIm5K1eaDg1B9l4iwS7BnuNpR7nozmkwwtVJZA=
X-Received: by 2002:a05:6a20:748a:b0:1a7:aecd:9785 with SMTP id
 p10-20020a056a20748a00b001a7aecd9785mr2293878pzd.25.1713420538263; Wed, 17
 Apr 2024 23:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 14:08:46 +0800
Message-ID: <CACGkMEvSTPnYGXmnOtAODS-0UPVaAqdTV_5zqGceN8R7=MvkGg@mail.gmail.com>
Subject: Re: [PATCH vhost 1/6] virtio_ring: introduce dma map api for page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> The virtio-net big mode sq will use these APIs to map the pages.
>
> dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct pag=
e *page,
>                                        size_t offset, size_t size,
>                                        enum dma_data_direction dir,
>                                        unsigned long attrs);
> void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t add=
r,
>                                    size_t size, enum dma_data_direction d=
ir,
>                                    unsigned long attrs);
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

