Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2BCDDA9
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878330; cv=none; b=BfA7rVB1EKq9XsC9O/mgR0aZJve77nZ3mjL1W1qhyTvSHGDeAgdpijiguBFrXpqyUW2/YOhltiSRXymDQC45St9VVFSYK1ladqBZ+L3BHo2coFaj5Rd9CTU5x5Q8Rn70bLrlXyIiudZ2IEYpLhZoEprlaU945MQt835QSW7M6RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878330; c=relaxed/simple;
	bh=7A9rE23m+RL+UaQQuX5flCQdY9RHFtZjjqn2wxodAtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GV8kX1YVDZCeObn8DisafKfYh5b7AKSAbv4l+iS4Gv6rfCN3G5zk3VdYP560eIgqLh0QMObjrEsjyYJpR0YUJwjK7agsLmrblaOMM9qGFxnoydhPUGX2aEa7+OFJ1MzE3DI2iqZmuYOf1XudlkGk/ZqJUyqmlUasS1rQf+z+cg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsbCymgD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsbCymgD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785878327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1TP38q0K01L56osFLXqQbZAP99zP82MPli6vDMYBEJU=;
	b=fsbCymgDctDUPskQD/Kyk+R+ffuB45sWWwCDmmo3kj3GkrwymfJivxKm/k60LLS27fiXuO
	VCg69bNwWNiAG9hmjBBslDLxX6byRZ0TAuzsYa8KoLmBu9ld/e5LtYS46evYwpAUg7SZkK
	RscQSCvrF7OTjypeHiZh1K0JvHxFHh8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-K1Cu7WeVMgmDUzO9oKhfZA-1; Tue, 04 Aug 2026 17:18:38 -0400
X-MC-Unique: K1Cu7WeVMgmDUzO9oKhfZA-1
X-Mimecast-MFC-AGG-ID: K1Cu7WeVMgmDUzO9oKhfZA_1785878317
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955e865174so1196715e9.3
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 14:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878317; x=1786483117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1TP38q0K01L56osFLXqQbZAP99zP82MPli6vDMYBEJU=;
        b=hrLhFvVNs0pGXzLf5c8qFD7OvdEunbYfUmuRqhY0oWXShPNk/eNuj0hSot2NEJ7qKV
         FxDNZFbL5pnfSq7xGT+Z3i80GPSGHd1FwLSIGOcj+GapZScbUptBt7lxrcJMrX8+whwv
         gfMnKufHmDgCxmcTm9Tt6S1c2jEBBVxjFnkqa1UwatdlLM13aqgZDYKc2TE/SpFvuj0I
         Uzc4qQMEfylVCBdAfMAXu7fjOyZSAOYnPp2fUHZYmyQ+RKJMmAcN29cQ3PWmA37UTRQd
         8edweXrfzHFGlLjMGBZpavjXgHFSHdlMDZqSVKgBL/BtNgLx/m8YjNWiiNBDrfmV3i76
         bRcg==
X-Forwarded-Encrypted: i=1; AHgh+RrQmfFDFASN4y5E8jzcd4CenMSfxYLVZhVnsP9+MvXiVgwDlmZUKA4ghbDWJW2RUxEgIlC9ZGtsk0WnAYUVFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEXyjyUIV9LHAmm1vOku6W+lhyAKkCre8Vu1cfLjbINdEeXwxF
	hl9tpMmzOpaWx4XzkymcmyEbifbOx+/vRNP9fkboCPhYrNpPtUCTIbfEQWftE23jOeTtx5RLB83
	HZ05yLDKTetayAXSe9dacDwUHsIt7qE4opM4FfX3hEUoweRcTBylaP7vfqyu3gQ2ywfZt
X-Gm-Gg: AR+sD10hegTJO5UUVhgh2kElKkiFQ9pes3qYnkBYk9ZPQP8/IR19BwRO9yb8e0N2glO
	iEd+nT2FtdpMJRtHIQXkUFOipCfiwLgzwf2d0p/XqMvzWHPGqo97ct7yWj/T98IOUIfETvn0eD7
	mOTFL5qkmtBCv24mR01VCiXsoJsantW5mk4o3sY43BHmkcyRL6IbnN4aA+RW+xvO4QiIs7GRyF7
	H2Jhl5QGMQVqh1AoczAIyMFv/dKeHcRjfQIIsxSN3MuTQOyw0SKALsSiVFWm4PZj/ksDx6GCZr0
	E57dUljb4o3tlE2pvgQASpbERYzPLPOS4kiB6eDnSaIy60tWEb1hAg1gQ9ptbJh3VFKW+iJmBDc
	ZTa4cyhU/lrwjq4tZrxDqsg==
X-Received: by 2002:a05:600c:2142:b0:495:5858:8101 with SMTP id 5b1f17b1804b1-4994e7cbcbfmr11546245e9.15.1785878317037;
        Tue, 04 Aug 2026 14:18:37 -0700 (PDT)
X-Received: by 2002:a05:600c:2142:b0:495:5858:8101 with SMTP id 5b1f17b1804b1-4994e7cbcbfmr11545645e9.15.1785878316524;
        Tue, 04 Aug 2026 14:18:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7b73sm151709455e9.9.2026.08.04.14.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:18:36 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:18:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: Zhu Lingshan <lingshan.zhu@kernel.org>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa: ifcvf: Put device on unsupported feature error
Message-ID: <20260804171710-mutt-send-email-mst@kernel.org>
References: <20260804092626.1344371-1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260804092626.1344371-1-xiongweimin@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kuul-M0WygLUEha24Qm76G4ByxmlBIdFrUEUvXIz4TY_1785878317
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 04, 2026 at 05:26:26PM +0800, Xiong Weimin wrote:
> Route unsupported provisioned features through the common error path after
> vdpa_alloc_device() so the allocated device and adapter pointer are
> released consistently.
> 
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>


I have no idea what this means. This is not how a commit log should
look. An example template:

Currently .... This is a problem because ... We can not do .... because
... To address .... And then ....



> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index ab6d6ab3b..3cd2c35db 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -724,7 +724,8 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  		if (config->device_features & ~device_features) {
>  			IFCVF_ERR(pdev, "The provisioned features 0x%llx are not supported by this device with features 0x%llx\n",
>  				  config->device_features, device_features);
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto err;
>  		}
>  		device_features &= config->device_features;
>  	}
> @@ -748,6 +749,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	return 0;
>  
>  err:
> +	ifcvf_mgmt_dev->adapter = NULL;
>  	put_device(&adapter->vdpa.dev);
>  	return ret;
>  }
> -- 
> 2.43.0

