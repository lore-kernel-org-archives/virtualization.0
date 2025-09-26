Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007721A3A80
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896807; cv=none; b=KT4TLLkLX/ST6GvoT1KyEreRkX/zD2jZStazu8Q3akvMuyot/k8YYYK3AJ1Bxxd83B/Oauj4l+xMTd2xgqPkshyF1141BPFZQ+Qjl7hj7cP0rik1cVsrFjvDRWSUEEmIGukWGLCx9P/lEeAGJLyPzo/dWT8djJ/UMlMa40qMxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896807; c=relaxed/simple;
	bh=d6I6D4UoA2fdvHaowOZB0/hBshkYl4/Hv4eNcR8VvOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qdLVNF0lnr7HalP1+prJ1eDfQyWg5UedzvmTRAhmdm00RcEfG7NnuCBX0w/4Fq4mR7C6w155DGXlqkZ9snM5fqUgoxdxKpS/w/pxO+KCvSFuliZRkLmjhdnBc6UYVfLqZXAtVvuidafrXdP6uLRmpRJH3Yup7IxQFTtpvdTtRwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EW27avN4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW27avN4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758896804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iatcngeh1af6TFJNiZJ9BJOYb6Kr+OAIH3TZvj018HE=;
	b=EW27avN4bAKTulEnslgymjXemCP4BlRbooel/sR6Ms8C0+Ix3j4j3qjTCoyUzdX2jI7fge
	kWiTO2M4jki4Rq5o9TEk3ACbZAEsBEPL1aCUTLKkP7wv6h5FeE+GnRmAoYoD4vQWooqsSz
	QpaKZ+74Lej5u0KpNSHciTjaKNzZJbA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-QSk44jV3NWm4DDaZqHusZg-1; Fri, 26 Sep 2025 10:26:43 -0400
X-MC-Unique: QSk44jV3NWm4DDaZqHusZg-1
X-Mimecast-MFC-AGG-ID: QSk44jV3NWm4DDaZqHusZg_1758896802
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso1615390f8f.1
        for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 07:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896802; x=1759501602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iatcngeh1af6TFJNiZJ9BJOYb6Kr+OAIH3TZvj018HE=;
        b=N2JP+riOZT1K6o+RSLqYMDRCEOwjjXCEG1Itnl/sRz0WO9vD+aq1a5cnSVljx7hC10
         nneA6MLIdA8GjAtYCb8X0Li4AGimteqq0J+FDhju8vBtORrHvcHUOVUU4kgAtU87Hiv+
         5UOlwSuTpMAKmvQrq37WmMwMCx7tkqsxxoxCtzFqwlkp47ke1pqtLBl4CMs+BeXNMvgA
         m5Rl26kEgFQdPkhKgiw3ai/6kwoDtUKOopKWkkj5u+nI8oTEH+p0pKyNDKyTd2FDCS7H
         4ixALh7nwCsAEv7VVfEb9d3GEkDV38PqL80OKyt9Yl4VcphkA26uvJzizrXFu5t5trUO
         99GA==
X-Forwarded-Encrypted: i=1; AJvYcCVD5paiqpwTsXCO5RTZONnGBixKwtvZy6rnKZbUfrDNGNo5pU+JAy43JZ/WIJ+LCu02nprgjbPwLtOUiWhuSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTYNrpMHLqosr2MN/sRG7tkLgmQf29bgfqdFudUzKDjvJ9xfZF
	PtjnK8OJGBd99HqEhIF7lBhKNeiiYQlAtPbjTCneQseI1+LoWhoeXKw5euG429l+obw2F+TzG0k
	ijaWkrEVAvN6EH7eKWjiqVzabf7nTcp6N4u3D97q10TXQZvsdVyb4t7mGSK7aHoQHviRs
X-Gm-Gg: ASbGnctf1esAUt6Ido6CJRDNkCztTzls18feCDP10QjPGt4p3fDruh9n16Eb6MlhI//
	0mxgSWoG0EUTUeU3+B4Q8sEaok88+mNHpXhUYBLsGreNsKCsNNia/yxiXWbT24WwRVK3exDK2oH
	nYWkt/L4hrBSD2VydX9AmeA+10L5BpypM5cHO0mlQZpkq4iX2xZPS5CZVfQsLQVtF3L24HTYIPn
	o4lqPU99PpRPzkRBaH7r1RiOKSO5cUn+YzRev/PpzNwmSBnAs4869zaHYRq4doLy9jGuJSIrMhU
	WtrBNI3Qw9EKhT9fjmHkRJOdOk2Wcf0dIDo=
X-Received: by 2002:a05:6000:22c7:b0:3ec:e276:f3d5 with SMTP id ffacd0b85a97d-40e48a56cddmr7464920f8f.42.1758896801815;
        Fri, 26 Sep 2025 07:26:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWQlwY9F5xZyQ8nyaSheZAwSNVELpvaScMCCct/EGl6ilha7T/oo9BNopzjhdDydTGuXSdgQ==
X-Received: by 2002:a05:6000:22c7:b0:3ec:e276:f3d5 with SMTP id ffacd0b85a97d-40e48a56cddmr7464874f8f.42.1758896801163;
        Fri, 26 Sep 2025 07:26:41 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602efdsm7576564f8f.34.2025.09.26.07.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:26:40 -0700 (PDT)
Date: Fri, 26 Sep 2025 10:26:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	alex.williamson@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250926023237-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
 <20250924021637-mutt-send-email-mst@kernel.org>
 <CACGkMEuWRUANBCkeE5r+7+wob3nr-Mrnce_kLRHbpeF0OT_45Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuWRUANBCkeE5r+7+wob3nr-Mrnce_kLRHbpeF0OT_45Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h8UuTUaxD-oTGrwIdC2XaMt9HsiYHDNEQjsP7tPc7hw_1758896802
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 26, 2025 at 12:55:11PM +0800, Jason Wang wrote:
> > > Looking at this, it's nothing admin virtqueue specific, I wonder why
> > > it is not part of virtio_config_ops.
> > >
> > > Thanks
> >
> > cap things are admin commands. But what I do not get is why they
> > need to be callbacks.
> >
> > The only thing about admin commands that is pci specific is finding
> > the admin vq.
> 
> I think we had a discussion to decide to separate admin commands from
> the admin vq.
> 
> Thanks

If what you are saying is that core should expose APIs to
submit admin commands, not to access admin vq, I think I agree.

-- 
MST

