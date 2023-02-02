Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFCBC05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 09:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2ED1C40BF3;
	Thu,  2 Feb 2023 09:09:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2ED1C40BF3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=1Q/JH/sU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TxCGm6zFC0Kj; Thu,  2 Feb 2023 09:09:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD4EF40BFF;
	Thu,  2 Feb 2023 09:09:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD4EF40BFF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95127C0032;
	Thu,  2 Feb 2023 09:09:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50531C0077
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23375419A2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23375419A2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=1Q/JH/sU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H4zaa1Qhm7Hc
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D2D7419D7
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D2D7419D7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:47 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id k13so1244387plg.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 01:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wj1wi+vfvB54wfWKyUZTobNpEfDR2hWH6JizNjshTls=;
 b=1Q/JH/sUAULTsLNVNGl+nJTH5Ax+tvJ+1r2DKsuwDfuOKK7Ec5J5bJnGtXbC45rfRC
 VynUJt6ACswjfIqa8MV8+aq8oj2HUPBfP0teYR/JHiz+uQcFDcvG0/t/1tUEWyWzCg4C
 EimV0skFo5WvorB8MwJjeN8RIM/0KZVjSL/U4Sq0/P3w8M+bciIDr8PXRPnNxwMYuhYp
 1uiIuZ1jZjWhqoykheNnB5QXWK6a0cb6X28sqYlLwQCnLc5tCl4KDqOueYTg1dZN8kaY
 gmXpt3eUAfDfZVXRPQ+OpYdbRcV6fVlEfZT1k2vMJ14BWtV2uVBge9Y8HoZ7t7JtqZDK
 i3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wj1wi+vfvB54wfWKyUZTobNpEfDR2hWH6JizNjshTls=;
 b=im1FT82gPpHfFVQxIHCRiSC+x4BgCgWheghOEugq88rzEOJ84k1XZknQI7U3EnHfPk
 Jo6PTKgRoWqGfbyLuKomcaBghJunhqlDWKAWSS4dFGaHyJHlg4ANImVoAQmU0A49x84h
 mwSJnICm4+wgRbgX4TQZL2BGtc2UEcen/5iuXsxxwFd3QFI4LG8MNt3Zr8Hc6MKW8NrN
 3VcKKWJwHP45TqdCVLluxaf9ok5OrB1MriPxZt/nbncEisonk/Xi9HTB+IYByf3yrYJh
 SNmilgagsdvS5/s7/7wtP8MZh8WFAft+0bAw6u8MCdVJCwQfs+zPGq5NoCKLEePoyZQN
 RJfg==
X-Gm-Message-State: AO0yUKVHmD6aFWdbAD23SLKD01lNgJb9ba3k9TPZCIvYFhz6QcC/twI3
 auexB81C7WKvwD2Pi118Me4DKA==
X-Google-Smtp-Source: AK7set8Mjt/sTl97PMKSnJmxqA5B1xuZBtgxd19g5SZqOTcdXWGQrZOHsyfNQ13X71sz0ldcLMsDJg==
X-Received: by 2002:a17:902:e810:b0:194:81c9:b8da with SMTP id
 u16-20020a170902e81000b0019481c9b8damr7411648plg.3.1675328986637; 
 Thu, 02 Feb 2023 01:09:46 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 ik12-20020a170902ab0c00b001929827731esm13145968plb.201.2023.02.02.01.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 01:09:46 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH v2 2/7] tools/virtio: enable to build with retpoline
Date: Thu,  2 Feb 2023 18:09:29 +0900
Message-Id: <20230202090934.549556-3-mie@igel.co.jp>
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

Add build options to bring it close to a linux kernel. It allows for
testing that is close to reality.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 tools/virtio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 1b25cc7c64bb..7b7139d97d74 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -4,7 +4,7 @@ test: virtio_test vringh_test
 virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
 
-CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
+CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register
 CFLAGS += -pthread
 LDFLAGS += -pthread
 vpath %.c ../../drivers/virtio ../../drivers/vhost
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
