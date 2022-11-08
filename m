Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3358C43217
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 10:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DD0F80DC0;
	Tue,  8 Nov 2022 10:34:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4DD0F80DC0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fimNQknF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IuUDQ0EeasWi; Tue,  8 Nov 2022 10:34:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D26E480BD0;
	Tue,  8 Nov 2022 10:34:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D26E480BD0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B014EC0032;
	Tue,  8 Nov 2022 10:34:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6500DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B1D4404F4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:34:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B1D4404F4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fimNQknF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R1d91By3fYqa
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:34:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60C16403C1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60C16403C1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667903683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKRP4+cw0VhFwZrp8HtA3cgViFo5lHlh1+6syG/i+wQ=;
 b=fimNQknFaTAUDv6871+ju9r+sWpLVjQOZ1iP2ULFUh30KF7B5anuxoHDfSwiv4zvFCoEtU
 AL/+c+ONgCBro5tf5cGOeu34agvlNRcy9qsRjnkZTj6MD6R1Dk37OBcLspWGRF6YUag3Nf
 2HZbPuKPMFURVqhalPeaTt64X2aNm0E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-90-pImE4-U0Pk-nFh_5pvYQOA-1; Tue, 08 Nov 2022 05:34:42 -0500
X-MC-Unique: pImE4-U0Pk-nFh_5pvYQOA-1
Received: by mail-wr1-f70.google.com with SMTP id
 s7-20020adfa287000000b00236c367fcddso3819070wra.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 02:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKRP4+cw0VhFwZrp8HtA3cgViFo5lHlh1+6syG/i+wQ=;
 b=4nK087WpD3x60b7r1XahW1Wf5bHixP1BmSGFZIOlTSqMm/Tip32iPSPZy0/oo6BudA
 x8maVNRUGSS76pIL0DS7zI95MgmfVmxlC4W8Xqo1DjadJP9vQkfCJ8PM2F8+c3aOMURz
 wfrZx5/KNHhJDzi7+6RW+iDgNVDbbeAhKP7whZ5ZhRihqdQJkLGeh1peufq+H9jNpirj
 AZ7gMI4fBG2BTXXHSPbGcyCyIT+wysns709bpMLI83+gg8i11remkq/VXt7yttZwRWbC
 ngoRRzhIV1ZISR4ersRXt8BJLM4BipNQQbH9RYm0Q7YRO/jrYeZXbzm12JSKAhehsTmf
 aRKg==
X-Gm-Message-State: ACrzQf1xzVwHiwHIUMmYvMDh5LFFz8FVCbeINQf6x+wQGcDLbza1gTpT
 MzRd5gam4xxMm8OkWpM8Z34ee5c+dQ7KWkW78gPFVnaOrHF07sG8QsAR5uZgHYgHX15xp0hyH6H
 XN1CjRBybb2LcVdA+cmSSed7V6GmhuV8tHhx6g6L8j10FTuZIecwifpwAQLU5zVWTcHMcrlvZhe
 6DMaUoOIIHJQ/ALlVXsQ==
X-Received: by 2002:a05:600c:ad0:b0:3cf:692a:7f66 with SMTP id
 c16-20020a05600c0ad000b003cf692a7f66mr35280932wmr.200.1667903681009; 
 Tue, 08 Nov 2022 02:34:41 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6ASsVMnXRj7BGCE+XsYeiyRdqfGCW4D/w7QesCAh5x6w9k97okW5QkPTlkLZADWxPYvplZtA==
X-Received: by 2002:a05:600c:ad0:b0:3cf:692a:7f66 with SMTP id
 c16-20020a05600c0ad000b003cf692a7f66mr35280908wmr.200.1667903680649; 
 Tue, 08 Nov 2022 02:34:40 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 m11-20020a5d4a0b000000b0022ca921dc67sm9632802wrq.88.2022.11.08.02.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Nov 2022 02:34:40 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 1/2] vringh: fix range used in iotlb_translate()
Date: Tue,  8 Nov 2022 11:34:36 +0100
Message-Id: <20221108103437.105327-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108103437.105327-1-sgarzare@redhat.com>
References: <20221108103437.105327-1-sgarzare@redhat.com>
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

vhost_iotlb_itree_first() requires `start` and `last` parameters
to search for a mapping that overlaps the range.

In iotlb_translate() we cyclically call vhost_iotlb_itree_first(),
incrementing `addr` by the amount already translated, so rightly
we move the `start` parameter passed to vhost_iotlb_itree_first(),
but we should hold the `last` parameter constant.

Let's fix it by saving the `last` parameter value before incrementing
`addr` in the loop.

Fixes: 9ad9c49cfe97 ("vringh: IOTLB support")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vringh.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 11f59dd06a74..828c29306565 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1102,7 +1102,7 @@ static int iotlb_translate(const struct vringh *vrh,
 	struct vhost_iotlb_map *map;
 	struct vhost_iotlb *iotlb = vrh->iotlb;
 	int ret = 0;
-	u64 s = 0;
+	u64 s = 0, last = addr + len - 1;
 
 	spin_lock(vrh->iotlb_lock);
 
@@ -1114,8 +1114,7 @@ static int iotlb_translate(const struct vringh *vrh,
 			break;
 		}
 
-		map = vhost_iotlb_itree_first(iotlb, addr,
-					      addr + len - 1);
+		map = vhost_iotlb_itree_first(iotlb, addr, last);
 		if (!map || map->start > addr) {
 			ret = -EINVAL;
 			break;
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
