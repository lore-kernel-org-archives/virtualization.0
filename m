Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91399C433F5
	for <virtualization@archiver.kernel.org>; Fri, 29 Apr 2022 07:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0980183FC1;
	Fri, 29 Apr 2022 07:15:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1CIlylES_w1C; Fri, 29 Apr 2022 07:15:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6C8B383F84;
	Fri, 29 Apr 2022 07:15:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CB16C0039;
	Fri, 29 Apr 2022 07:15:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BC12C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 07:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19ADD83FC1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 07:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bKj98i5mQlE0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 07:14:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3503F83F84
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 07:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651216496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bmhVhWxwujManEWb7Tvvt40ys1VYDFgv5QSh1ts7YSs=;
 b=fFIzZnNe8+/lmrsFqQbJJHduIekfgj3NeoTNwWqKIwat0xBQnRK0cvXqgRxsOFXi0snOqw
 2sMHTyjn5Vf6oZ21Y8YS0vHPkMvo0BysB9QX8zEsYZ6/8u0egSoNv5ZIeprBQrZWcHlJcx
 /tETHmQAyUoWvXgGcrOs+T2e2XSd17g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-D2G5xr6pNUSK8nLx3B4ldw-1; Fri, 29 Apr 2022 03:14:54 -0400
X-MC-Unique: D2G5xr6pNUSK8nLx3B4ldw-1
Received: by mail-ej1-f70.google.com with SMTP id
 mp18-20020a1709071b1200b006e7f314ecb3so4082677ejc.23
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 00:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bmhVhWxwujManEWb7Tvvt40ys1VYDFgv5QSh1ts7YSs=;
 b=TyXg3v17D36CWOzj3AqlXwHbwqZ/V4OpIaZ9SnCqg+ATCv0+o59XYGSR3Wy/xDg+JV
 6zR7/GR8VxOvEvI/QnqSG7wtR+kdhXiUs6RE4pvffYHlIVagsi4FCNxMc4/voAGI+a5/
 jGlxISgKrkCDriSl+y3TJqJzj6HGDIYfPRSH/ZS5laZg2sTKNPWLytRjkcdnu9lfUQd6
 LHPrUNBvIa8aLCXQAjmYLQjt6QqvbXGtN3yVWbc3RjwgFPjK8h3dW7eYtRCp+L0tVTzQ
 kZew8dd8gooLDdCAAdiuU+NrN4RdLRuhygQDkdiWca8ROc890D+/Avu+5QgrdY/4QoSW
 wbPA==
X-Gm-Message-State: AOAM530wdz/8opGyGj1DIdtmLTq6ExrX4qQ4NaSVeQdzTAJ7bvah2Y18
 L/Bx4XjTgt6C2YVWPT0PEEZxwYSHMCaQPUCPbitJIj7AjE8nWSWmsqP45nsI8KTd0UUqs0quYmA
 zVUxvhPLPwmRAAxlhZ/sdIqm/4rvAR3eYBr7CXSAJ3g==
X-Received: by 2002:a05:6402:518f:b0:426:25ed:4a2 with SMTP id
 q15-20020a056402518f00b0042625ed04a2mr8255002edd.9.1651216493622; 
 Fri, 29 Apr 2022 00:14:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnz8bMf2XUMgzQMQyMU1WLAZsmiRkEckvQzc3dWSmAMEIfI6u9vul2juptEqaiz0ZzC8QlpQ==
X-Received: by 2002:a05:6402:518f:b0:426:25ed:4a2 with SMTP id
 q15-20020a056402518f00b0042625ed04a2mr8254987edd.9.1651216493364; 
 Fri, 29 Apr 2022 00:14:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-234.retail.telecomitalia.it.
 [87.11.6.234]) by smtp.gmail.com with ESMTPSA id
 og31-20020a1709071ddf00b006f3ef214da2sm364183ejc.8.2022.04.29.00.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Apr 2022 00:14:52 -0700 (PDT)
Date: Fri, 29 Apr 2022 09:14:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
Message-ID: <20220429071449.pycbkk2dvvxmtvay@sgarzare-redhat>
References: <20220428151242.213824-1-sgarzare@redhat.com>
 <CACGkMEv=0VWh_NxhvM+6_TRHEx0f2RGRWbR1n5RhKfq0a7xJUw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv=0VWh_NxhvM+6_TRHEx0f2RGRWbR1n5RhKfq0a7xJUw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Fri, Apr 29, 2022 at 10:46:40AM +0800, Jason Wang wrote:
>On Thu, Apr 28, 2022 at 11:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> The simulator behaves like a ramdisk, so we don't have to do
>> anything when a VIRTIO_BLK_T_FLUSH request is received, but it
>> could be useful to test driver behavior.
>>
>> Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
>> that we support the flush command.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> index 42d401d43911..a6dd1233797c 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> @@ -25,6 +25,7 @@
>>  #define DRV_LICENSE  "GPL v2"
>>
>>  #define VDPASIM_BLK_FEATURES   (VDPASIM_FEATURES | \
>> +                                (1ULL << VIRTIO_BLK_F_FLUSH)    | \
>>                                  (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
>>                                  (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
>>                                  (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
>> @@ -166,6 +167,17 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>>                 pushed += bytes;
>>                 break;
>>
>> +       case VIRTIO_BLK_T_FLUSH:
>> +               if (sector != 0) {
>> +                       dev_err(&vdpasim->vdpa.dev,
>> +                               "A driver MUST set sector to 0 for a VIRTIO_BLK_T_FLUSH request - sector: 0x%llx\n",
>> +                               sector);
>
>If this is something that could be triggered by userspace/guest, then
>we should avoid this.

It can only be triggered by an erratic driver.

I was using the simulator to test a virtio-blk driver that I'm writing 
in userspace and I forgot to set `sector` to zero, so I thought it would 
be useful.

Do you mean to remove the error message?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
