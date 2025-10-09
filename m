Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8332E5B0D
	for <virtualization@lists.linux.dev>; Thu,  9 Oct 2025 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014468; cv=none; b=qdP9JWk5tdBTMoO4VjxCs4wGAodc1nq+qUIyUVVN5irAhwoknwMGSEEzxzeeBfpJA5/BWMek4DsUSNyYBrDHBkUflpynAX2+MblrYsgD24eM/Qc+ZUcFFcbhl9wMdHFWRHjGpT5qMws0MbbjzArLfyBNw7Vao/OLoI8DKXb4Wgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014468; c=relaxed/simple;
	bh=d+WHqjD1e2xfxGWREFy8UIQh97c1/2BfHbOxP9RKa5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CpCpT7p1kDxuLYn3lY3vXIf5C5SD3Q1J+iH5LVonS1iP9MpNs+GZaZ2yNhWFss64dcEwDYFVYgHO4nx/LE5JNjx+d5xgS1OB5Opryd7p+iLbOvq+dvwLJep6s8P5F+WVZLHDyXqdn4Wr6Xd3UxO/NsQWqzvDfoGK6P4pAbXuHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmD0KM70; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmD0KM70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760014464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sLVQWh+Znqw6JAYRNwQHXL1TFNSvZ0jniZ0MloD7+Hg=;
	b=EmD0KM70H+qEk6u1/odi44dhRuJ0K//SKUto1pWqhyzf2GbFFVJmOcA8n6hUqUnRG6J3QU
	V66IpEO7gxhbE/i6C5sVV7N2ypZ3zouB0z9/KPZJgawI7PqZe+yQy/OwGtLxTN2i6OM0NW
	IXwE7TQyw4TJTlhVRtezBhSW0uiMgHA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-7sx45PxXNru4GYxJu3S1hg-1; Thu, 09 Oct 2025 08:54:22 -0400
X-MC-Unique: 7sx45PxXNru4GYxJu3S1hg-1
X-Mimecast-MFC-AGG-ID: 7sx45PxXNru4GYxJu3S1hg_1760014462
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8606c1c2b4eso843291085a.0
        for <virtualization@lists.linux.dev>; Thu, 09 Oct 2025 05:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760014462; x=1760619262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLVQWh+Znqw6JAYRNwQHXL1TFNSvZ0jniZ0MloD7+Hg=;
        b=WJLu9W8rojWQhRxzoESV8DQPjWf+hIkSyVnt71AaSxGiamXeacGRHYeGbN+Aa159zq
         Zn4f4ez1Qj+EiL4B9pLz1fdGRk4KyO/mhbZt1Ks7PGaq/Pgzvqbqe+cDCOggXOD4m+hE
         9hHxdio2A5eH100d1FcgPKfvkLncGcFTgrmtxab+GP+8SoIU4VceDz3NjYyhZSSkeRLf
         fP/cA0f3FOYrADwgbg+RcQd1lDHILmDihi7E6ZVkm/ktL8vOqBWyaLwFwE2LKrv4zt4G
         Yj2W9rjWO0Q1gJMH8DkxwseqvvsbsIdpGQx5kF/GhBfe7smQNRzsx/M9idOu135A49CD
         zg3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7OJcBsAXLSKLxPkm7PcR2IL3CGYJ2n7dlbRRYb/ASU5lXsePguBBZm22WkIFrqNGrjbGdSszm0WbAAF4fgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw14yLKvI48Q3czPglsixcgcEyg08uJIKFMBz7pgacXhiIorjJh
	/syXDtdBHdYaitDlupNxR1TXcfw7e9EMByFuyH7PQyNEdVHO4nVCRpqPUSeUljH79wF7zkPGxPt
	4jjwOxkkP0UKrsk48YyEvPmWgiL8P5SqV0wm5iHdUuviRCyxiJU4t7vGgaDVFsHdOkT0t
