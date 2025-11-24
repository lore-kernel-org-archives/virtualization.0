Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3B2F83DB
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764024868; cv=none; b=Qlb+1HbGZjOh+nzBhfPqmYUZqioGcElxqUsC9aUaroxj0cDniUy83RMTLfe4dwB6Y5cwVcZIRuCQ5dAT9fsthTXzUuoN/qGfb1iVoUGPXRcjIZROIPYBjtdRCXqB2bD2yrdzvyw1I3CAzCztyCJ8ge0N4NFbFSqdmgLE+Iyl8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764024868; c=relaxed/simple;
	bh=26+QtX65UOT4HCp+EVjCEV/pYFiVKrU7/EECqOZouOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=P5F3tVBObc6WkVwNS06tH0sMvsxrRJVPFl5sEflVuX5S6FvhByCkbw/FH0xPr/GuZFdTI5N3zIJfKQzLeP1tAeduG9Xiy4aeMgbqyjVffL0c6tYb7eQYtTF0QP91Tace8ekPHT7gCzIhx3FtKNuFnjhUW9zR+TV6BO5K+8SeiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPMIj3jd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPMIj3jd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764024865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OetEkTOE2F/5xzSGTfF4kqvBotamRkDb8AG8TB2+1l0=;
	b=cPMIj3jdxzw8J6dtMmzl7bxUEUfejGN8FhV50SEWTL47C8dUQ217zrOI7HrR/7zT2tQLdZ
	rd/wjubUbjt8Jr4QE6qma2wUbYSouDE/zJggBHXFDbsbtNAbBQ4/Ib7EDAaNCiu5B633jM
	McaQcRiKQZYVTgks6dlC5Geye5vGh6o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-2_Xs925ZP-KpgnF_vYrO3A-1; Mon, 24 Nov 2025 17:54:23 -0500
X-MC-Unique: 2_Xs925ZP-KpgnF_vYrO3A-1
X-Mimecast-MFC-AGG-ID: 2_Xs925ZP-KpgnF_vYrO3A_1764024863
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so39044775e9.0
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 14:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764024863; x=1764629663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OetEkTOE2F/5xzSGTfF4kqvBotamRkDb8AG8TB2+1l0=;
        b=ox5CJTYGyXjPoQ93zfBiSFAC6QKts1cg1Q+zxydCkmQqXhfOO+iq+57yGmtZ2axez7
         L3oqBbdOdvk7G0LKmBzgWL4SEhOOr65Q+Cw8YxzttMyF2H/v97YaxsrrOkkqxJun+65D
         kzHrv8/LeIoOqTSSlyGj6oO503c5JZ5jeQk6jOVOlLHrNTDe4sENz/sLWjMNW8i53hiP
         kJ/28qFirYqxrtSooRrP9Wi8gv6xsoGPT/ax3NHeRevCeZS5plc2AcxTCf67xUC2YPI8
         kvG2tJ2ebjPCnAr3nFyp9YK0paFHOt/pxXoFRx8JST3JxlOsecwlO8fODRZ8mNFdFiJr
         dcPg==
X-Forwarded-Encrypted: i=1; AJvYcCXW1xeT9q95RKThYf8W0gQnX9GRE2u/aQqH8xdKeXKl4oKSt6iciJ8U2CKiYNXGU859nA92Hj6Q69O8ZsFp/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyY9dqw6TMhr3YuthFn/SSdOB1Y+XEeXF/JpN+utMpCVYIZ630
	GQf8ZvSFqMKS46mZRtY4yVYzjpyJ2j1opzzHcMHnisj3PH3WM9ANQx/N/IDlcxEklRnCyiiF4fv
	cM2aHBlutls4/+V8XL49zS87aIWI2mgcwjYsC5gz+e1qef4G8OcWsK0ZdQ5K14zPE+OsC
X-Gm-Gg: ASbGnctSyV+iCVXlDZ0ARIc1Rn6r1UuUREFuhK4DOf75G15VZt5a5b5G4oTKrGkuvfC
	9W/WPFZNMApjBwmFJOZnFcsGwU4TEeEQ3EJ1s/YWtKg3CjQubpPotzFbaQZQgyOPWrMOycKSQJc
	Y0MvoXLvrpHiJj/kLwgxxniLY+2Y5Iw+V7okEqlcb+kEmWXIWeWcaaoh6s7X6A9VQyqwPJyUooS
	mHMGryzD4+A8yYoFZMt1ynUR3hErimXu0qm5sYscHZF2LtgjWquDWYwPjM78DmGEP6lHoyPXAxv
	R00RGSvu3vIgX25D37+xYJ4Y2Np4mxOqvgIBLkoksHegAE/7NKNRcEtpaNa52czs2rZkyc/3KNp
	a7XQms+/DJWZY4lE2500kIPRQ0+QVdw==
X-Received: by 2002:a05:600c:1c82:b0:477:73cc:82c3 with SMTP id 5b1f17b1804b1-477c01ee405mr131520215e9.26.1764024862551;
        Mon, 24 Nov 2025 14:54:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjVw7J+iRYtg3aSk8SrQHBFx2JTGamtrX0Mw0WmcZxEeVR9ryRRvIYOmP8j4+NPfDD6CsKZQ==
X-Received: by 2002:a05:600c:1c82:b0:477:73cc:82c3 with SMTP id 5b1f17b1804b1-477c01ee405mr131520045e9.26.1764024862148;
        Mon, 24 Nov 2025 14:54:22 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf198a67sm228563205e9.0.2025.11.24.14.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 14:54:21 -0800 (PST)
Date: Mon, 24 Nov 2025 17:54:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20251124175247-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251119191524.4572-6-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V7BpQrg14pyNnep3H7veyog0M7NPCAGBjdTYixP6G_M_1764024863
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:15:16PM -0600, Daniel Jurgens wrote:
> index 4738ffe3b5c6..e84a305d2b2a 100644
> --- a/drivers/virtio/virtio_admin_commands.c
> +++ b/drivers/virtio/virtio_admin_commands.c
> @@ -161,6 +161,8 @@ int virtio_admin_obj_destroy(struct virtio_device *vdev,
>  	err = vdev->config->admin_cmd_exec(vdev, &cmd);
>  	kfree(data);
>  
> +	WARN_ON_ONCE(err);
> +
>  	return err;
>  }


The reason I suggested WARN_ON_ONCE is because callers generally can not
handle errors. if you return int you assume callers will do that so then
warning does not make sense.

Bottom line - make this return void.


