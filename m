Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DECBCDB47E
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 07:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DF72703E9;
	Fri, 20 Oct 2023 07:23:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DF72703E9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=boX3E520
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xIVSzgLappHW; Fri, 20 Oct 2023 07:23:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC8E3703E5;
	Fri, 20 Oct 2023 07:23:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC8E3703E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB081C0DD2;
	Fri, 20 Oct 2023 07:23:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71D36C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 07:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FDDE4EBDA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 07:23:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3FDDE4EBDA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=boX3E520
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lBKFsIowMSo6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 07:23:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 461B24EBCD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 07:23:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 461B24EBCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697786632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ps48hhG6wzB4Y+L3PoxO3ps+/OQgTevPQsiK41ym/g=;
 b=boX3E5202aZAXdRmwFbt6CiQnnW6ONX26rFDswTli3XzPbCuu8A0nzAaFBtV4bhSrxEwKi
 mfr1igpWI+P+bnHjpaKsYrIs4rBW81PNknSyX+Rx43zOhPzDsNZ52wRC9mNvXpOFjdsF4V
 vYvoemivTzEHxjWhnucN+dRzWWGey18=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270--JVIa43JNKeDPUmHJl75YQ-1; Fri, 20 Oct 2023 03:23:48 -0400
X-MC-Unique: -JVIa43JNKeDPUmHJl75YQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b822f5c156so36686266b.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 00:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697786627; x=1698391427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ps48hhG6wzB4Y+L3PoxO3ps+/OQgTevPQsiK41ym/g=;
 b=BbQhkSyjhAOeYYF+7HOIr1KkD+yd/xKz/aJ198hRQRYOS2vuDfjiqj4nFKUQq12Zei
 ue4VZ1E727Y7t72NozC/FHDFtNnEeRDDuLqJHlFej0jYjqefxO7yoqjCfzyHwRuZVpTc
 6xl1lBAqAxWMgB8K8OmEilZRYgHqrSWatOVc42ri3MEACQr7chSnPWSGups4pKczhsz4
 VAhM+Hf4tpy6UIRPyHCq8mmjjuR9MMtMHMPu9EUOcZzp8wQRfRlIBgLMfcs5tuiz3x3G
 mHiRePbmwvMqqkkilrxxIsfw5jxivywhxDzLr8p/3TX6KIoZMs1j0U20qILSpTnMq+2s
 uhtw==
X-Gm-Message-State: AOJu0YwE4ih1ZjHfpJYsp/kvUiv6VLef425m1ofPGwDyxuk+y7gvtxVB
 UH0pfT9x1b2FvDyHUgTltsfb05fOkORfjxknPAfQ1/uK7GAQxgLZ79tqy2GEoLorYt54uElgGK8
 9MG9WAiVyk3WhoyHTtBq1NWrMDUJJrvvMU2jxrQdINg==
X-Received: by 2002:a17:907:d9f:b0:9bd:d1e8:57f1 with SMTP id
 go31-20020a1709070d9f00b009bdd1e857f1mr730072ejc.50.1697786627592; 
 Fri, 20 Oct 2023 00:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsH0nFxuej6eEPp+AcxKRS1ZQmvLl9sf1mVsowX0cImCTldmzH0B405XVBoNVXTKEyFrRrXA==
X-Received: by 2002:a17:907:d9f:b0:9bd:d1e8:57f1 with SMTP id
 go31-20020a1709070d9f00b009bdd1e857f1mr730049ejc.50.1697786627165; 
 Fri, 20 Oct 2023 00:23:47 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 e27-20020a170906749b00b0097404f4a124sm935380ejl.2.2023.10.20.00.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 00:23:46 -0700 (PDT)
