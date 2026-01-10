Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72734254AF5
	for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 23:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768088955; cv=none; b=T4oP/cFGwFv88rXNG/+flkLmIA6IpDSZAM8+YQeiSiZOvWbjv3KStHVMkJopNHY9lXsCGJ4GWYX1nAsvfj50N+cyqQRPchQVMtGR2Dt1hUQzt6qQTCHButBi4iFayNAoIJp3Colgf4PIon9ha9K9Ufgs1CbpXYda+nAUnqQjnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768088955; c=relaxed/simple;
	bh=g8wCfRbUUXiCJohgKskRoYiN0bBaR39H3saqrlPe6WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Sf+WPJ9HPcbLWKpwNcbz2IDX9bEHbsPCMCexvhX2i2tJdA5dzT9zOOjZGKbQM/QjBphugTaapdS05HQyqgRys05nt9huRyeyegkwggIfinB9VKqbrU2mAnuNs5LR61wOSjSsIkVSLw/p0jt5Fvdt1eiNc/dVd/vCXg6s0hhvlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IcpQbFaY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcpQbFaY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768088952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8xEP+5qvKDlBMCCBF0MgL7LbkuTz0yEVMfMRy9ehdM=;
	b=IcpQbFaYtnVbClPNTf6KH6mzVlaXwm547684GrxoHLIyjeJ16P7ZOFGsTetyOgs4EzFmn4
	euWhyh+5YhATh2hDmjak0PKGwDtCif3VNyJeqrgOd+9b0roEY+8vsVyEvlhpl+yLdMGYBz
	jNkTlEMRyRHlRn1dotYo63YZXcHPId4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-hZr9pFygM6SkR0HMawT6SQ-1; Sat, 10 Jan 2026 18:49:10 -0500
X-MC-Unique: hZr9pFygM6SkR0HMawT6SQ-1
X-Mimecast-MFC-AGG-ID: hZr9pFygM6SkR0HMawT6SQ_1768088950
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fb8d41acso3546395f8f.1
        for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 15:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768088950; x=1768693750;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8xEP+5qvKDlBMCCBF0MgL7LbkuTz0yEVMfMRy9ehdM=;
        b=sY9XRFf9gWrwfgkDMpPA8Fa7AmmsJ+1SHlxMxOYoBrnaIHs0cCas5ECcqNxqhMVTQm
         3sZq1NCn7wYHROwiN4RITbgD9EzLScDXgYkHJbugfBZnU3E3u/g35XcJhe87fiH6h+Kg
         Ms/j0J4GFe4EW0W6yrny8iTvx3d2xOp63IhRMijGqOuAk5Y3hGKVGWKCKFsouJpwnrOw
         7dmT+Inue3wIejWNzmt8FFHtrEZgfdiZqUuIPQfeOjVNcjNDVN/rzFYB8umu+vIDmL9x
         6DhoxWy9AbRHnf7kWSpgza5qDkKUV01eGuTnW2VM4e20/RXrxXgT1VIqjfs/JBXzwnFK
         mTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIfdf+C4x7p8+mfXkhe+7121gUEEOWiMjpBO9psBl0xaZBD1T+ei2NmjRwoFXrO5RzspumYIgywHoXR4+jkg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxwmg08HUqHpF9T4hBcvFxteB+ItDJFB+E2ArbXbQ4LgdlZFSoy
	e26c++awzukdKiahbYvyazZutvFzCB58ZzgbJOeEreWEJnS7smg/bAKRGxThrAhKCPnQe1OAMJE
	hieJHV77gCwBEcM0B+Kte9y+6/5iJ7yaSi/DkWBmJ18pBdiXGI2AW2LW2ymMW2dN+s2bD
X-Gm-Gg: AY/fxX5LRZiHUH2xrCC0tObriJRd0I+YQSLbZF77Di9e3c5YZauCPn1UrRR99K6/Rg4
	iqNlwsWF0JGlT7yeJO+A759uzpg5+2g2huEQ8B8ddT+xPq2yEl26SU1FILxiOsNW/c+zTmn8Wj4
	W68tV/n/Y735tlnVa5lbDvp3d0WhEQyFTZMb5Ch4xQ16ptyUTk0zypJmwKsaUuvByweJdYA7694
	WWit9lCEOguhhdF3RzGUM3IAPzt21Exqhwi/bGYGZfnnfnlXK3K3B2zHvVVBn95TOQ9r4LKxkXL
	IVM4QPtHMeTf1+/VnaO4GKlpHsftS4jyT5h+q+13mfyGwwFbJlt9BI2pjPf3jDS5poxjh7i19py
	8A2n18e/9IG+cUWv3Vg5rcYeHNESwnwI=
X-Received: by 2002:a05:6000:1a8e:b0:432:84ef:713a with SMTP id ffacd0b85a97d-432c3628263mr17160296f8f.12.1768088949667;
        Sat, 10 Jan 2026 15:49:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV+eLxIDz0DYsCmG6rwg47r6evQDgeyRNThqqOHlW80rDw+1cEXxEZiRcZ0FcG6DJxB66hdg==
X-Received: by 2002:a05:6000:1a8e:b0:432:84ef:713a with SMTP id ffacd0b85a97d-432c3628263mr17160279f8f.12.1768088949227;
        Sat, 10 Jan 2026 15:49:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df90dsm30153428f8f.20.2026.01.10.15.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 15:49:08 -0800 (PST)
Date: Sat, 10 Jan 2026 18:49:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v11 06/12] vhost: forbid change vq groups ASID if
 DRIVER_OK is set
Message-ID: <20260110184849-mutt-send-email-mst@kernel.org>
References: <20260109152430.512923-1-eperezma@redhat.com>
 <20260109152430.512923-7-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260109152430.512923-7-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _l6nTABP0bRQ9dH_GPme9WEJCYX-NCG9UUTxRqVe6Pw_1768088950
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 09, 2026 at 04:24:24PM +0100, Eugenio Pérez wrote:
> Only vdpa_sim support it.  Forbid this behavious as there is no use for

behaviour

> it right now, we can always enable it in the future with a feature flag.
> 
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  drivers/vhost/vdpa.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 9d25b735b43d..3f0184d42075 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -682,6 +682,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  			return -EFAULT;
>  		if (idx >= vdpa->ngroups || s.num >= vdpa->nas)
>  			return -EINVAL;
> +		if (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK)
> +			return -EBUSY;
>  		if (!ops->set_group_asid)
>  			return -EOPNOTSUPP;
>  		return ops->set_group_asid(vdpa, idx, s.num);
> -- 
> 2.52.0

