Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC9B395DB1
	for <virtualization@lists.linux.dev>; Wed,  8 Apr 2026 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635280; cv=none; b=Lu/scxDqJ85vwvokz7XoBZeqCb1mFQ3Tn68Iu1E8RgI9ObsQkSm64LaKiGl8iUB7+MN814choO/zWHyGwe4VyGCdAkQ+mdawNOZPH7fuM5MvGiMhgMvBbIPmmcIlFZgE6IJlUXjCuYS0R14IrWOM7f/dYIrYu1kL/pkbmJpYtfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635280; c=relaxed/simple;
	bh=VNtmdeyD8ks5WGqCaRVQj9tbrSu1bGMKSPQMorgZx2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Y2iCaFcEOckabJ3YoKl3wF7wIVIuBWHKtd9aUN1dYZS2FZuDdZLA/tEnnyGYT5vtn8wK4/vfhTqBb4+Ci5rKfCo8v8dvmyxxG9yrqW9WDtqaLj9igkNKrU99NRirRqZGurehrvfeF6ZCGvmFSfTMQqin7NgMry1UJHRN3bThsQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4YhCt08; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4YhCt08"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775635276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vv/PNE06UTD9uwqSDBv6GwqwhwLSI3Ze0AfZPOM3Rjw=;
	b=N4YhCt08WxrtYpqJ+PGXGePVKFdrliycyP1IxZRFm+dw7kgeDsSpn18U4LuQnBWSkjWJbt
	8aYL5ZhVpoWAhwEQLKa79BnR5GOeQM+A18VspsnUhjb5M919wwNHF3Q3lw/JeHlUxse4pi
	DyyVt3chvkzdxRN7/QcJKeFQG1TX9hk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-k_Zw_8ucOPaQk2RImhemFw-1; Wed, 08 Apr 2026 04:01:15 -0400
X-MC-Unique: k_Zw_8ucOPaQk2RImhemFw-1
X-Mimecast-MFC-AGG-ID: k_Zw_8ucOPaQk2RImhemFw_1775635274
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d1ceb2ddfso5536551f8f.2
        for <virtualization@lists.linux.dev>; Wed, 08 Apr 2026 01:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635274; x=1776240074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vv/PNE06UTD9uwqSDBv6GwqwhwLSI3Ze0AfZPOM3Rjw=;
        b=gET4WzIWIhZv79wurq9eznE+H8J9vi5NgBshDVWzDyeHu4hBoJXX3CzdDeTB1b3t+T
         wA4KxMfdCsAKQS+wxfZfURFg7Ow3h+rPRDutIcgkGGfd9xm4RbH/Reqn6EzpR00ugksi
         5N0rzHGbU5bAOqFzsx5HGWwCii643fEixYG40ao4OiT3jd1sfTeGH0dclwFTN7t+todR
         dCI7qkLyu7QfmmKmEMhLJWoJ5f6g2+DT13mTqytODDq6ToyudmjnETyKPZsXezDXa/cl
         hDYX/FHHO61dJaD98qNgmQeXuIjy71ygtUmLRmXVIcRXHuO/jzbP/0xd5AlscB4i+nKH
         elHA==
X-Forwarded-Encrypted: i=1; AJvYcCWlJpi/Gkx+PHGPOTW6QIn3+tyDaMvXTQ/966pyTXwLrNKNiZpG6v7cb4qZXht6FDISBtD6BH0K/ZROMheFPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx69vfGIUNBYDl46VEWlDd31msSvfgjfP3CfQG5tzZMf4fyYdXA
	w/AN+yhG77ZgQ9x8bJmDQOp5yf6DFej5OZMlb/y8Nmnudw5Ni6x/iO/o3xZXHqP6RGNPuA7wTtb
	0SCruTpSbtvIYxt/jfacDMl7G7xkOvCjAOmGD+esoRUKdQ+JPTTAiY068qeECmRIajlPa
X-Gm-Gg: AeBDiet+C7iM1cEubBbWgMRdh/n/X0kWu9BKYO3xGoiQMjbtnfTBtmfgdgU/rz4UPGs
	0c/4ragWjLNeIoD/4UTtufLbtf3BPrEUkZVvbB5/oOoRT49yljCO8Fi5hlOcNBqzZg26e9sxr1M
	qW0ix3dRBH0YJMpyOPMEj5y5FRzS5GrGejVnUpmVNB4hWpK0qGmYZ0k+1D9Zw6uWqLxaP97891X
	hpeeGjYMOQsaYsIv2NuKkFRt8mRRg9T93PzObjKUFFbT0OcJtuqF4FYLvjWpor7tm0COixBFJ3U
	wl1hLTiVBhn92gxRQF9F1hATz4d9VTKsQZiJBrdXzmUM/aCv6Sd3/suy5wsm3o8k8SmMgjoqUBl
	sxifdOS2Hn28fSPKPRCLL7MHNB4OcXiuxCxQvxAxUzwiGxKO52R3KKP5ADoe4FAaGNKsqzVo+Sg
	==
