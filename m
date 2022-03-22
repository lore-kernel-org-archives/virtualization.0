Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7F0C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 14:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2775361212;
	Tue, 22 Mar 2022 14:36:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EMGECtfubwSr; Tue, 22 Mar 2022 14:36:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9BD0E60BB2;
	Tue, 22 Mar 2022 14:36:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68119C001A;
	Tue, 22 Mar 2022 14:36:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4C34C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B31F260F45
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gh628K0-Djk0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:36:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E21D860BB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647959799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dOj1GKJWSWVxdAPCqvgvT1u26bVfFeq3QZ8vKHNzDPY=;
 b=AqnJBH9sZtfoCRD87RqFWsoPSpIhpG1s3AyH7TnayHfTESf+ieb2fIvpU1ucqo9xZNVEdY
 xxABPzf+cuI3rwUfcjDUqOlZdiAIJNd4Z/r+cl6ODLnb3PWUJUbU4YFxoIGBhlgDgUv45e
 lB3blhDxYeMy+TwxQvjg7iC6suol4d0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-eKvJNqD0PAaRtjBspf8Zgg-1; Tue, 22 Mar 2022 10:36:38 -0400
X-MC-Unique: eKvJNqD0PAaRtjBspf8Zgg-1
Received: by mail-qv1-f69.google.com with SMTP id
 w10-20020a05621412ea00b00440d10d2799so13870312qvv.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 07:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dOj1GKJWSWVxdAPCqvgvT1u26bVfFeq3QZ8vKHNzDPY=;
 b=qITAbCdlOQAbsYnjoQ5xLPs57ZDegi9YeeWZt54qwW+IbfyYkW/8L/i24c24CRONzR
 6IkQp29DpaKp8HzWNJawdBVfwYMvt62jBjIhldPMNRs/sVCBJlcwz08eHYgI5FaX8S3H
 AqdLCv/Y6/BLd0K36YB3XrkR0+IkAnJjMEJ0cCLyR47U7zA5FgtNQ6lJHawgO4APVjGf
 juDo2kmwl83QCDxx13S4Idp164fpHQLxmWD/lWTMcLedcSNREAKz94IattOOvBdwuqDp
 PNeg2ZJOwH6K6WZc4O4U3SB00/TQeG25Xi4SUsfb4rxFDV1zzmfMS2RWWtSwoYPABo0O
 kulQ==
X-Gm-Message-State: AOAM533M3Mjbpvm36zQjqVAk6AAGcQWtGTRC0W+BxCyR9W3f3TYI0Dma
 I5Cn1KXG9Cp/Wj2pPMUQa7KXCQcVUGYhZpDQLgMg4TmFLX/Z3ArPEtz2AQ5AgD/WspYnb+wY6AX
 TpYC8JL94JloJFLrsw7iCWWvyoamQHJSW1zTF921XvQ==
X-Received: by 2002:a05:620a:28d2:b0:67e:c956:7ca8 with SMTP id
 l18-20020a05620a28d200b0067ec9567ca8mr471790qkp.683.1647959798186; 
 Tue, 22 Mar 2022 07:36:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXDv4AGOYhcpwZ3iXOsgSE7vB8MlD/bpaFwtt1h5AIpAisGg+eAfZ6KhHHNlDh4AUml/kF1w==
X-Received: by 2002:a05:620a:28d2:b0:67e:c956:7ca8 with SMTP id
 l18-20020a05620a28d200b0067ec9567ca8mr471763qkp.683.1647959797928; 
 Tue, 22 Mar 2022 07:36:37 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 h27-20020a05620a13fb00b0067b3615e4acsm8944129qkl.70.2022.03.22.07.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 07:36:37 -0700 (PDT)
Date: Tue, 22 Mar 2022 15:36:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: enable VQs early on probe
Message-ID: <20220322143631.gt32cshbwyetq2fh@sgarzare-redhat>
References: <20220322103823.83411-1-sgarzare@redhat.com>
 <20220322092723-mutt-send-email-mst@kernel.org>
 <20220322140500.bn5yrqj5ljckhcdb@sgarzare-redhat>
 <20220322100835-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220322100835-mutt-send-email-mst@kernel.org>
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

