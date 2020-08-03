Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E780BC433E0
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA45722C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbXJiFPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA45722C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 92F98204CB;
	Mon,  3 Aug 2020 20:59:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1l1gITK-45Vx; Mon,  3 Aug 2020 20:59:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7161E204FF;
	Mon,  3 Aug 2020 20:59:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56311C0050;
	Mon,  3 Aug 2020 20:59:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1745CC004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 06D12861CD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0R-xN6RpwiYY
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4E78985A90
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fjTvqLs5kODLJE0NPlW/uTfO7Hwyt71PbjjTwHT15mk=;
 b=HbXJiFPcZSN7FchRsEW6w/hEPqoiiAc+gtrXK3ChqA5ZldtLE8zx17dVNwotXLMB8Cl0pj
 Rr1ZuJGHBixO6y7j4xEbO4SYcBF2f1Z8ZeLKwQAGsDhjaHnJZqrKqvUWto14hWVVLU5WpI
 243i6BTU/nlzdHH51n7QhlaXiWnAiVI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-ff4IN_n-NkOohzPRVD6WBQ-1; Mon, 03 Aug 2020 16:59:41 -0400
X-MC-Unique: ff4IN_n-NkOohzPRVD6WBQ-1
Received: by mail-qv1-f71.google.com with SMTP id d1so11921944qvs.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fjTvqLs5kODLJE0NPlW/uTfO7Hwyt71PbjjTwHT15mk=;
 b=ZEG4np6BrKSHE+8cKLn7oTgUwAIsaei5UPONzs/4gKKsr8VnvrG4fEfObriDP5po4s
 grVBbLGkrIW7Ny9yCejkjfXtlfaNflonU3A1FEG1mxI1e16ax9WyRJ0jdiEVhp0xAXNq
 nR+JiVb+OPa1uknNa0UDvdedhfQW4I38AiAvZ8edLaPIYBuu3kjDtBViAfEQWp9Yl92y
 xBmC4oopfh3u6A4Jx70jYlSzV0i60vjlFUQAwJ2KCPMuxURLiP5hdGQxNWiMmKq9YOUF
 5Y1sppbsn5OSDCdGrWlhdqWHpmyf/8/SK6aC1YVYfoAINGoIztO8fZ87A69IJzF/Fujx
 ey7Q==
X-Gm-Message-State: AOAM533wqhF03CwNcq6xG3B6m420c6L8ho0y2Ucnk7x80nJ/Ujpf3Dz2
 lNZYGCRN2uzT1inVyMGzhAgFP7PVjbgt3kLhNGYl+a+9V0ZBf/MpB6ri4gYdUVtMjq7HJy+BnSS
 DALFzEGLySJ+BEkHZL5Cq9o8pwMh+O1bOvTzkuPh2Ig==
X-Received: by 2002:a0c:9b96:: with SMTP id o22mr9972778qve.213.1596488381232; 
 Mon, 03 Aug 2020 13:59:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEguqZOe3xZZy/pY+5yOtpUFeU9lmaquTNGOLViCY4ibIUj0Gv+q+QgMy1YzWYJl71ATFrZg==
X-Received: by 2002:a0c:9b96:: with SMTP id o22mr9972745qve.213.1596488380695; 
 Mon, 03 Aug 2020 13:59:40 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id l31sm24419314qtc.33.2020.08.03.13.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:59:40 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:59:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/24] virtio_net: correct tags for config space fields
Message-ID: <20200803205814.540410-15-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

Tag config space fields as having virtio endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_net.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 19d23e5baa4e..27d996f29dd1 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -87,19 +87,19 @@ struct virtio_net_config {
 	/* The config defining mac address (if VIRTIO_NET_F_MAC) */
 	__u8 mac[ETH_ALEN];
 	/* See VIRTIO_NET_F_STATUS and VIRTIO_NET_S_* above */
-	__u16 status;
+	__virtio16 status;
 	/* Maximum number of each of transmit and receive queues;
 	 * see VIRTIO_NET_F_MQ and VIRTIO_NET_CTRL_MQ.
 	 * Legal values are between 1 and 0x8000
 	 */
-	__u16 max_virtqueue_pairs;
+	__virtio16 max_virtqueue_pairs;
 	/* Default maximum transmit unit advice */
-	__u16 mtu;
+	__virtio16 mtu;
 	/*
 	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
 	 * Any other value stands for unknown.
 	 */
-	__u32 speed;
+	__virtio32 speed;
 	/*
 	 * 0x00 - half duplex
 	 * 0x01 - full duplex
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
