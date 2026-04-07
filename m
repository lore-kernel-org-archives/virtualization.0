Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9B3C9441
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578825; cv=none; b=B+LfkPUW4mnLLoYYxCRC2HBizIJYaR+jAyXfmDyF4MFFhQc5kTaXlrK6Qiqow+4H1U+KxfrLVxyRh9SAoFap1A0stfNHxiUNBp7PCTfp5u6TsVwIwFMMuVJz1fC49K358f85vvsX8pK+tQ18K/JVZXycKxDRViNsn4jl9M+mUAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578825; c=relaxed/simple;
	bh=qjKUh2/c0POe6itGY95pjhkErKbuTGfwNl6OlzliZRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HN1zjPNv/1sNdNMj6Y+bIu2yzKsQ3m6gh6CH5Lfh8BU5KWTkQIT69OFbEjpXrIa7GiQRNmitmDR5+0L4oLU84wXUwV5kw/efEiE4XSQBJhhwEg23SgEIO+I0eN9218/LUHGMi+G3h5SsVbXsQR35tKQ344PKsIe5pBXM6s/1MtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6Wg/RFe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6Wg/RFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775578823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdGxlbl8syjfTgQTMXZ1ljj0hjjObSL9cmEYj7pJ2aA=;
	b=S6Wg/RFeYQAL0Kslb+xl/scoALlwPDj60UxLF7+ZVD8pLlLSyxz03sai8EdNgGLNO3uz0E
	05L81fRfc3TCk7bh2nh9d2KFin3fJVXf5A67ovlbADmg8bd9HNQJncLgdwFtDK8MU5FhLv
	50lYKpLwzRaUIWoNk5K0LjUIIGZbics=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-314IcPTbNdWZvGwjMTAnLQ-1; Tue, 07 Apr 2026 12:20:21 -0400
X-MC-Unique: 314IcPTbNdWZvGwjMTAnLQ-1
X-Mimecast-MFC-AGG-ID: 314IcPTbNdWZvGwjMTAnLQ_1775578821
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ac04b2fc4eso47455476d6.0
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 09:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578821; x=1776183621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdGxlbl8syjfTgQTMXZ1ljj0hjjObSL9cmEYj7pJ2aA=;
        b=VL77FpQ/B3RkKKhs1ohDwiTquKcRT8YYS30jOCPQPfFWgjaXBWXGr/AN2a0If1KUL4
         AC1MAIRbm3l6zT71etUqVmvOe/U33Xd7FaeIKrMGgQ1PfD5r+WgFJT9mH51cub+obDZE
         UtzCh4qDIupM3w6h6rPmvj8/T2YphpmDKySy7UF7vDpbV13BFxzTEGOUh9vmRfO66XEH
         gDJmO5gp8OSL6o99w7KPtjVLTvOVc5jJBstNl9RBGKS1WijjgJSGFbo/7AU0mYahPIGk
         PkHaWJeKTDNksQjpqYxS3kjiAF9X4IKHjzNnrZ4JO0yElVadrg0q2zyUJcrc919QKR9s
         HXzg==
X-Forwarded-Encrypted: i=1; AJvYcCWSYujHi8FcEosBGp21KDogrVmxRY4mXyIahLI/QsykaTIslUXCNlf2LQTdXaVYwdVocLwOK4elU3n5H+96Ug==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxdw4DnmxhvhnmXWOtOqYKMckFwV9UB2Y8oPREmUpNGlJ4rBSGt
	kFlY0IvNcjb2vpiHlLw88PMSs6likj8theImpwu4jdUnkSR7JrM6uTW/AL2yaRFGhAR0qNPHa8Z
	bPsqg+h6lpQuvPCRHmtQfX4/spW++KdLwrewF3x54R55GPyjR6iIZS3a9C44ACDP8o06E
