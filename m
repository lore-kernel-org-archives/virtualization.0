Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11116355050
	for <virtualization@lists.linux.dev>; Mon,  9 Mar 2026 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773037185; cv=none; b=Odo6PkRRSqQHaDZPYYc6V278WrsscjbjCa1S/aRQaQ6/QGTm8rEHdnX6LtrF10/rs2Wu/6BcqmMCAbTBPdy+hqb87gXxM+/9fVS7Dg2W7hqrMMb9Fok+q9vKzorgAzFNbs/SyUp4mJ/UZrHXp1fGAdQh4++oPv31hx14uW1hK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773037185; c=relaxed/simple;
	bh=97nMirBjm0UVO/etDPBF9Dov9vOkpZNRytLiCpNLDIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n52+ogSvDKdmsdQkZySpasLjsy2+gWYdTcvPLKJz2meOa9vmglU1JN9s+wdr9lobSkj+tX+C/b15ZDIyew+UB1yZHR5k3v5//dBG7XfK0NZuZ2X9dU763EhduDqRU3lkibwoIwrDS9+YQ1at9+0mVS1S3yrdoLntDTzOnemU9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqpReeip; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqpReeip"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad21f437eeso81042665ad.0
        for <virtualization@lists.linux.dev>; Sun, 08 Mar 2026 23:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773037183; x=1773641983; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mM4k0a0lc5DlaYtJAS2n9qKrU0qPtvvuNJREMuZIIAc=;
        b=TqpReeipFZ9EVLtI0KHcevK+k/8staHih13gDY1fgr6f2Y7SUBz7WgNSssXtLEdRqr
         gA8q8d8PF9Acmm94hO3FL5LEb95XwXRxdCos1hmmIYuPvoezpCXL3jc9UpWyXiSZImqv
         VS+tHvRmN5EfiRd5nXc6K6R7SNNKb/QCkcUT14Srzei1EUkE6fxBstv62NXoakZnA9xb
         /j0TQHU+wRAxkc3zOrwFVwnXcRYkwI84guOAR39YwIhA6KLWRKpN4iE0G1iJpozrKREL
         V5NG7XNM7o4bJvj6AihKEedgu0RVq4iWrsgKIeo7clFp0b0vv/0GYALZLn0hJoDGRG58
         LlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773037183; x=1773641983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mM4k0a0lc5DlaYtJAS2n9qKrU0qPtvvuNJREMuZIIAc=;
        b=ubnqTRvgU9tktvDiRX/wOmmxtHxajVIkN1lqCdfhK1aWHLsRnvVloMo9XJzLjYnAHf
         QNNId4DHHTqSK8t3QGRIBjy4OtLmbMw68fhM9NxviWSx5GnhQl6SxnanSzssovZ402RJ
         1PMqOZOw6Lz0itW9onEUHI9u9dta3o7A0FsKcgUSYbSlqIoi4mdIviGLNkABIjV+/+hh
         O8oyT6UuzTKt7T13oZWGgNWOPd+MAytReyxevsvufr5/NuG3OMTq1J2ROpaC4HpQoZ5U
         rA0xqrYAXmuww7Im2xoxAOXSSx8qSDqpZe92e3dh1AiQG4jMzbA9wI0rKYCTTir6lv+R
         EaJg==
X-Forwarded-Encrypted: i=1; AJvYcCUKzaLPO9rseHUM68S22zZXVgTmG3q7aEeK/NhkJECwOWb3x2Z3w40bYZOTW9raetZ37jOiNepzTTizVskxwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDw/r7I0JMQeTcyZP9QsNdtXQ4dkZuR+bv5biyZxq7eNfUpv0S
	cU61E8Er9lxYbCkjm7hIrREwJoSH65OVJWxY6/UffgtT+dB0+KdLuHlp
X-Gm-Gg: ATEYQzzEynBMAuzxdHjTMToQ44E+OFfAq8s35Ocykj2MRmn0eUl8hQDKogq1zm+dyXQ
	8npCYy1T3engIHCzFeAZZ9clWN8e9Bn7TeuwHDeUiMXKtqqhpMHmZDkut4jPG5p6qd76sjqFqT/
	VFX/sbqQh4euGbw+3It+CCkXmMv1q1CxtSHE5pTR7YxBD82e/2kpfQol+U9WgJrwCsES6mCE5Ps
	fANKo4OqenYYnKBH5hpAdZVksnjraGOCkwyNA7jBaBAh6eFcAGig7Ie+JFmeoFmBjhNTLYCkghu
	tVa27iKZqYSodkGQijQchxvqtlYjNT8+2uF7YGSi0F51EonH1aV7S9AEwyt/s2AMkDDcDAn3GQc
	WhFjYOex3cdVX5gDKjiYmmC0aYEBoUdxnvPx8qh2dbRu9jaLuMiT8NjWE86ecDq7DViaLb+JGQm
	1nBMSoCU6ZYL+l8fVF3Fn1yKf5mgnZVwHWUQOwzSNqtUJQ
