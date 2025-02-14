Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F721518D
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519826; cv=none; b=gZFKVveesWdVRzdcYLNOoYJ4aBv1oMiT6WNIuB0+Fs83/nkh+DgPLViMbTI0zZ775mHhF6EPiTU3Q559ots7xg3HwGEozQs+B24kSm+b5cRKN3x2J9lyyiTYwkoiQQIHCd1eVcHuaj0LchGdQGfpwW5AgUwFYZh+aGMpMvNJooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519826; c=relaxed/simple;
	bh=RAc3uRNAsAC7KE7UVF0+DQRlceMJza3pY+dhi4K5pyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bytjYA8Wv1G5fg3vK7D4aPRe8y/qIBrMuMO4wyCVpd9O2uopRpX3yZXdBZ48YMsewR7n2LF8Ymsjtml+nlq3n5zv9ad42Yl+wcAUzvIa+Ly871gZjIpoLpYF+wpZfJAK6aVkWc0M10LLEJZfNLfvPXbk7hRpl5it0Gkqb0wz3NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9/wMgDG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9/wMgDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739519823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKdYMg8IBLgDesl4ekVYGz0UCbQcuGuYdL7TKUsf6Dg=;
	b=g9/wMgDGYrdB3xn4BJYgEg93phOuHptIBtpyV3voT8jtYPyh1fcWbfmopt6A+KCwvFNeJg
	8KKoo8qOWPeLPClqMbrE6dSQVu8QLUkIjiZcQYwGmoIg2OQWu+kDlXjQYHiCdf8J2tuUNf
	2c+DoxjZEQq5eGOnaC171dkb5KgOQqk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-35hf_gSJNVOCfN5orOVshw-1; Fri, 14 Feb 2025 02:57:02 -0500
X-MC-Unique: 35hf_gSJNVOCfN5orOVshw-1
X-Mimecast-MFC-AGG-ID: 35hf_gSJNVOCfN5orOVshw_1739519821
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38de11a0002so1840720f8f.3
        for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 23:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739519820; x=1740124620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKdYMg8IBLgDesl4ekVYGz0UCbQcuGuYdL7TKUsf6Dg=;
        b=lifuwq0UwUsS37GGXVIVGzn5twf8qfoTln1iky3G3UCSkP6wSbgzeN8tG4SCsFlaV0
         60lm81LlD3DSTJfD+fvMRgPui2mQIqjQBm1uJfE7Nc25oo8U3Q0owsa0R4f1b1lRbgA+
         4jnSxRtNl38gvVc2iq4//3m4Kt69uVWl7w7M5YLW6c6sKnu97zaTaPWR7T7WZ/c/WNWT
         +lD0gnUufHT/ygM1dVdzsdBh8YmRpOJwm8E+nXAddPAQLL/Y69g+pTDXTNdwU5jAWh1q
         8imcQezldfRESu0o2jp1DZt2RR7yGbObkEkv5ksd1upnMDkrDP6NG14Fny7PUBCDq/O1
         qYdg==
X-Forwarded-Encrypted: i=1; AJvYcCVbZTn4X6uxdrcl19ZAcsrtJkHzM4Ue2eCxrWqg4eTcpyivaJwRsPCjOs5yVwCLoVhN9YSDbP+ZUlQIH3HIIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpUU5mmv62x+JWmsOtWoPcWBsE+3GEHMqUw6P97sTenC511Zlu
	p2DQgAYJDDMuZ8c9TnCI5QZJlJ1oxgh5V8H5XdzMenhaOhhJO4sor7wk8ddsYv2lK542EGMzPFx
	liUN61+0Q6axQJkHxH+hziH7F2Opk0IcxUX0/NURt4sCpG5uKujNd0y18IGCpeYy6i25j4HVV
