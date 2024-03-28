Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831718646
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585590; cv=none; b=R1MK8CwPkuG5GDYeA0y8WACUSavlyJQ80XTkx//sOCIQ8v3teQEo1p4y4CXeHqVf8Yd/nX15IrP9VFGWeywZTi5kM/x97jemw6/evzM/ZePANtDwkpjH06Hebh64zDgQSpNU+QNVxq61el6H7vWcEKvPI/WYvHCvSaPZubcVRa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585590; c=relaxed/simple;
	bh=AzUVCPq4alUlr/fy2N4j1Rsho5Dmw2Doq/Njidb3450=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smxm+AarxII+OhIjNF4JSkHMoe/4PdUIpu1DBOdjrb0Y2fg73/NAVsu7xXyer/F2pbuliGYDlgGp4swyQAd9ImvVBMgNG6NijSImNdN1RGhytufSxOG8DghGEz+wRNMmpggsnaIW8UU4PgL77rz4Hs4ALKupEbSOByosegJWe+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHDPLkfw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHDPLkfw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711585588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcBhQV8eVYyeZ5qV8HbQJX0V8TUiJ78zQtrKVfKV7pQ=;
	b=GHDPLkfwMasXKFjyjHwy9Mdn3gTEpM0Oe/jJklIggCNHx5baSTAXFf977E3LxLvspcX6WH
	s9wvLrCflXxBFeKBN40fF9HoHbJqqTR2ysQGRtxF2XyScYIbdYiyERy6wAxyMbd5+T5kZ+
	A8eP9D7usw+9sWnajAN2qk9NQ/2xY0E=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-D81qHv9vOwqwt2udrstGLw-1; Wed, 27 Mar 2024 20:26:24 -0400
X-MC-Unique: D81qHv9vOwqwt2udrstGLw-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6e686728cc6so431946a34.2
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 17:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711585584; x=1712190384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcBhQV8eVYyeZ5qV8HbQJX0V8TUiJ78zQtrKVfKV7pQ=;
        b=X2/LU/3T+p2a4ctQPsJ0RSA3BcL4/Z1OYaigUOSc0vfqMsoz+NWsS7ft0AxJBYNkTW
         kLu0ECt4ae6qXzewnFh17nEFqP/CE6EDUlQqv/dyJTxm6nuI4qqCAKRLeySgFfezt/V0
         11QgHPfpLoWkYpVdNpy4F4YgSr9dRwBF8uRMuFpp8dObBpwYsOjIEr4XXfQSkaosXIL9
         nW5NYd0GFVnQYfFiB4Go/Zj8SrzsH25VlxGvrqJUcGzrJ6QpLc3qApK+szSQPAo2pyl8
         Vom/xZ9igocEaezjTw6NGDRdQXVKDBw7vhsJzAKA5CTWY1y8YNeBsf3mwUd7g5kSPZak
         Sl2w==
X-Gm-Message-State: AOJu0Yw+S/dxLOkKdExXhcOqW6ephDjQMT8fFR7ZPysasEoRP+/WgV0t
	eapfNhjUYFWRa5mZ6heqKIPNBqxuFZpV9dimgcj1dRrzAxRze6rREERGIBm66gpojc5m8Y0+YAm
	UTWob1YCzmPkl9kAx2hgKX4E1oE13eBplajQ4GakX7MBAtbp3pcdEDpqpSua/CasY
X-Received: by 2002:a05:6870:b50e:b0:22a:a1bd:a0a1 with SMTP id v14-20020a056870b50e00b0022aa1bda0a1mr601745oap.4.1711585583771;
        Wed, 27 Mar 2024 17:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfRAKQ/NAhgcVoMJjul2Pg5XivzNL80VVk+rmY3ikeXQxKkAURQV5Zlzcz5wVcxd/eD6lixQ==
X-Received: by 2002:a05:6870:b50e:b0:22a:a1bd:a0a1 with SMTP id v14-20020a056870b50e00b0022aa1bda0a1mr601725oap.4.1711585583451;
        Wed, 27 Mar 2024 17:26:23 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id b7-20020a62cf07000000b006eac433b2casm146099pfg.128.2024.03.27.17.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 17:26:22 -0700 (PDT)
Message-ID: <4d1adff0-b842-4b09-bfe8-02ea62c6c393@redhat.com>
Date: Thu, 28 Mar 2024 10:26:16 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vhost: Add smp_rmb() in vhost_vq_avail_empty()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, davem@davemloft.net, stefanha@redhat.com,
 sgarzare@redhat.com, keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com
References: <20240326233846.1086253-1-gshan@redhat.com>
 <20240326233846.1086253-2-gshan@redhat.com>
 <20240327075940-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240327075940-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 22:07, Michael S. Tsirkin wrote:
> On Wed, Mar 27, 2024 at 09:38:45AM +1000, Gavin Shan wrote:
>> A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
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
>> Add the missed smp_rmb() in vhost_vq_avail_empty(). Note that it
>> should be safe until vq->avail_idx is changed by commit 275bf960ac697
>> ("vhost: better detection of available buffers").
>>
>> Fixes: 275bf960ac697 ("vhost: better detection of available buffers")
>> Cc: <stable@kernel.org> # v4.11+
>> Reported-by: Yihuang Yu <yihyu@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   drivers/vhost/vhost.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 045f666b4f12..00445ab172b3 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2799,9 +2799,18 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>>   	r = vhost_get_avail_idx(vq, &avail_idx);
>>   	if (unlikely(r))
>>   		return false;
>> +
>>   	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>> +	if (vq->avail_idx != vq->last_avail_idx) {
>> +		/* Similar to what's done in vhost_get_vq_desc(), we need
>> +		 * to ensure the available ring entries have been exposed
>> +		 * by guest.
>> +		 */
> 
> A slightly clearer comment:
> 
> /* Since we have updated avail_idx, the following call to
>   * vhost_get_vq_desc will read available ring entries.
>   * Make sure that read happens after the avail_idx read.
>   */
> 
> Pls repost with that, and I will apply.
> 
> Also add suggested-by for will.
> 

Sure, the suggested comments have been included to v3.

> 
>> +		smp_rmb();
>> +		return false;
>> +	}
>>   
>> -	return vq->avail_idx == vq->last_avail_idx;
>> +	return true;
>>   }
>>   EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
> 
> As a follow-up patch, we should clean out code duplication that
> accumulated with 3 places reading avail idx in essentially
> the same way - this duplication is what causes the mess in
> the 1st place.
> 

Yes, nice idea. I've added PATCH[v3 3/3] to improve vhost_get_avail_idx()
to handle the memory barrier since all the callers have the concern.

v3: https://lore.kernel.org/virtualization/20240328002149.1141302-1-gshan@redhat.com/

Thanks,
Gavin

