Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104FF803
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 05:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720418021; cv=none; b=ExoCIWeyFz5j2o0kcDEYrRGaeJ1OytiWo9trh2WCll0cTUJnpFNOpygamXxhx/R2/CUG4l1pNwJl8zfrDWH/8mbYZ96jqbVvJLzN60A/vVvn4BTXM5Qbpog9+S0/cqzDOmZPgYgFuutJ4Abm7G6akzd+KqUg/MMmlEVKmg9l+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720418021; c=relaxed/simple;
	bh=k3sZegvgCSRZDvxaCGbPMnrHk92nUiiu+U/vHSWHQ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxngKWdHT7Cxf6lsC/ZmDAADSOCYjVvsIioui7FQ1DRYw0DFJEhFQWahkYhY3GMsmeriYbqrIqsz4hn3z8ETT76VmvSHaASB9oWqJR3HZrP4G06oPnxjZDlRrtGZplDM+afVkDD3hzmlR4/WftHnhytmM8AjdZEqajw8y/S3ums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hkmr0mCd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hkmr0mCd"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70af8128081so2091598b3a.1
        for <virtualization@lists.linux.dev>; Sun, 07 Jul 2024 22:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720418019; x=1721022819; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7MnPLFqEr5wWUkJ5Avv6Q9E12ojEI+o0v8AA8IEQyjg=;
        b=Hkmr0mCdz/LWkTqRobvelfHL6BaMCdKD/w67cq1wG72TX6SvjsT0wgfiIdno+WSsx1
         jn+NyK5yxVoZILfDB95nrjt4FsW3hhrKDz4ojX/9L4h4TGaKGYUy8IpNssVc6FGf7iiU
         dZuyJhBx8mNMmtQyNh8vQYDv6GvLYrKUB/YGSh5l4G9KQeKbEhVFtQLSyV1mnucig0jZ
         U2J7G198gmQoWnXdJUtv3cbJW/21XhaOd2rC9vMfedZpw1YIiEbAUTRFT5fTUsKIbhwB
         jOVGDSPNPZ52Ap7oY6aLsaVB4x+bMKcne5uZJ/WXxyUdzylVGryuWgt2TwbygyK+soDq
         GT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720418019; x=1721022819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MnPLFqEr5wWUkJ5Avv6Q9E12ojEI+o0v8AA8IEQyjg=;
        b=k/7Wj5MsgMcnyMBb3+KCirEq1JH3p+0WoXiV4zFKH4R8+sNvgfRWbSSOjrusDhNB/x
         +ACFfcbxLZTGS/RpOmHHvD1PKNU9dAb5wTIOpS9iyOL0X4LYT4CTAq35/QaeIgWfF++9
         q6ztYTxvrKOchAL58eCKksxAkSHWYUqMzWs0QAESp+cZmou29kZjBCHqp3KEpQz1dyak
         MTCpuSeawjYbx4qaps0zg3SgLmpwYRVH+PfZsXJZyflxE+KUzP8LJN4fZ4LFWDUmgW0h
         nGeBuer+8weSE6EKFg91LABTQLdBPcNQs/pf5JYZO7XxN7849Z5vGlbdNeRxX9JwJLOp
         pzVw==
X-Forwarded-Encrypted: i=1; AJvYcCUmP5Fr7wsTbE/7pW7sQ2sEnxh5eYGumoiLzwo0NArBMYDKBRViudd0HPEzlu4pC46/mcylMGPDMtQKODqmLMi5DlLO+7tnIgQycerHmeM=
X-Gm-Message-State: AOJu0YzTnRAdNsWPjwZUhEtvFbWF/d4pZcCHUVAcHmxUtjtpOuCmLdk3
	HK6pOdzemFxlcrbjYxMli0/frK+y0xBAIilba7/TZ39CFP0rmsv5V6GLuB2Lyq0=
X-Google-Smtp-Source: AGHT+IF1hOX8XoGx5HyaWGW+Cyy7qlkkVoVp1tuooj1gaUVsR6BxjALo8kufZT7NlabK0CHhfGpMTQ==
X-Received: by 2002:a05:6a20:3c87:b0:1c1:a257:50de with SMTP id adf61e73a8af0-1c1a2575f9fmr1302191637.29.1720418019366;
        Sun, 07 Jul 2024 22:53:39 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a951741sm7333159a91.15.2024.07.07.22.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 22:53:38 -0700 (PDT)
Date: Mon, 8 Jul 2024 11:23:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Conghui Chen <conghui.chen@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 58/60] i2c: virtio: reword according to newest
 specification
Message-ID: <20240708055336.5yquzurmoydscvqf@vireshk-i7>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
 <20240706112116.24543-59-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706112116.24543-59-wsa+renesas@sang-engineering.com>

On 06-07-24, 13:20, Wolfram Sang wrote:
> Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
> specifications and replace "master/slave" with more appropriate terms.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index c60ae531ba57..52ba1e0845ca 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -183,7 +183,7 @@ static u32 virtio_i2c_func(struct i2c_adapter *adap)
>  }
>  
>  static struct i2c_algorithm virtio_algorithm = {
> -	.master_xfer = virtio_i2c_xfer,
> +	.xfer = virtio_i2c_xfer,
>  	.functionality = virtio_i2c_func,
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
