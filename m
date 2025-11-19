Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE53043A1
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763583762; cv=none; b=TQOrLFn2DCRKdo2LMz7MgdN4LWHYrve+br86rESTCnrdJ7gJ1AVMikY0a2kSS+b9vFxP4cG2FrVFcaVHlzMwfxZGlLlMxc7TyKXqeze+wEpLfC9AtlMxSzn5ygLmtWDb+eck7SgegnGSSP9UswKP8lALI46/SxsfXdHF2aBsHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763583762; c=relaxed/simple;
	bh=Qf3h8LQWgZZpMpM3MFbHJdvzLVhTDqmkGNygGmxZVWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ULBiRPxR32gg/rn/M1ItXQh0u8xJcXXG2Abd039hCR2IUGAPjN4vPv22hbqYNNExGIwwJePkElsn8OVBf9SjpNF1lh5vpXYw2Svy3Vy0BdGd0UlQLZzi8SelBlgaL8vr6n/8okQxB2GeNtZDeoCWzslsH6iU76mMYWJimrME4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7OpbVpR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7OpbVpR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763583759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qf3h8LQWgZZpMpM3MFbHJdvzLVhTDqmkGNygGmxZVWw=;
	b=a7OpbVpR22gPxN8gh9XaMaDITKs19fCWzcHsIXtiQ8Z1NmeDqcE+RUzHXGTUd3GOZbXAU+
	WSU6SBIO1r3EFUHu6+4gRjOfy83ki72xpu/IcZonT6J39Cw2IwbcPYCuN2lap7sQj4mEjA
	5Hm6O9tPUcHWEYABVxJ5+AGjc3/SJ/A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-i7JxFMqoPNiWuBF-yAC66A-1; Wed, 19 Nov 2025 15:22:37 -0500
X-MC-Unique: i7JxFMqoPNiWuBF-yAC66A-1
X-Mimecast-MFC-AGG-ID: i7JxFMqoPNiWuBF-yAC66A_1763583756
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779981523fso2232375e9.2
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 12:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763583756; x=1764188556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qf3h8LQWgZZpMpM3MFbHJdvzLVhTDqmkGNygGmxZVWw=;
        b=Ezv+sgoggdlNAE8PNJ/fjZwLHmsr//ZPB+P9mRyUuYs5LTnd7D5fH7Hv7aVQrc4wvr
         JIH75WOQ/Ikf6PFN6a2x2RIO+f2oxFWvzCZ30xiVibCSbaiY2BVsKx1Q1AljcjBN6FJz
         YlMZ+c6qCZ2ywqCrRq3ss4N2JZFuoggfBFa0JsiNcSWS03FVlqLUr+kivxxQ6zTp/+lh
         IXlOTzu1o6hDdt+639xBeCskK4q7+uN2vPzvxyHalF5boQauRqiqcG79vyDsq42uMJhe
         2MfLhTVqJP7nce/wY5Q1/jlcjYn8THqaZqUfXaLJclvENgE8hjxuioWRUio/otbpDM/p
         qHxA==
X-Forwarded-Encrypted: i=1; AJvYcCVKAfe8+XioHt11Ta9VZak0uJuKEDOY6Y3lA9xadSVmuh6va8pXxVhe9/N0YR1jWA/dDLh8luALL9Fg/8WYOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRf381YqDG4rmlcGN7r7y1hHuqn230SOy8IkY3fA1LBBA9AB4D
	QqD8PnUxOIfs9VCFQdt8MSXaQmCgDnvDqUmBGq0XVPeCHfi92bef+389CbPEFXyBJQOY0eQ2g6P
	GQE7gUe+meobVC0yMInGRFj+/UyL7OYzgOiHurVnbhoY5wvuNTi8Y3HqQ4KCU7SZo4naL
X-Gm-Gg: ASbGncvyluDZ3VDEwlmSKUX2dicuZ/APFS1u9IGEIrEM+UeApiuICze91A8Sb/gt2XI
	LhnrLSFcUgJXVa4uJUg1yguEi1pI/5BqGHm/SpSebD4MXw1e+XAGqIQGetfYd7JwOoIUmA7IWVZ
	H4w4iDOzpe4cLCuneFt+Bf+kVVOoJo5PatWbf8czTgYuVj1Dps+K/Pr4om9r+SBLfa8g6UaCdeJ
	1wgVrAHxpZb756nlxdUgx4aw2uGuPlLtU4jnt6EHfrLeSg1cbbLv83igwQfAaFZWwKCcCZ+CctN
	yS0rYoaJL4kpik8auBXOod7Pc1VkQcNunUCZARzLY8zh3RMvU90y8vtJcyUEA+Y0vjvVADS+EBX
	NhP3y/kMVuJFfwndFyn5v/CPTMfV40g==
X-Received: by 2002:a05:600c:1c16:b0:477:95a0:fe95 with SMTP id 5b1f17b1804b1-477b8a90b69mr5239615e9.24.1763583756399;
        Wed, 19 Nov 2025 12:22:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv7OY/eeh/eaCRC0mGOzH9PPH/EZSDaI5JiPGJFpcL+zSbxL7SPGpS4v2uWECCiGLjI0pkxw==
X-Received: by 2002:a05:600c:1c16:b0:477:95a0:fe95 with SMTP id 5b1f17b1804b1-477b8a90b69mr5239305e9.24.1763583755891;
        Wed, 19 Nov 2025 12:22:35 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a96aed1esm50247745e9.0.2025.11.19.12.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 12:22:35 -0800 (PST)
Date: Wed, 19 Nov 2025 15:22:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 00/12] virtio_net: Add ethtool flow rules
 support
Message-ID: <20251119152206-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251119191524.4572-1-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jOjzA1rCberYyR7GVQ0MEPh8uAkPFJOHAYnCSSarYYo_1763583756
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:15:11PM -0600, Daniel Jurgens wrote:
> This series implements ethtool flow rules support for virtio_net using the
> virtio flow filter (FF) specification. The implementation allows users to
> configure packet filtering rules through ethtool commands, directing
> packets to specific receive queues, or dropping them based on various
> header fields.

traveling, will review after tuesday. thanks!

