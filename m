Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4789B1E990E
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430683; cv=none; b=plvbcxqp90UAzx0n6htz8MpLsDvMhLAJ08yFVihCyBrM80fh4C1z/7VeAPpY1eAYZx4GCskeQOLEoXwvYuizLQtIdTIGAYSCEQCCPNfNCvQGeDneiV8jxi1IIe/qLaterZmw4bYwVpksX5a+KlKCkfaG6oH6gZ0c65NjJxS3XtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430683; c=relaxed/simple;
	bh=dl7eQ+b13oFLr80NeiLiqkJZOxJwGG1XmIoZO6RrQ3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jtMBRpN7XtSkg3rAFpfxwMggraOyWTdLbUJuUEHhfCLlMkVjfeN8fyH1XsNv3KSnmeOoSiZpG42wZhoJuq3eiMN5hVlVCBweA4HGkUz36rqFTLNkXdkNFFjjlwcmA+NWqTIKI2IeW1CN8SBtg3Z9Ynz6DRQIzfddHlX6Q1a/Rlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Quk/iTqZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Quk/iTqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760430680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0qnbsdsNEBiaoT6uBRZDY8lZKyqNtV82DBTRjkp/dSU=;
	b=Quk/iTqZ9WjYZXH2j/L4a9hUuRh6Eq+hpkh5jGPEDdSjL/FJy9/OGJPLRRDAFQHxNEGSI9
	KJZ+jIYQAAxHw7DAEYL4IB8PapcwIG1n4PDzR0kw0K1T8qEvNftZw4pCXfjFuPXdueCaRt
	lkxnvyNwgXvNk3rgXtDOnPyy/mMZpfI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-5SwSPO4DNOCxiRnyXWkRMQ-1; Tue, 14 Oct 2025 04:31:18 -0400
X-MC-Unique: 5SwSPO4DNOCxiRnyXWkRMQ-1
X-Mimecast-MFC-AGG-ID: 5SwSPO4DNOCxiRnyXWkRMQ_1760430678
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-426d314d0deso2086892f8f.1
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 01:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430677; x=1761035477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qnbsdsNEBiaoT6uBRZDY8lZKyqNtV82DBTRjkp/dSU=;
        b=mwvM3qDMv55wuziz95zZmSWxxmNohJBQnMToxq1/Ovv6r5V73SCeVIf+BfhnQSmvcW
         fNXdO+QnvD5b16xkIUmMODx6z0cGlra4aTJKa1pycqNbqboO3Q9Fz83DXx02+wJUT2Cn
         X08ZOs8kYbEx/VIOoe2UAVBLG1dXeSU1cqzVjmSHlQj+zk4QnLIcSCAYk0Eb0SNzRs68
         AA3lTL7ikhqBNUJBl6JwxCq7lQnVpyv0HlTNYK25vgLza+Lj+t5hFeJuEkdBwMbNJOz1
         0U8s2MPxidAoZ3IsFDuakDw0finE9iVPQYP4oSS2tiPUjj1LgCghjPmFMzzlDdKE13Tp
         pBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDLwrpI9YJ8B4+Llq0WeSjTcZoP2TNVKXVYHja18fbYaCYnMlxQ13nMgwImAlnYbJ6SX8x8U3R495y4Fz9gA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFAmpcZCudrHO4s+5wmUHvaWMWFmb7uM8pDHjbS5tcxlr3OrzA
	qDNdHujaC2ISccd7zO1haxAR+rm7oJnekTqXuuBfJpuQEe3dV4GS/52X5VwdioJzBZQNFFH7dW6
	XrcJ4gX0bQx1HYaNL+T7Ko6QddAd3XSjbg4JjohOWbfz8rf0I3qROGZlPwrohpOp5xisj
X-Gm-Gg: ASbGncsnqn+lNZfBN0t8SisMx191rN4xn6XlF4msB4wY2BwSAPZscgDXPPLLS0chuT5
	rGQ4AS9nhKE5zKQvynNP1TBJTAKCFxUph38xGsiRnlljm+O9+abLrSaKkNzX0YI09mSJIgO0xIA
	L6yPV0djCXFfnIivftMvxgS+iHzfIWfdVPTTwFFR9f9SjlopY8d/2clb5kOSjWs4UVWSIeTXsAu
	gOvclfCqaOomCTMBd53ZHtkQSuTFpNJ4u1h7mSjOU0NW2W34XQVK/ICb7z19hj+HLZT9G2PeRjU
	ci4nbhI9/ynU1c4CIgzHVCSYOul/4HlrcQ==
X-Received: by 2002:a05:6000:310b:b0:425:7f10:d477 with SMTP id ffacd0b85a97d-42666ac2dcamr12583054f8f.2.1760430677537;
        Tue, 14 Oct 2025 01:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5rtWAPwA3LVdjHzFgAx87oQUT/zkUwZOwVAGCG1V+BPu6h5CRzzoQhKXDFi76mKqYg16BxQ==
X-Received: by 2002:a05:6000:310b:b0:425:7f10:d477 with SMTP id ffacd0b85a97d-42666ac2dcamr12583039f8f.2.1760430677130;
        Tue, 14 Oct 2025 01:31:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8207sm22040471f8f.47.2025.10.14.01.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:31:16 -0700 (PDT)
Date: Tue, 14 Oct 2025 04:31:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 2/2] vduse: lift restriction about net devices with CVQ
Message-ID: <20251014043004-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-1-eperezma@redhat.com>
 <20251007130622.144762-3-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251007130622.144762-3-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rCoCuSqeKQ7jbm-X16aOYhqZsc0u4Bm-0APfG_Xtg9Y_1760430678
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 07, 2025 at 03:06:22PM +0200, Eugenio Pérez wrote:
> Now that the virtio_net driver is able to recover from a stall
> virtqueue,

it's not able to recover, is it?

> let's lift the restriction.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index e7bced0b5542..95d2b898171d 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1726,9 +1726,6 @@ static bool features_is_valid(struct vduse_dev_config *config)
>  	if ((config->device_id == VIRTIO_ID_BLOCK) &&
>  			(config->features & BIT_ULL(VIRTIO_BLK_F_CONFIG_WCE)))
>  		return false;
> -	else if ((config->device_id == VIRTIO_ID_NET) &&
> -			(config->features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> -		return false;
>  
>  	if ((config->device_id == VIRTIO_ID_NET) &&
>  			!(config->features & BIT_ULL(VIRTIO_F_VERSION_1)))
> -- 
> 2.51.0

