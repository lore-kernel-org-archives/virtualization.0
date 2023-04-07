Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AA9C77B61
	for <virtualization@archiver.kernel.org>; Fri,  7 Apr 2023 12:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29BA860F32;
	Fri,  7 Apr 2023 12:34:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29BA860F32
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fjY4nw/E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ELv1rBwXqEmy; Fri,  7 Apr 2023 12:34:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6735C60F1D;
	Fri,  7 Apr 2023 12:34:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6735C60F1D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C1F3C0037;
	Fri,  7 Apr 2023 12:34:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EB01C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 12:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63AE041EE3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 12:34:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63AE041EE3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=fjY4nw/E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZIuoPI3JrWw7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 12:34:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29E79417A8
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29E79417A8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 12:34:23 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id bj20so31056842oib.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Apr 2023 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680870863; x=1683462863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=Ta5S4hKcE7ocLLx9UonnsfW725J+8bj4vIPtGwCJhj0=;
 b=fjY4nw/EUwmBoNX4AAm3dS+StowUoAUdRTvpgbuB1uVZ1fFey8Ab3Mu6gjHiIK45SS
 sMjj8b62gUlxfa1ymXb2M1p4D/WD68sybB6xH6MhzFxa5xxCqHJ5luqQuLqX1fcMqLwk
 S3rsK6sqLBu66ckbXck5IVaiI5TwK2bcb6Rl1YMHV+zTN/zgyVmT9tdTVx34PXM10XnN
 YQxHxnPNXjE7oZwhVLgtThjvGM66vkFxhwFWjfAcQ66lXLhX8/wUdoA+18wevcHvB2pG
 LFq9Pf3uFc9bONplkVjTu7XaHdyBO6kxCAcGq5m0BAH/sU+Xgr27LDhgn5AszO+9FHft
 j4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680870863; x=1683462863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ta5S4hKcE7ocLLx9UonnsfW725J+8bj4vIPtGwCJhj0=;
 b=NYOoz5O8tHEosnzMf8EgeDQP0E3EzqXf+ImHorLVnMFzO2adFn/3X5AHiL8GMQBYHD
 nZf1DQ2Bs/hO6kBbibrqPqdRtX6yt5yP6oBZkVd8OJcLH2rxVG+1cX8sRK4Pg9I5H6sT
 csX27Tup0GX4u+ldyM1s5UvonCb3Y1/71yNxRZAtDhK5xRb9nvjvadANFatop0446Ak9
 OmvTpPTFTFmOheTwjEC/TO2hnfpJfV4lNKN7lwip+vJJLMtsDf0RSFkoXiIdgWOUY9dA
 RpMTJhEF1Ln0XbAEgfBwr5ijsz2RfiZZYM2mpIfdVdsnXqoIpgdh0dpyZakXwxwzqcbk
 u73w==
X-Gm-Message-State: AAQBX9fH619mIeFpGyzFRI1ANGaAvqVOBXt3npRgL5syZNMLmcH6ti4h
 dspddds4prZ3UlftNedcvL8=
X-Google-Smtp-Source: AKy350aPtYF0B6Cw8LadLchXwjAq+4mUjdGhZ8xJKPJ4VckCiMeOar2QDcnxuGgFB/wnKVzajS6WGw==
X-Received: by 2002:a05:6808:1450:b0:389:340e:be3f with SMTP id
 x16-20020a056808145000b00389340ebe3fmr1237773oiv.2.1680870862986; 
 Fri, 07 Apr 2023 05:34:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 n128-20020acabd86000000b0038982a7e06esm1694774oif.1.2023.04.07.05.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Apr 2023 05:34:22 -0700 (PDT)
Message-ID: <1fbbda8b-f12a-77fd-411d-d7999b90cdb9@roeck-us.net>
Date: Fri, 7 Apr 2023 05:34:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Content-Language: en-US
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-9-xuanzhuo@linux.alibaba.com>
 <73a24f95-b779-44ac-be28-45b35d1bf540@roeck-us.net>
 <1680837458.7467153-1-xuanzhuo@linux.alibaba.com>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1680837458.7467153-1-xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 4/6/23 20:17, Xuan Zhuo wrote:
