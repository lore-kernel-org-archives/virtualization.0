Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667355;
	b=CBowT63VaKFnD8eKH45mn1Y2P7ODGfl7ZGOqa0W8htW8DMJE/s2rO76/AYO6tXI0xW7F
	 z5++XqbF5/i5MOZ7ATpvp5c+Rm9By31dwK2k56o7pl0HPewCJ9Z9G91P6vrRU1Fzm4sRq
	 fg2t4voZDOli3sEeNRbgXUgrJLPxIa8b72OtLdIPfiTqV94B/O36J1mCKoe+QdD8Q/Kvt
	 1fnoyBWHbW4qfbtlm342Ap7M1J2je7xSfNAHDLU510Cpc77V72tgU5G/+aT35jY2GQ7TW
	 tkC+S45n+NPnx8PhSbq9BU+3tmn1dmcxEEcfT4Qxs+1ZDOwabog1h4jW4+XxgcLwyJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667355;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Kfr2FuW+/5jOkM/9Gp3elCy+BZlBPlM7YujpgdnE7n4=;
	b=xco5msxYCqKJNSuiHVIMpNpgbNuV34HMyIJ8pgJVRkcu3rZGCsZ8ucMb6HjnbAicDmti
	 j50VFnL22TxYgbim777Fk/f1J3/x+ChgxC2Yc7X1txQx1jAOqcqEhO1UuEVBR5kivvRL4
	 /PrJc5QLztB9HKKQ0fCm2YylvofZISI+SXA9rV1J/cKzgD8qB5A18OTItVMpNn382Cn+p
	 w6IajkpDlCKhEppk5Cr7pk5tnKYEDFdihFzohL03n6R2OwlSFs9gYgeyYDuyvMuoBpVch
	 y5qjSUbX/EXZ85+FB2WnkzQJnJGtkxAcq7yOwefoucQxwlFIY8KguFbedl8f66s0gtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Asf2VhRT;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A126606A324;
	Tue,  3 Nov 2026 00:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A126606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Asf2VhRT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Kfr2FuW+/5jOkM/9Gp3elCy+BZlBPlM7YujpgdnE7n4=; b=Asf2VhRTCw2kBIbQEhmDO7H0yC
	j7jlva9N+y60cS17zyDUA8GQT2Yb9swyp+IwxqSI3R6X6AR5bXMCrjibUaywJsGrUB7Kuu+Hk5wkU
	x4RmfftpuC4w0KUNjVpgEeI+eYAAMkj7311mj2CYSazvhO51lwRnd93vtPdTEutwGQh1F7tp6k5x1
	Xa5lactLWBWUuwjCR8WBGSko0nN2w9+TH3Q1kw2DKfPDw01e0PYTQl9eGLEmAbkcmEsyBKU/MAMiY
	hYzXNhusbLUEt7P0/qWbIVwO+C+ZLwYzMclmxWEVHft6/dnczL4rbBx3uG3Cdc0t7c5pHGCyK1UbJ
	21jiFraw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO2oV-00000000llV-0e9z;
	Tue, 03 Nov 2026 00:55:47 +0000
Message-ID: <dbf3b343-0af1-4297-b78a-bed68865d59f@infradead.org>
Date: Mon, 2 Nov 2026 16:55:45 -0800
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/12] docs: describe virtio-sound capture options
To: Joonho Lee <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: tiwai@suse.de, perex@perex.cz, anton.yakovlev@opensynergy.com,
 mst@redhat.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
 <20261103000403.67106-13-mynameisjune111@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261103000403.67106-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/2/26 4:04 PM, Joonho Lee wrote:
> Document the five opt-in capture module parameters introduced by this
> series. All default to false. Describe the startup-empty, short-payload,
> packed-status and pause-restart compatibility behavior alongside staging,
> and require validation with the target device.
> 
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
> 
> ---

Please include a diffstat for each patch (here, below the "---" line).

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -8328,6 +8328,36 @@
>  			brightness level.
>  			default: 1
>  
> +	virtio_snd.capture_allow_empty= [HW,SOUND]
> +			Retry a bounded number of empty startup capture replies.
> +			Format: <bool>
> +			Default: false. Compatibility option for devices that
> +			require staged capture; validate with the target device.
> +
> +	virtio_snd.capture_allow_short= [HW,SOUND]
> +			Accept non-empty, frame-aligned short capture replies.
> +			Format: <bool>
> +			Default: false. Compatibility option for devices that
> +			require staged capture; validate with the target device.
> +
> +	virtio_snd.capture_packed_status= [HW,SOUND]
> +			Read status immediately after the returned capture data.
> +			Format: <bool>
> +			Default: false. Compatibility option for devices that
> +			require staged capture; validate with the target device.
> +
> +	virtio_snd.capture_pause_restart= [HW,SOUND]
> +			Release and reprepare capture streams across pause.
> +			Format: <bool>
> +			Default: false. Compatibility option for devices that
> +			require staged capture; validate with the target device.
> +
> +	virtio_snd.capture_staging= [HW,SOUND]
> +			Use request-owned buffers for capture data.
> +			Format: <bool>
> +			Default: false. Compatibility option for devices that
> +			require staged capture; validate with the target device.
> +

All virtio_snd entries should be *after* virtio_mmio (alphabetical order).

>  	virtio_mmio.device=
>  			[VMMIO] Memory mapped virtio (platform) device.
>  

-- 
~Randy