X-Gm-Gg: ASbGnculD3v9peXXFPZG8VZ9nQzv7qwfWJ1t19TTSVdpnpfk756yrHECCaQHxYrJK/S
	KkKmbfES8UPzQ/uMHglVmh3dgRtkQMODMJnUYQx/elPa3TAOLKke1BJnvthtzB1ycR5BlxE52X9
	OHGhCkp1jKg8jkmMkaxjlWLX7qW3UplcJOWLxN/HkSpEY48Bt7hc85fEtukw8LMurGZdi7bl76i
	1cpF+7rXrVnGLOL4p/CIMnExAjmHCLP5UO7cTqzt2zMtSIrzzezlkQ+qXMkn2znnc1rpMoXGsyf
	EDlYWTvUO87JJx0C2w2pjKUd0N5GuioboMlTGg978S0+Xgo=
X-Received: by 2002:a5d:5f94:0:b0:38e:65d8:b677 with SMTP id ffacd0b85a97d-38e65d8b981mr11978189f8f.33.1739519820357;
        Thu, 13 Feb 2025 23:57:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOwuVtgICUYzs4Eo3Rqa7ms7P6rPt8pmQ2fYQaQ+7uCx21947YDQCKykvrjeflZhpmmFI0Nw==
X-Received: by 2002:a5d:5f94:0:b0:38e:65d8:b677 with SMTP id ffacd0b85a97d-38e65d8b981mr11978161f8f.33.1739519819961;
        Thu, 13 Feb 2025 23:56:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961884251sm36863315e9.31.2025.02.13.23.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 23:56:58 -0800 (PST)
