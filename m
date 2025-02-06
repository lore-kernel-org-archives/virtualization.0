Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD0237163
	for <virtualization@lists.linux.dev>; Thu,  6 Feb 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738859233; cv=none; b=Q5VhaF+FFffPbrGDopX85mcOwBndXSv5PkMTFQFMSFIaufFYK6YUyDPnHRgPnnmdGeBI1DlKor30cTtPrnZKxbC7vyhs8XTCw4QAmvWK1dLIU8Lz+p7cCN1baUltSPkLvMgskcbJA8rumFJwX6z0kkY/WLxvwXdXPflSRiMs0dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738859233; c=relaxed/simple;
	bh=ftau5nnBcsyM3dzdxcNmsLfZUtbbOzIpxUgWT0DqxlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdrcof2QFOP25avClSNgjfrJIg/rqvKigWv24zxmhz/075yvuX3xnDBjKD24G81d/FUY9xsXNZZ/19Bv4lTCx9qOLphNrLv5ebk85X/JqwW6ltSjRnMDjxdpTHUOGjfJsG0uEYyXRC02Adb4ldGi7PNfQx5w/vM4HvZztMI5DwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+rPFByM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+rPFByM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738859230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ORfSJ3EHGoP5AEVbNbK5PWa+JtoK9YX59lWJj18YO+c=;
	b=O+rPFByMN1P3Oel96Pt6Gxf78uMdOnkj6puXofgXQBT31XTwplA4ywUMgyomL+GlfbeyI+
	8FnVieaHiw3pNBbbFjyJL8UPVRS//7R4q4gjfRTeA2BtugOO1MJFPJ77P/6I0Dw3Bxv940
	EjS0JJUl3ffqoE+G9bv6K941uEf8JVU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-PcYdBL6fPAavoBZVgni1EA-1; Thu, 06 Feb 2025 11:27:09 -0500
X-MC-Unique: PcYdBL6fPAavoBZVgni1EA-1
X-Mimecast-MFC-AGG-ID: PcYdBL6fPAavoBZVgni1EA
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4679d6ef2f9so28345301cf.1
        for <virtualization@lists.linux.dev>; Thu, 06 Feb 2025 08:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738859228; x=1739464028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORfSJ3EHGoP5AEVbNbK5PWa+JtoK9YX59lWJj18YO+c=;
        b=LMiLvdd3xsphvDqH6c7LJFvCmYGK69pegVfQBSl0X95IHKCyx12B7O/9LFT3PtD1Qu
         boYQYBVoJ3EfGh3dCORXfi21I1BTDSvAs0n3cUK6xLK31qkKsxE6FblnyGXDc/Xw6PWu
         XThEV3ZKZhCjSI4o5yV4mdwOYhHVxjaGT5KMmc1joIQKkTKoE/3RYhq9/lsILHEQgQmQ
         6jD5RIozDg3N3GXuxJJMu7heUWzkbx6LfTEijrCtX+8I9MRUCDff5s1rdAVDOqkywXa7
         bVx3u5swrm9BR02Kr2O2I1HdUrO0b4AW3Hn3IkHXZrocrzu0mWHRYm2c+5npvLd3qWgL
         byng==
X-Forwarded-Encrypted: i=1; AJvYcCW3PW5lU8Z/o+A0AgtScCMpSOd8E7cVmT9eOAy15wfQYuPrcm5w4Kzeqq8lvtYR2UspTiVnp/hkSQrsBCDpPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YznQ0jhicX7P3DvadsRCjWor6Cv/9ywaXjEZFJAOHGyA6Llg5Qy
	ZEeR/qLw6iIHnZer9dCvlbAOlvc4BsL5kOf4yLo6tE9SORaEQYvme6YKgGGYj4Fs++yR0URNOXd
	/C3t2MKweF26gUg5XhHuqHEPS4/Cba3t4Oz9JDEfTSHZCiq+64/PaWM8oR2FousoU
