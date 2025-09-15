Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E633472D
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947581; cv=none; b=mVYww3i2B0MIomtngkdJ1OeSLgs0ft4hdHFhFDNOk642bdajdAyc8Nx6zViJLyJnvexh/V0ra2Qt7TXj+e6uf83ugNGmZW9hMaxsU4rzoHBFtrC+wCQ4fhEha0qYJjGdI94okm/K+VhZrYuVnhkoeTiNnrfioiAOCspu8geJrME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947581; c=relaxed/simple;
	bh=g2Pnb04/njOJX6OP/WYZ5RrANes435aK4i1BTsy1kfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PR1BOTSrreLBHoDJ2jgZXSg7siWG1t7thdz3cpCkrfQD1QQF32DAGldgjtisYufHncFFCeuV5ueJhRwJn4Ge+i1nceRGBb3DZhR2DfzaL7YomFDZ4rs/V/0CxnClOKtT0tBVPca0DeK5epJMk5c+hiePvjcVXRqqTMlk7908kkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUtgs+L9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUtgs+L9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757947579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2Pnb04/njOJX6OP/WYZ5RrANes435aK4i1BTsy1kfE=;
	b=XUtgs+L9KpCWeYgQH2Ccf5WnDn3V6umisiRvpC6hV3M4W3dU+bnI31mxSPsZiYa1cedNCj
	exNWbO2FdhgjeZXXJfi0B7tt6HfskjJykSoqcXf6P4/h7e0AN2GLq7S4U/uQIM3stLFsYa
	UYBpCfU0c+LBdnFTQyXgeY+O4dcJLco=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-aSDCDhi9O9GnJxNA4RQmow-1; Mon, 15 Sep 2025 10:46:13 -0400
X-MC-Unique: aSDCDhi9O9GnJxNA4RQmow-1
X-Mimecast-MFC-AGG-ID: aSDCDhi9O9GnJxNA4RQmow_1757947572
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b04b06659d2so290696466b.2
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 07:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757947572; x=1758552372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2Pnb04/njOJX6OP/WYZ5RrANes435aK4i1BTsy1kfE=;
        b=kMxeCbIr0KNw7I+nbBcxFynnW56NqsyhP7OpRerpqw9QpKllp4w8ZhZGka4Elp5kGF
         AZdOgeNEipmcNAK51vcZbxn7fU4jwFGdvSe9rQfTM5TdIzho6yf1pLeIP2OzUyPJ2dak
         QMJMpaB9vu9MjaLWXjx7KY51UvBsus9MzmTYJAOSpZgYroFkf3g0FgVJHKTKl/bAy5SA
         ldluFzGBaB/QK89G24SFfPVDu/U0Wx9y/hbGjlFLLQuzAAqlC8gLXAix9i5HsN6er8lV
         NJ8rdhJJiTTQ9vir7GIWvYx4NPZI5gfo0+VePPSxU8xuISEJb5RQVMydNdVCflpRyTQM
         lyAg==
X-Forwarded-Encrypted: i=1; AJvYcCVvto1X7uMzAQGigZ5+gjZ3bKlyKxAsyBpCqgjKI94ECtXMzF+bUs2hbK4MUg4xr7uCNd1xCCxu77qt5HDHzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhReQD2TyYhUS+CLuL1wMUEbAFrGuayYANSHfDP8ug7wcBfm4q
	aNR1C/S786n5jW5KwtLYHmNjAs1T0/fKzk9d1A/p44AoNcrvSitZqnxsuDTU/3b9bVoZGnuz8Lj
	VpGJ9g2yTXZ+zOcW19yNB1dimyt2IWOcrqCdu3UokJPdssc0GLjzw1W9SSUXfuVYbFOzt/E9p2S
	/yUEg3t1mxgvjmpOt+IEF/1nUCYQwxN+rk1k8aGk7oZZM=
X-Gm-Gg: ASbGncuEFpM2iRUwqxqcMjkf4LANqtTocCh4HeXcsoUlnTPe9rkepiM2jWeiRW0NQkC
	qK5syjHVkpJyMhi8eZT1onMSpjg81G9EOoSDza1RuDoYpz4qnPJjDOdXnEkdgSXO88M1EVR2Gco
	McLqCAOT87jtXPAMgUkymK1w==
X-Received: by 2002:a17:907:3e03:b0:b10:ecc6:5da3 with SMTP id a640c23a62f3a-b10ecc6640dmr347176666b.63.1757947571752;
        Mon, 15 Sep 2025 07:46:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERqnM4TDFaglXTZ1TiljWgRnJ/XQu6e2iToInrsLSac1TYz5imtwKAo2yzppRLZeL61hsUVinU28MLjkJY0qE=
X-Received: by 2002:a17:907:3e03:b0:b10:ecc6:5da3 with SMTP id
 a640c23a62f3a-b10ecc6640dmr347172866b.63.1757947571319; Mon, 15 Sep 2025
 07:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
 <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>
 <glf2hbcffix64oogovguhq2dh7icym7hq4qkxw46h74myq6mcf@d7szmoq3gx7q> <jserzzjxf75gwxeul35kvvexscs7yruhlddwhmw6h433shfdhf@jsesmjef3x76>
In-Reply-To: <jserzzjxf75gwxeul35kvvexscs7yruhlddwhmw6h433shfdhf@jsesmjef3x76>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 15 Sep 2025 22:45:34 +0800
X-Gm-Features: AS18NWCPqkI_mOz0DI25Cy8SLU0CdLKom07g_re2BVpx_B9ko5kxeK11-LxKKX4
Message-ID: <CAPpAL=z2YXWDV7HVeSzZbTAUNrb1h4R3s1kmWSyjXp_r7iar8g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kernel-team@meta.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VNKubJHt6JDkRwluM_968KV2emBB3O_LDpUIpmkZRSw_1757947572
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 6:58=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Mon, Sep 15, 2025 at 03:55:53AM -0700, Breno Leitao wrote:
> > On Mon, Sep 15, 2025 at 06:50:15PM +0800, Lei Yang wrote:
> > > This series of patches introduced a kernel panic bug. The tests are
> > > based on the linux-next commit [1]. I tried it a few times and found
> > > that if I didn't apply the current patch, the issue wouldn't be
> > > triggered. After applying the current patch, the probability of
> > > triggering the issue was 3/3.
> > >
> > > Reproduced steps:
> > > 1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/next/lin=
ux-next.git
> > > 2. applied this series of patches
> > > 3. compile and install
> > > 4. reboot server(A kernel panic occurs at this step)
> >
> > Thanks for the report. Let me try to reproduce it on my side.

Hi Breno
> >
> > Is this a physical machine, or, are you using a VM with the virtio chan=
ge?

Yes, I test it with a physical machine. I didn't used VM=EF=BC=8C just inst=
all
rpm which compiled based on this series patches, then hit kernel pahic
at server rebooting.
>
> Also, I've just sent v3 earlier today, let me know if you have chance to
> test it as well, given it fixes the issue raised by Jakub in [1]
>
> Link: https://lore.kernel.org/all/20250914125949.17ea0ade@kernel.org/ [1]

I already submitted a job to test v3, the test will be completed
tomorrow and I will update the results promptly.

Best Regards
Lei
>

