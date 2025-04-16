Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69D522FE03
	for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786482; cv=none; b=PZ98cPOz8xl8UyKHoULZq3AElITUwIWrDjkXuBIhidCQ4BK3VR0NdOTBAqfZnabge7Ct6oC8D3nk126aPoBjK+tlQ5glOvGi3W/k4Jt+fvNml53eR2xmWlESI8LHZ4/584fixeCGnXgQoICxoGbaxZlTBQqa1E7ih5LZXDJ967g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786482; c=relaxed/simple;
	bh=eMwxxrI/yqh3c02Xa/Zji/ZDs6jaXH0UXIImJ6rzu0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZjqAY09ERRBIAyO/khCMbRox8Ysj7faMGMLA/RMeXYp/2wNKa6Sh0yXwIUzfQ4mtC7r6nlJiKCNku7+XguJbLIm7YkTZtlu76+yZH4Zm8Ju9mttQoH10G5gCNEqLo+IkLaZtyp6v+8GfIxZYVloqfvzmRk12gaK8kzmHlpNpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKoHMyDj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKoHMyDj"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af28bc68846so5657442a12.1
        for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 23:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744786480; x=1745391280; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwHFx2X+LzqDnaO5ScRT2dnEDpqIh6CuLMeABnbFK/o=;
        b=OKoHMyDjwtgXaQPK6mT/Og5qxajtO8bzoxGi1BY56xqGcjE3yUl30OE8NFTO6ob1Uj
         A/t2Novg9uxFuOu6QZZMd22SEuYDDyyas8eTOphebOfdoXNz1u1top2MYygc5K8sFqMv
         LpjDmospth8Cf74Jn2JbR1X0MnR7M9SnxLoavkNzZzgFNw3n26+eNkb9qMNq5d+aU4jh
         ZFvIcFoXoncmsAHE6o9FXyfrCFuf3bXKaN9gchlZBdyP1fvaqxSuCDXehdI67kQ3n00S
         mldDCXaCWkXXPFWdxYDWFvK/TkrXPX2HjUJWnSeY1TwL0Uk/VWt0kStN6XkuyRE8poX3
         0tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744786480; x=1745391280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwHFx2X+LzqDnaO5ScRT2dnEDpqIh6CuLMeABnbFK/o=;
        b=TTFXWr9IRdXkOZNQwWh55ZdF/Gf5ci4CtM+QXDDiDg54fKm1Jy9sY8UmnWOlFmslJG
         2/P3H6I6/npAlFrr+PZsmtHtFOk4XopVHs+iY6BQ8Aw9hfrtsE52CVfZhtV3livABWM1
         lVe5txhIUMOUkbuZEoH7Kg7nZjpady19W4uu3Q1HSjDQMspy5keAiGhxy3a51x2sn6tS
         BtOK1kpVmn6I0J9UnKiTqQUM4zPVbudNDv3MavWATDZMd2biOcG6g5ubqgbrNEyll/yz
         MKDHNCrlzkR4VfWHzoOmSHmp4qwt3OZ3cGoa2EVIdDtraJx0euOYTkTXsw+SaFDGbXuo
         NwVg==
X-Gm-Message-State: AOJu0YywO0Hj5WhmQ4PB9KZcTeRbNJJGcLoCthuphZeBjYjbg1EvBSf/
	4CeRaI8xiosEugU/N36jdC7vS02/DCIABr2F9LNdy0KAyCEYuMDM
