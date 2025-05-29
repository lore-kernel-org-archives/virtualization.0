Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD4156CA
	for <virtualization@lists.linux.dev>; Thu, 29 May 2025 06:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748498752; cv=none; b=HxkUsZEHsWnL3f9HKSJbFOPssXlGIhKeKuhy+yxyZ909k0HhfJt1roFYRLwXlUF/8s/ykxP02ZcGMkk54xnQdoK87n0cM3G8fSoUpfZG/b4aWv5gqN5OGKkp/SGGcGq56WugX5B8x3GcNJc5QnhBPnEOqtPSezNoRCUvAbECAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748498752; c=relaxed/simple;
	bh=no1aqbbZyBCpfeXzJTYYTAIz/S0TB+7xts0vma9pIFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFhL8PAWdiWOajVtPjKBRWERBwdKazNac1z3yh0emati5GF2tj6N7yi8WRa1mGSMP7eCq3r0evVEhZJT+WbuU5eYyYB54W6FtkDmJICy5+izv4q5ULBUa8YT2PxaMc1XntcGxoaJw6jTJHcxdIiGVNAvN6FRt5UKuGxCxuhnMm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1reMGJ7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1reMGJ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748498749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=no1aqbbZyBCpfeXzJTYYTAIz/S0TB+7xts0vma9pIFc=;
	b=T1reMGJ7ncAcE97l+c7wGeJTE8jJwL7IQyQUU+qHWi9hZEYkviZX/gAL4xIPaAt36jap1f
	u5Vp/v8aB+3nLc/0HXslHYDvMv3BqEwsLf28BQWbGJ2KcWj/acv4GEggMwEMgelMzdJsRe
	e8MqaODv5DHN9PV/RygTzuG26qtMAv8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-1juY81oBMXWqIUB-JPJJQw-1; Thu, 29 May 2025 02:05:47 -0400
X-MC-Unique: 1juY81oBMXWqIUB-JPJJQw-1
X-Mimecast-MFC-AGG-ID: 1juY81oBMXWqIUB-JPJJQw_1748498746
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-310efb64693so538026a91.0
        for <virtualization@lists.linux.dev>; Wed, 28 May 2025 23:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748498746; x=1749103546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=no1aqbbZyBCpfeXzJTYYTAIz/S0TB+7xts0vma9pIFc=;
        b=XwWAfBoxPwYH3IAflDsAME2akEN3+FN1+rrunwtZeAm8fXFlN3e4tsQ+vPMmLCFWvM
         q6B1qFcZOTIECTrqS9KKIn2Rp8I4lB+9KdMF0JH9oKt+dAEB5zWuMRZEJapKHY6Hcts9
         3s8ihF+Ud2pYqQtLucNA2LP+fZ/ex6PWIxqo26AcLLtVPCExCEs5HbNBFD+CGmBtgs4V
         gELB0h92nxnCyFxFTJ4AtbhKMHtozswNrEo6y4lgt+WPjjREziKcNb6pLh1pCNRHuHGa
         0KreGHuxDeLt53vQdZFYhIt7gC08yX04bOPSgKgAydqjbesJv/TVEP/DW79oUdm3HFTe
         eRQw==
X-Forwarded-Encrypted: i=1; AJvYcCX2Z9X6Mr/P6r5fb1jNajSaiWnFDWWsyEUXydlz/4nLIited0Xf+Z+mMca9BhpSG+tqVs6m1kO/LJD4FnzoOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJ8czbfbRBEjrh+bn4lxL9eKeXVm78QQWrjHFqzK2j51g0HeEX
	lZVHsDFTgqPRKagBJl855L3kjwsEE7KkSkrtctA95Ls0XL5823XfkqMuOhxQF9fmBR8psqM8wtJ
	Bs73WR6tiSI0IUwSV5zYYyrEkOc21wX/oHxWNoaRk6wOO5Gj7KwN9BJbM05pjJO3I36M+pOv8SS
	/uck97UgPbpUiAXEuqrqIEss6Q5S7Q1q0nTB+7hBlz/S8=
X-Gm-Gg: ASbGncthBxHQrBAsX5NEcnzdc8O5P87XeB2izKJ49Fmb9utExuVR+BJoqaO7V4hD6zU
	ftMiCUn8Ko71lnb5Whv4zVs7JvluZrvqU+LN+OozAp3k2XHURXXeFehA2PFUkqDRF8YVC5g==
X-Received: by 2002:a17:90b:1b4b:b0:311:d670:a10e with SMTP id 98e67ed59e1d1-311e741d857mr8403834a91.18.1748498746015;
        Wed, 28 May 2025 23:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhKm7vTdAWm+ZVfYsKZk4PLZyQfaAbTNQNUVYnzDB+/vla96NEa/sHqud4vlifM7NPP/JX6vV0pVkRrsEa74w=
X-Received: by 2002:a17:90b:1b4b:b0:311:d670:a10e with SMTP id
 98e67ed59e1d1-311e741d857mr8403795a91.18.1748498745614; Wed, 28 May 2025
 23:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <3e56c6f74002987e22f364d883cbad177cd9ad9c.1747827066.git.viresh.kumar@linaro.org>
In-Reply-To: <3e56c6f74002987e22f364d883cbad177cd9ad9c.1747827066.git.viresh.kumar@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 May 2025 14:05:34 +0800
X-Gm-Features: AX0GCFvm7_KOQ3_CSX-l22USsRFufClSk2dV8c7bgpa8kJcsAcwAfJSzihrbHw0
Message-ID: <CACGkMEsfgGU99_NC3NTYgyH89=6eADKPFiChVW0kZkfF1Js7NA@mail.gmail.com>
Subject: Re: [PATCH] virtio-mmio: Remove virtqueue list from mmio device
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Bill Mills <bill.mills@linaro.org>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: namrd87UZSRd9QsdXQ0NiovUn8EA7j0Z1Jw2SRLPaRA_1748498746
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 7:34=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The MMIO transport implementation creates a list of virtqueues for a
> virtio device, while the same is already available in the struct
> virtio_device.
>
> Don't create a duplicate list, and use the other one instead.
>
> While at it, fix the virtio_device_for_each_vq() macro to accept an
> argument like "&vm_dev->vdev" (which currently fails to build).
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Btw, virtio-vdpa may need the same optimization.

Thanks

