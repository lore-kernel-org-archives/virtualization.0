Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0527C1428E9
	for <virtualization@lists.linux.dev>; Fri, 26 Apr 2024 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126127; cv=none; b=EL0gCfONpqTIs/yknJhWbrX9MHoNXcAF00c1Ocket4DpnrZZEMHK6/OvNjP2BDFW+yksDBnczXeZdQXy/LbsDB+rFzzmyBL9dmISRH7bzOQM9zO4+dlonLg0hQdCZp78THC+DJ2EbXSmikoRUpbZkLi1CackHd2zLAdFM0Y7Msg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126127; c=relaxed/simple;
	bh=O6D5EqI+n+Wz5PrcLSUEc+Mwo0K5hqkNGOal1Nr4/og=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ky5FROIc76Z/bFVFXC70/lB2cg7VPnT2JtCJXFpjyLopD5qr4KCPWVnhXl91pyxZmvss9x8A6allOqzXrwys2acuvEVKK7Mu3QZGXQTEL9i8+XppYIcjB9gVEFXTYLWPTGVFvLEqrZ6EBYh8CC0am0/LS2ewQ1C1XC3hoLyeGG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DQ5dV1fF; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DQ5dV1fF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714126117; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=OMWxDvuwFhzkGQKKD5RYIxwbrnWRZZ3pYLh8+JuN2U8=;
	b=DQ5dV1fF/2VSz7fAeHdv34ZOjAvI8Z74nvgvVrzLdrdJFABdjHcH/a1J7vK3BcEloy6YbTKTBL9M296An4J55a/ifBOIGbjQxMvDxzMoscAG2i27knuXdQMz7SG1D1BzSJMcJeR2nt2Si3CYET8CqBvozIxIiyC5sVhefp9uanA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5IoZhD_1714126115;
Received: from 30.221.145.218(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5IoZhD_1714126115)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 18:08:36 +0800
Message-ID: <dc01448f-d2e6-456f-a1af-e149c296cd15@linux.alibaba.com>
Date: Fri, 26 Apr 2024 18:08:35 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 0/6] Remove RTNL lock protection of CVQ
To: Daniel Jurgens <danielj@nvidia.com>, Paolo Abeni <pabeni@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, jiri@nvidia.com,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>
References: <20240423035746.699466-1-danielj@nvidia.com>
In-Reply-To: <20240423035746.699466-1-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/4/23 上午11:57, Daniel Jurgens 写道:
> Currently the buffer used for control VQ commands is protected by the
> RTNL lock. Previously this wasn't a major concern because the control VQ
> was only used during device setup and user interaction. With the recent
> addition of dynamic interrupt moderation the control VQ may be used
> frequently during normal operation.
>
> This series removes the RNTL lock dependency by introducing a mutex
> to protect the control buffer and writing SGs to the control VQ.

I have done functional and performance tests on this set

with dim enabled, and it works well.

Please taking Paolo's tips into consideration.

For the series:

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
Tested-by: Heng Qi <hengqi@linux.alibaba.com>

Thanks!
> v5:
> 	- Changed cvq_lock to a mutex.
> 	- Changed dim_lock to mutex, because it's held taking
> 	  the cvq_lock.
> 	- Use spin/mutex_lock/unlock vs guard macros.
> v4:
> 	- Protect dim_enabled with same lock as well intr_coal.
> 	- Rename intr_coal_lock to dim_lock.
> 	- Remove some scoped_guard where the error path doesn't
> 	  have to be in the lock.
> v3:
> 	- Changed type of _offloads to __virtio16 to fix static
> 	  analysis warning.
> 	- Moved a misplaced hunk to the correct patch.
> v2:
> 	- New patch to only process the provided queue in
> 	  virtnet_dim_work
> 	- New patch to lock per queue rx coalescing structure.
>
> Daniel Jurgens (6):
>    virtio_net: Store RSS setting in virtnet_info
>    virtio_net: Remove command data from control_buf
>    virtio_net: Add a lock for the command VQ.
>    virtio_net: Do DIM update for specified queue only
>    virtio_net: Add a lock for per queue RX coalesce
>    virtio_net: Remove rtnl lock protection of command buffers
>
>   drivers/net/virtio_net.c | 276 +++++++++++++++++++++++----------------
>   1 file changed, 163 insertions(+), 113 deletions(-)
>