X-Received: by 2002:a17:902:e88c:b0:2ae:4ad5:b76c with SMTP id d9443c01a7336-2ae82974b26mr98769165ad.10.1773037183356;
        Sun, 08 Mar 2026 23:19:43 -0700 (PDT)
Received: from [172.20.149.24] ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f783dbsm103991205ad.42.2026.03.08.23.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2026 23:19:42 -0700 (PDT)
Message-ID: <d6161d2e-066e-4d85-bc5a-0129a5f116b8@gmail.com>
Date: Mon, 9 Mar 2026 15:19:39 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: add num_vf callback to virtio_bus
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev
References: <20260309023353.652650-1-yui.washidu@gmail.com>
 <CACGkMEu+fd91yCwmSPNj0fTXw5v3ZON7F4kL_PVUz6TbG-iT4g@mail.gmail.com>
Content-Language: en-US
From: Yui Washizu <yui.washidu@gmail.com>
In-Reply-To: <CACGkMEu+fd91yCwmSPNj0fTXw5v3ZON7F4kL_PVUz6TbG-iT4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/9/2026 12:33 PM, Jason Wang wrote:
> On Mon, Mar 9, 2026 at 10:37 AM Yui Washizu <yui.washidu@gmail.com> wrote:
>> Recent QEMU versions added support for virtio SR-IOV emulation,
>> allowing virtio devices to expose SR-IOV VFs to the guest.
>> However, virtio_bus does not implement the num_vf callback of bus_type,
>> causing dev_num_vf() to return 0 for virtio devices even when
>> SR-IOV VFs are active.
>>
>> net/core/rtnetlink.c calls dev_num_vf(dev->dev.parent) to populate
>> IFLA_NUM_VF and IFLA_VFINFO_LIST
> Patch looks good but,
>
> If I understand correctly, ndo_get_vf_config is needed for
> IFLA_VFINFO_LIST but not implemeted in this patch?

Thank you for your comment.

I submitted this patch because I confirmed
that "ip link show" returns the correct VF IDs with this implementation.

In the current implementation,
I believe there is no information that would need to be referenced 
through IFLA_VFINFO_LIST.
Therefore, I did not include ndo_get_vf_config in this patch,
as it did not seem essential at this stage.

Would it be better to implement IFLA_VFINFO_LIST support together with this?

Regards,


>> in RTM_GETLINK responses.  For a
>> virtio-net device, dev.parent points to the virtio_device, whose bus
>> is virtio_bus.  Without num_vf, SR-IOV VF information is silently
>> omitted from tools that rely on rtnetlink, such as 'ip link show'.
>>
>> Add a num_vf callback that delegates to dev_num_vf(dev->parent),
>> which in turn reaches the underlying transport (pci_bus_type for
>> virtio-pci) where the actual VF count is tracked.  Non-PCI transports
>> are unaffected as dev_num_vf() returns 0 when no num_vf callback is
>> present.
>>
>> Signed-off-by: Yui Washizu <yui.washidu@gmail.com>
>> ---
>>   drivers/virtio/virtio.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 5bdc6b82b30b..299fa83be1d5 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -435,6 +435,14 @@ static void virtio_dev_shutdown(struct device *_d)
>>          dev->config->reset(dev);
>>   }
>>
>> +static int virtio_dev_num_vf(struct device *dev)
>> +{
>> +       struct virtio_device *vdev = dev_to_virtio(dev);
>> +
>> +       return dev_num_vf(vdev->dev.parent);
>> +}
>> +
>> +
>>   static const struct bus_type virtio_bus = {
>>          .name  = "virtio",
>>          .match = virtio_dev_match,
>> @@ -444,6 +452,7 @@ static const struct bus_type virtio_bus = {
>>          .remove = virtio_dev_remove,
>>          .irq_get_affinity = virtio_irq_get_affinity,
>>          .shutdown = virtio_dev_shutdown,
>> +       .num_vf = virtio_dev_num_vf,
>>   };
>>
>>   int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
>> --
>> 2.47.3
>>
> Thanks
>
