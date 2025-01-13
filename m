Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F474C14
	for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 03:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736737633; cv=none; b=Sc9OPEp4b2b7x5QBpAWB0YPbt0k9bXbeRmuVAS+Q5X00KRlGTeadtM7/pHXMGGdS1yjhRBnw3C4uZfCSwq/IHXDtQif6amPrQRDp06YviptKB+0Xs+ffmLIyCRSTQcVTVUTCB/9WQKesL7WqLy5LAVc4FZizrfnhXnZaHG3/cnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736737633; c=relaxed/simple;
	bh=BaYlTT6OgVhY2ChFvikjFPS0MYK0SNbEESnmU30YQQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3ck8Xr7dfp1acRoyG5qb8GVFLOZ6iLaMfnV+BNJEf6181yEHCCqYiCVJtZmQ6FyiPv1YzxgfMntXGQIvvfZeBl2RNAAsz3NKtOw8txQ7ynixLr490y+AlubvIsiIpbKoGZyoyABnBFgUoQsUyLBfIkfRsfXjmLUc7w8vqdYnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aM5vFyrk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aM5vFyrk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736737629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BaYlTT6OgVhY2ChFvikjFPS0MYK0SNbEESnmU30YQQ8=;
	b=aM5vFyrk3vnuHnW7XAJk4zGhPSx3efbvQe8zINzq5NulgCbLHD/bPcDC/UorZPzxt3tc8g
	L6fME6f48hDG61FvCJTdWMguVlQyiGgPFA109uTYS1Lj2R1+lbA9MpckvVCpqDzGTZjeF9
	ZX3d09rzU38da/Kv3LkcfmNlstG6D4Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-a1FxP8EaNWeE6henbu9HuQ-1; Sun, 12 Jan 2025 22:07:08 -0500
X-MC-Unique: a1FxP8EaNWeE6henbu9HuQ-1
X-Mimecast-MFC-AGG-ID: a1FxP8EaNWeE6henbu9HuQ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2efc3292021so10209683a91.1
        for <virtualization@lists.linux.dev>; Sun, 12 Jan 2025 19:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736737627; x=1737342427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaYlTT6OgVhY2ChFvikjFPS0MYK0SNbEESnmU30YQQ8=;
        b=nn+a8cBV9t6/PkCEgb1z1l7G8zB/IbvYbEj4j2sHv3Pjr4yRVxf2BrCXR0yLzsx+83
         Ie9nOxj6ACu5IBO8YoX7T/tso3gDB/k752BtsPnBaStDxyS9CJmSlXTNBM5Tyob0jRv1
         LDeo3whFWFAKpgFFmKYMt3x3iZhjmSHwz9VoBNUku3lAPs8bAB9pRntlnVNy/i0CHQ6/
         9YG9plsd0d2jad+ZIqDXkEhlzPyUCIfyBOm3XaCYM9IF4Flcl++xmPHFxrkA7XM8V3o7
         a/T/SCGCjkFBSxhvHUZNiPguvzWBuyvGytM/I3lLD/WRWqihQPJjKUbpKmC3umXfw8bC
         pJyg==
X-Forwarded-Encrypted: i=1; AJvYcCVlrkwp991zaumkelgFmvXybYoCLO4L60U8NqANedwm/LJuqShCzRjCz4xpqJCQLqI0RLmLpw1TYXSWdkJW7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjEfk4yxoWYvDspzhu6eQ9JDg6zUGnBngWz09aurJnapaMIYKZ
	J8pBiJtk6SrtR8j4JV6U+rz3kKEq15NBr1KBCTUwV0oxe3qpf8cFmaKlEC6w2BKmGD1B3qMkPuS
	QvN774SYQHps8l2lOPncBYfWaGzeHoSfQnyfFLL1wWnqGYJ+H2cmFFN9hLsVU8CR2rhXGX+WLMh
	KDVbzIuNYBZJYvPqQLVWGkI7NW48fpdP+u8rEreW8=
X-Gm-Gg: ASbGncueB+4WhbwcrcL07M4jm/Vb6fbOVx6ujixsRq0wDmymSo19ZgP/6RkbETi5Q3w
	H3q4/Q3jAHYQ4Ov/HOOuzXSK60exE2AFbOSZyBIU=
X-Received: by 2002:a17:90b:274e:b0:2f4:4003:f3ea with SMTP id 98e67ed59e1d1-2f5490f19c7mr29703049a91.33.1736737627568;
        Sun, 12 Jan 2025 19:07:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbxmuUMkhZxdBtdwT2wVk/HrqOFfnBXehFfrQge9eZqSNUyrySium7ci6M6y8VvQ2mMzZNqV6QVn5E9RDwsLA=
X-Received: by 2002:a17:90b:274e:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-2f5490f19c7mr29703015a91.33.1736737627192; Sun, 12 Jan 2025
 19:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241111025538.2837-1-jasowang@redhat.com> <20250108063310-mutt-send-email-mst@kernel.org>
 <CACGkMEv_sMF5rmeaWchAbgyFd0a7-q+D_Gfejs7NpwcG-YD-YA@mail.gmail.com> <20250110033113-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250110033113-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Jan 2025 11:06:55 +0800
X-Gm-Features: AbW1kvaADG6eAn0aKzs18Y0iuSm6Oc9Z5HqlUPhZkdTz2JWJ5irtnl5kun0VEcU
Message-ID: <CACGkMEuUVasKB5UZxxzw=TPCWt9MvNR-nOTZ2FRh0yLAPCB8Mg@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: skip cpu sync when mapping fails
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tgDWN728GsbjhU7JG7j49dmqSUMi-irQntslNno9D_4_1736737627
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 4:32=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jan 10, 2025 at 11:32:46AM +0800, Jason Wang wrote:
> > On Wed, Jan 8, 2025 at 7:35=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Mon, Nov 11, 2024 at 10:55:38AM +0800, Jason Wang wrote:
> > > > There's no need to sync DMA for CPU on mapping errors. So this patc=
h
> > > > skips the CPU sync in the error handling path of DMA mapping.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > >
> > > So as I said, I do not get why we are optimizing error paths.
> > > The commit log at least needs to be improved to document
> > > the motivation.
> >
> > As replied before. Does the following make more sense?
> >
> > 1) dma_map_sg() did this
> > 2) When the driver tries to submit more buffers than SWIOTLB allows,
> > dma_map might fail, in these cases, bouncing is useless.
> >
> > Thanks
>
> About 2 - it's an error path. Is there a reason to think it's common?

For example, doing FIO testing with 1M or larger requests when SWIOTLB
is enabled.

> About 1 - ok reasonable. You can say "while we have no data on how
> common this is, it is consistent with what dma_map_sg does".

Ok.

Thanks

>
> --
> MST
>

