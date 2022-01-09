Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8E6C433EF
	for <virtualization@archiver.kernel.org>; Sun,  9 Jan 2022 21:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2957C40877;
	Sun,  9 Jan 2022 21:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ewmVa_QXFMR5; Sun,  9 Jan 2022 21:07:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D3367402D7;
	Sun,  9 Jan 2022 21:07:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4B3BC0031;
	Sun,  9 Jan 2022 21:07:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A3D6C001E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 131B1402D7
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oG7QZEKx1cO8
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51DEF402D4
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 21:07:17 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id s30so9673930lfo.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 13:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=esg4bn7G0jMIkn6seqDEuQvZNEfKaqIXGyIwMWcVDh0=;
 b=B1de/dpBwPvfubE+v3OaTkKnDg55HGFm13nmRzKKZ4yE9ozwtfZOAkNGm4dzpB5j9c
 1DCpFubLzTK+G20mk26Z2odim8dMS2HWjpzQ6pmPUV5mGeuwgYPhIC+jN7YCykPe36UF
 qIJNSMdz7AhP8MVNWPr0qK6JvWnA7kWUROWTwl5SHoBHabURvVNETBRTXTiBgwKki1cV
 LqBsjPMxkFHhySkGCw6nvq48vLOnqkJLxThjAW1EtNbp5za3Hwh9t3LZFE3lSuxzzHjZ
 7z1wNYfglyK3+bsSgHVPtTHHkTNliWt60z3dXX1S+8AFLUlpjfRJOqU5v9kS21Cqmwxn
 peTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=esg4bn7G0jMIkn6seqDEuQvZNEfKaqIXGyIwMWcVDh0=;
 b=jkVxRE0Z0nP7XtYYy5WqYNHfOwUWvLEC9RpUsetAkL6vaY8aADAYqoQ2h+N2ZF7G5S
 jWNS5Hq2ORsDz9q6rnkZlvPVqJ3R3FRMovIVTFxPC5f9ncvzJ1lKItvQK00ZqgCWIA4m
 hm6AYN90GgqENsMK339FSzW12hO2ICyQan7TD7djAJ+x2smy2JEKU7KPDTdFvRroC5EX
 3qRf+gm9BEVVKm4XkkN8M32pn9EqlQVqcmm5ibbUkGB+Z/DBDukScNDAmGV7wQY2KnJy
 JTHT001IiCtGy2p2bt21mLJyw0nUkMNL40TRe+F0wSKxQD/hXw7/pN7RkBXEH4DaO2GV
 tMyw==
X-Gm-Message-State: AOAM530hMPlpp9OcLwssDwROFgsdPDKUYEc8obN7sUEyct2Mq/RzpLRO
 cM/RSUW7PgQlI79NuUlZ3U1ZBg==
X-Google-Smtp-Source: ABdhPJxH3Js0nW5RBZ54Ll58iBo6WDg8zPSOgnp1ipujtGCBK7qTeTiBQQjXzcujKxks1yxE5fCT/w==
X-Received: by 2002:a2e:b907:: with SMTP id b7mr46119133ljb.167.1641762435212; 
 Sun, 09 Jan 2022 13:07:15 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id p17sm766129lfu.233.2022.01.09.13.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jan 2022 13:07:14 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jasowang@redhat.com, mst@redhat.com
Subject: [PATCH 0/4] RSS support for VirtioNet.
Date: Sun,  9 Jan 2022 23:06:55 +0200
Message-Id: <20220109210659.2866740-1-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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

Virtio-net supports "hardware" RSS with toeplitz key.
Also, it allows receiving calculated hash in vheader
that may be used with RPS.
Added ethtools callbacks to manipulate RSS.

Technically hash calculation may be set only for
SRC+DST and SRC+DST+PORTSRC+PORTDST hashflows.
The completely disabling hash calculation for TCP or UDP
would disable hash calculation for IP.

RSS/RXHASH is disabled by default.

Changes since rfc:
* code refactored
* patches reformatted
* added feature validation

Andrew Melnychenko (4):
  drivers/net/virtio_net: Fixed padded vheader to use v1 with hash.
  drivers/net/virtio_net: Added basic RSS support.
  drivers/net/virtio_net: Added RSS hash report.
  drivers/net/virtio_net: Added RSS hash report control.

 drivers/net/virtio_net.c | 404 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 390 insertions(+), 14 deletions(-)

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
