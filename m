Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424E233721
	for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380811; cv=none; b=Pc+dYQjYSVa9KH7C7ni48iMTPMfuFHdHTLhw8e0cYmccp/z2zSO5C2zSlxTzv+lTgdZ1Mj/+n6OJr+1LUXxYALATVcx9toDEc7mAwRIJwqDwKhSC2uRDlrFSeaBo1ms0QRNrr93GJMmoVKheWVbyDhFAstBZaG9GBGtdxlQWJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380811; c=relaxed/simple;
	bh=Yx19Cw7PrTxmK2aj7a0su0iOLHk3ekoOT2KchGcwVTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2iF7vAP+7FwOA4lkJ1JF2vHHv2jFUKaiK1TrMeFzlZSFzFZoOS7gDakK5wS9sVsuNGpRQ8YbDqwRxY0QKyVUTWGx3BsIC7nMzpmHnvGtJcA/jUrNRXgdtzolh+A7orVuAeK48PsRD6OS6yXFl7+5L5SOkzSjcmCE+f0JKNekiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zn9PEciC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn9PEciC"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2956d816c10so80594395ad.1
        for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 07:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765380809; x=1765985609; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESuYFpOjYXjLgX7Fp3qymkbq56ElvjhTl63RkbJTEwg=;
        b=Zn9PEciC9aA2cNBhBWLW92BpWasCoxWry9BjG8o+m9Ms2ePwThjvGMbuKwr1kULImu
         7EDnfwMpZsVMiH6Upt77fXSgJW24osIGA5V1S/gzxjKOhM/CkzBn6Y/U80oUfD4RxrVt
         d8ryt+pdJupbMD+02sFn5ViTwvB9pZJrPyKbEpOUO8aH2eutFRAWybOFR4SQIx3XQiOT
         +WkCQkuAthyFiLxOSWMKwXv7ZXYuDj/QDuWzv/M7S4r7Ir5E/yJ6scaHSGsMN4awp1kI
         zavys5XZ3Kn/cCEtu5tUoykcJuWoNKL18mssedOjme4pOPSC3oD8uHqNROasOBadlq8I
         rdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765380809; x=1765985609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESuYFpOjYXjLgX7Fp3qymkbq56ElvjhTl63RkbJTEwg=;
        b=i6fgegAi9UObbfVK136hE+zJQkFC9XY6meUD2KTrtDX+ihm2WxpOl5gnSlgGqj6fZ+
         7tFCfZO6nI6HVOgNmmnO37CnfvBqD3ZxXClUsIDePHCXOtkKNfGzt/vPNQZmhbvT8wpW
         6aQeHrWmZE5ULf3W7K0oxcAjyD69XmMttsbTwmid9HEc5WNO2OZ8PKvTRiWH4TAyZm/0
         QyJ/bCpePMwi/Zpw90si1A6vDy2rI2X2oX0ezv5aYZmHcNPt+IjsNUxdpVhjt0WB3EHa
         21JHBJQzIWfsNL56XTdJv/M3HL+i0yNGVX6zop462kJKQZ9BxpbJJK95tjUJTLbGrOT+
         wkNg==
X-Forwarded-Encrypted: i=1; AJvYcCVEP7XEhAEp+8dUd7fTlCfpLDw87kcjQNmfPioRSgsk5j3gjdvZDu0FDztBnzxV3ky6YuUwz36ZlBRiRqyx/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnGowQG81MB54oQliwZdardImfUPbt4NvOu8AU2Cj1l0G+4R2l
	oDX4AMOxmRbbZR9IBC1NphOCn3DzU2L/h0SSsETbPlCNZFdCoQwPGj6c
X-Gm-Gg: AY/fxX4IlBgZX6cVwWKeVXFjDr0kICkudmCos/DmYcitl2unil5OoTCk2b+Xrsm8VA7
	Ir7o88yoaGWJUrLJ02UqdXU3OiaiAB8IkuSEAKKDSoe/ndTJeZSwXA4DC5joy6EV8KOA+8rNdQG
	RRqxDvgFnBmpqRvfhVxiSVmY4kJNcZv0tUxM5vLPX5PmuVHxttrNmEfnlWinP0mxrFeqf0Mp46r
	fsd4TJw4+QBENXJ6bjTdSZOiTeo/zwwf6bMNzKwZaEXPYjpRykqJrprLPuV/ShDxgWfqZilG2mh
	8Ca0lVMwfJnFRB1Zt7vy78gY9K69TUHrodN28wGl5BNsZ07px+grvdFYUfhMBGjtdwEDUWI/pYe
	pw10GiWCQ9IPi6LMCzCgw4S9u2ThwUeVms9V4wYWDsDScIL5E/OMJ9pf6wmfIjiYOi0HonXhK1d
	VZ7fGz5FFtyg8uKmNvh6d88bpIFh3lqe7Sr9dOj6U8ak8+LK5+w0tj9ZM7K8fAaQ==
