Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F75214232
	for <virtualization@lists.linux.dev>; Thu, 29 May 2025 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748503911; cv=none; b=gcxZZ4dXiROvjfsTqczgZguBhrhgXN5YQPCZ60iPvx5v/j4MMvKfTg2TsaqQKmsUc/Du2If1vcLyucjF6WySHEBU3tUw51gVsLNLGl7xBaffN4agbN4rNlKL0vvZBb/u249BEz6/AY2z0hSJXJfCD73yqDLqyPGP+Abz/PGqhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748503911; c=relaxed/simple;
	bh=BFxCceWMxY0SEICuf5EA0saOeCuLQXtonksnjpgX6+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G10Brbh7U46aNSRno10kjOXB+h14PQ1OK3kJAAg+b1H+vSC887QFsV3zgVb/CKy03Xtm8Rt3cGF7zmCkZ7jBdUHRe8I7XHxVuneSRNot1VrNA/gjwTEzGgkoyKkNxwkq6XYkUvmoC7Ku2VpdnhPD7OpPhMEwLjpPML18pzSQXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GVu82CXm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVu82CXm"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742b0840d98so348403b3a.1
        for <virtualization@lists.linux.dev>; Thu, 29 May 2025 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748503909; x=1749108709; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=62y5vxiX9AVUW2V52SBBgeurxZxG3fCF/i4ngW1ZYV8=;
        b=GVu82CXm6GV91z1GC3n+BN4JcJpOBaXUfxI/RP35QcTixk8AiBBLsMioVl3SO5RNv1
         vT5mlEYKLVfP/5EO/8rIP9X++MVlR8pB0EwrykSsGMA1LO9e3d9k3j8h0Cgp3qIaWngw
         FacxEgqzrYVrI9Ip0QHLX2DZ73VqM6V9bQ+xV+vYDByWG+yvuFdCAxunC678n8w2V72l
         L8BK2cNjULrjc4O9W5yC+8Hw1Xqpzc5d6kiV8LDnEabwPOyED+jsNyQS3IYx3E8EYpTg
         ee70D75mrIvhcvmhMEJAAYuFeAtzZZLv9/lrnBnqFYHPbdHgqSV7VXyjycWg6VuiU9A2
         gkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748503909; x=1749108709;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62y5vxiX9AVUW2V52SBBgeurxZxG3fCF/i4ngW1ZYV8=;
        b=HWi9Ss6bZ/fBuKt2cR+jVOLk38yJyY2boGJO1CPs6XZHSMXEYG+4GVbZ3gDZaN7K1I
         RUOtFZX6Vs1DfiRzZSwNmuQr4oSuHqwnVAl07VR63D/F1SahzPr0jRQC6klsXQz9IRvR
         YuatFtTT7Ycf/nymYX8WmuhEl7D2cNGpbt5lUiy+zuRTm4xeNPIzmy1jy0tl53/oZfhc
         tHNbanI7HTl/oEqG/C0CtJ4ZafWIWH+ldxhUdPMfXmCpjXpDbhBs+K8sfwiZQbvNFvE5
         KSlEWdEomieXvBCmUpijd06pHuS3CZImh1gRc6LsDXxts8F3MwX5c3yhxIwwvRbC0zi/
         wBUA==
X-Forwarded-Encrypted: i=1; AJvYcCU6wqztS186Y/MUGlqPIbA0LG4putNVZJQbYoHaASBd9oRWFDnN/ca8/NAvKm0UXFInXMs+DFTiDmbo2AhuXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnkZoG1/njavLtn7M3XVtcDfEvI3XBnPrdgbZHCImtIskYELnB
	ocO7KyWLVkOC4VdYR0oEbiEUa6dc1uusIKPMJWsV6LNUM2av6Kh/D/irOUvSZ61zoLs=
X-Gm-Gg: ASbGncsQ6FHJI+i/97/MK+K5klriXYRmkf3KTEyfDQmfZ/suH6jbLODEpZ5luyGpyA1
	Gf0ymo8KYC3x7eQYS9Ba94XZdQv44M02qA+d/Inq0HRCDlNHU9RiI1H2eYBVctI3E7PRiyGJHda
	MbS/Z5zLNQmDibE1AUFgqHe1HANctAlIS8SPUUOqkfPe+1SdnpC648+62nbUFYKTHuz7uU28RJ1
	G7L2L5twQ+uQrEYHmh6UpLGUn4Od/IWsROo8IXAG7Kl4SeG5J2M6IimTlmErGmJG92KsK94+Q/Y
	H6k/66F5NfWrHOCggJNWCwgc/yM08fBaC0hwTRcfhSCjMv+etwM+PqcQcdX/fEI=
X-Google-Smtp-Source: AGHT+IFdl3yeDqGbsySeFH3EsP9AcF6U1idqzjnmwCHgn9ExUS6KfoHWBKHAHvMS270b21x4Yy7Hwg==
X-Received: by 2002:a05:6a21:3409:b0:1f5:8e94:2e83 with SMTP id adf61e73a8af0-2188c1eddbfmr31156339637.8.1748503908727;
        Thu, 29 May 2025 00:31:48 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2d99ec762dsm2149640a12.52.2025.05.29.00.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 00:31:48 -0700 (PDT)
Date: Thu, 29 May 2025 13:01:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-mmio: Remove virtqueue list from mmio device
Message-ID: <20250529073145.ss5ejipnlbl6v5fj@vireshk-i7>
References: <3e56c6f74002987e22f364d883cbad177cd9ad9c.1747827066.git.viresh.kumar@linaro.org>
 <CACGkMEsfgGU99_NC3NTYgyH89=6eADKPFiChVW0kZkfF1Js7NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsfgGU99_NC3NTYgyH89=6eADKPFiChVW0kZkfF1Js7NA@mail.gmail.com>

On 29-05-25, 14:05, Jason Wang wrote:
> On Wed, May 21, 2025 at 7:34 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The MMIO transport implementation creates a list of virtqueues for a
> > virtio device, while the same is already available in the struct
> > virtio_device.
> >
> > Don't create a duplicate list, and use the other one instead.
> >
> > While at it, fix the virtio_device_for_each_vq() macro to accept an
> > argument like "&vm_dev->vdev" (which currently fails to build).
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Btw, virtio-vdpa may need the same optimization.

Sent a patch for that now.

https://lore.kernel.org/all/7808f2f7e484987b95f172fffb6c71a5da20ed1e.1748503784.git.viresh.kumar@linaro.org/

-- 
viresh
