Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12C9C4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 15:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BAAC4035B;
	Mon, 14 Nov 2022 15:11:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4BAAC4035B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYpnePp4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S6lwBucwzN6p; Mon, 14 Nov 2022 15:11:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E94B4030A;
	Mon, 14 Nov 2022 15:11:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E94B4030A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 171A9C0032;
	Mon, 14 Nov 2022 15:11:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E39D8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 15:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1EDA812D0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 15:11:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1EDA812D0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYpnePp4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OpJwguE4HMJT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 15:11:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7824812AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7824812AF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668438687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d+pdot0+mJYBeC5ZDxgJijt7mCtgiiV6z+4YR5gwxYg=;
 b=DYpnePp4tiLknTIiKFyiY/vv6XRS3J68Ed68qMdAY9y2quyHCmYLeeAD1bfH+gA59XP/Da
 HX5o8gU+vPVrHOwcVI67bE+46MpkS+v/nIJWzHs8Bs8AfXHrBDwauqn/j/2kZn6zGQYbvv
 mr4fg+dtbBUeFB6+IiW0ibrzf+PbLMY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-389-cyCPQsa_OZmkN2d3Rsxgpg-1; Mon, 14 Nov 2022 10:11:25 -0500
X-MC-Unique: cyCPQsa_OZmkN2d3Rsxgpg-1
Received: by mail-qk1-f200.google.com with SMTP id
 bp10-20020a05620a458a00b006fa29f253dcso11256260qkb.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 07:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+pdot0+mJYBeC5ZDxgJijt7mCtgiiV6z+4YR5gwxYg=;
 b=VTJE4we1/0KVMqDD6yQFXO5mjRZZPuVDZJk77cI1CoqVuav/suNhDyQHQyOo40MlC6
 Up+VQq+deoQd3JoFtstawEWuT/gBjSOCkMxzEJVUtPd9eKN9iJuX4yizXDQCRRCH64Yh
 q4ZfJQ14K4KvftAmGy+A828HE5cC5qUFeLfTMSFAVXJ2qBovQlmEHTjUNeS0+19x2Zlu
 gB/aI3w/gxiW2U3XBrp7vEJpMXjwpkQBeKae+YvyGJYn3VbAH/UfB1Kxzj9kVUwt8lHe
 eWglngdIzytLhbJSBpuA6tBlFw4NwqXQObiPV5hu1Tk4FrKTP82z55hNf6xzVsBptsi/
 PwoA==
X-Gm-Message-State: ANoB5plMMO6ssl6CjlGCWYOoHrAirosvxFDIMIeZVi6cekQ8XDb7VkpS
 WhADhd2SkjR+Odn/XMAHB5DS5zp9h4hC6Rgut5dRBUrlMvZdoHC/6PmnI40p8Vb7JUn62GfgJTM
 4L8pAEQUcjVzLrvcFaXcCBygSApiBpr3/QpGwdNxDRg==
X-Received: by 2002:a05:6214:5bc9:b0:49f:8cd3:eaee with SMTP id
 lr9-20020a0562145bc900b0049f8cd3eaeemr12840842qvb.56.1668438685316; 
 Mon, 14 Nov 2022 07:11:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7no97ZrLRX04h0RS4jVHzW30d1xawZi1Yv4WoqReZkcMrTy6YSIC876bMhqPMVK58DZtNi6A==
X-Received: by 2002:a05:6214:5bc9:b0:49f:8cd3:eaee with SMTP id
 lr9-20020a0562145bc900b0049f8cd3eaeemr12840825qvb.56.1668438685082; 
 Mon, 14 Nov 2022 07:11:25 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 s1-20020a05620a0bc100b006faaf6dc55asm6695115qki.22.2022.11.14.07.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Nov 2022 07:11:24 -0800 (PST)
Date: Mon, 14 Nov 2022 16:11:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa_sim: fix vringh initialization in
 vdpasim_queue_ready()
