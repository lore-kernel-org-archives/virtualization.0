Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B255C4332F
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 02:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F21B60BD0;
	Tue, 27 Dec 2022 02:25:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F21B60BD0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=PdEinY5Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U9uXrOP2e4qf; Tue, 27 Dec 2022 02:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B0DA160BCA;
	Tue, 27 Dec 2022 02:25:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B0DA160BCA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D63DC0035;
	Tue, 27 Dec 2022 02:25:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4D1BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9385940527
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9385940527
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=PdEinY5Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0AgLSsGi3ozg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA10C404ED
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA10C404ED
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:43 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 n65-20020a17090a2cc700b0021bc5ef7a14so12073717pjd.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 18:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fCw3ePbQ4sWf6yjA8O8Z29UEVxW6bYbx76RpPXO7aY=;
 b=PdEinY5QSfamx3Mg38O2RR2okv24jZTiIqqQZSzIQSP/5YXvP+Qly0wyKRgl/F1uNK
 JangFsfS4pMaDyShPoK7l8kkT9Zh44XnLQo8hUlqWrsz5qe4ILWqcvzmy/7bB35gV0xj
 oPa5StauWTQq1jb57VF3CVOllZ3LRnEAymbQLB1k1skqbLxXPkBCpUdtA5Yw6SJ1BnV0
 R2MH3gioA5e3yYrRTjTM1T/Ci+Xzh/WM2nvicePmWnVaad6WutwHYASqAk9pxsh9SI09
 Z0Y7XT5B461WhBeQqZuHi5ZIyJMHvH5RLI2+oprZjrQraOdWfe99ZOsuUD68p5Jr7mlL
 yLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fCw3ePbQ4sWf6yjA8O8Z29UEVxW6bYbx76RpPXO7aY=;
 b=eJFVuZT1VMO4yhQ3W9Pvz6/RUpxXTRAnYqd/VvJqEaFHON5c67oQl2gBPgM62Jy3E9
 9xIoo7GXiDgOe77NRCZ73xL6tKolWk4PDiQP7KCJjcr93DFniJS+XsBBQfQm3qMWDyyl
 kf+wX+ZNqVhKMDn7KnJ9ic6/HE11qKM/ECj6995Sn2e+iCofg5M+vNOSqHALCvgJ4jeR
 /A6CCpc8z+pmuonUv/KyWiP71dzC7aVrE0oJT8EG3dkoEWuMnvK1CLNN++Aj7nSl39VH
 1RK3V9bSDhlw156PVZ7kExKfpYY3IjcQMlfvZTz4/76XoAdFsFwKysGNCAlyayFeNieV
 GyOA==
X-Gm-Message-State: AFqh2kqO6DFt2IBe865jiucGJPzhXWg3QiUxnMBie+ZRyqz+xOTg4zB6
 5PwszUwM18dDJhIW8NPQlY2bCA==
X-Google-Smtp-Source: AMrXdXtibhicJEAQU7zlMTYHTx9LNjc53ZCY1j8YzALFGnjrccnlQk473w/zeMGg3h4pH4QlYbUMRQ==
X-Received: by 2002:a17:902:f706:b0:190:fc28:8cca with SMTP id
 h6-20020a170902f70600b00190fc288ccamr24903066plo.10.1672107943300; 
 Mon, 26 Dec 2022 18:25:43 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a1709026f0f00b001870dc3b4c0sm2465014plk.74.2022.12.26.18.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 18:25:43 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH 3/9] tools/virtio: convert to new vringh user APIs
Date: Tue, 27 Dec 2022 11:25:25 +0900
Message-Id: <20221227022528.609839-4-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221227022528.609839-1-mie@igel.co.jp>
References: <20221227022528.609839-1-mie@igel.co.jp>
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

struct vringh_iov is being remove, so convert vringh_test to use the
vringh user APIs. This has it change to use struct vringh_kiov instead of
the struct vringh_iov.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 tools/virtio/vringh_test.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 98ff808d6f0c..6c9533b8a2ca 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -193,8 +193,8 @@ static int parallel_test(u64 features,
 			errx(1, "Could not set affinity to cpu %u", first_cpu);
 
 		while (xfers < NUM_XFERS) {
-			struct iovec host_riov[2], host_wiov[2];
-			struct vringh_iov riov, wiov;
+			struct kvec host_riov[2], host_wiov[2];
+			struct vringh_kiov riov, wiov;
 			u16 head, written;
 
 			if (fast_vringh) {
@@ -216,10 +216,10 @@ static int parallel_test(u64 features,
 				written = 0;
 				goto complete;
 			} else {
-				vringh_iov_init(&riov,
+				vringh_kiov_init(&riov,
 						host_riov,
 						ARRAY_SIZE(host_riov));
-				vringh_iov_init(&wiov,
+				vringh_kiov_init(&wiov,
 						host_wiov,
 						ARRAY_SIZE(host_wiov));
 
@@ -442,8 +442,8 @@ int main(int argc, char *argv[])
 	struct virtqueue *vq;
 	struct vringh vrh;
 	struct scatterlist guest_sg[RINGSIZE], *sgs[2];
-	struct iovec host_riov[2], host_wiov[2];
-	struct vringh_iov riov, wiov;
+	struct kvec host_riov[2], host_wiov[2];
+	struct vringh_kiov riov, wiov;
 	struct vring_used_elem used[RINGSIZE];
 	char buf[28];
 	u16 head;
@@ -517,8 +517,8 @@ int main(int argc, char *argv[])
 	__kmalloc_fake = NULL;
 
 	/* Host retreives it. */
-	vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
-	vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
+	vringh_kiov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
+	vringh_kiov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
 	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
 	if (err != 1)
@@ -586,8 +586,8 @@ int main(int argc, char *argv[])
 	__kmalloc_fake = NULL;
 
 	/* Host picks it up (allocates new iov). */
-	vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
-	vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
+	vringh_kiov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
+	vringh_kiov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
 	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
 	if (err != 1)
@@ -613,8 +613,8 @@ int main(int argc, char *argv[])
 		assert(err < 3 || buf[2] == (char)(i + 2));
 	}
 	assert(riov.i == riov.used);
-	vringh_iov_cleanup(&riov);
-	vringh_iov_cleanup(&wiov);
+	vringh_kiov_cleanup(&riov);
+	vringh_kiov_cleanup(&wiov);
 
 	/* Complete using multi interface, just because we can. */
 	used[0].id = head;
@@ -638,8 +638,8 @@ int main(int argc, char *argv[])
 	}
 
 	/* Now get many, and consume them all at once. */
-	vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
-	vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
+	vringh_kiov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
+	vringh_kiov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
 	for (i = 0; i < RINGSIZE; i++) {
 		err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
@@ -723,8 +723,8 @@ int main(int argc, char *argv[])
 		d[5].flags = 0;
 
 		/* Host picks it up (allocates new iov). */
-		vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
-		vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
+		vringh_kiov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
+		vringh_kiov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
 		err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
 		if (err != 1)
@@ -744,7 +744,7 @@ int main(int argc, char *argv[])
 		/* Data should be linear. */
 		for (i = 0; i < err; i++)
 			assert(buf[i] == i);
-		vringh_iov_cleanup(&riov);
+		vringh_kiov_cleanup(&riov);
 	}
 
 	/* Don't leak memory... */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
