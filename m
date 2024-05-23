Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FD5B5B8
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455357; cv=none; b=oUv5mre6abrYARUBOLeRGA4X470e2j1CBn9y05LIoH+xClaq2pz+VkRXXj1ADcFIhr3+w1SDhIViONH/cj+Nj9xKqplW7HVIYg3oDr4+0hxv83JCurjsw0PzxpB8BK7U6XHhV5dBNrcpbH4zxmJAzdKOAj+y1Qw4bT1AwNVSVBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455357; c=relaxed/simple;
	bh=2JYubz4Ps7KPt7XXfcnmfocab4Yao251kcNtVlyrwQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t96cwkgTJ7HQNX/HyBUACWsHvgWCSUNwIRv2MfvQKQZehkvwbefKGBJJM8STouMfLgga+kz0NBA3QwBqFg9VAP0HpU4wC0Y9w5Rg9Yxbbmv1IW2NXludrfVELF8OoStcxWueiUaIBjxM74Wfc+ejF613OWaUzVoXUuR4WLaK8MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aQ6DnZ6v; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aQ6DnZ6v"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-573061776e8so11250942a12.1
        for <virtualization@lists.linux.dev>; Thu, 23 May 2024 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1716455353; x=1717060153; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5SD+2Q/n2VCUhgMsXmzgdogRkao4DuVxoUJaRKE3zs=;
        b=aQ6DnZ6vvEay3wiqnani8A1v5Eu2iEZjEiExNRYuqhTC6B63zkRzDUyB/2x/2FfJUc
         DOHlssWVClWjTpA2tx0g0X+SXiMukUmO8R+EEWq6DV2v22Kdu+GO4dxFw4NyZywO9MYc
         Uao2OnhjcE80ez9hwILSyHd/Yb2Dyvu/OdWwxqXYuY6J+tamTo7qn6n9W9+S4AqPSnBj
         MEfOPFQhj/9HZGwW5IunKh3OrLJ++g0i7ca1v/pxsFGA11Yj1Hn42FJ1zVMlUU+mar+9
         MXeic2LiKSGzssdilPqOcccvyVyzTpqAeP+hsevSB1r4LRJZiwO3ngQe5VM1IiSgoxUB
         gXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716455353; x=1717060153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5SD+2Q/n2VCUhgMsXmzgdogRkao4DuVxoUJaRKE3zs=;
        b=X0TnAifLn4pu29U9T0PMRZUkqZYa44EvgrWC7NVaeqQtOqTUeIBSUI7RGFq9Y0CujX
         BYPeRgqFnBxQTv3xt/obaS7SPU1mI2oFIoVwgyAImn8qBFDjwjiTpPIBqyXPjEQHDLj8
         GprDbgacmL622fKYVDGBbp2hDBgQC1ieGDzqSdip99zu96bIY1IFhrRInG3Sr74Eg4qQ
         DJN3O/er5eCkHRVdT57UJJHQHMYXS/7YzQIdwhbBbqXNhrZPe0kqjyrtr34bz0U3a4gL
         r/poxJwQrcoSuhy1i4M1WM4sTI8XyN9TTFhtyXkcVs/O/ZtEWy5UbIGWJ8zj+setInxO
         3jtA==
X-Forwarded-Encrypted: i=1; AJvYcCU2mwVINMCb2mCAxUCtnFRNpr3zOt+YlRaQ4wrR8eKpb5hVw9GLTL+ckTF49w2bByC+T1CInAz7f8PlSzq9OTHBzcjTOwgl2dWsR3tj+rI=
X-Gm-Message-State: AOJu0Yyo95v/hjNLQnJKBrF2cCCRKzYD6v1cjoNh0QyXh2QfX3xebash
	lpJHOlFTDsqRQ7M2uHlGNpdmyKaV9A/wpQlUt6LRNUNCVz2mGCeLlO0CRJ6AWXg=
X-Google-Smtp-Source: AGHT+IGIKGAZV9XaKjWzU+vREJX1dK+rJPHwqt9SCZ2GLUEZ7Q56Oak3zmq8tVmP7jrz5tuX6zi6zA==
X-Received: by 2002:a17:906:ae41:b0:a59:f3f9:d24c with SMTP id a640c23a62f3a-a6228171dafmr272969466b.76.1716455353073;
        Thu, 23 May 2024 02:09:13 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a691870absm1444913866b.124.2024.05.23.02.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:09:12 -0700 (PDT)
