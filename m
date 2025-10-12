Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290662EFD8A
	for <virtualization@lists.linux.dev>; Sun, 12 Oct 2025 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760296681; cv=none; b=ubE1DpIsInaqZfsIA+OUfMzNzFy2/o6u9NG3pSyvweY+lo0EJb7nZ++UUj0udfWGaoMRnXdoA23KTCPE4CkycK+g1d3Kq0YE9a9ll5q5OAXEbb/puuCdAcbkUGPxVwu7YRf1NMVG2kEgrym+YoKgT8duLRrd+WSj1lvlfME4Yyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760296681; c=relaxed/simple;
	bh=A3Z0XV+aqR3Bg2mpMrZomWGUcAUm8fgeCMh6RsgVMqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MrCBEGIjfzjL3TzY3wHixR4omTcsg0PUfZbG6Xa+ZahaHtLG5K6VROe6rHrad9NH2dIscrlEYYwx+CJ0olz7o8o+tPVurFk6a/e6znH/W8PeGemp3iHyfwBFujz4G8yE2KiY4sOW+Qw6ePefiKNjxyCJ5qlE/6K6/GnOhrm7Oio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JD7o+d6v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JD7o+d6v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760296679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v/dR7852yMs8pT9RLFFYNYHUOca2oMO/u0IxKaXqyfA=;
	b=JD7o+d6vMAR3TwZ1RZv3IMViqa0WquBjAl0f3yXGDchVSEmqRIYSut0tUMMOeKsxjS0xdN
	u7AUfJZGkBcpm2PxtnkEZdrm6LKskgl2hzFSP8ygKVIwkG/fQHDct2Vbk9GUKxttKd482d
	04aD+6Azua3DaebCHPPZwddg5A/S++Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-lsYZ4WmCMguYH9W_Z0OPYQ-1; Sun, 12 Oct 2025 15:17:55 -0400
X-MC-Unique: lsYZ4WmCMguYH9W_Z0OPYQ-1
X-Mimecast-MFC-AGG-ID: lsYZ4WmCMguYH9W_Z0OPYQ_1760296674
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so39722035e9.2
        for <virtualization@lists.linux.dev>; Sun, 12 Oct 2025 12:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760296674; x=1760901474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/dR7852yMs8pT9RLFFYNYHUOca2oMO/u0IxKaXqyfA=;
        b=Tvh5WzanflacYWXXBZzG0dKuG2xnR+ryoxvmRy+do8O4sNDzoiADUdvBfW84DyBHia
         1wLhRj4ADn10LC0qYZs845NAGzzHJVoUHlhT2z+jt4Tex4vHHw7lNHku2pz8DhTxIc7/
         sOEIntY/tDv6zzkSlGN92RV3/GRnmo6yHYD8W4IKB2Kmpy1W8nyDVfGaa3fxVa96EC5q
         3OSpjI4BhQBtOlsFXFLbykA5fysNdmNVl5JlpYf1EPQWArujzTBlgbW5BsobC8lYBa/H
         /m37aeuTXCGL4/o7NNiyqB1LB3NcgYQZYIE2qsng/6F/1TEDp4Py2tH3g7uoogsZM7mA
         MMyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM4wX0UqNEMd4TK/AhY0fbb4MA7lsIe1oev/0SBAjI0n+ZemQsfpb7Zq5/z8BPs38wwqbBFE7x3KDgB8jj3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyI5nsUcS8W/B+xxD/3XVbupCepXIlsb+tYawSGtlmsd7t6AgQj
	z+6yyDzfZycH3zKUnMlA3tSdUSKayZH4aXfePH0xIAQ0DgDBvX8AMHMsTB5lULdbCJvnbiER0Kq
	tXAAC7TkkzUWbz7/mVB907nT9/M5aj5MyBIFFAgT+AwvXXy5+59HMadaGB+phWzggpjfT
X-Gm-Gg: ASbGncsyQI6atUpicyNofA2g3ijo49O47XLehHCx168L/g4f8Ch3qcXSo3H5p4cjzf+
	Ps/ZKxSeOK8fzzCHfTybfdfQKcVXIKRDIhvbePxMQCXhxy2vzC9OJ2+RpNG9BGPDgaZuUuznavL
	DF4/dTusaQ2Mco00b1pEpRl9utgHRY1pR9aFid7OMf3f6czwAkb4tEE0m/Koxj6U96X5tY3XGpb
	jGdfzrTNmpmfV8NrzzqZmdvucIyXpsw2iLkpRVjHS8wfFuS8T4CtsvQBvajEy914k1Xm5PBwGpY
	tP8KIBXr4qVHppGG+o4BeCSgeKo5hw==
