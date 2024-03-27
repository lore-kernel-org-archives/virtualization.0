Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C75B22F02
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711512650; cv=none; b=t9NxNlNbMOeexMh/bceKv8/LkHOklSbmGhhyfu7SSPFh/4vRtOixgKfFss1bR2ovvpihNFekG714XgRyFlyCGz9YuNjd8jW7UPAdP/+WRusGGGssM7Ak9aHR4Bgh6iqMwfP70wXnQseK0ALzwvdnVdjenQBoDTbokCXoIF5wWCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711512650; c=relaxed/simple;
	bh=p51JGKplShDetR3HvIlnBfRqUx7dnkAQPuvdWuaxSdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFcHjWpTq58tJwU72tqWb1Fwss2YmSs0ejrwGV1diIJltBmxJOAhhvfIqlK6sJ4/Ew8cTjCXjUm0H59bpgjT7lwX1fAN2zWz3dgDR11LoC3eAeubUt1bBzmTSTspDztff9kv2WqIR1w7n5cO7BlehD8bvwKjc+Pq6qLCS4hFeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEQiZ6lW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEQiZ6lW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711512647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5+1XpJ1QDmRZjMIApoly5kAN/ysXdALmVG61MmSu6w=;
	b=dEQiZ6lWEstHsoxl60phzIvUh69GBUgFcASA9H4x6nPXApntG00AX0zE7oJniP8RKubH4I
	g2AwcYY1xJJA87F/0sdDbHSH+UI5B0wAM9rHA28S30kB9yl9qDK69huAReSIDp2OiOPGaY
	CgMNkOUEfjYT9bkyjKUyiun7/650tLs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-3pfkdj2JPGWIDpViNuljdw-1; Wed, 27 Mar 2024 00:10:45 -0400
X-MC-Unique: 3pfkdj2JPGWIDpViNuljdw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29de4f107b7so5045017a91.2
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 21:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711512644; x=1712117444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5+1XpJ1QDmRZjMIApoly5kAN/ysXdALmVG61MmSu6w=;
        b=DFJ8WLXvH4puX52boitnuIzwvkaGfJppWZLJWVnGNEwL2UvxjGtZRZYXr29MZRVg0K
         cx/e0O68rW3d1cdqOtjNy1YpNS032+1vgdxAcuBIljMa7M+9VUdMbBv4w9S6/9CjXHyF
         Q08bmQCFB2K+1shPiVW0iUgQpvnvn+ee+4wfHiTxCclAssaeWtPy+Dlxjzr+qsWJPYSY
         aGdcC+FfCPS8MERHLmZ1T4cEl/89PrF0gsXqHcsYL03SkggcwUmymr97F6+vhemW2VIf
         PYXTMdrmFlZMzSkAZH1X7zOFpMx7BBL2b6X5r3bNZCZjU+TZM8AVFJ5veE76kfuo6V1u
         LFVw==
X-Gm-Message-State: AOJu0Yx2cmQuRybR+R0xFQPO1rzMgBvPqSiZxz52KWOIe5PyhjtdiUBo
	RETG0xAHYsYPxbridC1DD4QnJ11Y/lyDtu5TMYPcizOyw4MxffWqPuCX3soZXKEc+owKATYNAqj
	5W5U0a/JIH+M/nguVzPntY88hvtqBMJAM6fvHPdAFa2iEFM+Pm5BmlrHX4rLo3UwR
X-Received: by 2002:a17:90a:8c91:b0:29d:f554:2c6f with SMTP id b17-20020a17090a8c9100b0029df5542c6fmr4890983pjo.9.1711512644455;
        Tue, 26 Mar 2024 21:10:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/3ZBbxMY+6DfmgdcOBMF8ZQO0GR0DKXvxYhITpWYHb489a/NGFcwSiyDgYdq3phG6zaNijQ==
X-Received: by 2002:a17:90a:8c91:b0:29d:f554:2c6f with SMTP id b17-20020a17090a8c9100b0029df5542c6fmr4890970pjo.9.1711512644134;
        Tue, 26 Mar 2024 21:10:44 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id 22-20020a631756000000b005e838955bc4sm8272425pgx.58.2024.03.26.21.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 21:10:43 -0700 (PDT)
Message-ID: <c9d9c47e-6180-4a11-84d9-618e24c5a898@redhat.com>
Date: Wed, 27 Mar 2024 14:10:37 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vhost: Add smp_rmb() in vhost_enable_notify()
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 mst@redhat.com, davem@davemloft.net, stefanha@redhat.com,
 sgarzare@redhat.com, keirf@google.com, yihyu@redhat.com,
 shan.gavin@gmail.com, Will Deacon <will@kernel.org>
References: <20240326233846.1086253-1-gshan@redhat.com>
 <20240326233846.1086253-3-gshan@redhat.com>
 <CACGkMEsh8HguArBNUkxcZ74pWoZWOtfj2Zigenyt_Ehh7qf_YQ@mail.gmail.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CACGkMEsh8HguArBNUkxcZ74pWoZWOtfj2Zigenyt_Ehh7qf_YQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/24 12:41, Jason Wang wrote:
> On Wed, Mar 27, 2024 at 7:39 AM Gavin Shan <gshan@redhat.com> wrote:
>>
>> A smp_rmb() has been missed in vhost_enable_notify(), inspired by
>> Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
>> available ring entries pushed by guest can be observed by vhost
>> in time, leading to stale available ring entries fetched by vhost
>> in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
>> grace-hopper (ARM64) platform.
>>
>>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>>    -accel kvm -machine virt,gic-version=host -cpu host          \
>>    -smp maxcpus=1,cpus=1,sockets=1,clusters=1,cores=1,threads=1 \
>>    -m 4096M,slots=16,maxmem=64G                                 \
>>    -object memory-backend-ram,id=mem0,size=4096M                \
>>     :                                                           \
>>    -netdev tap,id=vnet0,vhost=true                              \
>>    -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0
>>     :
>>    guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>>    virtio_net virtio0: output.0:id 100 is not a head!
>>
>> Add the missed smp_rmb() in vhost_enable_notify(). Note that it
>> should be safe until vq->avail_idx is changed by commit d3bb267bbdcb
>> ("vhost: cache avail index in vhost_enable_notify()").
>>
>> Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
>> Cc: <stable@kernel.org> # v5.18+
>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   drivers/vhost/vhost.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 00445ab172b3..58f9d6a435f0 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2847,9 +2847,18 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>>                         &vq->avail->idx, r);
>>                  return false;
>>          }
>> +
>>          vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>> +       if (vq->avail_idx != vq->last_avail_idx) {
>> +               /* Similar to what's done in vhost_get_vq_desc(), we need
>> +                * to ensure the available ring entries have been exposed
>> +                * by guest.
>> +                */
>> +               smp_rmb();
>> +               return true;
>> +       }
>>
>> -       return vq->avail_idx != vq->last_avail_idx;
>> +       return false;
> 
> So we only care about the case when vhost_enable_notify() returns true.
> 
> In that case, I think you want to order with vhost_get_vq_desc():
> 
> last_avail_idx = vq->last_avail_idx;
> 
> if (vq->avail_idx == vq->last_avail_idx) { /* false */
> }
> 
> vhost_get_avail_head(vq, &ring_head, last_avail_idx)
> 
> Assuming I understand the patch correctly.
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 

Jason, thanks for your review and comments. Your understanding is exactly
what I understood.

> 
>>   }
>>   EXPORT_SYMBOL_GPL(vhost_enable_notify);
>>

Thanks,
Gavin

