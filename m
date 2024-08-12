Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD61862B2
	for <virtualization@lists.linux.dev>; Mon, 12 Aug 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481248; cv=none; b=GPqMs2i2vWnkoZ9G0gIDvYxQAgEVxFMhq2LXCBkSZ7JZiKfIDXkHqT+4B70X/2DVU2o8PD8H1yxxfG0a2sjHGJwvd9VsxbxDmN50jMm00N9zhUCXnOoAe/1ikoXO9b2RlIGNeCdq4RPeFJh2vU16zvTaK47Ic2ZJaImkC7I2jrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481248; c=relaxed/simple;
	bh=nzSfCYVp/w6falcxQaVO08jmUZRQNVRxZ4jNeeB08tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dzp+jH1gFw3nCvaUlL9LCnU6OQoC5VOdECyyH/NoMLFcyNpumg556OSYV+n2dmTp2jQRKW3JQtjtn124OD0P9sXXI2hdWIRjA18N7HivfvlSTgs6dJnCAF6rTm7m5FVBFOhrOyohfOtme7HkKCV1GNZv2VbD7lvdYBWD9w6GyDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rQQPfQ9x; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rQQPfQ9x"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso34583695e9.0
        for <virtualization@lists.linux.dev>; Mon, 12 Aug 2024 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723481244; x=1724086044; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+qmYh43xrJTCXcmc0Emw/Wgn7SNi5KSt3u4hAdZFhfQ=;
        b=rQQPfQ9xkCukIF8mricpfsXfbgunEBnIFW/Z+Bk3BcjmG+u+V63JBOPQsbyEAagbrx
         ABEv1WKDmQAyy8tcgyVMkU3gL3sGNtottP4D32KWcPqAecSCKgfRDqE/62/XDG9FRGew
         VpFueF8RZSww3kRDrOnAMnGmnSeiWbnVXVx13zLvPHT0l/7guv97gSuro0hCD1rPXP7n
         KtqzbUAOwZm2DJDCWMhq191pGvN3/PiHEKPOB78KUHayE9RzyJ1kLl/WKzUra2R0BcBV
         1m6xSx/cxBv0jSZngeLUiEItIC+K83ZB1bO1nbj1Fw3gh/ib/1wx7v5Gz879rES3O7FL
         8erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481244; x=1724086044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qmYh43xrJTCXcmc0Emw/Wgn7SNi5KSt3u4hAdZFhfQ=;
        b=YgYM0pxghE/hv586jaAtqx2jw0YS8yKDcTxY+bhuS7jTsgFECTcgeLmG6uIYTlNet/
         1RyLcGok6RlE/DXb2Ee8uSTBWcwuMhwuj9puq8i5VrMYh+vbiIwqVP1qxq6hONbfeUqM
         A2NOh4uWIEta4HUu2OXol8DT7lumsdXAmF+fbufGnDX0K4QMIEuMjJ+67C7NlMVr+jVN
         2C/xvxANqmy3lVrCg9MBsdNPNBGum3t6lbnyf3vX3YHcQ/BwKxwhXBaH7s1Ps1D2eR5U
         6qzpRmF++qo9t2/jlSL4/01wDvMCu7gfGXNsMGARzzNNDBb+JokNntuhj9r8grEnAAi5
         /+kw==
X-Forwarded-Encrypted: i=1; AJvYcCU1x70CHA4+tkeM1rEsyXOKzYGGFw9EpkNErsVyjr4CGNwthqZegoDX+V9DM1IGf6OfWp6aJoHCywuIlt3a3EXKzJiVVN/JdahGGUn+v0A=
X-Gm-Message-State: AOJu0Yy0O2Xvralqama1+LLRzORTgeDM8iLvjqLxTHnwxozje1fKgDoh
	iVmABsMSOYpqsJWxg3uY4YxkCA4eL7pA44dYXEfh2FsNQvlOf3fUNt7QGCWI46U=
X-Google-Smtp-Source: AGHT+IFrAvXysVgyqP+hS0kfQK7uLO5VMJ6VTPDxeoxQ2hpnNSYdogdPtpQCAktagXpfItZVMX4JdA==
X-Received: by 2002:a05:6000:c84:b0:36b:c65d:f669 with SMTP id ffacd0b85a97d-3716cd23d21mr649724f8f.49.1723481243572;
        Mon, 12 Aug 2024 09:47:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c775fc9csm106931135e9.47.2024.08.12.09.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:47:22 -0700 (PDT)
Date: Mon, 12 Aug 2024 18:47:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	dave.taht@gmail.com, kerneljasonxing@gmail.com,
	hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <Zro8l2aPwgmMLlbW@nanopsycho.orion>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <CGME20240812145727eucas1p22360b410908e41aeafa7c9f09d52ca14@eucas1p2.samsung.com>
 <cabe5701-6e25-4a15-b711-924034044331@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cabe5701-6e25-4a15-b711-924034044331@samsung.com>

