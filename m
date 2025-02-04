Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D320C48D
	for <virtualization@lists.linux.dev>; Tue,  4 Feb 2025 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738669617; cv=none; b=CcG8zHo+P0c5hPlM9Gk+U1QH0oKoSC82I5qDElJzo9lxriaWmEPSFkLFSdVzoTbDMPzqGuCrm/P+lZbMLlnlZCs4gKnavSgxoyDdGZjH+1LE3GbJiiAi4+NkRFdLjfEKwA8VahyTukU+hfZrQubGucpNZ0zKuRVpVXJzcpBSz+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738669617; c=relaxed/simple;
	bh=kyCBzsEvksiy34XuPM2mafO6HCLpkjdC6BbFlcWVjDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CeXtydjqVNXiGHYKYUFG+wSZvI5H8Jq9aSC2Irdv7I35TRako0MAMOxQp5UOELihZhrJHJ6/N+TKCcpKQ8hKZMOaGzBy2xZkqy583mZtoknpHD0x8rPsJ+UiW8r+9HUuhIFdX/hJl82DxVkIiiCUg2VZxsXU8omlVAJbA1q/qfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwjzECTg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwjzECTg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738669614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvcDdg7/SVFIqVUEmdXIURYWbEP0dIzrDz3mI0Bb3bY=;
	b=NwjzECTgZc7yiFfMmoBunGatW16DQAgjetzM/6jotbiQ2Xkpt4x5hL9SsKw/tjI3BB8lYq
	ntLohN2xhGyD6Mrz9GgAS5/SsZkqCPEECVldkRz63/1mh+bKw2C84wZ60Ayu2D1is+JE3T
	znSM3/F8eEQW5aR1wfP8qrl3z4+HtEs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-OYI3Hz7aOxWmuG0690--sg-1; Tue, 04 Feb 2025 06:46:50 -0500
X-MC-Unique: OYI3Hz7aOxWmuG0690--sg-1
X-Mimecast-MFC-AGG-ID: OYI3Hz7aOxWmuG0690--sg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436225d4389so28416435e9.1
        for <virtualization@lists.linux.dev>; Tue, 04 Feb 2025 03:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738669609; x=1739274409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvcDdg7/SVFIqVUEmdXIURYWbEP0dIzrDz3mI0Bb3bY=;
        b=iBXZNc2f5jBauZIRfmiebT6NoQN9pnrJ1Z4Rs4fZoKLF60bbCjPKLIL/FzJZbXzsHg
         0igetqCXGtICDrpGw82/vJzfJq89zcdibbCq4Zaa+HADngNCoB8wUolnpM6OjDGuM0Sq
         o//Ido0uQGwuDuujQ3+HFDLVo4IoVT6BawKePP063l+7XL+/8D9iA8J3eaIJfZoK7Qm7
         ZocvZXrp6nGHQoKTO6O1C+tx9X00C0rXQYzgWYyHD1qK9qoLwbm4FQb8pvayEgi0SvOi
         Wi3ezqz+d3b+VOYnRHO7jWGmxRcM6DnhPKobwRyE8qif4nvM5e5BMzpqGcPg2ZZ18l/S
         RZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCXPDuWBIv027RaOyz0TOWJ9altVEjDe3ogfs317fb3IraENSSoS6oX3taXtmZgFOYEr0z0S4vAeK6kwfMTXQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwXEHHaL0kC7ktwELCCTvdXKzmeIXhxFBXZDGJyl0qg1ug6KBR
	xy88uzh9C13X4t8/fVKizm2SaX5Z47MecfNhpBX1PlV/AVl+P2UVWd6LF29K7LSyoWTbDOJ5GQT
	Mr+cAO6jAKdOsqyGyTlwOZ4QClX8QjPY9WhxWVP0HMUHGWNNben6Jx4w19/wIUsl6
X-Gm-Gg: ASbGncsVGbLVBXHWdAy7Cl7E7V3+7ccTRajijDOe+/ggfMpQ7EVIhIlnaZ/PixOba2x
	F79D+nyQIBRasiXHRFzPvhZGRziOeCZFOduYjEpKohmKy6IF/F3nkronxXbQ3vzIckl42qZfus6
	6sQ2zOjfDsh+36SWJgtstTPwjw8vQDLtJFGw5UQqF50yFHrMztyrUKq3UIiDxYfQ3+35qVkuHbJ
	nVY2QLL8nsDRnsLp+di5uSHf7brQectQ4HieSQg+CJComimL0Yfby7CdSrXmd3ULC6I47BYqyGi
	mmNvLtx5d8OLXcO4iapepJMtToJCg8hRzZWx4qCsskyBbew=
