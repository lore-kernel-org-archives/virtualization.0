Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5BFC05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 09:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76BC681E9D;
	Thu,  2 Feb 2023 09:09:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76BC681E9D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=lnwrHXTm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SFXA-t_65gsi; Thu,  2 Feb 2023 09:09:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC52681EA5;
	Thu,  2 Feb 2023 09:09:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC52681EA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C79C4C0032;
	Thu,  2 Feb 2023 09:09:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5BF7C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0249610EB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A0249610EB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=lnwrHXTm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DiXGeaj1h6yi
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80E87607F0
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 80E87607F0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:49 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id m2so1202399plg.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 01:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RMLYkSO95pUa0F6Cu2apQCJX18FS/X+Z1XVi4WpAM8=;
 b=lnwrHXTmExnnyNYgz74oH23XeAVX8+/SsE4zJ+GC4CZY+kMas+zg9v4MfLh4yC6BmV
 Vg7I0LGoPg74p0Efx5Lpyt9KBWgnuIfu8zcqWvo3Kl8yj1RzNxPvb/gqy/jkK/1g1Czy
 YMVfpn95T6dT0ym0mmUpBnfZN98cSoV5hlke77oMv1UnHr/vdEIzL0CgytLEYhuVnflo
 7+yMjg5MTdo+oNyUwj866U4jfH23qmMDvKsSER1LgQ//yZzWfvPvx5/BJO8vMobr+o0Z
 FjPc+F6O653XmaiuyADkjf0B+AaeVHwhwIdqJOeoky8RIywRS5dGTNQucbUI7zTIwTNF
 ckCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RMLYkSO95pUa0F6Cu2apQCJX18FS/X+Z1XVi4WpAM8=;
 b=8D1NSYCswBz/NLh5qIalgDtzlPbz46/dIfFTjg/ypP5F2x/iZaV04Hc01rJhCp5VkS
 BEZAlE4vXiCjSkXOCv798BY2KPPnkFNyJ6LdlpXAPfIXL8amNq3RKrgKP2uzEkAjhxdB
 2HxLzDHGFsaS3koHCovhj7Mk8MlyA/R4HjLEu+spbkIZxdIIxdcf40+pNDSOreAgVZdc
 mEouWNWTxbehSLx00XuO2c5hmqs8h6zjjTMZWfRY4g/xPYYy2rIm2B/c+8UGt0l4tuQN
 LDxoS79Mz0sZ+NLoYxEqjth1wVqxZjzWWmKSw+K6Rc2E+clBKPJ5xwFUbfJ38EUWR+Nr
 LH9A==
X-Gm-Message-State: AO0yUKWJ9T6ShsCaaPiyVMlHHqBRqPYi7pcfrKMAu8IcG48uFIgzJNka
 IivM+Bn6q0GXaGCv2AqX8zwX2g==
X-Google-Smtp-Source: AK7set8TPdsc4qE+Ezq8fdne6seP2FMhU34jrF5Xw3efQHfet86AMSJnW6BukP9zSGqQIKKw12cXxQ==
X-Received: by 2002:a17:903:1d2:b0:196:2ade:6e21 with SMTP id
 e18-20020a17090301d200b001962ade6e21mr8155036plh.14.1675328988955; 
 Thu, 02 Feb 2023 01:09:48 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 ik12-20020a170902ab0c00b001929827731esm13145968plb.201.2023.02.02.01.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 01:09:48 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH v2 3/7] vringh: remove vringh_iov and unite to vringh_kiov
Date: Thu,  2 Feb 2023 18:09:30 +0900
Message-Id: <20230202090934.549556-4-mie@igel.co.jp>
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
index 33eb941fcf15..bcdbde1d484e 100644
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
