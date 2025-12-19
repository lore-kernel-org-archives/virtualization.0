Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F362283C83
	for <virtualization@lists.linux.dev>; Fri, 19 Dec 2025 05:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766120620; cv=none; b=un2n2OT1TtjYzvHPFE1ekxE75vrfXxwJUyCVt4vt+YQ7G1507VNdBr+9+CSfmqN1GeuMOmW6gEh1ZsI8eEVInIoWT3RT3HLV2bivio3+JjgMcXBPfOyJj7p+a+Kzx+95kQqh7YhQWaIB+pOZcUoZ0d/FhX3tg4R7vEi68xzClmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766120620; c=relaxed/simple;
	bh=kaURwmhdJjY8j91/nuYsMJxS/M+9Ly7tIAquBQJLkUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFJE7Sl/7lYfgE+ZW0AFnFClO3IagGGKoNgQ/4vF1x6S0STUO5dDIwLfILtNEQUvpnYB5L3qohsrlzJZ+TdzIjSUlyLsp/honKHQK4DtTvgtz4PzitTKUfYjAuIwuADgrbsdJpR/g0GPuHaK9mXsM8Q+PyY/U4d+9tW+bM8BL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlPq+z8a; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlPq+z8a"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a12ebe4b74so21054005ad.0
        for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 21:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766120617; x=1766725417; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZTCvbTwNrP8p42X+dpd7k1dFq41aRyw/GMHSDy5acE=;
        b=UlPq+z8aMwaRGuuctBcm8dVoEqH+E5E2XMBDnPDNf/JmhorA/FGas8rXQBqVCnUat2
         RFvj89fQk/GrwEHvyRynMg/b5whnab400NIOMsVM9f/QyWGTFMnacK1Zmt2JJ0QV6hj7
         M0YyLlodwnk+zDMl8a2CLlmvHXeSONW5ZVDAkh3LgzZXTRdfOV9gTDRUIANVJ5Laiu99
         o0HbVJh0mUbP7ZNnptdLSBQ7YdqkVdKr0Rf2hpu47fAeGHnOuZgubWKP3RB0N0Nan76p
         2YcAW9MOROwj3P9mm8DYomu0poBX9jIPFWD3zCUxd8ZN2FLtWiodtS/EMsJe2R3d5Y1d
         mO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766120617; x=1766725417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZTCvbTwNrP8p42X+dpd7k1dFq41aRyw/GMHSDy5acE=;
        b=T/neSm9vbNDEjTyEag3eHLUsfU8bmoUiKxHRVe1//D9sReYLVHB3mTo+BrOmDzVuDM
         ivYEzJGdIKBo79e207H2x9KYOn4vbHGjtj+MMkhTLhPn2RgDeM1h6oziIrZi+zO9pCaP
         sgJmF/bghUyRfIKiDVdLMEAakuxYFKlxaP2fpJS+JYcd6I1Zr3Jt1I+2DKrVBGphulID
         3bshj0fe6Ir4Ni7TB/Ku/vY0h4lkQ4TsJAXx6fkjWDZUglPcGFaza4JMUVhs2JfoO8+9
         Gx6pNEutr/JnFWxim1PKWWdbucqXGeUlmXdUfMbmgCbVnwvQTAcm/lHXNc8Wv2mC4+wL
         cK2A==
X-Forwarded-Encrypted: i=1; AJvYcCX49YRQ5KwOplVP4qtKGuvlpUZqif6dl/5rOw+vj5nRKFA73IikJEtr5zjIypzPnC+usCzoPAiyYRPTjHS6BA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDeKkOtrUZfMGtJpVMudBByeL0XQgnsxUsDfWXpBe6jT4qsC/U
	VShH9yhE2moPxut+xxjlzMN9WD5o9/dZq3k5dlSy/UImrr7H9hJ2O5z6
X-Gm-Gg: AY/fxX7s1GTj+xev1orcjXmXML5wnEXxasD8FGN+c69xta9QVt9TnXngLIsuIEF2MoP
	VbMake6pfDzITTdKaHzdcnMLjItMOiUce75rRrwy9pZGZjUnWlsrwM9jlQHGR8Qbfl568z9kcMU
	a3JfJeA/XatoGMCYeWajJqAp1jic3VtOoMR0TyAfncRt8d0HqECA8gEm2YW4rCRLf/bo1WdDMg8
	fiQrXOyVVHzW1gzDMNh26KzVuRLz88bfyza3Zzz4nyownxlZwcE5cUvBwN0TxR3apm4xhDkJw11
	y6A+cOBowI2nDI3QnAsHJ1SCT24QEPDrhKJXwwhz9nB75CqEve7oNAUrkCbPi4INjsmPgDeox0B
	1+ZMvRHdGoUendWXIwMyZH7XVaNC3Vvtl+NOAnD/DBOVdGxU50gWj1Hy9DTf3PpMe+hcyuJmuUe
	i/Go2RLr37JY+EqqwfeOWm6gkB/ktGvuLBFtb//8gz+vd5aEP2SGY7jKkPh9A=
