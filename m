Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4778DC433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 07:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFA7D4174B;
	Wed,  9 Nov 2022 07:29:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CFA7D4174B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b/O3GJsj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TWUp52kxzO-t; Wed,  9 Nov 2022 07:29:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AF8E74173E;
	Wed,  9 Nov 2022 07:29:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF8E74173E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9071DC0032;
	Wed,  9 Nov 2022 07:29:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BF0DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 07:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1306360E79
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 07:29:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1306360E79
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b/O3GJsj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VVQD0i6op4At
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 07:29:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DE1F60AED
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DE1F60AED
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 07:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667978972;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdtRIseNPT2+jZuZBXjbMtl4QnJDXpGj49sikX6Ctrg=;
 b=b/O3GJsjV/IUZiyM4/iHG7PXpAmzY3mArGaM17v9NgqcVhZt0uuKJPnNTezoX0bOjIGvcH
 v3EiSTz51h9dJ0nUzydGwu8GjKVR5lQ9UFCyjlVsmoJ6iXHiwNbewSCRjEVEUopknoMwap
 5IC0AAjoI52fK1eLoSEzpHuq5WiuS4w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-RsmzP0Y3OPuDGGpsAhEPOg-1; Wed, 09 Nov 2022 02:29:31 -0500
X-MC-Unique: RsmzP0Y3OPuDGGpsAhEPOg-1
Received: by mail-wm1-f70.google.com with SMTP id
 m17-20020a05600c3b1100b003cf9cc47da5so5650557wms.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 23:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YdtRIseNPT2+jZuZBXjbMtl4QnJDXpGj49sikX6Ctrg=;
 b=ydxTFObUSUjVr8RcBnSFJgLLSJt6ZptMBfz5I5WvpPh0zsayIf56obm3p7mprH1POf
 bChNCvNCp6gZaiiaFv5fiYUkdBS5+dUc0/QqM2YxjYI/CUO8ECrJdJE4whG6vMUvuX9+
 mCLWw/GPJPAX9BaIDjD6N2yb/L+YRFf3tLO9uOJms1kiDhizZfqbM4uVXEvP6wNgVBWl
 KQacitMyxPRVcrtppE2EEDMMJuJ5OkACh7Hz4WokvPKDnIUUhuYU52yIr7/P+YMTc3A7
 cNjvfqQ+RULyM7FsUku6iDKjQiNozYB7MXly6Z/hezT/jkMv8RQpBC5zM3xtA2UYZL/4
 bA3w==
X-Gm-Message-State: ACrzQf07UerVtkG3HO7wOo19m0G/Hwu56tdv3xltrCIlGmhxap45cbxe
 fFql76JI2nGiRTD99FO71/rEYHx+w6qBDmtiP/RqbvFrLl8HShTp3tsjlm6n5KZ02+Zd/1KQ/Vh
 7/XGZyYF3NveGwjVMHEmHOxwpKgYukS4QuHoeVjYc9w==
X-Received: by 2002:a05:6000:1a46:b0:236:9cb4:f2a7 with SMTP id
 t6-20020a0560001a4600b002369cb4f2a7mr37306596wry.141.1667978970229; 
 Tue, 08 Nov 2022 23:29:30 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6lZrksHKbpKvgOL8qujWYkFgNg3u58w4jQeAHHstRZ695iSsZmVkU1mrU0juQJVtjl8RA1Ow==
X-Received: by 2002:a05:6000:1a46:b0:236:9cb4:f2a7 with SMTP id
 t6-20020a0560001a4600b002369cb4f2a7mr37306583wry.141.1667978969917; 
 Tue, 08 Nov 2022 23:29:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 l16-20020adfe590000000b002365cd93d05sm12198397wrm.102.2022.11.08.23.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Nov 2022 23:29:29 -0800 (PST)
Message-ID: <f09c1b91-647e-3547-1914-59a7e785cc95@redhat.com>
Date: Wed, 9 Nov 2022 08:29:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
To: Jason Wang <jasowang@redhat.com>
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
 <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
 <20221107180022-mutt-send-email-mst@kernel.org>
 <CACGkMEsYyH5P2h6XkBgrW4O-xJXxdzzRa1+T2zjJ07OHiYObVA@mail.gmail.com>
 <20221108035142-mutt-send-email-mst@kernel.org>
 <CACGkMEtFhmgKrKwTT8MdQG26wbi20Z5cTn69ycBtE17V+Kupuw@mail.gmail.com>
 <20221108041820-mutt-send-email-mst@kernel.org>
 <7105abc8-85d1-63a4-7f77-a2b3e0177b6f@redhat.com>
 <CACGkMEuX-_+fce_rmc-DsBEfa84d1Kxxe2tE_REae2_JrqBWjw@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CACGkMEuX-_+fce_rmc-DsBEfa84d1Kxxe2tE_REae2_JrqBWjw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hi Jason,

