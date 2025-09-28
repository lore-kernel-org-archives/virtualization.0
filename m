Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA02459ED
	for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759040351; cv=none; b=NkaltREp2K5tWXzQ+PTmKxnp1mWqZd/iYsRC3fxrvp8CcQysbL5rmcwVi95/UTkdPOjbuztBbJRZD+7Mhjih7uinavi6a79qQiHiqqoXeUDtd8a9ZdZLjNTG1yV5LCZf+Uo8pbrRchK/qQ0k30l4tH/fVRgQPeV+qZCft05+P3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759040351; c=relaxed/simple;
	bh=FHSh68POuZci0soOBMqYretNIENx6qAcTuhOTMHoj+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WH+8jvZ1K0lN6ilzlGa/5O5ghiNG0g03Rajweijb5SZYrNmfmGa5RKGGZMGWwWzWvg7e8beG2PA1QzqAL6eSP8rOgAujWyQRqdzhlRtxUK4KlBdVRde7dVM29erzYtAK2WVpbfEtqEQlNsEqOPn4IckdU8Kk9ulc8jQZ0IMTQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VP4pDlUU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VP4pDlUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759040348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FHSh68POuZci0soOBMqYretNIENx6qAcTuhOTMHoj+s=;
	b=VP4pDlUUZMZzNSuvClhZcCENbwTPgnRm/gkvcu0TYPMoui6gib3Z6bZHtbRQVtLi83OyG8
	pkR4eaSi8QhTTqqdm4bm7OUzARrayysJ4Qy7kGQAEFOvnonDNLujpIPFjZR2zl8xzsX+8R
	J7a61DNwYLYGC6d6C6N5ZuvG7shRar0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-1tTQpqOXObG7q5R5LghFlQ-1; Sun, 28 Sep 2025 02:19:06 -0400
X-MC-Unique: 1tTQpqOXObG7q5R5LghFlQ-1
X-Mimecast-MFC-AGG-ID: 1tTQpqOXObG7q5R5LghFlQ_1759040345
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee13e43dd9so1681961f8f.1
        for <virtualization@lists.linux.dev>; Sat, 27 Sep 2025 23:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759040345; x=1759645145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHSh68POuZci0soOBMqYretNIENx6qAcTuhOTMHoj+s=;
        b=VurEIRPCONWCRtcQL4b6t54pbckkIF8Cn/CJrBfmEVtL2F0Qc5QLJ5ba52KVwwBFat
         ww2vWdM+wY0heSTlH96/iT1++E6kX6mWi9QpdrTtoP5z4OTGvqbCY0ozd4i3I90s7D01
         d1s2DdkMobfDl5+a4wsCaMyCUXU06CzIYx88BnAUjMcywIaYKyaoJ3ZHfmXD48XbTK/H
         VF1sUTPbIiuF21t/baEsaA1I2EcsGYMyDKIRQRLlcLocwUXWpvxxMpHoo9R7HkaQOGjB
         5ZqLgpJDiqeZEd6DkjzueZfKuw2uVeNGsp2E4D3gSEAZsQC/vtfYqrxlo27K3l3oiPXy
         Cidw==
X-Forwarded-Encrypted: i=1; AJvYcCW05rzW8IDvwR69wY8fIAQxbh0ON+C2tozVmI3tX0I+2ZG0RGARCZ3l1f7RlyXDEoNVH5+bvkwPGivTbJmEBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJH/m/9SdBcp6r745St6ZL4Jh2BNN8IY196b0g2PDfIk5PeMAF
	b3bBKa7hDJB7jFP9BEb3Uq0dRCiL46ls8+mlYKIJYUxhtqYFv2OxssmAyWiYfn3JKFma6G59kKR
	YHAkut59V819AGhGG7L0fbIAljXGApeIkWe6ArsT2pQs1rcOOhis6FzPkAzgipGyu7Vek
X-Gm-Gg: ASbGncvW/sOg83b8Y+Gsawuja/KN42lLzeI2ZKmh0NdOqXBntfwwTcZvkbBi90+8W6w
	rhT1C8wByHDJ5OSd9dw03pu1ODdnKqCTNzsBHLN0kSLGBMubWMSFb0Bvwfk1w2JtgHpnUTicqMK
	L1sDWGyJVXSDYpKSpZOK32X0KQkQrO4Q2Pb6HXGNodvArO98pRoW+JGBv1ZMgTW6IlmbXZ8FkVO
	Qjt7YJf6l6z0ynRwOq7qn2jx74huE0v/N0X86d6bBnjoZJaQhkb4H9Yb2BraE+bSoOu9FMAdUeS
	RuMrzksTcImihiGEQPjEY9C8uXOY2r2r
X-Received: by 2002:a05:6000:2f87:b0:3e9:2fea:6795 with SMTP id ffacd0b85a97d-40e4b389223mr12613884f8f.53.1759040345054;
        Sat, 27 Sep 2025 23:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGyAlosu7SLyYtGgUxUn7flP3QvS+gTogdl7QE3/POUYAQejBg7RyfeWxq6205Wv9jdzXgeg==
X-Received: by 2002:a05:6000:2f87:b0:3e9:2fea:6795 with SMTP id ffacd0b85a97d-40e4b389223mr12613844f8f.53.1759040344431;
        Sat, 27 Sep 2025 23:19:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:800:cc29:ccef:c1e8:5fd4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fe4237f32sm13263126f8f.63.2025.09.27.23.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 23:19:03 -0700 (PDT)
Date: Sun, 28 Sep 2025 02:19:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 11/11] virtio_net: Add get ethtool flow rules
 ops
Message-ID: <20250928021714-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-12-danielj@nvidia.com>
 <20250925164053-mutt-send-email-mst@kernel.org>
 <4532bc48-ca59-4f04-a3f4-a66d4be4ac1b@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4532bc48-ca59-4f04-a3f4-a66d4be4ac1b@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: el51klZEH0YoZpOS_zLX9GYrPNVB_zov4OfEr_RLCsU_1759040345
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 27, 2025 at 11:39:28PM -0500, Dan Jurgens wrote:
> As a practical matter I can't imagine a rules within 3 orders of
> magnitude of 2B.

Thinking about malicious devices here - virtio is commonly used with
CoCo. I don't specifically ask to validate everything if bugs are
not exploitable. Just that you keep this usecase in mind.

