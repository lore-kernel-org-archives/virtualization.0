Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBA5C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 13:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FFEF403F5;
	Wed, 23 Mar 2022 13:54:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T9bIGFnHYjoY; Wed, 23 Mar 2022 13:54:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F2C26402AF;
	Wed, 23 Mar 2022 13:54:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC208C001A;
	Wed, 23 Mar 2022 13:54:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9665C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:54:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9807C402AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:54:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QAW3wUf8gTuT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:54:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0020D403F5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648043650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PxY8wqYF5UreGCgb86/smuxb7YEIu8E3VvPChOzSsM8=;
 b=H88hJk6nbGiT4ww3DXaFYEJb9sdFugohXVb8c+hHaQ5aYsnE6RFGvt54PSOaCSQtrfqflU
 kZce9QHhdFej3xLy9q11oYECXfBFSbP9QSS/mdvKLoZMAn8Bovs/dso5yphnKgr47MME2Z
 bX9CBNCSTf8lSqUUDYdWAahPFgJIAtY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-1sdXAsIYOviEqr92YEzgng-1; Wed, 23 Mar 2022 09:54:09 -0400
X-MC-Unique: 1sdXAsIYOviEqr92YEzgng-1
Received: by mail-qt1-f197.google.com with SMTP id
 t19-20020ac86a13000000b002e1fd2c4ce5so1219650qtr.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 06:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PxY8wqYF5UreGCgb86/smuxb7YEIu8E3VvPChOzSsM8=;
 b=1YcIzBE/hPC4KVW/8N1IOM2m65Wg0L9Jjxd4EnQC2ZSMHdyiuZLbIDaK/8ANtocuIz
 1Mxdbi6pc5h8YRsko2CMMEMiAtWkbQMNgcJbFXcTQHezOgtJAJpxdaQEAnsm6sLhdZlp
 /oVFjq25US32AtSVDId8bOD1vY8B66DUuEwPzfnicz8B0H+kib3mQu8Z4FtZycTPsP9I
 7dbxN4uWAu7NhONb9BPVM3Lnn6bE6DWRljYMjOqPBwRObDy/RT24ZLKxDk3q3eCH84OC
 ryZuhmW6qF3GSRVGtSB+5HariP5IGGY7ECLlX9bOtzcxej/O0l2MBD1zLIwElZ3mtxYS
 z2og==
X-Gm-Message-State: AOAM533e+AjnjnLe2iaxGHyZa3Zo2v48XJS+cdk6s2DplScOfKCfe6GW
 06YtHOXgizJFJ2P/AZRjjnMmDqq5GM9QZ/qHtlC0LeE4FqMdE3YFaq2m/YbknSOYCTqrDqJpxKC
 yWrdfaX95fGKiHMRDiOJv5YwVhAJhsYCJffDC9jLJsA==
X-Received: by 2002:a05:620a:709:b0:67d:db18:b62b with SMTP id
 9-20020a05620a070900b0067ddb18b62bmr18499628qkc.2.1648043649203; 
 Wed, 23 Mar 2022 06:54:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNKMkeyDL6owOuZq/yQMl0dC0JGNmXAlEIBKsmpJ7pAyWr8mQi6FjWZ/yzv80h7Z6guEaHTQ==
X-Received: by 2002:a05:620a:709:b0:67d:db18:b62b with SMTP id
 9-20020a05620a070900b0067ddb18b62bmr18499620qkc.2.1648043648982; 
 Wed, 23 Mar 2022 06:54:08 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 p10-20020a05620a132a00b0067f926e36b2sm18222qkj.91.2022.03.23.06.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 06:54:08 -0700 (PDT)
Date: Wed, 23 Mar 2022 14:54:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net v2 1/3] vsock/virtio: enable VQs early on probe
Message-ID: <20220323135403.hqhi3pxzgr6rb7qo@sgarzare-redhat>
References: <20220323084954.11769-1-sgarzare@redhat.com>
 <20220323084954.11769-2-sgarzare@redhat.com>
 <YjskSh4PgXuDStAF@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <YjskSh4PgXuDStAF@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Asias He <asias@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Mar 23, 2022 at 01:44:42PM +0000, Stefan Hajnoczi wrote:
>On Wed, Mar 23, 2022 at 09:49:52AM +0100, Stefano Garzarella wrote:
>> virtio spec requires drivers to set DRIVER_OK before using VQs.
>> This is set automatically after probe returns, but virtio-vsock
>> driver uses VQs in the probe function to fill rx and event VQs
>> with new buffers.
>>
>> Let's fix this, calling virtio_device_ready() before using VQs
>> in the probe function.
>>
>> Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  net/vmw_vsock/virtio_transport.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> index 5afc194a58bb..b1962f8cd502 100644
>> --- a/net/vmw_vsock/virtio_transport.c
>> +++ b/net/vmw_vsock/virtio_transport.c
>> @@ -622,6 +622,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>>  	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
>>  	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
>>
>> +	virtio_device_ready(vdev);
>
>Can rx and event virtqueue interrupts be lost if they occur before we
>assign vdev->priv later in virtio_vsock_probe()?

Yep, as Michael suggested I'll fix the patch order in the next version.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
