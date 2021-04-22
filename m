Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E253C43461
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 22:20:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF3D61421
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 22:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF3D61421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E2CA40F52;
	Thu, 22 Apr 2021 22:20:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Of_rp_PMXagx; Thu, 22 Apr 2021 22:20:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A518740F51;
	Thu, 22 Apr 2021 22:20:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74840C000F;
	Thu, 22 Apr 2021 22:20:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50001C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 22:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D6FA40F4D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 22:20:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LcCaePsYXZXx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 22:20:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF89E40F46
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619130022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=tgQyxuFNIWv2WFwGCh6y2wdSkYdHkTXHx4X2Bpzjy2I=;
 b=HP+d12yBLmHIipwN9ACa6yrY4L8RxDcVHWE90COWvMT2redh/FX55Bi0zrc5JXHZ6VR1nr
 WlOn5DhHGv+pU0Gn2Zhl8Z4oyConXdvnA+e/xYVMaT30mWABtfnvWMqDbpHc95xEYGQw2k
 JSvFdhahPm+WK4CChyH8Itj3fA5Y+d4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-5LbqcI98OwWQSVns11iwUg-1; Thu, 22 Apr 2021 18:20:20 -0400
X-MC-Unique: 5LbqcI98OwWQSVns11iwUg-1
Received: by mail-ed1-f72.google.com with SMTP id
 l22-20020a0564021256b0290384ebfba68cso13665110edw.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 15:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=tgQyxuFNIWv2WFwGCh6y2wdSkYdHkTXHx4X2Bpzjy2I=;
 b=PC2IwcrJLf0ic9TYZP2bumEHZFqSnyka7aBPkjPsyWRB1EdFPhtZHBk+iJYtTyMGG6
 vHB0dDce17KHT1D3BjT2dG95wY7VU3+/xrf/H5POlg8xnfSfOLRVyHVayDGCH7Z5DXah
 dIKeyjEht7D+RWucUoDsKPtl8o605bUEFp8sbeZAzw31BPwFnLtuGPi9Bgsf2VHY7w2J
 KTvn0jTNJLYztl/lMFn21qvTn8V927e7nFbOXkntHdLnP2I21OHFpWXuKcM9kZpBer7p
 HP4VCNb7l8bceNm4BbtWO4BC58/yWmZEdb9TzTDxWiR+tuYI3m0wx3m/Y5b5KXD0olse
 tC9A==
X-Gm-Message-State: AOAM53013ZU3XWMHSR/gKVc8neMkYYnDlbLPbGq5U75O/Z18+Nse2BcV
 J9kPi0dU6pe+OSpcJvD88vrI6602V/Dch3MstZZ5XoymidjlSVdVMsXI+xJ3VO8ADVATLQctZ07
 fVLXwz6+rJjnPgjs8A6IjgMMBdsHVBFPKbnya3GAe6g==
X-Received: by 2002:a05:6402:1912:: with SMTP id
 e18mr807282edz.184.1619130019728; 
 Thu, 22 Apr 2021 15:20:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJy1AtNvC1yqgjKWu6Iev/lJ2pAgqjtkiG2OyAAr4aeu8ke3P5mSsVUhBCU4b2QDNeMyBTxQ==
X-Received: by 2002:a05:6402:1912:: with SMTP id
 e18mr807263edz.184.1619130019602; 
 Thu, 22 Apr 2021 15:20:19 -0700 (PDT)
Received: from redhat.com (212.116.168.114.static.012.net.il.
 [212.116.168.114])
 by smtp.gmail.com with ESMTPSA id u1sm3177747edv.90.2021.04.22.15.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 15:20:18 -0700 (PDT)
Date: Thu, 22 Apr 2021 18:20:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: last minute fixes
Message-ID: <20210422182016-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lkp@intel.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 elic@nvidia.com, dan.carpenter@oracle.com
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

The following changes since commit bc04d93ea30a0a8eb2a2648b848cef35d1f6f798:

  vdpa/mlx5: Fix suspend/resume index restoration (2021-04-09 12:08:28 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to be286f84e33da1a7f83142b64dbd86f600e73363:

  vdpa/mlx5: Set err = -ENOMEM in case dma_map_sg_attrs fails (2021-04-22 18:15:31 -0400)

----------------------------------------------------------------
virtio: last minute fixes

Very late in the cycle but both risky if left unfixed and more or less
obvious..

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (1):
      vdpa/mlx5: Set err = -ENOMEM in case dma_map_sg_attrs fails

Xie Yongji (1):
      vhost-vdpa: protect concurrent access to vhost device iotlb

 drivers/vdpa/mlx5/core/mr.c | 4 +++-
 drivers/vhost/vdpa.c        | 6 +++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
