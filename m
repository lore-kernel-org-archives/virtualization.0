Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0A7C00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 09:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5258081D73;
	Wed, 10 Aug 2022 09:44:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5258081D73
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F4WPHSnJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7NWguqsUEg3t; Wed, 10 Aug 2022 09:43:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D3374813E0;
	Wed, 10 Aug 2022 09:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3374813E0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB1FFC0033;
	Wed, 10 Aug 2022 09:43:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BA0CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26D998175C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26D998175C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y5yN7RuHcr8g
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B664814A9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B664814A9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660124636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxa8o9Tbfqnk5UAsXfKTjPHNDbYRHlKkIXBkapUnTe8=;
 b=F4WPHSnJJkgmNSwau2aDzBtojGUMh+I0OpIcl+EuzpgqNKFrMxGQRt4RCnmOb0SvFagtvk
 91FxTeNM+DBj9EGyAhwzB914JW66d282jUfTQDCaEAMAcA7DgQF3TkEbp2t1rP/qr7R9+Q
 9SI4fdvBaszT+jZQepMzSHnEMzaWy3M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-_tm1yqeHNMSYQ_eHvfTVTg-1; Wed, 10 Aug 2022 05:43:53 -0400
X-MC-Unique: _tm1yqeHNMSYQ_eHvfTVTg-1
Received: by mail-wm1-f69.google.com with SMTP id
 v130-20020a1cac88000000b003a4f057ed9fso7175216wme.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 02:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=bxa8o9Tbfqnk5UAsXfKTjPHNDbYRHlKkIXBkapUnTe8=;
 b=4aFnOlGnk6V2TGen7RO9HqsAqu4KaX3UJ20bXRUN5plVFTp/WVd9r2yFhGXbxaGzd3
 jqSttuOeFuGmgpqBBEpaJDJySUBmkWa92Oe1vx8MGfTkK0jSWvRmd9LV+k1q2JxuwLDE
 tx+qRKsfw062w9m7ZmVnje0PwUyMZgJOfqvtIqFLA9cwHhPX9Mp1iMNDIirwZIVc/Axb
 KTHoU7nUosBFZ8xlzYRN00q+pFbkilmJL344kSJZ2V6voRKSsJl/q5smu/0tMB3H4rbP
 moZffcZUl7w9bSkHRIOqcsyrsDcAws4g/2F1Aao+nCV9PdcMYDeOQi+VB+Ch64dv257t
 zkfg==
X-Gm-Message-State: ACgBeo0m+NvgOs8s1qzjJa5N11f9BwRZVTC9qZWcPIIjAUVFlDT8E32d
 rdHtHqsqLBd8TZV78n6/lb82ON6adnMqf0d1Ag3tIZDJHB3ewLj/6mtF8VzA4ZYNN6ssJsJsMYf
 cnBfdYqOK4+Kz9lNOHwNY45d9gJD5htThK7z5jlAv0mJFsMh5zyFy8rAI1Pb7wuI3nC1aUjpfym
 LPDKshCKH8ZStsqXWKIQ==
X-Received: by 2002:a05:600c:1c19:b0:3a5:a3c7:3800 with SMTP id
 j25-20020a05600c1c1900b003a5a3c73800mr1842915wms.69.1660124631920; 
 Wed, 10 Aug 2022 02:43:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Jxsv0aCcVhfY1+aZAP46TL6gSQU1Nu4jG9pvamIlkWl0TlioV7Jo9df4vCccE3CDr541Q2g==
X-Received: by 2002:a05:600c:1c19:b0:3a5:a3c7:3800 with SMTP id
 j25-20020a05600c1c1900b003a5a3c73800mr1842898wms.69.1660124631718; 
 Wed, 10 Aug 2022 02:43:51 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 q11-20020a5d658b000000b0021e4bc9edbfsm12921743wru.112.2022.08.10.02.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 02:43:50 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/4] vdpa_sim_blk: check if sector is 0 for commands other
 than read or write
Date: Wed, 10 Aug 2022 11:43:44 +0200
Message-Id: <20220810094347.20449-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810094347.20449-1-sgarzare@redhat.com>
References: <20220810094347.20449-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

VIRTIO spec states: "The sector number indicates the offset
(multiplied by 512) where the read or write is to occur. This field is
unused and set to 0 for commands other than read or write."

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index ba253f8bce32..69c9f4f36f9a 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -112,6 +112,15 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	offset = sector << SECTOR_SHIFT;
 	status = VIRTIO_BLK_S_OK;
 
+	if (type != VIRTIO_BLK_T_IN && type != VIRTIO_BLK_T_OUT &&
+	    sector != 0) {
+		dev_dbg(&vdpasim->vdpa.dev,
+			"sector must be 0 for %u request - sector: 0x%llx\n",
+			type, sector);
+		status = VIRTIO_BLK_S_IOERR;
+		goto err_status;
+	}
+
 	switch (type) {
 	case VIRTIO_BLK_T_IN:
 		if (!vdpasim_blk_check_range(sector, to_push)) {
@@ -178,6 +187,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		break;
 	}
 
+err_status:
 	/* If some operations fail, we need to skip the remaining bytes
 	 * to put the status in the last byte
 	 */
-- 
2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
