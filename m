Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BFEC4708D
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 12:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0EFD840523;
	Mon,  5 Dec 2022 12:22:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0EFD840523
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dMQDya76
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SJ3kWPitdwfy; Mon,  5 Dec 2022 12:22:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A655E40586;
	Mon,  5 Dec 2022 12:22:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A655E40586
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6555EC0033;
	Mon,  5 Dec 2022 12:22:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 376F7C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 12:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11DB760BDE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 12:22:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11DB760BDE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dMQDya76
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id deK2E7mvJx_E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 12:22:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CB3D605E0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CB3D605E0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670242943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Fpu1oLPXixRs8SXVb53vX2+k8zH4l62xyUnVTqnhLI=;
 b=dMQDya763huKerwxVobS6BeuX5jwLh9sQmd5qcfnPClbwBVx8yBdagBmHsg+b5mbEkJNXc
 K4DK0CEW1n7hWM9c3lSrcmOh0sLluMksnVYL5Mjf2zTMy6DZ/1EjjENFcS/fODCQ66UNxt
 LzdZEWEsm413uh3xEkoGR26459G0584=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-277-pEGnu-_3Mt-HYB3Bsx1yQg-1; Mon, 05 Dec 2022 07:22:22 -0500
X-MC-Unique: pEGnu-_3Mt-HYB3Bsx1yQg-1
Received: by mail-wm1-f72.google.com with SMTP id
 s24-20020a7bc398000000b003d087485a9aso3080664wmj.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 04:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Fpu1oLPXixRs8SXVb53vX2+k8zH4l62xyUnVTqnhLI=;
 b=72aj7xY7vgKKNRfxseizvZ0he4YaY4Xn2ybXY8V6SoDgjyRPHDcuW3gvHyqqyfBuUZ
 JXoS9KtsW1/OOda1IrvzsGAiXaZLPuF1hdUYwJdW6I9psITsw/mD2euT8mL2/TFKumBD
 hSEQY3MJUYNMQTqc4PEyYZsTL5Rk0r1WwBp3MPHKXF08dKCoBbit8xZx1HgPrwnNDQyT
 WLlnyOl6LK7SDV55QFK3ppRydVaa8VPMw3br7P/Ov9xgk/XOXy2mg1beMkixp1Icg4EJ
 V5tOyo0NyEY0EVSQde9vE30kvz0mAMoDeCNlS2TKVdxjOLAYf/fPLtD6LYhv5rQWlFWV
 FIrQ==
X-Gm-Message-State: ANoB5pmDEA6UwiOkoy3o8HRo+uHJgYhnt7aHR0cpq2KVtZH4j70BhokQ
 EXbZ5bNqW1E/dHeoVtTar2OI+h/URVNxF29vmQQnIcwPkpdgckfA1sGtuAEL6EKfZXBfGsQWfsC
 N4sl7DbqzVHq5UkAhfblj99WDVn6uneXy08O/GpYI6w==
X-Received: by 2002:a05:6000:1b86:b0:241:9606:1123 with SMTP id
 r6-20020a0560001b8600b0024196061123mr45199164wru.537.1670242940830; 
 Mon, 05 Dec 2022 04:22:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6lXoHQqNZ83Ji7T4v0uWQIKCS1P748eGLo9Jfj6gSuWt8L17oynW4Eb8SDldK2I9Z85TIOMg==
X-Received: by 2002:a05:6000:1b86:b0:241:9606:1123 with SMTP id
 r6-20020a0560001b8600b0024196061123mr45199150wru.537.1670242940594; 
 Mon, 05 Dec 2022 04:22:20 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 a3-20020adffac3000000b0024245e543absm8823432wrs.88.2022.12.05.04.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Dec 2022 04:22:20 -0800 (PST)
Date: Mon, 5 Dec 2022 13:22:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH v5] virtio/vsock: replace virtio_vsock_pkt with sk_buff
Message-ID: <20221205122214.bky3oxipck4hsqqe@sgarzare-redhat>
References: <20221202173520.10428-1-bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20221202173520.10428-1-bobby.eshleman@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, Krasnov Arseniy <oxffffaa@gmail.com>,
 Jiang Wang <jiang.wang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On Fri, Dec 02, 2022 at 09:35:18AM -0800, Bobby Eshleman wrote:
>This commit changes virtio/vsock to use sk_buff instead of
>virtio_vsock_pkt. Beyond better conforming to other net code, using
>sk_buff allows vsock to use sk_buff-dependent features in the future
>(such as sockmap) and improves throughput.
>
>This patch introduces the following performance changes:
>
>Tool/Config: uperf w/ 64 threads, SOCK_STREAM
>Test Runs: 5, mean of results
>Before: commit 95ec6bce2a0b ("Merge branch 'net-ipa-more-endpoints'")
>
>Test: 64KB, g2h
>Before: 21.63 Gb/s
>After: 25.59 Gb/s (+18%)
>
>Test: 16B, g2h
>Before: 11.86 Mb/s
>After: 17.41 Mb/s (+46%)
>
>Test: 64KB, h2g
>Before: 2.15 Gb/s
>After: 3.6 Gb/s (+67%)
>
>Test: 16B, h2g
>Before: 14.38 Mb/s
>After: 18.43 Mb/s (+28%)
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
>Changes in v5:
>- last_skb instead of skb: last_hdr->len = cpu_to_le32(last_skb->len)

With this issue fixed, I confirm that all the tests passed:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


As pointed out in v4, this is net-next material, so you should use the 
net-next tag and base the patch on the net-next tree:
https://www.kernel.org/doc/html/v6.0/process/maintainer-netdev.html#netdev-faq

I locally applied the patch on net-next and everything is fine, so maybe 
the maintainers can apply it, otherwise you should resend it with the 
right tag.
Ah, in that case I suggest you send it before the next merge window 
opens (I guess next week), because net-next closes and you'll have to 
wait for the next cycle.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
