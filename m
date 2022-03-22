Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D9CC433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 13:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AA7C340B09;
	Tue, 22 Mar 2022 13:36:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7o2_OzOTnjJf; Tue, 22 Mar 2022 13:36:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E3FBD40AEA;
	Tue, 22 Mar 2022 13:36:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 482D9C008F;
	Tue, 22 Mar 2022 13:36:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FD4FC001D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 13:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6EFCD40AFC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 13:36:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PHzuYOO96Ymw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 13:36:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81ED940AEA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 13:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647956182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yEfbx3KDPFlRi9NsR3t9OxuLawKBXpgCccFQfHQvcxA=;
 b=fhVhWJdi7t+P3dAoMoFXxeZdkO+IeM/DwwB//pOR9kI4TesLtrwiVeWjJgg5qcYGn1MPxg
 1OUuKCURqa5TPoYZS5ppB7SbUmGKRYmCosOlaGLNofwc4Yo94jo5gJsRTzBApFIsW9WSIa
 8yYZKSAmOzkEbgvaGI+Pf89b3aUhZa8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-NR9vMJXeMJCHe3nlZK9NGQ-1; Tue, 22 Mar 2022 09:36:20 -0400
X-MC-Unique: NR9vMJXeMJCHe3nlZK9NGQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 q185-20020a1c43c2000000b0038c9d85915bso2787627wma.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yEfbx3KDPFlRi9NsR3t9OxuLawKBXpgCccFQfHQvcxA=;
 b=Iw5a90uc0VI33oXVU+tk3GHBJXa/MD1OAOOnSmre6AEGlhMiGWK7xyr6LJoZC/+C7E
 BFEI34yPzrVNXNNlZFs7jxm2IF6Pob1XuftI7onW0NlCmFYgYQiiFut3kqBwvkle57rd
 GjpYONc7SxRRKROsPGDQgv+3uf2B2wyXwqXa8zsHQcCLf1TVWvGfe6/AAz3KHhFL8Ap8
 Q1rkSuR0ls3GZsqGC/T42MS8jU9RlWfXcHIVqNFS+u3BEGQZwAoovfW06wt3mG5PME11
 048czXmLbJDSMCBl2Uk05DaelHIKMPpGo4JPiOy0CzFtIvOMjpwxXvPAeXR4D4KbfDfu
 M7Cw==
X-Gm-Message-State: AOAM533trgxrcrz3nMPbqjLs7aLbIw0ynP75+OtTbau+3nm/EEPDHSzG
 MPrMp1M3prJRN7xrAIV79jeRZUTXwy7c1xEG0DovMlHHxe/LYvMlQ6vjNrLIFZJaEn9Sm3awvGA
 YUuLoTmE7VeA23fBRVwuvzrlbogGIDf/0W7H058C2eA==
X-Received: by 2002:a5d:5982:0:b0:204:1b19:40da with SMTP id
 n2-20020a5d5982000000b002041b1940damr6150031wri.23.1647956179335; 
 Tue, 22 Mar 2022 06:36:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt2WiiDuMgW7o4aI8TTeUozv/0SKfKOVFu6npOXGitY0mPpGVzP8XK+kXs7cco7hBpouXLOw==
X-Received: by 2002:a5d:5982:0:b0:204:1b19:40da with SMTP id
 n2-20020a5d5982000000b002041b1940damr6150004wri.23.1647956179070; 
 Tue, 22 Mar 2022 06:36:19 -0700 (PDT)
Received: from redhat.com ([2.55.132.0]) by smtp.gmail.com with ESMTPSA id
 q14-20020a1cf30e000000b0038986a18ec8sm1910031wmq.46.2022.03.22.06.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 06:36:18 -0700 (PDT)
Date: Tue, 22 Mar 2022 09:36:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: enable VQs early on probe
Message-ID: <20220322092723-mutt-send-email-mst@kernel.org>
References: <20220322103823.83411-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220322103823.83411-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Asias He <asias@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Mar 22, 2022 at 11:38:23AM +0100, Stefano Garzarella wrote:
> virtio spec requires drivers to set DRIVER_OK before using VQs.
> This is set automatically after probe returns, but virtio-vsock
> driver uses VQs in the probe function to fill rx and event VQs
> with new buffers.


So this is a spec violation. absolutely.

> Let's fix this, calling virtio_device_ready() before using VQs
> in the probe function.
> 
> Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 5afc194a58bb..b1962f8cd502 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -622,6 +622,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>  	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
>  	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
>  
> +	virtio_device_ready(vdev);
> +
>  	mutex_lock(&vsock->tx_lock);
>  	vsock->tx_run = true;
>  	mutex_unlock(&vsock->tx_lock);

Here's the whole code snippet:


        mutex_lock(&vsock->tx_lock);
        vsock->tx_run = true;
        mutex_unlock(&vsock->tx_lock);

        mutex_lock(&vsock->rx_lock);
        virtio_vsock_rx_fill(vsock);
        vsock->rx_run = true;
        mutex_unlock(&vsock->rx_lock);

        mutex_lock(&vsock->event_lock);
        virtio_vsock_event_fill(vsock);
        vsock->event_run = true;
        mutex_unlock(&vsock->event_lock);

        if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
                vsock->seqpacket_allow = true;

        vdev->priv = vsock;
        rcu_assign_pointer(the_virtio_vsock, vsock);

        mutex_unlock(&the_virtio_vsock_mutex);


I worry that this is not the only problem here:
seqpacket_allow and setting of vdev->priv at least after
device is active look suspicious.
E.g.:

static void virtio_vsock_event_done(struct virtqueue *vq)
{
        struct virtio_vsock *vsock = vq->vdev->priv;

        if (!vsock)
                return;
        queue_work(virtio_vsock_workqueue, &vsock->event_work);
}

looks like it will miss events now they will be reported earlier.
One might say that since vq has been kicked it might send
interrupts earlier too so not a new problem, but
there's a chance device actually waits until DRIVER_OK
to start operating.


> -- 
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
