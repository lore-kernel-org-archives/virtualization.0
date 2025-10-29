Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C563238175
	for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726005; cv=none; b=GKMfzKr1obGXQwno/1Rl/c/LiVfFCfZK66DapoMzylUTBaj2EymXbvr8bm5A3RB55n89HzRQuA9UAKoYa8czGISWxbnIISd1sUYLvqd3ZfM+GSjkwO+ZbkyGLzaUszyBqjfRJHud46kavMkhruJwjcz/TH0z+yXf4UEevSVzKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726005; c=relaxed/simple;
	bh=dF3Bio0TgnJ38n1yJDNKl2Un84TNaqbPbXxpnnYQNmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQs593GM/CjIgkAwJiIhjA2mdZxJAq59dbyidURBoOEfbAbkT2KPJyxAMQcc+SvDkb0RgMSEheEuJNFNS5nEWfVy+zrcGHUZMU9PZR32WlqsR88pWzOYkSb6VJ/mazP8tm1W2eqe1TjM2a6r7nzWxirpQB7r24dzmWQdJCKOZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbpPYvcj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbpPYvcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761726002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlHEB3885pfS5dzEnYONWhgNpmOARZh1obJdxfgK8IE=;
	b=bbpPYvcjCJmE3PLd+21MfD5M7J1pQZPlUttyOk9YAbe8sZlxshvOgBHc+6AhU4isEOFKT6
	DurP8pi8qYK4YPBN5i3h6Eo+OymCslatmOSCL2B9wksdcwnKhwe8PfmEGRZ9OzCk8qyA4j
	U/VCaHJ9iEVlJjAiAx5ooE4sqnDr8fM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-ixGbWTTXNAmfFAYyQ5nNLg-1; Wed, 29 Oct 2025 04:20:00 -0400
X-MC-Unique: ixGbWTTXNAmfFAYyQ5nNLg-1
X-Mimecast-MFC-AGG-ID: ixGbWTTXNAmfFAYyQ5nNLg_1761726000
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-475de0566adso37173355e9.0
        for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 01:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726000; x=1762330800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlHEB3885pfS5dzEnYONWhgNpmOARZh1obJdxfgK8IE=;
        b=CvTTTc4ZBIGylw/XyWNqoSpTEZDH9jBRPumLJVK6BPyHS/op/OXJEVqp7kGOIRUchK
         UyRbt++6Nd7D4G7hRh1gZ/dMauaJoYLKyTOHBxdImJH19m7Scl58Y7yxzXtEBbs4t8o6
         POxmaOT/Pt8g7TZN9O+oUdIS8bBLrxjwYNuT0lmOhF322PEWh7hT516OlnEEOxyUucgh
         VYx6UZkd5j1P1w4p0yu/hA0bFMc0wp1v0F/LtiJelBhF42l+Midlt1q9wfr0CJU6Ad6O
         u8vmcs8a9s4G+5Rd7LYHGVxfuT6Reu1N0/1S4oOr8Q9F10HK0WF3hc/PD301tFPKuyt+
         qwkw==
X-Gm-Message-State: AOJu0YwWPtBQ0GPCNM/HRRsUFOFtKNAeG+HQsyB8i5HmkZNx+E4Jqycv
	K6XMlaUpAAl16Zj3eXqfvXRkIqz+Mkk2+RiWQMwHMKKX2UuL1NGIBG1L/Mn6avNjmHJuxSw+ztR
	FIiD2qOvWEIwX900r4bKwF6hwac2Iuwm2QgrY2flVmLxDlt4w5DA3njQ7oXri1suco3QE
X-Gm-Gg: ASbGncunAptzhP1ygD/hAOJGcw1bcCfdQOeEPLEkFz2xgiHvDHDa1+IGQZrMjNUuMOb
	kKFaSs0+bHx56n20yV++6AYaFMwavXh9TuMTTMtSA73Hwq3RnmHPzCZCm9rL4ix150K6Hcw4Dt/
	QUsY+gomkeFy2ZjdyReCsV/iD16KSYLY8tyEwefWfLZUvbsrKGmCKL9yuCam7c8urQQZmaWI4Ou
	JBVwiqa21l/BACLUjH4+ZTH9W0kO52qlAx/wd+2JLB9KBu5wNjDBY6eonP6pvPdRJlDwommA50c
	lOtYDD2yJ4Oc2Ik3/8oH1s1WfLOJ6mQKaLNiHWfexxBV0hUKWjddlNx6nwM6+WE7xOTPahZ9aB8
	giQtooDt7g510/yhcnTLV4sBawhnmh+2UulTLKXD4gIajMxw=
X-Received: by 2002:a05:600c:3f0d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-4771e32f67amr17216475e9.4.1761725999694;
        Wed, 29 Oct 2025 01:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIKqhZC0CRaoe+oh+5iFeCWKZfBRUDuYDM2nN5t0zCHgNGsk8VxrCIMd1bsBbPfplLJXnHhw==
X-Received: by 2002:a05:600c:3f0d:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-4771e32f67amr17216155e9.4.1761725999244;
        Wed, 29 Oct 2025 01:19:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3937b3sm33177645e9.5.2025.10.29.01.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 01:19:58 -0700 (PDT)
Message-ID: <d0f1f8f5-8edf-4409-a3ee-376828f85618@redhat.com>
Date: Wed, 29 Oct 2025 09:19:57 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251029012434.75576-1-jasowang@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251029012434.75576-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SG4upubcDlRVgjklVvl6a5i0y3_tksC8W14a2zgSwMc_1761726000
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 2:24 AM, Jason Wang wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Changing alignment of header would mean it's no longer safe to cast a
> 2 byte aligned pointer between formats. Use two 16 bit fields to make
> it 2 byte aligned as previously.
> 
> This fixes the performance regression since
> commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
> virtio_net_hdr_v1_hash_tunnel which embeds
> virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
> shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.
> 
> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Whoops, I replied to the older thread before reading this one.

Acked-by: Paolo Abeni <pabeni@redhat.com>

