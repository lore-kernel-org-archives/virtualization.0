Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E533DED7
	for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725934; cv=none; b=ZrXvH2Qw08D8Q/PnQThSvvY2gn2I3cKJ9bLywOaucBdZX7rGYp41n3mcyeuWF+5YivzrsuCY9lF71CeL/wlR6dLgcNghdfbL1ZWvl4JZd8nkQaNOXJLXEmeNWlzozCaCtMXkk4NAykXqXpx+ypbzodreSXb1d8PW7aWzkNHkv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725934; c=relaxed/simple;
	bh=8H8soxGYOT3vCG44vOBwzgrU1KAhGT6U13rFxFdobrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3azMBqti6WAqEfKrB52ZwmntR8lP6IOQttFmlu4m+rwA8liIa+CQOLqq55jz3DO/Kd+Vz5/pF+/Fr8s6gHDPfi5IOnRTa6BCjI20j2ZaUizO0u75GDgHgY0idZMd7z3JEw0MGS+53lvNd2DAdWnqE8lIuihFkMsMk3KGJOQhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfywDkZB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfywDkZB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761725931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CcZI/qnw6B1L6zkF86iXEfjDjYa1qezAoXbeln8mok=;
	b=KfywDkZBEPV0P1bey4jIWH22s+XaVwTnw8GAeGVz10VfNfnigEUZUG3qOuy8hr4t4TkZTS
	X6x3fq06E1+whpa6e973ILcWwWvB90Go+21NIyoSAPZI3YqduTguDRnJYhoY+U+gpMLcBZ
	MiEwNQaOLg/PEo5NTnNZmcjJzXl1NdU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-XXe4D7hlN5CjloRaOVR0wA-1; Wed, 29 Oct 2025 04:18:50 -0400
X-MC-Unique: XXe4D7hlN5CjloRaOVR0wA-1
X-Mimecast-MFC-AGG-ID: XXe4D7hlN5CjloRaOVR0wA_1761725929
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475c422fd70so54609215e9.2
        for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 01:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725929; x=1762330729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+CcZI/qnw6B1L6zkF86iXEfjDjYa1qezAoXbeln8mok=;
        b=ZBxx7qgliSAo3msuJgfVSu84iOOXPfVKbdkrEQNr6kPxPJPxKSOHOgKWm3RbYEk8a0
         fh6RIpd3oP7wbjf19RClyBuChCAhRP5NJqX6Hsj7FRMo9L7cjMRg+Scih301pMOryXuq
         ObdfZFEvmTKhu/Hhbr4/m0bTcnwVbWwRB37bW3kk8NNX17MlrIec1A0SB+X4kHXby8NK
         886BItDG7v08bQoee6XrkL8qrq57y5Zu704S0qepmkvrUtIzmRtTKMEC3ekAIDaF/22z
         UN2I0CSt/eoME2xWo0PNB1AdNP41YBb4KHBz87xkq+1OrFghTuSLvI43sXOmb2pPuKa9
         DQMg==
X-Forwarded-Encrypted: i=1; AJvYcCWmjBbiIKB5hh+0mNEjxAP0znamFRHaOfbJNnQrZ8uDpwlv9+YLCevGJEnzHBJ7JUcmU0+AzxrLsYWnRt9+Mg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0G+Ju5zY2RNDBwNmFwjrSBAYROS6OUxJmeftp0LWAi7X64R4s
	YXtoHpVziiNVitPm8WCSaJw6Fa1FTOwXuruhJaPDuun3aDXR+2SRSpDRS1/3kckoNyaHzT9Qlny
	TBr07cJp6A7i+7oQ/k4St0Xyijuwwq2yphn1t6Pp4AcQK3fP8Z8U/ocho3ftmvj3rsz15
X-Gm-Gg: ASbGnctBzfD612qgdkOw4SlPEP3EelZSSf1uK/puw6C2PIQyhP3kfACTAFhPclzusOf
	+eCUueYKPWJ86O05f2wV2nYIIvl4MHx0J2uXf7Ba0JpqUrp8Hpg1Oge717ZPxHio6vwUpCO6W95
	trn7A+RQ4Vt6Ma465vZKQrIbb3bvQZhJJBS1FGDcXq1sjhuZsLh+ghVAVV5vWMOGxXfeJZPIhQ7
	BPnEjG2xISZvWnmNyzVUlm063TcY0znKFIcJM+SuMyFNJJJoxDyMqml8GbqfahFaT1xJneusXe1
	1Y/GSZ27VgDj5gBh5GlNOTlxZsIfLZA2ADvnV0y6AJPCdPcXi1YxOQdeDJjFRbJtA3zTFUR1Blx
	vJA8jdtR42UDuJXDmHVze6J6qfuL2UDx56fmm6Mw+E5ro2uw=
X-Received: by 2002:a05:600c:474d:b0:46e:2562:e7b8 with SMTP id 5b1f17b1804b1-4771e1cb161mr18373155e9.21.1761725928782;
        Wed, 29 Oct 2025 01:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF7JQwZ5gI4oKfKp7iQpZcTNE4SIKlKh608B1gAeQM0JjYtj8qEfOSjsYmJMqvyHD8orGB/w==
X-Received: by 2002:a05:600c:474d:b0:46e:2562:e7b8 with SMTP id 5b1f17b1804b1-4771e1cb161mr18372985e9.21.1761725928400;
        Wed, 29 Oct 2025 01:18:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm27290030f8f.45.2025.10.29.01.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 01:18:47 -0700 (PDT)
Message-ID: <96f6d774-457e-4bdf-a0b1-eb6f64b99a46@redhat.com>
Date: Wed, 29 Oct 2025 09:18:46 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: calculate header alignment mask based on
 features
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251028030341.46023-1-jasowang@redhat.com>
 <20251028101144-mutt-send-email-mst@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251028101144-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1CSYdafrzq7K93UZ6U3z3jFWy01TCTHog4InZ8YuBEA_1761725929
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 3:38 PM, Michael S. Tsirkin wrote:
> So how about just fixing the root cause then?
> Like this (untested, if you agree pls take over this):
> 
> ---
> 
> virtio_net: fix alignment for virtio_net_hdr_v1_hash
> 
> 
> changing alignment of header would mean it's no longer safe to cast a 2
> byte aligned pointer between formats. Use two 16 bit fields to make it 2
> byte aligned as previously.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

FWIW, I like this solution. With the u16/u32 change, feel free to add:

Acked-by: Paolo Abeni <pabeni@redhat.com>


