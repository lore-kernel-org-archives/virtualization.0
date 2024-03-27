Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7BF22EEF
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 04:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711512543; cv=none; b=EotuwiHPeH+eMGWvFEa0f2Hd1z6cxTyy8JoQHiyqWaAA0g8G5msvTEDmQf92u1p+vZXuOrfWuzGW3i6dou3mabCh2rKqj2P9GKS913GbaNfwxnLF/YcrB1rznbgrrMVSmZAgxIo/dtMZomj1V+/B9w+AqUfMkK1Mek8NaccwPaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711512543; c=relaxed/simple;
	bh=cYlTjtD+bzIm9O0kZSDQTY679EEzlq43YS86TKTIzS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KL3I+PW6FYXdZ4UHVkByDaS1H/rHOitGQutPMjaSQtFFhKpBX3rMfTrmWTPInIW0Eskqw7upIQW0oPhfai8Lx52OQqayRlvNTPBxaqzNBsxQoVurMEFs7D2Pshe2DrniXaGTiPp1N5bWZXSQO1ulXEfzEQLeL76omaWGMBDz9WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5bTGBGA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5bTGBGA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711512540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8EosfaIjE/yoo0St6t3babX28krvxRF6BRpyMRsDKc=;
	b=D5bTGBGA9VLL599RhiF4s7yJ5vvqxKRLKj5XdTbXycUVVChHowHDt4zgiME/tTYHHHb9Vm
	e1gwAeyhZeIt0bSYjU0S4rcHye1A5qF3gNZj7oJcu9g3zCi9DQ09lwtp6+/YjaV4ulp1or
	MCLHYQDqhRoupS1Y18z+fzUKYV0eJ/Q=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-cG18VBjRNdidx4y9KdLRiw-1; Wed, 27 Mar 2024 00:08:55 -0400
X-MC-Unique: cG18VBjRNdidx4y9KdLRiw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-221d1cc21deso8212832fac.3
        for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 21:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711512535; x=1712117335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8EosfaIjE/yoo0St6t3babX28krvxRF6BRpyMRsDKc=;
        b=WOQQrR5YEWBKhWFN/kSddC+PJQcL2nerTu2Vafv9y2nqg9wrq6vMAoUU1FJp99vBjZ
         8lOekQckqffYK2TzGGgomOhZHQwxj1eJUomviAmrkkhWYUQN4n7Mmc7lENRUx3llYLtK
         IuEURn4KfRqOH/NTAIqfzq5Ai5Q0uRbPluH8EK5Hzj+4sPL3pWfptJ4VWQpZKbO4Zreu
         KAcPEkrAQSPEXb/7UjUO7Ujjo6rdtk/jhzUkIbcdPcSiJ8dJ8D6PBvakNOPYkirDK3p3
         9XV6bDo0hi8Ph/+GKICXa4WYJbSYUem2tGdzdrT0ic3p9hdJCCHPVcAgrAVh3pZ5eW2l
         ltjg==
X-Gm-Message-State: AOJu0YxQykaHTj6mjnIXcKFTS3hwb667fVFVPsULLxWEXKDRrYnKONL+
	DzGpIg+i7HMm38Po0YE4bCfhy0AjAK9i5Rtf6F5EBrTH/eszLeit2k1u3keLQpqkSQBl57DlbiK
	R5JEh1fh9foeDOxeqDF2cwj72tULOhT1zFCILdjGgOnhZAdqCSGM9d3oY8q5/7hky
X-Received: by 2002:a05:6870:c141:b0:22a:551c:3170 with SMTP id g1-20020a056870c14100b0022a551c3170mr56373oad.23.1711512535133;
        Tue, 26 Mar 2024 21:08:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF50WxD1WML38dc+XtF4zkt7bojkoOjIiS4YMBjUxaHEoFI0r8QS8ChHwBVTO9PaX6/HLYzMw==
X-Received: by 2002:a05:6870:c141:b0:22a:551c:3170 with SMTP id g1-20020a056870c14100b0022a551c3170mr56349oad.23.1711512534774;
        Tue, 26 Mar 2024 21:08:54 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id y18-20020aa78552000000b006e70c4de7dasm6815509pfn.124.2024.03.26.21.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 21:08:53 -0700 (PDT)
Message-ID: <b6f4e8c1-bdd1-496e-aa1a-68349674671c@redhat.com>
Date: Wed, 27 Mar 2024 14:08:47 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vhost: Add smp_rmb() in vhost_vq_avail_empty()
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 mst@redhat.com, davem@davemloft.net, stefanha@redhat.com,
 sgarzare@redhat.com, keirf@google.com, yihyu@redhat.com,
 shan.gavin@gmail.com, Will Deacon <will@kernel.org>
