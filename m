Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF61E379B
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673540; cv=none; b=apv9OQ3HAq5HQLf5SQNf8mpwouUd8BYSpSdoPFSOZtBa+bkMjsV+nJwM2mioTuMuri9mH0MA3O/WBSr0GDR5lQ4eszdadZ8vINAT9Fzf4bPwpNFbNeZJyDDM3Rn3mYMQOdj46R6SQT50/hGl4BeJxFw+a0XwR4Wwg3bz+mRqcxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673540; c=relaxed/simple;
	bh=MPg4EE5I0+tMhvOJhfhmxHTCL0q9r66jTiHCRaj/jH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eX2PxaG9wP6N4KAScqz6uIFhIGh7E6lWebZ1C5GkFNoAtlG9wPftJyU4UHpx4CL2OZy3NLFPO9JgMIKkAfU2M+OlXWeIXn428L7YIUN76TWMWH8XHpEsP/q0Sgn7wG+WmGrs5W15+Cb2VQ48TPUdEuPiqBQXfuta1/pWZPGjaR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7V9bvsT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7V9bvsT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752673537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BzG4s6GH/MRwK8y3gbFMVIDxtkMeQaen3c1mJicjw+4=;
	b=U7V9bvsTOQC/mJbXUBjoA6qPAHiZcZketMvOeAv2M1L6MnDxRrBsHzF4AEF+4by2isGNn9
	4pL4lKHi1MzNJKm+7kECduFQa0+apHEwXLaMg3BFEElRDe1hnRgzG/EZWADJmUnt0VrYWr
	cbLN3AgsqXzb4KbSHw28LR3Stkjbyls=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-SWyGaGf-NDaj0Haq6958vQ-1; Wed, 16 Jul 2025 09:45:35 -0400
X-MC-Unique: SWyGaGf-NDaj0Haq6958vQ-1
X-Mimecast-MFC-AGG-ID: SWyGaGf-NDaj0Haq6958vQ_1752673535
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so4875712f8f.3
        for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 06:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673534; x=1753278334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzG4s6GH/MRwK8y3gbFMVIDxtkMeQaen3c1mJicjw+4=;
        b=pLQGDGj/zNBt60gJeQAnzpDijXmR+wkLIkiSHEOtgUupZlxL8LX5ZCvLT8j0U5Sc/Y
         KKpubAO0WkQH44i/qDkJ5lGsqV1GRDcbEpufc4NVGy/JvRy6sehUwOs1GHlYGbApFovG
         si/ZsoVW1+geOwzEUeobSYtFe6CpvWnnByflsnQiowrkbrvNrT36Ra2UOGRrxIyFnhTg
         kgOCDRCWXK8+b2jU7yHUkxBL3WhBVeY+6dEoC2gSnDcQlipJRfXNwh/9TviFYtKQSQr8
         lxKFGIhc3v7qBL6vq6lsfM6UkiRTusNri8Bebmpdu6O1AXl6HwAISYwVPxKIxUlmGD4c
         rFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUzI2ESb1+ivf3eFHzPq6s4XEXVOEMkREjO/MVM9qbvo+THFW9mC0p1Hn/yMAFRsonz/DtAhkbF8DLQ2bgeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwI/rpT8PPuTY4Eu17wSQgs3krVg/HP6R+WdVo6eqlW1TuIXwEh
	DBkLrotoeAAH3dQZu2hRPims8tZajC+ZDvJ3ATGo8ZJEkM/lumuT4hmPEbjyTX/4eRESOCThSyH
	fRsqNtZAjRaZRr2oPpQZVwxwMKDuhm4vF/dYrAv3nlHaPchourCvgQyNhD3ICzuuVsPWa
X-Gm-Gg: ASbGncvx8yy4wRrZs5Xu7DkN+Q7WkN36S3yroyhwaTDsy6kkSbIBpk5seL4a2TfxjuQ
	KaSgLMxx6mQBzqWGbqskujQt3dyTh0nf0v84LQRXmCsR4W5mYUx8B+JuLE0qxTauFGZmoVzlFUM
	KSLmK9qDYEQEwo9JtyRu56AB26tHYoUeFJjviMPsmC5ilMIMmB6P37p0Pf3Ia3B4dUdfmaUjiIP
	CRiZ49/zYl8kmrwwC+iN154Ihzf3ughCn2iDnga6ZswiN/jR4951tPk1pK5oo1moALT435Lr+Um
	IwwKlfEDiO2Ovoz5wrMUnBRqkm1MZJu1
X-Received: by 2002:a05:6000:43c8:b0:3b6:936:976c with SMTP id ffacd0b85a97d-3b60dd4fademr2281064f8f.17.1752673534494;
        Wed, 16 Jul 2025 06:45:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDl23G87l0xWrShlZkzWfmkRE81fr+mwiy+IsaH40FgxN7MhRFtfKraLRaKD+dZPLwNm5OLQ==
X-Received: by 2002:a05:6000:43c8:b0:3b6:936:976c with SMTP id ffacd0b85a97d-3b60dd4fademr2281038f8f.17.1752673534057;
        Wed, 16 Jul 2025 06:45:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26c97sm18146038f8f.90.2025.07.16.06.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:45:33 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:45:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com, niecheng1@uniontech.com,
	guanwentao@uniontech.com
Subject: Re: [PATCH] virtio: virtio_dma_buf: fix missing parameter
 documentation
Message-ID: <20250716094357-mutt-send-email-mst@kernel.org>
References: <241C7118259DA110+20250623065210.270237-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <241C7118259DA110+20250623065210.270237-1-wangyuli@uniontech.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6yEkhZz5x9ndR9Wdt6kkwKCFbx4ayHZ7iDhKiMxQd2c_1752673535
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 23, 2025 at 02:52:10PM +0800, WangYuli wrote:
> Add missing parameter documentation for virtio_dma_buf_attach()
> function to fix kernel-doc warnings:
> 
> Warning: drivers/virtio/virtio_dma_buf.c:41 function parameter 'dma_buf' not described in 'virtio_dma_buf_attach'
> Warning: drivers/virtio/virtio_dma_buf.c:41 function parameter 'attach' not described in 'virtio_dma_buf_attach'
> 
> The function documentation was missing descriptions for both the
> 'dma_buf' and 'attach' parameters. Add proper parameter documentation
> following kernel-doc format.
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>


Seems to be a subset of:
[PATCH v2] virtio: Update kerneldoc in drivers/virtio/virtio_dma_buf.c

can you pls review that one?

> ---
>  drivers/virtio/virtio_dma_buf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
> index 3fe1d03b0645..95c10632f84a 100644
> --- a/drivers/virtio/virtio_dma_buf.c
> +++ b/drivers/virtio/virtio_dma_buf.c
> @@ -36,6 +36,8 @@ EXPORT_SYMBOL(virtio_dma_buf_export);
>  
>  /**
>   * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
> + * @dma_buf: [in] buffer to attach
> + * @attach: [in] attachment structure
>   */
>  int virtio_dma_buf_attach(struct dma_buf *dma_buf,
>  			  struct dma_buf_attachment *attach)
> -- 
> 2.50.0

