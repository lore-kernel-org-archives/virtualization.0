Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC742C432BE
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 17:55:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F79F61100
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 17:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F79F61100
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C74B60BFB;
	Wed, 18 Aug 2021 17:55:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id diIordAqDA_4; Wed, 18 Aug 2021 17:55:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F3A0160BF6;
	Wed, 18 Aug 2021 17:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBF0FC001D;
	Wed, 18 Aug 2021 17:55:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36F1AC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2693960BEF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tHG76o_3YcTI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:55:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA6B560BDC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:55:04 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id i28so6409719lfl.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2fnlNwiofJwFvUxJlW0rUAKllXf+VVuXYYhoztRaKrc=;
 b=WddZj7EJgefVxb9XuzeiiByxrQaIU1ZCn078ocCIbUNKeYAKTZMl9cUO+YdbgHEnoz
 06LQkdHHFctMrAG52vWwHps/gFewpi3V+2amfn7E0CrLCwJypvwZ07F7xk/9c7pKOIc9
 wVVERJlWS6c5K+hmeZfgZZ+99oVmw0VJD5obvog078WwAKDqNgbz6/HGzdPl84b96hN2
 Ej00VMayudP/1poXgwckqFLbp3QQgTATYXZRK4798uvoYMKz/vNoeFZ/A47KMbGR1AEG
 599cWUJtiuOUWUcbVXE/scN59fy69DEDU4KrIkpJKBhZnb2cDZFopYCYd5WTZHNVvvR7
 wz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2fnlNwiofJwFvUxJlW0rUAKllXf+VVuXYYhoztRaKrc=;
 b=Q3/4BdpQ6m3dmUq0yxeCRnlDkskDuFCd/rQEikxCAa71t2RdyfOAZhgODJpHntja6C
 isDQKEFtz58Q6UcBp43M9diJ/IMy3oNXODefu6HfgQAwwu2q8KzGiI0R1gCYuHtQm3xr
 AEgaczLIzak7Y7brqNRpcaVlqU/yNp9Fu2zJEH1SNZMmT5tUP8F1Ydl3gGU42M3JxurD
 t8H394pbhoJSVUCe37lxgW1UaTO76xM9DYc6OBzdTYcWifUkqtRswTs0WDyyHQZtAzuI
 dhbgWmgWnXnNwFX4J9mzbup4Vyho3FbeXTSzk1miZ7KpHJlPDL/N92CfKkcjIMNRgcBd
 NEFQ==
X-Gm-Message-State: AOAM532rdijbzz02i6wAcn+1IVtnby6cJG2oU4kmn/xsrdvc02D4DTP0
 V1OyHtMLSh4AzjErFVdfNx8JVQ==
X-Google-Smtp-Source: ABdhPJzi4vtgTooKvWILaZjtHgpR8vbROhR7aWUGuVSAwZ/NyTVd1HWcvqoEvUBvVwziQ8vKIed/sw==
X-Received: by 2002:a05:6512:3048:: with SMTP id
 b8mr7342984lfb.420.1629309302699; 
 Wed, 18 Aug 2021 10:55:02 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id c5sm55820lji.67.2021.08.18.10.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Aug 2021 10:55:02 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net, kuba@kernel.org
Subject: [RFC PATCH 0/3] drivers/net/virtio_net: Added RSS support.
Date: Wed, 18 Aug 2021 20:54:37 +0300
Message-Id: <20210818175440.128691-1-andrew@daynix.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

This series of RFC patches for comments and additional proposals.

Virtio-net supports "hardware" RSS with toeplitz key.
Also, it allows receiving calculated hash in vheader
that may be used with RPS.
Added ethtools callbacks to manipulate RSS.

Technically hash calculation may be set only for
SRC+DST and SRC+DST+PORTSRC+PORTDST hashflows.
The completely disabling hash calculation for TCP or UDP
would disable hash calculation for IP.

RSS/RXHASH is disabled by default.

Andrew Melnychenko (3):
  drivers/net/virtio_net: Fixed vheader to use v1.
  drivers/net/virtio_net: Added basic RSS support.
  drivers/net/virtio_net: Added RSS hash report.

 drivers/net/virtio_net.c | 402 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 385 insertions(+), 17 deletions(-)

-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