X-Google-Smtp-Source: AGHT+IENrwT2Am+P2vjlTDz+KYOoqnBVC//oOg414tv75XRJNnToBhPmNfWibuLCCf4uNogdSV+RXQ==
X-Received: by 2002:a17:903:2ac7:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-29ec27be899mr30223795ad.42.1765380808606;
        Wed, 10 Dec 2025 07:33:28 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:311c:669b:9c36:4a99? ([2001:ee0:4f4c:210:311c:669b:9c36:4a99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49b196sm191451135ad.17.2025.12.10.07.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 07:33:28 -0800 (PST)
Message-ID: <c83c386e-96a6-4f9f-8047-23ce866ed320@gmail.com>
Date: Wed, 10 Dec 2025 22:33:17 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill
 work
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
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
 <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
 <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com>
 <CACGkMEuF0rNYcSSUCdAgsW2Xfen9NGZHNxXpkO2Mt0a4zQJDqQ@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEuF0rNYcSSUCdAgsW2Xfen9NGZHNxXpkO2Mt0a4zQJDqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/25 12:45, Jason Wang wrote:
> On Tue, Dec 9, 2025 at 11:23 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 12/9/25 11:30, Jason Wang wrote:
>>> On Mon, Dec 8, 2025 at 11:35 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
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
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>> ---
>>>>    drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
>>>>    1 file changed, 28 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 8e04adb57f52..f2b1ea65767d 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>>>>           return err != -ENOMEM;
>>>>    }
>>>>
>>>> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
>>>> +{
>>>> +       bool schedule_refill = false;
>>>> +       int i;
>>>> +
>>>> +       enable_delayed_refill(vi);
>>> This seems to be still racy?
>>>
>>> For example, in virtnet_open() we had:
>>>
>>> static int virtnet_open(struct net_device *dev)
>>> {
>>>           struct virtnet_info *vi = netdev_priv(dev);
>>>           int i, err;
>>>
>>>           for (i = 0; i < vi->max_queue_pairs; i++) {
>>>                   err = virtnet_enable_queue_pair(vi, i);
>>>                   if (err < 0)
>>>                           goto err_enable_qp;
>>>           }
>>>
>>>           virtnet_rx_refill_all(vi);
>>>
>>> So NAPI and refill work is enabled in this case, so the refill work
>>> could be scheduled and run at the same time?
>> Yes, that's what we expect. We must ensure that refill work is scheduled
>> only when all NAPIs are enabled. The deadlock happens when refill work
>> is scheduled but there are still disabled RX NAPIs.
> Just to make sure we are on the same page, I meant, after refill work
> is enabled, rq0 is NAPI is enabled, in this case the refill work could
> be triggered by the rq0's NAPI so we may end up in the refill work
> that it tries to disable rq1's NAPI while holding the netdev lock.

I don't quite get your point. The current deadlock scenario is this

virtnet_rx_resume_all
napi_enable(rq0) (the rq1 napi is still disabled)
enable_refill_work

refill_work
napi_disable(rq0) -> still okay
napi_enable(rq0) -> still okay
napi_disable(rq1)
-> hold netdev_lock
     -> stuck inside the while loop in napi_disable_locked
             while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
                 usleep_range(20, 200);
                 val = READ_ONCE(n->state);
             }


napi_enable(rq1)
-> stuck while trying to acquire the netdev_lock

The problem is that we must not call napi_disable() on an already 
disabled NAPI (rq1's NAPI in the example).

In the new virtnet_open

static int virtnet_open(struct net_device *dev)
{
          struct virtnet_info *vi = netdev_priv(dev);
          int i, err;

          // Note that at this point, refill work is still disabled, vi->refill_enabled == false,
          // so even if virtnet_receive is called, the refill_work will not be scheduled.
          for (i = 0; i < vi->max_queue_pairs; i++) {
                  err = virtnet_enable_queue_pair(vi, i);
                  if (err < 0)
                          goto err_enable_qp;
          }

          // Here all RX NAPIs are enabled so it's safe to enable refill work again
          virtnet_rx_refill_all(vi);


Thanks,
Quang Minh.