Date: Fri, 20 Oct 2023 09:23:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandru Matei <alexandru.matei@uipath.com>
Subject: Re: [PATCH] vsock: initialize the_virtio_vsock before using VQs
Message-ID: <uidej33c7o5gudvdvq2ggultubangijsuwyl53cmhd2jqrdxbg@2plf2qy4vyqy>
References: <20231018183247.1827-1-alexandru.matei@uipath.com>
 <a5lw3t5uaqoeeu5j3ertyoprgsyxxrsfqawyuqxjkkbsuxjywh@vh7povjz2s2c>
 <f0112021-c664-41ad-981c-08311286bb43@uipath.com>
MIME-Version: 1.0
In-Reply-To: <f0112021-c664-41ad-981c-08311286bb43@uipath.com>
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

On Fri, Oct 20, 2023 at 12:12:04AM +0300, Alexandru Matei wrote:
>On 10/19/2023 11:54 AM, Stefano Garzarella wrote:
>> On Wed, Oct 18, 2023 at 09:32:47PM +0300, Alexandru Matei wrote:
>>> Once VQs are filled with empty buffers and we kick the host, it can send
>>> connection requests. If 'the_virtio_vsock' is not initialized before,
>>> replies are silently dropped and do not reach the host.
>>
>> Are replies really dropped or we just miss the notification?
>>
>> Could the reverse now happen, i.e., the guest wants to send a connection request, finds the pointer assigned but can't use virtqueues because they haven't been initialized yet?
>>
>> Perhaps to avoid your problem, we could just queue vsock->rx_work at the bottom of the probe to see if anything was queued in the meantime.
>>
>> Nit: please use "vsock/virtio" to point out that this problem is of the virtio transport.
>>
>> Thanks,
>> Stefano
>
>The replies are dropped , the scenario goes like this:
>
>  Once rx_run is set to true and rx queue is filled with empty buffers, the host sends a connection request.

Oh, I see now, I thought virtio_transport_rx_work() returned early if 
'the_virtio_vsock' was not set.

>  The request is processed in virtio_transport_recv_pkt(), and since there is no bound socket, it calls virtio_transport_reset_no_sock() which tries to send a reset packet.
>  In virtio_transport_send_pkt() it checks 'the_virtio_vsock' and because it is null it exits with -ENODEV, basically dropping the packet.
>
>I looked on your scenario and there is an issue from the moment we set the_virtio_vsock (in this patch) up until vsock->tx_run is set to TRUE.
>virtio_transport_send_pkt() will queue the packet, but virtio_transport_send_pkt_work() will exit because tx_run is FALSE. This could be fixed by moving rcu_assign_pointer() after tx_run is set to TRUE.
>virtio_transport_cancel_pkt() uses the rx virtqueue once the_virtio_vsock is set, so rcu_assign_pointer() should be moved after virtio_find_vqs() is called.
>
>I think the way to go is to split virtio_vsock_vqs_init() in two: 
>virtio_vsock_vqs_init() and virtio_vsock_vqs_fill(), as Vadim 
>suggested. This should fix all the cases:

Yep, LGTM!

Thank you both for the fix, please send a v2 with this approach!

Stefano

>
>---
> net/vmw_vsock/virtio_transport.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index ad64f403536a..1f95f98ddd3f 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -594,6 +594,11 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	vsock->tx_run = true;
> 	mutex_unlock(&vsock->tx_lock);
>
>+	return 0;
>+}
>+
>+static void virtio_vsock_vqs_fill(struct virtio_vsock *vsock)
>+{
> 	mutex_lock(&vsock->rx_lock);
> 	virtio_vsock_rx_fill(vsock);
> 	vsock->rx_run = true;
>@@ -603,8 +608,6 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	virtio_vsock_event_fill(vsock);
> 	vsock->event_run = true;
> 	mutex_unlock(&vsock->event_lock);
>-
>-	return 0;
> }
>
> static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>@@ -707,6 +710,7 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_fill(vsock);
>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>
>@@ -779,6 +783,7 @@ static int virtio_vsock_restore(struct virtio_device *vdev)
> 		goto out;
>
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	virtio_vsock_vqs_fill(vsock);
>
> out:
> 	mutex_unlock(&the_virtio_vsock_mutex);
>-- 
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
