Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76D9C761A6
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 13:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B7F160ADE;
	Tue,  4 Apr 2023 13:14:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B7F160ADE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gt0o+5Pg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gmiE9Xqx_Zyd; Tue,  4 Apr 2023 13:14:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DE26E60AA7;
	Tue,  4 Apr 2023 13:14:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE26E60AA7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9ED5C0036;
	Tue,  4 Apr 2023 13:14:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11539C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDD74403A7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:14:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDD74403A7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gt0o+5Pg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HQj_PDVwaC1W
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:14:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4326F4038D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4326F4038D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680614073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=reoAM7f+Ql0t7teTIED97nCtpsbVHLsQxA9mgF0KDac=;
 b=Gt0o+5PgzGayRjdwW5KsZuDvTsAi5T9fUzL+AMWR7CapBQhfiDVZmkm/cj6CBoVFJxvgCD
 f9BQdkzr/FQjIvRyaocYFZO/MQJq17DwONV+3tYzGkwPepDNnbaABO5sARBlNOz/IlOdhB
 fG8OruSmqM+sLAf8bDXBR12EibR2SSo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-5cvRQQP_O7KhVvEa3jNKMw-1; Tue, 04 Apr 2023 09:14:28 -0400
X-MC-Unique: 5cvRQQP_O7KhVvEa3jNKMw-1
Received: by mail-qv1-f72.google.com with SMTP id
 j15-20020a0cc34f000000b005c824064b10so14626811qvi.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 06:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680614065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=reoAM7f+Ql0t7teTIED97nCtpsbVHLsQxA9mgF0KDac=;
 b=5nnSnCJBiBgqY/t+TflMrc5vPNOhVmD4X3w+4v5E1cXKAqtefYQ72WTHk99fCUr2o/
 c7K8bNJXGFIowcqSkL+bVoR5AfZe4hm9acxjxHYmDgN/x+Iq0OZjG0MSKoFqfdPP+tQ1
 YVybaneyR2v2XvcMYzcQLqjUtC1MvaezML0p8BV7RfUHYjHVGNNXaa0rhf7D9bQjaGTC
 iiInlcBmkFCyFH+X9owT/cOExe81LF239j2uTyi4nqM+4L9HrZ+y0T1OWwGp0sqgY71X
 c9mU4Ar4sDeRy5xw0lZWhI258H4XqcC+NlFVerA4lxy1Uy+zmZDbmqB1+j/yxVD5sXK/
 RFKQ==
X-Gm-Message-State: AAQBX9fJN0wwwP5qKqH2490onfapukrrCPfm5gpHqPUKUMlGxMiCc/Cn
 Ek9ldFTwfZcgUms2AiCdGRC1zuA57VfPwhQVhInJ9b/f+v3PZfYdRjgdj9Abz34vXa86QJzepRy
 Krco/tjg512QEvJo436u+qT0oKTqemXx208ouFK8lkg5Dg/uhQsQqgYZ5k1cDBFFA1MBF19ArSW
 T5iOAo5GZleGHn1FWKzWFYEQzBPQ==
X-Received: by 2002:a05:6214:5285:b0:5ab:e259:b2a9 with SMTP id
 kj5-20020a056214528500b005abe259b2a9mr4079717qvb.14.1680614065572; 
 Tue, 04 Apr 2023 06:14:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350YDpSM3tbHGFHJEq145wZugdvjzWux7UVveff8duUHbuTYsIkY07f4BZ179rNQz44IJ5qQQQw==
X-Received: by 2002:a05:6214:5285:b0:5ab:e259:b2a9 with SMTP id
 kj5-20020a056214528500b005abe259b2a9mr4079658qvb.14.1680614065167; 
 Tue, 04 Apr 2023 06:14:25 -0700 (PDT)
Received: from step1.redhat.com (host-82-53-134-157.retail.telecomitalia.it.
 [82.53.134.157]) by smtp.gmail.com with ESMTPSA id
 f24-20020ac84658000000b003b9a73cd120sm3228153qto.17.2023.04.04.06.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Apr 2023 06:14:24 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v5 4/9] vringh: define the stride used for translation
Date: Tue,  4 Apr 2023 15:13:21 +0200
Message-Id: <20230404131326.44403-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404131326.44403-1-sgarzare@redhat.com>
References: <20230404131326.44403-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, stefanha@redhat.com
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

Define a macro to be reused in the different parts of the code.

Useful for the next patches where we add more arrays to manage also
translations with user VA.

Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v4:
    - added this patch with the changes extracted from the next patch [Eugenio]
    - used _STRIDE instead of _SIZE [Eugenio]

 drivers/vhost/vringh.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 0ba3ef809e48..4aee230f7622 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1141,13 +1141,15 @@ static int iotlb_translate(const struct vringh *vrh,
 	return ret;
 }
 
+#define IOTLB_IOV_STRIDE 16
+
 static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 				  void *src, size_t len)
 {
 	u64 total_translated = 0;
 
 	while (total_translated < len) {
-		struct bio_vec iov[16];
+		struct bio_vec iov[IOTLB_IOV_STRIDE];
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
@@ -1180,7 +1182,7 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 	u64 total_translated = 0;
 
 	while (total_translated < len) {
-		struct bio_vec iov[16];
+		struct bio_vec iov[IOTLB_IOV_STRIDE];
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
