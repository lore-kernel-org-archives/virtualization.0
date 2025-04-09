Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468E212FA2
	for <virtualization@lists.linux.dev>; Wed,  9 Apr 2025 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181755; cv=none; b=EMCCjMDqGccnBn/ASEfUwExlfYuvWKGdJ2TXG1pp1gfpJDkWMQ33F6oHR7rwm20FAkevP6fkqHU46RzHxA7pvdX8yxYoEi6fU0zwftdF6pdTm+25nyYM7i7FSA3/sZqsp8V+05d2ixpa3xMjoZNWHA5nSi/X+vctiXgsHTzdPYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181755; c=relaxed/simple;
	bh=OqC3v9Gphs/qwzgAJtXvKZfDCpF4ZGPS2GOM3FmsfrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzEUVfsM1vDrF5kd/ICEkWgKmibrbhxJXU9hJRFMYv/wmpVWCijRFTbgJghHawzbATKOCpsl9TERlKsr8TSNdVSMjRyH44PfnVz9ejsSuOQqtDCmJ6OLwkkeE1DUqJWGt9WqH5Pj8UnflUj3B0FARiULW5Kr+YlY9tC7w9QYXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7UYfl7Y; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7UYfl7Y"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af5cdf4a2f8so4719341a12.3
        for <virtualization@lists.linux.dev>; Tue, 08 Apr 2025 23:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744181753; x=1744786553; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Co6gQM2wtA55c6R6TA7F5Fe1d0+w5yIt8c2Cnbe3qs=;
        b=j7UYfl7YKnkZ/iKwTYl68cm2WWx3xl/dP2m+qNZJApQe462M/nC6wvVShQx8+PRgJd
         IpBPx/6mXVBpZvolakqstTODUKz6+FYy/jp8vQ+trE/GWE1qXyCfjSQEcS7QFTWzoDoQ
         ijltiWgkOWAv3c0sjd1+Of0SkOCGRgSDE72iukhscTxRJcbFSxz6E8TVIUzyJUS2Cf6U
         LlyRBc4LV7Ijg2a/55tTz6WYrJwCBiMdiUul+8pKfAtjraCfCmCuptEi4Jrq9ag7dRML
         QEkRQQJBN51hg51WvlC6XbZxN/nbeFCNzLzaIoTCQDG8GOYWCGGQI6yG49JxqIzUbFre
         pAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744181753; x=1744786553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Co6gQM2wtA55c6R6TA7F5Fe1d0+w5yIt8c2Cnbe3qs=;
        b=nbtEUwMyEL0M7y8/wMmaJySC9ageuWF5UUyEBenkoesmsRMvwnjba5NXQc3ABZuvMU
         fNq+OdG1Pgfg5Obsykfn+H7kU51LWn+jZ4nk4SFvHge8oSjz4BGJt4a9PoQhgHjceXaC
         MplPH2SteCG2Su5pvyHjvnYbWkmYxZtCObjZebf+23UxAGEp2aLnhmpOP6gsp7jPdzEK
         mEzoFR05saeNucvxbFr9crXzNHvGFTaPqJf6WtIr7Hrj+p9x6Dj7puF1c1u5p8bN7L4m
         SzqzbO0XMATvH7fkgG9JVBym0FeP81+L4S0QMHx13WuTx7Uvllxo76Qj+QzI74DS5weu
         wEeg==
X-Forwarded-Encrypted: i=1; AJvYcCWC6FyirnMY/GY+uvDqfyXI0u+Ht5ABj1CPD3b9COb7y27jXGcFFTfv4jzdC6Lk7v1km75AhQQ7AFamePjNRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxh7tSdp82vecOmKlVxk0r248aDyidnfS0vCjmzimI71AdGGoAC
	NlD/e958LEXj4fUcEjKi0k5owB5rfuegFahuy8VUZiNlQZ9A6A2w
X-Gm-Gg: ASbGncuGWwGrkFvtb7OBFcgCgmFaRp2ymZWiwfas6/QLxa9sgJfU2qxyLo84Dcj+Mqh
	jGQx/mtTiHPZsf12/nTuD8tjPLx5g8HM4IJmviOSyRWNOnu0+kpTdBwZ8KBJTI0F5CKxy0HDSyb
	u6h0CtDlaccmnfI10grdtkS0NaQcVKY0cEvQyk+K3PmZbROiec5FsxaOI+jnLO/9AePfxtUnTYi
	2MDnyjDJ0jDDJ5stRSfCQ9CaW5/tiu5Zq3DyaDiWE/gWNDRMRrPsO8R+TiCBvLt/yo9Ywo2xISC
	uiSRZbcoepYnISvCJfaclVbIKP4992fSSbY+EaKvbrBAPAqj/w==
X-Google-Smtp-Source: AGHT+IEFL/RkO95k+Uctmsp/HTB9p2W38kSipc4AhjUtOz8zgzH7KRoyrtOfhT8hIBTAFqPJi8hqKw==
X-Received: by 2002:a05:6a20:c6c8:b0:1ee:c8e7:203c with SMTP id adf61e73a8af0-201591ceb04mr2970714637.24.1744181753017;
        Tue, 08 Apr 2025 23:55:53 -0700 (PDT)