X-Gm-Gg: ASbGncsmGfsQX96exmqEi8G7fTihA71dbWIJWLE4SAmVDCpkz7W5E9CUK8nqrI2YLJl
	lsGta/hDQzZpRv/8Z6wFCiYW/j2gPzHTm/urnRKCaSqqQEFwXRFLc18bbY56z6KZL+CgkAdviOe
	QcV+yrwz2Gu/1YNZn3+TDcpxM4822pmZ+RjUBZfEVAq5puwPUc7220GuGoX5iCUQt6pl+qJmgJZ
	AZsp6Q6v4a4LH26THKBJuwvYTA/F/1LbDliYm0YGoBRDWxiM8g1bHuqfn2Ncaij6kn6yUX59XZ+
	rmCMdiNHh87hwo9oAOcvMigYnwoi0AR0qIM=
X-Received: by 2002:a05:620a:269f:b0:82b:5e2e:bc46 with SMTP id af79cd13be357-8820d18e350mr1885888085a.35.1760014461819;
        Thu, 09 Oct 2025 05:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqMpvtMJcanZP3rlvKbgdpkQAf5WVURwTPSiw1JSFVgNS1mLi/kxcHSU28QD1hy96VkYKztg==
X-Received: by 2002:a05:620a:269f:b0:82b:5e2e:bc46 with SMTP id af79cd13be357-8820d18e350mr1885875985a.35.1760014460576;
        Thu, 09 Oct 2025 05:54:20 -0700 (PDT)
Received: from redhat.com ([138.199.52.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9ad8dasm190766385a.21.2025.10.09.05.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:54:20 -0700 (PDT)
Date: Thu, 9 Oct 2025 08:54:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 3/3] vhost: use checked versions of VIRTIO_BIT
Message-ID: <20251009085057-mutt-send-email-mst@kernel.org>
References: <cover.1760008797.git.mst@redhat.com>
 <6629538adfd821c8626ab8b9def49c23781e6775.1760008798.git.mst@redhat.com>
 <d4fcd2d8-ac84-4d9f-a47a-fecc50e18e20@lunn.ch>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d4fcd2d8-ac84-4d9f-a47a-fecc50e18e20@lunn.ch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r1jj9r-ER1_C0roh2E17AO0jzvFVoTY_B7zoHnK80wI_1760014462
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 09, 2025 at 02:47:53PM +0200, Andrew Lunn wrote:
> On Thu, Oct 09, 2025 at 07:24:16AM -0400, Michael S. Tsirkin wrote:
> > This adds compile-time checked versions of VIRTIO_BIT that set bits in
> > low and high qword, respectively.  Will prevent confusion when people
> > set bits in the wrong qword.
> > 
> > Cc: "Paolo Abeni" <pabeni@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/vhost/net.c             | 4 ++--
> >  include/linux/virtio_features.h | 9 +++++++++
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index 43d51fb1f8ea..8b98e1a8baaa 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -76,8 +76,8 @@ static const u64 vhost_net_features[VIRTIO_FEATURES_QWORDS] = {
> >  	(1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> >  	(1ULL << VIRTIO_F_RING_RESET) |
> >  	(1ULL << VIRTIO_F_IN_ORDER),
> > -	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
> > -	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
> > +	VIRTIO_BIT_HI(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
> > +	VIRTIO_BIT_HI(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
> 
> How any bits in vhost_net_features are currently in use?

68

> How likely is
> it to go from 2x 64bit words to 3x 64 bit words?

Maybe.

> Rather than _LO, _HI,
> would _1ST, _2ND be better leaving it open for _3RD?

I can just open-code

	VIRTIO_BIT_QWORD(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, 1)


> I would also be tempted to rename these macros to include _LO_ and
> _HI_ in them. VIRTIO_BIT_HI(VIRTIO_LO_F_IN_ORDER) is more likely to be
> spotted as wrong this way.

Hmm but with my macros compiler will warn so why uglify then?


> An alternative would be to convert to a linux bitmap, which is
> arbitrary length so you just use bit number and leave the
> implementation to map that to the correct offset in the underlying
> data structure.
> 
> 	Andrew

Right but it's a bit more work as we then have to change
all drivers. Not ruling this out, but this patchset
is not aiming that high.

-- 
MST