On 11/9/22 04:44, Jason Wang wrote:
> On Tue, Nov 8, 2022 at 6:17 PM Eric Auger <eric.auger@redhat.com> wrote:
>> Hi Michael, Jason,
>>
>> On 11/8/22 10:31, Michael S. Tsirkin wrote:
>>> On Tue, Nov 08, 2022 at 05:13:50PM +0800, Jason Wang wrote:
>>>> On Tue, Nov 8, 2022 at 4:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>> On Tue, Nov 08, 2022 at 11:09:36AM +0800, Jason Wang wrote:
>>>>>> On Tue, Nov 8, 2022 at 7:06 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>> On Mon, Nov 07, 2022 at 10:10:06PM +0100, Eric Auger wrote:
>>>>>>>> Hi Michael,
>>>>>>>> On 11/7/22 21:42, Michael S. Tsirkin wrote:
>>>>>>>>> On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
>>>>>>>>>> When the vhost iotlb is used along with a guest virtual iommu
>>>>>>>>>> and the guest gets rebooted, some MISS messages may have been
>>>>>>>>>> recorded just before the reboot and spuriously executed by
>>>>>>>>>> the virtual iommu after the reboot. Despite the device iotlb gets
>>>>>>>>>> re-initialized, the messages are not cleared. Fix that by calling
>>>>>>>>>> vhost_clear_msg() at the end of vhost_init_device_iotlb().
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>>  drivers/vhost/vhost.c | 1 +
>>>>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>>>>>>>>> index 40097826cff0..422a1fdee0ca 100644
>>>>>>>>>> --- a/drivers/vhost/vhost.c
>>>>>>>>>> +++ b/drivers/vhost/vhost.c
>>>>>>>>>> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
>>>>>>>>>>    }
>>>>>>>>>>
>>>>>>>>>>    vhost_iotlb_free(oiotlb);
>>>>>>>>>> +  vhost_clear_msg(d);
>>>>>>>>>>
>>>>>>>>>>    return 0;
>>>>>>>>>>  }
>>>>>>>>> Hmm.  Can't messages meanwhile get processes and affect the
>>>>>>>>> new iotlb?
>>>>>>>> Isn't the msg processing stopped at the moment this function is called
>>>>>>>> (VHOST_SET_FEATURES)?
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>> Eric
>>>>>>> It's pretty late here I'm not sure.  You tell me what prevents it.
>>>>>> So the proposed code assumes that Qemu doesn't process device IOTLB
>>>>>> before VHOST_SET_FEAETURES. Consider there's no reset in the general
>>>>>> vhost uAPI,  I wonder if it's better to move the clear to device code
>>>>>> like VHOST_NET_SET_BACKEND. So we can clear it per vq?
>>>>> Hmm this makes no sense to me. iommu sits between backend
>>>>> and frontend. Tying one to another is going to backfire.
>>>> I think we need to emulate what real devices are doing. Device should
>>>> clear the page fault message during reset, so the driver won't read
>>>> anything after reset. But we don't have a per device stop or reset
>>>> message for vhost-net. That's why the VHOST_NET_SET_BACKEND came into
>>>> my mind.
>>> That's not a reset message. Userspace can switch backends at will.
>>> I guess we could check when backend is set to -1.
>>> It's a hack but might work.
>>>
>>>>> I'm thinking more along the lines of doing everything
>>>>> under iotlb_lock.
>>>> I think the problem is we need to find a proper place to clear the
>>>> message. So I don't get how iotlb_lock can help: the message could be
>>>> still read from user space after the backend is set to NULL.
>>>>
>>>> Thanks
>>> Well I think the real problem is this.
>>>
>>> vhost_net_set_features does:
>>>
>>>         if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>>>                 if (vhost_init_device_iotlb(&n->dev, true))
>>>                         goto out_unlock;
>>>         }
>>>
>>>
>>> so we get a new iotlb each time features are set.
>>>
>>> But features can be changes while device is running.
>>> E.g.
>>>       VHOST_F_LOG_ALL
>>>
>>>
>>> Let's just say this hack of reusing feature bits for backend
>>> was not my brightest idea :(
>>>
>> Isn't vhost_init_device_iotlb() racy then, as d->iotlb is first updated with niotlb and later d->vqs[i]->iotlb is updated with niotlb. What does garantee this is done atomically?
>>
>> Shouldn't we hold the dev->mutex to make all the sequence atomic and
>> include vhost_clear_msg()?  Can't the vhost_clear_msg() take the dev lock?
> It depends on where we want to place the vhost_clear_msg(), e.g in
> most of the device ioctl, the dev->mutex has been held.

OK, I will double check and respin accordingly

Eric
>
> Thanks
>
>> Thanks
>>
>> Eric
>>
>>>
>>>
>>>>>
>>>>>>> BTW vhost_init_device_iotlb gets enabled parameter but ignores
>>>>>>> it, we really should drop that.
>>>>>> Yes.
>>>>>>
>>>>>>> Also, it looks like if features are set with VIRTIO_F_ACCESS_PLATFORM
>>>>>>> and then cleared, iotlb is not properly cleared - bug?
>>>>>> Not sure, old IOTLB may still work. But for safety, we need to disable
>>>>>> device IOTLB in this case.
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>>>>> --
>>>>>>>>>> 2.37.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
