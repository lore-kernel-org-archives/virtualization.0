Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E27CD484A
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 17:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9766081E7F;
	Fri, 22 Sep 2023 17:51:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9766081E7F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dA3Dt089
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vg_IcK1JPEgF; Fri, 22 Sep 2023 17:51:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 22BB381E72;
	Fri, 22 Sep 2023 17:51:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22BB381E72
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2F9FC0071;
	Fri, 22 Sep 2023 17:51:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AA24C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 163D741DE7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:51:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 163D741DE7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dA3Dt089
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WJ_-kJHh2Ecp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:51:18 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D99F6402A2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 17:51:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D99F6402A2
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-54290603887so1789988a12.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695405077; x=1696009877;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6FhFEbneXxxaBPpeUpxOqm5me+1wuH+iOEgRRKvJoLs=;
 b=dA3Dt089kMhH+sjTGWN4AEnj5zpN6JJJDvF9HkIJ7/cOq/AG1pVLanLsl8ebnyfyfa
 RnzzWyWkPyJud8Th9aZcjHK65+OTwkYT2r2pvg8DTLw8EtsSDq7YH+sIdyJa5iJpzwg6
 nm0gjf8D9SIWw3ggVpHh34YdNFmkjZ2sbakIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695405077; x=1696009877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6FhFEbneXxxaBPpeUpxOqm5me+1wuH+iOEgRRKvJoLs=;
 b=fwpy5hXC1dxS1kNSOkrBzsGz95CZIzfqSuJGNOCVxXo2iMwL3bTB9h077S5qodr1Lz
 7KB1ZyxUPgbD8286gtI1u1xiTz6/ITq/EnQbdrqskkvYVOMMIjJZ/6SpS8jnYrGf+N73
 a6HBEo8l+RA8bZzCkqT/aK05kL75i5nCw0C+9rgafffzrawMSUdXdjYOR2YAXzHfQtdk
 7tXqz0saNQl9IK7DlcpzkyGd8v9euzv762vjvQl1v2a19tmm0JCwUDllUXrqvqMdOJUJ
 5fc+jf7tYsPs5awU75smnUUFP5Oh7wK83hckrKATJ17akk7eHoetpyMbP2hfmzFGfbNZ
 rtmQ==
X-Gm-Message-State: AOJu0YzOIG3e+kmb+N3b+nPBAhSWPb5iUm51iv8TwrStTHyPtKiOACzS
 5VWF8MJ2IJhl6gHFwMJHsgE3JA==
X-Google-Smtp-Source: AGHT+IGbdv9VwbwNAFjuBeDTZqWEmq6Cgd7EZVO0zimsbEWBFdYx8gilTv66w2ACi0U7EPXn8wEnXg==
X-Received: by 2002:a17:903:11c9:b0:1bc:844:5831 with SMTP id
 q9-20020a17090311c900b001bc08445831mr94508plh.57.1695405077190; 
 Fri, 22 Sep 2023 10:51:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 jf11-20020a170903268b00b001c0a4146961sm3792429plb.19.2023.09.22.10.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 10:51:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Amit Shah <amit@kernel.org>
Subject: [PATCH] virtio_console: Annotate struct port_buffer with __counted_by
Date: Fri, 22 Sep 2023 10:51:15 -0700
Message-Id: <20230922175115.work.059-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=keescook@chromium.org; 
 h=from:subject:message-id;
 bh=hLc6EjIakpzsaX2PmH9KGXcoCU7k7VxuxAddnu5wvP4=; 
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdQT7dSBQHc/s6zgQ1bG9pZSaUdLcPzEWU5q+
 UW8H+WTeDCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UEwAKCRCJcvTf3G3A
 JvOmEACk0QTdWB4H9s0DTbpqXHzvscY+UZub5Qt5LP0HSsv4VUHS2VqKK302oSkpmjRd6PnScRR
 CgD59KxXDfrn0HXWKbgYGs9RBY9LB/BYhtrPIB+oA4X2l2bejqg//JPkCS5c3YQqgZslnuhfY+K
 2qWoHc1d1Q51y6JIDeheahZwH2BAv/dhFLmVYKUtR2CMk6muErN/cf6KqtBMdaqmPZ3PDtnHnnG
 M4+CHKXrUvsM99Lcvi6rtZ+r4n5q6CcSns7LnRTpajJJesE0zXK5GHp36jbRQ06nZzMWRztHxt8
 bNaRpaV55BWkecXEOURmiGWFxtqwNgaUeY/uBYqsl2ND5izgFB8mnE7jPdvkQNUPaQbbBSsyXc2
 xm0/NYMUo+aUXRSqxSptEQhc1ANGAwMUx8tt+8y9JpsZP/2691w3VuXNzp/pCtK4j8a4sJrJ/on
 XMA/XKEbifZ3ep9LXPAHWWlwjSVSvw0jzJ8ZgeKWjQTvb09AawkDpXmhUr8r1bSCoKQksybOR6S
 sRo2x2Xc4LL44AKxKWTZ9HhOzAn/iScJowWZki3dOZrMvsN5Gved36lKyWWuFQifTANbzNIPFvR
 1K35LT2O+9RZkieJErqb3GdNTuAQLgzFnrq4CtpzXoKu/Tst3IylFRzlkloZnU+cgGX1uqfgtv1
 OWDskmG st82qa8Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp;
 fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, linux-hardening@vger.kernel.org,
 Tom Rix <trix@redhat.com>
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

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct port_buffer.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 680d1ef2a217..431e9e5bf9c1 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -106,7 +106,7 @@ struct port_buffer {
 	unsigned int sgpages;
 
 	/* sg is used if spages > 0. sg must be the last in is struct */
-	struct scatterlist sg[];
+	struct scatterlist sg[] __counted_by(sgpages);
 };
 
 /*
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