X-Gm-Gg: ASbGnctqHS3GzwYX5qlfcCRZsoFfX9SrYPkPwYj4mMkJIicjAddPUnFydrrgRVtb5Fs
	+IGkmkmYOdHItTob25yJOaxnLq6w8Ji/Th2vAr1deG/1dt1Y5VMDhcAYGYx2xeDPTQARiTT84pZ
	BvdLUkXLMVubCmyj9NWB6oRc3YRy+JavzClG0EtW7aKIe09SEwFD/8Uv0rSfu8gH7x7zNnCWk9H
	tdC6/y5tzK9g6t9gEqVxqJJbot77lY+Qds2nRkpMfmV0peMCjbGy0MNg4pw5ranJMPONNxPg0M1
	r2VdugpRAnaET5lyaGiGBx+fHvh1bp5Z1JZS9bt9jkQiHYD17OOm9nEBif8Ry7AIdWW8FI6WR66
	uCAPn2a3jMBs2cpF5Jqo=
X-Google-Smtp-Source: AGHT+IF8/C/bE/M8V11NAS4DjSmBrO99vSahBnCYSkXY7IEd2nQ+G+Lw7PFE5CD5FqU81B6JmzCipg==
X-Received: by 2002:a17:90b:254d:b0:2ff:6fc3:79c3 with SMTP id 98e67ed59e1d1-30863f1b878mr1169706a91.9.1744786479803;
        Tue, 15 Apr 2025 23:54:39 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:bc8e:5d77:bf95:efb6? ([2001:ee0:4f0e:fb30:bc8e:5d77:bf95:efb6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308613b2ff9sm785083a91.30.2025.04.15.23.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 23:54:39 -0700 (PDT)
Message-ID: <1603c373-024d-4ec2-b655-b9e7fb942bba@gmail.com>
Date: Wed, 16 Apr 2025 13:54:31 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: net: add a virtio_net deadlock selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
 <20250415074341.12461-4-minhquangbui99@gmail.com>
 <20250415212709.39eafdb5@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250415212709.39eafdb5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/25 11:27, Jakub Kicinski wrote:
> On Tue, 15 Apr 2025 14:43:41 +0700 Bui Quang Minh wrote:
>> +def setup_xsk(cfg, xdp_queue_id = 0) -> bkg:
>> +    # Probe for support
>> +    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
>> +    if xdp.ret == 255:
>> +        raise KsftSkipEx('AF_XDP unsupported')
>> +    elif xdp.ret > 0:
>> +        raise KsftFailEx('unable to create AF_XDP socket')
>> +
>> +    return bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} {xdp_queue_id}',
>> +               ksft_wait=3)
>> +
>> +def check_xdp_bind(cfg):
>> +    ip(f"link set dev %s xdp obj %s sec xdp" %
>> +       (cfg.ifname, cfg.net_lib_dir / "xdp_dummy.bpf.o"))
>> +    ip(f"link set dev %s xdp off" % cfg.ifname)
>> +
>> +def check_rx_resize(cfg, queue_size = 128):
>> +    rx_ring = _get_rx_ring_entries(cfg)
>> +    ethtool(f"-G %s rx %d" % (cfg.ifname, queue_size))
>> +    ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))
> Unfortunately this doesn't work on a basic QEMU setup:
>
> # ethtool -G eth0 rx 128
> [   15.680655][  T287] virtio_net virtio2 eth0: resize rx fail: rx queue index: 0 err: -2
> netlink error: No such file or directory
>
> Is there a way to enable more capable virtio_net with QEMU?

I guess that virtio-pci-legacy is used in your setup.

Here is how I setup virtio-net with Qemu

     -netdev tap,id=hostnet1,vhost=on,script=$NETWORK_SCRIPT,downscript=no \
     -device 
virtio-net-pci,netdev=hostnet1,iommu_platform=on,disable-legacy=on \

The iommu_platform=on is necessary to make vring use dma API which is a 
requirement to enable xsk_pool in virtio-net (XDP socket will be in 
zerocopy mode for this case). Otherwise, the XDP socket will fallback to 
copy mode, xsk_pool is not enabled in virtio-net that makes the 
probability to reproduce bug to be very small. Currently, when you don't 
have iommu_platform=on, you can pass the test even before the fix, so I 
think I will try to harden the selftest to make it return skip in this case.

Thanks,
Quang Minh.