> On Thu, 6 Apr 2023 10:20:09 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
>> Hi,
>>
>> On Mon, Mar 27, 2023 at 12:05:33PM +0800, Xuan Zhuo wrote:
>>> Added virtqueue_dma_dev() to get DMA device for virtio. Then the
>>> caller can do dma operation in advance. The purpose is to keep memory
>>> mapped across multiple add/get buf operations.
>>>
>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>
>> On sparc64, this patch results in
>>
>> [    4.364643] Unable to handle kernel NULL pointer dereference
>> [    4.365157] tsk->{mm,active_mm}->context = 0000000000000000
>> [    4.365394] tsk->{mm,active_mm}->pgd = fffff80000402000
>> [    4.365611]               \|/ ____ \|/
>> [    4.365611]               "@'/ .. \`@"
>> [    4.365611]               /_| \__/ |_\
>> [    4.365611]                  \__U_/
>> [    4.366165] swapper/0(1): Oops [#1]
>> [    4.366630] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N 6.3.0-rc5-next-20230405 #1
>> [    4.367121] TSTATE: 0000004411001606 TPC: 00000000004375c0 TNPC: 00000000004375c4 Y: 00000002    Tainted: G                 N
>> [    4.367548] TPC: <dma_4u_supported+0x20/0x40>
>> [    4.368111] g0: 0000000000000000 g1: 0000000001a93a50 g2: 0000000000000000 g3: 0000000001a96170
>> [    4.368439] g4: fffff8000416e9a0 g5: fffff8001dc98000 g6: fffff80004170000 g7: 0000000000000005
>> [    4.368769] o0: 0000000000000000 o1: ffffffffffffffff o2: 0000000000000001 o3: fffff800040b78d8
>> [    4.369095] o4: 0000000000000000 o5: 0000000000000000 sp: fffff80004172d51 ret_pc: 00000000004375ac
>> [    4.369934] RPC: <dma_4u_supported+0xc/0x40>
>> [    4.370160] l0: 0000000000000002 l1: 0000000000000002 l2: 0000000000000000 l3: 00000000ffffffff
>> [    4.370493] l4: 0000000000000001 l5: 000000000119d2b0 l6: fffff8000416e9a0 l7: 00000000018df000
>> [    4.370820] i0: 0000000000000001 i1: ffffffffffffffff i2: fffff80004657758 i3: 000000000125ac00
>> [    4.371145] i4: 0000000002362400 i5: 0000000000000000 i6: fffff80004172e01 i7: 000000000050e288
>> [    4.371473] I7: <dma_set_mask+0x28/0x80>
>> [    4.371683] Call Trace:
>> [    4.371864] [<000000000050e288>] dma_set_mask+0x28/0x80
>> [    4.372123] [<0000000000a83234>] virtio_dev_probe+0x14/0x400
>> [    4.372348] [<0000000000ac7a18>] really_probe+0xb8/0x340
>> [    4.372555] [<0000000000ac7d64>] driver_probe_device+0x24/0x120
>> [    4.372794] [<0000000000ac8010>] __driver_attach+0x90/0x1a0
>> [    4.373012] [<0000000000ac5b4c>] bus_for_each_dev+0x4c/0xa0
>> [    4.373226] [<0000000000ac6d80>] bus_add_driver+0x140/0x1e0
>> [    4.373440] [<0000000000ac8d94>] driver_register+0x74/0x120
>> [    4.373653] [<0000000001b2a690>] virtio_net_driver_init+0x74/0xa8
>> [    4.373886] [<0000000000427ee0>] do_one_initcall+0x60/0x340
>> [    4.374099] [<0000000001b02f50>] kernel_init_freeable+0x1bc/0x228
>> [    4.374330] [<0000000000f37264>] kernel_init+0x18/0x134
>> [    4.374534] [<00000000004060e8>] ret_from_fork+0x1c/0x2c
>> [    4.374738] [<0000000000000000>] 0x0
>> [    4.374981] Disabling lock debugging due to kernel taint
>> [    4.375237] Caller[000000000050e288]: dma_set_mask+0x28/0x80
>> [    4.375477] Caller[0000000000a83234]: virtio_dev_probe+0x14/0x400
>> [    4.375704] Caller[0000000000ac7a18]: really_probe+0xb8/0x340
>> [    4.375916] Caller[0000000000ac7d64]: driver_probe_device+0x24/0x120
>> [    4.376146] Caller[0000000000ac8010]: __driver_attach+0x90/0x1a0
>> [    4.376365] Caller[0000000000ac5b4c]: bus_for_each_dev+0x4c/0xa0
>> [    4.376583] Caller[0000000000ac6d80]: bus_add_driver+0x140/0x1e0
>> [    4.376805] Caller[0000000000ac8d94]: driver_register+0x74/0x120
>> [    4.377025] Caller[0000000001b2a690]: virtio_net_driver_init+0x74/0xa8
>> [    4.377262] Caller[0000000000427ee0]: do_one_initcall+0x60/0x340
>> [    4.377480] Caller[0000000001b02f50]: kernel_init_freeable+0x1bc/0x228
>> [    4.377721] Caller[0000000000f37264]: kernel_init+0x18/0x134
>> [    4.377930] Caller[00000000004060e8]: ret_from_fork+0x1c/0x2c
>> [    4.378140] Caller[0000000000000000]: 0x0
>> [    4.378309] Instruction DUMP:
>> [    4.378339]  80a22000
>> [    4.378556]  12400006
>> [    4.378654]  b0102001
>> [    4.378746] <c2076658>
>> [    4.378838]  b0102000
>> [    4.378930]  80a04019
>> [    4.379022]  b1653001
>> [    4.379115]  81cfe008
>> [    4.379507]  913a2000
>> [    4.379617]
>> [    4.380504] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
>>
>> Reverting it fixes the problem. Bisect log attached.
>>
>> The reason is that dma_supported() calls dma_4u_supported(), which
>> expects that dev->archdata.iommu has been initialized. However,
>> this is not the case for the virtio device. Result is a null pointer
>> dereference in dma_4u_supported().
>>
>> static int dma_4u_supported(struct device *dev, u64 device_mask)
>> {
>>          struct iommu *iommu = dev->archdata.iommu;
>>
>>          if (ali_sound_dma_hack(dev, device_mask))
>>                  return 1;
>>
>>          if (device_mask < iommu->dma_addr_mask)
>> 	                  ^^^^^^^^^^^^^^^^^^^^ Crash location
>>                  return 0;
>>          return 1;
>> }
> 
> sparc64 does not support direct dma?
> 
> The virtio is a virtul device based on pci.
> 
> Do you know how we should adapt to sparc64?
> 

It isn't exactly common or typical to set dev->dma_mask in driver probe
functions, as your code does, and much less so to do it unconditionally.
I don't know why the virtio driver is different to warrant setting it
there, so I can not answer your question.

Guenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
