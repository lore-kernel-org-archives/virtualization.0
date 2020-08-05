Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F327C433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C90E2065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThqubZ6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C90E2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1B84B87742;
	Wed,  5 Aug 2020 13:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nIfGtOFZ61Re; Wed,  5 Aug 2020 13:43:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A79C786B43;
	Wed,  5 Aug 2020 13:43:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AB9BC0051;
	Wed,  5 Aug 2020 13:43:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA3C9C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B98AD877E3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iUA3zJubhZyj
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 27259875BD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4NE75uN6dBbbPR8XQJColAeceo7jKLXuooc66ABTACY=;
 b=ThqubZ6OOhiQkTZkhDY9JxmvLm+MhzP+iK6InlioC05resFGKSojYXV25iPPqZ2quo+XlR
 omTcZTR4M1X8M8BzyZ78//LKz5MFnKK3Kgfzc/A8e+uHnQNbNaTm8Xgrstz1yJIpgsCBGt
 7FIO0OQTMmHK9FOusDHve2V4vckX4Ac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-oYH_9x_zMx-MYdyzilWdSA-1; Wed, 05 Aug 2020 09:43:54 -0400
X-MC-Unique: oYH_9x_zMx-MYdyzilWdSA-1
Received: by mail-wm1-f71.google.com with SMTP id p23so2474373wmc.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4NE75uN6dBbbPR8XQJColAeceo7jKLXuooc66ABTACY=;
 b=OJ0WeAEeLje826MiLDLiTFbbujAoSPYAX2/CrWL14Pcbid/zd0fzgTshwgMF0k6LWN
 XQ+3uZtgbyYbEPQ816BFlyax/uSi9hdpEKZLntTanWTIyo58k5qtfk3p+Q/SDHULcHkU
 RkTiiLxyoKsJwhLasfUqozTJYXZQ42mfJiq2DyjCqCFOY0Z4np3DLojfvNjW7fRRtjbO
 DABjWQw0wXb+qFtjkP9RtaF3YPqWGMsJpan+3O6+GUYpu1NfxIAxvQoDsiIJJ50rLTii
 2EmNysJwsU4CDHSARC2oUpyLVtBqWwCSHxZJv2knVGGGcF0esk0yFswnHFnuZ15QXcpo
 V43g==
X-Gm-Message-State: AOAM5309V58RNKFhbTz12ktbWErtonxznJ0nFTs+HqtWJ9shlINanCRJ
 WHoMGyFvceO0q559br6XXB89SPDecAFfNEB/xHCoI7G7NQeaV4mUX9EpKIl62OZ80AAuR2yct4Z
 y5YoGAcasdxl6rfnnWj65BOmz8uu9coBtzI92dfbwsg==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr3306814wme.58.1596635033279; 
 Wed, 05 Aug 2020 06:43:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvbf5VBxq2UIHSD8lBlCOsb0tG11fiC9qNl08h72rxXtyKWMb6SnWrzJs0vLKD2J9n9C6/Ag==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr3306801wme.58.1596635033054; 
 Wed, 05 Aug 2020 06:43:53 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 j145sm3206544wmj.12.2020.08.05.06.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:43:52 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:43:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/38] virtio_mem: correct tags for config space fields
Message-ID: <20200805134226.1106164-14-mst@redhat.com>
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

TODO: check other uses of __virtioXX types in this header,
should probably be __leXX.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 include/uapi/linux/virtio_mem.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
index a9ffe041843c..70e01c687d5e 100644
--- a/include/uapi/linux/virtio_mem.h
+++ b/include/uapi/linux/virtio_mem.h
@@ -185,27 +185,27 @@ struct virtio_mem_resp {
 
 struct virtio_mem_config {
 	/* Block size and alignment. Cannot change. */
-	__u64 block_size;
+	__le64 block_size;
 	/* Valid with VIRTIO_MEM_F_ACPI_PXM. Cannot change. */
-	__u16 node_id;
+	__le16 node_id;
 	__u8 padding[6];
 	/* Start address of the memory region. Cannot change. */
-	__u64 addr;
+	__le64 addr;
 	/* Region size (maximum). Cannot change. */
-	__u64 region_size;
+	__le64 region_size;
 	/*
 	 * Currently usable region size. Can grow up to region_size. Can
 	 * shrink due to VIRTIO_MEM_REQ_UNPLUG_ALL (in which case no config
 	 * update will be sent).
 	 */
-	__u64 usable_region_size;
+	__le64 usable_region_size;
 	/*
 	 * Currently used size. Changes due to plug/unplug requests, but no
 	 * config updates will be sent.
 	 */
-	__u64 plugged_size;
+	__le64 plugged_size;
 	/* Requested size. New plug requests cannot exceed it. Can change. */
-	__u64 requested_size;
+	__le64 requested_size;
 };
 
 #endif /* _LINUX_VIRTIO_MEM_H */
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
