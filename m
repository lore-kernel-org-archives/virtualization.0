Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA41C433F5
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CAD2F40283;
	Mon, 22 Nov 2021 07:55:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KY_Ph91FyvrI; Mon, 22 Nov 2021 07:55:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EBE9040154;
	Mon, 22 Nov 2021 07:55:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA733C002E;
	Mon, 22 Nov 2021 07:55:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFC4AC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 07:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DF9040192
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 07:55:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TYZvM7NA_C61
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 07:55:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4531840154
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 07:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637567730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IDqi4ob8fjcAGc/R0j78nG91DfoEGPvFlcWEXhm0JSo=;
 b=isbWOcTIzCSD8Eh6hSHJePHIPJ0BCsgJ9JOupPCMvytau1hlEbEsfYaPefi67cEorUK+st
 a7ZBm6S1vLv5pgPrj4voKdt4W2M06WB+F0h8sfr1akosnNPDFlVx8SP4R3X36ehbSSm46x
 dsHyTHiaDhptQlr4Z1IQWrhgdZZrlBQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-579-0fKp1Ob8MWqV519r6QSvdQ-1; Mon, 22 Nov 2021 02:55:28 -0500
X-MC-Unique: 0fKp1Ob8MWqV519r6QSvdQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 m17-20020aa7d351000000b003e7c0bc8523so14006926edr.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 23:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IDqi4ob8fjcAGc/R0j78nG91DfoEGPvFlcWEXhm0JSo=;
 b=6TFkI+noCf/n4c+GTHpVXZ1sSvPLRfEH4A3kLWg2VevIBtyMHWc7QBT4DDaESX1VVM
 7C5sUJo2Ik/iGPwaMJop32wKt9trN82BHXaNBbzYhOv7fEgXinCXoGN3M1iCXc9f/Sz5
 ts5uA16ksnAXxapVV56A2dZ4o001pGXo2Cn+0MfAan2mUc16SAdRYhKCLJPwzZjSpjBy
 uiuLclNBYUY0iC0ivEo1D8o04SfdJpu3RUDifvl7T3w4gtvV8pM2wCH0OHy3ehGPvRJg
 xRcx4FR+g367ksKdrJWuLA5OmlgslBd2Dq1XvrxOGo/7ryKT5UWo0g6FPFjJCoIk+rpr
 xekg==
X-Gm-Message-State: AOAM532TfMe1WNMlrRB+IWThsa2efNNPEGkcViZqYG/t/XYnirU0RYqK
 9V65HUuEgQH0U0Du3Bb7W1sVe9Pjq8zIVPeR7cF+C/ecQBjZlshKzb+0Zz5rqkr6QDm+09NWX2Z
 o+ip3fvaxloQ8C1qTlIcO3daKx18RcnPmhEWkdZXTUA==
X-Received: by 2002:a17:907:9056:: with SMTP id
 az22mr37649782ejc.107.1637567727774; 
 Sun, 21 Nov 2021 23:55:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxr5Z88UCz2WxnZ+CArseBtRmXEXQUcg3EZRyJJMf+J3roKDaJq3Gzds3ZkXyqietpG3a1qHQ==
X-Received: by 2002:a17:907:9056:: with SMTP id
 az22mr37649761ejc.107.1637567727603; 
 Sun, 21 Nov 2021 23:55:27 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id hp20sm2688651ejc.81.2021.11.21.23.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Nov 2021 23:55:27 -0800 (PST)
Date: Mon, 22 Nov 2021 08:55:24 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211122075524.lzojug4hspzglzhl@steredhat>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kaplan, david" <david.kaplan@amd.com>, mst <mst@redhat.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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

On Mon, Nov 22, 2021 at 02:25:26PM +0800, Jason Wang wrote:
>On Mon, Nov 22, 2021 at 1:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>> On Mon, 22 Nov 2021 06:35:18 +0100
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>> > > I think it should be a common issue, looking at
>> > > vhost_vsock_handle_tx_kick(), it did:
>> > >
>> > > len += sizeof(pkt->hdr);
>> > > vhost_add_used(vq, head, len);
>> > >
>> > > which looks like a violation of the spec since it's TX.
>> >
>> > I'm not sure the lines above look like a violation of the spec. If you
>> > examine vhost_vsock_alloc_pkt() I believe that you will agree that:
>> > len == pkt->len == pkt->hdr.len
>> > which makes sense since according to the spec both tx and rx messages
>> > are hdr+payload. And I believe hdr.len is the size of the payload,
>> > although that does not seem to be properly documented by the spec.
>
>Sorry for being unclear, what I meant is that we probably should use
>zero here. TX doesn't use in buffer actually.
>
>According to the spec, 0 should be the used length:
>
>"and len the total of bytes written into the buffer."
>
>> >
>> > On the other hand tx messages are stated to be device read-only (in the
>> > spec) so if the device writes stuff, that is certainly wrong.
>> >
>
>Yes.
>
>> > If that is what happens.
>> >
>> > Looking at virtqueue_get_buf_ctx_split() I'm not sure that is what
>> > happens. My hypothesis is that we just a last descriptor is an 'in'
>> > type descriptor (i.e. a device writable one). For tx that assumption
>> > would be wrong.
>> >
>> > I will have another look at this today and send a fix patch if my
>> > suspicion is confirmed.
>>
>> If my suspicion is right something like:
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 00f64f2f8b72..efb57898920b 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -764,6 +764,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>>         struct vring_virtqueue *vq = to_vvq(_vq);
>>         void *ret;
>>         unsigned int i;
>> +       bool has_in;
>>         u16 last_used;
>>
>>         START_USE(vq);
>> @@ -787,6 +788,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>>                         vq->split.vring.used->ring[last_used].id);
>>         *len = virtio32_to_cpu(_vq->vdev,
>>                         vq->split.vring.used->ring[last_used].len);
>> +       has_in = virtio16_to_cpu(_vq->vdev,
>> +                       vq->split.vring.used->ring[last_used].flags)
>> +                               & VRING_DESC_F_WRITE;
>
>Did you mean vring.desc actually? If yes, it's better not depend on
>the descriptor ring which can be modified by the device. We've stored
>the flags in desc_extra[].
>
>>
>>         if (unlikely(i >= vq->split.vring.num)) {
>>                 BAD_RING(vq, "id %u out of range\n", i);
>> @@ -796,7 +800,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>>                 BAD_RING(vq, "id %u is not a head!\n", i);
>>                 return NULL;
>>         }
>> -       if (vq->buflen && unlikely(*len > vq->buflen[i])) {
>> +       if (has_in && q->buflen && unlikely(*len > vq->buflen[i])) {
>>                 BAD_RING(vq, "used len %d is larger than in buflen %u\n",
>>                         *len, vq->buflen[i]);
>>                 return NULL;
>>
>> would fix the problem for split. I will try that out and let you know
>> later.
>
>I'm not sure I get this, in virtqueue_add_split, the buflen[i] only
>contains the in buffer length.
>
>I think the fixes are:
>
>1) fixing the vhost vsock

Yep, in vhost_vsock_handle_tx_kick() we should have vhost_add_used(vq, 
head, 0) since the device doesn't write anything.

>2) use suppress_used_validation=true to let vsock driver to validate
>the in buffer length
>3) probably a new feature so the driver can only enable the validation
>when the feature is enabled.

I fully agree with these steps.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
