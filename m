Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF785C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 16:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 248DE83F81;
	Tue, 21 Jun 2022 16:09:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 248DE83F81
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BCf8H080
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NG9ON9D4ttsV; Tue, 21 Jun 2022 16:09:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BACBC83F7E;
	Tue, 21 Jun 2022 16:09:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BACBC83F7E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F583C0039;
	Tue, 21 Jun 2022 16:09:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AD27C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 16:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F48A60E53
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 16:09:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F48A60E53
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BCf8H080
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hDrrgJpwAKpr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 16:09:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73FB960E2A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73FB960E2A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 16:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655827745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9ILEoqsZx+2myJVQi86gTVEQaPIoJy1nmnDc84Xu+Qo=;
 b=BCf8H080t9MMi9LUBY7rVfdSlHVmX8QCrP79iqNhNZl1kGk6/1fo3bGMTs5zrzn3eBJaf2
 mLcYXayCmZDlT6wwTkVv5CVJkVECQRk/vTImtPLBf8NWy+iArWGh/ALAojc7NygaIca4YN
 kQRsg+CsrFKs0Dbt01Ly308ZukwIXw4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-6DZMm6BgMFmyYnP3pFDAKw-1; Tue, 21 Jun 2022 12:09:04 -0400
X-MC-Unique: 6DZMm6BgMFmyYnP3pFDAKw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ck13-20020a5d5e8d000000b0021b984d1565so620500wrb.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9ILEoqsZx+2myJVQi86gTVEQaPIoJy1nmnDc84Xu+Qo=;
 b=1QnZd+89YZs6LAvUfZNgsVhmZT/j1ovatqmdwg7i2XSJ2iffYmGbWYDY+90gVn6FpG
 goaM0c0jeatni0GUQvCMoY15ZLjAqTrtZtsN6HbOZRZeBQSRvvxRBYbbmudd0SVBIY/+
 RESoOCOhNf67J+dSX/3ZwN2j0tcM4+SPAq7awzt/SAa7z8ddOjcQfkTBI9gEIRUspXkY
 euBBcYBjH+oPWaTeE5kvcO154tMXcaxRs/8gAQ1o7xP/HoZ1kjgyixXJj6fEnf+1rpzl
 eTCxZe7n8Wc/god/BQ4PaY0n9/RI66zLT2ld7Kdsu/y5o2atpgy/n9no2GKuo0EgoZBS
 Xr3w==
X-Gm-Message-State: AJIora+uSsmem0Se8FgEJKbSvvbfAWYLfpY9/9uX+378ID7eipoP0HIw
 J9aiLfk5Rv5at2acaPkRNOVN23PX8bskVd5KjkNVxKRxhQVblhRBDr9PoUDxgUFXfhjzOHaG8ll
 LeUm/C8bMJPeZaHwVGs5S5/AvVdJdjcIgdo8ocUZAvwPZR6b8iNEvA7EdlB2f9MOOhhxFveimby
 bgEBIPP/48jo02ocMQew==
X-Received: by 2002:a7b:cd1a:0:b0:39c:4133:ade7 with SMTP id
 f26-20020a7bcd1a000000b0039c4133ade7mr30341524wmj.111.1655827742383; 
 Tue, 21 Jun 2022 09:09:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u5ULEJ6eMdX0D3UH7W5nqFcJOjZBZzUz4qpSBaU+tC8IeUMaGk2dezobQcH3CZWJvYsom4Sg==
X-Received: by 2002:a7b:cd1a:0:b0:39c:4133:ade7 with SMTP id
 f26-20020a7bcd1a000000b0039c4133ade7mr30341492wmj.111.1655827742111; 
 Tue, 21 Jun 2022 09:09:02 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 ba7-20020a0560001c0700b0021b903a018bsm6531560wrb.92.2022.06.21.09.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jun 2022 09:09:01 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 0/3] vdpa_sim_blk: several fixes for the vDPA block simulator
Date: Tue, 21 Jun 2022 18:08:56 +0200
Message-Id: <20220621160859.196646-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

The first two patches essentially limit the possibility of the guest
doing a DoS to the host.

The third makes the simulator more correct (following what we do in
vdpa_sim_net) by calling vringh_complete_iotlb() in the error path as well.

Stefano Garzarella (3):
  vdpa_sim_blk: use dev_dbg() to print errors
  vdpa_sim_blk: limit the number of request handled per batch
  vdpa_sim_blk: call vringh_complete_iotlb() also in the error path

 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 49 +++++++++++++++++++---------
 1 file changed, 33 insertions(+), 16 deletions(-)

-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
