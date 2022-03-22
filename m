Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68434C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 14:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 01C3C40AF6;
	Tue, 22 Mar 2022 14:05:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DleBSYep_fV8; Tue, 22 Mar 2022 14:05:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 476644000B;
	Tue, 22 Mar 2022 14:05:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1771AC0012;
	Tue, 22 Mar 2022 14:05:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7A92C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6FF260E2A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:05:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r3yU62J9Mjsr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:05:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EBF2F60BCC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647957908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWSu3wiWy99oqRDajCtjPLsUAPwXYFjyrn/okc9AKDQ=;
 b=ONW+mvp9oggZT7X+HtAXL/d8Ku/3aSRKt0t15O5X3Yx/3XtgCI4bNxJLGD+JTu+gIrADVd
 020zQJHqym9be7eYrwdzOE8RhBfgYacYLMrXTYnNX9P2vZlK6XpyjexmcgnCAo/iZugxJY
 tsmqMvFWxJa3JaqXfKJCO3yKR3kcRnc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-JSylE-VNOGG7Q9ECHdM_6Q-1; Tue, 22 Mar 2022 10:05:07 -0400
X-MC-Unique: JSylE-VNOGG7Q9ECHdM_6Q-1
Received: by mail-qk1-f197.google.com with SMTP id
 v22-20020a05620a0a9600b0067e87a1ff57so4849564qkg.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 07:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WWSu3wiWy99oqRDajCtjPLsUAPwXYFjyrn/okc9AKDQ=;
 b=bgmDGZ3AmJ6qZ6W8c5pL3tM3Evshbr3027cFq9yCgE68+YccRlp/ptJMnsgzpOG6xC
 UfvPPjU0qMr80dpLt5bm9JwKD9nWX3BFqiYk/eSb8rxY9tYfNjSl4153fvjq/ttODuj5
 kS9S8l6fsTz9ciDwVP85r3payc3LvSxYrS7J5IIs9jc8UCSfpkAHfe+1Jam3ykR6m1Mt
 rOgzVf3DcCI+n90ia4BhiiKxRic75IKlhQM+QeDq9PmeNM5x9r57dX/GF9HaTSX5A4qS
 8uobczlFCvKEmCjI0+3PSkgAHsqua66347bNDPJZMlCoS1htV3WYomh2JBNenC2Lt+qo
 XDiQ==
X-Gm-Message-State: AOAM533yzdd7HgchPnH5Wng+rx13sK95T7dm7+ag9pW0pD+hk4zCYs7t
 INohXGyjD9pCNSAPLwwGaGMzyXhgIriKrtFK8atqF38UMCmM6LnN5arXkxOy7EiTFfIF0W7AHg0
 MjCHzE1iA2r/MRVQOjTd0YRNlcuSV3gYCsaJg8qvo9g==
X-Received: by 2002:a05:6214:e87:b0:441:a5d:681c with SMTP id
 hf7-20020a0562140e8700b004410a5d681cmr12300783qvb.38.1647957907074; 
 Tue, 22 Mar 2022 07:05:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8/P7gBREOiebiPL6hs1ySKYG/JtpPyzM46Q58fFbmK5VNi/3+BC5pcuLrkbzn9AowdZrExg==
X-Received: by 2002:a05:6214:e87:b0:441:a5d:681c with SMTP id
 hf7-20020a0562140e8700b004410a5d681cmr12300737qvb.38.1647957906751; 
 Tue, 22 Mar 2022 07:05:06 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 l8-20020a05622a174800b002e1e3f7d4easm14583649qtk.86.2022.03.22.07.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 07:05:06 -0700 (PDT)
Date: Tue, 22 Mar 2022 15:05:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: enable VQs early on probe
Message-ID: <20220322140500.bn5yrqj5ljckhcdb@sgarzare-redhat>
References: <20220322103823.83411-1-sgarzare@redhat.com>
 <20220322092723-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220322092723-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Tue, Mar 22, 2022 at 09:36:14AM -0400, Michael S. Tsirkin wrote:
>On Tue, Mar 22, 2022 at 11:38:23AM +0100, Stefano Garzarella wrote:
>> virtio spec requires drivers to set DRIVER_OK before using VQs.
>> This is set automatically after probe returns, but virtio-vsock
>> driver uses VQs in the probe function to fill rx and event VQs
>> with new buffers.
>
>
>So this is a spec violation. absolutely.
>
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
>> +
>>  	mutex_lock(&vsock->tx_lock);
>>  	vsock->tx_run = true;
>>  	mutex_unlock(&vsock->tx_lock);
>
>Here's the whole code snippet:
>
>
>        mutex_lock(&vsock->tx_lock);
>        vsock->tx_run = true;
>        mutex_unlock(&vsock->tx_lock);
>
>        mutex_lock(&vsock->rx_lock);
>        virtio_vsock_rx_fill(vsock);
>        vsock->rx_run = true;
>        mutex_unlock(&vsock->rx_lock);
>
>        mutex_lock(&vsock->event_lock);
>        virtio_vsock_event_fill(vsock);
>        vsock->event_run = true;
>        mutex_unlock(&vsock->event_lock);
>
>        if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
>                vsock->seqpacket_allow = true;
>
>        vdev->priv = vsock;
>        rcu_assign_pointer(the_virtio_vsock, vsock);
>
>        mutex_unlock(&the_virtio_vsock_mutex);
>
>
>I worry that this is not the only problem here:
>seqpacket_allow and setting of vdev->priv at least after
>device is active look suspicious.

Right, so if you agree I'll move these before virtio_device_ready().

>E.g.:
>
>static void virtio_vsock_event_done(struct virtqueue *vq)
>{
>        struct virtio_vsock *vsock = vq->vdev->priv;
>
>        if (!vsock)
>                return;
>        queue_work(virtio_vsock_workqueue, &vsock->event_work);
>}
>
>looks like it will miss events now they will be reported earlier.
>One might say that since vq has been kicked it might send
>interrupts earlier too so not a new problem, but
>there's a chance device actually waits until DRIVER_OK
>to start operating.

Yes I see, should I break into 2 patches (one where I move the code 
already present and this one)?

Maybe a single patch is fine since it's the complete solution.

Thank you for the detailed explanation,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
