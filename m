Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530984EB30
	for <virtualization@lists.linux.dev>; Fri, 19 Jan 2024 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674051; cv=none; b=saNpVEdwgyVk90/ZvmGSm4NV0YiR6SDDXXWhJh4PAjZA1SqPBqVdvtU67K4rr+m62Q0QTgCOLZ82AbtYfipy7wyIcg1Pt6BX5U9f3M+gGYwKNF82piVsyFSni9DboIqPkbrauCwdC54nHGZY8g6jzZ7EJ42KegiXKC0fVRnnTp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674051; c=relaxed/simple;
	bh=FGwojiboHadsnYPaKwypjdnTtk0s5JjsWXbb+JDY4So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjHN6J+55VyiMgc0yVLqF0vHZBciS7IH1ToafSCV4LAnC/zAmwhIeIp28MGhYsHRWnitjR8ojfjOo4u+lgJiUHTJH2U1r4zRFh+4/AKRgYUGLSs7mwyNwgzqUkClKGelu13wD92C3imBWfvOH3rjIG6Gh0rueR4Irskwt/aA8K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=47.90.199.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W-wDAK9_1705674028;
Received: from 172.20.10.2(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W-wDAK9_1705674028)
          by smtp.aliyun-inc.com;
          Fri, 19 Jan 2024 22:20:30 +0800
Message-ID: <02c20702-0f35-4a6c-ae7a-da5163378019@linux.alibaba.com>
Date: Fri, 19 Jan 2024 22:20:27 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] virtio-net: a fix and some updates for
 virtio dim
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
 <20240119072743-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240119072743-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/1/19 下午8:28, Michael S. Tsirkin 写道:
> On Tue, Jan 16, 2024 at 09:11:30PM +0800, Heng Qi wrote:
>> Patch 1 fixes an existing bug. Belongs to the net branch.
>> Patch 2 requires updating the virtio spec.
>> Patch 3 only attempts to modify the sending of dim cmd to an asynchronous way,
>> and does not affect the synchronization way of ethtool cmd.
>
> Given this doesn't build, please document how was each patch tested.
> Thanks!

There are some other local modifications. When using 'git add -ip' to 
temporarily store the patch content,
content that does not belong to this patch (struct virtnet_coal_entry) 
was mistakenly added to the patch [3/3],
and it was compiled and passed locally. Sorry for this, I will 
re-release it in the next version.

Thanks,
Heng

>> Heng Qi (3):
>>    virtio-net: fix possible dim status unrecoverable
>>    virtio-net: batch dim request
>>    virtio-net: reduce the CPU consumption of dim worker
>>
>>   drivers/net/virtio_net.c        | 197 ++++++++++++++++++++++++++++++++++++----
>>   include/uapi/linux/virtio_net.h |   1 +
>>   2 files changed, 182 insertions(+), 16 deletions(-)
>>
>> -- 
>> 1.8.3.1

