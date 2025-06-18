Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081DA29DB7E
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Jun 2025 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248400; cv=none; b=OUf7OckKnyv6cnv74ZnzMjEKjMtga9Ly9zpUEEh48WQE9y+ESz1okJYTbKi8WiE1vRUwjstDyvCGW8xWRw5wiuO+/J3ecugXdfTPkp/S1Q7Xm1k9O/3f4FOgIk7gCiRsmeU96Cea01PTQ7PGKPZRb6G0YK9w46V3YzjjJCTyE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248400; c=relaxed/simple;
	bh=uHxdHDEOTugKk9J9OjXhzGtnevhg6NmN+nEaYePZyBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QZJdUDxj93LamdHZTCCNJnV43rq7WTWST/S1xFZ8gKSH1GFhx5137rk/HHtyKNX2BSqy1W9sShK81/FvfWoaMQxVXYsZL7KWGLztIWqVqgSs0v7OSw/Uh2xu65t8cP7pf/8ixGY4lRIvYdDkRDjP/PhSkaKWFe/nHf71kl1+cA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Ne5IT3sO; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Ne5IT3sO"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92E9B80D64
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Jun 2025 12:06:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T3UHvjh01xEF for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Jun 2025 12:06:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com; envelope-from=nicolas.dichtel@6wind.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A519E80CCB
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=6wind.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A519E80CCB
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=Ne5IT3sO
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A519E80CCB
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Jun 2025 12:06:36 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3a4e749d7b2so781091f8f.0
        for <virtualization@lists.linux-foundation.org>; Wed, 18 Jun 2025 05:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1750248395; x=1750853195; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JtO+1zIjYRJs86fkY6zRnbrPpWElMpbcIKEvz5ZokbE=;
        b=Ne5IT3sOC+5+xW8kbUsB09ryfUCDOykSWoESvWv1Es1VTRG/q2R/mC0NENsLKoisUh
         fmoACvkM8KujMMCi39d2nv3+hBMme38gQsxpwXQZYwWWO5BDL6HseVsnAufLRCVRHfLc
         EfMfmb8Fx5QEgP8ZlusR+htYpaXG4NdKcSV6jXuxgRIJ34kPuSUIWB/V7OEiNNqq6nmg
         rQuFWCit/IMhvF07IGa8RUk4i+YwWfFh8DxqPyi3FXJaVXKHhyr9+Rk29FV2hCbhC/m3
         prxkjWYljvFaOFEU01MxLLmqSkkCNdbhOG7ZrxoI9/RqHLmnHfR2WDSQ8UN8uUf/qg/J
         /TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750248395; x=1750853195;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtO+1zIjYRJs86fkY6zRnbrPpWElMpbcIKEvz5ZokbE=;
        b=euzk0fYvA6MAvfqc5gfXjqLLzwTMmpebXFGvn8QbQjVblaD7j3NHDKBmElvKBRBvrW
         fwT9br2hUpNMGWmKvkrMptAZJUNYpM+7QkO5lRD99t+oOB5gx48kC0r1kSoU04Q4/6kG
         1y3Yyb08nknp5l97xUBlRWhsEVOlPGktHdRUSBxNss7J3oUBhHraYfttH1B0RtW6Rzp+
         FExevReEyEoaMFcXRyzyf+/lmDcQovcVbRNDM4ohMKTAGHuHmWDiaGYA05VPqc6IC5W+
         d61fMeTGgQhgjlFkiyKIqCM+0reyB4237ggJGD8akMvfTQQKB6vhfjoNNPZxEjx5IPb3
         7reQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8nihWmDTxpo0uO/qkqTSv7sRHQwTFhH66TbZ7FnMZokSftBamebvbJWw1L1gcZqpDSfSziSXtJinNsJ47+Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyLAqy+fZAeiRDN8a8J3yHlh89DspjDDVXvlckn2LfJfXU5LPBj
	B4YF7psc9nJj3qUb69Qu1WK55w6YRVC0UGb/PN9kqlvPQHHo6BSgttmZft3SQgHndcc=
