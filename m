Return-Path: <SRS0=C+E9=BJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4162C433E3
	for <virtualization@archiver.kernel.org>; Thu, 30 Jul 2020 19:30:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1902083B
	for <virtualization@archiver.kernel.org>; Thu, 30 Jul 2020 19:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TK4/Arut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1902083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F275188626;
	Thu, 30 Jul 2020 19:30:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vZq2g3K8ugN0; Thu, 30 Jul 2020 19:30:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 64C54885E8;
	Thu, 30 Jul 2020 19:30:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45B4EC004F;
	Thu, 30 Jul 2020 19:30:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BC17C004D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jul 2020 19:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4B30986E8F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jul 2020 19:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OvAABhAEpQRz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jul 2020 19:30:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BA75B86E1F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jul 2020 19:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596137406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Zo62zBr05G4i/w6uOCrF5bcIwehfjUuSBLT3HlEcuYQ=;
 b=TK4/ArutFiX30RTVSeQP72Z2Gg3T069qDEa8QhEdpHXY4H9Wb9h/Q4PtRO7epGbvlxFCR6
 b7xh+gPHuedTwoEnaJewZS1w/y+Nxl6KOj3YtkbirOPQVc/+g6xkdBIucTEE8VtXApf05t
 HdtsZRI1T2jnHEfDUECFPrFB3Ys83mA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-0Uy-ARnYMUahhRusc5Dc8A-1; Thu, 30 Jul 2020 15:30:04 -0400
X-MC-Unique: 0Uy-ARnYMUahhRusc5Dc8A-1
Received: by mail-wr1-f70.google.com with SMTP id b13so5553013wrq.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jul 2020 12:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=Zo62zBr05G4i/w6uOCrF5bcIwehfjUuSBLT3HlEcuYQ=;
 b=ZZq9lmEBH/+rGnFa/2R8nmUap0dK734T56NDnMPcgt41MbokQqq/xGB6TxRlrEaqWk
 cqj8oP7UeMZbozIzhu8i7YC0GYOLNRbhQc0t6BGy7ps7aqSLo9V+VHTF97vV8pj4MDXo
 cCMA298LXtWMObI0a0UlqEtPULLkf4fS6YkXogQtLCRBgiWXFY0+qX0Jqe0fqOS1ESin
 udT0AdkKVM19rXCkVKdw8lfKEkapyb6ROHES3Y/g8EoEMM//xTckbyjVURw8CLEnTqEd
 NFH7d0rZB+B9triEqS8z8TWdMOT4OjP1bdY1TiI9kr0RIruGI7m720wh2ldBiIv0DhQN
 076Q==
X-Gm-Message-State: AOAM532JbFYWBd8fb+/tzG9kxo/nwDnn0KOs4a5q8EiX/uBhUsu2ULf6
 WqjMUHaboPRsVW1+wGrqmqw5s1mWX/y7xOwGXvWMBWDFAuqjrgaE6C4e+1u+pl3aTmg140DJPmB
 xBvQnzjpQUBmuR08cObxlHRxLwGjLCaKqppzPetDXyQ==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr267397wrv.280.1596137403065; 
 Thu, 30 Jul 2020 12:30:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxM38R/gaJ4B9lHJnwY7CoXgiuKGr1JOva2N2K51sHps4St8QHQsZSys7gU+zLzyFwcYWboVQ==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr267372wrv.280.1596137402764; 
 Thu, 30 Jul 2020 12:30:02 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id w64sm9081104wmb.26.2020.07.30.12.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 12:30:01 -0700 (PDT)
Date: Thu, 30 Jul 2020 15:29:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio, qemu_fw: bugfixes
Message-ID: <20200730152958-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: rdunlap@infradead.org, chenweilong@huawei.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wu000273@umn.edu, alexander.h.duyck@linux.intel.com
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

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to a96b0d061d476093cf86ca1c2de06fc57163588d:

  virtio-mem: Fix build error due to improper use 'select' (2020-07-30 11:28:17 -0400)

----------------------------------------------------------------
virtio, qemu_fw: bugfixes

A couple of last minute bugfixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexander Duyck (1):
      virtio-balloon: Document byte ordering of poison_val

Michael S. Tsirkin (2):
      vhost/scsi: fix up req type endian-ness
      virtio_balloon: fix up endian-ness for free cmd id

Qiushi Wu (1):
      firmware: Fix a reference count leak.

Weilong Chen (1):
      virtio-mem: Fix build error due to improper use 'select'

 drivers/firmware/qemu_fw_cfg.c  |  7 ++++---
 drivers/vhost/scsi.c            |  2 +-
 drivers/virtio/Kconfig          |  2 +-
 drivers/virtio/virtio_balloon.c | 11 ++++++++++-
 4 files changed, 16 insertions(+), 6 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
