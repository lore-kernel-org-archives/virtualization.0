Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8346BC4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 10:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16D654029B;
	Tue,  8 Nov 2022 10:34:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16D654029B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RzNqQiRX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hRhH6DrmyOeO; Tue,  8 Nov 2022 10:34:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B297840191;
	Tue,  8 Nov 2022 10:34:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B297840191
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DCAFC0032;
	Tue,  8 Nov 2022 10:34:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA5E5C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D35F80C03
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:34:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D35F80C03
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RzNqQiRX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IKK0m269vERI
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:34:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAA2080BD0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAA2080BD0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667903681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8hI+VXGlNsYpteEY2VwbFWoOIdKQL0RxnupFV92rerk=;
 b=RzNqQiRXe1fckqMf6nP4j8h8amMCiVk48WdMB7L9y8Pq2taJUTamfQ1Cziz4JJAxXfxbFJ
 tM36S7klglKtL868EatEG/Z3DBtQvk9/d8ANpSgLbbPvMX/zls6yR5+aTVAuha/T+zPdGA
 aopM4uaaBDjTFPRxMUklRlP7JJ45tyA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-qyaX1lcuMu2EJGHFfg0ouQ-1; Tue, 08 Nov 2022 05:34:40 -0500
X-MC-Unique: qyaX1lcuMu2EJGHFfg0ouQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 c10-20020a7bc84a000000b003cf81c2d3efso3697235wml.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 02:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8hI+VXGlNsYpteEY2VwbFWoOIdKQL0RxnupFV92rerk=;
 b=BzZ7STtk9DL0efevGPkoatIbNPB8KhUJlun5Q1Kq1IKI1K1iOk4DULtiw5izUraYop
 2QSK8r2zM2caC3sPDwuGq8FXRqt2EsETuf4zoHeNeA57yQzMP8/QnIoPekY1ZhMKy6V8
 hnQy5ABW4SpdJxWzkqDK4H+TUqsnNuZ35FMWkIoMvC8xAjdHim0nMvoiQWy50TUAtzrk
 rFGGMaFZGuW0w2iZBdivK+vQobSB9C3drV6myBx6g0W2Y894Z7UrqGchYCaRQozVSpcJ
 pWLc+ll3lkwUDlWoC4ZWz37rpgG2jKa7lBHZBzKUttEDLfjy2kPSG5aZCE6b6FJTNyte
 Lqsw==
X-Gm-Message-State: ACrzQf3DrtJwR6pFnQAuaWbHfqc8CQtswQ/+oD+o33fiLBiWdRNopjfY
 v75KI8blFx9KZb4Hs0iqmnLoo/v52za6traXdNeo5AJ5WX4hVVhNnBiSPmd7jxoBBnnKwyI4Av6
 7uDSKaGVfKi/9N06nkKM+Ymsj1drQfdNqORviY7O8AqG24UaulniU6vtxykTCnoG6bwUZJrz0p3
 8027nQxdNkUX/z4G11MQ==
X-Received: by 2002:a7b:c3d8:0:b0:3cf:9b7b:b96c with SMTP id
 t24-20020a7bc3d8000000b003cf9b7bb96cmr14185214wmj.113.1667903679479; 
 Tue, 08 Nov 2022 02:34:39 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6RD9d9dmQiyq7sLWytIU3odBHdl1zaUxi78OJvddMLj7UOQAvMCdSY9vUfUFobQvSSZ7B9AA==
X-Received: by 2002:a7b:c3d8:0:b0:3cf:9b7b:b96c with SMTP id
 t24-20020a7bc3d8000000b003cf9b7bb96cmr14185199wmj.113.1667903679190; 
 Tue, 08 Nov 2022 02:34:39 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 m11-20020a5d4a0b000000b0022ca921dc67sm9632802wrq.88.2022.11.08.02.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Nov 2022 02:34:38 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 0/2] vhost: fix ranges when call vhost_iotlb_itree_first()
Date: Tue,  8 Nov 2022 11:34:35 +0100
Message-Id: <20221108103437.105327-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

While I was working on vringh to support VA in vringh_*_iotlb()
I saw that the range we use in iotlb_translate() when we call
vhost_iotlb_itree_first() was not correct IIUC.
So I looked at all the calls and found that in vhost.c as well.

I didn't observe a failure and I don't have a reproducer because
I noticed the problem by looking at the code.

Maybe we didn't have a problem, because a shorter range was being
returned anyway and the loop stopped taking into account the total
amount of bytes translated, but I think it's better to fix.

Thanks,
Stefano

Stefano Garzarella (2):
  vringh: fix range used in iotlb_translate()
  vhost: fix range used in translate_desc()

 drivers/vhost/vhost.c  | 4 ++--
 drivers/vhost/vringh.c | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
