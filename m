Return-Path: <SRS0=Yk2c=PM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38080C433F5
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 13:55:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C165F60FBF
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 13:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C165F60FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4BDF340251;
	Sun, 24 Oct 2021 13:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6RCaY8xqgLgf; Sun, 24 Oct 2021 13:55:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A7784401E3;
	Sun, 24 Oct 2021 13:55:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78EA6C0019;
	Sun, 24 Oct 2021 13:55:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02F4BC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 13:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE35B40124
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 13:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RFpDSMqrmJTW
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 13:55:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 29BE8400B5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635083700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=tewEIaGWIVgpjWlRNV0G2f4scnW96h9ilayJkc4j6ck=;
 b=SHlmIvgXpoJwJ7zrtm0AeR08yz8WFr+ZztwzGzpDMcKYFTtCPBwk4lnP9a8dO0BVP4UAAo
 KCWwSEC2aeuNTU1lOQOkumVtyLtoAQWnT9wV7vTWvD1iP0JycH21vCnGdLeMJRy7CO5Wuy
 yX6kqv9+IlkaJRYtn8I1xNAStkbq/Ec=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-BLb3JwINNXa6psK_LSy4lA-1; Sun, 24 Oct 2021 09:54:59 -0400
X-MC-Unique: BLb3JwINNXa6psK_LSy4lA-1
Received: by mail-ed1-f70.google.com with SMTP id
 r25-20020a05640216d900b003dca3501ab4so7550044edx.15
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 06:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=tewEIaGWIVgpjWlRNV0G2f4scnW96h9ilayJkc4j6ck=;
 b=RUpKusY0v1c1QOrPoBOmAZPngPwlKV0i2rwq8/mU4u4EhXIyJFBXanLBgWDoig35++
 gS68uU8tFRqL8lH0rdK5l7/S/TfG3YMig4DmZXpmRvpOR1CaejJv/kYvWLT9biZiPyEb
 9yWaIHbozsEU+NtPw+LJVchw2kgncSD1iPfkDK4jZvjoXQhrcFa0l8riAR/oYCmZwb4j
 nAaQ6jsWxWtqjVZ/R24rGAsSqfuzVWtxDmEo7tRIJSehZKedTQrkQ13H5NGSmN4PYlgc
 6+VwUz/eHfxGArVHDWr/YkTG8ZiU7P3wJjOi6i2e5qpLzIPwS+6odo4i/c2Ua1nTl1Ey
 +I2w==
X-Gm-Message-State: AOAM531vDlfoO3I/r5UduPRrox6+AvjkB6lW6H08FaPOWo9Xp9HSQevM
 qO/p51XgE2wyxlYw1CO2ad2rGLtuQno9iNr163kKW7nMcv/5tsDJEtcyMCdpcaWWSe1ZLr7nQtO
 rQteckw2cEEH4F12GTslIDyxG+ml/o6pkidRgTj49Bw==
X-Received: by 2002:aa7:de8f:: with SMTP id j15mr17998588edv.347.1635083697860; 
 Sun, 24 Oct 2021 06:54:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziB449a0jkGnMyxw5Nq/yiWf48HjGMENXG4KqcvYNiRPrUcOY/ICO7KLwSoXi1Wh6vBRnxxA==
X-Received: by 2002:aa7:de8f:: with SMTP id j15mr17998572edv.347.1635083697702; 
 Sun, 24 Oct 2021 06:54:57 -0700 (PDT)
Received: from redhat.com ([2.55.151.113])
 by smtp.gmail.com with ESMTPSA id bx2sm1887573edb.44.2021.10.24.06.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Oct 2021 06:54:57 -0700 (PDT)
Date: Sun, 24 Oct 2021 09:54:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_blk: allow 0 as num_request_queues
Message-ID: <20211024135412.1516393-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

The default value is 0 meaning "no limit". However if 0
is specified on the command line it is instead silently
converted to 1. Further, the value is already validated
at point of use, there's no point in duplicating code
validating the value when it is set.

Simplify the code while making the behaviour more consistent
by using plain module_param.

Fixes: 1a662cf6cb9a ("virtio-blk: add num_request_queues module parameter")
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6318134aab76..c336d9bb9105 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -30,20 +30,8 @@
 #define VIRTIO_BLK_INLINE_SG_CNT	2
 #endif
 
-static int virtblk_queue_count_set(const char *val,
-		const struct kernel_param *kp)
-{
-	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
-}
-
-static const struct kernel_param_ops queue_count_ops = {
-	.set = virtblk_queue_count_set,
-	.get = param_get_uint,
-};
-
 static unsigned int num_request_queues;
-module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
-		0644);
+module_param(num_request_queues, uint, 0644);
 MODULE_PARM_DESC(num_request_queues,
 		 "Limit the number of request queues to use for blk device. "
 		 "0 for no limit. "
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
