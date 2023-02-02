Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B680C61DA4
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 09:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 346D340BF5;
	Thu,  2 Feb 2023 09:09:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 346D340BF5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=8EMNDhCq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id shJq5REY5C1f; Thu,  2 Feb 2023 09:09:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3BF2C405B8;
	Thu,  2 Feb 2023 09:09:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BF2C405B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C9E4C007F;
	Thu,  2 Feb 2023 09:09:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2014C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E1D540AC9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E1D540AC9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f6bcWw69S0mD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F263405B8
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F263405B8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:41 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 l4-20020a17090a850400b0023013402671so4923295pjn.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 01:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=10hCW48KPbvjfvXEjrjQ+Mgg8cpIPYTv4D/tTAJDTFA=;
 b=8EMNDhCqTbFttbka/+TAiSeV5HrHEpPPTDWCdd+pC75E+2UqrAgvMajQc0EkjbagyX
 9n/0ZfjnRY8rUa+nIoXcW7SqLt4UxhjTntX5RNDx0A4bTmCkZ1dUofksYyMCwUplG0ZK
 khdSJiOtcrutRo1WdLqkenS+9CMGQ52nG60Rw+43cN28AWgHp3X0vKj7xoOdW4Oij+p2
 PH1+Hqzp/LlbRe+bNIAeHcitIsnEfGKgqPxC1LNuG6nP3gu7h+TNyhPGv7CGuOaksqsB
 xEFUWl3qxYUaT3dz2n9sGR8Fx60EGP4Xk6Tcmx1lhpa+jY/tS/gNaQb+fyrgR2X0Xx7v
 KQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=10hCW48KPbvjfvXEjrjQ+Mgg8cpIPYTv4D/tTAJDTFA=;
 b=jJq88gTnIkGART5A5lOMXZTBAOyHxo88PUvksw8S1ZN2YhMcc2R4k2Y42JwplVKhk6
 jkEEKLVQzXOVOgthSsnbeNyAI1Qy0ghHB6G3+ubUkAnREbPj2rRve0NPAbUpwwpTUffx
 5VvzaD07ZfBXjv6D16j6RbJGZNKMC1CISFX8kn1Vcofkq7LX3F14kTldyuL1U5NvBwHr
 hD472FIdU4UywAoNggCT9cZ7Znx/WY/ySn/E64jnY+NxIGX+kxj4aL7j7HfY//2iE7D4
 voEea2uqSdQl4aK80XwexUKe8/2IJ+i54nRgA07dqFO5cmb95UBqLgzyDc/ZR5SwR5if
 3mww==
X-Gm-Message-State: AO0yUKVjpCItHJgqk0dmMo1ou76aZK44o5OysW3C2w5wune2K/qjDnTa
 dBAq5oFjhRdKgSjt+9nqtMgr6w==
X-Google-Smtp-Source: AK7set8TRDrnyQM34c60qrfKukf3YMCoIk81aVwwaJ/9ofFNhvBNL5Xdej/Gen3KhJgGunl2ZBfRDA==
X-Received: by 2002:a05:6a20:6987:b0:bb:bb46:bb9e with SMTP id
 t7-20020a056a20698700b000bbbb46bb9emr6437176pzk.39.1675328981236; 
 Thu, 02 Feb 2023 01:09:41 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 ik12-20020a170902ab0c00b001929827731esm13145968plb.201.2023.02.02.01.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 01:09:40 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
Date: Thu,  2 Feb 2023 18:09:27 +0900
Message-Id: <20230202090934.549556-1-mie@igel.co.jp>
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
planning to publish it. Also changes of drivers affected by this patchset
are not included yet. e.g. caif_virtio and vdpa (sim_net,blk, net/mlx5)
drivers.

This patchset can separate into 4 parts:
1. Fix a typo in the vringh header[1/7]
2. Enable a retpoline on virtio/vringh_test [2/7]
2. Unify the vringh APIs and change related [3, 4, 5, 6/7]
3. Support IOMEM to vringh [7/7]

This first part is just for typo fixing. The second part changes build
options of virtio/vringh_test. The change bring the test close to linux
kernel in retpoline. In the third part, unify the vringh API for each
accessors that are user, kern and iotlb. The main point is struct
vringh_ops that fill the gap between all accessors. The final part
introduces an iomem support to vringh according to the unified API in the
second part.

Those changes are tested for the user accessor using vringh_test and kern
and iomem using a non published driver, but I think I can add a link to a
patchset for the driver in the next version of this patchset.

v2:
- Add a build options to enable the retpoline in vringh_test
- Add experimental results of the API unification

v1: https://lore.kernel.org/virtualization/20221227022528.609839-1-mie@igel.co.jp/
- Initial patchset

Shunsuke Mie (7):
  vringh: fix a typo in comments for vringh_kiov
  tools/virtio: enable to build with retpoline
  vringh: remove vringh_iov and unite to vringh_kiov
  tools/virtio: convert to new vringh user APIs
  vringh: unify the APIs for all accessors
  tools/virtio: convert to use new unified vringh APIs
  vringh: IOMEM support

 drivers/vhost/Kconfig      |   6 +
 drivers/vhost/vringh.c     | 721 ++++++++++++-------------------------
 include/linux/vringh.h     | 147 +++-----
 tools/virtio/Makefile      |   2 +-
 tools/virtio/vringh_test.c | 123 ++++---
 5 files changed, 357 insertions(+), 642 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
