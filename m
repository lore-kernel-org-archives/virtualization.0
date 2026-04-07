Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB335BDBB
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578923; cv=none; b=rUWhpEi5V76KBHTVkKN/kqgXFNAfgvc9w9GuJVjjJjpzEo7X7/Zz2cQunGLiNAvOD9D49hYrE3pGoZWskrmWoEzvr0QfdYhjB3/lffYuyLyKzW6oAldyFmzIfRE6s3BnSoI8EfyUn6eVxxeLKS/R3LX3eqLzwjoe0Mq+sr9fgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578923; c=relaxed/simple;
	bh=u8wI9hTscnvuSfzk49DVot7IJ4FsolONhdRDQ5uzIr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nMzo9jk3CEo79aL1rHi68QnRjVNA12QZpCmdsg3Ss3pMFQa+wYcW+oRfxc4eDBvOqezYdNG31ktFFKXfglAH13eC3lO3DdMexrAEA2wAaONvUKOt2JHR0ti+uqGafYrGWjrqGJh12gDodd68t2QJmceB6AlaOHKEqT4IcXxgVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8AaJ12P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8AaJ12P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775578920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGHajfexAnXrxSzTmQi5iS3YEGjNR0TJQImcUVg5Ums=;
	b=N8AaJ12POCUIxDGWFmwbqvA3uO0CD7zw5/AdxFmFiqnEItYdJ2WebuS9pYZJH8NzAfqdb0
	M/SAGY5mL4YMs6CWm6tEh/h2aWyJTRcm7jszOQeu9e8KROL4tDfmm6C7tw2hbKBBtqIHPY
	gEFRTx3rYNUC95gWM1BeNWWZol0/WWQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-nv3RK5PoNvCI08rtDZAlNA-1; Tue, 07 Apr 2026 12:21:59 -0400
X-MC-Unique: nv3RK5PoNvCI08rtDZAlNA-1
X-Mimecast-MFC-AGG-ID: nv3RK5PoNvCI08rtDZAlNA_1775578918
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b781542c1so113819221cf.1
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 09:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578918; x=1776183718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGHajfexAnXrxSzTmQi5iS3YEGjNR0TJQImcUVg5Ums=;
        b=GtrvBHd4gkvMqfg4KEP5kyQQHEX9pFp9djF4ZQ/67zXeeopMWRZmdkuRW0kkfpDYcL
         PvM7ekr9gKbrHts5MH7unm8bge504/E5FZWk0HSljNTQ7LFq6c34V4BCOKbqfm3uy+3n
         7asnLt1QA04HFxXfSSYPFf/ovok964faPtTc4fTvXt01QDhsruFGNzkWLDdFCZ5MHGHL
         HEKaeZ9y+brcazoXtq1FT89RxcAXad0VttucRfIQJ4Zk96mcxBoTc8WJ31liiPlQe1zA
         GsWhaJ+ASRKLOP4neoZ2nqOCB0Be1jYnb2yrXmSWe2Hnuoej4Zm+s5sCQLybZ2BsKB0K
         XGAw==
X-Forwarded-Encrypted: i=1; AJvYcCVPSoLxcoLqIi/CMoVV/6tQ+CTqDotzLYLCBwGcRbW8ZBCIYkX5N1ZfXp9R5fLUn+ACd2vg/oAHlEwYJGuOBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxnx4PufAX605QCGL8QpTfNrgx0hcy49LR+lyLHi7KIf7P5bKYv
	adHYd0d4lLdVBGsEM7hQ8Do2tybFVt9jx0164f+sdhnDUdxfL214b7JnS4xIP25O5/9+06JQmo3
	Gxcgn1OSUBHjaK+syh1scZw5TJOzw7by3vV07gIgpZf3Sq6lrxNkgsgE4frynXh2oLjbI1h82Rj
	eNivA=
X-Gm-Gg: AeBDiesJLPhMxFD+5Wj/GXNYDK6tvcGOr8Az1b9KZVFd3mHm2SeC8tikhOgcXEyVb43
	Aom9RvQ5UfK/4jT5sqb1HIOpv2GpZFwu3LhsX/KBu7HzrOmym7sUvvB982KYuLpknnJP7lp5OaL
	gH2w5AmJlO0P5xU1konkuKnanepilliuyqOkYEvYya0VzazKmBZRyJ9Pocd+XewuqfLP4exXq8Q
	KJm7XKbdgXl0RXYrbfN7EiZ5/BXdCGTHvHnrZgm1y1CLMBQEPggE5QPRbQRNAoBcrdsZ05UlCdM
	NscCfPrxmbiEja127Z+yFN8e6WlX3C3EcoQxQ+dqPP3kMNWH5UUtAjapDlotFKQwp6ytaJcCDih
	cCQbbnFCEtFtK
X-Received: by 2002:a05:622a:4cc3:b0:50d:a8f5:1c0d with SMTP id d75a77b69052e-50da8f5226dmr29654041cf.52.1775578917652;
        Tue, 07 Apr 2026 09:21:57 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc3:b0:50d:a8f5:1c0d with SMTP id d75a77b69052e-50da8f5226dmr29653461cf.52.1775578917046;
        Tue, 07 Apr 2026 09:21:57 -0700 (PDT)
Received: from redhat.com ([37.19.196.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d8e11b927sm73269491cf.23.2026.04.07.09.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:21:56 -0700 (PDT)
Date: Tue, 7 Apr 2026 12:21:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 4/4] virtio_ring: preserve VIRTIO_F_RING_RESET in
 transport features
Message-ID: <20260407122025-mutt-send-email-mst@kernel.org>
References: <20260407123904.6390-1-astellman@stellman-greene.com>
 <20260407123904.6390-5-astellman@stellman-greene.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260407123904.6390-5-astellman@stellman-greene.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zSaRyhu8sO3PfFTFGNlKX4QbdINEOeUjxUAv6XICK78_1775578918
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2026 at 08:39:04AM -0400, Andrew Stellman wrote:
> vring_transport_features() whitelists known transport feature bits and
> clears the rest via __virtio_clear_bit(). VIRTIO_F_RING_RESET is
> missing from the whitelist, so it is unconditionally cleared during
> feature negotiation. Drivers that depend on ring reset capability
> silently lose the feature.

Hmm was this observed in practice or just from code analysis?
And on which transport?
Because


static void vp_transport_features(struct virtio_device *vdev, u64 features)
{               
        struct virtio_pci_device *vp_dev = to_vp_device(vdev);
        struct pci_dev *pci_dev = vp_dev->pci_dev;
                        
        if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
                        pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
                __virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
        
        if (features & BIT_ULL(VIRTIO_F_RING_RESET))
                __virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
        

...



}




> Add VIRTIO_F_RING_RESET to the switch statement, matching the other
> transport-level features.
> 
> Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fbca7ce..2cb643f 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3524,6 +3524,8 @@ void vring_transport_features(struct virtio_device *vdev)
>  			break;
>  		case VIRTIO_F_IN_ORDER:
>  			break;
> +		case VIRTIO_F_RING_RESET:
> +			break;
>  		default:
>  			/* We don't understand this bit. */
>  			__virtio_clear_bit(vdev, i);
> -- 
> 2.34.1

