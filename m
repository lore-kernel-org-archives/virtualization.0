Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298EA32
	for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794060; cv=none; b=TNhiMUvJHtGggO7qn9kcjGD846DlvMU/Ch3MIYtAcUC8pUsIlanedj8eWFyPmEdAPBjhtnW+oMUkepOYqwhjXsckyCbQuv/gkww0FXRE3aZGUxaFioqBn2D7IFhJIfcw0Y/QCV78HM0WE4sCm3ghUGkNLsIJS9bhXfqRj1+27oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794060; c=relaxed/simple;
	bh=LkkRxVsKuChlvoYMnjLCZHxahJRvcKvpegCE7X/JCx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGzqebanb/Huvp8fHvXszZrpHvFTevuGJAIOnYFjmSNqYeAZRy3+Ee/eDKhCN28IxTKTzHGQMcXPjV+0yjeu54x0EGDl/2Yu4rMIyxYn8UhTqcM+5AV0brM/Jpi7zMF/PXilmsO7qXyZmBwPb08wj7U+Y6In68bUGNNribUSr8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+1I7hW7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+1I7hW7"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224341bbc1dso60721655ad.3
        for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744794058; x=1745398858; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmG5wLnCycwNioKCuXAaZLGjYi/ybga0dH9UjvjLbBQ=;
        b=F+1I7hW71/z1Pw/ySDT7LCq8ALK8tstHLvNTVJXNKd5yzf15PKsoAyMogMfFabsE1R
         HAs5oHkqEjy7qJINz7nMD6+U6AKJLbH6BptuaN+Vwe4oqwJ7AkUJo2/7dlMwqwO7LjXw
         0WV1VaGkRqAIonWEpv6LKFbO3fLc79MGud7RB2sVYwupUGlPktjf+zthAXmIjhoEGVK9
         RCJ9W7oZaVkkRJYQzr/awq6YdM2A/5HbBp87Y9pNqRz733ajKipWwuhJXfb0UTGuODZv
         oiN1H6M56MOWKk7rzjL/1kUVLb0NRm5Ihc1uw7BoKknpKe4WGOreHbBSgpi8T14DqtPh
         O56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744794058; x=1745398858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmG5wLnCycwNioKCuXAaZLGjYi/ybga0dH9UjvjLbBQ=;
        b=H4M5Z4QqYGoZ28EAu+xPOF4Pd99PTGhSA/TFDFjOOKVcMLHmQQ0acBt8Bhj1uM8ii2
         D9cVzg/jE0L7ja+X1O8+y7J9Toasc+HonuDJki9RDtjEMHeVNgM1R4YGmEsY7GhDvNxx
         FcOBK8JNPQcq4yBQa/40Awo76DVxM9XiAxoXzEflRldnzvVtJF3RKLmbn6UHhIeVlg7a
         vgLc+ExWLWcDkkYxash1Wq1MmJ8/gFzp/XJztlIYql9m1kEecJ0XKi5oU1vRVXsj9mtg
         GaGMwOBmr54VhAkmEOF0ibYtm/xObmvGCb7TrKKhhyhmTmCHqvuUcpnVyq4EGvOrau5G
         POdA==
X-Forwarded-Encrypted: i=1; AJvYcCXNtKIHp0NrtlkfkAF4g6DNNYvDK64g7xeNyB4qxDwTcZMNtjaCCAp0ROJaFZ9dC5AmmVggdUEQeCyCXE+cyA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyxw+zYR3oXJVLLZpkXJyvs/OczrWxulydtZJkK40y7a7L4IPD9
	RBVanfL+gcWOUzAAHKbrcy/u0t0pL6DOsFcjKq34zYziFvMRxwdR
X-Gm-Gg: ASbGnctD8gg1Q5oD0lxN+Ff2GAjDuTzh/ms8Lbi4jggV4pxYjZVdA8cee4t3AhJI1vf
	zUBX5hSTNA74fcWOfWoeKUW65w1uT4m7nz0NVL0Jo9wOW1lft4m+RpORPgk/NnoApjl2XPz0e6u
	yZj8GJyXOJ05tnIWdVd+OKVGeEDm9EtF6gru6gCa5UH6suXhfkkdOyt3KXvLsRCjB+cGqNzrWIx
	2lrc34jtsYcuohOYt2bRfM/T1YssEJ3SYwDCucLTZfi+Qbbn/IHpIFHWMeLgGFUZtWEm50dwHp2
	SDmoETH6IdtxNkh8Hz1nvTCBruzQ01F8TBR52QOSkjOiohQizQ7F0cFwv8s=
