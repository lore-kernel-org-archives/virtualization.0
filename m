Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B064C433DB
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 16:22:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3304520867
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 16:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3304520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 112AD22D10;
	Mon, 28 Dec 2020 16:22:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OXrlGoJNA7ro; Mon, 28 Dec 2020 16:22:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D4FC42001C;
	Mon, 28 Dec 2020 16:22:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2A8AC1DA2;
	Mon, 28 Dec 2020 16:22:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1ED2C0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 904AE87029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zSb+tjiOefDQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 86BBB865F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:22:38 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id 4so5164326qvh.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 08:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ds2qIQ3CIy8ER5iAyqIpSFRnqjHxdJqLZeRLwlowhag=;
 b=rrjmLQUrtYMBmmD8EwaGJ1Bt7NxhzC0ChFF8hq5Eo02cgtktccgntzN0kN9cfOYq+D
 DtET9XvP92NgaCrHpPbTWwo8Gff4C0F2tSnvmGUtuIIPzG7GDxT2duaC4rku8PD5Y8BS
 P0bsrUrYczea0/DpxXB0EzViP6ZvUPQk+oS9byvMfsAJ5xcqnN2NCg3mFueqkMeTVmuG
 +ep0RtU7D5wWWpx8R5rQTkWRN4HrxqSeAEmzOm0XAF65XJbvt5jPIx3wmclExke1cUVJ
 h5VDz6DLQiGvxxpLHMDAiHlWU7NjoRhv2tznVLb+bGrNZYLcVcMf60pKtf2F36wHd941
 GB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ds2qIQ3CIy8ER5iAyqIpSFRnqjHxdJqLZeRLwlowhag=;
 b=oI3tqzbwDnaaSATDK56+0E6JZ97eAnrZ8IVEvucJlf0DLkdww+9R4Y6L6SSi6IaH1e
 1wNQnXjjwmTXDqo2etnU7ZEa2LwIQL3Zui2uxiTVqZNvo4SizDgNMIEdIztLiCH7+Ui7
 0Zim13p7qiQ0S+n1KzWKzgudScR7zFHJ0te/KztJLh4OQ92kfeVkNZSRzdGahy5PsRnV
 mgEOk6/wgPHxW7MO805+gDYlU1uI0uZ4GZJBqixlr8cPHGoS3aBh3iZMiBbSGunyZ67Q
 vR0F//SFFiLXTVKiah6HJB/efhSsT1T4PaDlaS4C8yFzKufC+eZlUiEKsbyOlKg5IwAJ
 tn7w==
X-Gm-Message-State: AOAM530rAgXUUjOJaA/ev2ZJLaQXDR259Pm7iGjh0ZnIz7k/pcIvDhbG
 h+1tIWZnEovIdxdf96iXlnP2dosRHac=
X-Google-Smtp-Source: ABdhPJwLYDd8/DF/QrvENX4G+Kh3drp769zSKvqLtT6HngYBfsrfFqkEzn9wH23hrz2IvJgFlKoMwg==
X-Received: by 2002:a0c:df94:: with SMTP id w20mr47587823qvl.33.1609172557307; 
 Mon, 28 Dec 2020 08:22:37 -0800 (PST)
Received: from willemb.nyc.corp.google.com
 ([2620:0:1003:312:f693:9fff:fef4:3e8a])
 by smtp.gmail.com with ESMTPSA id u65sm24005556qkb.58.2020.12.28.08.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 08:22:36 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH rfc 0/3] virtio-net: add tx-hash, rx-tstamp and tx-tstamp
Date: Mon, 28 Dec 2020 11:22:30 -0500
Message-Id: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 mst@redhat.com
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

From: Willem de Bruijn <willemb@google.com>

RFC for three new features to the virtio network device:

1. pass tx flow hash and state to host, for routing + telemetry
2. pass rx tstamp to guest, for better RTT estimation
3. pass tx tstamp to host, for accurate pacing

All three would introduce an extension to the virtio spec.
I assume this would require opening three ballots against v1.2 at
https://www.oasis-open.org/committees/ballots.php?wg_abbrev=virtio

This RFC is to informally discuss the proposals first.

The patchset is against v5.10. Evaluation additionally requires
changes to qemu and at least one back-end. I implemented preliminary
support in Linux vhost-net. Both patches available through github at

https://github.com/wdebruij/linux/tree/virtio-net-txhash-1
https://github.com/wdebruij/qemu/tree/virtio-net-txhash-1

Willem de Bruijn (3):
  virtio-net: support transmit hash report
  virtio-net: support receive timestamp
  virtio-net: support transmit timestamp

 drivers/net/virtio_net.c        | 52 +++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_net.h | 23 ++++++++++++++-
 2 files changed, 71 insertions(+), 4 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
