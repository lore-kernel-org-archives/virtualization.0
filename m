Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD384C4332F
	for <virtualization@archiver.kernel.org>; Tue, 31 Oct 2023 14:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E47180CEA;
	Tue, 31 Oct 2023 14:43:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E47180CEA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYN42d4C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JlhQ0tF0BDT6; Tue, 31 Oct 2023 14:43:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B30EE80C44;
	Tue, 31 Oct 2023 14:43:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B30EE80C44
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73688C0039;
	Tue, 31 Oct 2023 14:43:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56F28C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 14:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F7FE61340
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 14:43:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F7FE61340
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYN42d4C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aaxntx-v-Oav
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 14:43:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D46456129E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 14:43:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D46456129E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698763428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xXlUwrZ8a+TiVbwN/xlzrhXNH8IBziMOpwtSPkVcE7I=;
 b=DYN42d4CB4bw2sneBoTHPSP/DkNwfUMHq5RTbME45zJB+6E2HfdIhqQBehkEIdlUbLOpk2
 s6kLlWL5DMJ8HdUpm+fx/UDUDcR/VlCTQExX//aL118hyL/nBZfUWOrRK6B84fHhacK5l7
 1/aA7vc8zuHM+jvSDWznRA2ARwHKPWM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-BtjqtuxqOoWKOcP2ITW4TQ-1; Tue, 31 Oct 2023 10:43:45 -0400
X-MC-Unique: BtjqtuxqOoWKOcP2ITW4TQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6d30af2399bso1077115a34.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 07:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763424; x=1699368224;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xXlUwrZ8a+TiVbwN/xlzrhXNH8IBziMOpwtSPkVcE7I=;
 b=rwi7VTOfmmO473z81DdP3cLoCUpXU3ZPYEukt197eFwp7Jw5zQt3s2OT0DC/F83IvJ
 75bfh0CemwF+lU5W40o10hgY7wbbQAvPYLZymRDdoO4v6c97w50ZGKZxk+iawYks9qKE
 XlACMDkbXut3Ui8v9AedUZmUjrgw8/UxWepqpMt2rLbzLuFKaf/F8I1eYco+xnDQSR9f
 bZeDnqh2U+3G5XUCUKfeo6GkNxGGFcufPfDRWqSgv2BUkGGqUMbWU8YxrkEjmOOYRPyU
 j2yUuoOgUKZ3ewigOhFi5aJMfq7XGmlVi8sgGZKTgwKAqJJy2NImWDqJHEhVK5/bvPRW
 AJaQ==
X-Gm-Message-State: AOJu0YzbN1DqxpYCSEf9y7PruGzBx4u6xVUmrGFj0pXvSthsfd1MnCC3
 sW5eRgXXGRvvPZxYfN0NgK3+UpOJuKCizW163PlzxvoF/BoMsFW5a8lV10euSSZFxbQUd+ZU9n7
 HddCXEgmrFvxKdd4Q6d321oHYr78LlEI9EIm64sG7nJDpZu0gvj2xMB9vARwysDV/zuNuadYz/u
 vWwryvVKbs5zpLb88de6eSXHuhKw==
X-Received: by 2002:a05:6830:1e35:b0:6d3:a14:f3f1 with SMTP id
 t21-20020a0568301e3500b006d30a14f3f1mr2374209otr.7.1698763424357; 
 Tue, 31 Oct 2023 07:43:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFBHVEKDScky83TG83898xQYY2ysehM/b/1rfoz+oNpMActtM8216vJOH2Z5EptpCShbw5hQ==
X-Received: by 2002:a05:6830:1e35:b0:6d3:a14:f3f1 with SMTP id
 t21-20020a0568301e3500b006d30a14f3f1mr2374193otr.7.1698763424028; 
 Tue, 31 Oct 2023 07:43:44 -0700 (PDT)
Received: from step1.redhat.com ([5.179.178.82])
 by smtp.gmail.com with ESMTPSA id
 j7-20020ac84c87000000b004181e5a724csm544231qtv.88.2023.10.31.07.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:43:43 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vdpa_sim_blk: allocate the buffer zeroed
Date: Tue, 31 Oct 2023 15:43:39 +0100
Message-ID: <20231031144339.121453-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Qing Wang <qinwang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
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

Deleting and recreating a device can lead to having the same
content as the old device, so let's always allocate buffers
completely zeroed out.

Fixes: abebb16254b3 ("vdpa_sim_blk: support shared backend")
Suggested-by: Qing Wang <qinwang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index b3a3cb165795..b137f3679343 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -437,7 +437,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (blk->shared_backend) {
 		blk->buffer = shared_buffer;
 	} else {
-		blk->buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
+		blk->buffer = kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
 				       GFP_KERNEL);
 		if (!blk->buffer) {
 			ret = -ENOMEM;
@@ -495,7 +495,7 @@ static int __init vdpasim_blk_init(void)
 		goto parent_err;
 
 	if (shared_backend) {
-		shared_buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
+		shared_buffer = kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
 					 GFP_KERNEL);
 		if (!shared_buffer) {
 			ret = -ENOMEM;
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
