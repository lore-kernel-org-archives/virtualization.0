Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7441C3DA79
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 02:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 452CA81336;
	Tue, 27 Dec 2022 02:25:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 452CA81336
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=R7ffvjAv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rvJKigvmSNCj; Tue, 27 Dec 2022 02:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E22E781314;
	Tue, 27 Dec 2022 02:25:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E22E781314
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB2DCC0035;
	Tue, 27 Dec 2022 02:25:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDA8AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B28440382
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8B28440382
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=R7ffvjAv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CUvNeg4ztdKD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B5B7400D1
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B5B7400D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 02:25:37 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 h7-20020a17090aa88700b00225f3e4c992so3404880pjq.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 18:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XVIHb2xUd8sujupspgAGNpJyN016wzYVPc2YpZ2bDag=;
 b=R7ffvjAvcrMZ1p1LMq+Euj4OlP/yRK1ztz7vAX2mfWZWhLy4PKsT3r/kZpWE/KmBW8
 maRBuG+idbhR+rPlrNYg6m/KIUBBeIiRdWAHBURPpw5pUMX91PKiIOQccdwuVyH4q+Ml
 6ASi7GlNpP43gmoUHjJI4V3NFPlkslPkD5Cz6UBuNwjvUlQ1G/K4L9ZLvq52lMix9WkY
 OUcgrLgcnRiUM6cAiL4n7VLLFeWFn9MOVo/8H6PJgYat7bIGpdd/wOgkYPMUh8g/DxgQ
 MU2sirbyrMZeyH88qpXiYAtSh7EzDwFJwE7Y/TVUcS1n5+wW7Y7jddzCrcvUAU1l7nl/
 KtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XVIHb2xUd8sujupspgAGNpJyN016wzYVPc2YpZ2bDag=;
 b=fBp5qVALOlgOffdPdE7FGsoSvr9HpHKnPe1ee/zoLw/82z9GAu4UO/79iv/k9q/JKI
 cJb8fIX5icUEDxAn0bCXOqk7wPjHkvrvJ9axbIZfaOeBKOOtklb5k/wAxzkUTnLIePh2
 rspmg+vOQ5To45zAaJnlfSBeE6w30IglXGPiMLxTzPBJ2VYrlm7XLsJywfaVk6AqTR16
 3tI4im0EYQsARZASXJefHPq5CC0QSYzm8MKQXFRBR/GSwadkNo1A4PDEafhGxWBxLp5O
 Uj/2zyryqikqc8mZcqhEbLzm2G+Hfm0OUFASDI5/WNSCCYscKZHz9E1hKVsNWXhpnnDT
 v3lg==
X-Gm-Message-State: AFqh2krz0C4IaYJVBZrEFcdarpX0/ijwZ8pSVuMGDr4zXlsTWUN755hY
 lPFA/87WtwZ/DfYFbr1CzHmbVg==
X-Google-Smtp-Source: AMrXdXuKZS1Ph/IY6Bb5WWpBVaf6Yu1Vdz30CYa7Nf5FAmFaa4UtKH4qrnegeQAYBuEW0rq2BEA3bg==
X-Received: by 2002:a17:902:b418:b0:191:1fc4:5c14 with SMTP id
 x24-20020a170902b41800b001911fc45c14mr20844566plr.49.1672107936658; 
 Mon, 26 Dec 2022 18:25:36 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a1709026f0f00b001870dc3b4c0sm2465014plk.74.2022.12.26.18.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 18:25:36 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH 0/6] Introduce a vringh accessor for IO memory
Date: Tue, 27 Dec 2022 11:25:22 +0900
Message-Id: <20221227022528.609839-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
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

Vringh is a host-side implementation of virtio rings, and supports the
vring located on three kinds of memories, userspace, kernel space and a
space translated iotlb.

The goal of this patchset is to refactor vringh and introduce a new vringh
accessor for the vring located on the io memory region. The io memory
accessor (iomem) is used by a driver that is not published yet, but I'm
planning to publish it. Drivers affected by these changes are not included
in this patchset. e.g. caif_virtio and vdpa (sim_net, sim_blk and net/mlx5)
drivers.

This patchset can separate into 3 parts:
1. Fix and prepare some code related vringh [1, 2, 3/6]
2. Unify the vringh APIs and change related [4, 5/6]
3. Support IOMEM to vringh [6/6]

This first part is preparation for the second part which has a little fix
and changes. A test code for vringh named vringh_test is also updated along
with the changes. In the second part, unify the vringh API for each
accessors that are user, kern and iotlb. The main point is struct
vringh_ops that fill the gap between all accessors. The final part
introduces an iomem support to vringh according to the unified API in the
second part.

Those changes are tested for the user accessor using vringh_test and kern
and iomem using a non published driver, but I think I can add a link to a
patchset for the driver in the next version of this patchset.

Shunsuke Mie (6):
  vringh: fix a typo in comments for vringh_kiov
  vringh: remove vringh_iov and unite to vringh_kiov
  tools/virtio: convert to new vringh user APIs
  vringh: unify the APIs for all accessors
  tools/virtio: convert to use new unified vringh APIs
  vringh: IOMEM support

 drivers/vhost/Kconfig      |   6 +
 drivers/vhost/vringh.c     | 721 ++++++++++++-------------------------
 include/linux/vringh.h     | 147 +++-----
 tools/virtio/vringh_test.c | 123 ++++---
 4 files changed, 356 insertions(+), 641 deletions(-)

--
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