Date: Thu, 23 May 2024 11:09:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2 2/2] Revert "virtio_net: Add a lock for per queue
 RX coalesce"
Message-ID: <Zk8Hts3HrzFMV0p9@nanopsycho.orion>
References: <20240523074651.3717-1-hengqi@linux.alibaba.com>
 <20240523074651.3717-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523074651.3717-3-hengqi@linux.alibaba.com>

Thu, May 23, 2024 at 09:46:51AM CEST, hengqi@linux.alibaba.com wrote:
>This reverts commit 4d4ac2ececd3c42a08dd32a6e3a4aaf25f7efe44.
>
>When the following snippet is run, lockdep will report a deadlock[1].
>
>  /* Acquire all queues dim_locks */
>  for (i = 0; i < vi->max_queue_pairs; i++)
>          mutex_lock(&vi->rq[i].dim_lock);
>
>There's no deadlock here because the vq locks are always taken
>in the same order, but lockdep can not figure it out, and we
>can not make each lock a separate class because there can be more
>than MAX_LOCKDEP_SUBCLASSES of vqs.
>
>However, dropping the lock is harmless:
>  1. If dim is enabled, modifications made by dim worker to coalescing
>     params may cause the user's query results to be dirty data.
>  2. In scenarios (a) and (b), a spurious dim worker is scheduled,
>     but this can be handled correctly:
>     (a)
>       1. dim is on
>       2. net_dim call schedules a worker
>       3. dim is turning off
>       4. The worker checks that dim is off and then exits after
>          restoring dim's state.
>       5. The worker will not be scheduled until the next time dim is on.
>
>     (b)
>       1. dim is on
>       2. net_dim call schedules a worker
>       3. The worker checks that dim is on and keeps going
>       4. dim is turning off
>       5. The worker successfully configure this parameter to the device.
>       6. The worker will not be scheduled until the next time dim is on.
>
>[1]
>========================================================
>WARNING: possible recursive locking detected
>6.9.0-rc7+ #319 Not tainted
>--------------------------------------------
>ethtool/962 is trying to acquire lock:
>
>but task is already holding lock:
>
>other info that might help us debug this:
>Possible unsafe locking scenario:
>
>      CPU0
>      ----
> lock(&vi->rq[i].dim_lock);
> lock(&vi->rq[i].dim_lock);
>
>*** DEADLOCK ***
>
> May be due to missing lock nesting notation
>
>3 locks held by ethtool/962:
> #0: ffffffff82dbaab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> #1: ffffffff82dad0a8 (rtnl_mutex){+.+.}-{3:3}, at:
>				ethnl_default_set_doit+0xbe/0x1e0
>
>stack backtrace:
>CPU: 6 PID: 962 Comm: ethtool Not tainted 6.9.0-rc7+ #319
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>	   rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>Call Trace:
> <TASK>
> dump_stack_lvl+0x79/0xb0
> check_deadlock+0x130/0x220
> __lock_acquire+0x861/0x990
> lock_acquire.part.0+0x72/0x1d0
> ? lock_acquire+0xf8/0x130
> __mutex_lock+0x71/0xd50
> virtnet_set_coalesce+0x151/0x190
> __ethnl_set_coalesce.isra.0+0x3f8/0x4d0
> ethnl_set_coalesce+0x34/0x90
> ethnl_default_set_doit+0xdd/0x1e0
> genl_family_rcv_msg_doit+0xdc/0x130
> genl_family_rcv_msg+0x154/0x230
> ? __pfx_ethnl_default_set_doit+0x10/0x10
> genl_rcv_msg+0x4b/0xa0
> ? __pfx_genl_rcv_msg+0x10/0x10
> netlink_rcv_skb+0x5a/0x110
> genl_rcv+0x28/0x40
> netlink_unicast+0x1af/0x280
> netlink_sendmsg+0x20e/0x460
> __sys_sendto+0x1fe/0x210
> ? find_held_lock+0x2b/0x80
> ? do_user_addr_fault+0x3a2/0x8a0
> ? __lock_release+0x5e/0x160
> ? do_user_addr_fault+0x3a2/0x8a0
> ? lock_release+0x72/0x140
> ? do_user_addr_fault+0x3a7/0x8a0
> __x64_sys_sendto+0x29/0x30
> do_syscall_64+0x78/0x180
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Fixes: 4d4ac2ececd3 ("virtio_net: Add a lock for per queue RX coalesce")
>Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
