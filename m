Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2AA2F2619
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051482; cv=none; b=cNNLsjBKNQV2pdh8x4Di4Qriid0qU073n13+2h104ZFm+E7cF7MUwJMeY0vuso49m61sXHWxrHn8jcB+yypSsIdNH9tfKNneQQzoep3zAVYbbCXElDHd1SuUlSsm+2Kzsjd8gcsYgG8FZRe7O4coMSHxChLwEKh2CATUL5U3ln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051482; c=relaxed/simple;
	bh=FfcoUUoPUpOsa0VkWk/Dk1Pdl70TqifwXFfjdZWH8QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hiMwSyTkU51iPeCcFsVqGOmrFNTSbTpjoJ5tQyDoV2cMsn9RbrOI2vVaFL4P4DbbbPpTd5HchuXxijdxBEDaqTrqUj6cwLpH82qJCaWKYpt8+jjd6E31gvaQcxnsb6DbMgtG8J9gAGVJDRmBXiVLLgb1nBR/tVK7ejy4UETY82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvUfadTO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvUfadTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvdJq2dPLugSFjjKOvXm1LBOxtEu3BmwSDlhR75aYWo=;
	b=KvUfadTOtYd4YATO2qf/JDmnvJJrevXEbpk+CFSbWOhR7RckZ/3ODtaY7/IIu4+6r1Sy7L
	BcBiUYktOxQ43SVpj4S5LlRy363zrykdXmukbdx3gCk2Vx6HgAveg0093Yuq5XupkCEPUt
	7PXGSjjWpqpn9olEfwaroxKKHrLc4Zc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-huEcjAflOVqVORmb0MY6zQ-1; Tue, 21 Oct 2025 08:57:58 -0400
X-MC-Unique: huEcjAflOVqVORmb0MY6zQ-1
X-Mimecast-MFC-AGG-ID: huEcjAflOVqVORmb0MY6zQ_1761051477
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47106a388cfso25119485e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 05:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051477; x=1761656277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvdJq2dPLugSFjjKOvXm1LBOxtEu3BmwSDlhR75aYWo=;
        b=U8u3N3PJdheJfU39UE68GHY6fJzZ7sbmhd9J3ZQ74RqUn/RET9sVrChIT2NalPReAs
         fZhShs6Ra+FzHJPW45kBb8onqqotss8N57K5DVSmyolKzO8GUWnr8rK34c9yN3FeHmd/
         U91YGthqzC3/vmVJUJbwdNVPpGq2h9DYrSMYTWMwkLUMvPQ5oiW+lvBvvIShowlF33zU
         7zksyz8gTsgBwtD+xhtnxiOY3z3bYDs0BknRWYtnMM1T5ysdCjukbBDZVHGfcGJppiyj
         rqZzHvFFFhzlLG07PtXCGzWZ/k/KTRzXu8ePepK29JvFkpQbXui+C9i1A/03Q9xJzz2y
         XNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO/YqkYVThGyjTCCIlQkfeEjrtr78bBvJFxSMVLeuvl32VQJpyktZRM7MSX+bRpd3ycCTGbLSaD2E0b2VfAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxacgu3zPxEatLud0124yIJXUFSB0zIkreHzStdiEmkgd4tlnOd
	XsWfD39O3Bmk31cT9hS3vn7vOqQoVnfnk9oQBCvM533kPRoxJmG/akhJjs0z6g6LbbV8kzRq9Dv
	rs9VSCJCtL9E8ZUIDgg5dm+udMpBVwZKMt0IpAgBWV5UWbG/yLc4/Rh/aRz/UmBE19mdV
X-Gm-Gg: ASbGnctxZ9ZaTpHOy2pmb3e+aYjHYs1sroXDcTC9aFRGIjoryV3YoeVlbCAPkPVQfjy
	MheK27/cRmJSpmDLHR82b2KxNnXcOh/URoTKoaNpL/gXtlq1XNmQ5ihaXRfh8Z9W3XCuaMxu+bm
	fuahdS6RmUQIG1dWi5d54ll8MBeEVjfv1tD6f3pGkWoFbuPsPmOMlWoSCz/puja2z40p4o/RpOF
	BJ64rK7yp836mAKHVn7mbaCKw0MgecHQML5KVlWUEOWuBvOi71xpm+1NNWxc7JdJ5zFjFcghqlk
	YxsBy3Cz5pWvKq92bJdE57VE/tAyLfXTBS4TgqJvU1QC5IS1QAjthlSSUUJG98ygYs1E
X-Received: by 2002:a05:600c:198d:b0:46e:3c29:ce9d with SMTP id 5b1f17b1804b1-4711791c57bmr139775115e9.32.1761051476913;
        Tue, 21 Oct 2025 05:57:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMQOVxMDKEqgOB4aV0YZaSaGuRZMfduYN5i5pIKMunnPmVy9cLSdbbEF1RTdTSlw3qu+1DNA==
X-Received: by 2002:a05:600c:198d:b0:46e:3c29:ce9d with SMTP id 5b1f17b1804b1-4711791c57bmr139774785e9.32.1761051476400;
        Tue, 21 Oct 2025 05:57:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d3843csm195088345e9.11.2025.10.21.05.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:57:55 -0700 (PDT)
Date: Tue, 21 Oct 2025 08:57:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	pavan.kondeti@oss.qualcomm.com
Subject: Re: [PATCH] virtio_blk: NULL out vqs to avoid double free on failed
 resume
Message-ID: <20251021085030-mutt-send-email-mst@kernel.org>
References: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251021-virtio_double_free-v1-1-4dd0cfd258f1@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j5_xqfaKeIP1-kS9oU-a-Q3gFypJnAdxFlLNnQYTSB4_1761051477
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 21, 2025 at 07:07:56PM +0800, Cong Zhang wrote:
> The vblk->vqs releases during freeze. If resume fails before vblk->vqs
> is allocated, later freeze/remove may attempt to free vqs again.
> Set vblk->vqs to NULL after freeing to avoid double free.
> 
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> ---
> The patch fixes a double free issue that occurs in virtio_blk during
> freeze/resume.
> The issue is caused by:
> 1. During the first freeze, vblk->vqs is freed but pointer is not set to
>    NULL.
> 2. Virtio block device fails before vblk->vqs is allocated during resume.
> 3. During the next freeze, vblk->vqs gets freed again, causing the
>    double free crash.

this part I don't get. if restore fails, how can freeze be called
again?

> ---
>  drivers/block/virtio_blk.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index f061420dfb10c40b21765b173fab7046aa447506..746795066d7f56a01c9a9c0344d24f9fa06841eb 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1026,8 +1026,13 @@ static int init_vq(struct virtio_blk *vblk)
>  out:
>  	kfree(vqs);
>  	kfree(vqs_info);
> -	if (err)
> +	if (err) {
>  		kfree(vblk->vqs);
> +		/*
> +		 * Set to NULL to prevent freeing vqs again during freezing.
> +		 */
> +		vblk->vqs = NULL;
> +	}
>  	return err;
>  }
>  

> @@ -1598,6 +1603,12 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
>  
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);
> +	/*
> +	 * Set to NULL to prevent freeing vqs again after a failed vqs
> +	 * allocation during resume. Note that kfree() already handles NULL
> +	 * pointers safely.
> +	 */
> +	vblk->vqs = NULL;
>  
>  	return 0;
>  }
> 
> ---
> base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> change-id: 20250926-virtio_double_free-7ab880d82a17
> 
> Best regards,
> -- 
> Cong Zhang <cong.zhang@oss.qualcomm.com>

