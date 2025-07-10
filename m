Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B61E0E0B
	for <virtualization@lists.linux.dev>; Thu, 10 Jul 2025 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136257; cv=none; b=M/9uFQvSa8cHhfXd7748kus+oHETC6i+f7NN8TofhD3XCfACWyx8kkhlBlJO10ZhNJ3wUWJzRQGqQOA2ZFbHcJjtjevMM7yYtyhTw9nLqHtyE26Soul4mpOdw04SWZYfMoVtcXlzoKW2KxbNx56TxPiCWP7nmyv3lgaWZfpyoJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136257; c=relaxed/simple;
	bh=MGRu2+QngwLs5uFhX6yStKHd0N3yjjMo437iKPhLRpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYSQXWeJLXz/Yk1ACVkD85anVmDODi6lvkKRKx4UXHV4RRvVao3tH/1tqxxkjgPisRFMR2GHfEBsxe6hzK+ZuJec4qYbelL+P9Hjh+pEbEHQxVhFjE0OOajv5fCH2hV8ZUd11X3PpI3VESKH1vDKpf6bndBMb5QefHFTlglmyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRIlT+Cb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRIlT+Cb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752136254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2K9+/07FmEiqTT+1vCXL7HOUD62rjsYkPTRRSfZI4VU=;
	b=NRIlT+CbGGVaYyexX0vkbYkewFW/E7XXzLlpR2zHfjyIbUEJJsLqCuwDfWm4Uwlt51jF9W
	opnDmDftScG0nF256W1q4LIiRAJfiWjU5BpD4KVHn6TspzCr+8atCXKDf8GllJPMHAnJkY
	cZ/w8Wq6J3Xb7lc2dKY+TWL86J1+s1A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-8xbSUK8wM3utLR_g8_AuSw-1; Thu, 10 Jul 2025 04:30:53 -0400
X-MC-Unique: 8xbSUK8wM3utLR_g8_AuSw-1
X-Mimecast-MFC-AGG-ID: 8xbSUK8wM3utLR_g8_AuSw_1752136252
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451deff247cso8574555e9.1
        for <virtualization@lists.linux.dev>; Thu, 10 Jul 2025 01:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136252; x=1752741052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2K9+/07FmEiqTT+1vCXL7HOUD62rjsYkPTRRSfZI4VU=;
        b=NP8r/HNkrh4ib/2odkBsI/44U+7HCwSCHTYIBuINKoBcJvd1zc/l8zZekPBYQEB9HB
         HOIPUfwvbrzzhZy9MQcI5lHnXA9UmuH4pNrrtaIpsnURw9tXDp+Zn4ayBtRwbDK4Rxok
         wia2S8JJJE0FH2gHKG60+D170wqbyswCtdLUIIWC3tDw2nu0TEgFBseIfyIeIZBw4vky
         JKwSrk6xLDq5WHwvrIZvRqnaUh+/HFd7OeGUCS2H3v7sMEQuAR39qVLz2R4T86p/b6x0
         W5kiyGSjubXmhTvN8K8w37sbwG7cRczYz+Yud+JHl97DOxJSDkmfC/o3YG+fvF3uPzva
         ONwQ==
X-Gm-Message-State: AOJu0YyWkd1Ck3sp+DdmL/tK6WNh9eDlzHcHPzyL/fIY8fQx0IXgHqrA
	LOytZJ2mofej3X+1aJxsuypmxPbtR6je1CpE6OCSO6koyyRhFTtyddrZp75/9L7rIG74jsUmD3/
	l4Vvm6EwPsIK7Y/XvTNkYX1hBVXSCGZXSJ5NdokzVBNeRYnUDTPgdOSu2bEatF+TGADs4
X-Gm-Gg: ASbGnctMsCqskdStGlF9V8QcU1zKnIJkqjIX33I5dOcTUOwPq1y54eN7f1clsyKyJO/
	Rw9UNSxQv5+/c+FDcV+TmczCUkrOCY9Rg2zUrK1b4RofqPa8gjtYmrJI+G2z3oqwjkWpwsXKSDL
	SfBgya/RRyq/y9DFJ17p19o1vbWcUqIEfrQOQXmXyXHr6B9VM2G7CsREIzeiVYKER6kxX76wAJd
	H3zwQq2q5AXsG4OH6arGcEN178020iwxmI+C/Joc3MQ7AUGi4sLQWOG84/1Yzvv7/y5PxIfL2pr
	WNhRpJ2OiPiqnxdIQpvYsYh1sJDTypIJcX86O09X/C9uzAvumQxW4WfXgNLJ8tJ1KF+kzA==
