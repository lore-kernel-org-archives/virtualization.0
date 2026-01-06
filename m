Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C2334C04
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711119; cv=none; b=dGar/ql/YIMua2tOIIg3FsFvffAv6oZhR96vD/SyhUXTp4Je8bgSBRQF3btt7VmdEOmDlg//BgstVN2cFATE2Mfsd6gBUKXBQu5fQdpJNiTVTKM1feJS6QMNzFitxNlZ+sfLDI3ydwHeHuh8SEl6Kjl9K2S8KWTZkatGHimd2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711119; c=relaxed/simple;
	bh=OtGN4S8+ZWGuAfn6+2YZp7eQlkz7c6TNLgozVUvUCR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TR41pXA9vMZXbHqvzfUKQee85gZwm0iPt104fy4hzgfU22AkCEm7LYkbseBZA287/7U4Y6SrL1SK9XY8WuQA8aVh8LSjcUNziX6OnbwEhqRX2gl/a9elAegXB9WeLFIEe+bAoDIADsoeWYP4b2Mr9klSl/sUxbNKn8sn7EKGpwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BL/teLkI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BL/teLkI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767711116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v8xGpc9e0AHSzqXJdY4dTy2UmvNhNHIufeUOIUm/LzQ=;
	b=BL/teLkIPThhL9jHSrLxfnXBDAY94IA+4vZjWBnQV3yo45uDf/RAL3O+P6o/grWXBJUjBy
	kSdVyRT+DYU1jyL9Eh3w4KbjJ22QUBmyP4Qj/RE/9lA4/4ta+qMswvZeeitZXTT4Xgm/pF
	VPPkgscRwkHWKhiljX3vgwBG56z+dwE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-UR7UtxEJOA6mDfdy0UTuSg-1; Tue, 06 Jan 2026 09:51:53 -0500
X-MC-Unique: UR7UtxEJOA6mDfdy0UTuSg-1
X-Mimecast-MFC-AGG-ID: UR7UtxEJOA6mDfdy0UTuSg_1767711112
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430f4609e80so488361f8f.3
        for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 06:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711112; x=1768315912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8xGpc9e0AHSzqXJdY4dTy2UmvNhNHIufeUOIUm/LzQ=;
        b=qYYgca7P86FY72NPcy9HfLfjxIlrzjmu2t9s235QLlZPRTo7fP94XMeta9U53dYORr
         NToSzMzg7tCuBqIcTDLCal0wXwieeDxOGjZCbozsYGdiXZgMk+aB570+gnLj8KJ2PX0c
         kM2fR4UpSO68OLiMDbdgl3/9o/PwH5RsPcoYO9gmSknug8e0yowbmzQDBt28Pu6nFWbO
         R7BvYfoapHxqvCp32Bu945m7T76bXuyVFymOusSMSoiukBv3122q9bN0fv2c3T6AMt4D
         +cy8AL7gTSDLACo31cCtchArEl4IF8OP32L4Zwdm/lEkyAvXo33vDf1JtzbMTbz+dAp3
         1KCA==
X-Forwarded-Encrypted: i=1; AJvYcCWNSsBEicvfRMyDFsTvZ5kN7Q/iil1yoOBNZN1GpvNDbb42lt2QChCGCvB8O+Ut8jHsDYbTqXchFntn9VW93A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+WMHlvieHrug17Tu+btfX8Ae3cpZm1v73EN44Y5mijHLD4ydZ
	UEeQXdlhvc0ADvXYy25Q4XPIq/4LzDH+xEqNNEOztDUYgHGw2SM2dUYCvBBHngilQxay6himwLB
	0J09QYVeMmUSOXICUzEocK8WqM72RcuV1RpThZyLJQzxjIUxbN9l6dti+6Yvud2AQvxsP
X-Gm-Gg: AY/fxX5IkCOQaN0DJ/Co/m2dySHBtb00Df/PBxPwsJrblbQsjpPekaJopNAnOR8UhJA
	kUBwTAWXTwK4sZ3kVjvjVynU6g0/M7MfXPVXPV6wx1uwXO6K0iheu5NLYC8d2qdo3CgTorlnvdt
	ehKGBa8UUCivT0PoBxJLcgZi0AHI/huIk5GHfV6uxhE14jeXE1VVMF39KPh1A1vGrmW7EEk3XGI
	mSUu/SriVwce09WraoB7EJUjQt9qK8NX6wh0iBmqV1kjblY1aAthYW1Usn7/0J5+wnzZiPviSaR
	oL5G/q2czs431dsYm3j8c2dtNwkFOpZ0GHxnP6ZTuHxZz1TTuO05VAKP8K2Oiiw8KxydMFACGOM
	iQ7VcKllGoejUD5TTP2KqwymAbWpB/302lA==
X-Received: by 2002:a05:6000:200f:b0:431:b6e:8be3 with SMTP id ffacd0b85a97d-432bc9f6dccmr4753203f8f.38.1767711112123;
        Tue, 06 Jan 2026 06:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOynDA9QP29UwN/sUhG6OCzOdNXrD0Y6rHdaimQHcJZW2G3EKin+vfxrhBk6BDORYTgSmwkg==
X-Received: by 2002:a05:6000:200f:b0:431:b6e:8be3 with SMTP id ffacd0b85a97d-432bc9f6dccmr4753140f8f.38.1767711111656;
        Tue, 06 Jan 2026 06:51:51 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ede7esm4752453f8f.32.2026.01.06.06.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 06:51:51 -0800 (PST)
Date: Tue, 6 Jan 2026 09:51:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 10/15] virtio_scsi: fix DMA cacheline issues for events
Message-ID: <20260106095044-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
 <8801aeef7576a155299f19b6887682dd3a272aba.1767601130.git.mst@redhat.com>
 <20260105181939.GA59391@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260105181939.GA59391@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6ScovXHQ7yQ5GZt3SSThkS51DzJ-1ipSWN6bAHkdyCw_1767711112
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2026 at 01:19:39PM -0500, Stefan Hajnoczi wrote:
> On Mon, Jan 05, 2026 at 03:23:29AM -0500, Michael S. Tsirkin wrote:
> > @@ -61,7 +62,7 @@ struct virtio_scsi_cmd {
> >  
> >  struct virtio_scsi_event_node {
> >  	struct virtio_scsi *vscsi;
> > -	struct virtio_scsi_event event;
> > +	struct virtio_scsi_event *event;
> >  	struct work_struct work;
> >  };
> >  
> > @@ -89,6 +90,11 @@ struct virtio_scsi {
> >  
> >  	struct virtio_scsi_vq ctrl_vq;
> >  	struct virtio_scsi_vq event_vq;
> > +
> > +	__dma_from_device_group_begin();
> > +	struct virtio_scsi_event events[VIRTIO_SCSI_EVENT_LEN];
> > +	__dma_from_device_group_end();
> 
> If the device emits two events in rapid succession, could the CPU see
> stale data for the second event because it already holds the cache line
> for reading the first event?
> 
> In other words, it's not obvious to me that the DMA warnings are indeed
> spurious and should be silenced here.
> 
> It seems safer and simpler to align and pad the struct virtio_scsi_event
> field in struct virtio_scsi_event_node rather than packing these structs
> into a single array here they might share cache lines.
> 
> Stefan



To add to what I wrote, that's a lot of overhead: 8 * 128 - about 1K on
some platforms, and these happen to be low end ones.

-- 
MST