Mon, Aug 12, 2024 at 04:57:24PM CEST, m.szyprowski@samsung.com wrote:
>Hi,
>
>On 18.06.2024 16:44, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Add support for Byte Queue Limits (BQL).
>>
>> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
>> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
>> running in background. Netperf TCP_RR results:
>>
>> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
>> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
>> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
>> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
>> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
>> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
>>    BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>>    BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>>    BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>>    BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>>    BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>>    BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
>>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v2->v3:
>> - fixed the switch from/to orphan mode while skbs are yet to be
>>    completed by using the second least significant bit in virtqueue
>>    token pointer to indicate skb is orphan. Don't account orphan
>>    skbs in completion.
>> - reorganized parallel skb/xdp free stats accounting to napi/others.
>> - fixed kick condition check in orphan mode
>> v1->v2:
>> - moved netdev_tx_completed_queue() call into __free_old_xmit(),
>>    propagate use_napi flag to __free_old_xmit() and only call
>>    netdev_tx_completed_queue() in case it is true
>> - added forgotten call to netdev_tx_reset_queue()
>> - fixed stats for xdp packets
>> - fixed bql accounting when __free_old_xmit() is called from xdp path
>> - handle the !use_napi case in start_xmit() kick section
>> ---
>>   drivers/net/virtio_net.c | 81 ++++++++++++++++++++++++++++------------
>>   1 file changed, 57 insertions(+), 24 deletions(-)
>
>I've recently found an issue with virtio-net driver and system 
>suspend/resume. Bisecting pointed to the c8bd1f7f3e61 ("virtio_net: add 
>support for Byte Queue Limits") commit and this patch. Once it got 
>merged to linux-next and then Linus trees, the driver occasionally 
>crashes with the following log (captured on QEMU's ARM 32bit 'virt' 
>machine):
>
>root@target:~# time rtcwake -s10 -mmem
>rtcwake: wakeup from "mem" using /dev/rtc0 at Sat Aug 10 12:40:26 2024
>PM: suspend entry (s2idle)
>Filesystems sync: 0.000 seconds
>Freezing user space processes
>Freezing user space processes completed (elapsed 0.006 seconds)
>OOM killer disabled.
>Freezing remaining freezable tasks
>Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>------------[ cut here ]------------
>kernel BUG at lib/dynamic_queue_limits.c:99!
>Internal error: Oops - BUG: 0 [#1] SMP ARM
>Modules linked in: bluetooth ecdh_generic ecc libaes
>CPU: 1 PID: 1282 Comm: rtcwake Not tainted 
>6.10.0-rc3-00732-gc8bd1f7f3e61 #15240
>Hardware name: Generic DT based system
>PC is at dql_completed+0x270/0x2cc
>LR is at __free_old_xmit+0x120/0x198
>pc : [<c07ffa54>]    lr : [<c0c42bf4>]    psr: 80000013
>...
>Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>Control: 10c5387d  Table: 43a4406a  DAC: 00000051
>...
>Process rtcwake (pid: 1282, stack limit = 0xfbc21278)
>Stack: (0xe0805e80 to 0xe0806000)
>...
>Call trace:
>  dql_completed from __free_old_xmit+0x120/0x198
>  __free_old_xmit from free_old_xmit+0x44/0xe4
>  free_old_xmit from virtnet_poll_tx+0x88/0x1b4
>  virtnet_poll_tx from __napi_poll+0x2c/0x1d4
>  __napi_poll from net_rx_action+0x140/0x2b4
>  net_rx_action from handle_softirqs+0x11c/0x350
>  handle_softirqs from call_with_stack+0x18/0x20
>  call_with_stack from do_softirq+0x48/0x50
>  do_softirq from __local_bh_enable_ip+0xa0/0xa4
>  __local_bh_enable_ip from virtnet_open+0xd4/0x21c
>  virtnet_open from virtnet_restore+0x94/0x120
>  virtnet_restore from virtio_device_restore+0x110/0x1f4
>  virtio_device_restore from dpm_run_callback+0x3c/0x100
>  dpm_run_callback from device_resume+0x12c/0x2a8
>  device_resume from dpm_resume+0x12c/0x1e0
>  dpm_resume from dpm_resume_end+0xc/0x18
>  dpm_resume_end from suspend_devices_and_enter+0x1f0/0x72c
>  suspend_devices_and_enter from pm_suspend+0x270/0x2a0
>  pm_suspend from state_store+0x68/0xc8
>  state_store from kernfs_fop_write_iter+0x10c/0x1cc
>  kernfs_fop_write_iter from vfs_write+0x2b0/0x3dc
>  vfs_write from ksys_write+0x5c/0xd4
>  ksys_write from ret_fast_syscall+0x0/0x54
>Exception stack(0xe8bf1fa8 to 0xe8bf1ff0)
>...
>---[ end trace 0000000000000000 ]---
>Kernel panic - not syncing: Fatal exception in interrupt
>---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>
>I have fully reproducible setup for this issue. Reverting it together 
>with f8321fa75102 ("virtio_net: Fix napi_skb_cache_put warning") (due to 
>some code dependencies) fixes this issue on top of Linux v6.11-rc1 and 
>recent linux-next releases. Let me know if I can help debugging this 
>issue further and help fixing.

Will fix this tomorrow. In the meantime, could you provide full
reproduce steps?

Thanks!

>
> > ...
>
>Best regards
>-- 
>Marek Szyprowski, PhD
>Samsung R&D Institute Poland
>
