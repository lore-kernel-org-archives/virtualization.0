Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B663D34A791
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780890276; cv=none; b=r8tLzYFPPb1vFHdfxMX8Yq9aRwar3fCCaG9Vph8wdhMV+vd6VBiQRPWqzJ5KgVy+YuUC6CfU2muDni/+sBY6Hx8D0fjbz4xu6aKkO0qo5topgLU3UmcxphSh4dgK5DB0MhksLrfNXwx7gVx/SHSPdImWsh7OWDR8V63rjby2K4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780890276; c=relaxed/simple;
	bh=x/jE3WkInHWhOYnc0mIGEzA3lMatPTNns944BHfelV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPDVzVS5132cNzyDsWLKcaxufogEn6Bmti3uRNpgImfsA4vQv1BoB7Pm94cKp84R2gpOykH+r7/5pxCFalg/CAwFowphiE/6ZBatWHCSnL/503InSnX/QyWUsoQBMtIS6jRRZCYOfTojVjZbaKZe52cNYnK2V15yLcLDcD1GeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=acwPIXbY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="acwPIXbY"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84234c83142so1475942b3a.1
        for <virtualization@lists.linux.dev>; Sun, 07 Jun 2026 20:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780890275; x=1781495075; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2lKo0muPPjvxZp63cMcIf07S+igkG9mD6vGKVSxOx8=;
        b=acwPIXbYWCC5OVHcC79d5fHrsi0ZFm0yvpODrw1cbyVKsxhVbvs6v+gYVgG6FKMCEQ
         K3RYEQrfaF7wNtfHfjUm/A/qMtlq2keaHxepthug6jiuXQQRENTv4c1BZ22RIeYwUi3F
         MsLqjfRvoFtdS302JjTvFQNQYNfR7M9CC4uZsSvPXxwwYwiMiSF2jI2U5XeDUL7H1M1f
         5BtUdilsUglruD6U0AnMR8LUQcjMYYFtAT/W1yxZDia+g8wmHP0Cro6/MfJL8+5JG2dg
         Z43YooFPNIxcuyn5/FxWNFF7B1td2XoDuxUQXOP/mFHnaeBrPRt2HBMpYUhDKt10YGuH
         wb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780890275; x=1781495075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2lKo0muPPjvxZp63cMcIf07S+igkG9mD6vGKVSxOx8=;
        b=pKy8UAiVT3e3ZTcpJnQJFkp46YGQqyb9LXSQwa08KzbXwryocn570bx250Y8eUsfCa
         i2GY0KVt0hTHtgm8l4KeFj6/4Op9GUbCX+JxYnmmRVnAZq8IKG6Qzf/RI1m5g/r5AqUD
         sDh27wnqqHlZJgzEecKqQ9Dl3gME3vDj2KaIxBbplcbMf5hyYHezLEbNa/r5tKSTNdkt
         /uqsVdnxVbBXbE6breEA67GwCnZK9q6DAAl4FIU87IASGqaJYkqdbTFz0rR/lU2Q8zZ+
         Zli8Xx1kA89BSqSW7Y6v9uN7YEztt3KykKexU0cN/170tMwUy9GByonCydbzCzAaVOz+
         8aww==
X-Forwarded-Encrypted: i=1; AFNElJ+a8VWJhtJntkBTFDUn506BpTQbG7gmN6D/h8rOQtQWKm5q7x32Vi/W8N+AZhoGfGjtYbMAGdqcsvIzfqbzbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyMNiKbKtQtvW0eVXA6oePwb3Aiz9vyLjCxpoxqXGuAeGbHjj8
	enql1rMx/V5nVk4RjhtAeFZOFFoMMzKMk17V1SVyZDcNfOwyFqWkQt2qyxcdsewrFew=
X-Gm-Gg: Acq92OHBldiX5VPxqIpkMdCvumkY1JMTZVSQL9OFsWMGk0F4C8o8TSZOl+O+rr0aCzZ
	SL5XausBjEkByRClOlumiiFdjoCTYC1L+CEw8VYzxLdcttVTvjLMukR7IyokuS1wsAA4Sx5UZcY
	KWvrb6Bv6rnRuT43AMl60tOq2b7KVtFq+YbxvltcJ/CG41Xe93/v4XJq+XYc/INOZw+wXHD7+NB
	d2H4bGcToxv37M35HgNgyTBU6z6IbnY+RXLqJVxoTVL2YULAmUBeCJQydH0cQottpHij8PR4fPV
	P4v2QnakuWxMvcmSQleIml068uATYztqQjTnh19nXWGS2hBZOpq/yS2zPpaOOZjk6Teu9+81Qmr
	XFLUdEmxoZVSDkqogj+Ta0QurTZ7lV7HzHy2mV75GPcz09MD9t7ueyhlX7v3jzpS/9xM6s3ASbV
	4exXUclB0f4Bu4tv52Xx25Ss0S/spdKVPsuaYq2l3BAcrG
X-Received: by 2002:a05:6a00:a89:b0:842:83d1:ee6d with SMTP id d2e1a72fcca58-842b1004ac0mr13892308b3a.45.1780890274866;
        Sun, 07 Jun 2026 20:44:34 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842823512b0sm17180032b3a.15.2026.06.07.20.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 20:44:33 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:14:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gavin Li <gavin.li@samsara.com>
Cc: linux-i2c@vger.kernel.org, "Chen, Jian Jun" <jian.jun.chen@intel.com>, 
	andi.shyti@kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v1] i2c: virtio: wait uninterruptibly for completions to
 avoid UAF
Message-ID: <ars6vptfsifv3zvdbx2p7ihcw4rbwbgkvft3xpqyjbvkdckfzy@zxx2exbtuib4>
References: <20260607143608.76122-1-gavin.li@samsara.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607143608.76122-1-gavin.li@samsara.com>

On 07-06-26, 10:36, Gavin Li wrote:
> virtio_i2c_complete_reqs() uses wait_for_completion_interruptible() and stops
> waiting when a signal arrives. virtio_i2c_xfer() then frees reqs and the
> per-request DMA bounce buffers while the device may still hold virtqueue tokens
> pointing at &reqs[i] and DMA into read bounce buffers. Additionally, when the
> device later completes those requests, virtio_i2c_msg_done() calls complete()
> on freed memory and can corrupt the slab freelist.
> 
> Wait uninterruptibly for every completion before freeing reqs. This
> matches how other virtio drivers retain request storage until the device
> completes it. The virtio spec unfortunately does not provide a way to
> cancel an in-flight request, so waiting uninterruptibly is required.
> 
> Signed-off-by: Gavin Li <gavin.li@samsara.com>
> ---
>  drivers/i2c/busses/i2c-virtio.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

This is a revert of (and maybe better if that is mentioned in the logs):

commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible completion wait")

I don't think this is the right approach here. We shouldn't hang the kernel
indefinitely if the other side is dead.

-- 
viresh
