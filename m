Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AD0C4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 04:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5D5BC404C4;
	Wed, 12 Oct 2022 04:52:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D5BC404C4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pg3m0b9z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id veTkADgQnKiZ; Wed, 12 Oct 2022 04:52:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E0A5240156;
	Wed, 12 Oct 2022 04:52:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0A5240156
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2245C0033;
	Wed, 12 Oct 2022 04:52:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80C86C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 04:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45C2E82A26
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 04:52:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45C2E82A26
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pg3m0b9z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TlNKCv3d0_gK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 04:52:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 617D982983
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 617D982983
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 04:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665550359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=FgWbfbhMWMtoQvRE45b5B2jwxgfNrBgnpCUvv7Lscw4=;
 b=Pg3m0b9zRdX9WIKMzxnklbeW4wC40tBR2YQ/HFHP9n9MBJoLryEsYWxRgrTUFpc9tLResd
 CNot6mvQHEuiXOW6xKa04PJLVodut1JHnr+QgV1+vCJprwpbC6KG6Vj5jvEfyYmHPyRRc3
 Fzm5Emm97PJn1Vwm87cPp7pVQX0iN94=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-339-M4Wo9OyYOoaHKuUXUMueQQ-1; Wed, 12 Oct 2022 00:52:37 -0400
X-MC-Unique: M4Wo9OyYOoaHKuUXUMueQQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 t12-20020adfa2cc000000b0022adcbb248bso4493895wra.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Oct 2022 21:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FgWbfbhMWMtoQvRE45b5B2jwxgfNrBgnpCUvv7Lscw4=;
 b=AmKQDEny5hN1N9wwOV0T4ZVgzh/UsTfl5Il6bSV7z5AoOEW3F3Vhh7hw3C2QgGd6X5
 3YeN4jzwSq+EeFD7bKnVz/c2LwXsFbzQ41pEsZrjL9hwbPTG/0ge/F+6aHpkwsDJ+myW
 8DRtX2ZzIgrbdulhFkzE1ihRCAPLjNyXO9cqBGj7AbuFn2gU7qQz/qtAHv7gXIr8BnXg
 ov3AUUs0K66q5EUE12Mz+7LapHql1LBP8LqzVZJ0BlOLGNtjtrSg/BAgDLII+xus/149
 ul/JBnKRkfQbdndBTPGJd0jJPCi0ymHbQqqFjMbd1YZAsrOvpREnRPNAnF2F/8v80wCx
 38sg==
X-Gm-Message-State: ACrzQf25MWhj6NFwXefNDHJzGb9S0t4IDJXFSixRAr/I3ZetB/DTOyVT
 nyOWzyHhsbWVopzUw8fijbCXcHH5edVzbCcDHOUph8joTD8eKl0i2bhUnnEzRNwE5zXbg2DICJz
 x+7x7IEG6nbRUrfH/ZmYWUCwFCNxuiMN8T9y+OGN1ZA==
X-Received: by 2002:a05:600c:4e4d:b0:3b4:7659:38c with SMTP id
 e13-20020a05600c4e4d00b003b47659038cmr1373721wmq.176.1665550356816; 
 Tue, 11 Oct 2022 21:52:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4iZDeridtCKmzd9gDftPmBS44o5wzn0jyUgtvdhGtzuaiYLNEPiBhn3L8OdGNYm+6sDG3IeA==
X-Received: by 2002:a05:600c:4e4d:b0:3b4:7659:38c with SMTP id
 e13-20020a05600c4e4d00b003b47659038cmr1373712wmq.176.1665550356556; 
 Tue, 11 Oct 2022 21:52:36 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 q128-20020a1c4386000000b003a6a3595edasm718732wma.27.2022.10.11.21.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Oct 2022 21:52:35 -0700 (PDT)
Date: Wed, 12 Oct 2022 00:52:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa/ifcvf: add reviewer
Message-ID: <20221012045152.223274-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Zhu Lingshan <lingshan.zhu@intel.com>,
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

Zhu Lingshan has been writing and reviewing ifcvf patches for
a while now, add as reviewer.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d960ca4e969..531bbb0a507a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21736,6 +21736,10 @@ F:	include/linux/virtio*.h
 F:	include/uapi/linux/virtio_*.h
 F:	tools/virtio/
 
+IFCVF VIRTIO DATA PATH ACCELERATOR
+R:	Zhu Lingshan <lingshan.zhu@intel.com>
+F:	drivers/vdpa/ifcvf/
+
 VIRTIO BALLOON
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	David Hildenbrand <david@redhat.com>
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
