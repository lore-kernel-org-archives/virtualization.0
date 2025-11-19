Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BF337BBF
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543707; cv=none; b=D7NOvEhJcx3MIb4j2OaLdxJm2CeSvH09e+kzizBacm8s3MtRqnj7pBU/cXvyWPubyQDvq4KR2r8qD+BvM8sTbP0CRLq7Wtkv2gCJ20PNedIXtfHDaeZreHRIFJqPrtoN+9YpTblUepHt3zpStAXfNj8JQKxAEKXeGEq1UgogI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543707; c=relaxed/simple;
	bh=vCiayDyXQMeSWQnZ0u5xg0l7ULoxebZX0NUwkzYWlSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IJmruQSfkypJuTHyZIqtdQFJikrw+3G7r/q2b6dqUDMMgwL29lestRA1N9tJFrb3Tr5I3eEcXIwTyOb2kkMCdYddRanon26fhb+aVLP3Kz05Yrn9OZGaK1AqYnaB/k1Sm3vSgJvV8hMR3Z3xPd/boK5MEXAesZ3HABWiAa2CY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cIZmBk3C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIZmBk3C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763543704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+iRB2oBivDIJuDbosHNcX/b7vuh1IFrDOEjoVs0d5Q=;
	b=cIZmBk3ChN1My7WoHTQD5b/BMVCCpaJyKeqEbB+lnCd9xl21ndx34GabsXvQxbYbA4yzwi
	1R0PeF/a5de+1p++q1njWVPWmrBjrthZWM8V6OQuIpudNkKdVwNqjBonPNGZVcinlFdlXr
	g7xVPi3ZAwGrllbQQaOiPB3cbo8qKt8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-t5Q_kyS7OQC0q1IrHtpkJw-1; Wed, 19 Nov 2025 04:15:03 -0500
X-MC-Unique: t5Q_kyS7OQC0q1IrHtpkJw-1
X-Mimecast-MFC-AGG-ID: t5Q_kyS7OQC0q1IrHtpkJw_1763543702
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b56125e77so3280903f8f.3
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 01:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763543702; x=1764148502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+iRB2oBivDIJuDbosHNcX/b7vuh1IFrDOEjoVs0d5Q=;
        b=EIyunc5ja5n9hucfDOrRwoj56ltlUmDW6jEs1JjnLKqju0RhEn7NohasKHcA29Js7Y
         cStupmCcIo8YzEHvmiOBYXcAxwloyJ2/PlbOTuzkfULBmMOGoEiiIAk48WR0mTT5Ycni
         OH7frBq053R41mPEKJBAg5MNUQ4SpMU2FqYHoPWr2erXlddfP57ZpvMyVXtAoZNLWguc
         e/g0ePlkhFekInwWGUZvJhIr0N/4eBiqByYdxuxR69k0jpOcVBRzJtgJe1mYVCB+Fwhr
         qD0R6EX4AUMGPZofIbuisEtLJW0GD4dkRsFreYvK6X/iZTM5SzB9JQD+OoI8hK+8fQIO
         WCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN4cBDd2f3gcfVrJEud0oyfsJy32FMHY6JRMj7uT70vp/S8jfxVjuWlwoSvkW0BqhQR5zOGwrbqoRagLyOOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOMb7OUA1Bud1jAMUiMaEdehJqvr2qpe74PQ/YA1kHrsnG04uv
	kBmUmC9InbVxrgCSnsvfgpPhEdXr9ZTVvSVP71w6FgcO7m+W0BkAvk8n82czvq/OjJKRTOXXowY
	Hl8ItfczC+zFuTZgMYRgJcwX4BM4ZlYBQ2KUquHsp6h42tYTDQ2k9Hv4KRWVOpVnPWdFR
X-Gm-Gg: ASbGncvAQ+El5iQNdV4Ud+aVpk6cBfC58L1T8rBPkO0LSAUj7xhmPucdE+5yaBl2JFr
	cAppd2J2M7xAc72MlQ+oMvSDj8RFAXQvIx5WeZlxtzXq2S9ebg7M/JL10oCVF+E37hyCJnWkXj5
	vfC6NQe0NM+He9Tj9QGgOvfOFFnroxr73pzq/LXtjA25wOXVnmucMZ9+vn8d+dc5vgJAfZ9/DdN
	Os6eB3xdm+Z4kbE07iiiRSYQilSx2LjYGcfB1sweHlGt7cueH3tmliRkyuhhimxTGOoJdzK57O9
	KIVbD5h5p00jA2OnvT4Mvs4eOZY3cdeNtYuW7qs9rLxOJp8uD92Fl1HC0YAPSe0l6E8w39DsOwi
	KzdIm3Mq3nwR9cs9Rn4kPOjynmKSG/w==
X-Received: by 2002:a05:6000:1849:b0:429:f14a:9807 with SMTP id ffacd0b85a97d-42b5938aac0mr18791029f8f.40.1763543701705;
        Wed, 19 Nov 2025 01:15:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpSphKmrAY6KUvFodAB5O56XHMrPtkTG1jHwTLKCUo+5xF8M9q56JIE1Dwzj482I2IEdQ3tQ==
X-Received: by 2002:a05:6000:1849:b0:429:f14a:9807 with SMTP id ffacd0b85a97d-42b5938aac0mr18790983f8f.40.1763543701242;
        Wed, 19 Nov 2025 01:15:01 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae88sm36177558f8f.6.2025.11.19.01.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:15:00 -0800 (PST)
Date: Wed, 19 Nov 2025 04:14:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
Message-ID: <20251119040931-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-12-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118143903.958844-12-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 20lz6L0tv5RDFh18x3sLRQJgWIiQAkYy8oCzZwwSgBc_1763543702
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 08:39:01AM -0600, Daniel Jurgens wrote:
> @@ -7167,6 +7261,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
>  	case ETHER_FLOW:
>  	case IP_USER_FLOW:
>  	case IPV6_USER_FLOW:
> +	case TCP_V4_FLOW:
> +	case TCP_V6_FLOW:
> +	case UDP_V4_FLOW:
> +	case UDP_V6_FLOW:
>  		return true;
>  	}
>  

it kinda looks like you are sending flow control rules to
the device ignoring what it reported as supported through
VIRTIO_NET_FF_SELECTOR_CAP

Is that right?

The spec does not say what happens in such a case.

Parav what is your take? is the implication that driver
must only send supported rules?

-- 
MST