X-Received: by 2002:a05:600c:348c:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-43905f2bdb0mr20470725e9.0.1738669608757;
        Tue, 04 Feb 2025 03:46:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeum0PL2xaCZP/ssYUTuxdWNYIr0Cy4p2cLeswu3gbbZgIeYWyXJW1jokFJSibPL23F+FfPA==
X-Received: by 2002:a05:600c:348c:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-43905f2bdb0mr20470475e9.0.1738669608398;
        Tue, 04 Feb 2025 03:46:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c0ec886sm15402597f8f.1.2025.02.04.03.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 03:46:47 -0800 (PST)
Message-ID: <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com>
Date: Tue, 4 Feb 2025 12:46:46 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Hongyu Ning <hongyu.ning@linux.intel.com>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
 <20250203094700-mutt-send-email-mst@kernel.org>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20250203094700-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _4KEOtHUMEgVTMsFCefSQsVfAOajBCbjJ-EsXRhSjTw_1738669609
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
> On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
>> Hi Kirill, Michael
>>
>> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
>>> accesses during the hang.
>>>
>>> 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
>>> 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
>>> 	...
>>>
>>> It was traced down to virtio-console. Kexec works fine if virtio-console
>>> is not in use.
>>>
>>> Looks like virtio-console continues to write to the MMIO even after
>>> underlying virtio-pci device is removed.
>>>
>>> The problem can be mitigated by removing all virtio devices on virtio
>>> bus shutdown.
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
>>
>> Gentle ping on that patch that seems to have fallen though the cracks.
>>
>> I think this fix is really needed. I have another test case with a
>> rebooting guest exposed with virtio-net (backed by vhost-net) and
>> viommu. Since there is currently no shutdown for the virtio-net, on
>> reboot, the IOMMU is disabled through the native_machine_shutdown()/
>> x86_platform.iommu_shutdown() while the virtio-net is still alive.
>>
>> Normally device_shutdown() should call virtio-net shutdown before the
>> IOMMU tear down and we wouldn't see any spurious transactions after
>> iommu shutdown.
>>
>> With that fix, the above test case is fixed and I do not see spurious
>> vhost IOTLB miss spurious requests.
>>
>> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
>> IOTLB callbacks when IOMMU gets disabled,
>> https://lore.kernel.org/all/20250120173339.865681-1-eric.auger@redhat.com/)
>>
>>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Tested-by: Eric Auger <eric.auger@redhat.com>
>>
>> Thanks
>>
>> Eric
>>
>>> ---
>>>  drivers/virtio/virtio.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>> index a9b93e99c23a..6c2f908eb22c 100644
>>> --- a/drivers/virtio/virtio.c
>>> +++ b/drivers/virtio/virtio.c
>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
>>>  	of_node_put(dev->dev.of_node);
>>>  }
>>>  
>>> +static void virtio_dev_shutdown(struct device *_d)
>>> +{
>>> +	struct virtio_device *dev = dev_to_virtio(_d);
>>> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>>> +
>>> +	if (drv && drv->remove)
>>> +		drv->remove(dev);
> 
> 
> I am concerned that full remove is a heavyweight operation.
> Do not want to slow down reboots even more.
> How about just doing a reset, instead?

I tested with

static void virtio_dev_shutdown(struct device *_d)
{
        struct virtio_device *dev = dev_to_virtio(_d);

        virtio_reset_device(dev);
}


and it fixes my issue.

Kirill, would that fix you issue too?

Thanks

Eric
> 
>>> +}
>>> +
>>>  static const struct bus_type virtio_bus = {
>>>  	.name  = "virtio",
>>>  	.match = virtio_dev_match,
>>> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
>>>  	.uevent = virtio_uevent,
>>>  	.probe = virtio_dev_probe,
>>>  	.remove = virtio_dev_remove,
>>> +	.shutdown = virtio_dev_shutdown,
>>>  };
>>>  
>>>  int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
> 

