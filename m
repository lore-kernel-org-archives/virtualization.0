Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566122071FD
	for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100521; cv=none; b=DeOVrIFZCmpOtjmfnNBWIiCVRb5k+8zF+WNnvv8k7fUq75kkXcPbm2J9DcPPUHK7IbdCx8Uh/GbLGMoSHjQJtGeh+0gptyL0OmR1MiFCDN/frF24VMzPHMhzJOTGQ93K0UlkwmDGeqQaXIht8kjpAZ8mzoYoPIyZI32AxkxE2Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100521; c=relaxed/simple;
	bh=zZa2DuJtbeZdTDiPg6nHIyegUjLqhs+ELaawfPSdUmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uCRPUkQgIpriwYBJ9ILZW1nFQBpxO0WevZD7v0MTycclS91pqo3pqc6Gve4IEhL9akKS3YzjJ23ntED0mzwL0Ac7yQ1SS9CafA8bh6qSwqoV8CpOswGwIot2Dc/PyfZuQMoE8Ptwmyx8XSRpVEKVig6BNdhegnvwgM4NJ2XvnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7zICxVe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7zICxVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729100518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/q8VB7z/+Dd2yPKgk6uJSd98F7HmQ0TN0/vUj4F4ARY=;
	b=V7zICxVePekiFPcSxm6tLw2sM65lpfzO2t3HDOUXdcCZjt1Ac/Qgo7eerJEcJXWhiqPrkG
	oy1It1iTNNRJCnz34GJyO+gwnkv+cqBGV2CVuid+O5nWMlc/lEFfay/ubzRJvk8JxwWFfC
	8sBaeOXg1DAfgP/MUcQ0QKM9PDAenwQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-5r5-ptRzNWuZkjR75tWyrg-1; Wed, 16 Oct 2024 13:41:57 -0400
X-MC-Unique: 5r5-ptRzNWuZkjR75tWyrg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d4a211177so20432f8f.0
        for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 10:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729100516; x=1729705316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q8VB7z/+Dd2yPKgk6uJSd98F7HmQ0TN0/vUj4F4ARY=;
        b=Pdt5R8YG4HSe44jeQdg+vLFcVuFgVFHXvOJCR4nWJv02R84ARW9SPl6m16Kofmid2B
         BqxbtY89vvkGsS7xxz3zD+IuMfG895SGI7A9fLln3MRC9RJZOtGsDe/8D+sadiemkB9c
         V/HEANdsNiI53j4fYOwe/8wnHNL7sHVc8y5KLoXLLznSQGvwega+b4LaNHkM9uYRYmXF
         xOm9+Grhg+8iwmFzbQbfdzCCrvPDQYjoB27hBMwJs9SPPovQ5yjBKNXm/msVju2zbOUA
         8Q4Uvv87KGFzBVFeAvbPgI9mD9sGyX63IgYNWyweWRBAY5fdZdW2pz9m3BJRUWASFmUM
         FZNA==
X-Forwarded-Encrypted: i=1; AJvYcCUgXQSw6b92tf1BH2EYNX/GXZqSeQGW77DoltGuQ246nV/N/l+slWBfmP9Mjm/YCfsLBVCx5litu6I5R0EynQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzn0oC12jWWZDt88xiNX6uudlIDnc6gVRxKZT2YIbGtiCVPch1m
	mfsg2lPKR0jrnXXee799YjdL9Fdl6sxPRjxAh1OQ5GVQHf6fw/guC3HE0soxLvCT39YdzYyZbe0
	0ZKoNofEEQv2hsNdhfsTyZqBD8X/3bX6klE136fvCDAsEXiB7pCRWmly1M1LH3Nn3
X-Received: by 2002:a5d:47c2:0:b0:37d:4e03:ff86 with SMTP id ffacd0b85a97d-37d86d698c7mr3670353f8f.49.1729100515990;
        Wed, 16 Oct 2024 10:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5LqH4y7mLhg477ilLXLgpjCf7W76dfje6QpYrJUn7Yqcr3EVNRcTIF4VEtU+n8CArG/mOlg==
X-Received: by 2002:a5d:47c2:0:b0:37d:4e03:ff86 with SMTP id ffacd0b85a97d-37d86d698c7mr3670337f8f.49.1729100515493;
        Wed, 16 Oct 2024 10:41:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:b9f1:592:644a:6aa0:615c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc411fbsm4836012f8f.107.2024.10.16.10.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 10:41:54 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:41:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Srujana Challa <schalla@marvell.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/2] vhost-vdpa: Add support for
 NO-IOMMU mode
Message-ID: <20241016134127-mutt-send-email-mst@kernel.org>
References: <20240920140530.775307-1-schalla@marvell.com>
 <Zvu3HktM4imgHpUw@infradead.org>
 <DS0PR18MB5368BC2C0778D769C4CAC835A0442@DS0PR18MB5368.namprd18.prod.outlook.com>
 <Zw3mC3Ej7m0KyZVv@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Zw3mC3Ej7m0KyZVv@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 14, 2024 at 08:48:27PM -0700, Christoph Hellwig wrote:
> On Mon, Oct 14, 2024 at 01:18:01PM +0000, Srujana Challa wrote:
> > > On Fri, Sep 20, 2024 at 07:35:28PM +0530, Srujana Challa wrote:
> > > > This patchset introduces support for an UNSAFE, no-IOMMU mode in the
> > > > vhost-vdpa driver. When enabled, this mode provides no device
> > > > isolation, no DMA translation, no host kernel protection, and cannot
> > > > be used for device assignment to virtual machines. It requires RAWIO
> > > > permissions and will taint the kernel.
> > > >
> > > > This mode requires enabling the
> > > "enable_vhost_vdpa_unsafe_noiommu_mode"
> > > > option on the vhost-vdpa driver and also negotiate the feature flag
> > > > VHOST_BACKEND_F_NOIOMMU. This mode would be useful to get better
> > > > performance on specifice low end machines and can be leveraged by
> > > > embedded platforms where applications run in controlled environment.
> > > 
> > > ... and is completely broken and dangerous.
> > Based on the discussions in this thread https://www.spinics.net/lists/kvm/msg357569.html,
> > we have decided to proceed with this implementation. Could you please share any
> > alternative ideas or suggestions you might have?
> 
> Don't do this.  It is inherently unsafe and dangerous and there is not
> valid reason to implement it.
> 
> Double-Nacked-by: Christoph Hellwig <hch@lst.de>

It's basically because vfio does, so we have to follow suit.

-- 
MST

