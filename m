Return-Path: <SRS0=GaRw=BU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A82DC433DF
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 12:58:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E667B206E9
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 12:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xal2rq4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E667B206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B91CA890BB;
	Mon, 10 Aug 2020 12:58:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id po4v5nFi2FGI; Mon, 10 Aug 2020 12:58:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3F48089033;
	Mon, 10 Aug 2020 12:58:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DBD7C013C;
	Mon, 10 Aug 2020 12:58:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C1C7C004D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 12:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4B28585A76
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 12:58:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DmonpcawGZUt
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 12:58:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BCE0385A6E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597064322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=0XWxoXgTd+Cmn2+Y+VXXovIx+yerjTcX1eN21KuFyjg=;
 b=Xal2rq4iVe3bQCuOWOefzw9WUXU1SJOLVd84mlyHC7iPfvHAQSZD/+6K4++U1c3xP4rtR/
 th01CfaI5lzgR6+sBMUbSJ9+PLWAfdjEqrGG1b4Zvtxb7dh6+Xuni3Xu2tm5hSLibq1TnC
 TCI3HI5ASMvM+i5nou0NVto3YY8dO4o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-pJ-WUg7cO3e1Ala5KGnK2g-1; Mon, 10 Aug 2020 08:58:40 -0400
X-MC-Unique: pJ-WUg7cO3e1Ala5KGnK2g-1
Received: by mail-wr1-f70.google.com with SMTP id r14so4213806wrq.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 05:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=0XWxoXgTd+Cmn2+Y+VXXovIx+yerjTcX1eN21KuFyjg=;
 b=nsPYI99xJEhTLlth8UjF1G5OCHdoKV7ygrPpNh9kLVoc0g6aWREI4Am+xMsx66dkMF
 cOLqcGKrZlMyyaE0XWQCr0LEBzzQURLjO75bv3Rz8Ah38PuiGGiZHnSDjH2paAAi7CzO
 mbA3VpfPi2uOf/MOaiRERDJB8B6wBlArOaKG/Vo+zWWqiYgr9LL5iVOpLWHF5X6ufu+0
 m5mJbXXt5uOND90x5WzZiiqj+vn5f28qYIandJQhbvKA1riRw4ymTe1F8APupme/D5d8
 PnHqA6ejIalHAMrwH6RwAYxC6QzMnfdHaJwhx74dh5/n9HvyTDP7aNIjy5y963BJ74rc
 ELtQ==
X-Gm-Message-State: AOAM531GyUWRlUo3RwqBgA2m4gjLKep+6JxpvprnbE/JJ2MsAmFDfoqY
 ZAvrv/elpIB/lu/3B28gvkm/tCG2lJUFhWOt9AEmxImsg3ZCYevhN/bGRx7Ic7Cu/atLtqzzVur
 +TcAIrVTTFSpt9PU/UayY3MI5od1cYTPQP2cIm9Mcxw==
X-Received: by 2002:a05:6000:141:: with SMTP id
 r1mr23576326wrx.69.1597064319483; 
 Mon, 10 Aug 2020 05:58:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgVrjE6ddfYhHeuXfquYYvBR+ne2IStmNs3q7O3IT77a7Q8nyuM1ewjqhkOrzQtMEqJjKPvg==
X-Received: by 2002:a05:6000:141:: with SMTP id
 r1mr23576314wrx.69.1597064319331; 
 Mon, 10 Aug 2020 05:58:39 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id 31sm20844627wrj.94.2020.08.10.05.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 05:58:38 -0700 (PDT)
Date: Mon, 10 Aug 2020 08:58:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa_sim: fix pointer math in get_config
Message-ID: <20200810125833.1556552-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
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

There is a pointer math bug here: the variable cast is a struct so the
offset is in units of struct size.  If "offset" is non-zero this will
copy memory from beyond the end of the array.

fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 604d9d25ca47..62d640327145 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -558,7 +558,7 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
 	if (offset + len < sizeof(struct virtio_net_config))
-		memcpy(buf, &vdpasim->config + offset, len);
+		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
 }
 
 static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
