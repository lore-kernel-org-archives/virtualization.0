Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742B241CB7
	for <virtualization@lists.linux.dev>; Thu,  9 Oct 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760003098; cv=none; b=NRaG/Y7ZlTR9LzYEi0QFnDI65HRE1lSyvxzeOvOmQ2Dub1rPyd92d/JmMaT4Mv8InvDRVs5jjBiH+ShdTdRdPL0YL/c2Pe1HAgcBRXwbJ8SL919uBa/1GCXYqTyubc3EGMIuYkkN1pbcYZQ1d3KmmaH+n9GpBtgaU1OAyTt41Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760003098; c=relaxed/simple;
	bh=VrWDDApLvX2qMH79/+xTLKnVAMMuqqi7MbrMjwSyaCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFB3t+3++WiCxu6CCDtOKRMGr/dp5CWM2yUp8bggopxUwLbZguZ4Q6T9VXuUtd4Nn4d/4zJNyWwf2V9leS20jzAR4apmdpIm4KdirVZbQOi6NT/o5xFhfRn44PL364c5+73+3V9hILPvpYm9UApMyW63S8RQl7oyqVTRxtF8EGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbCuFgUo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbCuFgUo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760003095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znS/sY1Cp+Lu2TFNQZjRRZlOQYTeUBE60EraEojaqMw=;
	b=BbCuFgUowOTtGJ4gBPoTSX70kOOMq+N/Pjo+FQwlZBYfKtJs1hEhyhrQZxQ7L5jdgEG20M
	iXxS5Cx/HUXG/20m2gA5Nj6icTiLHXpv6+X7J+A0aeQhbYHovvzabZB6VRHW5d5OQKwYd3
	iYjkR3He5M+xaIcjrDCRoY0ZzGKDI90=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-Jvr1HeFFN8qZtfZe5TEjxg-1; Thu, 09 Oct 2025 05:44:54 -0400
X-MC-Unique: Jvr1HeFFN8qZtfZe5TEjxg-1
X-Mimecast-MFC-AGG-ID: Jvr1HeFFN8qZtfZe5TEjxg_1760003093
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e473e577eso4816095e9.0
        for <virtualization@lists.linux.dev>; Thu, 09 Oct 2025 02:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760003093; x=1760607893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znS/sY1Cp+Lu2TFNQZjRRZlOQYTeUBE60EraEojaqMw=;
        b=KZM4hgp+pLtg1R/BHVziFXT2Jffu/R9xq11hy+awRTmQzx7I+yc+GEukuDb4eHUQ3V
         TpzpV0IqClNrfKf3mxuNsqMgxL9UMNm3jiTgNQK4vS4xq9CgUH7GBQ37ZkLn1B7xEIzy
         WJkQI5T51vlx8+fS+S6FN2Fp0iZcBDUnYBL7jbimhMfRIbizWbWIav988wZ+FTGQUF/U
         TGHpdnoLwdR6wcIaYD1cnjLgHr8Di3ApR6eW1kZxJ0XYOV+DXmwp8YNxeCmi8HbxFRyk
         ebHMpEBPrOpXQASZjyDyNX8L1zEsuVQWiBXkH6mC/AMsx9XnIgRT518fy1fX7NHmVu3y
         gtPw==
X-Gm-Message-State: AOJu0YzqRZtSo98nfu30xW9x39Fe3EulyPg1cjej7ohadniHYKDsSoc9
	hQ9ULk8UXKyZ9RgT23hdEyMJOR01NsQ5MfUUxAavWQUepDCFcY16WjCKKQDYIrXH7nIUDJcv1oY
	TPqrWGwWDtsYaYWloTTN29MRBQY4tYRZTRsdcl4NNmXOvaOLbqzfh0yaiZY5JAei3a6RR
X-Gm-Gg: ASbGncsSXCdcjsu66t8WB7w1Oca2BLMIYLlZ68M/qYiXlvxU2V53XgEcVxTEYwOz77A
	CNNzsb+Dmnh+8JVmuOZOy7RJ+8yKexGJ6wBsB33dF3X+CYkuTKGZqATfIkrUiQ0FQ/wbV7cy0VX
	DNIYwJIqmHULXTdXvox/kGWQqm718p6XHhuXxmVYTmPXKjvodeAOKzbH9/sCafl42973giy2ita
	2gqFYueahdHpmCJPptw/btVlnu9MbXTYYWsfGj7TVWU4+x/4ElMd0TWuoqE4Gu5STpgwQ6TL3Lp
	/AjhD6qluAtxw2cIM11EznKmFyV8poAGVywLLStzjMljf0chYKz6u/xSvoWZOZH6q4WHcAWmVG/
	3wnvdqG337+1WDhkf5w==
X-Received: by 2002:a05:600c:1c23:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-46fa9a892d7mr47582765e9.3.1760003092878;
        Thu, 09 Oct 2025 02:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9gDsR4HGquo/2JI/lZk6sK8VDkVdB5y9k+m65fa3iHwrikY3mxNzXnp+RSx/jRgjPRDHkiQ==
X-Received: by 2002:a05:600c:1c23:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-46fa9a892d7mr47582615e9.3.1760003092475;
        Thu, 09 Oct 2025 02:44:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb1e0f019sm18863005e9.10.2025.10.09.02.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:44:52 -0700 (PDT)
Message-ID: <6c346fd4-3c61-4b31-976a-41a2e2ef0afe@redhat.com>
Date: Thu, 9 Oct 2025 11:44:50 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/3] vhost/net: enable outer nw header offset
 support
To: Kommula Shiva Shankar <kshankar@marvell.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, jerinj@marvell.com,
 ndabilpuram@marvell.com, sburla@marvell.com, schalla@marvell.com
References: <20251008110004.2933101-1-kshankar@marvell.com>
 <20251008110004.2933101-4-kshankar@marvell.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251008110004.2933101-4-kshankar@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: emDycD0WIQbydUJbh7YFfunMAvJ1QAikJdrXobwlmxI_1760003093
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 1:00 PM, Kommula Shiva Shankar wrote:
> apprise vhost net about the virtio net header size.
> 
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> ---
>  drivers/vhost/net.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 35ded4330431..8d055405746d 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -78,6 +78,7 @@ static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
>  	(1ULL << VIRTIO_F_IN_ORDER),
>  	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
>  	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
> +	VIRTIO_BIT(VIRTIO_NET_F_OUT_NET_HEADER),

I guess this patch needs better testing; the above triggers a compile
warning:

./drivers/vhost/net.c:81:2: warning: excess elements in array
initializer [-Wexcess-initializers]
   81 |         VIRTIO_BIT(VIRTIO_NET_F_OUT_NET_HEADER),

which in turns hints the feature is not actually used/available. The
chunk should be:

  	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
  	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO)  |
	VIRTIO_BIT(VIRTIO_NET_F_OUT_NET_HEADER),

/P