X-Gm-Gg: AeBDievqZj8f1+jBkARR/fX4EodDmySss8JJDSfGoFN5qKVXX8cYnKpLcXdPv7xZ5IB
	xx26gSMT6b1vYWnGnmMDtcEaTUMsDVehqhIEychQ9PBmH5tS/AekcmmuSPIx8uQyk1/Yx7CwkQg
	It9OyR+5e4zt7oka2YwrMFypvDG9B/5rHFQsKcQXnVJSh4zG3PA4R+uYp9Ar5xd+fkLPFmO7Fnh
	0V1jA26c9dfVZpk+4IV8n7Wxbguu5XFF3M1KTEGUi38RsaKGgfNlZCs9ckI7I95OBHpIU+BD4rJ
	4llRCyKcoEb9XTSecmGOUCbcMsFfL3aknn9T0CfTib8rnOOjj14S0OHP6KEy7Jbq/+QpretlDsK
	SZPb/EV8vlUtm
X-Received: by 2002:a05:6214:4703:b0:8a7:3317:6043 with SMTP id 6a1803df08f44-8a733176356mr247961416d6.3.1775578821062;
        Tue, 07 Apr 2026 09:20:21 -0700 (PDT)
X-Received: by 2002:a05:6214:4703:b0:8a7:3317:6043 with SMTP id 6a1803df08f44-8a733176356mr247960916d6.3.1775578820498;
        Tue, 07 Apr 2026 09:20:20 -0700 (PDT)
Received: from redhat.com ([37.19.196.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5977e00b4sm148842596d6.47.2026.04.07.09.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:20:20 -0700 (PDT)
Date: Tue, 7 Apr 2026 12:20:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 3/4] virtio-pci: return IRQ_HANDLED for config-change
 interrupts
Message-ID: <20260407121906-mutt-send-email-mst@kernel.org>
References: <20260407123904.6390-1-astellman@stellman-greene.com>
 <20260407123904.6390-4-astellman@stellman-greene.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260407123904.6390-4-astellman@stellman-greene.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U3E6IzhAXqT-nOv6Ds4t-_t_R4vUrk5-Fm7YG6ATNhM_1775578821
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 07, 2026 at 08:39:03AM -0400, Andrew Stellman wrote:
> vp_interrupt() unconditionally returns the result of
> vp_vring_interrupt(). When a config-change interrupt fires but no vring
> activity is pending, vp_vring_interrupt() returns IRQ_NONE — even
> though the interrupt was legitimately handled by vp_config_changed().
> Over time this causes the IRQ subsystem to flag the line as spurious.
> 
> Track the return value explicitly: set ret to IRQ_HANDLED when the
> config-change bit is set, OR it with the vring result, and return the
> combined value.
> 
> Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>

Fixes tag?

> ---
>  drivers/virtio/virtio_pci_common.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 0b9d66b..1d1ab02 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -106,6 +106,7 @@ static irqreturn_t vp_vring_interrupt(int irq, void *opaque)
>  static irqreturn_t vp_interrupt(int irq, void *opaque)
>  {
>  	struct virtio_pci_device *vp_dev = opaque;
> +	irqreturn_t ret = IRQ_NONE;
>  	u8 isr;
>  
>  	/* reading the ISR has the effect of also clearing it so it's very
> @@ -117,10 +118,15 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
>  		return IRQ_NONE;
>  
>  	/* Configuration change?  Tell driver if it wants to know. */
> -	if (isr & VIRTIO_PCI_ISR_CONFIG)
> +	if (isr & VIRTIO_PCI_ISR_CONFIG) {
>  		vp_config_changed(irq, opaque);
> +		ret = IRQ_HANDLED;
> +	}
>  
> -	return vp_vring_interrupt(irq, opaque);
> +	if (vp_vring_interrupt(irq, opaque) == IRQ_HANDLED)
> +		ret = IRQ_HANDLED;
> +
> +	return ret;
>  }
>  
>  static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> -- 
> 2.34.1