X-Gm-Gg: ASbGncsr4tHAMNjR3yAf9u2V9t5VGY3xjXzbQhD34rq1AJm4T1fOEq+YBg0cu/tDRGI
	mrc6O8usbblTBBHXg1EMAwZktuENZaEFr0Q4c3+uyT+MKTm7oaD9LhXQW3/gCupgawbeSaAwA0G
	JFYOlwpgXOxeV78wyMB1I2tD2l6ZhJZ020YqBgf2CvMGhE1H8f9wOiwKCBW+yiY0EqDMK00eFjd
	DALPc6OYAJ+SeGaBEqEJt8b6rXi+ljFyjv1TRT8R6vJNJOf8/3SrnD3j0EChOG1+u9LF/tn23yZ
	fKgnXBhQ35bKGV2AzVM/FGtIlWgP2UGlbvFEUEV1BTAhtEQhzZTkH5oq/boYUQV+wfflTT7/6Nq
	H7gcwxQ==
X-Google-Smtp-Source: AGHT+IHw8NEafcpaIypnwCtdzWnvZDL+f6HF2yLjNIyemROAVUnq+qOCCQ7uNSAQajDmZhfC1cJ+LQ==
X-Received: by 2002:a05:6000:4203:b0:3a4:dbdf:7152 with SMTP id ffacd0b85a97d-3a585f7d67fmr2085596f8f.14.1750248391929;
        Wed, 18 Jun 2025 05:06:31 -0700 (PDT)
Received: from [172.31.99.185] ([185.13.181.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm207704175e9.4.2025.06.18.05.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 05:06:30 -0700 (PDT)
Message-ID: <6107dcb2-51a3-42f8-b856-f443c0e2a60d@6wind.com>
Date: Wed, 18 Jun 2025 14:06:30 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v12 1/1] vhost: Reintroduces support of kthread API and
 adds mode selection
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
 michael.christie@oracle.com, sgarzare@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
References: <20250616062922.682558-1-lulu@redhat.com>
 <20250616062922.682558-2-lulu@redhat.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250616062922.682558-2-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 16/06/2025 à 08:28, Cindy Lu a écrit :
> This patch reintroduces kthread mode for vhost workers and provides
> configuration to select between kthread and task worker.
> 
> - Add 'fork_owner' parameter to vhost_dev to let users select kthread
>   or task mode. Default mode is task mode(VHOST_FORK_OWNER_TASK).
> 
> - Reintroduce kthread mode support:
>   * Bring back the original vhost_worker() implementation,
>     and renamed to vhost_run_work_kthread_list().
>   * Add cgroup support for the kthread
>   * Introduce struct vhost_worker_ops:
>     - Encapsulates create / stop / wake‑up callbacks.
>     - vhost_worker_create() selects the proper ops according to
>       inherit_owner.
> 
> - Userspace configuration interface:
>   * New IOCTLs:
>       - VHOST_SET_FORK_FROM_OWNER lets userspace select task mode
>         (VHOST_FORK_OWNER_TASK) or kthread mode (VHOST_FORK_OWNER_KTHREAD)
>       - VHOST_GET_FORK_FROM_OWNER reads the current worker mode
>   * Expose module parameter 'fork_from_owner_default' to allow system
>     administrators to configure the default mode for vhost workers
>   * Kconfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL controls whether
>     these IOCTLs and the parameter are available (for distros that may
>     want to disable them)
> 
> - The VHOST_NEW_WORKER functionality requires fork_owner to be set
>   to true, with validation added to ensure proper configuration
> 
> This partially reverts or improves upon:
>   commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>   commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/Kconfig      |  17 +++
>  drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h      |  22 ++++
>  include/uapi/linux/vhost.h |  29 +++++
>  4 files changed, 294 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index 020d4fbb947c..1b3602b1f8e2 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -95,4 +95,21 @@ config VHOST_CROSS_ENDIAN_LEGACY
>  
>  	  If unsure, say "N".
>  
> +config VHOST_ENABLE_FORK_OWNER_CONTROL
> +	bool "Enable VHOST_ENABLE_FORK_OWNER_CONTROL"
> +	default n
Why disabling this option by default?

Regards,
Nicolas
