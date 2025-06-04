Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7D6290D8E
	for <virtualization@lists.linux.dev>; Wed,  4 Jun 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046644; cv=none; b=fL8xuauP/bEjbtjWZ8jxOCDjG5EBJBEj8+6Y84Fy00g2px95BfL/tbAgb//fKPdtbbT8LzgzkL/ObX8I91AxQ5jDZ3Q5lw6wOB0MfXouiixjXfGgV6nv8SfzMW91teo8cb3VODCub3u3oekN2LI/o9mNGTqZTQUsCEGUzpt2Tvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046644; c=relaxed/simple;
	bh=Nnuyl9wD25Z9WoJOMjCag6e7edZarcfbMnxn+kgonFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gey+hzXj834ZiHsMw1ASzhhuYW2lJ/Peg9YCnlTIvAP2zFzYV0jWPlQRx/7nlIyvcok2V0aTrwv2xXBQfEVoV0eswf88TUrW33ypJVg55/TTbYGXgoVNbAclAv2peHHf3uYoc5V50xtb1PTXR2lZEcFSfaFIlKLryzu4Bkzi7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWhVui2W; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWhVui2W"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23539a1a421so40364705ad.0
        for <virtualization@lists.linux.dev>; Wed, 04 Jun 2025 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749046642; x=1749651442; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbNMtoTuh7H5yqZEP3R1sHyOOtxrJsRVIWBb21IBiJI=;
        b=NWhVui2WcssUhjjw8nPdQu1kqUnhsLofB8k60Mig4dkcBhbf6hqusTtqQiWvk0w22q
         R2sCtJXkD50ZcODfMldrLvWCAZU4y/LzMAvkXpinQN1H6vmj+rcttAxRZOdM8+3/swmC
         kaBZ5TOxxt6zWh+BU632DIdWHDQU4msF9X5B7Qoz/wamjxSQ3SWry6RztkK9VgesCgMk
         fB3sVzyfPSfLrxRhVjByvL4a18HQ7iXJbJHd13f351smEGGTAK1fWDa4AZYpm6bihvPu
         h3Jdeqlvj384L30hfqvm0evQihZwXVtd2ZWNySlvy0h3/jBHeFw3ffaIE0alCcMeMR2a
         gNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749046642; x=1749651442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbNMtoTuh7H5yqZEP3R1sHyOOtxrJsRVIWBb21IBiJI=;
        b=ceR7+VniBBEVGfhbBuyRZJuYhhN1zNrmXRQ5R5rC+Xn8YKvDlA/NYQ51m4VbsEcIjE
         +D6NYHshRNTp9nQI2+8Fi/mIjdTJ0rgYPaCdt/9ifVXnwgXhBXE0JkOFC0AeAzs+3Wge
         8IKdyqFInBqNK2l9FTdV5qUOc1FbpaIQh+HdgPUW0/0Oql/5NzpfPi1iGwrGLO2XpRSc
         PY+IsQ1BxLTFwV6KENlzZS8qxj/j78qEET13ZvcT//23jgbQmL0U2WSlmhCx5TSNmXRF
         2EfjhBjwBa/dn7uDB5D1HXNLVKENo3zTJEreeBwQKwqpjZF/puxvvkTZdUy+q4Yt9OM3
         rbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe+UIfxUYw6+8edDAoabV/6P06jDAlCpTi6iKZQlMcVB/i/akRpGpVH/aAfd6RMIc2vFlF6RJH1Qqq6zUU7w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm/nlkshJB32suxCYdMc3eiPMdkUbKKuwHDjXE0QL0XLaVRehp
	06S77+VdJ4yvMNOI0NlecHsptLWEIdZQ8q3obhnFyDoWdhznRy3imwXL
X-Gm-Gg: ASbGncuj/TJiwKjVYCDitkylzcBX7a3NvM5diUPy6m3JApOD1QVT7bONB2fgl+PUcUQ
	Ww324I3EcWjPXNr5SSKxYMC/ME/uagx9XPOIiQktUnQd/2FvxRU6LDydTFC2LuLnQIQL1lhSFWv
	H2TrNtBd1PsHgKg+t7WeRD2OCYGf4KbpEjybQY3+Q+mXG1P5edgf+v5PjL13qaX1uzN4brz3i+t
	NLPB8f/9dQI6oVcA6PB+6G/hPtdJ/u9qz+AI4QuOafU+hVoK/fom4Ujj9fpnBVdmBnV0LDrD9Sm
	/dQvrzq4iFL7R3Yr3IV6cHy3beLWAhKZyq7mkZ33a8nDv5a+dSRnq2eJePxvoDDo2J8BLcyceO9
	Uh8rvAx0xGrT2miznm3kzlvgFhndFcg==
X-Google-Smtp-Source: AGHT+IE828D8E7wNAmkp2vuWIY7rdgflYp7evYs/pZp1n9PqsG0ZfmxYtWnexCMgGjwdtHSFbk9D6Q==
X-Received: by 2002:a17:902:c94d:b0:234:bca7:2920 with SMTP id d9443c01a7336-235e11c91abmr48459595ad.24.1749046641673;
        Wed, 04 Jun 2025 07:17:21 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:8915:1d85:9b14:f198? ([2001:ee0:4f0e:fb30:8915:1d85:9b14:f198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd93f7sm103883575ad.95.2025.06.04.07.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 07:17:21 -0700 (PDT)
Message-ID: <0bc8547d-aa8f-4d96-9191-fd52d1bec74e@gmail.com>
Date: Wed, 4 Jun 2025 21:17:09 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
 <CACGkMEuHDLJiw=VdX38xqkaS-FJPTAU6+XUNwfGkNZGfp+6tKg@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEuHDLJiw=VdX38xqkaS-FJPTAU6+XUNwfGkNZGfp+6tKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/4/25 07:37, Jason Wang wrote:
> On Tue, Jun 3, 2025 at 11:07 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> In virtio-net, we have not yet supported multi-buffer XDP packet in
>> zerocopy mode when there is a binding XDP program. However, in that
>> case, when receiving multi-buffer XDP packet, we skip the XDP program
>> and return XDP_PASS. As a result, the packet is passed to normal network
>> stack which is an incorrect behavior. This commit instead returns
>> XDP_DROP in that case.
>>
>> Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e53ba600605a..4c35324d6e5b 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
>>          ret = XDP_PASS;
> It would be simpler to just assign XDP_DROP here?
>
> Or if you wish to stick to the way, we can simply remove this assignment.

This XDP_PASS is returned for the case when there is no XDP program 
binding (!prog).

>
>>          rcu_read_lock();
>>          prog = rcu_dereference(rq->xdp_prog);
>> -       /* TODO: support multi buffer. */
>> -       if (prog && num_buf == 1)
>> -               ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
>> +       if (prog) {
>> +               /* TODO: support multi buffer. */
>> +               if (num_buf == 1)
>> +                       ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
>> +                                                 stats);
>> +               else
>> +                       ret = XDP_DROP;
>> +       }
>>          rcu_read_unlock();
>>
>>          switch (ret) {
>> --
>> 2.43.0
>>
> Thanks
>


Thanks,
Quang Minh.


