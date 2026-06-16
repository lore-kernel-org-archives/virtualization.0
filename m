Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5937EFED
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781580622; cv=none; b=GvshoVeZreNOroiG5mlUaN19zuQG+DAqFTdZGjl+X/1JE34j1TVmejWcgY7na6KLG6R4IY2PVxY5o/2n43IK1I56sSX/X8Nyw8N4FqonfsWEQz1BGf0nQuzw+Is5ROim4+EovMoLceN4HY8OCBKm0xWNI+J7riV3NhtxYnDXGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781580622; c=relaxed/simple;
	bh=XhQ/iwpD6xB5XqW7n4vAQPkFQiKFHtuMn+FU7J2ZLYs=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=InDX5adMuQUyTpJl/EnRzrf5e0FSsf6ZW50IevrcTl/8ElR4HaRlpP7JW+OEHn9WhEt3P9WPKNzPSJannuINXdBTXOQnX9xuHSW3vt1CeUQ6CNQHJO9v8P5Js29slBZ3WTgoN6apIQewbZ9ETpWOrKAfUXIdgwHecqWsU665NmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F8xue/H4; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F8xue/H4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781580609; h=Message-ID:Subject:Date:From:To;
	bh=2zEAyFJClhrGrGeDqyRtRWEfhvy13Dfh4gTkmvqveRU=;
	b=F8xue/H4ojD7EmrTnyFsosFTsmRUOHEhhUMgdABYDunJvVY9/6zxvN/Nk4Cj4M36sR1uwbp6WI/ezEHJnHtIZPs/gqBvNN3UoEz4lSwXT16xpWhpeJji5v2O3piF6pFahFeXFMIo0vkxBA4VZpFrAl90oYvxU+8+1SKKNipM2gY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X4zos.H_1781580608;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X4zos.H_1781580608 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Jun 2026 11:30:08 +0800
Message-ID: <1781580432.712892-1-xuanzhuo@linux.alibaba.com>
Subject: Re:Re: [PATCH] virtio_net: disable cb when napi_schedule_prep fails during busy-poll
Date: Tue, 16 Jun 2026 11:27:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Lange Tang <lange_tang@163.com>
Cc: "edumazet@google.com" <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 Tang Longjun <tanglongjun@kylinos.cn>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
References: <20260615094550.106391-1-lange_tang@163.com>
 <1781517700.4206195-1-xuanzhuo@linux.alibaba.com>
 <19692a81.3001.19ece5f8ddc.Coremail.lange_tang@163.com>
In-Reply-To: <19692a81.3001.19ece5f8ddc.Coremail.lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 16 Jun 2026 11:00:29 +0800 (CST), Lange Tang <lange_tang@163.com> wrote:
> At 2026-06-15 18:01:40, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com> wrote:
> >On Mon, 15 Jun 2026 17:45:50 +0800, Longjun Tang <lange_tang@163.com> wrote:
> >> From: Longjun Tang <tanglongjun@kylinos.cn>
> >>
> >> When busy-poll is active, napi_schedule_prep() returns false in
> >> skb_recv_done(), so virtqueue_disable_cb() is skipped. The device
> >> may keep firing irqs until the next poll round reaches
> >> virtqueue_napi_complete(). If cb is enabled under busy-poll case,
> >> it will lead to a large number of spurious interrupts. Explicitly
> >> disable callbacks in this case to prevent spurious interrupts.
> >>
> >> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> >> ---
> >>  drivers/net/virtio_net.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index f4adcfee7a80..6d675fddc59b 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -728,6 +728,8 @@ static void virtqueue_napi_schedule(struct napi_struct *napi,
> >>  	if (napi_schedule_prep(napi)) {
> >>  		virtqueue_disable_cb(vq);
> >>  		__napi_schedule(napi);
> >> +	} else if (test_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state)) {
> >> +		virtqueue_disable_cb(vq);
> >
> >I see, but we should avoid checking NAPI_STATE_IN_BUSY_POLL directly in the
> >drivers. The NIC driver should remain agnostic to busy polling. I think we need
> >a better way, maybe we should rewrite virtqueue_napi_schedule instead.
>
> How about rewrite it like this?
> static void virtqueue_napi_schedule(struct napi_struct *napi,
>                                     struct virtqueue *vq)
> {
>         virtqueue_disable_cb(vq);
>         if (napi_schedule_prep(napi))
>                 __napi_schedule(napi);
> }
> Any comments are welcome.


Another CPU could be running NAPI and has just enabled the callbacks (cb).
Meanwhile, this side unconditionally disables the cb. Since NAPI on the other
CPU hasn't exited yet, the subsequent prep on this side fails, leaving no one to
re-enable the cb.

Thanks.


> >
> >Thanks.
> >
> >>  	}
> >>  }
> >>
> >> --
> >> 2.25.1
> >>
>
