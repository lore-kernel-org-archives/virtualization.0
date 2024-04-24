Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB16815B996
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968810; cv=none; b=W0O+LWf4cWNBNXE9gSWnOSVTTjPF5QZokzKCHvuiDoUBb36GFYrA0E01K7ak+U4j4SzFCzpdsP6hfaN+XBoQBOPcU7KihZoLAV2V2B9E0JOXXab+zzgIn5osucUQtAMihyvWeCSS4snNv7dDtPEhK8d56MvuW/+gEzQD0JlKWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968810; c=relaxed/simple;
	bh=6WncPP1f0Ia6dk7ZkOHTYIcFgae85cIvVUAMzALi/P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrB4VcSPBo0qCjEkAge6QNIH5o0NsZm8VtPwcX3mSB02BhgEl0nRfEE8u3HYJVpMhaaJjz8shyUI/JIEoaie+idsugmeQrmDnB4WG9e2yiO0SFWACbTyuYnsxHEKmJMAypj4Aeq5QF4GJTRA1bse+SDiE9H8cIsp4mOrpaFPLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TLN1elnz; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TLN1elnz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713968800; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=x9V9kFjm1xOhQWW6hghXKNWYOBQlGLUX4xl805MN+iU=;
	b=TLN1elnzUx8MgOQcwmYl7sdJPDHaHfrX6L5uFxH9Qyq+eon8bn3dnJg4+dCfmzorkb+buCaKWQxV63imM8qTlJIGT381wxdcmlhvul+MfzxT2GwI+JBTgA2iSjrXfkw2y5TwJ49F9fZhfe0cBdTPWhl5Vbto+JaGFr7o1z9p6h4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5CTXgW_1713968797;
Received: from 192.168.0.101(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5CTXgW_1713968797)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 22:26:38 +0800
Message-ID: <acf47cc1-3aaa-4ca4-b0f5-434ad6d6b0dd@linux.alibaba.com>
Date: Wed, 24 Apr 2024 22:26:36 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v7 0/4] ethtool: provide the dim profile
 fine-tuning channel
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240415133807.116394-1-hengqi@linux.alibaba.com>
 <20240422165456-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240422165456-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/4/23 上午4:55, Michael S. Tsirkin 写道:
> On Mon, Apr 15, 2024 at 09:38:03PM +0800, Heng Qi wrote:
>> The NetDIM library provides excellent acceleration for many modern
>> network cards. However, the default profiles of DIM limits its maximum
>> capabilities for different NICs, so providing a way which the NIC can
>> be custom configured is necessary.
>>
>> Currently, interaction with the driver is still based on the commonly
>> used "ethtool -C".
>>
>> Since the profile now exists in netdevice, adding a function similar
>> to net_dim_get_rx_moderation_dev() with netdevice as argument is
>> nice, but this would be better along with cleaning up the rest of
>> the drivers, which we can get to very soon after this set.
>>
>> Please review, thank you very much!
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Hi Michael,

Thanks for your ACK, the profile series has progressed to v9 and is still

being iterated. it would be better to collect your tag again in a newer 
version.

Thanks!

>
>> Changelog
>> =====
>> v6->v7:
>>    - A new wrapper struct pointer is used in struct net_device.
>>    - Add IS_ENABLED(CONFIG_DIMLIB) to avoid compiler warnings.
>>    - Profile fields changed from u16 to u32.
>>
>> v5->v6:
>>    - Place the profile in netdevice to bypass the driver.
>>      The interaction code of ethtool <-> kernel has not changed at all,
>>      only the interaction part of kernel <-> driver has changed.
>>
>> v4->v5:
>>    - Update some snippets from Kuba, Thanks.
>>
>> v3->v4:
>>    - Some tiny updates and patch 1 only add a new comment.
>>
>> v2->v3:
>>    - Break up the attributes to avoid the use of raw c structs.
>>    - Use per-device profile instead of global profile in the driver.
>>
>> v1->v2:
>>    - Use ethtool tool instead of net-sysfs
>>
>> Heng Qi (4):
>>    linux/dim: move useful macros to .h file
>>    ethtool: provide customized dim profile management
>>    virtio-net: refactor dim initialization/destruction
>>    virtio-net: support dim profile fine-tuning
>>
>> Heng Qi (4):
>>    linux/dim: move useful macros to .h file
>>    ethtool: provide customized dim profile management
>>    virtio-net: refactor dim initialization/destruction
>>    virtio-net: support dim profile fine-tuning
>>
>>   Documentation/netlink/specs/ethtool.yaml     |  33 +++
>>   Documentation/networking/ethtool-netlink.rst |   8 +
>>   drivers/net/virtio_net.c                     |  46 +++--
>>   include/linux/dim.h                          |  13 ++
>>   include/linux/ethtool.h                      |  11 +-
>>   include/linux/netdevice.h                    |  24 +++
>>   include/uapi/linux/ethtool_netlink.h         |  24 +++
>>   lib/dim/net_dim.c                            |  10 +-
>>   net/core/dev.c                               |  83 ++++++++
>>   net/ethtool/coalesce.c                       | 201 ++++++++++++++++++-
>>   10 files changed, 430 insertions(+), 23 deletions(-)
>>
>> -- 
>> 2.32.0.3.g01195cf9f
