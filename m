Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B1FC77B73
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 12:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DC1E60DFE;
	Mon,  5 Jun 2023 12:54:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DC1E60DFE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BI5Kdmq5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HkQT4S1pe4Eu; Mon,  5 Jun 2023 12:54:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EBAE060F17;
	Mon,  5 Jun 2023 12:54:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EBAE060F17
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D007AC0087;
	Mon,  5 Jun 2023 12:54:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FCDDC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 12:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D59060E3B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 12:54:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D59060E3B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2KXX4bcZKcSo
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 12:54:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00CFD60DFE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00CFD60DFE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685969669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cllYJg4KX1vPMf9LlRacmMLfsZ/aSYb5fS8F5Fzs6S0=;
 b=BI5Kdmq56EjgQ20pcrSUGAJqCeR838mK1+WHKQ5iDtt2yXoc01uUhS8D3/WjXdXFGuCuEO
 bW3D53dnzWPAW2NRIWComEUtro4806nsp0FgZxkbZfXR2I3QcaLf1JKtsVk6VFV2puijPi
 YhVp0cFTeGFbICLZRr6WmUEWVl9S6AE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-UCu5YnKWNpCGwYKg0JsQUQ-1; Mon, 05 Jun 2023 08:54:29 -0400
X-MC-Unique: UCu5YnKWNpCGwYKg0JsQUQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-626070979faso33904906d6.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jun 2023 05:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969668; x=1688561668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cllYJg4KX1vPMf9LlRacmMLfsZ/aSYb5fS8F5Fzs6S0=;
 b=AN0OKQYdl0r44gE2aeIlZ+mpikQFojBDzfCcE2hixsi/2iS7uo6gMOY85NGJMgR7+n
 QW7sYPie31+zAVkeDqu+3co5eJ640CLUVBEYgUri9zBpebe5RngXDwEQplazk684uVlj
 9McrXgh3H8bgOVv9/zWOcRRoj2i6ChMDYVD2jLoUqkQXxVRwd0mLU5EBIAVelQy59HYB
 5FdbaAaLhIQ2nHckdFpjTFq+0g2/o2ifvi61c8opDf5+Ke0rxL8GMRdpZcIeHyCtbiv3
 hWWWqqFDEB/W5Qm1BuqgWxN4Nrhyw9DLQusGoUq38x5TiMGj0v/W6wFmQgQX8VMbzEIj
 BbmA==
X-Gm-Message-State: AC+VfDyETkT6bGyf4Zo6lYg1tN0GfkQByilLy8OQ+JRqOFj6SKH0oFTT
 b2Tq0IPRIxY3LK4tD7FRjsW6ep1YNiT3fIwuaJVirBZXNJ5n1nG0WMEazMOTngaTHVQ/VnerR+/
 dOaLVtn650UxydYrkssO1EHv1mWTfhPIchRKzzQgtxu13wekklw==
X-Received: by 2002:a05:6214:2aa1:b0:5e9:48da:9938 with SMTP id
 js1-20020a0562142aa100b005e948da9938mr5534969qvb.11.1685969668252; 
 Mon, 05 Jun 2023 05:54:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7evpJje0CVQr5WLMJUrUmM/oUkM2nmAHq9rmpMI832Wdb8hYuY0N9fs0ZUTOPXxOtGPcdxgA==
X-Received: by 2002:a05:6214:2aa1:b0:5e9:48da:9938 with SMTP id
 js1-20020a0562142aa100b005e948da9938mr5534960qvb.11.1685969667992; 
 Mon, 05 Jun 2023 05:54:27 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.106])
 by smtp.gmail.com with ESMTPSA id
 cj21-20020a05622a259500b003f364778b2bsm4715846qtb.4.2023.06.05.05.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 05:54:27 -0700 (PDT)
Date: Mon, 5 Jun 2023 14:54:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <24fjdwp44hovz3d3qkzftmvjie45er3g3boac7aezpvzbwvuol@lmo47ydvnqau>
References: <20230605110644.151211-1-sgarzare@redhat.com>
 <20230605084104-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230605084104-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jun 05, 2023 at 08:41:54AM -0400, Michael S. Tsirkin wrote:
>On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
>> vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
>> don't support packed virtqueue well yet, so let's filter the
>> VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
>>
>> This way, even if the device supports it, we don't risk it being
>> negotiated, then the VMM is unable to set the vring state properly.
>>
>> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>
>> Notes:
>>     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
>>     better PACKED support" series [1] and backported in stable branches.
>>
>>     We can revert it when we are sure that everything is working with
>>     packed virtqueues.
>>
>>     Thanks,
>>     Stefano
>>
>>     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
>
>I'm a bit lost here. So why am I merging "better PACKED support" then?

To really support packed virtqueue with vhost-vdpa, at that point we 
would also have to revert this patch.

I wasn't sure if you wanted to queue the series for this merge window.
In that case do you think it is better to send this patch only for 
stable branches?

>Does this patch make them a NOP?

Yep, after applying the "better PACKED support" series and being sure 
that the IOCTLs of vhost-vdpa support packed virtqueue, we should revert 
this patch.

Let me know if you prefer a different approach.

I'm concerned that QEMU uses vhost-vdpa IOCTLs thinking that the kernel 
interprets them the right way, when it does not.

Thanks,
Stefano

>
>>  drivers/vhost/vdpa.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index 8c1aefc865f0..ac2152135b23 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -397,6 +397,12 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
>>
>>  	features = ops->get_device_features(vdpa);
>>
>> +	/*
>> +	 * IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE) don't support
>> +	 * packed virtqueue well yet, so let's filter the feature for now.
>> +	 */
>> +	features &= ~BIT_ULL(VIRTIO_F_RING_PACKED);
>> +
>>  	if (copy_to_user(featurep, &features, sizeof(features)))
>>  		return -EFAULT;
>>
>>
>> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
>> --
>> 2.40.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
