Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7043C337B8B
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543934; cv=none; b=AgJJcIFYqt0lvOXmnVR9mnJl+iP1L689yqFAy0YXDSiboODB49E+cKiJy02sfzgBMcwzcEvrt149j0RW62m1B48RJIGqzW8hhjXgJeLyzOr6G3oB7nDoWtzLgymoxkQUMg+Np/HTjMJOOIZAEIW0SQa3sVsScvYFgTiJWtH94D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543934; c=relaxed/simple;
	bh=eD8SrHrMaadYG50GIhGP1OcsE+eBdPe4buzRGFAm4Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mpO2TV4UyFZi1cPL191aYiUHlVNSYhBc3bWFguvLXITf8aegt55pfqvlPJoutdAD1D5nXFFWtZXYf/acQd762btLAQEZx59XsYWOMSS70idbuZWGaBKew7+QxprK4DwkcKQyLODhnmyl3FHxZiRahqcSs44c3h1rwHwx18Tizzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aFDnPUNM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFDnPUNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763543931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykiTizCFtTIndhsPVLB6d9JwBV5HvA0v8sThcwbCDCw=;
	b=aFDnPUNM2eJGO6WPvM182ypJ0DvGSOs79ItsblV5P7kdzo+wYq0fwqMDO2yr8n0e2GnU88
	OQkQ9WJ6NnHsLT1ikNEk0NtzWm8L9dEaHbaJVYPbsRsSmXvwlbWisPfP/MkR3f2zMe/EKj
	8OQ2Gs4zLAkg4ID+GsNkwQCpJ69mbos=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-Wph04L__NduZmTAcE9Oijg-1; Wed, 19 Nov 2025 04:18:48 -0500
X-MC-Unique: Wph04L__NduZmTAcE9Oijg-1
X-Mimecast-MFC-AGG-ID: Wph04L__NduZmTAcE9Oijg_1763543927
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775fcf67d8so43518145e9.0
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 01:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763543927; x=1764148727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykiTizCFtTIndhsPVLB6d9JwBV5HvA0v8sThcwbCDCw=;
        b=ideMHdiV7ke1EoDMHn9xmjyoQ58hVPpq4DhY/vkBkkHzYvth0pwVmNncyzEUtvU+yk
         mrxO8FUS2qBhOYNxxjCAS7LtXT/wfv17Se8yOh/9XvO6MFkDC5D6VtJK4TNKme2Wa1ip
         ye6J5NaOfEake0cOJbN1rF5y3pkeG6HwbYz+tkjumj+2RdZDonkJdmYQVB4Jks+3G70X
         yTzAqOv/NzzydGOVADx7new2m+37+dfBsOZm+FEgWlyLQtVrfl9gfOFqbnSNs0BJEamA
         wLicU8dTb6+xdKiWu99RS6FvWjeObhQ0Tc1peAj9tAOWRc2qpMqEqwA9bGqfAHQ4m+sE
         uFCg==
X-Forwarded-Encrypted: i=1; AJvYcCUyOyYN/DWzvrYwo35b3aBgqcHSBrBr81OMgBVHN2gxefFWg6oMYufMCz8B/ebMpVjn1wiXU2EMpbC0tul0sQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeyrhMHMGUvMg4OioVtYj/1QwuzkzPgGV3K5UTTDidLmDUleOX
	9NlnJd3Jcv1cFCKO6WxnQHgFP9nGiok+QQZn2cKmmkRLWxAsnwiM9VIK7hE+qt0CBndJwFIRP+G
	+vY+Mzjp9IdmhjkkO3c5eZ+LaGtXPP9aQiTGqCPEr1UxkmQ4cdghj5NSmU99oWRoyKJHw
X-Gm-Gg: ASbGncswKYfjuR7HXU7NteDlAQvDn90P2sYL0NL/irsw0hGqS57F5PsIehWBsU5G99U
	OP/MeBZxPkgXVgKR89m898iNUVqj0mRBOFdlAwQROZGm+zusDj82Jhg2hackHHE4GGAmZnKv9s3
	amrp+EjGsI6J0b2eChhDoejH8Je9NrvemckDEiOmkfe/vux6wVDlCdq+UuHUwcOTmjjJFrxNQEH
	FncnAV/VVUTyZrbxhlHyvM6I27SRNsUkyolwIaN7PVf3C7tVyVm7NoHSqk/BbHs+Hun2VVu32TB
	6Jf67lCX8NjtBKTjNov/2HgQ0zpuGHekfLUd74ZBTGSqiByPZvyZ6tw6Wv6QebAzhQRA9r/iozk
	cQuh8apMsFLw43jkbrIc/fpexh7DpCw==
X-Received: by 2002:a05:600c:c48f:b0:477:7b16:5f80 with SMTP id 5b1f17b1804b1-4778fe49c0bmr188982475e9.10.1763543926573;
        Wed, 19 Nov 2025 01:18:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ0kf7jlIDNUdvm7TX8LR8Op1tEhe9CwD+MgXbg7FzSdj44TfR1SeRP2n+wUWlmPpEYHNLLQ==
X-Received: by 2002:a05:600c:c48f:b0:477:7b16:5f80 with SMTP id 5b1f17b1804b1-4778fe49c0bmr188982255e9.10.1763543926189;
        Wed, 19 Nov 2025 01:18:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm37899071f8f.19.2025.11.19.01.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:18:45 -0800 (PST)
Date: Wed, 19 Nov 2025 04:18:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20251119041745-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
 <20251118161734-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251118161734-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KUahiDACfSNNIF8B-YSJFDKGQsJ8PvRFVz79fyVeCQQ_1763543927
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2025 at 04:31:09PM -0500, Michael S. Tsirkin wrote:
> > +static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
> > +			     u8 *key,
> > +			     const struct ethtool_rx_flow_spec *fs)
> > +{
> > +	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> > +	struct iphdr *v4_k = (struct iphdr *)key;
> > +
> > +	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> > +	selector->length = sizeof(struct iphdr);
> > +
> > +	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> > +	    fs->h_u.usr_ip4_spec.tos ||
> > +	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
> > +		return -EOPNOTSUPP;
> 
> So include/uapi/linux/ethtool.h says:
> 
>  * struct ethtool_usrip4_spec - general flow specification for IPv4
>  * @ip4src: Source host
>  * @ip4dst: Destination host
>  * @l4_4_bytes: First 4 bytes of transport (layer 4) header
>  * @tos: Type-of-service
>  * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
>  * @proto: Transport protocol number; mask must be 0
> 
> I guess this ETH_RX_NFC_IP4 check validates that userspace follows this
> documentation? But then shouldn't you check the mask
> as well? and mask for proto?
> 
> 
> 

in fact, what if e.g. tos is 0 but mask is non-zero? should not
this be rejected, too?

