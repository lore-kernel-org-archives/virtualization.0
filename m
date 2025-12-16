Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8AD329C41
	for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902197; cv=none; b=jmxBPQc8trN/RgXmcKTfn/72ZOspTYxDNKCh/dSH5P2AzdinJGnLNxwG7M88M5tBEhekM5mS7bGXytrog4/2GwZW0WtEsGpJbDRA5c8RYhYrH9yYcKy/6JCSQXdDiqYT6LKe0t1+ZGCC9aA6CTEMtRpfrIPuA01H57kZb9hrjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902197; c=relaxed/simple;
	bh=SLX1m3nU08SsL41tzHOdEaPGIcnB60w6kwnMIe7g1D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+p/6mUxhcQDq+zkNGxumTgOoAYxbAeHDpVZjmJzLyhYJ6iNvXQHtRqDIGbQJpO5+wHyhLs5aK3CCssFroceyrdvrcgSrUdCdwvVbX6fVaai0VEbGtouq0vna4YQsxKCUX3Y0m2qOzKQnz0buitgnKnkclL5Xy2+dMdKazq2tRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBRLcq8G; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBRLcq8G"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso7124026b3a.1
        for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 08:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765902192; x=1766506992; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5vCKhasJ1Ig30OHsuQK/Y6r0bPzjGj3HFYq+PgtrOQ=;
        b=FBRLcq8G5zlNpbsZdW4s+UNERp1oVtdzBmYbdGVpnAlXgsEL0FYEOD2AYNcy8kFt8c
         9BezGTBzH2N1bkBY/aQoGPOM9oWtOkC2urOWMiGc7q3l+Edi0N1ak9+wARS8Wgxxc/QR
         J4DCwSFdKWeYjbWy3DaZoPQSa1UDWpEBcmzLQxeOwUo3zm6ImW/bO/MiZJVkEXSToOzG
         sH2RwqdJLZIc62UIrh50wgx8g5ENTqTSGoF2RvCLoZosVQ+f+bZ/2CxjZrGjGvhrzfV3
         KWeUEvLhoyH+bkmn39DnWkh6cTbD3dXsdEcbVmVDNomDl6Mfk7OvZ5s1FzdwK/PTw8D5
         YJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765902192; x=1766506992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5vCKhasJ1Ig30OHsuQK/Y6r0bPzjGj3HFYq+PgtrOQ=;
        b=BT4x5wsXylh7CjAqrbcYn0vDa7cUb59axtE6hkMXCowg4Vb30tKulAe3/8+PrMr3V2
         iXy/CO/s+CvlfG1N6fSXDJrIg2skeOina0bjwIzBCF+sKXNSgF2iRDTh82FXdc0dr+gf
         mjbTfJ/cX1ux1xJai7q7S2ErkY7D78I8iCHPm3mtZVubQ9mumr/+d6ZwwjibCJc7lZjw
         by4frtMRERqku6I9OqV9O4/1Xcsz5Pk2/IEpkWENZMOw2ERvNrpXec1Wa23IWpN15cWA
         WPj80pK7WC71z+Elca00uAEhuETF3VDRnTUt+iFCNQM8R+0/xrYQHbiSswn1qcNau82J
         +MLg==
X-Forwarded-Encrypted: i=1; AJvYcCWnYYKxKJQJ+yapSdG8sVk4Sxj7t+vn7CVL6Kp5q7NS2WSdltBxqPE7J28dJ69u3wUOxankILeEL/QXNr1ayg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWTeZzQCFU/Fox/hYA50hfMrpI74I9KPijYZfpxEQpKR3DAVZu
	SrGckXpwIrrZNbkt2jH8+g7tIxnV6bwERve3siBWVbtH1KDNqVqWWD79
X-Gm-Gg: AY/fxX4b8Cg+F9pakuG15RHqK0Qov5gUJ0Y7R6aPshVY4viLpoqwzf3HLBGsKGQWiY0
	7DgpIS8bcMO7vZpZH9pId2qkYg8wiycsMYKPsI9hpvw9AFDbysps8LKvfU27zmDZpCLiUaQzl1p
	h9iKQ7Nrd7yKxqFERwCGW/lpJ1YS4Qp7rMAfQu3h6xO/f5frammaDGPdfrqJyEu1qspgzXSSACK
	/vqjO/03KKsz2fc02i/A1ZMul8cNcsW5DWORMJWPibm8cJwF2DuqHSw//gQT1ytfYNUrONeUOMO
	L0PidDnuU4RpME3J3+ij7NyMrUhNaH3ppkZyBXW6C4jOYPdeYGqW9xwuOvKOd6Iqodi/10Ew2HY
	Zk72CjGLvGzggnMXr+ju4t1+F2v1Be7Y7zrmo0jR9pvQVe3CPKs92NoeA85MqmTneBQz7sHtDcq
	ZGhKc+HctAmWtFT2z77NfaEcjA8O+M9gIgN6Xt8ROJgkIJJTCZPWjjOzksxek=
