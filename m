Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544CDC001E0
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 14:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8CBD60ECB;
	Mon, 23 Oct 2023 14:30:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8CBD60ECB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BVJbkctK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1AUIrlfgR-vV; Mon, 23 Oct 2023 14:30:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4ADE860B21;
	Mon, 23 Oct 2023 14:30:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4ADE860B21
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BD9EC0071;
	Mon, 23 Oct 2023 14:30:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BA2CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 14:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 474896107A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 14:30:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 474896107A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qONOc56_Q9Tq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 14:30:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7813660B21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 14:30:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7813660B21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698071409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kySDKR+e82Dq0GbnFVXWHHRylAyqPYM5YM7Pq4ou10o=;
 b=BVJbkctKhsmc+wRmZs9X6ey7xungpLo6++pKHPjLKZD5r6Whu8o1wAG7MZeZ37iF7xRw/K
 daReecTVZ4AlJHEZYVX/PEykL6UMgxYtSpGw6Bn+2doZQuG4ypN7RUeW9DGf1EU82KPQXP
 70Y1lVYJwmoYtwpmfnrrolmPlOKyis8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-zr4lo_cINXqpkKP21Qv2bg-1; Mon, 23 Oct 2023 10:29:58 -0400
X-MC-Unique: zr4lo_cINXqpkKP21Qv2bg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-778b25af933so357544985a.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 07:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698071397; x=1698676197;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kySDKR+e82Dq0GbnFVXWHHRylAyqPYM5YM7Pq4ou10o=;
 b=CdS/AUp71htcciNzI2XwxTTAmfiNRZ2CqQbkmaB3vLJ4H5RFn38SStKZj9JYFc6WGO
 m3hvcP52yhKe1p15oUUPysR9lbYvaprY+fQ1fL9VIcAtZ2OarZ4v9eDreYgI9puHjV4P
 UN9aGPCbzlxwBv7RI+1yHLb9ySkp0Xa0IQPVfqkAkky9qK8wx48NpmUxFt4LmHJiuwpV
 qyMPkO1cXx8YDXd3CCNLfLwTH9zFFnqtp8J/z53/i3qf8TsFECm/VtrciErChKm93day
 hBg43ShzgcYZc5kk9KdXbjPJMi0DAQawEFZy3LLsgIHQeKHDnq35LggUvL5zcEtlBfDM
 5ItQ==
X-Gm-Message-State: AOJu0Yx8jLcb2mHjsWUuZV9gJ93UKgQAU27wKDMiGz8jYzZI/0gUmM3X
 +LoXumltskVMrJme3AdrPRH8K7kDMtib6VIbeEQA3XycfMLn3i7kO//I0oSFcMhAXM/CMcJc8Ui
 UEq/sWlPyKubsWs9uO5qxxW5DvnyABpHB890Gpg9n+A==
X-Received: by 2002:a05:620a:c4c:b0:778:b0f5:d4e7 with SMTP id
 u12-20020a05620a0c4c00b00778b0f5d4e7mr8747569qki.46.1698071397506; 
 Mon, 23 Oct 2023 07:29:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoIEdB7iELDRun3hsVSPuymnAKtgjwualgCraxWcYPHJJfqhEETtyAiBCcLGcgIIkq3BUmLg==
X-Received: by 2002:a05:620a:c4c:b0:778:b0f5:d4e7 with SMTP id
 u12-20020a05620a0c4c00b00778b0f5d4e7mr8747549qki.46.1698071397203; 
 Mon, 23 Oct 2023 07:29:57 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 k22-20020a05620a143600b00774350813ccsm2736609qkj.118.2023.10.23.07.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 07:29:56 -0700 (PDT)
Date: Mon, 23 Oct 2023 16:29:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandru Matei <alexandru.matei@uipath.com>
Subject: Re: [PATCH v2] vsock/virtio: initialize the_virtio_vsock before
 using VQs
Message-ID: <2tc56vwgs5xwqzfqbv5vud346uzagwtygdhkngdt3wjqaslbmh@zauky5czyfkg>
References: <20231023140833.11206-1-alexandru.matei@uipath.com>
MIME-Version: 1.0
In-Reply-To: <20231023140833.11206-1-alexandru.matei@uipath.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Viorel Canja <viorel.canja@uipath.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mihai Petrisor <mihai.petrisor@uipath.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
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

On Mon, Oct 23, 2023 at 05:08:33PM +0300, Alexandru Matei wrote:
>Once VQs are filled with empty buffers and we kick the host,
>it can send connection requests.  If 'the_virtio_vsock' is not
>initialized before, replies are silently dropped and do not reach the host.
>
>Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
>Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>---
>v2:
>- split virtio_vsock_vqs_init in vqs_init and vqs_fill and moved
>  the_virtio_vsock initialization after vqs_init
>
> net/vmw_vsock/virtio_transport.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..92738d1697c1 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -559,6 +559,11 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	vsock->tx_run = true;
> 	mutex_unlock(&vsock->tx_lock);
>
>+	return 0;
>+}
>+
>+static void virtio_vsock_vqs_fill(struct virtio_vsock *vsock)

What about renaming this function in virtio_vsock_vqs_start() and move 
also the setting of `tx_run` here?

Thanks,
Stefano

>+{
> 	mutex_lock(&vsock->rx_lock);
> 	virtio_vsock_rx_fill(vsock);
> 	vsock->rx_run = true;
>@@ -568,8 +573,6 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	virtio_vsock_event_fill(vsock);
> 	vsock->event_run = true;
> 	mutex_unlock(&vsock->event_lock);
>-
>-	return 0;
> }
>
> static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>@@ -664,6 +667,7 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_fill(vsock);
>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>
>@@ -736,6 +740,7 @@ static int virtio_vsock_restore(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_fill(vsock);
>
> out:
> 	mutex_unlock(&the_virtio_vsock_mutex);
>-- 
>2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
