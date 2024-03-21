Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D461757F7
	for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023955; cv=none; b=IMyjyxCLloALnN+lvh4HOVX6aDDgsQvpuR/o/Ug6MCQTT89xtH5uOZLk4vtSWdKofxrwBUkZiaptiAKxjooqwVYzODFdijLVwiWs/2K8jBWveRIBpKgRTbm9KdggM9+121iiqclfe8A8wHcnZcKN0Qu8rT/T7norvo52vqxrJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023955; c=relaxed/simple;
	bh=f0UFDOliM0/oFqbShrqNpo9zCLLTLt/hpgBvhtyDe20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGby/dAjnWZwfnmUN97K/PoMgYxLJWeJbE8mwWvpobzsy1JKwFgWGKn+Wfq51wDsPzMB2ZQ3tZT/qjwf7ghM0T+u32xaoLP1piCilPLT4mizPiOBPpjsnmyGfdCTYExN14oKZh24J5U2LvQfdIcfcFWEcAngsy8sK2hVp8PxBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=3RZITb8m; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="3RZITb8m"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4146f2b3fafso6482555e9.1
        for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 05:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711023952; x=1711628752; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m56XLFlbHMb5W7WCW5wQ6I/h2Kkdc9w2hy23AT0x+8w=;
        b=3RZITb8msWri9SY37QPSm2fMgPpbSQZ7cMrmxz72eQjPQGgb9LQD4ikqR2MkbK5LPB
         VYfTiw5f26arQf3DKpVBuHkZD16bbtDFHKsSVaYMLxyH+58ZJ2TF/d1qXd3yNLXB15y+
         jsQAZlwH4NC5BidcoH2MGZCX0BdKQQhVdEmbTLVHCfc1rF6WJnevW6PFI/lWgt+e4eH4
         p6YufkSd7bUzgrmg13rpeH/DVQ2fROp92vIYPjcRsLLw84SEHcrjrfx48PF7plYi34QR
         41wLF+t72e5K+aee96xvZqb5RN4rDtUw/+11KJXEmHyVYtkTvGs9kQEQdKD3N5a1HGpb
         lCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711023952; x=1711628752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m56XLFlbHMb5W7WCW5wQ6I/h2Kkdc9w2hy23AT0x+8w=;
        b=sQnCxeCZfo8+1+MXLSaNZayb0cmEDJR33qyaxrWkfxxazKhcOQOUwKXQJyUNnQy1ut
         OVlr5MV3lviLJS7V20SYY8Wk/cQbhwgUqSooZ26W+ALa2+6TZULYTBYzid7s7pQ/YHNQ
         pcyCmn/h7JhQUf/vH9KFVMUG7/wa5NoqnqOrOa63+ns+O0+QaOehqKCEjt+T4ybg2c/N
         JuUetoDZPcxc9u6fs0dKp6x8qOr7XhhHVgT0h5T4em3o4+45ngcNvGL74LpeD2bKqwrQ
         MLMunSUBVpM/A/kl6pXwZR3DVE8gPlk5PCe6SGDLYUuFdai8nWD1SfwwopNA/f9jKNHj
         iGWg==
X-Forwarded-Encrypted: i=1; AJvYcCXtYySXSRKHDDAjNMuQ2QRR7Re8ODMXKwTwVDOwMjXbypthaGQtxcGhzwUxXLuoYZXigREILJitHuH9Rx69jXkgo0bCjNEl7emRURrP59I=
X-Gm-Message-State: AOJu0Yy8l0dYUQf1lUTKAHHidaTh4CKLQGrV8+MNwWI0pIQ7e7rA0tZE
	k2M3jBOobFIs5OwY7kvBBppAVTvWdCeZvntxmNSuZDfwFxdQLCliIDMl6xm1mrY=
X-Google-Smtp-Source: AGHT+IGhXuA9mSb9k6iVMD5LLd452Lwv0mOTj1BFgjLiBJYBANZoXhSViPIyKUvXNEgYKATgMq1kHQ==
X-Received: by 2002:a5d:4483:0:b0:33e:7650:58b4 with SMTP id j3-20020a5d4483000000b0033e765058b4mr1434697wrq.27.1711023951565;
        Thu, 21 Mar 2024 05:25:51 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id q2-20020a05600000c200b0033dedd63382sm17012019wrx.101.2024.03.21.05.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 05:25:50 -0700 (PDT)
Date: Thu, 21 Mar 2024 13:25:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 0/2] virtio-net: a fix and some updates for virtio dim
Message-ID: <ZfwnSz5vP4KzXNxa@nanopsycho>
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>

Thu, Mar 21, 2024 at 12:45:55PM CET, hengqi@linux.alibaba.com wrote:
>Patch 1 fixes an existing bug. Belongs to the net branch.

Send separately with "net" indication in the patch brackets:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html?highlight=network#tl-dr


>Patch 2 attempts to modify the sending of dim cmds to an asynchronous way.
Not a bugfix, then send separately with "net-next" indication. Net-next
is currently closed, send it next week.


>
>Heng Qi (2):
>  virtio-net: fix possible dim status unrecoverable
>  virtio-net: reduce the CPU consumption of dim worker

The name of the driver is "virtio_net".



pw-bot: cr


>
> drivers/net/virtio_net.c | 273 ++++++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 246 insertions(+), 27 deletions(-)
>
>-- 
>1.8.3.1
>
>
