Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73930FC33
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593222; cv=none; b=nz/t7bQMaizRn4GQZ8askXXjna4aadIFK8IIyV2C1Rphk5Ec/Lno3rCqxTB4p1lIfHrw9X68Kqqdek+zZx7SSG9yt37UhS66YUxHD/Ce3yld3TCzDWRQzuBgWob4l4CmYsDs+0sBhTxc092qQFeEdjjVCGHv5HYRXTC+RKjVeqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593222; c=relaxed/simple;
	bh=YMXnj9b968hz/tdpsB8BHrM2AXmUFazsJROkqzRawiI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=oiQN6Ay15Mvl/07BJ9XLDXD4WiH2CWkdRWrdZngyinaQyu53uKLpK0gLOYWooYtdDpXfzoy//2D10/uEQcfYANtzpvqiHts/xqiPAHTDC+4R3aIE0dK+ofEhlzXTzRQd9iHIMIqZXcbWaZQcdbv7SIr9TDez6XAbm5AKEStoMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=i944KEPj; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="i944KEPj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781593200; h=Message-ID:Subject:Date:From:To;
	bh=aQcd/shNjfkRC5tt8ejk0Oq/ahEgqk7BqFCbuAw2J+w=;
	b=i944KEPjNu0ZMCWil2Bvn5Dp/PVflsVkl4Ke1igVR6bnCPwd8Dq9MqYWmBRmqmEXf+NDZZ8g+S/HlMvPI/t9LPYxJH9OOh/MNQyr3zitIqVtWBTJqWjYb5+CLu0FNAZg6Rd/0VVsWkqA7ys6Sk9VVdT+cc9RIH0cW7xpTL9PAbo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X5-P-pK_1781593199;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X5-P-pK_1781593199 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Jun 2026 14:59:59 +0800
Message-ID: <1781592565.1172295-1-xuanzhuo@linux.alibaba.com>
Subject: Re:Re:Re: [PATCH] virtio_net: disable cb when napi_schedule_prep fails during busy-poll
Date: Tue, 16 Jun 2026 14:49:25 +0800
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
 <1781580432.712892-1-xuanzhuo@linux.alibaba.com>
 <4118686.4d22.19ecf0ad78e.Coremail.lange_tang@163.com>
In-Reply-To: <4118686.4d22.19ecf0ad78e.Coremail.lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 16 Jun 2026 14:07:34 +0800 (CST), Lange Tang <lange_tang@163.com> wrote:
> At 2026-06-16 11:27:12, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com> wrote:
> >On Tue, 16 Jun 2026 11:00:29 +0800 (CST), Lange Tang <lange_tang@163.com> wrote:
> >> At 2026-06-15 18:01:40, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com> wrote:
> >> >On Mon, 15 Jun 2026 17:45:50 +0800, Longjun Tang <lange_tang@163.com> wrote:
> >> >> From: Longjun Tang <tanglongjun@kylinos.cn>
> >> >>
> >> >> When busy-poll is active, napi_schedule_prep() returns false in
> >> >> skb_recv_done(), so virtqueue_disable_cb() is skipped. The device
> >> >> may keep firing irqs until the next poll round reaches
> >> >> virtqueue_napi_complete(). If cb is enabled under busy-poll case,
> >> >> it will lead to a large number of spurious interrupts. Explicitly
> >> >> disable callbacks in this case to prevent spurious interrupts.
> >> >>
> >> >> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> >> >> ---
> >> >>  drivers/net/virtio_net.c | 2 ++
> >> >>  1 file changed, 2 insertions(+)
> >> >>
> >> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> >> index f4adcfee7a80..6d675fddc59b 100644
> >> >> --- a/drivers/net/virtio_net.c
> >> >> +++ b/drivers/net/virtio_net.c
> >> >> @@ -728,6 +728,8 @@ static void virtqueue_napi_schedule(struct napi_struct *napi,
> >> >>  	if (napi_schedule_prep(napi)) {
> >> >>  		virtqueue_disable_cb(vq);
> >> >>  		__napi_schedule(napi);
> >> >> +	} else if (test_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state)) {
> >> >> +		virtqueue_disable_cb(vq);
> >> >
> >> >I see, but we should avoid checking NAPI_STATE_IN_BUSY_POLL directly in the
> >> >drivers. The NIC driver should remain agnostic to busy polling. I think we need
> >> >a better way, maybe we should rewrite virtqueue_napi_schedule instead.
> >>
> >> How about rewrite it like this?
> >> static void virtqueue_napi_schedule(struct napi_struct *napi,
> >>                                     struct virtqueue *vq)
> >> {
> >>         virtqueue_disable_cb(vq);
> >>         if (napi_schedule_prep(napi))
> >>                 __napi_schedule(napi);
> >> }
> >> Any comments are welcome.
> >
> >
> >Another CPU could be running NAPI and has just enabled the callbacks (cb).
> >Meanwhile, this side unconditionally disables the cb. Since NAPI on the other
> >CPU hasn't exited yet, the subsequent prep on this side fails, leaving no one to
> >re-enable the cb.
> >
> >Thanks.
>
> Regarding the case you described, when NAPI on another CPU exits, the virtqueue_napi_complete func
> will be executed to re-enable cb.  and if there is still unconsumed data in the virtqueue, virtqueue_napi_schedule
> will be called again to schedule NAPI.
>
> In summary, I think that the disable_cb and __napi_schedule within the virtqueue_napi_schedule func do not need to be bound together.
>
> Any comments are welcome. Thinks.


<Your code>
static void virtqueue_napi_schedule(struct napi_struct *napi,
                                    struct virtqueue *vq)
{

							       |static bool virtqueue_napi_complete(struct napi_struct *napi,
							       |				    struct virtqueue *vq, int processed)
							       |{
							       |	int opaque;
							       |
							       |	opaque = virtqueue_enable_cb_prepare(vq);
                                                               |
        virtqueue_disable_cb(vq);                              |
        if (napi_schedule_prep(napi))                          |
                __napi_schedule(napi);                         |
							       |	if (napi_complete_done(napi, processed)) {
							       |		if (unlikely(virtqueue_poll(vq, opaque)))
							       |			virtqueue_napi_schedule(napi, vq);
							       |		else
							       |			 return true; // return directly
							       |	} else {
							       |		virtqueue_disable_cb(vq);
							       |	}
							       |
							       |	return false;
							       |}
}

1. new packets (notified by irq) are consumed by napi before virtqueue_napi_complete
2. poll is not called by irq, maybe xsk wake up. So irq is not disabled.


Thanks.


>
> >
> >
> >> >
> >> >
> >> >>  	}
> >> >>  }
> >> >>
> >> >> --
> >> >> 2.25.1
> >> >>
> >>
>