Message-ID: <83b43e73-8599-44ff-8657-6d5f2f9b2de5@redhat.com>
Date: Fri, 14 Feb 2025 08:56:56 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
To: "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
 <20250203094700-mutt-send-email-mst@kernel.org>
 <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com>
 <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
 <90a09ffa-e316-41f0-916b-25635b1d4bc6@linux.intel.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <90a09ffa-e316-41f0-916b-25635b1d4bc6@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lpITt8hVv0YqpSfgIb6hKfRx32vf_OKsdWfafcWd2Fg_1739519821
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2/14/25 8:21 AM, Ning, Hongyu wrote:
> 
> 
> On 2025/2/6 16:59, Eric Auger wrote:
>> Hi,
>>
>> On 2/4/25 12:46 PM, Eric Auger wrote:
>>> Hi,
>>>
>>> On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
>>>> On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
>>>>> Hi Kirill, Michael
>>>>>
>>>>> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
>>>>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
>>>>>> accesses during the hang.
>>>>>>
>>>>>>     Invalid read at addr 0x102877002, size 2, region '(null)',
>>>>>> reason: rejected
>>>>>>     Invalid write at addr 0x102877A44, size 2, region '(null)',
>>>>>> reason: rejected
>>>>>>     ...
>>>>>>
>>>>>> It was traced down to virtio-console. Kexec works fine if virtio-
>>>>>> console
>>>>>> is not in use.
>>>>>>
>>>>>> Looks like virtio-console continues to write to the MMIO even after
>>>>>> underlying virtio-pci device is removed.
>>>>>>
>>>>>> The problem can be mitigated by removing all virtio devices on virtio
>>>>>> bus shutdown.
>>>>>>
>>>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
>>>>>
>>>>> Gentle ping on that patch that seems to have fallen though the cracks.
>>>>>
>>>>> I think this fix is really needed. I have another test case with a
>>>>> rebooting guest exposed with virtio-net (backed by vhost-net) and
>>>>> viommu. Since there is currently no shutdown for the virtio-net, on
>>>>> reboot, the IOMMU is disabled through the native_machine_shutdown()/
>>>>> x86_platform.iommu_shutdown() while the virtio-net is still alive.
>>>>>
>>>>> Normally device_shutdown() should call virtio-net shutdown before the
>>>>> IOMMU tear down and we wouldn't see any spurious transactions after
>>>>> iommu shutdown.
>>>>>
>>>>> With that fix, the above test case is fixed and I do not see spurious
>>>>> vhost IOTLB miss spurious requests.
>>>>>
>>>>> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
>>>>> IOTLB callbacks when IOMMU gets disabled,
>>>>> https://lore.kernel.org/all/20250120173339.865681-1-
>>>>> eric.auger@redhat.com/)
>>>>>
>>>>>
>>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>>> Tested-by: Eric Auger <eric.auger@redhat.com>
>>>>>
>>>>> Thanks
>>>>>
>>>>> Eric
>>>>>
>>>>>> ---
>>>>>>   drivers/virtio/virtio.c | 10 ++++++++++
>>>>>>   1 file changed, 10 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>>>>> index a9b93e99c23a..6c2f908eb22c 100644
>>>>>> --- a/drivers/virtio/virtio.c
>>>>>> +++ b/drivers/virtio/virtio.c
>>>>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
>>>>>>       of_node_put(dev->dev.of_node);
>>>>>>   }
>>>>>>   +static void virtio_dev_shutdown(struct device *_d)
>>>>>> +{
>>>>>> +    struct virtio_device *dev = dev_to_virtio(_d);
>>>>>> +    struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>>>>>> +
>>>>>> +    if (drv && drv->remove)
>>>>>> +        drv->remove(dev);
>>>>
>>>>
>>>> I am concerned that full remove is a heavyweight operation.
>>>> Do not want to slow down reboots even more.
>>>> How about just doing a reset, instead?
>>>
>>> I tested with
>>>
>>> static void virtio_dev_shutdown(struct device *_d)
>>> {
>>>          struct virtio_device *dev = dev_to_virtio(_d);
>>>
>>>          virtio_reset_device(dev);
>>> }
>>>
>>>
>>> and it fixes my issue.
>>>
>>> Kirill, would that fix you issue too?
> 
> Hi,
> 
> sorry for my late response, I synced with Kirill offline and did a retest.
> 
> The issue is still reproduced on my side, kexec will be stuck in case of
> "console=hvc0" append in kernel cmdline and even with such patch applied.

Thanks for testing!

Michael, it looks like the initial patch from Kyrill is the one that
fixes both issues. virtio_reset_device() usage does not work for the
initial bug report while it works for me. Other ideas?

Thanks

Eric
> 
> my kernel code base is 6.14.0-rc2.
> 
> let me know if any more experiments needed.
> 
> ---
>  drivers/virtio/virtio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index ba37665188b5..f9f885d04763 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -395,6 +395,13 @@ static const struct cpumask
> *virtio_irq_get_affinity(struct device *_d,
>         return dev->config->get_vq_affinity(dev, irq_vec);
>  }
> 
> +static void virtio_dev_shutdown(struct device *_d)
> +{
> +        struct virtio_device *dev = dev_to_virtio(_d);
> +
> +        virtio_reset_device(dev);
> +}
> +
>  static const struct bus_type virtio_bus = {
>         .name  = "virtio",
>         .match = virtio_dev_match,
> @@ -403,6 +410,7 @@ static const struct bus_type virtio_bus = {
>         .probe = virtio_dev_probe,
>         .remove = virtio_dev_remove,
>         .irq_get_affinity = virtio_irq_get_affinity,
> +       .shutdown = virtio_dev_shutdown,
>  };
> 
>  int __register_virtio_driver(struct virtio_driver *driver, struct
> module *owner)
> -- 
> 2.43.0
> 
> 
>> gentle ping.
>>
>> this also fixes another issue with qemu vSMMU + virtio-scsi-pci. With
>> the above addition I get rid of spurious warning in qemu on guest reboot.
>>
>> qemu-system-aarch64: virtio: zero sized buffers are not allowed
>> qemu-system-aarch64: vhost vring error in virtqueue 0: Invalid
>> argument (22)
>>
>> Would you mind if I respin?
>>
>> Thanks
>>
>> Eric
>>
>>
>>
>>
>>>
>>> Thanks
>>>
>>> Eric
>>>>
>>>>>> +}
>>>>>> +
>>>>>>   static const struct bus_type virtio_bus = {
>>>>>>       .name  = "virtio",
>>>>>>       .match = virtio_dev_match,
>>>>>> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
>>>>>>       .uevent = virtio_uevent,
>>>>>>       .probe = virtio_dev_probe,
>>>>>>       .remove = virtio_dev_remove,
>>>>>> +    .shutdown = virtio_dev_shutdown,
>>>>>>   };
>>>>>>     int __register_virtio_driver(struct virtio_driver *driver,
>>>>>> struct module *owner)
>>>>
>>>
>>
> 