X-Google-Smtp-Source: AGHT+IFKvp8JSTcKdJ90nG6KVwZddhuAz0H9jshWa+isMyWM0doLGpZ4rJFIqTTHy7XwTHyjEXrxRg==
X-Received: by 2002:a17:902:ccc8:b0:22c:2492:b96b with SMTP id d9443c01a7336-22c358d9c65mr20545865ad.15.1744794058037;
        Wed, 16 Apr 2025 02:00:58 -0700 (PDT)
Received: from [172.16.0.99] ([113.161.92.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f8253sm10208920b3a.93.2025.04.16.02.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 02:00:57 -0700 (PDT)
Message-ID: <e5369006-1439-4936-9193-3f931f8a6f29@gmail.com>
Date: Wed, 16 Apr 2025 16:00:51 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: net: add a virtio_net deadlock selftest
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
 <20250415074341.12461-4-minhquangbui99@gmail.com>
 <20250415212709.39eafdb5@kernel.org>
 <1603c373-024d-4ec2-b655-b9e7fb942bba@gmail.com>
 <CACGkMEvceXT+=HJRRe6D3Zk3k40E2ADJiXNb4qqAYm=PZnxNpQ@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvceXT+=HJRRe6D3Zk3k40E2ADJiXNb4qqAYm=PZnxNpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/25 14:46, Jason Wang wrote:
> On Wed, Apr 16, 2025 at 2:54 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 4/16/25 11:27, Jakub Kicinski wrote:
>>> On Tue, 15 Apr 2025 14:43:41 +0700 Bui Quang Minh wrote:
>>>> +def setup_xsk(cfg, xdp_queue_id = 0) -> bkg:
>>>> +    # Probe for support
>>>> +    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
>>>> +    if xdp.ret == 255:
>>>> +        raise KsftSkipEx('AF_XDP unsupported')
>>>> +    elif xdp.ret > 0:
>>>> +        raise KsftFailEx('unable to create AF_XDP socket')
>>>> +
>>>> +    return bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} {xdp_queue_id}',
>>>> +               ksft_wait=3)
>>>> +
>>>> +def check_xdp_bind(cfg):
>>>> +    ip(f"link set dev %s xdp obj %s sec xdp" %
>>>> +       (cfg.ifname, cfg.net_lib_dir / "xdp_dummy.bpf.o"))
>>>> +    ip(f"link set dev %s xdp off" % cfg.ifname)
>>>> +
>>>> +def check_rx_resize(cfg, queue_size = 128):
>>>> +    rx_ring = _get_rx_ring_entries(cfg)
>>>> +    ethtool(f"-G %s rx %d" % (cfg.ifname, queue_size))
>>>> +    ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))
>>> Unfortunately this doesn't work on a basic QEMU setup:
>>>
>>> # ethtool -G eth0 rx 128
>>> [   15.680655][  T287] virtio_net virtio2 eth0: resize rx fail: rx queue index: 0 err: -2
>>> netlink error: No such file or directory
>>>
>>> Is there a way to enable more capable virtio_net with QEMU?
> What's the qemu command line and version?
>
> Resize depends on queue_reset which should be supported from Qemu 7.2
>
>> I guess that virtio-pci-legacy is used in your setup.
> Note that modern devices are used by default.
>
>> Here is how I setup virtio-net with Qemu
>>
>>       -netdev tap,id=hostnet1,vhost=on,script=$NETWORK_SCRIPT,downscript=no \
>>       -device
>> virtio-net-pci,netdev=hostnet1,iommu_platform=on,disable-legacy=on \
>>
>> The iommu_platform=on is necessary to make vring use dma API which is a
>> requirement to enable xsk_pool in virtio-net (XDP socket will be in
>> zerocopy mode for this case). Otherwise, the XDP socket will fallback to
>> copy mode, xsk_pool is not enabled in virtio-net that makes the
>> probability to reproduce bug to be very small. Currently, when you don't
>> have iommu_platform=on, you can pass the test even before the fix, so I
>> think I will try to harden the selftest to make it return skip in this case.
> I would like to keep the resize test as it doesn't require iommu_platform.

Okay, in next version I will force the XDP socket binding to zerocopy to 
setup xsk_pool. When the binding fails, 2 tests still run but I will 
print a warning message.

Thanks,
Quang Minh.
