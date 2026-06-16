Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA27376BD1
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642826; cv=none; b=X7wXFAchF6nmL3B3pVhipQMcRTsf+24FC7qBFRu9GKbOovWEvZ2wS1AQMS0Whvu22se4nyWX6bLCcOMPWjli9iEgPEICiIABE6IJ4IxLTZ9J/imfEcSi1ylZrR2Xe3R9QFfFFBDgQiHXZ07aYoiS23XQ6odexItju18OH1cnUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642826; c=relaxed/simple;
	bh=55ubhwgPFP/ggX+sEQoWYZsZ9CMeijE8qXL6+9SVM4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=se1NCn6oOGrZpRQzvMEXXuKwAu1Ew7T/17zbBLtScMefQOE0YwaGlUaNbSMhKVhKX8JqG9qwwrnYCUsNIKwUsG05pjuSQdrZZZgY1Le9AW68ny0CV2mYu9waMjkRgJw7GHS0hR7XSWal9a/WwoxwU8tPjmkgoOdVwyXlErdmw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=BH4nrCs6; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="BH4nrCs6"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43bfe055ffbso3222043fac.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781642823; x=1782247623; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3bsbmxS4GadL4Z4bToRsBD+Gi0dvukUshOqKGVXCG8=;
        b=BH4nrCs6ALJ6aNgnWhGBE40QwN5I/iran+lfXADPTH80I5DvG736PX0lVttEs1B8MY
         IZ7fPE2s0+MsdTNuW/0hA2pBUiXBvWBE+6HC/m/EDiZ/4zTMqpdERmGI1bf0rCZuHMy4
         6QaJICvB3LxgBDnO0JbGg4SihQZ/Ubf3PJeu3MvM7GZWH7GW6J0e0IXm7XeNBLi++DTZ
         djBmQgstkwU9x/6tl+Lt0kPCOBu1mwgGUtDe/2i7esqUO1e+kOludGc1jEBDL0CIdy+Y
         LCXvAFzz8mpwEOTHAIYOtOGaAYbjomLbNIO0wmkWuSJ8tPUx3Em8cZmPHXy7g98B1Olv
         7e1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781642823; x=1782247623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3bsbmxS4GadL4Z4bToRsBD+Gi0dvukUshOqKGVXCG8=;
        b=W0u3Xs0eVmL+b6YMW66g7uTY48BEaXrikSnfqQoQMxyfVoaQ3PWeP57QoU03BPll8p
         LaT2aXXcZ7+ygb1ICXQArj6XKcnbKCrlm8DWEChm4xq/SN9yo6jwgs0q5YJz67CcHiwd
         8u5zjdyVcg6EyXO/aHK1J9NzFZPOCw4Vs6sA8auCu6GwRpKeaxwsuVB/xI8NJ2Fea9E1
         L/FxFplc4PStjdhg2iXRpa2XkSUTn+E0EJiA+7YB6F6rZA939yo0qISP2pfmLIQkho2M
         SL1oQhXBzCC7fMT12IZBpMEiYMEz5MqZjA9M3A5UJpZls14bgQAVUhuGWOu1YEyuHWnM
         E+Fg==
X-Forwarded-Encrypted: i=1; AFNElJ9NqQ9b3S87iw9WsggzakLdYIeQbSi9iLxMaYA8YVnOSA0RWPE0PMm+0ViG4upURax58vIuQKqOPFocKxcMfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXmSbbEPhJlGGp2Njr75z09Z7fECTo+qVajG/d4f21qLjOuAMs
	G0apk0u1pS9PtomHCejJgSt1YowjJKotjC8MzJU5am3eBMcoSiwepun5taxAMmSSUc0=
X-Gm-Gg: Acq92OHCDFNgJdcdNgQRbOwAiWy1FTPE97EYPKLyPYtthMJVEOa1zLWeinTbNRgZWHW
	my7Wi9BdsKrONxnjMQ10lYTGiIvxQmJ4jJTXUMHNw9ySbL0DFceK86kW9V7eIxvoU1ICcxQ/1vM
	HllhXRIajCk8DKRA3xrpl16bQBZXrr1hzuNhOoHB0ppuS8lLASiIbPXh1RFOvf7ltQzMcQUia4i
	NRfmd8DPtlhNG1Y2ukqnC3Np1R61YQHQ585pzcXbL7U6NsKmM+a85TLaA5rsAOtvrgR4/4zT8HB
	GRX/wc37Qz4PUCgkq6gfROBTXsmWHL6SiDEcehxF57jGjDLdZ2xyIsnEdrb1t2S/EuTUst0XV+o
	z1w/Op/X0F6ps5NJhO4JOuLR+yZ8tUYQRtWwz3IbeEuiWquN+oIXKcE9xTw2hr+vmYSr1/LrXHy
	bKi+J404lA9TsiHLQMfyoE9QHLJtfk/KFKOWvrJBntJdheWa3V1qA0Su2yobvvmHD3Af/cfSFYC
	SNFGfA7AQ==
X-Received: by 2002:a05:6871:538a:b0:442:175:cea7 with SMTP id 586e51a60fabf-4469010a70amr626699fac.1.1781642823167;
        Tue, 16 Jun 2026 13:47:03 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-443090386basm2851306fac.17.2026.06.16.13.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 13:47:02 -0700 (PDT)
Message-ID: <910230d8-6a14-4d56-9520-169bd379f3d2@kernel.dk>
Date: Tue, 16 Jun 2026 14:47:00 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
To: Octavian Purdila <tavip@google.com>, netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
 kvm@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20260613000953.467473-1-tavip@google.com>
 <20260613000953.467473-2-tavip@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260613000953.467473-2-tavip@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/26 6:09 PM, Octavian Purdila wrote:
> Export iov_iter_restore so that it can be used by modules.
> 
> This is needed by the virtio vsock transport (which can be built as a
> module) to restore the msg_iter state when transmission fails.
> 
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
>  lib/iov_iter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 243662af1af73..067e745f9ef53 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
>  		i->__iov -= state->nr_segs - i->nr_segs;
>  	i->nr_segs = state->nr_segs;
>  }
> +EXPORT_SYMBOL(iov_iter_restore);

I don't have a problem exporting this to modules, but any new export
should be _GPL. So please change it to that.

-- 
Jens Axboe
