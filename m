Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDE3C433DF
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A05B22C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsqbwsX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A05B22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9CFA020500;
	Mon,  3 Aug 2020 20:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rEvuDXOUVK86; Mon,  3 Aug 2020 20:59:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8843E20369;
	Mon,  3 Aug 2020 20:59:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7482CC0050;
	Mon,  3 Aug 2020 20:59:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18884C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 065E387A6B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pM3AcCoUjaUE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 70F6E87A5E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pjba7UTEkMQb9cgNSFsINkPwPT47kJGCQxpArSsq/v4=;
 b=KsqbwsX0OSBi/UozBeZItDI5uUU7UMHVs6ocbS143ebggkM6ba1HHhxr3yhN+lkTQ+CsTv
 RAb/mvMvbCccdt73hEwlKMMjdRrGxPjTCrjlErbhm/dYFW7ZDkOBIy/KbDxUhS6xAAQPjE
 QbocxOFGhGqcZV9oueNXM8/bZlWHFCk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-U0_JkQ_zPCe3mc4pQrnPzw-1; Mon, 03 Aug 2020 16:59:23 -0400
X-MC-Unique: U0_JkQ_zPCe3mc4pQrnPzw-1
Received: by mail-qv1-f70.google.com with SMTP id z10so3662992qvm.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pjba7UTEkMQb9cgNSFsINkPwPT47kJGCQxpArSsq/v4=;
 b=IthxbPGSTN+AZPdIApG/6FADBWOwT2f9yX2YPxTzvodkPFMe3vNXdYx6rO18mHbRxQ
 BparT7ozXveS1mjJzyMMST21n3f2/mt2x/ubh6jUfjtOnTXdJSj1UQZmYqOOK8Ui2t85
 P1CVFxbkm6MwJa8reRhR1SqRkmhIqlbOERQPbgEhG1T5eRY54Oea0ws0gXrRS90dJt4D
 tE0nvHjtV5AQRXvU8JjOajr8MUK3u3S77oUTF7KHIpC4gT34asv2Fw9MMA6ksXzWLyXe
 HNifK6g9/iGYx5jW/a+obcBjzlfKJr1GtrWTJdYtDCu5q24SiNDOAGSn2ggzCpU+5b83
 iAUQ==
X-Gm-Message-State: AOAM531zS2au5fumHb6ooyLyp8bOtwjJU3/nIU12qaWwOYuIa3p2ADHh
 +ic1opCrBxnWiDPFi59nzA4Ls/LceuDun84ZdhZFBYZ0HgzuB+7Qu2zqe1xmtWWqKmBgIkgolOt
 GDPiBKn2ZycA4XcXD3QjS2MW8daY2uRtKeLJP9liIqw==
X-Received: by 2002:ac8:387b:: with SMTP id r56mr18809903qtb.353.1596488363040; 
 Mon, 03 Aug 2020 13:59:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHozttQuejm//tCqktxmYXDIQpJ0ThAuBb6QUqCnnttWqM4Fv1n/r76PemaGEK2xQsqaBj5g==
X-Received: by 2002:ac8:387b:: with SMTP id r56mr18809888qtb.353.1596488362838; 
 Mon, 03 Aug 2020 13:59:22 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id p17sm19764307qkj.69.2020.08.03.13.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:59:22 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:59:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/24] virtio_gpu: correct tags for config space fields
Message-ID: <20200803205814.540410-11-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
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

Since gpu is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_gpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 0c85914d9369..ccbd174ef321 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -320,10 +320,10 @@ struct virtio_gpu_resp_edid {
 #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
 
 struct virtio_gpu_config {
-	__u32 events_read;
-	__u32 events_clear;
-	__u32 num_scanouts;
-	__u32 num_capsets;
+	__le32 events_read;
+	__le32 events_clear;
+	__le32 num_scanouts;
+	__le32 num_capsets;
 };
 
 /* simple formats for fbcon/X use */
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
