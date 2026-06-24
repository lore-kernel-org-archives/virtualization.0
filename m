Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6B388E50
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284913; cv=none; b=I1Z4HWhNCH+Nc9Asils7SPOeclJDY9lfsbMT41PXu52zWPzbqXf/gOSdXuIBn6XPfVYg+4FhPqKt0j7N3MMlVbVNBkuKg+coCauQiVi0aQvz/PmKZ0qzoWcxzH80zLQUaDgyeFL2z6dcUzX8ufM6BlZ4FweF18xsdTkvPhwpCyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284913; c=relaxed/simple;
	bh=xxRwD872hAY7e9+wcKaMu2M9Gp5015MokzS33Hl3FeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hH2ZaBFFO17fB17zXL2D+wUlDR+7fEEERAHd7OrCkFe0geG2k2/NFhVSC8chNOj2IF/x/pYQAQ1XLeOAIyHWN13xcGZymQVgqQXVBLIeiAWh5vHEX7SHyqqvosYw3v5l+VfuIEl7w54kj0rkXzriW7tGr0+PBkAYqwcNalXnsmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+BG+dT+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+BG+dT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782284911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SOVdOpEBfLtfj8+28uRc5uJ//FeD3/0uqHv5rRdyHRo=;
	b=Z+BG+dT+OKUcYXx4pNxEAJbz/7uOfClvFsr5wcjQi1rlPxMSUNGOHrMeNN0YLfx5L/MjOT
	YxxLVxYJNhQZyokjtDKnvmKwwQ51CH+W35kdtGUPLW3WtGPhEvNyHpkIEhMT0l0qPVUX5b
	dZJhO898lKGr7KRKT7qP3WSdd8Yc5nU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-xetlENbcPaCNX4eIFAkuGw-1; Wed, 24 Jun 2026 03:08:30 -0400
X-MC-Unique: xetlENbcPaCNX4eIFAkuGw-1
X-Mimecast-MFC-AGG-ID: xetlENbcPaCNX4eIFAkuGw_1782284909
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490cc1ae292so4158425e9.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 00:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782284909; x=1782889709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOVdOpEBfLtfj8+28uRc5uJ//FeD3/0uqHv5rRdyHRo=;
        b=RgQrDBt2PejhIMk3N74mpEJUqiD3PKnO3oMwEpM1eJ0Hw0mrjA+FLqy+MjD0aXR7Ol
         T0raLOM8N3rgK+G/A9MeANvNcz/LbNID1T+jnH74K83Lrol4sz3tfELpNvQ8DDDBiuhj
         yGEYbSH+xEGM5/49+zijj/oJu68h3HhseESZF2d0NGSdYV7khCm7SjxcfLMtiQ40dtZ1
         x7mB8Z8QvvUQSN+iNYsf7RpwT2aJNjy0ogefnJ4/+pn0NSf/soNJ8k3E4RRm92OyiZ9H
         c6KR5QanTyQgUdq11xZAUERIj3G76gNJfX6qFcWXeHemgcKvXu7c+EjqUfBtSh7cLUJ6
         OblA==
X-Forwarded-Encrypted: i=1; AFNElJ/keChtdnglp6GhB9Fhk4vkpctUAEMg+4YeAcTdpqGT6duDEbn9Shrn7n3JQYuq5wbQBbvE3depBwTM1y/xUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlRIvDgAGz4Zlghh9E0XnEUE2paS3uTnCzcupkPttT9ucUVsqQ
	NYvF22biv34y5FWVfsv1KBryImjL/gVGrqYMMDIPa/CwzqoXhPa8c0PRneu7HdaTZ/waHmF+c8e
	G9s5oreGx2sD3gV8H6kEUR60T81ldA87Mb40iBFT2VHe9xyB7j+Iu71awcH2tqqr1RuEfpNvK/W
	rR
X-Gm-Gg: AfdE7ckNlGOhIq5QLdfzNx4Dcvcr3AzT89e7ks7geHVuSLapQSSMvOFWJ6nH7HbBBnx
	BOSFj9Peg9qHhcmsDN46I7shIOMhV1Fks7sTEqOP+mE5ZIsXP557lo74uJzhMWoo0xkunv79x4Q
	0ml5KFLemZJvgdGeJZ4e4mAznEj0rxRS5811vSUm3qtisnxXuNxcwcGGL1y4SwB/ia4fqz20z/U
	I5+p0iVJ6XoIuzJo5rUBgQ7CADv9GcNfIdxiguidBKZVWR96rPicHUcG75w7hdGSKU36wOFMdua
	/naQsw68zJJ8GRcZklvucjBAaw9P65C+SPIsSnKA9YMr63sFwC/XqVymtjq/QWYl2k8nIIMtJoY
	Ar2BJLU4Z4rFbuffvkYgkb6vQ2rck/sDC
X-Received: by 2002:a05:600c:3b2a:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-4925a0a9b8bmr88810555e9.7.1782284908874;
        Wed, 24 Jun 2026 00:08:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3b2a:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-4925a0a9b8bmr88809375e9.7.1782284907436;
        Wed, 24 Jun 2026 00:08:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49260e14d0asm23280535e9.0.2026.06.24.00.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 00:08:26 -0700 (PDT)
Date: Wed, 24 Jun 2026 03:08:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: xuanzhuo@linux.alibaba.com, jasowang@redhat.com, edumazet@google.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: Re: [PATCH v3] virtio_net: disable cb when NAPI is busy-polled
Message-ID: <20260624030656-mutt-send-email-mst@kernel.org>
References: <20260624070206.85467-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260624070206.85467-1-lange_tang@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jHzwWCsoF_kCdnYuG9PRXYxwfxHxL2PJNgwcW7IF6c0_1782284909
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2026 at 03:02:06PM +0800, Longjun Tang wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> When busy-poll is active, napi_schedule_prep() returns false in
> virtqueue_napi_schedule(), so virtqueue_disable_cb() is skipped.
> The device may keep firing irqs until reaches virtqueue_napi_complete().
> Under load (received == budget), it will lead to a large number
> of spurious interrupts.
> 
> Fix it by disabling the callback at the virtnet_poll() entry. This keeps
> the callback off while we poll and re-enable

and it is re-enabled

> by virtqueue_napi_complete()
> when going idle.
> 
> Fixes: ceef438d613f ("virtio_net: remove custom busy_poll")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> 
> ---
> V1 -> V2: Remain agnostic to busy polling
> V2 -> V3: Add fixes tag
> ---
>  drivers/net/virtio_net.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..0a11f2b32500 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3008,6 +3008,11 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	unsigned int xdp_xmit = 0;
>  	bool napi_complete;
>  
> +	/* Keep callbacks suppressed for the duration of this poll,
> +	 * busy-poll need.

I don't know what "busy-poll need" means. Just drop this part?
In fact, the whole comment can go, we know virtqueue_disable_cb
disables callbacks.

> +	 */
> +	virtqueue_disable_cb(rq->vq);
> +
>  	virtnet_poll_cleantx(rq, budget);
>  
>  	received = virtnet_receive(rq, budget, &xdp_xmit);
> -- 
> 2.43.0

