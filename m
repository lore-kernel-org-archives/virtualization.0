Return-Path: <SRS0=kXQI=NW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F244C432BE
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 06:39:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA82D60F4B
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 06:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA82D60F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B789440578;
	Tue, 31 Aug 2021 06:39:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CaZEdZgAHxyw; Tue, 31 Aug 2021 06:39:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2BC60403CD;
	Tue, 31 Aug 2021 06:39:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2CD1C001A;
	Tue, 31 Aug 2021 06:39:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C05D9C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3AAA403CD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DFEvepHSDyXm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:39:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CAB8440611
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 06:39:23 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 28-20020a17090a031cb0290178dcd8a4d1so1432408pje.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 23:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NTCDFRak7iBO7zSAEx1oNf4Ml2aUyPgE0FxiqkjCLnw=;
 b=ea0cyM6OhCVeGG5usZ0KxNHxuYsmmrHVTB/I0bTGwh+BYHl4HXTqySRz2JObBQ5eb9
 g0HmHkQ1s0wX9/HzIvkxUGZT9rCe7WYKXVKbpjJGlS6uHCmfwSXgsg7fP9KMI8svvy+P
 B5iih6MzjvTdzL9aIaUBOPVpE9YT7D+6MkVGB2ARB8wodEFoouVyRZN9Lf7UdDfPrHpk
 dAdq+Og5Nn1szM1iIG5p3/ldeifZO/p74iKLP3uz5D1DeuVF4hEqwoSnvDJVYoBX9lUi
 P2KxxiVYUIQwOYy9MX/j5u15XaXVzqGK7FPEjNWDD/6GUsWWKiu1P+mxWuZKmHfD8rZS
 QnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NTCDFRak7iBO7zSAEx1oNf4Ml2aUyPgE0FxiqkjCLnw=;
 b=JxZkVTwullpqiSfwY93OfCgMNw4yUSLLe5qdbiki+rfaqNvk7ZpG9fzPcjPi0UiwZA
 qUl0sAmneoyXQY+wdsNZqy8pQ79G2HzG3Y+FopWkUl+eMaagq9QKMjXOrXl4jW6nXrnN
 LXQUDbssTXpy42Kutk9eQ1MGhBVMPvlh597zHaa7Xzb371POfPhALKylP8w1QCrJOUza
 ukoapqieHiqK99foEIG2q5Kw0kANQGnd92Txnl3w/juTOo6TNKEfk8DEBgD97YpHLj7E
 kkM7ejBcl8DQLwX3ZK6cvDnZIoEN++Y3R9Jj8ogVE+hoCgHLPm6vTTnxSvP3JBj2dxPX
 LUEQ==
X-Gm-Message-State: AOAM531m/BKUqRTUMQeX+0jLwajErHf3DUBmictIzFJ7rsfLU0wNNjxN
 VyUaaM9wSgZVlM707RD/BQHB8g==
X-Google-Smtp-Source: ABdhPJxBHVEMsZU9CGeogp8ZvKAVf1sD+YoYtF3kIkhRZTAMZ5NJtLosRxW0uUePoJRVQ3c2ER8/zg==
X-Received: by 2002:a17:90a:680c:: with SMTP id
 p12mr3619960pjj.33.1630391963054; 
 Mon, 30 Aug 2021 23:39:23 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id y3sm19954621pgc.67.2021.08.30.23.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 23:39:22 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpio: virtio: Add missing mailings lists in MAINTAINERS entry
Date: Tue, 31 Aug 2021 12:09:17 +0530
Message-Id: <76305b7e89006437b2a3ecf97f857231b2d4ae2a.1630391782.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "Enrico Weigelt, metux IT consult" <info@metux.net>
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

Add gpio and virtualization lists in the MAINTAINERS entry for Virtio
gpio driver.

Reported-by: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f632acd7d98c..da58964935d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19650,6 +19650,8 @@ F:	include/uapi/linux/virtio_fs.h
 VIRTIO GPIO DRIVER
 M:	Enrico Weigelt, metux IT consult <info@metux.net>
 M:	Viresh Kumar <vireshk@kernel.org>
+L:	linux-gpio@vger.kernel.org
+L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	drivers/gpio/gpio-virtio.c
 F:	include/uapi/linux/virtio_gpio.h
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
