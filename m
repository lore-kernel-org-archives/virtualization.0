Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AC8C53210
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 02:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EFE7440527;
	Tue, 27 Dec 2022 02:25:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFE7440527
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=2CQrI3y9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id suk6OHteWNjr; Tue, 27 Dec 2022 02:25:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5F42C404BA;
	Tue, 27 Dec 2022 02:25:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F42C404BA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35C06C0035;
	Tue, 27 Dec 2022 02:25:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97B60C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 662C18137E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 662C18137E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=2CQrI3y9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZTS_KLFfEEZI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D01281314
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D01281314
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:41 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id d15so12035295pls.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 18:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5haqsSicJ1y5JAf4DzHeYZjjvPaH/eOCnQ95phXljnc=;
 b=2CQrI3y9LCx/RRrNUdJU8EApVGWI0esJTePaxBlTM7cbLOWb64WOVFKVPTPXKnkbI9
 6xp4P8D5Hmjz6+nF3q95kJgycSRDDHByKChF8H2CrtipRLijEJRFOOLGgiox9RiH2k2S
 IDCeNI5PeeHoO4vP6MQEI+23PmkpRM7EvKVR2QqxImQWYiUjUZNtDAVjAYoxVE/OF4F8
 Ba540u1tNN5l1PSh1DgEfxTEH4lyB+l6Iw2zt149mKjROirMIT+ISOI2OhiZxtJe+wBL
 Y2UwBV0d09p907V7RMOTsUvlggvnaq/Mh/8o99XjnJdZSXnlAurRXwXY187X1DsQvQAQ
 VqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5haqsSicJ1y5JAf4DzHeYZjjvPaH/eOCnQ95phXljnc=;
 b=kal9qp4MGLvARKPNkTZSDUjjh0cOoW2vn35FsaCnQ+2Z8eVVLgQS9RPzCQaRErvkME
 Cufi4e/0i4Y6dAsSE29pyAusfU6ZrnMSYw5TITJ4IaWzzod9plZ03D+/vM0z4tKp+5yT
 SjXVhJJrM2jqKZIWBb+Tg1dbnThQpiIV3rtWQ1brWlwlpcNk8BzgRwJG6oppVvaOujAq
 /EyN1HtxYqPAPa3NBpivEMRsAPnFzxAWtDzc4/nVRkqjaRkWQBQYbXPlebn6tXQEDRLO
 Zw9GOrhz0nfYnfaUSZVc2Cngss6medLwJfS62OeFFTEN8oXkvD0Jl1SqrNVaIDBuQ+7v
 eGlg==
X-Gm-Message-State: AFqh2kq3mXSX2cstjC8knDFnlm4xgwgD26PimdW5CoR250tW6fyE2HBE
 2+tDllWe1Rws/sCIGWt5uBiZVg==
X-Google-Smtp-Source: AMrXdXuBf0YmaVtc2Str53QshIsQ5jNRTxQJluF/BUCseYuqpswPq5ANFNlIIq9O+nFVAMm0wV7D1g==
X-Received: by 2002:a17:902:da86:b0:191:1987:9f69 with SMTP id
 j6-20020a170902da8600b0019119879f69mr31083660plx.35.1672107941111; 
 Mon, 26 Dec 2022 18:25:41 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a1709026f0f00b001870dc3b4c0sm2465014plk.74.2022.12.26.18.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 18:25:40 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH 2/9] vringh: remove vringh_iov and unite to vringh_kiov
Date: Tue, 27 Dec 2022 11:25:24 +0900
Message-Id: <20221227022528.609839-3-mie@igel.co.jp>
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

struct vringh_iov is defined to hold userland addresses. However, to use
common function, __vring_iov, finally the vringh_iov converts to the
vringh_kiov with simple cast. It includes compile time check code to make
sure it can be cast correctly.

To simplify the code, this patch removes the struct vringh_iov and unifies
APIs to struct vringh_kiov.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/vhost/vringh.c | 32 ++++++------------------------
 include/linux/vringh.h | 45 ++++--------------------------------------
 2 files changed, 10 insertions(+), 67 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 828c29306565..aa3cd27d2384 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -691,8 +691,8 @@ EXPORT_SYMBOL(vringh_init_user);
  * calling vringh_iov_cleanup() to release the memory, even on error!
  */
 int vringh_getdesc_user(struct vringh *vrh,
-			struct vringh_iov *riov,
-			struct vringh_iov *wiov,
+			struct vringh_kiov *riov,
+			struct vringh_kiov *wiov,
 			bool (*getrange)(struct vringh *vrh,
 					 u64 addr, struct vringh_range *r),
 			u16 *head)
