Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC7DC433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB272065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZNkcQav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB272065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5898586B68;
	Wed,  5 Aug 2020 13:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hp7pLxR2TQy9; Wed,  5 Aug 2020 13:43:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E565686B67;
	Wed,  5 Aug 2020 13:43:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEE6BC0051;
	Wed,  5 Aug 2020 13:43:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A024C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1992F8350D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pjrX5p4QC9B5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5CA3880AD0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QZtQO+RPpH+qMcVX7UHHBecNGQz0/LWgC7hfTGQuckU=;
 b=FZNkcQav4TirtlffdgdRcl9jdXtkD8VR2muIysOWGebUor0GOaJGwJ8YY70Bs0qJ1Insuo
 tGNbLHa8Ph9cQEdMQxffHtVlinrq4XiGZjccgosHPX+2ZBa+afhJZhCEqfRPExyW21O+gQ
 55/g63Pd0z0FO9VhtzS6RpAE2DcZhJA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-tJafOe4OMAmhvnCJWSQn7w-1; Wed, 05 Aug 2020 09:43:20 -0400
X-MC-Unique: tJafOe4OMAmhvnCJWSQn7w-1
Received: by mail-wr1-f70.google.com with SMTP id b18so10574764wrn.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QZtQO+RPpH+qMcVX7UHHBecNGQz0/LWgC7hfTGQuckU=;
 b=HsdjWX+hQFeRSBTz0M5w2cbu08YoLQBqrDnxQvMG9nZiIvCkUgh1VnxQH1p2VEfXMg
 HOT5496fg/D5ZLAt+YXZVsxvu7lqOc+GG5j8lNFswQaIhLUIUMXGEf8fvCf09cZS0Foz
 AYduD94hy8YKe0d+UH/PHw16nF5ga64Th5mxiqOUL9kkArRGyZ8Cbv5yfWEsh7qSBOEc
 N7mi12K6dUMGe6AjGjNt4oX5j64HaQDoqjqWi0WomUwnQxmEt4qR0LY44+/P9+3PU2bN
 xLj/W6/TMDHrLFdeXgAeW3z7lFml+KeL9h6c8EXE93I8cbLBj181/cocieZIvoSC478j
 +SKA==
X-Gm-Message-State: AOAM531VERSuG6hSGyOJjDz3SENq3LlX8bl8B7/x8hEXDil3FRqXnR12
 KNLRnYhlU3K/Br9epeZJeaNh51zl/88FmJIEnNqgqw3Wui6A/zsWCbC4vR1nP55/ClRhRX2udBb
 fkaD1yTrL/pDOcv3jIOV/YTQr5gdWFt4X9nSNp+sqFQ==
X-Received: by 2002:a05:600c:2189:: with SMTP id
 e9mr3594944wme.171.1596634999574; 
 Wed, 05 Aug 2020 06:43:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaUQx57cc7JttIMX2xKEoawmsqxvIFhQa983nt+oNgyKZc7lcEC6u20fEKG5dxWjJXOX9tYA==
X-Received: by 2002:a05:600c:2189:: with SMTP id
 e9mr3594934wme.171.1596634999421; 
 Wed, 05 Aug 2020 06:43:19 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 x6sm594339wmx.28.2020.08.05.06.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:43:18 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:43:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/38] virtio_balloon: fix sparse warning
Message-ID: <20200805134226.1106164-2-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cornelia Huck <cohuck@redhat.com>,
 virtualization@lists.linux-foundation.org
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

balloon uses virtio32_to_cpu instead of cpu_to_virtio32
to convert a native endian number to virtio.
No practical difference but makes sparse warn.
Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 54fd989f9353..8bc1704ffdf3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -600,7 +600,7 @@ static int send_cmd_id_start(struct virtio_balloon *vb)
 	while (virtqueue_get_buf(vq, &unused))
 		;
 
-	vb->cmd_id_active = virtio32_to_cpu(vb->vdev,
+	vb->cmd_id_active = cpu_to_virtio32(vb->vdev,
 					virtio_balloon_cmd_id_received(vb));
 	sg_init_one(&sg, &vb->cmd_id_active, sizeof(vb->cmd_id_active));
 	err = virtqueue_add_outbuf(vq, &sg, 1, &vb->cmd_id_active, GFP_KERNEL);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
