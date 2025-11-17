Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255C329C69
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372397; cv=none; b=S7QDE/N3zTMqklwBDrFvssFbIiZtf8rGeLkwcAGWWJAWGk8oGKe/x8RfCExAGeeIqRuNvsYkt6Q6bDaQZmCMJI3W6sdYiPxNZ9ArKfIl+GIMcQfBf0milgeEvGdLiFKnuULzsdLOcpw8izLCFBDlmAkdY15GKcllSIrteag3Ips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372397; c=relaxed/simple;
	bh=4CnGodEfo32klWJ1L+LcOk9DiKn6L/+cggihvUTvzwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TtedqMSUkqA01V4Lmu8k0Wlu0hhlofxuy1XOAZBfDvxpJT8GvMR1+hmv6tzvUYcTr+DnenGhPC2r9UeyYjcNb37Nm+sA9v3fETsGtYGawv3GQyrzzBa07WNlkGRqQOoEIJN9o6vS7va/uXhnC/FwSLUqEn0nCT7w4InpgNluTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxoGRuKN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxoGRuKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763372393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6O3GnJt58R4gRECz0DYLzPCnFMbftw1gUSd0oervUlc=;
	b=XxoGRuKNlAHDjC3Yw5YzQxWlY8egbSEtmHv1mr6d/RSwvvcYL7THA2QIdEp2E3vG1+fjMQ
	rAgSeI6yM6B1zBWPfZeZ+1x4pn4LpiwQfneSCRFcwm87sEwDCZHpr8OTIgA/cqmtsd0Yzc
	anE5mcOCS7tCwURQBu0HhI4r5VC6OH8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-7O-cKs-CPBOE3l0aMwy1aA-1; Mon, 17 Nov 2025 04:39:52 -0500
X-MC-Unique: 7O-cKs-CPBOE3l0aMwy1aA-1
X-Mimecast-MFC-AGG-ID: 7O-cKs-CPBOE3l0aMwy1aA_1763372391
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b570776a3so1945250f8f.3
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 01:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763372391; x=1763977191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6O3GnJt58R4gRECz0DYLzPCnFMbftw1gUSd0oervUlc=;
        b=IOBV1W+Qe1IG/aa91jGDwFoO7LWLXciBfIgdMr55xpuQLwnVXcgtFog75ms482r08f
         W2aff5OInYKIBf9nU150Hkk/+ObxBq2rn6HQfq7wG7SjGyGe0E8Ip8UinbVH86TIReXF
         fDfgFWkyZmby39sPOCKYsdGwrdMEXdqv60OqXRG/UYT86eyaiQNEuNxfNh+F62DC5Z8v
         n29IV1DR5J3FsHBQ/H7647R5IFeRfKw4gLANoEPeZsi7ouzNL8m9XehQAaFF7cxDnlV1
         of4lWzIa8Mz7nvcntFe9/vn8DSQjYhbAw2f9mwxFWeIjonUNIeRkfzvEGKyjQ+w0pasG
         0IYA==
X-Forwarded-Encrypted: i=1; AJvYcCUVUONfE97vvCzwTEKt1UDKusjaCY0e5wCvWmu5weapK5Q09q3dIcu/kFl1d46KJFs3InJrpbJ46UoGRdd4+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQGUN3uCuMPshIKufd8kSzAWRlVxuCjhL8erX8kE4bcfcKL4tB
	QlvvT4awQ9bpVNz999PS19Kb2HrUI4qYCtX2kPFlnENR1pJKTCh5oarEcJnCjbhsEdNGD5hGQBZ
	AJvxHDMw2+XJCJQm56vvwrzCEdZDcEuUlbnK5FA60Sq+1xqZUPgRjG2OlrinwGJZtuCmh
X-Gm-Gg: ASbGncvnEp6T5SALlGw39TfqGprXTRl5cM8USHowTNn0Ku7imtbiVemOdpS2NiA32n9
	ZiS8+vFwGMf5hJ8SLFVvujTkG06sDOxCfXFhTkhJflUhBbe7vZK08gx5kuwpE4oYExnPpTtGmYy
	1zS6vw85spExtPdiUN3olaoR23Ya/kRPO0DTIhxJY8NMUNbqQ3wMFxAxvCwtwsE+OL34RXonbfo
	LgXitMIm6VnZe6sk7f18lJEnnTiOQ1gIgTkhxXD24ImjFfPHQMRHHj6q9WMvwXTNehtLPrq0Q+F
	WqcXcj9sf7LuZRDnhq1xsOa9g2aFE9awkdx44zjJBJOxEqDCbamG4kMbQNrD2KfxIeqmrAuw2yU
	L2vZlNYHPPakFsWWj6mk=
X-Received: by 2002:a05:6000:1865:b0:42b:3246:1681 with SMTP id ffacd0b85a97d-42b59344ff4mr10484789f8f.18.1763372391155;
        Mon, 17 Nov 2025 01:39:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfj5Hn7516Tmt768MAQru4ZVgWKYpkloYkkGdb4oINmzL5NMh2IECxn7AyarfOQjldp/tMEg==
X-Received: by 2002:a05:6000:1865:b0:42b:3246:1681 with SMTP id ffacd0b85a97d-42b59344ff4mr10484756f8f.18.1763372390614;
        Mon, 17 Nov 2025 01:39:50 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b5ce849ddsm18828364f8f.14.2025.11.17.01.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:39:50 -0800 (PST)
Date: Mon, 17 Nov 2025 04:39:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>, shuah@kernel.org,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH] virtio: document @vaddr in virtqueue_map_free_coherent
 kernel-doc comment
Message-ID: <20251117043922-mutt-send-email-mst@kernel.org>
References: <20251029033559.83145-1-hsukrut3@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251029033559.83145-1-hsukrut3@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: czeCvAmtbKDxh9ThRhjVstNQCVIt45AxJdF0JQaMF0Y_1763372391
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2025 at 09:05:58AM +0530, Sukrut Heroorkar wrote:
> Building with W=1 reports:
> Warning: drivers/virtio/virtio_ring.c:3174 function parameter 'vaddr'
> not described in 'virtqueue_map_free_coherent'
> 
> The @vaddr parameter was introduced when virtqueue_map_free_coherent
> was added in order to provide map operations to virtio device, but it
> was never documented. Document @vaddr to silence this warning.
> 
> Fixes: bee8c7c24b73 ("virtio: introduce map ops in virtio core")
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>

I picked a different version that fixed a couple of other
issues as well, but thanks!

> ---
>  drivers/virtio/virtio_ring.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 7b6205253b46..d763060ff0f6 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3166,6 +3166,7 @@ EXPORT_SYMBOL_GPL(virtqueue_map_alloc_coherent);
>   * @vdev: the virtio device we are talking to
>   * @map: metadata for performing mapping
>   * @size: the size of the buffer
> + * @vaddr: virtual address of the buffer
>   * @map_handle: the mapped address that needs to be freed
>   *
>   */
> -- 
> 2.43.0