@@ -708,26 +708,6 @@ int vringh_getdesc_user(struct vringh *vrh,
 	if (err == vrh->vring.num)
 		return 0;
 
-	/* We need the layouts to be the identical for this to work */
-	BUILD_BUG_ON(sizeof(struct vringh_kiov) != sizeof(struct vringh_iov));
-	BUILD_BUG_ON(offsetof(struct vringh_kiov, iov) !=
-		     offsetof(struct vringh_iov, iov));
-	BUILD_BUG_ON(offsetof(struct vringh_kiov, i) !=
-		     offsetof(struct vringh_iov, i));
-	BUILD_BUG_ON(offsetof(struct vringh_kiov, used) !=
-		     offsetof(struct vringh_iov, used));
-	BUILD_BUG_ON(offsetof(struct vringh_kiov, max_num) !=
-		     offsetof(struct vringh_iov, max_num));
-	BUILD_BUG_ON(sizeof(struct iovec) != sizeof(struct kvec));
-	BUILD_BUG_ON(offsetof(struct iovec, iov_base) !=
-		     offsetof(struct kvec, iov_base));
-	BUILD_BUG_ON(offsetof(struct iovec, iov_len) !=
-		     offsetof(struct kvec, iov_len));
-	BUILD_BUG_ON(sizeof(((struct iovec *)NULL)->iov_base)
-		     != sizeof(((struct kvec *)NULL)->iov_base));
-	BUILD_BUG_ON(sizeof(((struct iovec *)NULL)->iov_len)
-		     != sizeof(((struct kvec *)NULL)->iov_len));
-
 	*head = err;
 	err = __vringh_iov(vrh, *head, (struct vringh_kiov *)riov,
 			   (struct vringh_kiov *)wiov,
@@ -740,14 +720,14 @@ int vringh_getdesc_user(struct vringh *vrh,
 EXPORT_SYMBOL(vringh_getdesc_user);
 
 /**
- * vringh_iov_pull_user - copy bytes from vring_iov.
+ * vringh_iov_pull_user - copy bytes from vring_kiov.
  * @riov: the riov as passed to vringh_getdesc_user() (updated as we consume)
  * @dst: the place to copy.
  * @len: the maximum length to copy.
  *
  * Returns the bytes copied <= len or a negative errno.
  */
-ssize_t vringh_iov_pull_user(struct vringh_iov *riov, void *dst, size_t len)
+ssize_t vringh_iov_pull_user(struct vringh_kiov *riov, void *dst, size_t len)
 {
 	return vringh_iov_xfer(NULL, (struct vringh_kiov *)riov,
 			       dst, len, xfer_from_user);
@@ -755,14 +735,14 @@ ssize_t vringh_iov_pull_user(struct vringh_iov *riov, void *dst, size_t len)
 EXPORT_SYMBOL(vringh_iov_pull_user);
 
 /**
- * vringh_iov_push_user - copy bytes into vring_iov.
+ * vringh_iov_push_user - copy bytes into vring_kiov.
  * @wiov: the wiov as passed to vringh_getdesc_user() (updated as we consume)
  * @src: the place to copy from.
  * @len: the maximum length to copy.
  *
  * Returns the bytes copied <= len or a negative errno.
  */
-ssize_t vringh_iov_push_user(struct vringh_iov *wiov,
+ssize_t vringh_iov_push_user(struct vringh_kiov *wiov,
 			     const void *src, size_t len)
 {
 	return vringh_iov_xfer(NULL, (struct vringh_kiov *)wiov,
diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 1991a02c6431..733d948e8123 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -79,18 +79,6 @@ struct vringh_range {
 	u64 offset;
 };
 
-/**
- * struct vringh_iov - iovec mangler.
- *
- * Mangles iovec in place, and restores it.
- * Remaining data is iov + i, of used - i elements.
- */
-struct vringh_iov {
-	struct iovec *iov;
-	size_t consumed; /* Within iov[i] */
-	unsigned i, used, max_num;
-};
-
 /**
  * struct vringh_kiov - kvec mangler.
  *
@@ -113,44 +101,19 @@ int vringh_init_user(struct vringh *vrh, u64 features,
 		     vring_avail_t __user *avail,
 		     vring_used_t __user *used);
 
-static inline void vringh_iov_init(struct vringh_iov *iov,
-				   struct iovec *iovec, unsigned num)
-{
-	iov->used = iov->i = 0;
-	iov->consumed = 0;
-	iov->max_num = num;
-	iov->iov = iovec;
-}
-
-static inline void vringh_iov_reset(struct vringh_iov *iov)
-{
-	iov->iov[iov->i].iov_len += iov->consumed;
-	iov->iov[iov->i].iov_base -= iov->consumed;
-	iov->consumed = 0;
-	iov->i = 0;
-}
-
-static inline void vringh_iov_cleanup(struct vringh_iov *iov)
-{
-	if (iov->max_num & VRINGH_IOV_ALLOCATED)
-		kfree(iov->iov);
-	iov->max_num = iov->used = iov->i = iov->consumed = 0;
-	iov->iov = NULL;
-}
-
 /* Convert a descriptor into iovecs. */
 int vringh_getdesc_user(struct vringh *vrh,
-			struct vringh_iov *riov,
-			struct vringh_iov *wiov,
+			struct vringh_kiov *riov,
+			struct vringh_kiov *wiov,
 			bool (*getrange)(struct vringh *vrh,
 					 u64 addr, struct vringh_range *r),
 			u16 *head);
 
 /* Copy bytes from readable vsg, consuming it (and incrementing wiov->i). */
-ssize_t vringh_iov_pull_user(struct vringh_iov *riov, void *dst, size_t len);
+ssize_t vringh_iov_pull_user(struct vringh_kiov *riov, void *dst, size_t len);
 
 /* Copy bytes into writable vsg, consuming it (and incrementing wiov->i). */
-ssize_t vringh_iov_push_user(struct vringh_iov *wiov,
+ssize_t vringh_iov_push_user(struct vringh_kiov *wiov,
 			     const void *src, size_t len);
 
 /* Mark a descriptor as used. */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