X-Google-Smtp-Source: AGHT+IECYfe/OWkP+h6xwdXpAJwtn05ZsuE/m7/iUcw3NPvb9j7sxFVFBX2c8mmvByjxd+djfC6elw==
X-Received: by 2002:a05:6a00:1d0a:b0:7b7:6f69:e9ba with SMTP id d2e1a72fcca58-7f667447030mr15140623b3a.1.1765902191527;
        Tue, 16 Dec 2025 08:23:11 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:aa6d:57b:2df9:35ae? ([2001:ee0:4f4c:210:aa6d:57b:2df9:35ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4e9d9e3sm15921893b3a.45.2025.12.16.08.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 08:23:11 -0800 (PST)
Message-ID: <3f5613e9-ccd0-4096-afc3-67ee94f6f660@gmail.com>
Date: Tue, 16 Dec 2025 23:23:04 +0700
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
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEtzXmfDhiQiq=5qPGXG+rJcxGkWk0CZ4X_2cnr2UVH+eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/16/25 11:16, Jason Wang wrote:
> On Fri, Dec 12, 2025 at 11:28 PM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> Calling napi_disable() on an already disabled napi can cause the
>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
>> when pausing rx"), to avoid the deadlock, when pausing the RX in
>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
>> However, in the virtnet_rx_resume_all(), we enable the delayed refill
>> work too early before enabling all the receive queue napis.
>>
>> The deadlock can be reproduced by running
>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
>> device and inserting a cond_resched() inside the for loop in
>> virtnet_rx_resume_all() to increase the success rate. Because the worker
>> processing the delayed refilled work runs on the same CPU as
>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
>> In real scenario, the contention on netdev_lock can cause the
>> reschedule.
>>
>> This fixes the deadlock by ensuring all receive queue's napis are
>> enabled before we enable the delayed refill work in
>> virtnet_rx_resume_all() and virtnet_open().
>>
>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v2:
>> - Move try_fill_recv() before rx napi_enable()
>> - Link to v1: https://lore.kernel.org/netdev/20251208153419.18196-1-minhquangbui99@gmail.com/
>> ---
>>   drivers/net/virtio_net.c | 71 +++++++++++++++++++++++++---------------
>>   1 file changed, 45 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 8e04adb57f52..4e08880a9467 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3214,21 +3214,31 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>>   static int virtnet_open(struct net_device *dev)
>>   {
>>          struct virtnet_info *vi = netdev_priv(dev);
>> +       bool schedule_refill = false;
>>          int i, err;
>>
>> -       enable_delayed_refill(vi);
>> -
>> +       /* - We must call try_fill_recv before enabling napi of the same receive
>> +        * queue so that it doesn't race with the call in virtnet_receive.
>> +        * - We must enable and schedule delayed refill work only when we have
>> +        * enabled all the receive queue's napi. Otherwise, in refill_work, we
>> +        * have a deadlock when calling napi_disable on an already disabled
>> +        * napi.
>> +        */
>>          for (i = 0; i < vi->max_queue_pairs; i++) {
>>                  if (i < vi->curr_queue_pairs)
>>                          /* Make sure we have some buffers: if oom use wq. */
>>                          if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>> -                               schedule_delayed_work(&vi->refill, 0);
>> +                               schedule_refill = true;
>>
>>                  err = virtnet_enable_queue_pair(vi, i);
>>                  if (err < 0)
>>                          goto err_enable_qp;
>>          }
> So NAPI could be scheduled and it may want to refill but since refill
> is not enabled, there would be no refill work.
>
> Is this a problem?

You are right. It is indeed a problem.

I think we can unconditionally schedule the delayed refill after 
enabling all the RX NAPIs (don't check the boolean schedule_refill 
anymore) to ensure that we will have refill work. We can still keep the 
try_fill_recv here to fill the receive buffer earlier in normal case. 
What do you think?

>
>
>> +       enable_delayed_refill(vi);
>> +       if (schedule_refill)
>> +               schedule_delayed_work(&vi->refill, 0);
>> +
>>          if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
>>                  if (vi->status & VIRTIO_NET_S_LINK_UP)
>>                          netif_carrier_on(vi->dev);
>> @@ -3463,39 +3473,48 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>>          __virtnet_rx_pause(vi, rq);
>>   }
>>
> Thanks
>

Thanks,
Quang Minh.

