Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E9DC4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 12:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2BB5415FD;
	Tue, 20 Dec 2022 12:42:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2BB5415FD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jDlbCVx5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9KVt07zF9apU; Tue, 20 Dec 2022 12:42:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7DD0D415CF;
	Tue, 20 Dec 2022 12:42:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DD0D415CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39EECC0035;
	Tue, 20 Dec 2022 12:42:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08834C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 12:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2F66415C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 12:42:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2F66415C9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HCK8I1s22f2W
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 12:42:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD15541571
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD15541571
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671540120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=a9dphcXJKbDgaDzxRRBiVFA9p7kE9yji17UDhT5ug+8=;
 b=jDlbCVx5ASW9WXd/pM0qM3JKtx5JDLczj05mZ/T2tx3j0JEJLNlBevQSTFkX69JY6oVB/1
 b4dITTT2oSk8ueGT+FDcKRgoHHg+EdroInniqMs45LSF6jleOztdCILOUBTeG3O3WVGOx8
 UD/5q+Kq63GELU0sYr2RDhIJh1veFRs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-76-YRCC5mAKPtaP0YWFjzn1kw-1; Tue, 20 Dec 2022 07:41:59 -0500
X-MC-Unique: YRCC5mAKPtaP0YWFjzn1kw-1
Received: by mail-qt1-f198.google.com with SMTP id
 k7-20020ac84747000000b003a87ca26200so5434088qtp.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 04:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a9dphcXJKbDgaDzxRRBiVFA9p7kE9yji17UDhT5ug+8=;
 b=HzIFHmvHG4IVsPbVQtgdC3H7oZYCkNzD7wQPvwqNsf+jMpYCab3bau2Ic/a264Sb5Z
 aO+ycBJ1WTmS98CHIOCR5E9GIbX/J9et2YgEuXDWdIum5NBsDlSn8/jSIYjFHLKa3J0d
 ty/kyhxGtDXvfkY6EdIWTpVe8i1pGEf8dKB8swosErB3j30gJAc2/MJD9v0B1xEjMXew
 rbHYcsrsKkNLMmtKVgTVHROLbcfkg7RYeF1OpXw/+FjjqF4le8HdNlIecu7DO32fsxEP
 DCwCRAGqN2LGSlDnE9bNZ4vmne3roSwgH6olMsgR9MrENB/131LG9zzHHkZyyNcFM8Nu
 pHfQ==
X-Gm-Message-State: AFqh2kqy30AvKeLNjT33usjg9jBLVm9Wun0agxfl8Y84GO3b9RFQs4jY
 HvkM6dWuuJQn/c+kzzMVR/I7MA91ZlHqpKC9I8vWy9gJVPBR5GU6sCHOx9tAncsO8RKSsIvFkWr
 T1OQ7fUaq6jG92tQoTDE+MON0UieypFm9K65O3UabPw==
X-Received: by 2002:ac8:6904:0:b0:3a9:6b48:a130 with SMTP id
 bt4-20020ac86904000000b003a96b48a130mr25323876qtb.34.1671540119051; 
 Tue, 20 Dec 2022 04:41:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsSZ+R1ipZB7Pp5jlH4N4rO4W1kiXyv4dXazNe/fcZv+aCknM6mHWYUdqpnkHeBoyJ3nTFEpA==
X-Received: by 2002:ac8:6904:0:b0:3a9:6b48:a130 with SMTP id
 bt4-20020ac86904000000b003a96b48a130mr25323850qtb.34.1671540118802; 
 Tue, 20 Dec 2022 04:41:58 -0800 (PST)
Received: from redhat.com ([37.19.199.118]) by smtp.gmail.com with ESMTPSA id
 i8-20020a05620a404800b006fbaf9c1b70sm8781028qko.133.2022.12.20.04.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 04:41:58 -0800 (PST)
Date: Tue, 20 Dec 2022 07:41:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_blk: temporary variable type tweak
Message-ID: <20221220124152.523531-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

virtblk_result returns blk_status_t which is a bitwise restricted type,
so we are not supposed to stuff it in a plain int temporary variable.
All we do with it is pass it on to a function expecting blk_status_t so
the generated code is ok, but we get warnings from sparse:

drivers/block/virtio_blk.c:326:36: sparse: sparse: incorrect type in initializer (different base types) @@     expected int status @@
+got restricted blk_status_t @@
drivers/block/virtio_blk.c:334:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted
+blk_status_t [usertype] error @@     got int status @@

Make sparse happy by using the correct type.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 88d8410ecc5e..73cd5db0d7d5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -336,7 +336,7 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 static inline void virtblk_request_done(struct request *req)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-	int status = virtblk_result(vbr->status);
+	blk_status_t status = virtblk_result(vbr->status);
 
 	virtblk_unmap_data(req, vbr);
 	virtblk_cleanup_cmd(req);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
