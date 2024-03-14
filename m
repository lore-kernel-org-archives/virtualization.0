Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF576D1B3
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411335; cv=none; b=sEfThXBQxXTIL1NBEdd5ZbFGnP4jI2SQEgk7O+X2wCi78bgbHDl2jNL1+cCPQPTuFgKZD/5h3Y5bYPmZzIlCfO4OTEOhAjzGukJehEUPqunL/3OGchalYfzpHKZgnSFcnhOJgXhLTybSnq6iRfEUrKYJSW0ohuXXMW5NTCBlYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411335; c=relaxed/simple;
	bh=ycsW7LzYI2X7GBwi/xPk4fdSIDiJftf7KAKOzrECOFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXGau49dOrRQaHG0q02ZwpI67CQTmwDrMfAFfdCslaEVN/pfQUD8Ec8pMTrtsk6Z7kexMeCJrL7mB8fCOQO/wokG3ADYQ20gtBWkCntQWhotgJ3SSn6MKBwZ8LDbzkSEShxUxxUqHLASy1A+QSX7pL8MS72xhc6+PwMWbzhi0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgVfaHTA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgVfaHTA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710411332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1Uxb+6viRMpNE9ltOLx40J6IZsgLFNrkQ0OvLIySyw=;
	b=RgVfaHTACEAFB+l51myAidXFgKKDFpPioIaP4gP25Zo8/voFZ8Ze4+8MMOsFPpNAk2H2BD
	oUnBnbF2ALaPaUuKO91/nIHNwpSsl3QLUYQXONR6mz6c4BLPxGHilJh4TNivdjPeRFe7U1
	3TuYp2Z35Dc1565h4omea6PyXxmWJgM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-kqzbkIsWOPemSYkux3G-fA-1; Thu, 14 Mar 2024 06:15:29 -0400
X-MC-Unique: kqzbkIsWOPemSYkux3G-fA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso680496a12.0
        for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 03:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710411328; x=1711016128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Uxb+6viRMpNE9ltOLx40J6IZsgLFNrkQ0OvLIySyw=;
        b=p5ZIGz16n8tFcmW9xJuWKotoWmk58PhQ3RbrtRvzc5klvDcInnGtejwgDS8TxbEp8W
         NcHRQt2gwgM0szGIQRD4d3EF7QJ/ekUbGqmqaagCfEf1Ob7ubn7RuF8gemZ22zK8rVlX
         2Ettu+KLbwYEzqKLEFO7Dasnot8CgGsHo1OkY7G2zufDZhmdDzBsVNHkiYhxd4+D5HKx
         PWu3isrm5eAtFe62wTy1YMpgzNqo3Yalus2MlIdWZSZyypWP+dCAIj4+S7sw5ozVjdu2
         HCknbsb3KsidKnCvyc2JBoQMsoP3embQdiW1NaAokfwKhR142yLsiZWnqbAU0PTFCtyn
         nD1Q==
X-Gm-Message-State: AOJu0YwHIZdtX2qY0FysQB6DyOCF00H89Tjo0UaMHaWYpTN28HOMl1Xm
	5t/+iZmlEes3DpYmaKiLZMS2lSY0CYMUIpqlCbf3O3mbT/z3d62jYHQcP78Dehqn5aJsYz/KDUI
	jWZzeAFgDH+do9hJ8i49t/LOaZRaeotsZm+DbG2SQeHJU9x91Qb18y0IEBS13Pi26
X-Received: by 2002:a17:902:ce87:b0:1dc:7101:58c0 with SMTP id f7-20020a170902ce8700b001dc710158c0mr7610154plg.22.1710411328139;
        Thu, 14 Mar 2024 03:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBfGxwiSyPHkLnxtwxkJJyRl1lXhku6m/rd49AH3cwYX8QYQ0bzga29lt8nOAFDxAXNKvfIA==
X-Received: by 2002:a17:902:ce87:b0:1dc:7101:58c0 with SMTP id f7-20020a170902ce8700b001dc710158c0mr7610128plg.22.1710411327738;
        Thu, 14 Mar 2024 03:15:27 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id v2-20020a170903238200b001dc3c4e7a12sm1302622plh.14.2024.03.14.03.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 03:15:26 -0700 (PDT)
Message-ID: <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
Date: Thu, 14 Mar 2024 20:15:22 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
 shan.gavin@gmail.com
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240314040443-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240314040443-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 18:05, Michael S. Tsirkin wrote:
> On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
>> The issue is reported by Yihuang Yu who have 'netperf' test on
>> NVidia's grace-grace and grace-hopper machines. The 'netperf'
>> client is started in the VM hosted by grace-hopper machine,
>> while the 'netperf' server is running on grace-grace machine.
>>
>> The VM is started with virtio-net and vhost has been enabled.
>> We observe a error message spew from VM and then soft-lockup
>> report. The error message indicates the data associated with
>> the descriptor (index: 135) has been released, and the queue
>> is marked as broken. It eventually leads to the endless effort
>> to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
>> and soft-lockup. The stale index 135 is fetched from the available
>> ring and published to the used ring by vhost, meaning we have
>> disordred write to the available ring element and available index.
>>
>>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
>>    -accel kvm -machine virt,gic-version=host                            \
>>       :                                                                 \
>>    -netdev tap,id=vnet0,vhost=on                                        \
>>    -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
>>
>>    [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
>>
>> Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
>> virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
>> ARM64. It should work for other architectures, but performance loss is
>> expected.
>>
>> Cc: stable@vger.kernel.org
>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   drivers/virtio/virtio_ring.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 49299b1f9ec7..7d852811c912 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>   	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>   	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>   
>> -	/* Descriptors and available array need to be set before we expose the
>> -	 * new available array entries. */
>> -	virtio_wmb(vq->weak_barriers);
>> +	/*
>> +	 * Descriptors and available array need to be set before we expose
>> +	 * the new available array entries. virtio_wmb() should be enough
>> +	 * to ensuere the order theoretically. However, a stronger barrier
>> +	 * is needed by ARM64. Otherwise, the stale data can be observed
>> +	 * by the host (vhost). A stronger barrier should work for other
>> +	 * architectures, but performance loss is expected.
>> +	 */
>> +	virtio_mb(false);
> 
> 
> I don't get what is going on here. Any explanation why virtio_wmb is not
> enough besides "it does not work"?
> 

The change is replacing instruction "dmb" with "dsb". "dsb" is stronger barrier
than "dmb" because "dsb" ensures that all memory accesses raised before this
instruction is completed when the 'dsb' instruction completes. However, "dmb"
doesn't guarantee the order of completion of the memory accesses.

So 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
can be completed before 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.
The stronger barrier 'dsb' ensures the completion order as we expected.

     virtio_wmb(true)         virt_mb(false)
       virt_wmb                 mb
         __smp_wmb               __mb
           dmb(ishst)              dsb(sy)
       

Extraced from ARMv9 specificaton
================================
The DMB instruction is a memory barrier instruction that ensures the relative
order of memory accesses before the barrier with memory accesses after the
barrier. The DMB instruction _does not_ ensure the completion of any of the
memory accesses for which it ensures relative order.

A DSB instruction is a memory barrier that ensures that memory accesses that
occur before the DSB instruction have __completed__ before the completion of
the DSB instruction. In doing this, it acts as a stronger barrier than a DMB
and all ordering that is created by a DMB with specific options is also generated
by a DSB with the same options.

>>   	vq->split.avail_idx_shadow++;
>>   	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>>   						vq->split.avail_idx_shadow);
>> -- 
>> 2.44.0
> 

Thanks,
Gavin

