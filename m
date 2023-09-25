Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0568CE7A81
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 10:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3DE8F40105;
	Mon, 25 Sep 2023 10:31:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DE8F40105
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ePyqz1Es
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tyfSdqDM7H2W; Mon, 25 Sep 2023 10:31:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C192F40129;
	Mon, 25 Sep 2023 10:31:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C192F40129
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9241BC0071;
	Mon, 25 Sep 2023 10:31:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6971FC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 10:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3051660792
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 10:31:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3051660792
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ePyqz1Es
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h3zjPSg36HYv
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 10:31:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB5F260BCD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 10:31:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB5F260BCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695637864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0DpECY4xgD810waS/rgF1VksorNZHYkHpCmfPvNqmEU=;
 b=ePyqz1EsLb9CWe/6RWcb3GbCQq9NpcyiGzTGv647lTewWWn39wro/EMhnqbhgF/JSASoqE
 aNWY6oAmy7mmmqkqQnHL2dm06kqM5/XjaXnMtt2/RtRVcFQbNwmyNky3L0ZprY8coQhidS
 z03mhY3QCnI/gFD8OBJ2K4WpkxJ73s4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-UwytUONOPsysnU0qxKR6vA-1; Mon, 25 Sep 2023 06:31:03 -0400
X-MC-Unique: UwytUONOPsysnU0qxKR6vA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b8405aace3so79638621fa.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 03:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695637861; x=1696242661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0DpECY4xgD810waS/rgF1VksorNZHYkHpCmfPvNqmEU=;
 b=kiQCZp8Rk70wwrb25jgV2bTnHvSYKJqfNLPgsAJcEZUlrdfUXFwnQob8HtyWVDnHEu
 DtfiVz4QebhCLogPoqHFz2AuDUOP8Q4usPNx0ojbcKSU3EfHo3jdRtA13p8P0CxfZpcA
 8cUMp50Iu9aAz6wN0K4Pf6/0+8tJJufzqCNYiD6VPkKYtBu8LZxA5ttQB5ZbcBpHTzO9
 V2xbG2ZkTBbcxZ9ps8SFt+YEI6JBMNJ3ZnIKdpwaNkmQ/M4hYTrEt2Pfd0TiRtAhUPBC
 BRDsJ5OYef1WLUNkUJfOqO9M6lqsnAHUWCx+DHAkBKtsTVO2CnDoTXfdtDOuz+2VL08V
 WM7Q==
X-Gm-Message-State: AOJu0Yxmkh6We5nCVO0nSIOfAJgyZPRYPGg5V7x1oSpk8OoeN509wfbq
 Fcf9jwxS69ylsTW5FNaHdPYPFe2OINEOJi1oT7KXUHRqJLn+81+mp+0SiwlheIVWOzzMC0MLwNN
 mpmbKe0YQWN/HowiWn+28lWmi+A+9Q172gBMhvrrYWGnCihEgr6TmuUdQ1HaBWTl96flJqM4WlH
 brs458KdoyGcr4MpDQl3SATbDWUs1T
X-Received: by 2002:a2e:8084:0:b0:2bc:fa8f:83c4 with SMTP id
 i4-20020a2e8084000000b002bcfa8f83c4mr5126305ljg.39.1695637861187; 
 Mon, 25 Sep 2023 03:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx1EwDlCVz04qbWgbyK5nfpeoyXqfQ6Qq2TBRTZPqNjJwRcJMbIuZi7IseWRVL8VlZINlyCw==
X-Received: by 2002:a2e:8084:0:b0:2bc:fa8f:83c4 with SMTP id
 i4-20020a2e8084000000b002bcfa8f83c4mr5126286ljg.39.1695637860736; 
 Mon, 25 Sep 2023 03:31:00 -0700 (PDT)
Received: from step1.lan ([46.6.235.141]) by smtp.gmail.com with ESMTPSA id
 mh2-20020a170906eb8200b0099cc3c7ace2sm6161066ejb.140.2023.09.25.03.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 03:30:59 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()
Date: Mon, 25 Sep 2023 12:30:57 +0200
Message-ID: <20230925103057.104541-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

In the while loop of vringh_iov_xfer(), `partlen` could be 0 if one of
the `iov` has 0 lenght.
In this case, we should skip the iov and go to the next one.
But calling vringh_kiov_advance() with 0 lenght does not cause the
advancement, since it returns immediately if asked to advance by 0 bytes.

Let's restore the code that was there before commit b8c06ad4d67d
("vringh: implement vringh_kiov_advance()"), avoiding using
vringh_kiov_advance().

Fixes: b8c06ad4d67d ("vringh: implement vringh_kiov_advance()")
Cc: stable@vger.kernel.org
Reported-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vringh.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 955d938eb663..7b8fd977f71c 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -123,8 +123,18 @@ static inline ssize_t vringh_iov_xfer(struct vringh *vrh,
 		done += partlen;
 		len -= partlen;
 		ptr += partlen;
+		iov->consumed += partlen;
+		iov->iov[iov->i].iov_len -= partlen;
+		iov->iov[iov->i].iov_base += partlen;
 
-		vringh_kiov_advance(iov, partlen);
+		if (!iov->iov[iov->i].iov_len) {
+			/* Fix up old iov element then increment. */
+			iov->iov[iov->i].iov_len = iov->consumed;
+			iov->iov[iov->i].iov_base -= iov->consumed;
+
+			iov->consumed = 0;
+			iov->i++;
+		}
 	}
 	return done;
 }
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
