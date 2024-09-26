Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6913D276
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333174; cv=none; b=UzvxtoW3HFUyjG6qE1w98WffsMqDIDm3k+mzlzXn6vbSsEOBwFNUKbylyYVhKlcDRjEotsYCDsP9frdwmr6O5KcKK2/jfIdsrtQVO35NB2GVWBWI8vKoGrywY2XhKgfp41+CCaKfdm26eIp+XDU80iX+A2TVpfVMtdB+DMTfl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333174; c=relaxed/simple;
	bh=/BkQATAz/sVxKy3t7GyVG/atcZOaBkrw3XuUSr9Ybyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V6n6JuSkiThRC3cFN8mGYlITixdhLXywM2W+EeJGuY+l9wz1Enxihdi0nNB+TOXvBhAUumOYHgWPLM0lDnCnj9aDU0FfvCKICYNxsGlRwrsFJdDfhgdbNSP0LiFoQIN1JcjvLMFjLlXH8n9fWZg8BSFhA9zSlIWFyuhCXXEKUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aN3zhvB/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aN3zhvB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727333171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4lMZrO1KfsraCg6U8a5z5qex1i5fmU5LWdWcG00Tkz0=;
	b=aN3zhvB/bkp+HH4oX/rD6tYCmUZOXJBadnYpgq7v6YBnE8R0M1g8xnPzDtbi3r2ysqiJCH
	fQkUI84rQa+94WFN7FYrqWrTXNfuH5fEQJ9NrvFx9vDW2UrcQb591+rIeNPm/4yFoUqxkx
	uy8BbEX0URLjGSLzNNIR1BnnnhmJMas=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-yGRrgPWiPZyVmi-r8XI3xA-1; Thu, 26 Sep 2024 02:46:10 -0400
X-MC-Unique: yGRrgPWiPZyVmi-r8XI3xA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37ccd14a2f9so253112f8f.0
        for <virtualization@lists.linux.dev>; Wed, 25 Sep 2024 23:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333168; x=1727937968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lMZrO1KfsraCg6U8a5z5qex1i5fmU5LWdWcG00Tkz0=;
        b=blGZvdnk7pPDNw97+93UAFoYyYWR6jdYHUCMnng5KpAWzzvdqREt77T9h5yY+dUnoT
         V/c2OJ51t/cx+vLSqkyE6S5400/3x0Nx4dg4vNnrzCN3ZJDTI4Qj5AJHSLBq/BM0FQCa
         W13BBIsh3ZVVWIthuUGSVI47RlVPMli2Dhv4a/zIjJ9TppB2xjj+Zah1KCct4Lh4ikeU
         x28H84u/Sl2j1cmZKjWRz22lgL9rKEoQtHItHrBgB8ZT/EMLpxW0kIehOhNrr2qP3Oyq
         WgbhW+PpfcGGr+HIdstUAXY5KVrK+oKwjm07fknjugotMhD5d5iy/iXVqsMDLiCRlqKg
         GJXg==
X-Forwarded-Encrypted: i=1; AJvYcCU8C9p0oZGoBlY8Q6eBnPmylw6gCReNhBfrISzrFOPT9K9ggH+poDtFi3Nw6xd1569C3Pc5Rcsj6Teg6maMoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGzIwzyJLMEEi8+IjgEEzEx7qBGcMojLp5JBfQVmk+thOkg8Hb
	iALXT1tdqUeHElSJUyb9cTGEn6bE7RYSyiXB/Ru6Asefv0O1SwDq5WBpr1aGRBjeZSJsJPunAoY
	IVLme5njSpXeM+vXPc10WCnKWLqlfln3KVPKfepiboHEE2/oSeEyCNuTFDJCumez6+jwf2uEc
X-Received: by 2002:a05:6000:1f84:b0:371:83ac:fec1 with SMTP id ffacd0b85a97d-37cc2467021mr4454936f8f.1.1727333168185;
        Wed, 25 Sep 2024 23:46:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiRkwee1QUFRu3Pcb+9KBe5iD4MejM1AvT+6Kdu3epPqHMM8uj/HYYLmwP5b9vTa/V+bzW+g==
X-Received: by 2002:a05:6000:1f84:b0:371:83ac:fec1 with SMTP id ffacd0b85a97d-37cc2467021mr4454921f8f.1.1727333167742;
        Wed, 25 Sep 2024 23:46:07 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:1ead:3828:4c0c:a50:df14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a3622bsm37811515e9.35.2024.09.25.23.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:46:06 -0700 (PDT)
Date: Thu, 26 Sep 2024 02:46:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jianguo Sun <quic_jianguos@quicinc.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev,
	Anant Goel <quic_anantg@quicinc.com>
Subject: Re: [PATCH 1/2] Virtio: Add CONFIG_VIRTIO_MMIO_POLL_RESET
Message-ID: <20240926024409-mutt-send-email-mst@kernel.org>
References: <20240922123435.17946-1-quic_jianguos@quicinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240922123435.17946-1-quic_jianguos@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 22, 2024 at 08:34:34PM +0800, Jianguo Sun wrote:
> Add CONFIG_VIRTIO_MMIO_POLL_RESET to as an option to enable
> synchronous reset for the MMIO based transport for virtio.
> Change-Id: Ifa7e29b4c0cfa26922535f921c6ab69eacdc4cfc

Don't put these in.

> Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
> Signed-off-by: Anant Goel <quic_anantg@quicinc.com>
> ---
>  drivers/virtio/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 42a48ac763ee..fb17b1078d53 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -188,4 +188,12 @@ config VIRTIO_DEBUG
>  
>  	  If unsure, say N.
>  
> +config VIRTIO_MMIO_POLL_RESET
> +	bool "Virti-mmio device synchronous reset support"
> +	depends on VIRTIO_MMIO
> +	help
> +	  Say y here to enable synchronous reset for the MMIO transport based
> +	  virtio device. After writing 0 to device_status, the driver must
> +	  wait for a read of device_status to return 0 before reinitializing
> +	  the device.

I see no real value in this config option as defined, users will have no
idea when to enable it. And you definitely do not want this
as a separate patch, you are adding an option but it does not work,
then you fix it in a separate patch. No need for this, it's
small enough.

>  endif # VIRTIO_MENU
> -- 
> 2.17.1

