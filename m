Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68082560AD8
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708111; cv=none; b=hIobi8zovZTRWs4l4XM3kP/vFkGu3P/wAH3yZmiUQYrezgSkF6tgTFZQ5KswhfeXI4L0I2PdzV0W6VFoYcBCJoVJTWE11VeO8jEexvy6yxYX2lJHCLZFu6WJAkibA2bk4NTRWZSlzQTSsgC86chyANh7v/fZvaXUGT31/z9XBcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708111; c=relaxed/simple;
	bh=Pk/5a+euc9+KQt8ccXqkIMO/jo2RiNiDERPo8DgohYI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=um+3ula6fQk+V3gSNM71lCbwOiOfc9Ra7g6nIvMnQjiXNbT2aZyKH3U5duGvaptTP7X/13dJZbe7Ondt5jOPL3+unz3cp/FeyR7ybeNkApDF+fL4zKeKwZE9EBZuluLx2VvNoJeW/sSRDnS3v2h1wp5+siqKh8IKq9HlOMgFEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=qSjyiOgv; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="qSjyiOgv"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b48100af4so824326eec.3
        for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790708107; x=1791312907; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xCuwMi4zULdHjWYJYrQu1pRHUDSa8xNrh2/5Zv8/EY=;
        b=qSjyiOgvLagMKVo+2wSJ6eyqWZ0HLGoY/snC2BPDDZ5kIP85PYVupTsB4u63L9sm30
         PHW01uz8vPDTSy3muY1RXG8nqNT6MrRZQdUG/HFKBbpMpbnE/skaCAzK/D+dIlgzZ0S7
         jfWiAFamnyaAHaf4sLniiDBpEbzaQxl6ywamNj9sdOBZhVfYtN4ZcdYJt2oL+iYTYwwQ
         HA8wvg/2p1tOtQ07ultXG5tf180AEm6etgC3ASRqljfferSVF3+yUAi/if6+ezo9FePt
         8smDKCDnDE2i+2M/0gOlsPrNZIsn82w13VEUmOQDrtNmsdnNkd123jr1mexPDDIn1lg6
         1G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790708107; x=1791312907;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xCuwMi4zULdHjWYJYrQu1pRHUDSa8xNrh2/5Zv8/EY=;
        b=mYT+ZjcAZ7P79i+PCqHtCOOxdZxhWvejL5XaMEQPlc7P5mVsWVmRLCQ9tbQYLazVhh
         GLRQ83mouZsCOevJ4/RWCyBdujRQtLLi1AxkjWoVQLzdiEy8Inbll7rO4k+ghe//l/Im
         ggXrSmyiu1iT1tUpcrZcKNEetVpxnZ1CFs28NmUJ9NqI/MXMDqGwHcyHbfB+fSfNfHLz
         XErOKkw13RP9kQ69a0AadGcg0HrHFMLKajqEFTAQ8MF2Fbr+urxCH0Rz22R3gcJsAfhb
         k2ZdacK599vv6Xx0f9HzKTl6rK3QrS3wWW4XuGjL4cpq1sHhv238QMu5t4Z/Wtit+3OF
         pEZA==
X-Forwarded-Encrypted: i=1; AKwUvBy8odAew6SgR8QtaSi9ZxIwQ1v1ZxRqKRFySzjaLAI/nFNiEJbVLrlC2OwVSO5xDrKdFw9lz0mLRANp6sdkTg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKQ9AfuBbRxXYRqzU0uBY6PUSEXgqtg6LW/QSluEYw5ZRCKDNef
	HHQnWh1Z82wIsw+lvW8tqwrhKahDAZbbfuqUz4qkxv6Oh+TbA2O+7+C5akeYrXpkl5QOmfBz+Ty
	IdExvS0c=
X-Gm-Gg: AYBFou0WK6fneiow/I0cbptTk+AA4L4/B/irpBuujBIBQ+t9PRZmXJzmB3gXgt1I7N4
	oqOK8gqrWY4qG+x+DOm6HETyDlTtAh2DCq150ro3bJUoIGbpPY5yb+3E6hZiNg0Gekxg3CNVWqN
	UtnGFJB3PWeXN2wKcaP8uAPPjAYrLuIuy62DxD+BCktLpA/kyFBVTxYBLoocvLOesckQV1CM8Xn
	dJ9ii2S9+vF+JHc+7n7rx5f4GSiw0uNWMQR1LPChUlDLSPgy52niPdh0sCqtwN8GLomjLd8GCO0
	c3Cni2pH3J7kos0ldCX8JM7OAdl3Mbjz1TriPhF2uJqcNm/f3o34ail3KSwyhwPMs60u+OB8a95
	HMPqY+dgySSFmORfXHSOKO/AltwmktZ4gPwZoOFW/4F9AJYxJbJbidzokojJMB6UIEVKiel5weP
	6n1OByoQMahpAH6fcPIrTHDKnM1grIIdyLh501axdFuN/23NpSo6ONRO3vobj5embJjRPkw9e1j
	vms41ULAWnFvkyHfs03a3hmziBS3gyF1IF3D9LV/VMM6SMFUmO9/PuKmmo=
X-Received: by 2002:a05:7300:b087:b0:344:c316:3451 with SMTP id 5a478bee46e88-34c67da3736mr283778eec.35.1790708106614;
        Tue, 29 Sep 2026 11:55:06 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34c386b6bd9sm1106541eec.16.2026.09.29.11.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:55:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, virtualization@lists.linux.dev, 
 linux-block@vger.kernel.org
In-Reply-To: <20260918140641.2031075-2-cassel@kernel.org>
References: <20260918140641.2031075-2-cassel@kernel.org>
Subject: Re: [PATCH] virtio_blk: set the zone write granularity
Message-Id: <179070810551.1304703.14426485043749461550.b4-ty@b4>
Date: Tue, 29 Sep 2026 12:55:05 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 18 Sep 2026 16:06:42 +0200, Niklas Cassel wrote:
> virtblk_read_zoned_limits() reads the write granularity that the device
> reports in virtio_blk_zoned_characteristics and assigns it to the
> physical block size and to io_min, but never to the limit that is named
> after it. queue_limits.zone_write_granularity is left at zero, so
> blk_validate_zoned_limits() raises it to the logical block size:
> 
> 	if (lim->zone_write_granularity < lim->logical_block_size)
> 		lim->zone_write_granularity = lim->logical_block_size;
> 
> [...]

Applied, thanks!

[1/1] virtio_blk: set the zone write granularity
      commit: 684b413b5483f57c890c171b9400076a0143b918

Best regards,
-- 
Jens Axboe



