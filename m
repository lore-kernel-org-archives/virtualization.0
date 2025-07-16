Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F455186294
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685240; cv=none; b=iD9aD+IraAHG8G02KtEfuQBWShB8+ZIgNj6MDFLuvlmTRWIN7lAG7+A6SF7qlCxHWyKFCaYTNQ/3cruGq+9QdIl77SeEW24EVQ++6GV/CgJGVuq9j40Mq1YkklIn71ZRNMqCGLe3u35OvnSQvNLg1PQk6H3OHb1W16+9mZ3VNpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685240; c=relaxed/simple;
	bh=VT2e/D8TNHzCkI96xQbHOMePD40bqojitO9TYfZwJRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdsO98lsAy73+ecdajpOa3QN47SaY4lZPvi7dHU3krpqZfgdcfxm8uQH2C/15O3GsrI6K5j/1r6Iq5U8dQxatkcTFNZtR0Fr38m0vboogNZz3guzjKhDCMHEd7X/x2YKDFfUqtDWDLkiDcmRUHvQIlZXmAEyVNNo+w34I9yLoiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGW2SqND; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGW2SqND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752685232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9bKE/0cNtoQ/CuczzprbbV3beLrr2MpjH/0TxwAvYDI=;
	b=EGW2SqNDS+bbvfZeAe7m0XkeSE/5InZp+3e8Cm9971xBLykYMr0Id2ZKD6lhZf2L14cb7E
	m/7j21puwycBSAL1z5yPa+WPPIcNV7qCtSSmndOl4e2MIfmaQBvEJL0v9ZDdhcEouARXw7
	N1R7nTs676nXIO0KAIF44/eoIk4Gb3s=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-9SNDpzlXObGnLT5X1Gltyw-1; Wed, 16 Jul 2025 13:00:31 -0400
X-MC-Unique: 9SNDpzlXObGnLT5X1Gltyw-1
X-Mimecast-MFC-AGG-ID: 9SNDpzlXObGnLT5X1Gltyw_1752685230
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86cfa305eb6so48139f.0
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 10:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752685230; x=1753290030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bKE/0cNtoQ/CuczzprbbV3beLrr2MpjH/0TxwAvYDI=;
        b=QW398yLCN7PPDMgx0m6zkJgZyw2YfqciFCFjeL1nAAAi7/P7FvbHPtWQbVp+C5Yk6r
         GyZebjGqwkf2K8xS+YyF3Tr1911nEkQV+6OVbJBr49BrxnY2M2+f12fl3wOqos+j4+uU
         IDCkNdx8Z4IbgzucxxM+o7138v8N/kA+apGikglZuSq2leGuU2HIqky7rFiyMJ98oY7W
         IKig+68N59gINOPY1OiNKtgYU+u5xcrVaXV8u0r+HSqEp4AQRWo4NFaawX1EJlFHKu0F
         aLpOwtQ+jcOoVesJv7uvu/9P0vP2iI9PC79dyTJESp4rasKk0UMGOEV1xzntxSOmWVAS
         a6PA==
X-Forwarded-Encrypted: i=1; AJvYcCUYhzeR6aNp65oDhh+nqoceEWVsf+mevyzavGyZPaL4abUHYuRVc+73khF2nOb0QgkxkwbsUSqGS2/4BpLEfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXc+NY0W3gvAfF0GzUkrhGBpFqlAAOlReqar1D+9qf/TDRph1/
	AYvEJ4Ca6E881b1hLrpRn0O7y0+9u4DqUIXdCCfZXDTbQEc4lTCvJqG7XHnwjulTchqK6R+adRm
	AfOYXSc9TRZGVQJwAO1eNH03xz3aR6wHf50LHlDBZJHGOfzePoX8NsE0vXaYhvtLd+Qsy