X-Gm-Gg: ASbGncsMfZB2ZZfo+5Eb857a1767xryqTceSINqo+tI0ZV2wbAipX/sI0IHrqRxMCkt
	EmSHlT4AptR2ZiaKdZVAls+fSsJIgDWIT0t7tUeEYNRUDa2ggORclCTW3a4bjA20GLlg9AbFZL7
	A2FlWVg7IUqsFkT7lq5RSYvuaZfl+dn53pY7k00qTYGr6efMIDisG4Bt30D8x4hFXKeczKRpKB1
	YMlYIScns8icqUD9yZ4b8Q9uDVDHrAE379jufLJpn2qNYXFoE0/UWNxfuxkAynOfaLxMMxr5+A4
	dBWtAJOfR1zGyv1pjWme/7PpWt+yW+XcOCgdFU3Qay/uvDc=
X-Received: by 2002:a05:622a:1a90:b0:467:492b:617f with SMTP id d75a77b69052e-4702822e385mr86446201cf.40.1738859228502;
        Thu, 06 Feb 2025 08:27:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvcgibIGM8aGZG9wg0yw8o0j+eeVyK5m/Jf0cgWT4wBzwtzyrqOC36QaaH6GdJ23Q2Y15NDw==
X-Received: by 2002:a05:622a:1a90:b0:467:492b:617f with SMTP id d75a77b69052e-4702822e385mr86445801cf.40.1738859228043;
        Thu, 06 Feb 2025 08:27:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153bc6ba7sm6648641cf.61.2025.02.06.08.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 08:27:07 -0800 (PST)
Message-ID: <91f6b468-e851-4817-bb51-869a8ee8654f@redhat.com>
Date: Thu, 6 Feb 2025 17:27:04 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Hongyu Ning <hongyu.ning@linux.intel.com>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
 <20250203094700-mutt-send-email-mst@kernel.org>
 <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com>
 <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
 <pnpkqz6keacwz4myydc6aak6gkdmomqn2lo376przlhb3mscsq@tdsfxwb2ujpk>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <pnpkqz6keacwz4myydc6aak6gkdmomqn2lo376przlhb3mscsq@tdsfxwb2ujpk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VGdZOuDPnMOpc21SwOEh2zSdE5ShxsDkWITTEA0K9G4_1738859228
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/25 11:04 AM, Kirill A. Shutemov wrote:
> On Thu, Feb 06, 2025 at 09:59:58AM +0100, Eric Auger wrote:
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
>>>>>> 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
>>>>>> 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
>>>>>> 	...
>>>>>>
>>>>>> It was traced down to virtio-console. Kexec works fine if virtio-console
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
>>>>> https://lore.kernel.org/all/20250120173339.865681-1-eric.auger@redhat.com/)
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
>>>>>>  drivers/virtio/virtio.c | 10 ++++++++++
>>>>>>  1 file changed, 10 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>>>>> index a9b93e99c23a..6c2f908eb22c 100644
>>>>>> --- a/drivers/virtio/virtio.c
>>>>>> +++ b/drivers/virtio/virtio.c
>>>>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
>>>>>>  	of_node_put(dev->dev.of_node);
>>>>>>  }
>>>>>>  
>>>>>> +static void virtio_dev_shutdown(struct device *_d)
>>>>>> +{
>>>>>> +	struct virtio_device *dev = dev_to_virtio(_d);
>>>>>> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>>>>>> +
>>>>>> +	if (drv && drv->remove)
>>>>>> +		drv->remove(dev);
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
>>>         struct virtio_device *dev = dev_to_virtio(_d);
>>>
>>>         virtio_reset_device(dev);
>>> }
>>>
>>>
>>> and it fixes my issue.
>>>
>>> Kirill, would that fix you issue too?
>> gentle ping.
> 
> I am on vacation this week. Will try to get around to it next week.
OK. Enjoy your vacation!

Eric
> 

