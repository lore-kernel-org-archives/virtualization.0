Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8204FC433E1
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9F62065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/ktO42n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9F62065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1885987750;
	Wed,  5 Aug 2020 13:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0AXhslAa-mun; Wed,  5 Aug 2020 13:43:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 25432875B4;
	Wed,  5 Aug 2020 13:43:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06650C0051;
	Wed,  5 Aug 2020 13:43:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A584C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 19EBB88177
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SDJPrAM+fBsH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5BC168796D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g3o0OGn0mUAYpih0J/9SEomhwUpjV32w1tKo7wzCsHg=;
 b=O/ktO42nNh33+ijwAJV86ntCMcX1BG9NZnrnuuJORfZz6vSm3kinY9FR+O6HD3WOtQxK//
 uvb/UEiGvtjIbwQ3201mhPVb6naiLxCKbTtVeLH9bS4n5RJpvdtBSa3HODyv/UsTXMARSz
 6RFAWeKca67C2eEpXx2HvqcX0sjX/MQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-D6mdkbUVPvOsi1e9nyjDpQ-1; Wed, 05 Aug 2020 09:43:49 -0400
X-MC-Unique: D6mdkbUVPvOsi1e9nyjDpQ-1
Received: by mail-wr1-f69.google.com with SMTP id b8so3980388wrr.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g3o0OGn0mUAYpih0J/9SEomhwUpjV32w1tKo7wzCsHg=;
 b=L/If8iJcGSptI2/7gHWaUE9Tx3UBBKBxqIGCyF5F/3mv/3QJdIV38vDYEjrA0be/kh
 rMr2jRxFpmbfkU83tvgKB8J6pg8OHQXahiSDVRSL0l6apWqTAA5321YpoCE0YC7J6AY5
 xvf0o0dnx6g/S0BBA2neHmvgQrKQ+kbVjNuGKWeBZIJ8nAa8aCfzynAnH2ePB6hlp5MQ
 7rd2Ae/BJp9YdDEdj9lH8fsHVtjZ6mMNLkwDSQVZReTVVG6VaHkQHErVOns88yS6ycA6
 leitUBHhGHu6xxZNWMoSEbzCeSJzcE41hXiWTyShnBbgsF4mltuCOG9atVVoZschljaw
 o92Q==
X-Gm-Message-State: AOAM533ZjaISVzFqT+GykPV0yKwDWYIWVnPL/NhUHCKzzxOWeXhxSqVM
 8B4vGQN+2AibXET0OvDZ0CANNR90fClbRULp5ZA7JPu7zMcZdaboQq0y4I02jthcqgAzmwuPbnZ
 SuewXlBjfSSnDPdEYdePV3PDRHjCo5IrOOnSrYooGCQ==
X-Received: by 2002:a1c:de85:: with SMTP id v127mr3619752wmg.156.1596635028104; 
 Wed, 05 Aug 2020 06:43:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwmrGMDVCn/Eh3OUbw6CERaaET4RDsZOTOCOJ+17iVCbbptXxAFKPNKih6Ihq1bDCxSPDlyg==
X-Received: by 2002:a1c:de85:: with SMTP id v127mr3619743wmg.156.1596635027917; 
 Wed, 05 Aug 2020 06:43:47 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 v29sm2858032wrv.51.2020.08.05.06.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:43:47 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:43:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/38] virtio_input: correct tags for config space fields
Message-ID: <20200805134226.1106164-12-mst@redhat.com>
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

Since this is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 include/uapi/linux/virtio_input.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/virtio_input.h b/include/uapi/linux/virtio_input.h
index a7fe5c8fb135..52084b1fb965 100644
--- a/include/uapi/linux/virtio_input.h
+++ b/include/uapi/linux/virtio_input.h
@@ -40,18 +40,18 @@ enum virtio_input_config_select {
 };
 
 struct virtio_input_absinfo {
-	__u32 min;
-	__u32 max;
-	__u32 fuzz;
-	__u32 flat;
-	__u32 res;
+	__le32 min;
+	__le32 max;
+	__le32 fuzz;
+	__le32 flat;
+	__le32 res;
 };
 
 struct virtio_input_devids {
-	__u16 bustype;
-	__u16 vendor;
-	__u16 product;
-	__u16 version;
+	__le16 bustype;
+	__le16 vendor;
+	__le16 product;
+	__le16 version;
 };
 
 struct virtio_input_config {
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
