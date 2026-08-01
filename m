Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D469B38D
	for <virtualization@lists.linux.dev>; Sat,  1 Aug 2026 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542424; cv=none; b=tlnGdzuezHkUbrzH7+Pd3nofhkDWBUhVCkde3uLkG1D9fKN0UQk6IUECvV69Ub49NShmjKDstTMipjNsnimhdkogWEVPgL6UAuSz5rgZGeY8vZ1Y1jlkRSs8MrocBg34maOlPQQJInzuAwkpVb/+/Ued23JUykLgwOQOHYs7nOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542424; c=relaxed/simple;
	bh=O8HqmJQWZA1nfUBNMj9sxQRGTvaC1yJRVK0bfgHcTrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RztKbLs4bOthfmN2PH/4QNHq4H14Mk1h9f2/1jKHUtWoNTWLLLgvnNzLkShE/YmOoz25U3ZuH29HPI1Qe1cnLzTJ5/Bva5Mjq6Wp47+y75GYf/0wRVoPJMhj1WexsJKZ3ixGR2xBAeMR26/Tlrk99aOXC1IXVMaKrijRKGzm6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PynQSuYV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PynQSuYV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785542421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H0eYF5OZd5Mj1htNYojskxEZwjl7/C9yBVDIfFNOInU=;
	b=PynQSuYVSFsk5CAAwOQzPlwJHY0TzB4JNSMh+SDHUIV1I4CMvSlaQXgJdyv9Qs31WeZYC7
	wAl0HmNny1FjNIgRTDcydRgeSbYBANM/HW5MdDOcRG72igsbso4DoNh2LtupiTxahSZ+Si
	MsBlP168j+xaAP1yGh1tOvDQMmIlmUY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-jPgoav8RMsSiO_jVDa3B2A-1; Fri, 31 Jul 2026 20:00:18 -0400
X-MC-Unique: jPgoav8RMsSiO_jVDa3B2A-1
X-Mimecast-MFC-AGG-ID: jPgoav8RMsSiO_jVDa3B2A_1785542417
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767b782so1304275e9.2
        for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 17:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785542417; x=1786147217;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H0eYF5OZd5Mj1htNYojskxEZwjl7/C9yBVDIfFNOInU=;
        b=LUpdXTDWXTcMkKOqyfMZEzCnqwTbCf6evH14IisQZuiQcq5cqlI7qedivaO/IE4Ip/
         L8sQCJXn5VOmG5TYG918IqVpJ89XS3rzK4buPOyEha9rkHj+nTonsUlFCHMQkpuz2NJx
         CaQQLrxYtV/lyp1qAOJaCpUrSqwICugepPzt8d4axK98oN3HJogjTf5j5dfJLcDqW2Pw
         dNMZ9zqqAvsnEGAp+MJVyfQmrXNiGNL1uHgv8YHq962Lzj1BMm2eLcGYiAJeVAN0RF6h
         jY+e6TzKXf2Hy1k24udE+ZmRG2PGjXq9LlSmKvwsKGGtGEd5uYZnK4vhZkVXijYAg5Lz
         pqXw==
X-Gm-Message-State: AOJu0YwCr6z5rdFpBA8QxDyPsJncMeIAQmUVz3w3XKFy8IE0ysL3nmBP
	mgO37c8o31ibaRqOKGZTTdLL9U1lXf54+YZorQ/6tPuEgcl0SYrV+HGOGVkdDKmsquXwydFHNeb
	9F7CEdKFAjf5md3hmq0EaF08EsADaVHIgEzLpP/UcJCPY0Rks0eSH3+HKIjFz9DSgaH+M
X-Gm-Gg: AR+sD11JuMUIW32BjeEyiw9j3MebwSAzcNl4+J1Bm4AXu/CyV1v0BjUijoU2bEG5lle
	sEamoNCdndMe47LGMS+8jSsWxywuyYz1jg9npAnoZ7PKojIS/pjb387T5EAHkj9/WXj1BM4Nsv+
	r9eJOIKU4cFRRVXU/mPm9qOobadO8DT0Oev0j33vR6YdN13VBN9xFw6aZVwmQhIyXhR9H/Er6WF
	qfR7vOp9xzGNLI7Tmg8m7iWs3akBupYLPMSWdj+1NLiU5oZ/yreEPqCWhkMEchH9N+MS5DBfvCP
	YLMRplB/hR3R7rdZveNeLV8GNvMDEuE6FCRZrMyDFEkm7h/pKwpMaP0HjjaotNMXSvIzY5SpgBZ
	4ljyt+6YqDFc6YvmalN1J4WE=
X-Received: by 2002:a05:600c:48a2:b0:496:bba5:33a7 with SMTP id 5b1f17b1804b1-4980c6824e7mr1432215e9.27.1785542416755;
        Fri, 31 Jul 2026 17:00:16 -0700 (PDT)
