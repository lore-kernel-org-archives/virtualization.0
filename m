Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA102A1BA
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479984; cv=none; b=m8RkGEAgmXcrrHKJp0WR8W7h2bwcEufkfCnMngD0avW+Bbesj1PDEszpfhVDW13BiGBp4Y8oL8/SL87zgIxJx86F2UgWuEK1kISpbYtI7vUqFxDJpYGItEQLNtOVUttTG0QzzOoGQEO5gljt3/ii23ee7bwiknwiAVzAFsc8jts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479984; c=relaxed/simple;
	bh=D38h4FrrzKLcHZsP5Qqe1ZZ/zOqHrv1rVOBVVIbrFUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rhu3GHoDPfnviBQkOTE2bLkpFDtkjfiNGfZ6RACGKBMLJuQIZNIvN6kFrxh8jZ0S4ofCh9VmX6iXhPxL0+u6sO/1Cj7Mt0mT/CHRvtUG1o5TkoFYIaY8VYppFMJnHKSgV16yob6xqkTDzYB0dXP5/WPHCnbJzhkqClg+dG1GoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WB64nFal; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WB64nFal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736479980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D38h4FrrzKLcHZsP5Qqe1ZZ/zOqHrv1rVOBVVIbrFUw=;
	b=WB64nFalIyNbrMhw2VJ8ZLgJy/HU1gBliLAo00nLgb3rYPEH6hmNOuXnT1sdgFpSPKtMwD
	qR/mRHQkhel6VtyCo3wNptpDJGadk8gAn9lem74YAjdl/XV4Kq6YIC2sFvBG1l1zV84iux
	LcRmb9uUrf13IXlH4D+ryHpdnrOm7J4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-p0pUZNfANz2Z5CdhDjgKLA-1; Thu, 09 Jan 2025 22:32:59 -0500
X-MC-Unique: p0pUZNfANz2Z5CdhDjgKLA-1
X-Mimecast-MFC-AGG-ID: p0pUZNfANz2Z5CdhDjgKLA
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so3009655a91.2
        for <virtualization@lists.linux.dev>; Thu, 09 Jan 2025 19:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736479977; x=1737084777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D38h4FrrzKLcHZsP5Qqe1ZZ/zOqHrv1rVOBVVIbrFUw=;
        b=csxRkMhcLmbH0U9XOFz2HybitpMRavHqBa7Jue1Up+RxSampUfvTigS49gI2j42YZI
         q5fWjBO75Xcz4gSO0V3DWhc+EVjvnRP1kXXmpuTRDBUQh40Gqrwtq1l4ks6ZTbZUO2I9
         nUtACgZGjxihAAQLYrF/wMh1m92NUp/uhiC5ofXy54BEJAjVoRE42XNDhtjhrrqReaWO
         MJtQtU3LGUKRMXzna1QOFA0+sr2H5LDso4M9fsLx33O8PRWuHeyxjV+d4XNo6BEnVFzN
         7uR/latvGxdFl8y5G9jHyGo1RXuNkS/5ZhjQovt5/c5j5JFf/ReQgbawiRYTjtITdBwt
         FRnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFp+GjUSaJErMIKANM1CkBq6HV2ILxOLqNaxPiBQ6F741tWBHF8uv7Q/Ar7Cckc34yMdJvmOcF9krQmWWNKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTJaXdugJyLRbu4SzEALewSnNyh8s86MrUlPX3HPI+Fby7f63g
	CHVITv6ZtedcxbikwahTNoo11U5bmnMfPWIYo/9grF96Mz4W5wmEw5x9Y8Z2PHPS+buQ+Ff2Pk8
	Nx0pWEewWZVKHPT37INoEBxzBiO5IyQU+zNiW4ecnSer2WLn3gl40JaWFnJLQEWDnw5YouYdYoh
	DUhCiXTploGvhsIx35yjBTwiQpDNe0LY8P+pZAxoQ8LMlB2SzyNqrj
X-Gm-Gg: ASbGncvNAlvlHLbwRO++6Vlxp2dmqyIRSOqkRvJgXVDVAL3taAEFMab3JiubB3o6J74
	R6B171SNMiDVaor4LX12py1LBo+T45J3gsS5pcr4=
X-Received: by 2002:a17:90a:d648:b0:2ef:1134:e350 with SMTP id 98e67ed59e1d1-2f548f4273amr13755980a91.35.1736479977562;
        Thu, 09 Jan 2025 19:32:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwUWzIyDJsGPb1s2im88ffnjwm7m+ERma9erd4+Fy29KQGMHWgkqZQeoGy9ehggRZOy69tYnUwjSDd1KAjkBA=
X-Received: by 2002:a17:90a:d648:b0:2ef:1134:e350 with SMTP id
 98e67ed59e1d1-2f548f4273amr13755953a91.35.1736479977167; Thu, 09 Jan 2025
 19:32:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241111025538.2837-1-jasowang@redhat.com> <20250108063310-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250108063310-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Jan 2025 11:32:46 +0800
X-Gm-Features: AbW1kvajguOA9J-6Ttp0Vnmuq4TrT-wibacn_gZIl5gpvGL5iYbNY9GqY9m2aEs
Message-ID: <CACGkMEv_sMF5rmeaWchAbgyFd0a7-q+D_Gfejs7NpwcG-YD-YA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: skip cpu sync when mapping fails
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eHC1Sfd74KyB7-0iEPvDoadJfLAfL3kNCJrvBebfKGk_1736479979
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 7:35=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Nov 11, 2024 at 10:55:38AM +0800, Jason Wang wrote:
> > There's no need to sync DMA for CPU on mapping errors. So this patch
> > skips the CPU sync in the error handling path of DMA mapping.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> So as I said, I do not get why we are optimizing error paths.
> The commit log at least needs to be improved to document
> the motivation.

As replied before. Does the following make more sense?

1) dma_map_sg() did this
2) When the driver tries to submit more buffers than SWIOTLB allows,
dma_map might fail, in these cases, bouncing is useless.

Thanks