References: <20240326233846.1086253-1-gshan@redhat.com>
 <20240326233846.1086253-2-gshan@redhat.com>
 <CACGkMEtyEo2QQSEh0ZnZDUJSXMMhzeO97Jp0wF4_rhzUBGk4Zg@mail.gmail.com>
 <CACGkMEtUdgDr_M-F8-gdFkJp+29Xuw9DCib2-diFmJxFxDN2Bw@mail.gmail.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CACGkMEtUdgDr_M-F8-gdFkJp+29Xuw9DCib2-diFmJxFxDN2Bw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/24 12:44, Jason Wang wrote:
> On Wed, Mar 27, 2024 at 10:34 AM Jason Wang <jasowang@redhat.com> wrote:
>> On Wed, Mar 27, 2024 at 7:39 AM Gavin Shan <gshan@redhat.com> wrote:
>>>
>>> A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
>>> Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
>>> available ring entries pushed by guest can be observed by vhost
>>> in time, leading to stale available ring entries fetched by vhost
>>> in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
>>> grace-hopper (ARM64) platform.
>>>
>>>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>>>    -accel kvm -machine virt,gic-version=host -cpu host          \
>>>    -smp maxcpus=1,cpus=1,sockets=1,clusters=1,cores=1,threads=1 \
>>>    -m 4096M,slots=16,maxmem=64G                                 \
>>>    -object memory-backend-ram,id=mem0,size=4096M                \
>>>     :                                                           \
>>>    -netdev tap,id=vnet0,vhost=true                              \
>>>    -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0
>>>     :
>>>    guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>>>    virtio_net virtio0: output.0:id 100 is not a head!
>>>
>>> Add the missed smp_rmb() in vhost_vq_avail_empty(). Note that it
>>> should be safe until vq->avail_idx is changed by commit 275bf960ac697
>>> ("vhost: better detection of available buffers").
>>>
>>> Fixes: 275bf960ac697 ("vhost: better detection of available buffers")
>>> Cc: <stable@kernel.org> # v4.11+
>>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   drivers/vhost/vhost.c | 11 ++++++++++-
>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>> index 045f666b4f12..00445ab172b3 100644
>>> --- a/drivers/vhost/vhost.c
>>> +++ b/drivers/vhost/vhost.c
>>> @@ -2799,9 +2799,18 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>>>          r = vhost_get_avail_idx(vq, &avail_idx);
>>>          if (unlikely(r))
>>>                  return false;
>>> +
>>>          vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>>> +       if (vq->avail_idx != vq->last_avail_idx) {
>>> +               /* Similar to what's done in vhost_get_vq_desc(), we need
>>> +                * to ensure the available ring entries have been exposed
>>> +                * by guest.
>>> +                */
>>
>> We need to be more verbose here. For example, which load needs to be
>> ordered with which load.
>>
>> The rmb in vhost_get_vq_desc() is used to order the load of avail idx
>> and the load of head. It is paired with e.g virtio_wmb() in
>> virtqueue_add_split().
>>
>> vhost_vq_avail_empty() are mostly used as a hint in
>> vhost_net_busy_poll() which is under the protection of the vq mutex.
>>
>> An exception is the tx_can_batch(), but in that case it doesn't even
>> want to read the head.
> 
> Ok, if it is needed only in that path, maybe we can move the barriers there.
> 

[cc Will Deacon]

Jason, appreciate for your review and comments. I think PATCH[1/2] is
the fix for the hypothesis, meaning PATCH[2/2] is the real fix. However,
it would be nice to fix all of them in one shoot. I will try with PATCH[2/2]
only to see if our issue will disappear or not. However, the issue still
exists if PATCH[2/2] is missed.

Firstly, We were failing on the transmit queue and {tvq, rvq}->busyloop_timeout
== false if I remember correctly. So the added smp_rmb() in vhost_vq_avail_empty()
is only a concern to tx_can_batch(). A mutex isn't enough to ensure the order
for the available index and available ring entry (head). For example, vhost_vq_avail_empty()
called by tx_can_batch() can see next available index, but its corresponding
available ring entry (head) may not be seen by vhost yet if smp_rmb() is missed.
The next call to get_tx_bufs(), where the available ring entry (head) doesn't
arrived yet, leading to stale available ring entry (head) being fetched.

   handle_tx_copy
     get_tx_bufs                 // smp_rmb() won't be executed when vq->avail_idx != vq->last_avail_idx
     tx_can_batch
       vhost_vq_avail_empty      // vq->avail_idx is updated from vq->avail->idx

The reason why I added smp_rmb() to vhost_vq_avail_empty() is because the function
is a exposed API, even it's only used by drivers/vhost/net.c at present. It means
the API has been broken internally. So it seems more appropriate to fix it up in
vhost_vq_avail_empty() so that the API's users needn't worry about the memory access
order.

>>
>>
>>> +               smp_rmb();
>>> +               return false;
>>> +       }
>>>
>>> -       return vq->avail_idx == vq->last_avail_idx;
>>> +       return true;
>>>   }
>>>   EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);

Thanks,
Gavin

