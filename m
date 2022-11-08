Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3341C4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 07:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64AE081401;
	Tue,  8 Nov 2022 07:31:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64AE081401
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XiODdMgq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aS9dBWi7unfa; Tue,  8 Nov 2022 07:31:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C70AB813F2;
	Tue,  8 Nov 2022 07:31:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C70AB813F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80FF3C0033;
	Tue,  8 Nov 2022 07:31:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75B42C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 07:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C926813F3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 07:31:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C926813F3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OxfSYxGuH8Ep
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 07:31:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7578813F2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7578813F2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 07:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667892712;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qMzkFr5wWO2ErYRr9fFrSjmX0hB7P0RxUcl1SJ2pD3Q=;
 b=XiODdMgqvI4rYbrwZO1yOsjiZPBOkPsKltIa6emWzhiDbz6HptmVTXz0zqhAnlbkZLYJVd
 A2MqK7jl3gq0rfc2v36+cpceepRDBsvuVx4SLR/SjHPauNVzWpz4QPrWWf1G+rj7bQ5iN2
 yCbN1V5C9VaoePbWsMF7wsmnQsPhjMg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-483-tQYWWc8EOYKVSzvk4WWFzg-1; Tue, 08 Nov 2022 02:31:51 -0500
X-MC-Unique: tQYWWc8EOYKVSzvk4WWFzg-1
Received: by mail-wm1-f70.google.com with SMTP id
 l42-20020a05600c1d2a00b003cf8e70c1ecso5987197wms.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Nov 2022 23:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qMzkFr5wWO2ErYRr9fFrSjmX0hB7P0RxUcl1SJ2pD3Q=;
 b=BGENwIDfiEfxzrSfl7mlzdCwKzdyNA8MjElqPjqAEcfsPVt2nb+Zna+sIl8Ori3G2p
 O3nWuIxZq6Ioa/xb6UpzlEHxaBQ6OmHd1crmBS+lv5QQatB6TDBelbmXPF2fbkHsDmXk
 lgPUMz3vy2RgbAr7AMrARuQXyzDv0jN6p0soSBGlp7y4y5f8s7cNLnZoHET/piTUG5qp
 w0iYtKimQsfcfg0If2QXtPO0hoMaoY8S9o9DcFGKTXPXU+vIBt+RgLb/BHbm5SNiRplL
 dEnFYjwo57biMFwzDE1kRoaQpt4voPmfC88smFrG1G3W1Cc5SNbbxy9U1Q1S5+hQc7U3
 3OeQ==
X-Gm-Message-State: ANoB5pkbQ7OdsjqMU+sbvdP8sS5JI3Kzbr28JkHYNKKqJYANNB2hd4qx
 y6R4G5aoCyv9eWhL46XDRE1kLXKPGpUVasRGfrEhJym+14bSnopjd4gju80g/lfZH2omTZVFEoJ
 7uHsLDSXCgG9BqO/VU7DGrSOqP2GD24nbHsBRPgSJrw==
X-Received: by 2002:a1c:a1c4:0:b0:3cf:a616:cc8d with SMTP id
 k187-20020a1ca1c4000000b003cfa616cc8dmr8088683wme.62.1667892710087; 
 Mon, 07 Nov 2022 23:31:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5uIx7UmC0fECL2xHHWwwpOMztkaHKJt1L2WyCKzX01NL2l1JGJEX5qifjLTMybc5+Tr12N5A==
X-Received: by 2002:a1c:a1c4:0:b0:3cf:a616:cc8d with SMTP id
 k187-20020a1ca1c4000000b003cfa616cc8dmr8088667wme.62.1667892709861; 
 Mon, 07 Nov 2022 23:31:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a05600c1d8400b003b497138093sm10405740wms.47.2022.11.07.23.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Nov 2022 23:31:49 -0800 (PST)
Message-ID: <c9c0ca0d-d100-c789-dbb8-b308652695e7@redhat.com>
Date: Tue, 8 Nov 2022 08:31:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
 <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org>
 <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eric.auger.pro@gmail.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 11/8/22 04:09, Jason Wang wrote:
> On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
>>> Hi Michael,
>>> On 11/7/22 21:42, Michael S. Tsirkin wrote:
>>>> On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
>>>>> When the vhost iotlb is used along with a guest virtual iommu
>>>>> and the guest gets rebooted, some MISS messages may have been
>>>>> recorded just before the reboot and spuriously executed by
>>>>> the virtual iommu after the reboot. Despite the device iotlb gets
>>>>> re-initialized, the messages are not cleared. Fix that by calling
>>>>> vhost_clear_msg() at the end of vhost_init_device_iotlb().
>>>>>
>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>> ---
>>>>>  drivers/vhost/vhost.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>>>> index 40097826cff0..422a1fdee0ca 100644
>>>>> --- a/drivers/vhost/vhost.c
>>>>> +++ b/drivers/vhost/vhost.c
>>>>> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
>>>>>    }
>>>>>
>>>>>    vhost_iotlb_free(oiotlb);
>>>>> +  vhost_clear_msg(d);
>>>>>
>>>>>    return 0;
>>>>>  }
>>>> Hmm.  Can't messages meanwhile get processes and affect the
>>>> new iotlb?
>>> Isn't the msg processing stopped at the moment this function is called
>>> (VHOST_SET_FEATURES)?
>>>
>>> Thanks
>>>
>>> Eric
>> It's pretty late here I'm not sure.  You tell me what prevents it.
> So the proposed code assumes that Qemu doesn't process device IOTLB
> before VHOST_SET_FEAETURES. Consider there's no reset in the general
> vhost uAPI,  I wonder if it's better to move the clear to device code
> like VHOST_NET_SET_BACKEND. So we can clear it per vq?

OK I will look at this alternative
>
>> BTW vhost_init_device_iotlb gets enabled parameter but ignores
>> it, we really should drop that.
> Yes.
Yes I saw that too. I will send a patch.
>
>> Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
>> and then cleared, iotlb is not properly cleared - bug?
> Not sure, old IOTLB may still work. But for safety, we need to disable
> device IOTLB in this case.
OK

Thanks

Eric
>
> Thanks
>
>>
>>>>
>>>>> --
>>>>> 2.37.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
