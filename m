Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EBB1F4FBC
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977984; cv=none; b=VX7Lk8qe+MHiAWbwXr338ln/i4q7+bh2mDZshTA0xF6ABHzzjexdqoOzqj1F2JVcFc87Q/gRSK3hP4t0tdMQD6KIqgfri2AV0/ou5XzIqiwaCHqtbKRahVBScNbbwaro6RFuDKFtCcgpmxzkbgzDQsa4BAemXkqWip64LpQzb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977984; c=relaxed/simple;
	bh=FAssYMuT3g1UCnr1f1768ULjkSWodEn3Mogao3a8VUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVtmf9UeTJsMYUnDWXJfJxxGiw5EEdECHQ6/Hg2Bid99xOnjBSEX4/Ci7LT+X9Mt6xMiUDTZIUdjJGOEjlTrEN+9QOiR8i7vxb10dHsVMChdm99vXYyUY1QI5VvPJCfTYuAKtqnLhzyNL424O4zrKoHpe0vCe+/URx8BpEBfZ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFw0tPI+; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFw0tPI+"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A00B403E2
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 11:13:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QqdRx5RaA0oW for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Nov 2024 11:13:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=dan.carpenter@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4A30B40304
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A30B40304
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VFw0tPI+
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4A30B40304
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 11:13:00 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a9ed49edd41so141937366b.0
        for <virtualization@lists.linux-foundation.org>; Thu, 07 Nov 2024 03:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730977978; x=1731582778; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bxTnaansLsGwyX4X1dG26PErwNbDYPOXaZq2IphXvjY=;
        b=VFw0tPI+RriFALPrQWc3oWmyyQKXzrNPJzIy+SFt+wyBQzMWGw4IMq2gw1T11E3vB+
         esEnVy7lsySdKWm0ErbRsL0uiiufGZKOEwTBPXEaWWp0eYAMy1AagMekAFYXLWMIh6r9
         fzf7dPJEhIpLkcQ/cExfGqUC9I3DPkPQpSEsH0dP5PwiwxiIfSoFz/9wfQAN3JqekATJ
         WqSVCD143MQOSZ5QLUbhKj53BDpVlH6QlWn8/I3C4tLGSB0p+8D6v4uAjiOjxmd7j4t+
         898Kgvp/xPNvfgB3aoEr90fvwXRa+oxLoxZKGQSESBdGqn8Imq5ZHrlF3lkznTz91THf
         sVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730977978; x=1731582778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxTnaansLsGwyX4X1dG26PErwNbDYPOXaZq2IphXvjY=;
        b=Kkf/iKniCHAy/x+WoVKyR7HSFEGRAme9pGeIn9/Pu++6dIzgUtHoujPqbertz6+8+3
         7IYcvBuAMou1qaCqRxznTHRIpUqzcQpOPD5DrZmUhWBMd69jWDQ7EdCVEHGQZIxPybHa
         gKIvsN1+9/Om/h9+lxoJya2dyxRmvs3OMNUnuFZShRVWk6hDchJGr2hN3+pzRlmrsu6w
         ofEctE+FC+nGQiWSIRASRVA/qFDEidlx6QmL6gFHleGRM6JhxRXs/NKbCnXSUjVxbpkr
         od4VCfIywGWhkrSr9Cwp2S+ra2wU2LTk5H74SjtfIMCN4nSUzzXIzSrX5e1yfZwYZZc8
         8tjw==
X-Forwarded-Encrypted: i=1; AJvYcCXL2GBdNWkabc2Xf1SusP1PrjNfHiaiqFvChoQCrED1q5xJPmqfbNDslga4URjHRZAwbnHAJ6wK2QaCo3XrnA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwujepU8S35nWU1vzCEvNlk6kJvecVtYsk22mim02LRT4Baphil
	ayVg+6zR8TnPzxW/p6wyTrdqOMv8uinH+nVWWY6xbIvJhSNa+R2TETmBP4jrbbI=
X-Google-Smtp-Source: AGHT+IFphj611143VdJsImYjeAH+pxPMUc82CFGVDH/4iqS20JWIIoXXYG/sr/hULPByHmo8QW5suw==
X-Received: by 2002:a17:907:7d8d:b0:a9a:1e4d:856d with SMTP id a640c23a62f3a-a9de5edb084mr4352238366b.22.1730977978083;
        Thu, 07 Nov 2024 03:12:58 -0800 (PST)
Received: from localhost ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e0fabesm77450566b.174.2024.11.07.03.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:12:57 -0800 (PST)
Date: Thu, 7 Nov 2024 14:12:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 5/9] vhost: Add kthread support in function
 vhost_worker_queue()
Message-ID: <e55d4e60-37ed-49ad-a8cc-f7b6adb03b09@suswa.mountain>
References: <20241105072642.898710-6-lulu@redhat.com>
 <247f4cd6-5653-4eef-9436-5699b44c4b82@suswa.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <247f4cd6-5653-4eef-9436-5699b44c4b82@suswa.mountain>

On Thu, Nov 07, 2024 at 01:38:56PM +0300, Dan Carpenter wrote:
> Hi Cindy,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vhost-Add-a-new-parameter-to-allow-user-select-kthread/20241105-153254
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> patch link:    https://lore.kernel.org/r/20241105072642.898710-6-lulu%40redhat.com
> patch subject: [PATCH v3 5/9] vhost: Add kthread support in function vhost_worker_queue()
> config: x86_64-randconfig-161-20241106 (https://download.01.org/0day-ci/archive/20241107/202411071251.tQLG8K6C-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202411071251.tQLG8K6C-lkp@intel.com/
> 
> New smatch warnings:
> drivers/vhost/vhost.c:241 vhost_worker_queue() error: we previously assumed 'worker' could be null (see line 241)
> 

I only meant to send this warning.

> Old smatch warnings:
> drivers/vhost/vhost.c:311 vhost_dev_flush() warn: iterator 'i' not incremented
> drivers/vhost/vhost.c:678 vhost_attach_cgroups() error: uninitialized symbol 'ret'.
> drivers/vhost/vhost.c:673 vhost_attach_cgroups() warn: iterator 'i' not incremented
> 

Not these.  I need to fix these for systems without the cross function
DB...  #embarassing.

regards,
dan carpenter