X-Google-Smtp-Source: AGHT+IEMNwtnT5HSACs7KJDQv87Ul7tb9qZwcx6898sXznsIUuzVEP7oMOI9Ae1p0oHl8YKCnExepA==
X-Received: by 2002:a17:902:e74c:b0:24b:270e:56c7 with SMTP id d9443c01a7336-2a2f22069e3mr16825885ad.7.1766120617119;
        Thu, 18 Dec 2025 21:03:37 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:2598:f3ef:512:c5a9? ([2001:ee0:4f4c:210:2598:f3ef:512:c5a9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d77451sm8994465ad.96.2025.12.18.21.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 21:03:36 -0800 (PST)
Message-ID: <5434a67e-dd6e-4cd1-870b-fdd32ad34a28@gmail.com>
Date: Fri, 19 Dec 2025 12:03:29 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio-net: enable all napis before scheduling
 refill work
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20251212152741.11656-1-minhquangbui99@gmail.com>
 <CACGkMEtzXmfDhiQiq=5qPGXG+rJcxGkWk0CZ4X_2cnr2UVH+eQ@mail.gmail.com>
 <3f5613e9-ccd0-4096-afc3-67ee94f6f660@gmail.com>
 <CACGkMEs+Mse7nhPPiqbd2doeGtPD2QD3BM_cztr6e=VfuiobHQ@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEs+Mse7nhPPiqbd2doeGtPD2QD3BM_cztr6e=VfuiobHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/17/25 09:58, Jason Wang wrote:
> On Wed, Dec 17, 2025 at 12:23 AM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> On 12/16/25 11:16, Jason Wang wrote:
>>> On Fri, Dec 12, 2025 at 11:28 PM Bui Quang Minh
>>> <minhquangbui99@gmail.com> wrote:
>>>> Calling napi_disable() on an already disabled napi can cause the
>>>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
>>>> when pausing rx"), to avoid the deadlock, when pausing the RX in
>>>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
>>>> However, in the virtnet_rx_resume_all(), we enable the delayed refill
>>>> work too early before enabling all the receive queue napis.
>>>>
>>>> The deadlock can be reproduced by running
>>>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
>>>> device and inserting a cond_resched() inside the for loop in
>>>> virtnet_rx_resume_all() to increase the success rate. Because the worker
>>>> processing the delayed refilled work runs on the same CPU as
>>>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
>>>> In real scenario, the contention on netdev_lock can cause the
>>>> reschedule.
>>>>
>>>> This fixes the deadlock by ensuring all receive queue's napis are
>>>> enabled before we enable the delayed refill work in
>>>> virtnet_rx_resume_all() and virtnet_open().
>>>>
>>>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>>>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>>>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>> - Move try_fill_recv() before rx napi_enable()
>>>> - Link to v1: https://lore.kernel.org/netdev/20251208153419.18196-1-minhquangbui99@gmail.com/
>>>> ---
>>>>    drivers/net/virtio_net.c | 71 +++++++++++++++++++++++++---------------
>>>>    1 file changed, 45 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 8e04adb57f52..4e08880a9467 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -3214,21 +3214,31 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>>>>    static int virtnet_open(struct net_device *dev)
>>>>    {
>>>>           struct virtnet_info *vi = netdev_priv(dev);
>>>> +       bool schedule_refill = false;
>>>>           int i, err;
>>>>
>>>> -       enable_delayed_refill(vi);
>>>> -
>>>> +       /* - We must call try_fill_recv before enabling napi of the same receive
>>>> +        * queue so that it doesn't race with the call in virtnet_receive.
>>>> +        * - We must enable and schedule delayed refill work only when we have
>>>> +        * enabled all the receive queue's napi. Otherwise, in refill_work, we
>>>> +        * have a deadlock when calling napi_disable on an already disabled
>>>> +        * napi.
>>>> +        */
>>>>           for (i = 0; i < vi->max_queue_pairs; i++) {
>>>>                   if (i < vi->curr_queue_pairs)
>>>>                           /* Make sure we have some buffers: if oom use wq. */
>>>>                           if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>>>> -                               schedule_delayed_work(&vi->refill, 0);
>>>> +                               schedule_refill = true;
>>>>
>>>>                   err = virtnet_enable_queue_pair(vi, i);
>>>>                   if (err < 0)
>>>>                           goto err_enable_qp;
>>>>           }
>>> So NAPI could be scheduled and it may want to refill but since refill
>>> is not enabled, there would be no refill work.
>>>
>>> Is this a problem?
>> You are right. It is indeed a problem.
>>
>> I think we can unconditionally schedule the delayed refill after
>> enabling all the RX NAPIs (don't check the boolean schedule_refill
>> anymore) to ensure that we will have refill work. We can still keep the
>> try_fill_recv here to fill the receive buffer earlier in normal case.
>> What do you think?
> Or we can have a reill_pending

Okay, let me implement this in the next version.

> but basically I think we need something
> that is much more simple. That is, using a per rq work instead of a
> global one?

I think we can leave this in a net-next patch later.

Thanks,
Quang Minh

>
> Thanks
>
>>>
>>>> +       enable_delayed_refill(vi);
>>>> +       if (schedule_refill)
>>>> +               schedule_delayed_work(&vi->refill, 0);
>>>> +
>>>>           if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
>>>>                   if (vi->status & VIRTIO_NET_S_LINK_UP)
>>>>                           netif_carrier_on(vi->dev);
>>>> @@ -3463,39 +3473,48 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>>>>           __virtnet_rx_pause(vi, rq);
>>>>    }
>>>>
>>> Thanks
>>>
>> Thanks,
>> Quang Minh.
>>

