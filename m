Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEDEC433FE
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 04:14:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0949B60F4A;
	Mon, 28 Nov 2022 04:14:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0949B60F4A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=eS+8uiL0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D_zEgarrAR1T; Mon, 28 Nov 2022 04:14:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A441C60F4E;
	Mon, 28 Nov 2022 04:14:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A441C60F4E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CD14C0032;
	Mon, 28 Nov 2022 04:14:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7250BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 04:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4ACB0408BF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 04:14:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4ACB0408BF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net
 header.a=rsa-sha256 header.s=dreamhost header.b=eS+8uiL0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08ueaWipn4Qw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 04:14:43 +0000 (UTC)
X-Greylist: delayed 00:07:20 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE94A4018B
Received: from black.elm.relay.mailchannels.net
 (black.elm.relay.mailchannels.net [23.83.212.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE94A4018B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 04:14:42 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 975B5921721;
 Mon, 28 Nov 2022 04:07:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a283.dreamhost.com (unknown [127.0.0.6])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 2996E9212EF;
 Mon, 28 Nov 2022 04:07:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1669608440; a=rsa-sha256;
 cv=none;
 b=lU4rom3mdnyyeuG2OY4NSDxMEOWsl3IBH2TPVhvULpKNqHT13b2kDgfC12Sda9nklvbrrA
 pPzGLktmEStIztGkWciq6n0E5QIlwx+qJE1uVhbMaFFCOKbGNLAwAVYDohprpY7bPmiEmZ
 BbQ7a8Xl1XA5sVpdmXveKpGzt1ZygZvel67nej4uECWYamWwnVZ3e+YKRF3m0XssiY/8/7
 Kai61YwiovlrbJZXeXXAMvXsS3LbtWGauVJurb3BWrj1epftAwfoVwD+xbGbLPrP6arEua
 6hKo+BVXatfV5H4KGknrGBYityaAHCLhCelFFh6xZpJ4hkQz2vcO5F6voJ3hnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1669608440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=SKbnCvjMYXVAHe2AiOxYz31B4/GkUnKWltlmDgeCdug=;
 b=A3epQhUYPN8q2UQYMuBZv3EITmt7GlAbdhnRXy20fQ7dh7H75zaaYQIiPA1+R02P3i45KZ
 9pSaRKBjmHKAZXD4TQoiN2uCzlIIW5NraL9R5OFqHKl7BzkOEKpuu0tX8uVNtSrx5s77J+
 /jEfa2LF/N74ty/nLx4pHTSNPOe6wrDM3NqYfzsQQBjOLiJKQPhceVtyOzcTLwqnCcuCut
 +1inyossFUhhzXWaI3jDU5szT3FEKjqrJ+8F6vhRXgw1bOUTsIsmc/IgYGwxnsPgw3zcNW
 t4NVsr8Ip1rKzTJMZYDAlMo1ZE5IOEJvdEcDZzjzPM+tDWu1x394KQAD40FB4w==
ARC-Authentication-Results: i=1; rspamd-84789cff4b-smsx9;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cold-Abortive: 345b32716bfc5789_1669608440418_1916038887
X-MC-Loop-Signature: 1669608440418:3640735801
X-MC-Ingress-Time: 1669608440418
Received: from pdx1-sub0-mail-a283.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.97.48.119 (trex/6.7.1); Mon, 28 Nov 2022 04:07:20 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net
 [72.199.50.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a283.dreamhost.com (Postfix) with ESMTPSA id 4NLBkb4ygsz8p; 
 Sun, 27 Nov 2022 20:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1669608440;
 bh=SKbnCvjMYXVAHe2AiOxYz31B4/GkUnKWltlmDgeCdug=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=eS+8uiL0P+icyCZsAoPiH5GCxz99YBLavwqwBPaxs+67HC58MdfgMDHtMWgpqpOHL
 h1MxjBbuQbscIHvxHgOI6f3Pm9BdcWpCW3fSR2Co1f6CU56wLGNgJLTQZtteIeLwZy
 Of+nBCIdquK8ndoK8EApmgL2EBpE/4glAokFYUlrTMPmYW46Cz6nucSJ/wnon1MrvM
 IBCkRR/oFfZAaiIkGePQ+czhEca8O8Hv2ORF9HFJyuEEHsk1k1WoFjd9Dxi7HFGfyu
 xokY321ahBaOsdc2AF36CPQMRtbdecTRzrhZF7CmaS2/y8Pbq4DpSuEH4kMwRySwfb
 K48kWnYWQFUTw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: mst@redhat.com
Subject: [PATCH 1/2] tools/virtio: remove stray characters
Date: Sun, 27 Nov 2022 19:43:46 -0800
Message-Id: <20221128034347.990-2-dave@stgolabs.net>
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

__read_once_size() is not a macro, remove those '/'s.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/virtio/ringtest/main.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index 6d1fccd3d86c..9ed09caa659e 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -149,16 +149,16 @@ static inline void busy_wait(void)
 static __always_inline
 void __read_once_size(const volatile void *p, void *res, int size)
 {
-        switch (size) {                                                 \
-        case 1: *(unsigned char *)res = *(volatile unsigned char *)p; break;              \
-        case 2: *(unsigned short *)res = *(volatile unsigned short *)p; break;            \
-        case 4: *(unsigned int *)res = *(volatile unsigned int *)p; break;            \
-        case 8: *(unsigned long long *)res = *(volatile unsigned long long *)p; break;            \
-        default:                                                        \
-                barrier();                                              \
-                __builtin_memcpy((void *)res, (const void *)p, size);   \
-                barrier();                                              \
-        }                                                               \
+	switch (size) {
+	case 1: *(unsigned char *)res = *(volatile unsigned char *)p; break;
+	case 2: *(unsigned short *)res = *(volatile unsigned short *)p; break;
+	case 4: *(unsigned int *)res = *(volatile unsigned int *)p; break;
+	case 8: *(unsigned long long *)res = *(volatile unsigned long long *)p; break;
+	default:
+		barrier();
+		__builtin_memcpy((void *)res, (const void *)p, size);
+		barrier();
+	}
 }
 
 static __always_inline void __write_once_size(volatile void *p, void *res, int size)
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
