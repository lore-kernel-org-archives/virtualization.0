Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3681B960
	for <virtualization@lists.linux.dev>; Mon, 11 Nov 2024 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288645; cv=none; b=iyy8E204vgWdLEJ15HzfcY90ad0JBwiBJqTx+hIFzMab3TOsF1icS8B3pwVSP5b0oJ0XuCgtWZ35+QzQCky6pZ4Mx4cJKjAF1ktYB3LzJ0ebrQm2h0MIUPqixG4srn6EUJDu904RxpiG2XKJINplStqvZzpZzBbpWtCTu6c1xQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288645; c=relaxed/simple;
	bh=pf9PTbGNPjVHsdQ4Eg1yKfu4ucndzhUiZGAnz9ecS9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ur+zzZ4kkZiyFkIbiQOuE8tB9jY9H2nEAJAFK3crYNghOtwQjEg1GRo6GMo3HLmVoIejT6zWhUaxb651SzvWKPhl61zP1bJWKkFcV2/a8xR7d+/lwfiR+tk45gb9TDa+TeXH29JO2dY41vgrUYRHUGXowXeggjokL/6o6Bqjipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMirI1iU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMirI1iU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731288642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pf9PTbGNPjVHsdQ4Eg1yKfu4ucndzhUiZGAnz9ecS9Y=;
	b=UMirI1iUq0bEwjOXCS1iRYYaGkm/TlX73RjZHmFhZ/LXEL771N++0tzt0e3SDEwRlcqyNR
	pJGeVkAPwDWxdzsOTABgFtAEfMkgRl2pqGX/e4ch9MFXYYG4UfD+VjndR643pdKKgmkViO
	h0dT1IcVGf8jE9tKmzLGVC54GPZWm8E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-KMZiBt_PM6K7WLXufpkhvw-1; Sun, 10 Nov 2024 20:30:41 -0500
X-MC-Unique: KMZiBt_PM6K7WLXufpkhvw-1
X-Mimecast-MFC-AGG-ID: KMZiBt_PM6K7WLXufpkhvw
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21159b15562so57070645ad.0
        for <virtualization@lists.linux.dev>; Sun, 10 Nov 2024 17:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731288640; x=1731893440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf9PTbGNPjVHsdQ4Eg1yKfu4ucndzhUiZGAnz9ecS9Y=;
        b=im5EFz74cqiVR6AeMSUadO5iz8h9pntcIymrQgJ60k8uvjD43z77PLLGMSsLYriDOs
         GZT0HDqyapWCYWTjqyOb+4O5z7xe/a3PijBeFQ5xVtoul9NLfNdZUDGr8Ye1rBmS6kkt
         tKjhs47X19buiYB3rIp0M4RknY/gvlA3earngmMxHXrf+uwFp5xJt3BlsjRu1XHVB1eO
         Jsxz6F3JLfxbY60kqvlgJBbBCZ/nUYZEn9N281mGPBtd3NIT09D8DviOIeG2ttox8QpV
         UX9+ecext57crD0RVWfeQiq9uH+4Ygs2YHrHCZZF7tncuYaLh/ZeV6urp/Jl4y+Ixk4k
         Z/tg==
X-Forwarded-Encrypted: i=1; AJvYcCVfBQPuvQHHL0prRmh3IB+8i5HfaKITHt4I9A8mgMa4IACX4DIaDZ7jRIiykq/O7iODK3os/keHlo2fiDFefA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7IRlm77mngTF2T0Z79sbKeWrdhsFC+4cRtpFEU2WftSlM1t6X
	GgJJg6wb0skJb/niKjlfF41zvxipdlwEK8eqMPKwAdg8LX2XFBZQLpj6G452IPhYDCOiTvMCF4a
	JPsjRFSzUI+Z8R9Z2ysh4k2OS13Qgm9ykN9gjTgadSAdyUv5xeapIOaV9rOO8dNI+B8jaLA6QQ+
	qSGrMQqogabgqlP9OwNA3133lUb0+Ujoz6eqQSZ1Q=
X-Received: by 2002:a17:902:cec7:b0:20b:b7b2:b6c5 with SMTP id d9443c01a7336-211835cd1a9mr142109775ad.54.1731288640282;
        Sun, 10 Nov 2024 17:30:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZRBnvWh5GWrgUU3+bWrELT9eUGDwENrtwgxF8fs2ll6MrUvLLBsrBK0BTbf9dHmzIUgOcdwoSUpYFkpBBW3M=
X-Received: by 2002:a17:902:cec7:b0:20b:b7b2:b6c5 with SMTP id
 d9443c01a7336-211835cd1a9mr142109475ad.54.1731288639882; Sun, 10 Nov 2024
 17:30:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241104085706.13872-1-lulie@linux.alibaba.com> <1730883538.0293355-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1730883538.0293355-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:30:28 +0800
Message-ID: <CACGkMEundAnfw9mHY64xTGtrwB6TcZkfmVQc3K2L7vBy6SWSnA@mail.gmail.com>
Subject: Re: [PATCH net 0/4] virtio_net: Make RSS interact properly with queue number
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, mst@redhat.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew@daynix.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D7_uLfn2c6G0r1QV_UXqVK993Ooh28IUrXB9SY5o-zc_1731288640
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Hi Jason, could you review this firstly?
>
> Thanks.
>

It looks like the series has been merged.

Anyhow it looks good to me.

Thanks

