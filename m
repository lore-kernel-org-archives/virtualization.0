Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262DFC61DA4
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 09:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44E2B81ED9;
	Thu,  2 Feb 2023 09:10:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44E2B81ED9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=RHAYUhhi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UpDkEEZPl4FO; Thu,  2 Feb 2023 09:10:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 34F5981EC0;
	Thu,  2 Feb 2023 09:10:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34F5981EC0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71FD1C007F;
	Thu,  2 Feb 2023 09:09:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DD15C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D687281EA9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D687281EA9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RMrhmxuE7mLy
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F284A81EA5
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F284A81EA5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:56 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 v6-20020a17090ad58600b00229eec90a7fso5495459pju.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 01:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fw1zp7wA+/zxFPe9++9b6RsIhQH1xDXghkXPllMc2n4=;
 b=RHAYUhhi7m4bqCve8jy5sn9GcndvUwRsO5MFk+Ps48SogJBHXlDFp0+/Ek9xa63hAN
 6HaoBk3raAJUX4HZChXQu6Di4nWjHlbVRDza+0tmX+oNn7PWgyTH1t/ebxyAG10kWWKL
 KSWrjnCUHG9z+rBxjkTozSwsYfDTwBrbwnRkap/NvlxNm/R0v5m/nUPdSCEwpUIODcg2
 wUc/ssK5jXWrU2hIeFSbc1gmKqD2Oq4b5Xk+JoHUs8s7vK+rCAQxB5lrMtXXh/Ihq5Id
 //hqWWtLv2vNcZmYMIBScxffN/zTu57fOcX71sXBqVQGiLQ7VSetmEr/NbFPEFtdbwuL
 NrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fw1zp7wA+/zxFPe9++9b6RsIhQH1xDXghkXPllMc2n4=;
 b=CmfqWvUt8fvM9Ec4f/rkgzkVEJT2qPe971aM6kSmllRQiKIGjbcg7ZmNaPHYipLg1E
 /kT9nORem7Pu/7fAHelyGY3ZGmD7QAFTqExCqvBqg0xIRn78ZRDraYCz1yUCKm/JyyjK
 5NaCp2A5xWrmtGJiIFewl2hBGCbVCFcXodwpKFDCL4neL63rrz9xNLzEVzGCb9B4z21F
 aROxLTUaRItq0aax3TO2UcDo6ArgXud/npaMdvOV+tVR5tMyGzKRyS0xzuL+FbfvfkF8
 QEhEeKebkGlNr++mWJFSchrMX2NKNVx8vsMlblVCXfbsd+CAhVwEEgLaHr7/+NFbQ4C8
 HHjA==
X-Gm-Message-State: AO0yUKWXDOpH3KC0bYTOta4Ag4lP42eu2fkg3tKaZjgTJkhTRjLx9UVx
 sabGslbBS983KX574VVFxIlmQg==
X-Google-Smtp-Source: AK7set/Z8dFW1tZRKDrpRGuHnjxLkBwAwsLaNrNmOiR93N9vjf72xnm3Gl2dga1GPB4aoVpiKXjhHg==
X-Received: by 2002:a05:6a20:b046:b0:be:22c5:92df with SMTP id
 dx6-20020a056a20b04600b000be22c592dfmr5208131pzb.16.1675328996263; 
 Thu, 02 Feb 2023 01:09:56 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 ik12-20020a170902ab0c00b001929827731esm13145968plb.201.2023.02.02.01.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 01:09:55 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH v2 6/7] tools/virtio: convert to use new unified vringh
 APIs
Date: Thu,  2 Feb 2023 18:09:33 +0900
Message-Id: <20230202090934.549556-7-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202090934.549556-1-mie@igel.co.jp>
References: <20230202090934.549556-1-mie@igel.co.jp>
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

