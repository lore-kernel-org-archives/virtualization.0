Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9C192590
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374251; cv=none; b=PNgdj5UqWZ4hNOh/RkREz8tAIcSkDWnSSxEZ15GcKzZ/nlS6eW9QP38X/9bn+NgUiHCbU6LNxOYWTsyNQOBBNnW5wp9qZ+YpYrH6ATIUjtA+K+6/wrQcSGQwQmELaPP86+OlMsbdzX+IIVIuF1O3M4cOKgTaz3cE5+ig0PQYBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374251; c=relaxed/simple;
	bh=i2C431AWV3MMpedKaWKbDwDz6MKWVi4UjKClAsNr2IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fidapbmo+cIVm4JjZtQhQeNF/beosy/ZWWjxYiwlelABLiaWjuEYlr2K4npGUkQxARaSFWbzp7f4bVWWzKbpn4C2CEUhFSQvbKVmXWYJ4Ibr51r6aPxxsFWBjgCMlaysXqvvsFJF2QqCdFshOSJJYyE4E9abiJ5er252aPf68Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lz7VuQtC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lz7VuQtC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763374248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eArzcjJn9ybnU/O3tqYFq7uZLu4LYx0+vTBI5/gonIg=;
	b=Lz7VuQtCaqcR40AKv6ZGgESUjEvG2e7u2LsNcbKxaZ2Gj+KHHHspXkCnTlWFa9j+e2ahxz
	0gTSP5gaMLNtSG2NaLrJhKmS3EwVE+HsAfjG1ELUxjJnCEThwoLjY/oTe3/7fIYXBAI+9x
	19jxUMtr0YUlxNnP5KAwKJ0R1CzkCvo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-mRnNClw6O5-qgn0-BduR9Q-1; Mon, 17 Nov 2025 05:10:46 -0500
X-MC-Unique: mRnNClw6O5-qgn0-BduR9Q-1
X-Mimecast-MFC-AGG-ID: mRnNClw6O5-qgn0-BduR9Q_1763374246
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47777158a85so35556125e9.3
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 02:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763374246; x=1763979046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eArzcjJn9ybnU/O3tqYFq7uZLu4LYx0+vTBI5/gonIg=;
        b=FvDBQYqEafwbnEt+XtDgNIEs9mGw4200VH251fkE3axDSOgmMcpqvilHtDWPDLrQoT
         Cehd10lHks3Bbom9rutMhSX+Z2aisLabPYCSTTnhtOvkgpzjiTGWrfs+zwK0S0fKZHKJ
         FE5dIUTQuc5ph1dpoVvBLm5gATWRR0g+mQyFZH5+wWSWtseAun18tODfGm1enNuWyBdb
         MujgcccU+M4KRsqLKiqKTDmT8mcoQfU+3KzJU6BWn+8JgzGwD8Ss2QIINiRHMWA79Vhd
         +2vIuhY1CAEc83ojR8YGRABxjQWYz1BLsOtCPQh0UfOLzB8HCeJAFkqIus2XX++EDqKr
         8bWw==
X-Forwarded-Encrypted: i=1; AJvYcCWcGnV5eLFY+MVsQrlF0Wp8MC1wz4xF27AV92YFgQdmHxLNKhVdTPymZ/VYKfRabxK1iIxTDY7osdlQUFElGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOueVUrv+qLPNEIh4WufPXUYs/tXzuWtzfvWy1b7Snqe45ke3D
	KF+ikLM9w9zvorgux8hdEW5T5ZHKKsS5KKlgV/jz0+HnFhUPVrA6vhw83B2IjHR5/RCv2AhQzka
	Ha9FJRJsfuZqgu8gB6lVEHiTNb5KfubotFTvIgYmviKxpxF2A0Ayy4d/RepmI+3Q2s+36
X-Gm-Gg: ASbGncs8vUE4tL6h9fv6jgZrHNBb2XO9kqRbR1AGu1rt1UMpmrC9ElHDuLfTmw4NB3T
	4B41CoajiSokcYPU/wDp40gatgI28fJGQHWBi3ScI4aVJVGvBzRRzvbuzLxHbRq9eOE1C+nSKDX
	SOBJ1oXDm8Yvz8L4+akVm9Yu4GzJ3qBw1ClH9kdMun5QYJhP0v7tCq4oj0/X1EioR3pAu0wkjyq
	1OWozdfEZM8HsZ1cLKgzWtLAZt/8+tb0s1JhDEXrCPb8r5CIEKrkUPp7S/YjBmFslpWvM5mZUti
	hwskX1+PeXEY2lxT5yb1S2iHAbv3oDehPDPEqkS7DP+UPrx33mprhRVQ2OlwFpIc5v7QlXdywSw
	A9E7MfjgbARCKvi52CTY=
X-Received: by 2002:a05:600c:138d:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-4778fe5de6fmr118177185e9.10.1763374245510;
        Mon, 17 Nov 2025 02:10:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQwB3mdw4knFtBHpSv9qNb8dra726Apakly9X80MT3rt8wljWIcdGp0HNihzcNUvrSIfeZ3g==
X-Received: by 2002:a05:600c:138d:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-4778fe5de6fmr118176805e9.10.1763374245069;
        Mon, 17 Nov 2025 02:10:45 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e45677sm304410285e9.8.2025.11.17.02.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:10:44 -0800 (PST)
Date: Mon, 17 Nov 2025 05:10:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: wuzongyong@linux.alibaba.com, arnd@arndb.de, eperezma@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH] eni_vdpa: improve IRQ error logging for config vector
Message-ID: <20251117050536-mutt-send-email-mst@kernel.org>
References: <20251018191502.1516313-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251018191502.1516313-1-alok.a.tiwari@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZBYwTQ67-2AqaLykl0_p2bW1ySwYSALlfAkLQDjkpjU_1763374246
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 18, 2025 at 12:15:00PM -0700, Alok Tiwari wrote:
> In eni_vdpa_request_irq(), the error message for requesting the config
> vector IRQ prints the loop index i. However, i is only valid inside the
> queue setup loop. At the point of requesting the config IRQ, i has gone
> out of scope and does not correspond to any vector, which makes the log
> misleading.

It's not that it has gone out of scope - it equals queues.
which happens to be the right thing to report:
        irq = pci_irq_vector(pdev, queues);

both the code and the message are confusing though,
I agree.



> Update the error message to print the actual return code ret instead of
> the stale i value.
> 
> Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index e476504db0c8..e3b20ea7c423 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -196,7 +196,7 @@ static int eni_vdpa_request_irq(struct eni_vdpa *eni_vdpa)
>  	ret = devm_request_irq(&pdev->dev, irq, eni_vdpa_config_handler, 0,
>  			       eni_vdpa->msix_name, eni_vdpa);
>  	if (ret) {
> -		ENI_ERR(pdev, "failed to request irq for config vq %d\n", i);
> +		ENI_ERR(pdev, "failed to request irq for config vector ret=%d\n", ret);


you do not really need to print err it is reported up the stack.

I would probably go with:

		ENI_ERR(pdev, "failed to request irq %d for config\n", queues);



>  		goto err;
>  	}
>  	vp_legacy_config_vector(ldev, queues);
> -- 
> 2.50.1

