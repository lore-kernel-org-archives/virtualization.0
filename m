Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E871C433DB
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:06:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1968A22CBE
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1968A22CBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 05F5F2045F;
	Tue, 12 Jan 2021 20:06:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DjbyvDDZdM5s; Tue, 12 Jan 2021 20:06:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 51804203C4;
	Tue, 12 Jan 2021 20:06:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3865FC0893;
	Tue, 12 Jan 2021 20:06:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79539C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4E75A2044D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:06:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id isXy-pH0PDUi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:06:47 +0000 (UTC)
X-Greylist: delayed 00:18:54 by SQLgrey-1.7.6
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by silver.osuosl.org (Postfix) with ESMTPS id 262A420354
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:06:47 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id g24so3736641edw.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 12:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RENS1yiCoqDoLkKN/GRTnjThUIFO+qOBX6TnsDEXMJ4=;
 b=M/GX6JJ7p2H2eTx80N54RrcrNovJmEJksJOoBQDaMLSzid6cmcZm7fhz67QqX1fL5P
 IdT39n+3quPjJon55Yrm52XJi48JC4N264PIWrap0CYeK86yDZZ+zEJcTwiKudRaOcu3
 wXoQ+xjsPaLtUxHrXSVu9o7ZzQRgJuokj+6KBtBcm0Zx+B7h8aZiYqFXJ3KjMQQyb1JP
 VOmGW/qJxnsFSZUkpX//QYy9P3sHgwODGlbccFdfwVkGYWPx3MNPz+nieZ4tlIyY6yLl
 osKVjKeNCMT8VtZGL5mmwM64fXLfHfr+b+cGMxg0fdz/BywiQ1W/2QgZOf6jp8KNqTTi
 Chyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RENS1yiCoqDoLkKN/GRTnjThUIFO+qOBX6TnsDEXMJ4=;
 b=lBkxaxKMedJRliUA3vuEPvy9vi73ejeA3ou+b6A1Uw/MCyn2N8lNuyhIlx4xGED5g0
 ASNcENsmLJN7Tozp5CJldcrH6FHteAsRKmSGKkGtise1ViZ2dPAUqNif1I9wi710Sgm6
 DOzQ9JjD7mjojpuP1uh9mP5pnCYR7Ta8IP17BmYuH48kbHvupbSu8+odwLNOYtaZDOHX
 h24HjoBKCJe6Gh1e2m2xw+5R6dBDJeWG9kLh6qYQ8T/PusMkyeF1CPpoWiZIbt1WMWEe
 TaKa3thZA4MhyM9ZRdCtofERwRbw4W8vt3fwTQ7yNNUPhEWkXvSR6KqVse4l9Iog6gFp
 Na/Q==
X-Gm-Message-State: AOAM530ENhsPORPpEYILV9YdEztek9oAH0rI6Pz+UTwNJ2rWiQ1Bkpo3
 s5j93/YJOfOn8cKq/pH5mlE8LOE1wXUNa2Wc
X-Google-Smtp-Source: ABdhPJy88KkYeCfk/twqMv7qxLAVLrtcCRDSJ2F4RxIb3LJRD8cqoUZ55scrlMHcmG48qxh7J7CDhQ==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr437008wrt.406.1610480524252; 
 Tue, 12 Jan 2021 11:42:04 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net.
 [79.183.72.147])
 by smtp.gmail.com with ESMTPSA id z63sm4885315wme.8.2021.01.12.11.42.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 11:42:03 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
 gustavoars@kernel.org, herbert@gondor.apana.org.au,
 steffen.klassert@secunet.com, nogikh@google.com, pablo@netfilter.org,
 decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com, elver@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
Subject: [RFC PATCH 3/7] tun: allow use of BPF_PROG_TYPE_SCHED_CLS program type
Date: Tue, 12 Jan 2021 21:41:39 +0200
Message-Id: <20210112194143.1494-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112194143.1494-1-yuri.benditovich@daynix.com>
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
Cc: yan@daynix.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This program type can set skb hash value. It will be useful
when the tun will support hash reporting feature if virtio-net.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 drivers/net/tun.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7959b5c2d11f..455f7afc1f36 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2981,6 +2981,8 @@ static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
 		prog = NULL;
 	} else {
 		prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SOCKET_FILTER);
+		if (IS_ERR(prog))
+			prog = bpf_prog_get_type(fd, BPF_PROG_TYPE_SCHED_CLS);
 		if (IS_ERR(prog))
 			return PTR_ERR(prog);
 	}
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
