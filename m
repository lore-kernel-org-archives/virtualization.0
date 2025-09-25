Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ECE2D0606
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835385; cv=none; b=FCb3PSeNpzIWUI4XUYwdm0wvX4CXyq+1RJAMcid/4dC2FkfTE8Ddv4F/cikwUrlEAwzO5qmQZlYn7eY7iDds8sF1Su1is0+BZA/FwGqoiLUy1dfmggoPBAWOTKXgVPth5ublgkJtr+ac1zUSdJ8A0Yv1T7EQ4ykb+NLVNi97rU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835385; c=relaxed/simple;
	bh=F/lfsdyoROFd5M36/k6KcRcPVp6aiZdeNYsR5rM8xTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l4yuc9IaU0lNrD+awy/FPw0ACudaeToHy5NIb/CJXDtkAD6OwKwk6NWrvBoKZpOnq2thIqmGDwTA7mEwg6pl1h1vfa4O1aeVmLyau08npdYcJKFt/OPvEB++R6q8fPbOkqd8+Y8/c/VW9T+14Is5ZAWpNqx6IP8hog8eMveN0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YI69HErp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YI69HErp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758835382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=88zoVV1aX2IdFwOgFrkT9f/SnpSpDG0hDuK9RJ1HXEA=;
	b=YI69HErpoMZUe9EzlGFsbVkw7I3aUg64Wh5imBE4Mn2BOc4ilJX7SoGUgUhz2HdTgBoIHG
	tlp+U9gHtp05saRPI0VGOtHkc1QHv+Ucf64SxpOQJi31UEN4m0/6mTi+ebsoPXpRUBs2d8
	CYwoWfsomeLp/8kqHE4Uc/4MRjmC8s8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-VmU4_YbvMtalWAeVgiKqNw-1; Thu, 25 Sep 2025 17:20:54 -0400
X-MC-Unique: VmU4_YbvMtalWAeVgiKqNw-1
X-Mimecast-MFC-AGG-ID: VmU4_YbvMtalWAeVgiKqNw_1758835254
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ece14b9231so965338f8f.0
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 14:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835253; x=1759440053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88zoVV1aX2IdFwOgFrkT9f/SnpSpDG0hDuK9RJ1HXEA=;
        b=bpCetfCnmiRrCD78/oaIRF4xSExyRzqK/uD/sITm6j983Yd0jHCM+/maz2Q/NGksr4
         GrO/jYXV0VvsR2kRCJ+Tr6UwkHVbyBq4pGNZUGgqQVKABnlTjQR4dc38A/ISWoTjcHZ2
         ljG4jfub3QP4KGBo0daDvwqYzHVaIUZ6yAjqX1MbOGasOME/h/ZPTKKlMskk1M3bNAUd
         lS3GiwumKS30E1blzparlEIzNyiQxXUsITT4qmRvCynhbhQfZaVCwFmoONNR9umngqy9
         nojjwayocNlhKG7UaEaXmIEuApePzI25KBF4sJo1QW+EtWnUyuKwucLpO1yJsu1LBK9T
         Rf/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4Y+9G2rYjXbjoRoqPEvxOQYhIRU1ukKDjp0Cd+L2tNvks6A9OuDSdm42rJEotxoP36JeQqCjVC97OOmj42g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnLeIwxrb2kaRkM/wfcTrpy5GAuMLH33+0TetuDA/hNO2XJEmX
	V1I2K5fdao5WRLs/Yrf28OSIpGg/F8lXV4SD7i9OLf6nVRml6b+axi0zVDQRXHK4QXQLiEnUEyQ
	7zTXJJDf6f+TBupCDWQEboEcGmjwgwhVVRJIWAtgztfl/eRO65Guu9P0yCkJldT8JqqYC
X-Gm-Gg: ASbGncu69G+Nn2S4bxsg3tQPUlgaH/YrJ2vhdZyH7kXnMW1b+qceXOFzhLnCIsGuH5i
	bgxvGpPaQXNzaw9P6b0x8eT2R2Vxft3mMoZ5WEEKEUD5FyTcCmZRoeG6LvURBs7x1xtlN5pabSB
	P4dk60Qdk2WSyzrvEtWXsZzfVhLBMUavwB01dYD5qyidq2nAwXgF0a/TVq0OU8yqImgS3D5sKcp
	pgwc24lxuItVMr35EDQuRSG1rAIYuhdJmnXhV/qbNcNanooKZaqlJCBesf0BdzaoqlYs/7GsH+t
	1xdRsbG/zh1XTz8fcVwvY/ACBpcy2l6mLQ==
X-Received: by 2002:a05:6000:615:b0:3f3:c137:680e with SMTP id ffacd0b85a97d-40e4ff19927mr4506715f8f.43.1758835253632;
        Thu, 25 Sep 2025 14:20:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgh5VC5yyfre4nkWgfsZ9zqcVRyYQ/TYsZXlD8u6iZ2B2i5N6PHpkQew+jpERiYfdRNBV7AA==
X-Received: by 2002:a05:6000:615:b0:3f3:c137:680e with SMTP id ffacd0b85a97d-40e4ff19927mr4506699f8f.43.1758835253277;
        Thu, 25 Sep 2025 14:20:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33be359dsm46129065e9.13.2025.09.25.14.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:20:52 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:20:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 08/11] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20250925171936-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-9-danielj@nvidia.com>
 <20250925164807-mutt-send-email-mst@kernel.org>
 <5518ba7f-80b4-43f1-a5c1-eb8298170e9a@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5518ba7f-80b4-43f1-a5c1-eb8298170e9a@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cjyq44TbZcacwhyPKlg12RQ8PvtI6AhuJi7AF6tRReY_1758835254
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2025 at 04:13:42PM -0500, Dan Jurgens wrote:
> On 9/25/25 3:53 PM, Michael S. Tsirkin wrote:
> > On Tue, Sep 23, 2025 at 09:19:17AM -0500, Daniel Jurgens wrote:
> >> Add support for IP_USER type rules from ethtool.
> >>
> >> +static
> >> +struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
> >> +{
> >> +	void *nextsel;
> >> +
> >> +	nextsel = (u8 *)sel + sizeof(struct virtio_net_ff_selector) +
> >> +		  sel->length;
> > 
> > you do not need this variable. and cast to void* looks cleaner imho.
> 
> It's cast to u8* so we do pointer arithmetic in bytes, which is not
> standard C on void*. GCC doesn't mind, but I thing Clang does.
> 
> I saw you had a similar comment on a subsequent too.>

it's a known C standard bug.

kernel does void* math everywhere.

Linus hath spoken on this ;)


> >> +
> >> +	return nextsel;
> >> +}
> >> +
> 

