Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93561F6679
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978648; cv=none; b=HdRb9Gd2SoFpLM+XayVR2OjWrVJU4vf4XGOE0KgJJIgfg1DHf9VWdtNAPLb49JsLTLLnw/r6xt6ceR74+0UWhuO/QMCc8Q07Wcoyt4C3cWRHVgmmigV/Vd6m05CrbRkl+Fh4ON8GOGBOP+JbLarSR6FCvm7tjtPtMXplEt8e5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978648; c=relaxed/simple;
	bh=2GsD4FM0iXQ9ZQgHNEDuqIySpEr5mZ0z+3AwGF26ZN0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tBPXtIG+iDZSmMtSw9zXRuXQDaXL77a5t5wjCV7Vqhy/UxOGnPFk3gIbJ0ujh4daQbNnU4vruw0v1RThmdKTJJeuIWNggycW89iJSy5uuSkyTTtw5dDUTA5Xh2Q50j2XYV+jCh9WRHAD6m6YUJ3ApdG2es6zAscNQdEWBThvzus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wKKS9ZVq; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKKS9ZVq"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D7A380B2F
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 11:24:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fem7P0X1TuDr for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Nov 2024 11:24:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=dan.carpenter@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EC43E812B2
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC43E812B2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wKKS9ZVq
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EC43E812B2
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 11:24:03 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so7412165e9.1
        for <virtualization@lists.linux-foundation.org>; Thu, 07 Nov 2024 03:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730978642; x=1731583442; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YI7D6pYZ3MPTsBn2X/3v3EZ17avH4kCX3waBbepnJPk=;
        b=wKKS9ZVqn40OcVx17bOQIaz9Ze12phDR9j5lSodrSkGiO9gNfJZMpDWpyifymIOt6s
         eQUyTLnfobi7xHLnNl15i8/Fa5n1+aaKuLZvPiJBKESgUPn2Cz0Uc8rA1fYyz/yeCBnz
         LIrqdnmh4SM5/pq7ISa1E/5GlGODBkHMWQgecOjXU+Sx3CdKk7TIa6PH6RdUrafCQy8Y
         bS0dc3z6iQ4LwKBWMqS2RH+K+EA/uWKd4Qp1WW5X5vYXveGUlyQGHl+BpejMxHuKzIKY
         r8On8S8icykycOivFDTmV9018NzZIMklGcLfo2r6cvFQ/QrIjA39swcGYVpo5JwcYBzM
         DO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730978642; x=1731583442;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YI7D6pYZ3MPTsBn2X/3v3EZ17avH4kCX3waBbepnJPk=;
        b=HO8DTY8FrFT5m7hJi2d6PK+XR8A3BpIYdGD1hQkOOY27W8k6hbM5C7J/UFBzm1zbrh
         CgVhCsPXjfoKqxwh/WjxnmhtPaVo/XYMEzECCbWmiaARHd9lMVib5iZUPbMoFtACCJWg
         FkN2HaxuMWTWilQtrNEapnjq+GNOIbtw8nHtqGXJ9OYhlQfK9CK6IvyBeK6kaL//xh87
         yrZH3ZkehMXCd+chFNm0YXe3sz9lHB1Yjg5MmPDy9GXNJhAsOr1B37pPnQ6Qr7CgHvHf
         ESHaHa+oHnyveex3FfdcCGYDLMNx5Gu3PtObeYGBn3WvLCqP++jgcAcDtDjV/oO/GHt8
         nsHg==
X-Forwarded-Encrypted: i=1; AJvYcCWKOumoY2ya6o7+3YDgwGB7Lv8lxM+zoiNl2X2f71sAgvuDAgaUFoZyvShi8kyewhtxIt8bsTKbkQceyUgF4g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwyNh58vyUhsW0dneg+4skZStduBk4F/CM5qZFNiUSqGvQoMgGS
	2nYmcNteIewC/chufIg8Gq/TjnFA1BJgceLldHSp8QLZaRTKCDtQuw4KmQAV1c4=
X-Google-Smtp-Source: AGHT+IFBpowv+bSWYC6j4VAMIQVR8u8yrWok5kaYTtpzwW5CbfWm5qUgpBko8chZf+PgyCz8MppP4g==
X-Received: by 2002:a05:600c:348e:b0:42c:b74c:d8c3 with SMTP id 5b1f17b1804b1-432b30a15femr7963805e9.32.1730978641744;
        Thu, 07 Nov 2024 03:24:01 -0800 (PST)
Received: from localhost ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e56sm59261885e9.2.2024.11.07.03.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:24:01 -0800 (PST)
Date: Thu, 7 Nov 2024 14:24:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 6/9] vhost: Add kthread support in function
 vhost_worker_destroy()
Message-ID: <ed23b4b1-1aa8-414a-856c-15e072541dee@suswa.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105072642.898710-7-lulu@redhat.com>

Hi Cindy,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vhost-Add-a-new-parameter-to-allow-user-select-kthread/20241105-153254
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20241105072642.898710-7-lulu%40redhat.com
patch subject: [PATCH v3 6/9] vhost: Add kthread support in function vhost_worker_destroy()
config: x86_64-randconfig-161-20241106 (https://download.01.org/0day-ci/archive/20241107/202411071945.ExiEHgoX-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411071945.ExiEHgoX-lkp@intel.com/

New smatch warnings:
drivers/vhost/vhost.c:721 vhost_worker_destroy() error: we previously assumed 'worker' could be null (see line 721)

Old smatch warnings:
drivers/vhost/vhost.c:241 vhost_worker_queue() error: we previously assumed 'worker' could be null (see line 241)

vim +/worker +721 drivers/vhost/vhost.c

1cdaafa1b8b4ef Mike Christie 2023-06-26  718  static void vhost_worker_destroy(struct vhost_dev *dev,
1cdaafa1b8b4ef Mike Christie 2023-06-26  719  				 struct vhost_worker *worker)
1a5f8090c6de99 Mike Christie 2023-03-10  720  {
e4dec2edddbd54 Cindy Lu      2024-11-05 @721  	if (!worker && !worker->fn)

Same thing.  && vs ||.

1a5f8090c6de99 Mike Christie 2023-03-10  722  		return;
1a5f8090c6de99 Mike Christie 2023-03-10  723  
1cdaafa1b8b4ef Mike Christie 2023-06-26  724  	WARN_ON(!llist_empty(&worker->work_list));
1cdaafa1b8b4ef Mike Christie 2023-06-26  725  	xa_erase(&dev->worker_xa, worker->id);
e4dec2edddbd54 Cindy Lu      2024-11-05  726  	worker->fn->stop(dev->inherit_owner ? (void *)worker->vtsk :
e4dec2edddbd54 Cindy Lu      2024-11-05  727  					      (void *)worker->task);
e4dec2edddbd54 Cindy Lu      2024-11-05  728  	kfree(worker->fn);
1cdaafa1b8b4ef Mike Christie 2023-06-26  729  	kfree(worker);
1cdaafa1b8b4ef Mike Christie 2023-06-26  730  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