X-Received: by 2002:a05:600c:4746:b0:453:84a:e8d6 with SMTP id 5b1f17b1804b1-454db8815a6mr26571245e9.1.1752136251816;
        Thu, 10 Jul 2025 01:30:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfmngUjFtTpgc3VNRVQxUoFiGh7p4WIxZ5kf23OkSlRKWn+OvYDDDdXEdex3RWzzxe0vUghw==
X-Received: by 2002:a05:600c:4746:b0:453:84a:e8d6 with SMTP id 5b1f17b1804b1-454db8815a6mr26570895e9.1.1752136251383;
        Thu, 10 Jul 2025 01:30:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d575cbbfsm47859325e9.32.2025.07.10.01.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 01:30:50 -0700 (PDT)
Message-ID: <d86d4ca3-5d3e-461f-ac8a-9d8715413dcf@redhat.com>
Date: Thu, 10 Jul 2025 10:30:49 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio-net: fix a rtnl_lock() deadlock during
 probing
To: Zigit Zo <zuozhijie@bytedance.com>, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702103722.576219-1-zuozhijie@bytedance.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250702103722.576219-1-zuozhijie@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VeJuqSEkTSBeQM4DDojcXdqHt7KTIQ1uPb6nobBYEbM_1752136252
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 12:37 PM, Zigit Zo wrote:
> This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
> the virtio-net driver is still probing with rtnl_lock() hold, this will
> cause a recursive mutex in netdev_notify_peers().
> 
> Fix it by temporarily save the announce status while probing, and then in
> virtnet_open(), if it sees a delayed announce work is there, it starts to
> schedule the virtnet_config_changed_work().
> 
> Another possible solution is to directly check whether rtnl_is_locked()
> and call __netdev_notify_peers(), but in that way means we need to relies
> on netdev_queue to schedule the arp packets after ndo_open(), which we
> thought is not very intuitive.
> 
> We've observed a softlockup with Ubuntu 24.04, and can be reproduced with
> QEMU sending the announce_self rapidly while booting.
> 
> [  494.167473] INFO: task swapper/0:1 blocked for more than 368 seconds.
> [  494.167667]       Not tainted 6.8.0-57-generic #59-Ubuntu
> [  494.167810] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  494.168015] task:swapper/0       state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x00004000
> [  494.168260] Call Trace:
> [  494.168329]  <TASK>
> [  494.168389]  __schedule+0x27c/0x6b0
> [  494.168495]  schedule+0x33/0x110
> [  494.168585]  schedule_preempt_disabled+0x15/0x30
> [  494.168709]  __mutex_lock.constprop.0+0x42f/0x740
> [  494.168835]  __mutex_lock_slowpath+0x13/0x20
> [  494.168949]  mutex_lock+0x3c/0x50
> [  494.169039]  rtnl_lock+0x15/0x20
> [  494.169128]  netdev_notify_peers+0x12/0x30
> [  494.169240]  virtnet_config_changed_work+0x152/0x1a0
> [  494.169377]  virtnet_probe+0xa48/0xe00
> [  494.169484]  ? vp_get+0x4d/0x100
> [  494.169574]  virtio_dev_probe+0x1e9/0x310
> [  494.169682]  really_probe+0x1c7/0x410
> [  494.169783]  __driver_probe_device+0x8c/0x180
> [  494.169901]  driver_probe_device+0x24/0xd0
> [  494.170011]  __driver_attach+0x10b/0x210
> [  494.170117]  ? __pfx___driver_attach+0x10/0x10
> [  494.170237]  bus_for_each_dev+0x8d/0xf0
> [  494.170341]  driver_attach+0x1e/0x30
> [  494.170440]  bus_add_driver+0x14e/0x290
> [  494.170548]  driver_register+0x5e/0x130
> [  494.170651]  ? __pfx_virtio_net_driver_init+0x10/0x10
> [  494.170788]  register_virtio_driver+0x20/0x40
> [  494.170905]  virtio_net_driver_init+0x97/0xb0
> [  494.171022]  do_one_initcall+0x5e/0x340
> [  494.171128]  do_initcalls+0x107/0x230
> [  494.171228]  ? __pfx_kernel_init+0x10/0x10
> [  494.171340]  kernel_init_freeable+0x134/0x210
> [  494.171462]  kernel_init+0x1b/0x200
> [  494.171560]  ret_from_fork+0x47/0x70
> [  494.171659]  ? __pfx_kernel_init+0x10/0x10
> [  494.171769]  ret_from_fork_asm+0x1b/0x30
> [  494.171875]  </TASK>
> 
> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>

@Micheal: I think this addresses your concerns on v1, WDYT?

/P

