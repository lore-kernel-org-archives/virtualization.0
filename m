Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF8378D6B
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878387; cv=none; b=HwrmlBULYjzJxf0lhEErt7DxCybaS2HNfJF/lskULwv/SG4sopVmQmM8xctXtz8Lc7x/YdlV7VrhW0vM1uyY/ou1e6YRX6IKXfNoAASJ0nLAcNYjhOgtcX7zM0dgZJG25NvkiY6mpScw1CKA/pmQPz3UF4YN7lnIiqcbQeIh1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878387; c=relaxed/simple;
	bh=/AMjJkwmXepaiNPW211uL4M2QxKkm9iBVQbvs9W65Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ufjugjTd5miVDISfkR5McXiU1FfUUG5eZwcMhJoG2sqfGs+HeUFF4Q1K43LYZyLWc4BW54LYCSfuzyn8RR1e55uh1r8FMKi7oz+CUFv08wbf/6MP110Rpnwkf41C1JhtDAzcxrRsnzaViChmB5pFgzyRk2ezijO2J8bHIYDSFgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6l+Wsnx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6l+Wsnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785878384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iEFMTqOdO4uNqL8QNG/Z4Re63pCP40xKpdmxCirFV8A=;
	b=R6l+WsnxGTNczYMr2KWrd3bkP1lGsNmcETeVn3KMaX2zbanFJlCI4RKCJ/J8yvlJ/OVCxt
	trEENWVgwIo9cqI13OCGpNZBz9db9x09K6nEQB8JAxKQPHrv1xuG/pPAMZ7ZzfI8rWH+d1
	WUN439pxzMnGDW5P/R8ioOVSelkj49c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-NdE8jF2lOy6S-AkVwctrSw-1; Tue, 04 Aug 2026 17:19:42 -0400
X-MC-Unique: NdE8jF2lOy6S-AkVwctrSw-1
X-Mimecast-MFC-AGG-ID: NdE8jF2lOy6S-AkVwctrSw_1785878381
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767b782so1416225e9.2
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 14:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878381; x=1786483181;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iEFMTqOdO4uNqL8QNG/Z4Re63pCP40xKpdmxCirFV8A=;
        b=JssZSb81nd1Sw8Rgr/vFca0B6tA2RMDEqWs+oNfeK5PmzAvZMphzDaeqG64Gp4alpI
         1JbMLAMC7J7qeQW3qNGlN16BeeiOG7V48nb0Co6azIoALbTmj/xHZIPk2Nx39YwK5fO5
         6m1cp/+La9IPT90kYaUp8znzNd0g1O/obRbZ4KYPdCkEcu1lEn/lzX8q80I0+9M+hkz/
         2OUdVpg90FlJCdpRJjwmVWzWgcYbTvv+wIlArRJa4OwsiNIFts1Lymc6ReO7FVerNQmI
         knSlNb0qlKOEcZVvW+ipAMa3On6iWx9EsTt41sxDf2YAqYTXCrt/YJa1tmTsgeh49Mar
         RFAw==
X-Forwarded-Encrypted: i=1; AHgh+RqNsBmspu28qk1UVPz6gpM8bCY/OZ3+YZAm4L4sMF8F3zkupNUGmDrJkjlHIthhMhM4eQCVSkKOiz5llv1Bsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBmV+EtluGsowuNI/epaS1YrEW491sk2FToINU0I+8LOmA9ybG
	7y1FedmOgHj5VgrNpPGRo0w4LULd3nqvC/tAqI+3PFiHo/roTfbWeQ5lwPAfyNzTx5QAf7Mg4gS
	8If4PNAwW66gTkMd6HAi3hGWFyawaj/v+2Wex95oq2JxEH38f+pwI8E4cnnYfQ3XAA2uT
X-Gm-Gg: AR+sD13+s4oXvKuGq0RpXv1C3NRWxdsCinpeM4lfWAy3e0ViMxflUG9KcBqhFW3nZjJ
	c8zUFrHnDfdGVmjgYb/wgDrpsae6mkkMUDT+W+Xa+6qXTFeQpU4RGtm9zAgG4xpjppFGUsXQTp0
	AWlnEYl4cUnH4aphVN1N98nZRtgPf/tRVHLA6Rk/c+6RDs5Qeou+io+pNs/miJFeG2UD1s4qHRN
	lslDfi+uKIQZdgMhrUoxpyyxw2t1I1OndRkUqgzSAzYPRGufkIa/Wn/SYBzHEU97ou8TMpnZM/w
	T+attdrXZ/6lhUs1J2tDzohCQ5G8rBcvi4n4+dEcWefacSO9ndEcfgGvafGUEgAmkBiPuINsvrc
	ZUb4d3aFyBk+R6XoZ//ZQKw==
X-Received: by 2002:a05:600c:35d0:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-4994e7c5ca9mr10783815e9.15.1785878381441;
        Tue, 04 Aug 2026 14:19:41 -0700 (PDT)
X-Received: by 2002:a05:600c:35d0:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-4994e7c5ca9mr10783355e9.15.1785878381053;
        Tue, 04 Aug 2026 14:19:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994dfda45asm41924895e9.4.2026.08.04.14.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:19:40 -0700 (PDT)
Date: Tue, 4 Aug 2026 17:19:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa: solidrun: Free IRQs after request failure
Message-ID: <20260804171850-mutt-send-email-mst@kernel.org>
References: <20260804092617.1344317-1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260804092617.1344317-1-xiongweimin@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nHqeHpf0MG6AFWvzkgeGv4_VpwWbXOlKhjnL51iHXGc_1785878381
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 04, 2026 at 05:26:17PM +0800, Xiong Weimin wrote:
> Unwind any IRQs already requested by snet_request_irqs() before returning
> an error so a later retry starts from a clean state.
> 
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>

Here too. Pls tell us what is wrong and how it is fixed. E.g.:

Currently .... This is a problem because ... We can not do .... because
... To address .... And then ....


> ---
>  drivers/vdpa/solidrun/snet_main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
> index 28d55315d..aa3ae3876 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -407,7 +407,7 @@ static int snet_request_irqs(struct pci_dev *pdev, struct snet *snet)
>  			       snet->cfg_irq_name, snet);
>  	if (ret) {
>  		SNET_ERR(pdev, "Failed to request IRQ\n");
> -		return ret;
> +		goto err_free_irqs;
>  	}
>  	snet->cfg_irq = irq;
>  
> @@ -418,11 +418,15 @@ static int snet_request_irqs(struct pci_dev *pdev, struct snet *snet)
>  				       snet->vqs[i]->irq_name, snet->vqs[i]);
>  		if (ret) {
>  			SNET_ERR(pdev, "Failed to request IRQ\n");
> -			return ret;
> +			goto err_free_irqs;
>  		}
>  		snet->vqs[i]->irq = irq;
>  	}
>  	return 0;
> +
> +err_free_irqs:
> +	snet_free_irqs(snet);
> +	return ret;
>  }
>  
>  static void snet_set_status(struct vdpa_device *vdev, u8 status)
> -- 
> 2.43.0