X-Received: by 2002:a05:600c:5292:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-488996d2309mr295098775e9.5.1775635273743;
        Wed, 08 Apr 2026 01:01:13 -0700 (PDT)
X-Received: by 2002:a05:600c:5292:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-488996d2309mr295097975e9.5.1775635273101;
        Wed, 08 Apr 2026 01:01:13 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm352031205e9.10.2026.04.08.01.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:01:12 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:01:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, John Villamil <john@doyensec.com>
Subject: Re: [BUG] vsock: refcount_t saturation and OOM via buffer size
 invariant inversion
Message-ID: <adYKERRYwzMIhZAl@sgarzare-redhat>
References: <523A8D3C-F4D9-43DD-A3A6-01C9EC335656@doyensec.com>
 <acuKUpZQq6z1DY_n@sgarzare-redhat>
 <C918071D-C036-4FD3-BD64-16C8E143479F@doyensec.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <C918071D-C036-4FD3-BD64-16C8E143479F@doyensec.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x2UI22p6b-w1ZK2fLURLdZgHwaVyjB1j3mL6HKBmfPw_1775635274
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Apr 06, 2026 at 08:36:16PM +0200, Norbert Szetei wrote:
>Hi Stefano,
>
>I like option 1 the most, as it is the most straightforward way to fix
>the issue. I am including the patch below. This fixes the clamping
>mismatch, but as you pointed out, it won't solve the root problem
>regarding the issue to arbitrarily set a maximum buffer value.
>
>Since VSOCK uses a unified buffer size rather than separating read and
>write buffers like the core stack, introducing a vsock-specific sysctl
>(e.g., net.vmw_vsock.buffer_max_size) seems the cleanest approach to me.
>I was also considering net.core.wmem_max/rmem_max, but mapping to those
>feels less natural.

I would prefer to stop to add custom sysctl/sockopt for vsock and start 
to reuse the common ones, so if net.core.wmem_max/rmem_max can be used 
in some way, maybe we can try that path first and fallback to a custom 
one if we see it isn't doable.

>
>If you agree with the vsock-specific sysctl, or have a different
>suggestion, let me know and I will send a follow-up patch for that.
>Thanks.
>
>Best, Norbert
>
>-- >8 --
>From f5d160167c862c7f2ad6e6a1d4181d01997b683a Mon Sep 17 00:00:00 2001
>From: Norbert Szetei <norbert@doyensec.com>
>Date: Mon, 6 Apr 2026 19:52:52 +0200
>Subject: [PATCH] vsock: fix buffer size clamping order
>
>In vsock_update_buffer_size(), the buffer size was being clamped to the
>maximum first, and then to the minimum. If a user sets a minimum buffer
>size larger than the maximum, the minimum check overrides the maximum
>check, inverting the constraint.
>
>This breaks the intended socket memory boundaries by allowing the
>vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.
>
>Fix this by checking the minimum first, and then the maximum. This
>ensures the buffer size never exceeds the buffer_max_size.

Please add a Fixes tag here, that should be:

Fixes: b9f2b0ffde0c ("vsock: handle buffer_size sockopts in the core")

For virtio transport it was pre-existing of that commit IIUC, but 
doesn't metter since these changes will not apply without that commit, 
so should be fine.

Please add also a Suggested-by.

>
>Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>---
> net/vmw_vsock/af_vsock.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d912ed2f012a..08f4dfb9782c 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1951,12 +1951,12 @@ static void vsock_update_buffer_size(struct vsock_sock *vsk,
> 				    const struct vsock_transport *transport,
> 				    u64 val)
> {
>-	if (val > vsk->buffer_max_size)
>-		val = vsk->buffer_max_size;
>-
> 	if (val < vsk->buffer_min_size)
> 		val = vsk->buffer_min_size;
>
>+	if (val > vsk->buffer_max_size)
>+		val = vsk->buffer_max_size;
>+

The patch itself LGTM!

Thanks,
Stefano