Received: from [192.168.0.118] ([14.169.40.45])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0cf374asm505349a12.26.2025.04.08.23.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 23:55:52 -0700 (PDT)
Message-ID: <58b84867-086e-44f7-86b1-c1759bbc2009@gmail.com>
Date: Wed, 9 Apr 2025 13:55:45 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
 <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
 <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
 <1b78c63b-7c07-4d25-8785-bfb0e28c71ad@redhat.com>
 <20250408073709.4e054636@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250408073709.4e054636@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/25 21:37, Jakub Kicinski wrote:
> On Tue, 8 Apr 2025 11:28:54 +0200 Paolo Abeni wrote:
>>>> When napi_disable is called on an already disabled napi, it will sleep
>>>> in napi_disable_locked while still holding the netdev_lock. As a result,
>>>> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
>>>> This leads to refill_work and the pause-then-resume tx are stuck altogether.
>>> This needs to be added to the chagelog. And it looks like this is a fix for
>>>
>>> commit 413f0271f3966e0c73d4937963f19335af19e628
>>> Author: Jakub Kicinski <kuba@kernel.org>
>>> Date:   Tue Jan 14 19:53:14 2025 -0800
>>>
>>>      net: protect NAPI enablement with netdev_lock()
>>>
>>> ?
>>>
>>> I wonder if it's simpler to just hold the netdev lock in resize or xsk
>>> binding instead of this.
>> Setting:
>>
>> 	dev->request_ops_lock = true;
>>
>> in virtnet_probe() before calling register_netdevice() should achieve
>> the above. Could you please have a try?
> Can we do that or do we need a more tailored fix? request_ops_lock only
> appeared in 6.15 and the bug AFAIU dates back to 6.14. We don't normally
> worry about given the stream of fixes - request_ops_lock is a bit risky.
> Jason's suggestion AFAIU is just to wrap the disable/enable pairs in
> the lock. We can try request_ops_lock in -next ?
>
> Bui Quang Minh, could you add a selftest for this problem?
> See tools/testing/selftests/drivers/net/virtio_net/
> You can re-use / extend the XSK helper from
> tools/testing/selftests/drivers/net/xdp_helper.c ?
> (move it to tools/testing/selftests/net/lib for easier access)

I've just tried the current selftests and found out that the queues.py 
can trigger the deadlock.

Running this a few times (the probability is quite high) on the guest 
with virtio-net interface
~ NETIF=enp0s2 ./ksft-net-drv/run_kselftest.sh -t drivers/net:queues.py

The test hangs.

I've got the hung task warning

[  363.841549]  #0: ffff88800015c758 
((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x1a9/0x3c9
[  363.841560]  #1: ffffc90000043e28 
((work_completion)(&pool->work)){+.+.}-{0:0}, at: 
process_scheduled_works+0x1c2/0x3c9
[  363.841570]  #2: ffffffff81f5a150 (rtnl_mutex){+.+.}-{4:4}, at: 
rtnl_lock+0x1b/0x1d
[  363.841579]  #3: ffff8880035e49f0 (&dev->lock){+.+.}-{4:4}, at: 
netdev_lock+0x12/0x14
[  363.841587] 3 locks held by kworker/2:0/26:
[  363.841589]  #0: ffff88800015c758 
((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x1a9/0x3c9
[  363.841598]  #1: ffffc900000f7e28 
((work_completion)(&(&vi->refill)->work)){+.+.}-{0:0}, at: 
process_scheduled_works+0x1c2/0x3c9
[  363.841608]  #2: ffff8880035e49f0 (&dev->lock){+.+.}-{4:4}, at: 
netdev_lock+0x12/0x14

~ cat /proc/7/stack
[<0>] netdev_lock+0x12/0x14
[<0>] napi_enable+0x1a/0x35
[<0>] virtnet_napi_do_enable+0x1a/0x40
[<0>] virtnet_napi_enable+0x32/0x4a
[<0>] virtnet_rx_resume+0x4f/0x56
[<0>] virtnet_rq_bind_xsk_pool+0xd8/0xfd
[<0>] virtnet_xdp+0x6d3/0x72d
[<0>] xp_disable_drv_zc+0x5a/0x63
[<0>] xp_clear_dev+0x1d/0x4a
[<0>] xp_release_deferred+0x24/0x75
[<0>] process_scheduled_works+0x23e/0x3c9
[<0>] worker_thread+0x13f/0x1ca
[<0>] kthread+0x1b2/0x1ba
[<0>] ret_from_fork+0x2b/0x40
[<0>] ret_from_fork_asm+0x11/0x20

~ cat /proc/26/stack
[<0>] napi_disable_locked+0x41/0xaf
[<0>] napi_disable+0x22/0x35
[<0>] refill_work+0x4b/0x8f
[<0>] process_scheduled_works+0x23e/0x3c9
[<0>] worker_thread+0x13f/0x1ca
[<0>] kthread+0x1b2/0x1ba
[<0>] ret_from_fork+0x2b/0x40
[<0>] ret_from_fork_asm+0x11/0x20

The deadlock was caused by a race between xsk unbind and refill_work.


Thanks,
Quang Minh.

