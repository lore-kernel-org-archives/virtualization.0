Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8140E7849A
	for <virtualization@archiver.kernel.org>; Mon,  2 Oct 2023 11:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AC626132B;
	Mon,  2 Oct 2023 11:50:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AC626132B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SbEA3bt6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xxkXs46kPlJM; Mon,  2 Oct 2023 11:50:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E2966129B;
	Mon,  2 Oct 2023 11:50:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E2966129B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C873C0071;
	Mon,  2 Oct 2023 11:50:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D95CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 11:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E08716129B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 11:50:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E08716129B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n2W-D6-bXX6w
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 11:50:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0EFE6132A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 11:50:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0EFE6132A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696247452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBrZhcB5nUcd1tpUxuWzIbaWMcBLbzzhsFdEDldJgN4=;
 b=SbEA3bt6l7ejvR/v7vAK7j6i3gwRxluCmJF30WGCo/X61XS1J/zVMIXhNMqwMYqlI8FRPv
 oeomV2z6rnYpw0EXdn3lpGvjIlLdoqTcgGYqPX3rvHAY6RMk+n4q3Wpdvu5mLAlGEkKChJ
 qU12u0uhjmujCrazz4pR7CpfzRfXi3M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-RjplxvHLPciNY8ATbbsQ-A-1; Mon, 02 Oct 2023 07:50:48 -0400
X-MC-Unique: RjplxvHLPciNY8ATbbsQ-A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso12123945f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Oct 2023 04:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696247447; x=1696852247;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mBrZhcB5nUcd1tpUxuWzIbaWMcBLbzzhsFdEDldJgN4=;
 b=R5xYtsJtF67B2HL2qaVCFlsx/nAiHoBbR7bDKiFNku3hvJw4s9W4cXsOBl/dVi5ZVU
 UvDM6lQJinMKoZgFc/jkPvZqb01QIND2xXzYwFzRZJr6PwO3qp2VamdLhTCRZ78UaABc
 iuT/7HV63a4FuNiaQnfY0XotYjVpejZ9kz7eKLaO5OYsI41XR+ISrlpU/96ykPC3/UnA
 XEFSIkXOEnCh4i1v8aHamcbEUaCaCDE72RVPJo/otVfbBfDEtW7a0njWIG/x4IrXQqlL
 lR8fcPA2Ciff2uJDrm7rVA0C5XJ0zcQrlM/so1SQeg5EY8jNxXa3DsN2sYzP83xTwq+i
 IUlA==
X-Gm-Message-State: AOJu0Ywp+0q4Q312W9neIoG1u1EJlzHDujcFQeu09MEL5eaxnIR1RP+y
 OnfLROLEjQ9jNiQoHfXobiCQJmFm1SYhxSuI2FOm36pKUdFOUl2qLyEeafVV5FOc4Vpr6Q6Q+aQ
 wfK0Dx+LbZuLNfP9GM+UHG9vIClPtwmHwt874By0Ebw==
X-Received: by 2002:adf:e9c9:0:b0:319:79bb:980c with SMTP id
 l9-20020adfe9c9000000b0031979bb980cmr9786481wrn.64.1696247447630; 
 Mon, 02 Oct 2023 04:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLNQHhxBlGvd3QBrupxsNSkpIsO/mIp/g907haHFJ/D8eLi4qV+cMl4rqxJw7Q8mpvESCurw==
X-Received: by 2002:adf:e9c9:0:b0:319:79bb:980c with SMTP id
 l9-20020adfe9c9000000b0031979bb980cmr9786464wrn.64.1696247447165; 
 Mon, 02 Oct 2023 04:50:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446?
 (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de.
 [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
 by smtp.gmail.com with ESMTPSA id
 x13-20020adff64d000000b00325b29a6441sm7465254wrp.82.2023.10.02.04.50.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 04:50:46 -0700 (PDT)
Message-ID: <53ec0cfb-37c8-f8e3-4cd3-53a390b2cd2b@redhat.com>
Date: Mon, 2 Oct 2023 13:50:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] virtio_balloon: Fix endless deflation and inflation on
 arm64
To: Gavin Shan <gshan@redhat.com>, virtualization@lists.linux-foundation.org, 
 mst@redhat.com
References: <20230831011007.1032822-1-gshan@redhat.com>
 <9efb4685-7c28-d51d-fd5b-aa2de8e5ded2@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <9efb4685-7c28-d51d-fd5b-aa2de8e5ded2@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 shan.gavin@gmail.com, zhenyzha@redhat.com
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

On 25.09.23 01:58, Gavin Shan wrote:
> Hi David and Michael,
> 
> On 8/31/23 11:10, Gavin Shan wrote:
>> The deflation request to the target, which isn't unaligned to the
>> guest page size causes endless deflation and inflation actions. For
>> example, we receive the flooding QMP events for the changes on memory
>> balloon's size after a deflation request to the unaligned target is
>> sent for the ARM64 guest, where we have 64KB base page size.
>>
>>     /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>>     -accel kvm -machine virt,gic-version=host -cpu host          \
>>     -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1 \
>>     -m 1024M,slots=16,maxmem=64G                                 \
>>     -object memory-backend-ram,id=mem0,size=512M                 \
>>     -object memory-backend-ram,id=mem1,size=512M                 \
>>     -numa node,nodeid=0,memdev=mem0,cpus=0-3                     \
>>     -numa node,nodeid=1,memdev=mem1,cpus=4-7                     \
>>       :                                                          \
>>     -device virtio-balloon-pci,id=balloon0,bus=pcie.10
>>
>>     { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
>>     {"return": {}}
>>     {"timestamp": {"seconds": 1693272173, "microseconds": 88667},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272174, "microseconds": 89704},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272175, "microseconds": 90819},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272176, "microseconds": 91961},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272177, "microseconds": 93040},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>     {"timestamp": {"seconds": 1693272178, "microseconds": 94117},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>     {"timestamp": {"seconds": 1693272179, "microseconds": 95337},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272180, "microseconds": 96615},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>     {"timestamp": {"seconds": 1693272181, "microseconds": 97626},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272182, "microseconds": 98693},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>     {"timestamp": {"seconds": 1693272183, "microseconds": 99698},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272184, "microseconds": 100727},  \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272185, "microseconds": 90430},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272186, "microseconds": 102999},  \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>        :
>>     <The similar QMP events repeat>
>>
>> Fix it by aligning the target up to the guest page size, 64KB in this
>> specific case. With this applied, no flooding QMP events are observed
>> and the memory balloon's size can be stablizied to 0x3ffe0000 soon
>> after the deflation request is sent.
>>
>>     { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
>>     {"return": {}}
>>     {"timestamp": {"seconds": 1693273328, "microseconds": 793075},  \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     { "execute" : "query-balloon" }
>>     {"return": {"actual": 1073610752}}
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
>> ---
>> v2: Align @num_pages up to the guest page size in towards_target()
>>       directly as David suggested.
>> ---
>>    drivers/virtio/virtio_balloon.c | 6 +++++-
>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>
> 
> If the patch looks good, could you please merge this to Linux 6.6.rc4 since
> it's something needed by our downstream. I hope it can land upstream as early
> as possible, thanks a lot.

@MST, I cannot spot it in your usual vhost git yet. Should I pick it up 
or what are your plans?

-- 
Cheers,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