On Tue, Mar 22, 2022 at 10:09:06AM -0400, Michael S. Tsirkin wrote:
>On Tue, Mar 22, 2022 at 03:05:00PM +0100, Stefano Garzarella wrote:
>> On Tue, Mar 22, 2022 at 09:36:14AM -0400, Michael S. Tsirkin wrote:
>> > On Tue, Mar 22, 2022 at 11:38:23AM +0100, Stefano Garzarella wrote:
>> > > virtio spec requires drivers to set DRIVER_OK before using VQs.
>> > > This is set automatically after probe returns, but virtio-vsock
>> > > driver uses VQs in the probe function to fill rx and event VQs
>> > > with new buffers.
>> >
>> >
>> > So this is a spec violation. absolutely.
>> >
>> > > Let's fix this, calling virtio_device_ready() before using VQs
>> > > in the probe function.
>> > >
>> > > Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
>> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > ---
>> > >  net/vmw_vsock/virtio_transport.c | 2 ++
>> > >  1 file changed, 2 insertions(+)
>> > >
>> > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> > > index 5afc194a58bb..b1962f8cd502 100644
>> > > --- a/net/vmw_vsock/virtio_transport.c
>> > > +++ b/net/vmw_vsock/virtio_transport.c
>> > > @@ -622,6 +622,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>> > >  	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
>> > >  	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
>> > >
>> > > +	virtio_device_ready(vdev);
>> > > +
>> > >  	mutex_lock(&vsock->tx_lock);
>> > >  	vsock->tx_run = true;
>> > >  	mutex_unlock(&vsock->tx_lock);
>> >
>> > Here's the whole code snippet:
>> >
>> >
>> >        mutex_lock(&vsock->tx_lock);
>> >        vsock->tx_run = true;
>> >        mutex_unlock(&vsock->tx_lock);
>> >
>> >        mutex_lock(&vsock->rx_lock);
>> >        virtio_vsock_rx_fill(vsock);
>> >        vsock->rx_run = true;
>> >        mutex_unlock(&vsock->rx_lock);
>> >
>> >        mutex_lock(&vsock->event_lock);
>> >        virtio_vsock_event_fill(vsock);
>> >        vsock->event_run = true;
>> >        mutex_unlock(&vsock->event_lock);
>> >
>> >        if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
>> >                vsock->seqpacket_allow = true;
>> >
>> >        vdev->priv = vsock;
>> >        rcu_assign_pointer(the_virtio_vsock, vsock);
>> >
>> >        mutex_unlock(&the_virtio_vsock_mutex);
>> >
>> >
>> > I worry that this is not the only problem here:
>> > seqpacket_allow and setting of vdev->priv at least after
>> > device is active look suspicious.
>>
>> Right, so if you agree I'll move these before virtio_device_ready().
>>
>> > E.g.:
>> >
>> > static void virtio_vsock_event_done(struct virtqueue *vq)
>> > {
>> >        struct virtio_vsock *vsock = vq->vdev->priv;
>> >
>> >        if (!vsock)
>> >                return;
>> >        queue_work(virtio_vsock_workqueue, &vsock->event_work);
>> > }
>> >
>> > looks like it will miss events now they will be reported earlier.
>> > One might say that since vq has been kicked it might send
>> > interrupts earlier too so not a new problem, but
>> > there's a chance device actually waits until DRIVER_OK
>> > to start operating.
>>
>> Yes I see, should I break into 2 patches (one where I move the code already
>> present and this one)?
>>
>> Maybe a single patch is fine since it's the complete solution.
>>
>> Thank you for the detailed explanation,
>> Stefano
>
>Two I think since movement can be backported to before the hardening
>effort.

Yep, maybe 3 since seqpacket was added later.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
