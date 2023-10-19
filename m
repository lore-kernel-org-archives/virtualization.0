Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09BCCDB483
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 08:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7DB956FB2A;
	Thu, 19 Oct 2023 08:54:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7DB956FB2A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VA6j7/iw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S5eBe0_ZjTgy; Thu, 19 Oct 2023 08:54:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 824F26FA52;
	Thu, 19 Oct 2023 08:54:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 824F26FA52
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57630C0071;
	Thu, 19 Oct 2023 08:54:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AA5CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 08:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 23D87405D7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 08:54:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23D87405D7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VA6j7/iw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0XBu1eNrL3Sq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 08:54:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D87540169
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 08:54:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D87540169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697705671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEAJ+VDUrNVXU5xbHG/3Z3vLqN5pIVSHhZmt7Niw3wo=;
 b=VA6j7/iwFfAzhfArnhTHNLwzwDsBYii3QbT7AK+e/rP2D0ljzTY9qOokd9BQw93yGIzwfF
 0WMBLQla3NShgLS8E1EFGRWX59nwPxcfqJuEB5oyEIGPUFlf3YURqXykpx7ujwpUu3Sx5N
 Vj/UhhAo/KiR96l8y+Zt8uWr8Vx2GRQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-fqk35snhOiSwAJTpa1MK4g-1; Thu, 19 Oct 2023 04:54:29 -0400
X-MC-Unique: fqk35snhOiSwAJTpa1MK4g-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-533d8a785a5so6222783a12.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697705668; x=1698310468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wEAJ+VDUrNVXU5xbHG/3Z3vLqN5pIVSHhZmt7Niw3wo=;
 b=ReTNwVwEnkHW7++sKsQaexZSfWBvAivdXY5Sm842+d3CzWL04fhsmAfwGqFXlynX+C
 Ez/ItWMARWgyEQBiPhfa5eFd6OBqb5cr8PV5G+nqjcf7s6+1BbSygYmYNTy5NJDSGCok
 +oF3QTW/kO15rJZc5+DOCBXVh2Ls/F1J5SYcQE26AddG3iNYOEmMSwDHX1JvDFyKu+aV
 YuvZAtfkWU5dhNHpnnWRYXdYY0hQchlpbIJdQ6UijeRsnx/Iybb8YQSD5vuCfsibnlL/
 ppRI3r4oDQ3UMpv716tPlWcdr+IP/ki2Fu92dJY2wPBknOZiFElRPEAaZRo67JJc6NMj
 +4ew==
X-Gm-Message-State: AOJu0Yzw4zNAwFnZfJqKSZqIve4AqQfK4l4llW1nF4qblyy7rGMs8kvR
 QJc0xxdAI2vfmNrVC9WNt18sI1lmXIYShpqAMjSe8JDHF5RrSzTUzkq9dMsGxKWvur67creuFTC
 DqEG8hFUTWMLQ8wJfJafM//mB6u4NFiC0kjGkCLr8Zg==
X-Received: by 2002:a05:6402:3483:b0:53e:3fce:251 with SMTP id
 v3-20020a056402348300b0053e3fce0251mr1126836edc.0.1697705668241; 
 Thu, 19 Oct 2023 01:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFACpGM/rzsBWnQw0oghgETBEoNMcsod/FUAw+yf7qyqXIbwEBgi5TL8hRsdtikCm2vUW/WVg==
X-Received: by 2002:a05:6402:3483:b0:53e:3fce:251 with SMTP id
 v3-20020a056402348300b0053e3fce0251mr1126810edc.0.1697705667920; 
 Thu, 19 Oct 2023 01:54:27 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 v23-20020a50d597000000b0053e2a64b5f8sm4088664edi.14.2023.10.19.01.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 01:54:27 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:54:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandru Matei <alexandru.matei@uipath.com>
Subject: Re: [PATCH] vsock: initialize the_virtio_vsock before using VQs
Message-ID: <a5lw3t5uaqoeeu5j3ertyoprgsyxxrsfqawyuqxjkkbsuxjywh@vh7povjz2s2c>
References: <20231018183247.1827-1-alexandru.matei@uipath.com>
MIME-Version: 1.0
In-Reply-To: <20231018183247.1827-1-alexandru.matei@uipath.com>
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

On Wed, Oct 18, 2023 at 09:32:47PM +0300, Alexandru Matei wrote:
>Once VQs are filled with empty buffers and we kick the host, it can send
>connection requests. If 'the_virtio_vsock' is not initialized before,
>replies are silently dropped and do not reach the host.

Are replies really dropped or we just miss the notification?

Could the reverse now happen, i.e., the guest wants to send a connection 
request, finds the pointer assigned but can't use virtqueues because 
they haven't been initialized yet?

Perhaps to avoid your problem, we could just queue vsock->rx_work at the 
bottom of the probe to see if anything was queued in the meantime.

Nit: please use "vsock/virtio" to point out that this problem is of the 
virtio transport.

Thanks,
Stefano

>
>Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
>Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>---
> net/vmw_vsock/virtio_transport.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index e95df847176b..eae0867133f8 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -658,12 +658,13 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 		vsock->seqpacket_allow = true;
>
> 	vdev->priv = vsock;
>+	rcu_assign_pointer(the_virtio_vsock, vsock);
>
> 	ret = virtio_vsock_vqs_init(vsock);
>-	if (ret < 0)
>+	if (ret < 0) {
>+		rcu_assign_pointer(the_virtio_vsock, NULL);
> 		goto out;
>-
>-	rcu_assign_pointer(the_virtio_vsock, vsock);
>+	}
>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>
>-- 
>2.34.1
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