vringh_*_user APIs is being removed without vringh_init_user(). so change
to use new APIs.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 tools/virtio/vringh_test.c | 89 +++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 45 deletions(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 6c9533b8a2ca..068c6d5aa4fd 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -187,7 +187,7 @@ static int parallel_test(u64 features,
 
 		vring_init(&vrh.vring, RINGSIZE, host_map, ALIGN);
 		vringh_init_user(&vrh, features, RINGSIZE, true,
-				 vrh.vring.desc, vrh.vring.avail, vrh.vring.used);
+				 vrh.vring.desc, vrh.vring.avail, vrh.vring.used, getrange);
 		CPU_SET(first_cpu, &cpu_set);
 		if (sched_setaffinity(getpid(), sizeof(cpu_set), &cpu_set))
 			errx(1, "Could not set affinity to cpu %u", first_cpu);
@@ -202,9 +202,9 @@ static int parallel_test(u64 features,
 					err = vringh_get_head(&vrh, &head);
 					if (err != 0)
 						break;
-					err = vringh_need_notify_user(&vrh);
+					err = vringh_need_notify(&vrh);
 					if (err < 0)
-						errx(1, "vringh_need_notify_user: %i",
+						errx(1, "vringh_need_notify: %i",
 						     err);
 					if (err) {
 						write(to_guest[1], "", 1);
@@ -223,46 +223,45 @@ static int parallel_test(u64 features,
 						host_wiov,
 						ARRAY_SIZE(host_wiov));
 
-				err = vringh_getdesc_user(&vrh, &riov, &wiov,
-							  getrange, &head);
+				err = vringh_getdesc(&vrh, &riov, &wiov, &head);
 			}
 			if (err == 0) {
-				err = vringh_need_notify_user(&vrh);
+				err = vringh_need_notify(&vrh);
 				if (err < 0)
-					errx(1, "vringh_need_notify_user: %i",
+					errx(1, "vringh_need_notify: %i",
 					     err);
 				if (err) {
 					write(to_guest[1], "", 1);
 					notifies++;
 				}
 
-				if (!vringh_notify_enable_user(&vrh))
+				if (!vringh_notify_enable(&vrh))
 					continue;
 
 				/* Swallow all notifies at once. */
 				if (read(to_host[0], buf, sizeof(buf)) < 1)
 					break;
 
-				vringh_notify_disable_user(&vrh);
+				vringh_notify_disable(&vrh);
 				receives++;
 				continue;
 			}
 			if (err != 1)
-				errx(1, "vringh_getdesc_user: %i", err);
+				errx(1, "vringh_getdesc: %i", err);
 
 			/* We simply copy bytes. */
 			if (riov.used) {
-				rlen = vringh_iov_pull_user(&riov, rbuf,
+				rlen = vringh_iov_pull(&vrh, &riov, rbuf,
 							    sizeof(rbuf));
 				if (rlen != 4)
-					errx(1, "vringh_iov_pull_user: %i",
+					errx(1, "vringh_iov_pull: %i",
 					     rlen);
 				assert(riov.i == riov.used);
 				written = 0;
 			} else {
-				err = vringh_iov_push_user(&wiov, rbuf, rlen);
+				err = vringh_iov_push(&vrh, &wiov, rbuf, rlen);
 				if (err != rlen)
-					errx(1, "vringh_iov_push_user: %i",
+					errx(1, "vringh_iov_push: %i",
 					     err);
 				assert(wiov.i == wiov.used);
 				written = err;
@@ -270,14 +269,14 @@ static int parallel_test(u64 features,
 		complete:
 			xfers++;
 
-			err = vringh_complete_user(&vrh, head, written);
+			err = vringh_complete(&vrh, head, written);
 			if (err != 0)
-				errx(1, "vringh_complete_user: %i", err);
+				errx(1, "vringh_complete: %i", err);
 		}
 
-		err = vringh_need_notify_user(&vrh);
+		err = vringh_need_notify(&vrh);
 		if (err < 0)
-			errx(1, "vringh_need_notify_user: %i", err);
+			errx(1, "vringh_need_notify: %i", err);
 		if (err) {
 			write(to_guest[1], "", 1);
 			notifies++;
@@ -493,12 +492,12 @@ int main(int argc, char *argv[])
 	/* Set up host side. */
 	vring_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
 	vringh_init_user(&vrh, vdev.features, RINGSIZE, true,
-			 vrh.vring.desc, vrh.vring.avail, vrh.vring.used);
+			 vrh.vring.desc, vrh.vring.avail, vrh.vring.used, getrange);
 
 	/* No descriptor to get yet... */
-	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
+	err = vringh_getdesc(&vrh, &riov, &wiov, &head);
 	if (err != 0)
-		errx(1, "vringh_getdesc_user: %i", err);
+		errx(1, "vringh_getdesc: %i", err);
 
 	/* Guest puts in a descriptor. */
 	memcpy(__user_addr_max - 1, "a", 1);
@@ -520,9 +519,9 @@ int main(int argc, char *argv[])
 	vringh_kiov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
 	vringh_kiov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
-	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
+	err = vringh_getdesc(&vrh, &riov, &wiov, &head);
 	if (err != 1)
-		errx(1, "vringh_getdesc_user: %i", err);
+		errx(1, "vringh_getdesc: %i", err);
 
 	assert(riov.used == 1);
 	assert(riov.iov[0].iov_base == __user_addr_max - 1);
@@ -539,25 +538,25 @@ int main(int argc, char *argv[])
 		assert(wiov.iov[1].iov_len == 1);
 	}
 
-	err = vringh_iov_pull_user(&riov, buf, 5);
+	err = vringh_iov_pull(&vrh, &riov, buf, 5);
 	if (err != 1)
-		errx(1, "vringh_iov_pull_user: %i", err);
+		errx(1, "vringh_iov_pull: %i", err);
 	assert(buf[0] == 'a');
 	assert(riov.i == 1);
-	assert(vringh_iov_pull_user(&riov, buf, 5) == 0);
+	assert(vringh_iov_pull(&vrh, &riov, buf, 5) == 0);
 
 	memcpy(buf, "bcdef", 5);
-	err = vringh_iov_push_user(&wiov, buf, 5);
+	err = vringh_iov_push(&vrh, &wiov, buf, 5);
 	if (err != 2)
-		errx(1, "vringh_iov_push_user: %i", err);
+		errx(1, "vringh_iov_push: %i", err);
 	assert(memcmp(__user_addr_max - 3, "bc", 2) == 0);
 	assert(wiov.i == wiov.used);
-	assert(vringh_iov_push_user(&wiov, buf, 5) == 0);
+	assert(vringh_iov_push(&vrh, &wiov, buf, 5) == 0);
 
 	/* Host is done. */
-	err = vringh_complete_user(&vrh, head, err);
+	err = vringh_complete(&vrh, head, err);
 	if (err != 0)
-		errx(1, "vringh_complete_user: %i", err);
+		errx(1, "vringh_complete: %i", err);
 
 	/* Guest should see used token now. */
 	__kfree_ignore_start = __user_addr_min + vring_size(RINGSIZE, ALIGN);
@@ -589,9 +588,9 @@ int main(int argc, char *argv[])
 	vringh_kiov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
 	vringh_kiov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
-	err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
+	err = vringh_getdesc(&vrh, &riov, &wiov, &head);
 	if (err != 1)
-		errx(1, "vringh_getdesc_user: %i", err);
+		errx(1, "vringh_getdesc: %i", err);
 
 	assert(riov.max_num & VRINGH_IOV_ALLOCATED);
 	assert(riov.iov != host_riov);
@@ -605,9 +604,9 @@ int main(int argc, char *argv[])
 
 	/* Pull data back out (in odd chunks), should be as expected. */
 	for (i = 0; i < RINGSIZE * USER_MEM/4; i += 3) {
-		err = vringh_iov_pull_user(&riov, buf, 3);
+		err = vringh_iov_pull(&vrh, &riov, buf, 3);
 		if (err != 3 && i + err != RINGSIZE * USER_MEM/4)
-			errx(1, "vringh_iov_pull_user large: %i", err);
+			errx(1, "vringh_iov_pulllarge: %i", err);
 		assert(buf[0] == (char)i);
 		assert(err < 2 || buf[1] == (char)(i + 1));
 		assert(err < 3 || buf[2] == (char)(i + 2));
@@ -619,9 +618,9 @@ int main(int argc, char *argv[])
 	/* Complete using multi interface, just because we can. */
 	used[0].id = head;
 	used[0].len = 0;
-	err = vringh_complete_multi_user(&vrh, used, 1);
+	err = vringh_complete_multi(&vrh, used, 1);
 	if (err)
-		errx(1, "vringh_complete_multi_user(1): %i", err);
+		errx(1, "vringh_complete_multi(1): %i", err);
 
 	/* Free up those descriptors. */
 	ret = virtqueue_get_buf(vq, &i);
@@ -642,17 +641,17 @@ int main(int argc, char *argv[])
 	vringh_kiov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
 	for (i = 0; i < RINGSIZE; i++) {
-		err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
+		err = vringh_getdesc(&vrh, &riov, &wiov, &head);
 		if (err != 1)
-			errx(1, "vringh_getdesc_user: %i", err);
+			errx(1, "vringh_getdesc: %i", err);
 		used[i].id = head;
 		used[i].len = 0;
 	}
 	/* Make sure it wraps around ring, to test! */
 	assert(vrh.vring.used->idx % RINGSIZE != 0);
-	err = vringh_complete_multi_user(&vrh, used, RINGSIZE);
+	err = vringh_complete_multi(&vrh, used, RINGSIZE);
 	if (err)
-		errx(1, "vringh_complete_multi_user: %i", err);
+		errx(1, "vringh_complete_multi: %i", err);
 
 	/* Free those buffers. */
 	for (i = 0; i < RINGSIZE; i++) {
@@ -726,19 +725,19 @@ int main(int argc, char *argv[])
 		vringh_kiov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
 		vringh_kiov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
 
-		err = vringh_getdesc_user(&vrh, &riov, &wiov, getrange, &head);
+		err = vringh_getdesc(&vrh, &riov, &wiov, &head);
 		if (err != 1)
-			errx(1, "vringh_getdesc_user: %i", err);
+			errx(1, "vringh_getdesc: %i", err);
 
 		if (head != 0)
-			errx(1, "vringh_getdesc_user: head %i not 0", head);
+			errx(1, "vringh_getdesc: head %i not 0", head);
 
 		assert(riov.max_num & VRINGH_IOV_ALLOCATED);
 		if (getrange != getrange_slow)
 			assert(riov.used == 7);
 		else
 			assert(riov.used == 28);
-		err = vringh_iov_pull_user(&riov, buf, 29);
+		err = vringh_iov_pull(&vrh, &riov, buf, 29);
 		assert(err == 28);
 
 		/* Data should be linear. */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
