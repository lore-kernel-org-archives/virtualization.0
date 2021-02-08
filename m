Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02C4C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 18:56:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C9264E74
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 18:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C9264E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03A23870BE;
	Mon,  8 Feb 2021 18:56:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WRE9t8DmPrMm; Mon,  8 Feb 2021 18:56:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E386870BB;
	Mon,  8 Feb 2021 18:56:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B127C0891;
	Mon,  8 Feb 2021 18:56:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93B7EC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7AD11870BC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id evNN8Ce-rjXt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A39E9870BB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 18:56:02 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id e15so11093650qte.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Feb 2021 10:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PvwDibSqionGUMaIW7fX8WGczOxj5MLsnicm5PTCNvk=;
 b=jep7KXYV4ExWJl47hFOg8XN6oE6fOlXD39bAUtpnSXPM/8knz03tVv28HzfACdCURm
 ZodldbPw6kYw4wVNnSNH9dGRQw7Fsmt63WunGTYYAkWw5ZfLb6EeB5YEnP9UFB6yBe1T
 UeuGE2nBIODzNYWVzIoVOMC20pC/Esh/Xf9r5wrd1BZvD6yWum71D4t+flhOOwtXhSwV
 ILo6DNSxKFLtyVCkAJoHj6i0+H8UHiPNIhnS4+WhTN+IrePN/AWgH6oJyPkwiuLABTsY
 3BOmtE9vZy/ebnCxGjSNmCNHKi2A3ttJOoIsOokLOotbJigpguowQpy2mpieCxB2o3i1
 mLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PvwDibSqionGUMaIW7fX8WGczOxj5MLsnicm5PTCNvk=;
 b=Ptk/Y5Mr/oXQZHUh1LhW91eicewkvFdMukC2cQTsruyPUik8eGUYowyneI3JKF65Oc
 QCRtYHyvYkQbfM4yvnqlaSa+RVSKeeGXVEanhoqPOPNjPq52ELhKankpjKon3gvGy6dq
 B1wRKIuwhrtMk7CiJcxUUw0GTxz/5vnP+Z0VXCCOnSGNsWSkVVdSK+Yf1aiuWVB6Degx
 zoXjWWOSOE0nrR8ZlLewIesErALbhZ5+dipct8Y6GacxcuvuXGZjA0/s3zUcnJMv6YHn
 JndZpjV8MYaiY4fvHvzZBnIVm6+ttO6b5W2pXUt0/AOIRwNYC/acIYNdbo400hOy30Rp
 H/yg==
X-Gm-Message-State: AOAM530b2QwyGM0KxdSYynNbFQgbVKSjDKmEJ74oAi88+Jz7Uf1qEda8
 HgyVh6GTf1QyQU5sudLO0WxTA7TEI0Q=
X-Google-Smtp-Source: ABdhPJwu2s7LwojmiLLpCb/ffJb1Imze4ED2pNvOdRx2MWtKJQearbN4K5lnq9hKZaj8YaBdFu4MZA==
X-Received: by 2002:ac8:4706:: with SMTP id f6mr13928451qtp.75.1612810561269; 
 Mon, 08 Feb 2021 10:56:01 -0800 (PST)
Received: from willemb.nyc.corp.google.com
 ([2620:0:1003:312:f109:45d3:805f:3b83])
 by smtp.gmail.com with ESMTPSA id q25sm17370744qkq.32.2021.02.08.10.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 10:56:00 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp,
 tx-tstamp and tx-time
Date: Mon,  8 Feb 2021 13:55:54 -0500
Message-Id: <20210208185558.995292-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 richardcochran@gmail.com, mst@redhat.com
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

RFCv2 for four new features to the virtio network device:

1. pass tx flow state to host, for routing + telemetry
2. pass rx tstamp to guest, for better RTT estimation
3. pass tx tstamp to guest, idem
3. pass tx delivery time to host, for accurate pacing

All would introduce an extension to the virtio spec.
Concurrently with code review I will write ballots to
https://www.oasis-open.org/committees/ballots.php?wg_abbrev=virtio

These changes are to the driver side. Evaluation additionally requires
achanges to qemu and at least one back-end. I implemented preliminary
support in Linux vhost-net. Both patches available through github at

https://github.com/wdebruij/linux/tree/virtio-net-txhash-2
https://github.com/wdebruij/qemu/tree/virtio-net-txhash-2

Changes RFC -> RFCv2
  - add transmit timestamp patch
  - see individual patches for other changes

Willem de Bruijn (4):
  virtio-net: support transmit hash report
  virtio-net: support receive timestamp
  virtio-net: support transmit timestamp
  virtio-net: support future packet transmit time

 drivers/net/virtio_net.c        | 193 +++++++++++++++++++++++++++++++-
 drivers/virtio/virtio_ring.c    |   3 +-
 include/linux/virtio.h          |   1 +
 include/uapi/linux/virtio_net.h |  24 +++-
 4 files changed, 214 insertions(+), 7 deletions(-)

-- 
2.30.0.478.g8a0d178c01-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
