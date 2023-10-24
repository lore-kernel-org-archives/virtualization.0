Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083F2C00A8F
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 07:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7724342EEB;
	Tue, 24 Oct 2023 07:22:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7724342EEB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VOP7ZdKY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ddPndXeenZta; Tue, 24 Oct 2023 07:22:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 897D94248B;
	Tue, 24 Oct 2023 07:22:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 897D94248B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AB80C0039;
	Tue, 24 Oct 2023 07:22:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9D7CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 07:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2ECF8416F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 07:22:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2ECF8416F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VOP7ZdKY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vrwchI_UYv4O
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 07:22:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E37884160
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 07:22:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E37884160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698132167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rv0SpeFLc8EPDyVFSHvu8ODjo19NeLRxyGY2cziN3BQ=;
 b=VOP7ZdKYocMvqXbyEYvH1Nf9SwC/Vd2Yc/ssNQg3zzlvlWq2AMrXtLlT5W9NrRX7tBBoeD
 CG5xiqao0XPgey+cunthgbfJrpb8DKV5FiK30myG1I0rWVnYnFRA8YZE48pXEMyBKJpJyM
 uN8QOPByg5pdOIijLhzzJz+/o2OFCSQ=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-hh1yAsCXO8i1WU2bkn-ywQ-1; Tue, 24 Oct 2023 03:22:45 -0400
X-MC-Unique: hh1yAsCXO8i1WU2bkn-ywQ-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-457bc611991so1953085137.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 00:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698132165; x=1698736965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rv0SpeFLc8EPDyVFSHvu8ODjo19NeLRxyGY2cziN3BQ=;
 b=d35dSbyfLbcsCfm2osyI5VnqnRa9DHFJWJmNedq7OLRXITCh/++OCKT0bXgy18B7mZ
 KSVFShQMRH3GQB0udaGqo5geWUBH9S0RS0bofDbaMRomZMrgt9czs1p001/ZnHv5fI2q
 SdD3JKKb4aMZ5jCJjLhpwozUlwkcws1GKi96lSmPJ2ff+dSCy27H0R7+0P3bAY+SSXqI
 DIMTEFrFxjDjAVeCAIwPYvLGuQJjL7I76OD9OxSjO5GysAKazZbO4mtYOVuPRNrgWTYV
 iN4rsIQtyfj26VD/NPMrmadz+nw2pGd1EPivUkNc3RgWQ0wdDcTFH/I2mwtKApSI9sZ9
 i6yg==
X-Gm-Message-State: AOJu0YwxHSzs0uaSVKQ1q9tEyyIezVpwxDP7kUXii2OvhaGBA+Bxk7Kz
 BNMBhZN5jyPsV2RMlJQOGcqOzaIwheI1ckQ84jc7yvZcxh6+6FRBI8RsdB3xo59PLCI7g8H8MQY
 Bz3HeyakZ33TxwN6ULNVlcFtQbza6NGziVKYfQ0JmqA==
X-Received: by 2002:a05:6102:2092:b0:450:8e58:2de4 with SMTP id
 h18-20020a056102209200b004508e582de4mr9896264vsr.7.1698132165221; 
 Tue, 24 Oct 2023 00:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSc1UnFRYGpNLAyeRqiE0mbWYzJbU92m3CE1awsD070guqv6X6NuBMOiyw9bpdIyW4han0dA==
X-Received: by 2002:a05:6102:2092:b0:450:8e58:2de4 with SMTP id
 h18-20020a056102209200b004508e582de4mr9896248vsr.7.1698132164898; 
 Tue, 24 Oct 2023 00:22:44 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 g24-20020a37e218000000b007671b599cf5sm3263591qki.40.2023.10.24.00.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:22:44 -0700 (PDT)
Date: Tue, 24 Oct 2023 09:22:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandru Matei <alexandru.matei@uipath.com>
Subject: Re: [PATCH v3] vsock/virtio: initialize the_virtio_vsock before
 using VQs
Message-ID: <iqjmblf2n42w7afw42udxvju3znupmwrixfsbwcn247u7bayoc@zrbken7ls6m7>
References: <20231023192207.1804-1-alexandru.matei@uipath.com>
MIME-Version: 1.0
In-Reply-To: <20231023192207.1804-1-alexandru.matei@uipath.com>
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

On Mon, Oct 23, 2023 at 10:22:07PM +0300, Alexandru Matei wrote:
>Once VQs are filled with empty buffers and we kick the host, it can send
>connection requests. If the_virtio_vsock is not initialized before,
>replies are silently dropped and do not reach the host.
>
>virtio_transport_send_pkt() can queue packets once the_virtio_vsock is
>set, but they won't be processed until vsock->tx_run is set to true. We
>queue vsock->send_pkt_work when initialization finishes to send those
>packets queued earlier.
>
>Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
>Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>---
>v3:
>- renamed vqs_fill to vqs_start and moved tx_run initialization to it
>- queued send_pkt_work at the end of initialization to send packets queued earlier
>v2:
>- split virtio_vsock_vqs_init in vqs_init and vqs_fill and moved
>  the_virtio_vsock initialization after vqs_init
>
> net/vmw_vsock/virtio_transport.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..c0333f9a8002 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -555,6 +555,11 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
>
> 	virtio_device_ready(vdev);
>
>+	return 0;
>+}
>+
>+static void virtio_vsock_vqs_start(struct virtio_vsock *vsock)
>+{
> 	mutex_lock(&vsock->tx_lock);
> 	vsock->tx_run = true;
> 	mutex_unlock(&vsock->tx_lock);
>@@ -568,8 +573,6 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	virtio_vsock_event_fill(vsock);
> 	vsock->event_run = true;
> 	mutex_unlock(&vsock->event_lock);
>-
>-	return 0;
> }
>
> static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>@@ -664,6 +667,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_start(vsock);
>+
>+	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);

I would move this call in virtio_vsock_vqs_start() adding also a comment 
on top, bringing back what you wrote in the commit. Something like this:

         /* virtio_transport_send_pkt() can queue packets once
          * the_virtio_vsock is set, but they won't be processed until
          * vsock->tx_run is set to true. We queue vsock->send_pkt_work
          * when initialization finishes to send those packets queued
          * earlier.
          */

Just as a consideration, we don't need to queue the other workers (rx, 
event) because as long as we don't fill the queues with empty buffers, 
the host can't send us any notification. (We could add it in the comment 
if you want).

The rest LGTM!

Thanks,
Stefano

>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>
>@@ -736,6 +742,9 @@ static int virtio_vsock_restore(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_start(vsock);
>+
>+	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>
> out:
> 	mutex_unlock(&the_virtio_vsock_mutex);
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