X-Gm-Gg: ASbGnctBdJUIFKaHZWxIPolvjnVswOn2SDjZzKz1N/woYpCK7YPpAA5NH2S5jtDBQp/
	F4lLd+ubJi5WuRUKAWeWh82zCC9FRcT6QigQfDyYGjQ8b+Uqh00VLPVUsijOuaQy9SqQvER6Sgl
	ZDTdccElQfR3G0upAGQeC+WDwWnTDP3kMhJmpM+027Pm7Ddwui4LbUHkhNFIUhVv1agFGEnBx7Z
	wmLNIFnQkWu0sImV3d6m2bWoE4sf4wJT0H72b/J/yq4v6UZ9Xb82WvCqBd2AULjk+pUzPErQ368
	sFrm/kA6s7Mkb6nuesUJTOqaPxsCrO3JiHiqvP5779Y=
X-Received: by 2002:a05:6602:1690:b0:85e:12c1:fe90 with SMTP id ca18e2360f4ac-879c096efeamr126748039f.5.1752685229891;
        Wed, 16 Jul 2025 10:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+tZmWUIYwitvuBgGnxfswO12NMpp8mD2icMHkWg5+YtIZRRU8sqVvx4qLf0KrRuHgGBPToA==
X-Received: by 2002:a05:6602:1690:b0:85e:12c1:fe90 with SMTP id ca18e2360f4ac-879c096efeamr126745539f.5.1752685229362;
        Wed, 16 Jul 2025 10:00:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569d0e42sm3119302173.101.2025.07.16.10.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:00:28 -0700 (PDT)
Date: Wed, 16 Jul 2025 11:00:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 Ankit Agrawal <ankita@nvidia.com>, Brett Creeley <brett.creeley@amd.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Kevin Tian
 <kevin.tian@intel.com>, kvm@vger.kernel.org, Longfang Liu
 <liulongfang@huawei.com>, qat-linux@intel.com, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, virtualization@lists.linux.dev, Xin
 Zeng <xin.zeng@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH v3] vfio/pci: Do vf_token checks for
 VFIO_DEVICE_BIND_IOMMUFD
Message-ID: <20250716110027.7e94129f.alex.williamson@redhat.com>
In-Reply-To: <20250715230618.GV2067380@nvidia.com>
References: <0-v3-bdd8716e85fe+3978a-vfio_token_jgg@nvidia.com>
	<76f27eb9-7f56-45e7-813e-e3f595f3b6e9@suswa.mountain>
	<20250715230618.GV2067380@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HM1ijJgPUp3p0276hbqVKf5qbB8K56GN-x1mq27b5-c_1752685230
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 20:06:18 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jul 16, 2025 at 01:55:45AM +0300, Dan Carpenter wrote:
> > 5fcc26969a164e Yi Liu          2023-07-18  117  	mutex_lock(&device->dev_set->lock);
> > 5fcc26969a164e Yi Liu          2023-07-18  118  	/* one device cannot be bound twice */
> > 5fcc26969a164e Yi Liu          2023-07-18  119  	if (df->access_granted) {
> > 5fcc26969a164e Yi Liu          2023-07-18  120  		ret = -EINVAL;
> > 5fcc26969a164e Yi Liu          2023-07-18  121  		goto out_unlock;
> > 5fcc26969a164e Yi Liu          2023-07-18  122  	}
> > 5fcc26969a164e Yi Liu          2023-07-18  123  
> > be2e70b96c3e54 Jason Gunthorpe 2025-07-14  124  	ret = vfio_df_check_token(device, &bind);
> > be2e70b96c3e54 Jason Gunthorpe 2025-07-14  125  	if (ret)
> > be2e70b96c3e54 Jason Gunthorpe 2025-07-14 @126  		return ret;
> > 
> > This needs to be a goto unlock.  
> 
> Oop yes, thank you
> 
> Alex can you fix it up when applying?

Yes, I'll apply with:

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 53a602563f00..480cac3a0c27 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -123,7 +123,7 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
 
 	ret = vfio_df_check_token(device, &bind);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	df->iommufd = iommufd_ctx_from_fd(bind.iommufd);
 	if (IS_ERR(df->iommufd)) {

