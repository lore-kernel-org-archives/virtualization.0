Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03F1F8AF6
	for <virtualization@lists.linux.dev>; Wed,  8 Jan 2025 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337766; cv=none; b=XL3t4jEPQD2pzVT3blRBwzDvDthaeF/oJ1GSgxZ8p09F7/5fr/alV6L2V7nOKqagIHnKdf7qC7Tl23SEx/xQadwqY93QknHj23bh953lgSbPTJgKpjUPitYN1Sf5zjX0GAMlIR0Ka8C5SP77JRuQ+EWo1sRfpgj6VbqSd3MuygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337766; c=relaxed/simple;
	bh=IRcFUEnTe1JCKcKtnWX/qLTSGUTw9/fWw8tLCIvzbDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M+xx0ZrsWyHNyY+uNPby+MX8zZ+j22Lcxc73JxFRDeCsa5Yq26DkerorncZiul2rrA+AlqonOVTXe6pYR0hMHuylzQhbciXYIJ1KRnKwgOtWB00ezVo02N06b7HUry4l+BsDmKTPG4qq/4zXCcqmv1SlV9yb9cwU1xuVNBN2+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sk+Uad1A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sk+Uad1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736337763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLqYtIizfpzeEDN0YbG2hxxynEcPRAfxOqYGH5kCnXM=;
	b=Sk+Uad1Ah2VMPsZv4LFhZ8hw+w5okJmIP/bZC3SyJAmg93jf5Cq2z1u21LwpIJdIMgfP6H
	vv6qaB8zVtho9MgSsv1YYhymiEmWHOwfsVh9rjc0RqZwgAaSe3SVUUY1JR5oEIbwmuUx/K
	0433WM97l/pSA2E3scgFjzDUznyQZlk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-OFvLFfFzOEKI3gTPPgvq9g-1; Wed, 08 Jan 2025 07:02:40 -0500
X-MC-Unique: OFvLFfFzOEKI3gTPPgvq9g-1
X-Mimecast-MFC-AGG-ID: OFvLFfFzOEKI3gTPPgvq9g
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361f371908so112879495e9.0
        for <virtualization@lists.linux.dev>; Wed, 08 Jan 2025 04:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736337759; x=1736942559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLqYtIizfpzeEDN0YbG2hxxynEcPRAfxOqYGH5kCnXM=;
        b=vOgvrFLEaTuJAglh2pzsYCM4DBAhsfOiaW0EGiPVJShmvuJAJ+b0BhgAojVreAQblA
         pRH6YaTDIVxBYUGMFV/HTVVI7akjzpYLbBCNCJGdv1EtmHvVV/IGqkQ98k5L6VETeyYD
         C1BIWPNFVD9JrgYvexJqyjAHRitXbDWWhxZWM0FLKoUag+DWBGLE4hQbed6jUynxUQIJ
         QD1orWMoapZqhOyPejFRSQ/luTcluLOAgiDAxzC4WJPOZpwB/ZA+aEnzsGLOmwDvdkwZ
         LYDRfbrNvyFBSpy9oFRpYlTldP3/us9+tGtGo9+CFdUynsciC/o0It2aAR82qG5EO/Bu
         TOEg==
X-Forwarded-Encrypted: i=1; AJvYcCVDvClsazjRrf5x8yBDFDa618k1EcGIDN29Pm/sEBr5rNzAz5YPwkoCNFqeoZKFvE4K7N7iARU0UOR6X13YnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXGN1BoArsscTRtUW4gQBLYShlaPfksoPnZT8qGkwpaEI7X3s0
	Nubqr1kn3wnrxsRNxOjeEgNlf2LumwQrNlC2G0DNYLFVqaKnk7SUEHUdvJf+VHJCroTCDd6ayt5
	TafdCG74RICmAr2wKRGQNUMgNrf2YU3PnRfIehZWokVc9fzpgJjYeWVWmxz4C3nkg
