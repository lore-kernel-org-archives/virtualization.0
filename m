Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CCC191473
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682393; cv=none; b=eEEov9i5SdYPWNlTr8/n23Wzu7tq/oOx2x2LdHWCoYe6Asjd7rGOa6rdFDQMaqXDN78RPvHKhleU4E73ixDJRh+NLpI3aMpjcm00xqVQN3VC4WJNp18xbftlJSVVh5waS88h9ZHpKUULVQLOYF8Esn7VQnDoCSSsfn/UuHxnnyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682393; c=relaxed/simple;
	bh=j2YzyquIcqOBkL5820gFp/L4JHF1EzvqRlwP2pitwjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mq5iWeJc9sN/spHmgjZbr3GPfzGeXpVfNZawyTnjzx0WhyHPPmHGgZ0HEhQrkJa8FCC2WZmuq78PbmezyVBVMGnnsT5DR3ur9tzxhzwcngefZxg3ctuR+fu1zzZgPtMSTrddMloP3+hm7das0CVZcJfq0cXSbUc9rNv0dmduDeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=AFpoqYfM; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="AFpoqYfM"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DE0780F2A
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 14:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u0RbxeeYFFcH for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Aug 2024 14:26:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b2c; helo=mail-yb1-xb2c.google.com; envelope-from=cbilbao@digitalocean.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9380E80F00
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9380E80F00
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=digitalocean.com header.i=@digitalocean.com header.a=rsa-sha256 header.s=google header.b=AFpoqYfM
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9380E80F00
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 14:26:29 +0000 (UTC)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-e16582cb9f9so3244316276.0
        for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 07:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724682388; x=1725287188; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zpWiMMhNfGvh8VuUq4vLeaPQYJOMaJrubxkW6+puf9U=;
        b=AFpoqYfMW70FAfvpBHg6fI8XpKvighWBYDrQjm2kR00InhHfLHdPrBTnmvntU3UkD9
         GYSiuKBSIEAjJ4egieCTIy8anyBbpW2a+uZrLCS3/nGomK0Sazj2GvpeebJq3wEa6Du/
         av7Xi3Yh+pBa1fNQEDVkOtNzhcibrr9p7htes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682388; x=1725287188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpWiMMhNfGvh8VuUq4vLeaPQYJOMaJrubxkW6+puf9U=;
        b=OFfM5cjOMXvOEXSTjjRlxuJD1WJ4Dm+uOpEnI0s0FydN9jK42zncqxrrF2hmzn0lQ0
         vTShxj8LE8zbFDNEKIICd0BVfAgel8BzC+Qw7ZJZambPNQ2585jINhKGRtJAtcZ4ArP0
         pM/1mJQ6cpSYAZmFQa6o789vuxwCCHLFOsKqq+6gxSTC+VWRlkdnrbA8Is2suEjuYVF7
         uQfWKxuEGTeBvOoaOLZXIJMV1dH5Xhd0CWcJMZOUQDboxlVciWZac7IYXilHnhVLM7ed
         g0Ft4Fe+RANH3kcpJ//sJ2Cr0f6pNfQOVdWRg5eI90jJz+wFiwZkr97ls8lpXwdu0fph
         sWEw==
X-Gm-Message-State: AOJu0YwhrZKTISr3bJJEaV6coFb8sUVQ+8vPEqfIucVQ5nUD/+2z/C8V
	5mdW+fA3YZwVzTUUt/MrS1OJcG+JrRmaxyy79G6QBCb9Rbz0WsIZ7iVjzxGvv9E=
X-Google-Smtp-Source: AGHT+IGw6RFLC5cQuNUBq9p3JVA7HOeaQFT0Z1elg/9n8uPf+vXVvoyeGNVXBlPDsVt37nm9QXKdvw==
X-Received: by 2002:a25:ab62:0:b0:e13:c81b:184d with SMTP id 3f1490d57ef6-e1776537d2bmr12632704276.15.1724682387917;
        Mon, 26 Aug 2024 07:26:27 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:45f:f211:3a7c:9377? ([2603:8080:7400:36da:45f:f211:3a7c:9377])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4b3cafsm2002157276.28.2024.08.26.07.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 07:26:27 -0700 (PDT)
Message-ID: <8a15a46a-2744-4474-8add-7f6fb35552b3@digitalocean.com>
Date: Mon, 26 Aug 2024 09:26:25 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Why is set_config not supported in mlx5_vnet?
To: Dragos Tatulea <dtatulea@nvidia.com>, eli@mellanox.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com,
 sashal@kernel.org, yuehaibing@huawei.com, steven.sistare@oracle.com
References: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
 <afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Dragos,

On 8/26/24 4:06 AM, Dragos Tatulea wrote:
>
> On 23.08.24 18:54, Carlos Bilbao wrote:
>> Hello,
>>
>> I'm debugging my vDPA setup, and when using ioctl to retrieve the
>> configuration, I noticed that it's running in half duplex mode:
>>
>> Configuration data (24 bytes):
>>   MAC address: (Mac address)
>>   Status: 0x0001
>>   Max virtqueue pairs: 8
>>   MTU: 1500
>>   Speed: 0 Mb
>>   Duplex: Half Duplex
>>   RSS max key size: 0
>>   RSS max indirection table length: 0
>>   Supported hash types: 0x00000000
>>
>> I believe this might be contributing to the underperformance of vDPA.
> mlx5_vdpa vDPA devicess currently do not support the VIRTIO_NET_F_SPEED_DUPLEX
> feature which reports speed and duplex. You can check the state on the
> PF.


According to ethtool, all my devices are running at full duplex. I assume I
can disregard this configuration output from the module then.


>
>> While looking into how to change this option for Mellanox, I read the following
>> kernel code in mlx5_vnet.c:
>>
>> static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
>>                  unsigned int len)
>> {
>>     /* not supported */
>> }
>>
>> I was wondering why this is the case.
> TBH, I don't know why it was not added. But in general, the control VQ is the
> better way as it's dynamic.
>
>> Is there another way for me to change
>> these configuration settings?
>>
> The configuration is done using control VQ for most things (MTU, MAC, VQs,
> etc). Make sure that you have the CTRL_VQ feature set (should be on by
> default). It should appear in `vdpa mgmtdev show` and `vdpa dev config
> show`.


I see that CTRL_VQ is indeed enabled. Is there any documentation on how to
use the control VQ to get/set vDPA configuration values?


>
> Thanks,
> Dragos


Thank you!
Carlos