Message-ID: <20221114151111.6ay3ra4shzj3k2lg@sgarzare-redhat>
References: <20221110141335.62171-1-sgarzare@redhat.com>
 <CAJaqyWdvdy2QxuuyPRtfBKtuObrMg_kX_R9hdui+Oh72XtJ7Qw@mail.gmail.com>
 <20221111163007.35kvkodvk6zpimmu@sgarzare-redhat>
 <CAJaqyWfYx+63-hOp0K8fznkyjkScKu6-r8CUPd3eD96oKCHu9A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfYx+63-hOp0K8fznkyjkScKu6-r8CUPd3eD96oKCHu9A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Mon, Nov 14, 2022 at 10:13:51AM +0100, Eugenio Perez Martin wrote:
>On Fri, Nov 11, 2022 at 5:30 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Nov 11, 2022 at 04:40:33PM +0100, Eugenio Perez Martin wrote:
>> >On Thu, Nov 10, 2022 at 3:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> When we initialize vringh, we should pass the features and the
>> >> number of elements in the virtqueue negotiated with the driver,
>> >> otherwise operations with vringh may fail.
>> >>
>> >> This was discovered in a case where the driver sets a number of
>> >> elements in the virtqueue different from the value returned by
>> >> .get_vq_num_max().
>> >>
>> >> In vdpasim_vq_reset() is safe to initialize the vringh with
>> >> default values, since the virtqueue will not be used until
>> >> vdpasim_queue_ready() is called again.
>> >>
>> >> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> ---
>> >>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 +--
>> >>  1 file changed, 1 insertion(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> >> index b071f0d842fb..b20689f8fe89 100644
>> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> >> @@ -67,8 +67,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>> >>  {
>> >>         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>> >>
>> >> -       vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>> >> -                         VDPASIM_QUEUE_MAX, false,
>> >> +       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false,
>> >>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
>> >>                           (struct vring_avail *)
>> >>                           (uintptr_t)vq->driver_addr,
>> >> --
>> >> 2.38.1
>> >>
>> >
>> >I think this is definitely an improvement, but I'd say we should go a
>> >step further and rename VDPASIM_QUEUE_MAX to VDPASIM_QUEUE_DEFAULT. As
>> >you point out in the patch message it is not a max anymore.
>>
>> I'm not sure about renaming since it is the value returned by
>> vdpasim_get_vq_num_max, so IMHO the _MAX suffix is fine.
>
>Oh that's a very good point. But then I guess a conformant driver
>should never set more descriptors than that.

Yep, right!

>
>Would it be convenient to make the default queue size of 32768 and let

Yep, I think it makes sense.

>the guest specify less descriptors than that? Default configuration
>will consume more memory then.

Do you mean for the driver point of view?

Because IIUC in vringh we don't allocate anything related to the queue 
size.

>
>> But I admit that initially I didn't understand whether it's the maximum
>> number of queues or elements, so maybe VDPASIM_VQ_NUM_MAX is better.
>>
>> >
>> >Another thing to note is that we don't have a way to report that
>> >userspace indicated a bad value for queue length. With the current
>> >code vringh will not initialize at all if I'm not wrong, so we should
>> >prevent userspace to put a bad num.
>>
>> Right!
>>
>> >
>> >Ideally, we should repeat the tests of vring_init_kern at
>> >vdpasim_set_vq_num. We could either call it with NULL vring addresses
>> >to check for -EINVAL, or simply repeat the conditional (!num || num >
>> >0xffff || (num & (num - 1))). I'd say the first one is better to not
>> >go out of sync.
>>
>> Or we could do the check in vdpasim_set_vq_ready() and set it not ready
>> if the vq_num is wrong.
>>
>
>Maybe it is the right place to do it, but the device is initiated at
>that point so the driver needs to perform a full reset.
>

Yes, but the driver is misbehaving, so it might be okay to request a 
full reset.

>As a reference, qemu will retain the last valid size set to a vq, or
>the default. This is because it ignores the bad values systematically.
>Not sure what is more conformant actually :).
>

Me too :-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