X-Gm-Gg: ASbGnctweNVuW827F/iJdIJu+S1GqF450NqNC0wybnGnTrDka+JrAm6axeIp713NU6n
	sVq3aOuPqoUWGFOFRxHOA2ejPG91bwRRJjf58LQ5xXlRAE7BGS04ydemDOUe2s5tcLgy4C+y2b7
	DxQS/LPxVT0s5WDj9TpGqoplZkiidK5jj1fMsc/AeXrmyj/d2nwgUycBTKfWN/s2diI84oQ4iMY
	6YboHQ8VFNLqUu1z4Ov4xkncw2kSVX8Q1h6xs0VDn71yOOA5SI=
X-Received: by 2002:a05:600c:46ce:b0:436:6ddf:7a27 with SMTP id 5b1f17b1804b1-436e27072a7mr17628595e9.23.1736337759391;
        Wed, 08 Jan 2025 04:02:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGScykllzbh31utZyOyhyPCeqeJOHfUUx2k3Z8hq3BxWlAiscDN3qnY2p23jYlKYf6YnAI+gQ==
X-Received: by 2002:a05:600c:46ce:b0:436:6ddf:7a27 with SMTP id 5b1f17b1804b1-436e27072a7mr17628305e9.23.1736337758928;
        Wed, 08 Jan 2025 04:02:38 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddcf38sm18472675e9.20.2025.01.08.04.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:02:38 -0800 (PST)
Date: Wed, 8 Jan 2025 07:02:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Yuxue Liu yuxue.liu@jaguarmicro.com" <yuxue.liu@jaguarmicro.com>
Cc: jasowang@redhat.com, lkp@intel.com, angus.chen@jaguarmicro.com,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, oe-kbuild-all@lists.linux.dev,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] vdpa/vp_vdpa: implement kick_vq_with_data callback
Message-ID: <20250108070206-mutt-send-email-mst@kernel.org>
References: <CACGkMEvf9TS6c9PTiwWn3POr33m7m1shNfHOkviZpk-Pkbf79Q@mail.gmail.com>
 <20241203023743.1757-1-yuxue.liu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241203023743.1757-1-yuxue.liu@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W2Ck3KzK5gIbCRI_JCBPzvmT7FisTse7m0U9Q3tV2Pg_1736337759
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2024 at 10:37:43AM +0800, Yuxue Liu yuxue.liu@jaguarmicro.com wrote:
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> 
> Implement the kick_vq_with_data vDPA callback.
> On kick, we pass the next available data to the hardware by writing it in
> the kick offset.
> 
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>

Pls do not send v2 as reply to v1.
I am not sure all tools test the patch if you do.

> ---
> v2: fix build error for kernel test robot
> 
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 16380764275e..8787407f75b0 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -367,6 +367,14 @@ static void vp_vdpa_kick_vq(struct vdpa_device *vdpa, u16 qid)
>  	vp_iowrite16(qid, vp_vdpa->vring[qid].notify);
>  }
>  
> +static void vp_vdpa_kick_vq_with_data(struct vdpa_device *vdpa, u32 data)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +	u16 qid = data & 0xFFFF;
> +
> +	vp_iowrite32(data, vp_vdpa->vring[qid].notify);
> +}
> +
>  static u32 vp_vdpa_get_generation(struct vdpa_device *vdpa)
>  {
>  	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
> @@ -472,6 +480,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
>  	.get_vq_size	= vp_vdpa_get_vq_size,
>  	.set_vq_address	= vp_vdpa_set_vq_address,
>  	.kick_vq	= vp_vdpa_kick_vq,
> +	.kick_vq_with_data      = vp_vdpa_kick_vq_with_data,
>  	.get_generation	= vp_vdpa_get_generation,
>  	.get_device_id	= vp_vdpa_get_device_id,
>  	.get_vendor_id	= vp_vdpa_get_vendor_id,
> -- 
> 2.34.1

