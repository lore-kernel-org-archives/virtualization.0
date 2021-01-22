Return-Path: <SRS0=TOd4=GZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669E9C433DB
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 09:28:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6409239D1
	for <virtualization@archiver.kernel.org>; Fri, 22 Jan 2021 09:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6409239D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1280F87343;
	Fri, 22 Jan 2021 09:28:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HCc7xA2zgIxz; Fri, 22 Jan 2021 09:28:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 81FB88734B;
	Fri, 22 Jan 2021 09:28:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35D89C1DA7;
	Fri, 22 Jan 2021 09:28:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04D5BC08A1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 09:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E892587343
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 09:28:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XhPt1e6pytM8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 09:28:35 +0000 (UTC)
X-Greylist: delayed 18:59:08 by SQLgrey-1.7.6
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 679AD87341
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 09:28:35 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id g24so5734700edw.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 01:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=e8zlznAImcFn6aUQKKQ/ezvduZl3NWTYoAtSuyukN7E=;
 b=BRbFnfHDIs/smHNgoUrxYDsFF05nDbpo8aSX5PfzleHap763MuKQwDfK8u29Egxixj
 LCg013vU1qCYwBh/SMZ8szaUPk+K5RJooP2EyszdG93GCzNP0+yTdjHxZgJ//gzygcOz
 jArtPCqymk9K81zX3cm4IOjMeFbE06eym3lNUPhR4WZokG/h+vhIOlluYchjHAJe2/wv
 ctoKg+wMd5of+A0178pvtkJUHW891tZo2G4b1lAcikc1QrB/V+fkdJXpi0rQp0EsOl4w
 045fYov7QDjRjW6IQ2u5TVSfVF76TRDw+xRa7zVuj5ORUtWyC7ZzUfDYAr3l4ETfM5CW
 A5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=e8zlznAImcFn6aUQKKQ/ezvduZl3NWTYoAtSuyukN7E=;
 b=F00WmHZLGamcs+kzvwcuBE8ChOUdaTawotXSeakwI1D1FzzyfmeF7M04VLKqPjADNb
 ktDY7Uyf/ryh4+ysz0Krl2WJYnnmUMzfmK7SAJCDcLm4vbBkB5edDGH9dNKbpdt7JAMx
 tPrg0yQV9IvZpfqjN45MHUgUpigJUvhcIWjiClzrXiW+XmFkxSdvqlCq6YzzEgB0PsuJ
 I5xvf85hrA03fcLsLMDZBg3ZW68DU5PaDaRfmbnshaKUpITtfMx8hEsO/ARPU5OpzlGS
 cW0aIs6EBidVdvEuVE1xmdDYlUGsRs4FW1rUM+IVrZXUatMImIuPILiNv1EzOU1UA8AZ
 D+zw==
X-Gm-Message-State: AOAM530rpZG7k2Z37ok50JCHw1fpmnmMjXrCuWtmGr+RlrHnPDRGAGwP
 a62UbS+IR0PKbSjIEh3U6lwRTg==
X-Google-Smtp-Source: ABdhPJyMaoODmdy8RXoi2rfv+If9xXYUfirTcZFY48nRrUmzOPPhl1zUfZ7bEVx62nyqAu1KqG1gJA==
X-Received: by 2002:a50:bacb:: with SMTP id x69mr2476714ede.39.1611307713947; 
 Fri, 22 Jan 2021 01:28:33 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:481b:68e3:af3e:e933])
 by smtp.gmail.com with ESMTPSA id g17sm4684508edb.39.2021.01.22.01.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 01:28:33 -0800 (PST)
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To: axboe@kernel.dk
Subject: [PATCH V2 0/2] remove unused argument from blk_execute_rq_nowait and
 blk_execute_rq
Date: Fri, 22 Jan 2021 10:28:22 +0100
Message-Id: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Cc: hch@infradead.org, linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, target-devel@vger.kernel.org
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

V2 changes:
1. update commit header per Christoph's comment.

Hi Jens,

This series remove unused 'q' from blk_execute_rq_nowait and blk_execute_rq.
Also update the comment for blk_execute_rq_nowait.

Thanks,
Guoqing

Guoqing Jiang (2):
  block: remove unnecessary argument from blk_execute_rq_nowait
  block: remove unnecessary argument from blk_execute_rq

 block/blk-exec.c                   | 13 +++++--------
 block/bsg.c                        |  2 +-
 block/scsi_ioctl.c                 |  6 +++---
 drivers/block/mtip32xx/mtip32xx.c  |  2 +-
 drivers/block/paride/pd.c          |  2 +-
 drivers/block/pktcdvd.c            |  2 +-
 drivers/block/sx8.c                |  4 ++--
 drivers/block/virtio_blk.c         |  2 +-
 drivers/cdrom/cdrom.c              |  2 +-
 drivers/ide/ide-atapi.c            |  2 +-
 drivers/ide/ide-cd.c               |  2 +-
 drivers/ide/ide-cd_ioctl.c         |  2 +-
 drivers/ide/ide-devsets.c          |  2 +-
 drivers/ide/ide-disk.c             |  2 +-
 drivers/ide/ide-ioctls.c           |  4 ++--
 drivers/ide/ide-park.c             |  2 +-
 drivers/ide/ide-pm.c               |  4 ++--
 drivers/ide/ide-tape.c             |  2 +-
 drivers/ide/ide-taskfile.c         |  2 +-
 drivers/mmc/core/block.c           | 10 +++++-----
 drivers/nvme/host/core.c           |  8 ++++----
 drivers/nvme/host/lightnvm.c       |  4 ++--
 drivers/nvme/host/pci.c            |  4 ++--
 drivers/nvme/target/passthru.c     |  2 +-
 drivers/scsi/scsi_error.c          |  2 +-
 drivers/scsi/scsi_lib.c            |  2 +-
 drivers/scsi/sg.c                  |  3 +--
 drivers/scsi/st.c                  |  2 +-
 drivers/target/target_core_pscsi.c |  3 +--
 fs/nfsd/blocklayout.c              |  2 +-
 include/linux/blkdev.h             |  5 ++---
 31 files changed, 50 insertions(+), 56 deletions(-)

-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