X-Received: by 2002:a05:600c:4ed0:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-46fa9a8be52mr117921625e9.5.1760296674286;
        Sun, 12 Oct 2025 12:17:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmLezo5h9IdZASkzNABJRNf+q1estWeI7SsZRQXuBRZVVly4xzTsB0yzUTdppy7wFbEkBWcw==
X-Received: by 2002:a05:600c:4ed0:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-46fa9a8be52mr117921495e9.5.1760296673709;
        Sun, 12 Oct 2025 12:17:53 -0700 (PDT)
Received: from redhat.com ([31.187.78.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4983053sm148394535e9.8.2025.10.12.12.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:17:53 -0700 (PDT)
Date: Sun, 12 Oct 2025 15:17:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] virtio: dwords->qwords
Message-ID: <20251012151345-mutt-send-email-mst@kernel.org>
References: <cover.1760008797.git.mst@redhat.com>
 <350d0abfaa2dcdb44678098f9119ba41166f375f.1760008798.git.mst@redhat.com>
 <26d7d26e-dd45-47bb-885b-45c6d44900bb@lunn.ch>
 <20251009093127-mutt-send-email-mst@kernel.org>
 <6ca20538-d2ab-4b73-8b1a-028f83828f3e@lunn.ch>
 <20251011134052-mutt-send-email-mst@kernel.org>
 <c4aa4304-b675-4a60-bb7e-adcf26a8694d@lunn.ch>
 <20251012031758-mutt-send-email-mst@kernel.org>
 <36501d9c-9db9-45e6-9a77-1efd530545ee@lunn.ch>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <36501d9c-9db9-45e6-9a77-1efd530545ee@lunn.ch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 13VoJqWvRDZea8mY--1Ez2exNiG_x_GmJ_ksxoPRpvw_1760296674
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 12, 2025 at 04:39:06PM +0200, Andrew Lunn wrote:
> > > DeviceFeaturesSel 0x014
> > > 
> > > Device (host) features word selection.
> > > Writing to this register selects a set of 32 device feature bits accessible by reading from DeviceFeatures.
> > > 
> > > and
> > > 
> > > DriverFeaturesSel 0x024
> > > 
> > > Activated (guest) features word selection
> > > Writing to this register selects a set of 32 activated feature bits accessible by writing to DriverFeatures.
> > > 
> > > I would interpret this as meaning a feature word is a u32. Hence a
> > > DWORD is a u64, as the current code uses.
> > > 
> > > 	Andrew
> > 
> > 
> > Hmm indeed.
> > At the same time, pci transport has:
> > 
> >          u8 padding[2];  /* Pad to full dword. */
> > 
> > and i2c has:
> > 
> > The \field{padding} is used to pad to full dword.
> > 
> > both of which use dword to mean 32 bit.
> > 
> > This comes from PCI which also does not define word but uses it
> > to mean 16 bit.
> 
> Yes, reading the spec, you need to consider the context 'word' is used
> in. Maybe this is something which can be cleaned up, made uniform
> across the whole document?

Yes and thanks for bringing this to my attention.
So MMIO can be "features set selection"

And pci can be "pad to 32 bit".


Less work than defining "word".

> > I don't have the problem changing everything to some other
> > wording completely but "chunk" is uninformative, and
> > more importantly does not give a clean way to refer to
> > 2 chunks and 4 chunks.
> > Similarly, if we use "word" to mean 32 bit there is n clean
> > way to refer to 16 bits which we use a lot.
> > 
> > 
> > using word as 16 bit has the advantage that you
> > can say byte/word/dword/qword and these do not
> > cause too much confusion.
> 
> > So I am still inclined to align everything on pci terminology
> > but interested to hear what alternative you suggest.
> 
> How about something simple:
> 
> #define VIRTIO_FEATURES_DU32WORDS	2
> #define VIRTIO_FEATURES_U32WORDS	(VIRTIO_FEATURES_D32WORDS * 2)
> 
> or, if the spec moves away from using 'word':
> 
> #define VIRTIO_FEATURES_U64S	2
> #define VIRTIO_FEATURES_U32S	(VIRTIO_FEATURES_U32S * 2)
> 
> The coding style says not to use Hungarian notation, but here it
> actually make sense, and avoids the ambiguity in the spec.
> 
> 	Andrew

I mean we can just define number of bits. Open-code / 32 or / 64
as needed. Hmm?


-- 
MST

