Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2620C433E1
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A8F22C9F
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2LVuNPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A8F22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4F53E8555A;
	Mon,  3 Aug 2020 20:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6TcYu29dNalo; Mon,  3 Aug 2020 20:59:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5641C853E6;
	Mon,  3 Aug 2020 20:59:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40AEDC0050;
	Mon,  3 Aug 2020 20:59:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 739B6C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 61C0385C9E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hYgpogF82D1F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D9AC085C50
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8eHz/lbxCSjMlZVNH/34TV/YIRF5gbPoZs5VubwoF5c=;
 b=F2LVuNPQ5BYggz7boPIHdq8LdgZohx0J8M5343BqV2N00FndJ9efLHkmrvCSBtMw8mpJm3
 yTsKMN9isMZgu3qt1OUDKj9qXPz7lJJntiuIvdK8UE+1kEn0OXDJ3Lv56Ox805Z4I55DAM
 c0K+YHTSZbTmRpnmRao3sRilc21DDaE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-VpvNCgMfOlCn3hJjaIHIlQ-1; Mon, 03 Aug 2020 16:59:00 -0400
X-MC-Unique: VpvNCgMfOlCn3hJjaIHIlQ-1
Received: by mail-qk1-f197.google.com with SMTP id j7so27048732qki.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8eHz/lbxCSjMlZVNH/34TV/YIRF5gbPoZs5VubwoF5c=;
 b=HXYLHSjbql6OVUi7o6cdj+sOnZxsrqn/csvbecv1RAhTzxRihkjgJyPaV9bbShQlya
 Zbcn5nZqokJvg+2zrJmOgeZjlCT/5pSCo3DnSYExCpp42j9TQZSJPQcq/W0kOU5wvtUq
 R2pDPBeLJekC8xaom9TuXjSI9FmUvjgdWMtJ70j8MGTq/nrrRIKmNPnxpY4+VzUKxeIt
 jy3BVefp4mwo7ogBSzYHOWG/h5iX6DKaBBzCHNcHsWkw63lOvcqe6tHYGv8CWiXkh4kI
 TPAkpzJ1psQsGuBLC3ccixYWAKHl1eT+YYhQn6rwXgWlIAlq1SgqKVdJVARqsZdDYOc1
 D8zA==
X-Gm-Message-State: AOAM533TUFCYAOVOPkD5U5ygOO4N3lH5J3busECLD5pVEN8DBGd5HbQZ
 zIqX0lknCSYLEazugB4YTPrMKMcMnC2qKwP37kOtXHgtHPL9zWdBXGoeDxzWMnfrsmT8SpmQjJH
 PLVfhZ3S5a/H+n8mEy0nSL+Hu/q33hkr8WpXyVOzexw==
X-Received: by 2002:a37:b647:: with SMTP id g68mr16691697qkf.70.1596488339532; 
 Mon, 03 Aug 2020 13:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpr04+Pwki0AMTvbbWBex2pXR+QEGXSXfwWpj28UnW+RCxiaQMgdRzpparB0ZmbKWaDfeieA==
X-Received: by 2002:a37:b647:: with SMTP id g68mr16691684qkf.70.1596488339330; 
 Mon, 03 Aug 2020 13:58:59 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id o37sm24587956qte.9.2020.08.03.13.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:58:58 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:58:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/24] virtio_balloon: correct tags for config space fields
Message-ID: <20200803205814.540410-6-mst@redhat.com>
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

Tag config space fields as having little endian-ness.
Note that balloon is special: LE even when using
the legacy interface.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_balloon.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index dc3e656470dd..ddaa45e723c4 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -45,20 +45,20 @@
 #define VIRTIO_BALLOON_CMD_ID_DONE	1
 struct virtio_balloon_config {
 	/* Number of pages host wants Guest to give up. */
-	__u32 num_pages;
+	__le32 num_pages;
 	/* Number of pages we've actually got in balloon. */
-	__u32 actual;
+	__le32 actual;
 	/*
 	 * Free page hint command id, readonly by guest.
 	 * Was previously named free_page_report_cmd_id so we
 	 * need to carry that name for legacy support.
 	 */
 	union {
-		__u32 free_page_hint_cmd_id;
-		__u32 free_page_report_cmd_id;	/* deprecated */
+		__le32 free_page_hint_cmd_id;
+		__le32 free_page_report_cmd_id;	/* deprecated */
 	};
 	/* Stores PAGE_POISON if page poisoning is in use */
-	__u32 poison_val;
+	__le32 poison_val;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