X-Received: by 2002:a05:600c:48a2:b0:496:bba5:33a7 with SMTP id 5b1f17b1804b1-4980c6824e7mr1432025e9.27.1785542416366;
        Fri, 31 Jul 2026 17:00:16 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807eb12c5sm3178825e9.3.2026.07.31.17.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 17:00:15 -0700 (PDT)
Date: Fri, 31 Jul 2026 20:00:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, jasowangio@gmail.com,
	michael.christie@oracle.com, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org,
	joe.jin@oracle.com
Subject: Re: [PATCH 2/2] vhost-scsi: reject invalid max_io_vqs module
 parameter
Message-ID: <20260731195756-mutt-send-email-mst@kernel.org>
References: <20260731221116.236791-1-dongli.zhang@oracle.com>
 <20260731221116.236791-3-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260731221116.236791-3-dongli.zhang@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2vgRGvNHXXW7pe8I9kW32AOtmmj7F755HhgOtC-fSKU_1785542417
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2026 at 03:10:24PM -0700, Dongli Zhang wrote:
> max_io_vqs is currently validated only when a vhost-scsi device is opened.
> This allows sysfs to show values larger than the driver will actually use,
> e.g. writing 2048 succeeds even though vhost_scsi_open() later clamps it to
> VHOST_SCSI_MAX_IO_VQ. This makes the sysfs value differ from the value that
> will actually be used.
> 
> hv# echo 2048 > /sys/module/vhost_scsi/parameters/max_io_vqs
> 
> hv# cat /sys/module/vhost_scsi/parameters/max_io_vqs
> 2048
> 
> [  315.630495] Invalid max_io_vqs of 2048. Using 1024.
> 
> Use a module parameter callback to reject out-of-range updates when the
> parameter is written. This keeps the visible parameter value consistent
> with the effective queue limit.
> 
> With the parameter value kept in range, remove the duplicate validation
> from vhost_scsi_open().
> 
> Invalid values now fail with -EINVAL at write/load time instead of being
> accepted and silently adjusted later when the device is opened.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

why should we change userspace visible behaviour now?

> ---
>  drivers/vhost/scsi.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 0c0634eea144..c138c29ce3dd 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -210,7 +210,20 @@ static const int vhost_scsi_bits[] = {
>  #define VHOST_SCSI_MAX_EVENT	128
>  
>  static unsigned vhost_scsi_max_io_vqs = 128;
> -module_param_named(max_io_vqs, vhost_scsi_max_io_vqs, uint, 0644);
> +
> +static int vhost_scsi_set_max_io_vqs(const char *val,
> +				     const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, 1, VHOST_SCSI_MAX_IO_VQ);
> +}
> +
> +static const struct kernel_param_ops vhost_scsi_max_io_vqs_op = {
> +	.set = vhost_scsi_set_max_io_vqs,
> +	.get = param_get_uint,
> +};
> +
> +module_param_cb(max_io_vqs, &vhost_scsi_max_io_vqs_op,
> +		&vhost_scsi_max_io_vqs, 0644);
>  MODULE_PARM_DESC(max_io_vqs, "Set the max number of IO virtqueues a vhost scsi device can support. The default is 128. The max is 1024.");
>  
>  struct vhost_scsi_virtqueue {
> @@ -2273,22 +2286,14 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>  	struct vhost_scsi_virtqueue *svq;
>  	struct vhost_scsi *vs;
>  	struct vhost_virtqueue **vqs;
> -	int r = -ENOMEM, i, nvqs = vhost_scsi_max_io_vqs;
> +	int r = -ENOMEM, i, nvqs;
>  
>  	vs = kvzalloc_obj(*vs);
>  	if (!vs)
>  		goto err_vs;
>  	vs->inline_sg_cnt = vhost_scsi_inline_sg_cnt;
>  
> -	if (nvqs > VHOST_SCSI_MAX_IO_VQ) {
> -		pr_err("Invalid max_io_vqs of %d. Using %d.\n", nvqs,
> -		       VHOST_SCSI_MAX_IO_VQ);
> -		nvqs = VHOST_SCSI_MAX_IO_VQ;
> -	} else if (nvqs == 0) {
> -		pr_err("Invalid max_io_vqs of %d. Using 1.\n", nvqs);
> -		nvqs = 1;
> -	}
> -	nvqs += VHOST_SCSI_VQ_IO;
> +	nvqs = vhost_scsi_max_io_vqs + VHOST_SCSI_VQ_IO;
>  
>  	vs->old_inflight = kmalloc_objs(*vs->old_inflight, nvqs,
>  					GFP_KERNEL | __GFP_ZERO);
> -- 
> 2.43.5

