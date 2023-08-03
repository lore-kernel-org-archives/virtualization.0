Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2209CC0015E
	for <virtualization@archiver.kernel.org>; Thu,  3 Aug 2023 08:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9924281437;
	Thu,  3 Aug 2023 08:55:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9924281437
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qtmfkj13
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id svvWUJROQrPL; Thu,  3 Aug 2023 08:55:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 09751813E8;
	Thu,  3 Aug 2023 08:55:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09751813E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEF1DC0071;
	Thu,  3 Aug 2023 08:55:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B322FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 08:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8588241742
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 08:55:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8588241742
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qtmfkj13
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-KXOP0k0idf
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 08:55:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C66AD405B3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 08:55:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C66AD405B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691052901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a0Qb1ZCjTg5X2iHgPbuPkClilFu2mrOZGxq+uAuigRM=;
 b=Qtmfkj13s3Y8/R/DD02MonAsfkd3XKG6Vm8AOF6/XG45oZ6aJWYTWkI/6u74L4aX9ZL13P
 bJzLmITMpXa86+6hQ2dxcXPkONgIaf4MCOXnE7X3UpS8bjeT8zeRpyIgQtEpp/XLMAJ4mt
 FNZqDz2NvKFBGOFG0D4LMtgKqTOHniE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-FL1uB3J6O0CZ-ORaqbEZBw-1; Thu, 03 Aug 2023 04:54:57 -0400
X-MC-Unique: FL1uB3J6O0CZ-ORaqbEZBw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso47231566b.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Aug 2023 01:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691052896; x=1691657696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a0Qb1ZCjTg5X2iHgPbuPkClilFu2mrOZGxq+uAuigRM=;
 b=lr/H/rHKYKBdnCdmQct7urYcac4N09gNqMYR0Pz3iEFdTJNgCJ1ZC3QycL/ibGjhB4
 PpkmNOEJQT8XXjotkMn1Ql9uhOoaUNhcGFPBzs02Foraw3a6c9PaVaNaluxY8x9vn5Sa
 Sbr9GsrROdXNLkOl2Ng9PrrZgKBmyaNYnfMvMRhztknvmhmKOR9NHbsYu2MudzsflUbw
 CF3w8TzmHjUr6cOihLEYE/J4NYebdfTqrQDq7t/nJ6iFoAW2BYQ5jKw8+f3KxhdfJs12
 oCL6oZ8PWsc5MatCXSxYLOUEJ2rzjUAxVD8lglUwQyaf3+/J4+nruOeUMD8DjKc8OsBq
 KPQQ==
X-Gm-Message-State: ABy/qLboegaCN07KL+R58KHL7ziYkRQ0ZwWaUizr0iM02lcEMlUQj1Bg
 tdzjUie8BiFHz4c3zfnOmymMUIQ5AfungQ1zX3UfHt3cMScN2xCbGYEdKGlAFGR35GNfFF2UwMv
 2RrVginN4iBXjyzspw6hlpF+KINz8hHI1Yg3Mk0RFKA==
X-Received: by 2002:a17:906:519e:b0:993:fb68:ed67 with SMTP id
 y30-20020a170906519e00b00993fb68ed67mr7034887ejk.24.1691052896530; 
 Thu, 03 Aug 2023 01:54:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHVe0KJwC7fd5aUom3TJxYmpf5W0xCgiDOUhdnqgr4ZWF5nCbowtI5xFne903dpuVY/rWA+AQ==
X-Received: by 2002:a17:906:519e:b0:993:fb68:ed67 with SMTP id
 y30-20020a170906519e00b00993fb68ed67mr7034877ejk.24.1691052896280; 
 Thu, 03 Aug 2023 01:54:56 -0700 (PDT)
Received: from step1.home (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 u17-20020a1709060b1100b0099bcf563fe6sm10239984ejg.223.2023.08.03.01.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 01:54:55 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net] test/vsock: remove vsock_perf executable on `make clean`
Date: Thu,  3 Aug 2023 10:54:54 +0200
Message-ID: <20230803085454.30897-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

We forgot to add vsock_perf to the rm command in the `clean`
target, so now we have a left over after `make clean` in
tools/testing/vsock.

Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
Cc: AVKrasnov@sberdevices.ru
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
index 43a254f0e14d..21a98ba565ab 100644
--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -8,5 +8,5 @@ vsock_perf: vsock_perf.o
 CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
 .PHONY: all test clean
 clean:
-	${RM} *.o *.d vsock_test vsock_diag_test
+	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf
 -include *.d
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
