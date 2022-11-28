Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3605C433FE
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 04:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9952C81A92;
	Mon, 28 Nov 2022 04:16:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9952C81A92
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=Elhx8hzi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dGsbtWRMbnzD; Mon, 28 Nov 2022 04:16:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D33B81A5C;
	Mon, 28 Nov 2022 04:16:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D33B81A5C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 125AAC0032;
	Mon, 28 Nov 2022 04:16:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44316C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 04:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D3C341524
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 04:16:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D3C341524
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net
 header.a=rsa-sha256 header.s=dreamhost header.b=Elhx8hzi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MnpfvCoSIBMW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 04:16:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 277B241522
Received: from crocodile.elm.relay.mailchannels.net
 (crocodile.elm.relay.mailchannels.net [23.83.212.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 277B241522
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 04:16:01 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 14890412AA;
 Mon, 28 Nov 2022 04:07:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a283.dreamhost.com (unknown [127.0.0.6])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id A3C8041369;
 Mon, 28 Nov 2022 04:07:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669608440; a=rsa-sha256;
 cv=none;
 b=oOuCfdC2aFTU4OZ/m0PT2oQ/P9fnY+Fh9pM0MwmmyszUuHj97BnWl8LOFG+epTFI8V2hMS
 kg2SFJQAPxNmvoob/bUjsM36SaPCA8n+BFR8NBZEqanMYIwdXd8YBFJZ0z2jdAXBY6SPPF
 IP1wDStWQw3UO3CX8Da8mLmIYuwSCjXHXr+IwsS6H2n470YCm7KYG/8MgKkTv956SztvDm
 lbIrSIfr5KAuAFxkDF/khWGoc0orCUOKHaPS7eDjE2bSwvs0M5Q0bSx3BwfeNGCklI5JU/
 Br2uO2d6Pdq8tq1hzXDdO+ZfYDe003b2Wxo6s7WawNmK03oobRrnGEwljcQ9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1669608440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=cNHJgNohZbk1ATNrC2SM8HmkbxHfzP5Rb8J4WNikoEY=;
 b=7GX6vCXfBxxQI/AvknD9DT5j6ibK1ZCJK2TXsMw0yazRfTEMtwJJVm0V23njfY5q+fO5Mt
 sNoxP3mBJxlvjnmJQlN/KIEG3fYPzukxGOPTHxY0ddXvYv2SHKYGZIf/1fgsY2/iygO6kL
 ocFgLWMEcUqqzOGAoY+nwz4rEXTsU7DxWHZxnTgicn7jwF8jMbtEy1KbloTqjgcplI6mtq
 3QM8eQn3ZxTfc9ZLtZk3EciAwvb+NpHh+OCzCB08TATvHshG9dP89uNqoc0M/Yqo0nOqxh
 ErVEKfdP5OPO/0SmDpVc6CDI1+DpwjdyV3WRxKDpL8SUM1aMqrT6EfeJj+X3AQ==
ARC-Authentication-Results: i=1; rspamd-84789cff4b-5sz77;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-White-Illustrious: 5388c18734dbd4c4_1669608440906_1724246424
X-MC-Loop-Signature: 1669608440906:384576075
X-MC-Ingress-Time: 1669608440906
Received: from pdx1-sub0-mail-a283.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.116.179.104 (trex/6.7.1); Mon, 28 Nov 2022 04:07:20 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net
 [72.199.50.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a283.dreamhost.com (Postfix) with ESMTPSA id 4NLBkc1Rw9zCV; 
 Sun, 27 Nov 2022 20:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1669608440;
 bh=cNHJgNohZbk1ATNrC2SM8HmkbxHfzP5Rb8J4WNikoEY=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=Elhx8hzils/2f+pIyPwtdDOoHpK3lVoa3HliCMM/wiFtVkuE0FsyXTxN5b/7thvtY
 Acb8uHx2IOaVRqVPk2Ko6eDpCgQcTFscXpCA4bYINGTpEEffpTD0w+LFLcKRwmTlOV
 djL4MYx1A60qKiJYU7Y+O/LmlXhaKYuaxzTR1w+NGOUqTl6CVkaPpJ2t2T4VQnFb5E
 LE1gCwOHIM6Z2TJg87zvU5gcoItA+3gpFR/MptVKjfhW8TXGYSMP9cT/gxGcNBgHU5
 6V/ENYyfnI+g205auuWmnl5p91D0rEZ1FqfUahqdaxPbjsmjnRNKujZApgo0mjzhzL
 FnnJ3zNKG8VEg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: mst@redhat.com
Subject: [PATCH 2/2] tools/virtio: remove smp_read_barrier_depends()
Date: Sun, 27 Nov 2022 19:43:47 -0800
Message-Id: <20221128034347.990-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128034347.990-1-dave@stgolabs.net>
References: <20221128034347.990-1-dave@stgolabs.net>
MIME-Version: 1.0
Cc: dave@stgolabs.net, linux-kernel@vger.kernel.org,
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

This gets rid of the last references to smp_read_barrier_depends()
 which for the kernel side was removed in v5.9. The serialization
required for Alpha is done inside READ_ONCE() instead of having
users deal with it. Simply use a full barrier, the architecture
does not have rmb in the first place.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/virtio/ringtest/main.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index 9ed09caa659e..b68920d52750 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -140,12 +140,6 @@ static inline void busy_wait(void)
 #define smp_wmb() smp_release()
 #endif
 
-#ifdef __alpha__
-#define smp_read_barrier_depends() smp_acquire()
-#else
-#define smp_read_barrier_depends() do {} while(0)
-#endif
-
 static __always_inline
 void __read_once_size(const volatile void *p, void *res, int size)
 {
@@ -175,13 +169,22 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 	}
 }
 
+#ifdef __alpha__
 #define READ_ONCE(x) \
 ({									\
 	union { typeof(x) __val; char __c[1]; } __u;			\
 	__read_once_size(&(x), __u.__c, sizeof(x));		\
-	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
+	smp_mb(); /* Enforce dependency ordering from x */		\
 	__u.__val;							\
 })
+#else
+#define READ_ONCE(x)							\
+({									\
+	union { typeof(x) __val; char __c[1]; } __u;			\
+	__read_once_size(&(x), __u.__c, sizeof(x));			\
+	__u.__val;							\
+})
+#endif
 
 #define WRITE_ONCE(x, val) \
 ({							\
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
