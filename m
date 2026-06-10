Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB537186F
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071394; cv=none; b=iwQAtwUB0pkR6m3VEZ03VNyj2bncnMYCWzZQOdUrhoqyhmrzUjfhSJWxqXfsTt4jeq0zyZYncU140PoghMB5nfH9/srT4XzxpWRjB7Gl3Cq2ubB2j4fl9T7TzXnVDlapZZVY3g0urfd4vxfh1iuNCW4m+crV78pQEVejPc2FilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071394; c=relaxed/simple;
	bh=pw88L/ouDyuHyWNL2/y8YiHC2YxgRVKO24sWCq/8McI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXahDq8KZ4XK1TP3Lp6ANfo0e5yn8qr4xwCWzc1WVCXMJeFPziDR9rhMsPkVxFv3mAbu+Oz4rDeGTMJf3fNtsMXU1/OKuBV1Zg0RQqSSOfo5KoMypa3uLH0B/bNHdCxbhnw9RQTvZoMswzxs8OYquntHNoQuFU+asrCSTsPQ5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yLd/iYMZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLd/iYMZ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8423f52af13so4455073b3a.2
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 23:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781071390; x=1781676190; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yk7RSWHHdbxWdBcudFPBcLz7KkZ0UbwwurunM9RMroo=;
        b=yLd/iYMZFpqcOyp5+qme0Jw1lpX78xWZC6ZV1ESU05yugthVvh9EcDGRiUfgG3kukQ
         izDXp6xk0lFsGj8dMmV1/UQh0bwECKJcI/hSSfchbp0jaoyXWBU709xodNtx4ZDoyX9+
         /ypKDNeDOLDJO3w46On2kj+8G4CWy2xwkK6AYvi4RbvAe6jWtygEWvNCqpRzm9tJt7iw
         mZAjiHokvPVBYxIpNGhOkY0ttFaBIVxOuR4YPFKHbWy6x3qHjEzNUfGFSTJIr8quPZCj
         S4N80nVshBKZW5idTVHF7qD6k2fdEQzHZkxkxESjg84U2Yo5/Olx6LvsyaWYAJBOaM9/
         2OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071390; x=1781676190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yk7RSWHHdbxWdBcudFPBcLz7KkZ0UbwwurunM9RMroo=;
        b=SaZa1pc0Svis8JLXecigE/WU7QbUpTMl48zv+Z0jFZtJVyCMBE+rH5yeKhekZLWteR
         W4Hf65JEMuvQfxFMGiUKcJXwVPK+zliP4UzRoZoYHNxAJ8XVp1hpeT7me/e7dyJD0VHZ
         Y4fbn0BknrM7lvgT4IDdRmpOmANsIuqFDBR52F9ALls33pvhkfZu3uKDeqBeR/Ic2KV4
         FyXTPI1gz2ZGPm8pH+INy2hyu0ELo/VJXkwruYvCo4t9/xOEJjBfiGTvu6H8BWoVkaZj
         QTGx6at56C6iys/jZuDmwS8BEFT0wVJARNNCj+b1a5C0E67dofZAH/jXaAf0YDh12HHI
         qTtA==
X-Forwarded-Encrypted: i=1; AFNElJ9sFcBJWebyKSbL5heCjIaRnnV/K/UBd1ks6MrDYEl26C/roCnu3dlXpL/9LKjnuDVGWTijeVbX7KiS0BfBiw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywa4UHKy0rxLzRsGnnLSR1zx92+VzW8JsRbkM5OuUVHTswvg2R+
	9dAJvjJixwy+VFh9dhLkip6iVmajxOu6kW/3dj91uOaNY1lCTu/K2ht8dyZr5oBCds4=
X-Gm-Gg: Acq92OHwok+gO1dwBDHRDq+yb39JyNBP1N5HfqkrvPUb0n8Kq9uiQ6fvTaUbJT6hO3x
	9X1TFgkUiLxGj/XjGtASsWvYATWPLVQJeFANx+qudvuG8Sdz28h4+RG3STpbTe7G7wl0OvgUTag
	PPZKMfQH8YFx7P6+IlpWNj2DVM4x8C+bkKHCGSnJz03jYLVEEje4cOn/lqXBKTZLN1Dv1RKmrIU
	EAPFsjxF4Bx9VXlOQ4DJLfWdUDYxhlvKSmP+97LgqsvPOJ/QGSQU6g7C8YP8p9egKi2MpO7ugKE
	NESAnIbPldo4yqIHuA5e3yMbfV+ulWn3CL+e4Az7YxLcd/qwC5a4q2c4GDS3f7jXhB8ZovUV5bU
	S7CQurhqKMIAeIonN3KNYUZNQ/6GpPQJaAjjXV2lOMZ2tfUJZ4YuWTb0X1v7yT8oIp8JbylH6B1
	HsdoXvHs1SQvwlqNddxxMtZBX+YTHM8O70rA==
X-Received: by 2002:a05:6a00:4b55:b0:842:5da3:9b8c with SMTP id d2e1a72fcca58-842b0f94b60mr24102426b3a.36.1781071390457;
        Tue, 09 Jun 2026 23:03:10 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828fa877sm23675026b3a.51.2026.06.09.23.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:03:09 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:33:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gavin Li <gavin.li@samsara.com>
Cc: linux-i2c@vger.kernel.org, "Chen, Jian Jun" <jian.jun.chen@intel.com>, 
	andi.shyti@kernel.org, virtualization@lists.linux.dev, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
Message-ID: <sw3omsbthxztl7p237jp2hamdxhauulh6nadlaefkms73qwbgj@2afkjcqrwbez>
References: <20260607143608.76122-1-gavin.li@samsara.com>
 <20260609134358.36583-1-gavin.li@samsara.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609134358.36583-1-gavin.li@samsara.com>

Ccing I2C/Virtio maintainers.

On 09-06-26, 09:43, Gavin Li wrote:
> Additionally, force usage of a bounce buffer even if the i2c_msg buf is
> DMA-safe, since the buffer passed to the virtqueue must remain valid
> even if the transfer is interrupted. Remove usage of
> i2c_get_dma_safe_msg_buf() since it may pass through msg->buf directly.
> This results in an extra allocation+copy when I2C_M_DMA_SAFE is used.

Please always create separate patches for such changes. It would be better to
not fix multiple issues in the same patch. That would also allow for a clean
revert of the change, just in case.

> @@ -82,9 +116,16 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
>  		sgs[outcnt++] = &out_hdr;
>  
>  		if (msgs[i].len) {
> -			reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
> +			/*
> +			 * Even if msg->flags has I2C_M_DMA_SAFE set, a bounce
> +			 * buffer is required because the transfer may be
> +			 * interrupted, after which msg->buf is no longer valid.
> +			 */
> +			reqs[i].buf = kzalloc(msgs[i].len, GFP_KERNEL);
>  			if (!reqs[i].buf)
>  				break;
> +			if (!(msgs[i].flags & I2C_M_RD))
> +				memcpy(reqs[i].buf, msgs[i].buf, msgs[i].len);
>  
>  			sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);

I don't think this is acceptable, bringing the performance down because the
remote device may misbehave.

Maybe its time for I2C and Virtio maintainers to provide some feedback here.

-- 
viresh
