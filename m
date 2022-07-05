Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B885EC433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 07:11:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 326AE60ECB;
	Tue,  5 Jul 2022 07:11:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 326AE60ECB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GTdd2ECP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bSl-m1q_aLtW; Tue,  5 Jul 2022 07:11:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8123F60A72;
	Tue,  5 Jul 2022 07:11:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8123F60A72
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FBB3C0032;
	Tue,  5 Jul 2022 07:11:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32558C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 07:11:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDDA081D3A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 07:11:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDDA081D3A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GTdd2ECP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aLLjuftGJ2-w
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 07:11:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2694E81D35
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2694E81D35
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657005077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pJXN8MigLI7PutDCLu0w7BuxFejNMyCNinj+kATd3bo=;
 b=GTdd2ECPsGdu0rYFxaXS1rKI4asfWMmjB5Laj5Y9UaIT8pCTx8L3Cyx75fvTtTyNdd70Es
 bv0loXgJNVpVP6+t7n4oBC7Ev0mMDTsDkSgH21NDPq9Y48CLwEeoTVxPA/rg6MHHgMqO1M
 h/bn1PQ4iUoeOk6bh1JFpJo0bXnt91I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-eXuB3GLFPvOGJFwtWSXqrw-1; Tue, 05 Jul 2022 03:11:16 -0400
X-MC-Unique: eXuB3GLFPvOGJFwtWSXqrw-1
Received: by mail-wm1-f72.google.com with SMTP id
 i184-20020a1c3bc1000000b003a026f48333so4903488wma.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jul 2022 00:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pJXN8MigLI7PutDCLu0w7BuxFejNMyCNinj+kATd3bo=;
 b=mor65/j8o0layDd31sExWsAzA+yT6qjbRg94hR0HJfkP+hSOBHBagu1+8N7APxQEWk
 sTbqiUHTwjQ6kMuN4YRwiIhsJ6HnFKOhhOIFubm3Cd0P70Q93cgycBz8vcAaaIZG4eMB
 UcMzXdwRqibiwdAgT+r6Pvoj4bahjR+QvuoDXlx5/FIeGFsPiynQUmaZ6OSUDxxphqna
 NqHUe8iigU1PVxityJLkoeY8RNt41timyfy5hdfGRSYBataquedoetePP6nYmYp4pYPx
 XiP+5uKQmhbbPk/e8xAEAQzCU3zrLZbI9SqIe/C+AQDlcFJmJ/bzhoE2DqdusARXEM+Y
 4uXg==
X-Gm-Message-State: AJIora/a6toiceSns2eB6FGPA5L8zJWtGPBMWBO/B4axJKFo1UbmdY6g
 0+lFF7PoFWq4ukdUNQ34LE4Z2w0goohetcgaNkq8ibkTHIZ/XCw8o4v6B6JjK9hmHcVIWM9n4Vk
 3+0X7nAAi4Q/IizGO0xcPzYSVttIIPMu5pPv+H/PSqg==
X-Received: by 2002:a05:600c:1f0d:b0:3a1:a05c:13c5 with SMTP id
 bd13-20020a05600c1f0d00b003a1a05c13c5mr10501982wmb.146.1657005074500; 
 Tue, 05 Jul 2022 00:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sWjWhrCzGRvoHfRF4VGqhhX94VqJHSrSBXKRmAVO2iCxkXT//j3aoBo3tr1QCnHGg/Q9WPhw==
X-Received: by 2002:a05:600c:1f0d:b0:3a1:a05c:13c5 with SMTP id
 bd13-20020a05600c1f0d00b003a1a05c13c5mr10501966wmb.146.1657005074306; 
 Tue, 05 Jul 2022 00:11:14 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-206.retail.telecomitalia.it.
 [79.46.200.206]) by smtp.gmail.com with ESMTPSA id
 q5-20020adff945000000b0021b9585276dsm31484278wrr.101.2022.07.05.00.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jul 2022 00:11:13 -0700 (PDT)
Date: Tue, 5 Jul 2022 09:11:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 3/6] virtio_test: call __virtio_unbreak_device
Message-ID: <20220705071110.xqerzycco3pziwbk@sgarzare-redhat>
References: <20220704171701.127665-1-sgarzare@redhat.com>
 <20220704171701.127665-4-sgarzare@redhat.com>
 <20220704150450-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220704150450-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Jul 04, 2022 at 03:06:39PM -0400, Michael S. Tsirkin wrote:
>On Mon, Jul 04, 2022 at 07:16:58PM +0200, Stefano Garzarella wrote:
>> Commit 8b4ec69d7e09 ("virtio: harden vring IRQ") initialize vq->broken
>> to true, so we need to call __virtio_unbreak_device() before starting
>> to use it.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>I think this shouldn't be necessary with latest master.

Right, c346dae4f3fb ("virtio: disable notification hardening by default")
is merged now.

I'll remove this patch.

Thanks,
Stefano

>
>> ---
>>  tools/virtio/linux/virtio.h | 2 ++
>>  tools/virtio/virtio_test.c  | 1 +
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
>> index 363b98228301..feb720d4304f 100644
>> --- a/tools/virtio/linux/virtio.h
>> +++ b/tools/virtio/linux/virtio.h
>> @@ -66,4 +66,6 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>>  				      const char *name);
>>  void vring_del_virtqueue(struct virtqueue *vq);
>>
>> +void __virtio_unbreak_device(struct virtio_device *dev);
>> +
>>  #endif
>> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
>> index 23f142af544a..765e64895dab 100644
>> --- a/tools/virtio/virtio_test.c
>> +++ b/tools/virtio/virtio_test.c
>> @@ -177,6 +177,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>>  	long long spurious = 0;
>>  	const bool random_batch = batch == RANDOM_BATCH;
>>
>> +	__virtio_unbreak_device(&dev->vdev);
>>  	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
>>  	assert(r >= 0);
>>  	if (!reset_n) {
>> --
>> 2.36.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
