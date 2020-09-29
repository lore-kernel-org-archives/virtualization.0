Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758E7C4346E
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:50:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2272076A
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHAP+yEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2272076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6F832870AD;
	Tue, 29 Sep 2020 07:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i92nufPXN4oQ; Tue, 29 Sep 2020 07:50:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E04F38709C;
	Tue, 29 Sep 2020 07:50:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C372FC0890;
	Tue, 29 Sep 2020 07:50:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F25D0C016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DD40B8709C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JZYXXwLxdWzv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:50:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 040808708E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:50:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601365840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=ZH5RUsiNCBnwQO3HdBH/S2GadrEkNWR9w8D2mfkC+xk=;
 b=hHAP+yEsfXNFbeo5E8kcZzYTiThkE7Qv8ciUdP7sO8ekrcbB+Ppo88bEVffek1C6xufWcN
 ntlBddjnWar0+5sq5PGmH8QSz7qXwJFFs2eQQVEpuRYaL2KXlTqPAUe2mI/1s6NGIym64R
 ioFsWDbKN+5Ws22w7QAWjmLNmMy2wVM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-9e8agJhpOxWC0X_Lj90Rnw-1; Tue, 29 Sep 2020 03:50:38 -0400
X-MC-Unique: 9e8agJhpOxWC0X_Lj90Rnw-1
Received: by mail-wm1-f69.google.com with SMTP id l26so1379579wmg.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=ZH5RUsiNCBnwQO3HdBH/S2GadrEkNWR9w8D2mfkC+xk=;
 b=guFzx67AuePYwrFciAZBiBaRAZuI6drg/V7FJPG29E74Ud0kdcxCXR3Zj0VUADbnZC
 dEzXzMSkTdGooU++/eSNJuvBdKNqlrPGWbafZyurU2Pv7/VFTg63nSEjriWbLYqZZvju
 QkTSqDA2+O3x0fFnQaqTvV7M5L8iFggVHcm5diRASkDVHveCeFotPCajlwUrnO8zLu4e
 plk+XJLdD5EUjXYDXQFgDTkRBzopkwSe9yDiUv7PdU9PZEKaYQrT5TlHvy1+1+cvHnHf
 rJRYujl14Gg8dQX4YeEZdkd7P3DRof/pK7gb1Ug4qNteYPhmisqkB8x+JEyw0SWm35+d
 Lf4A==
X-Gm-Message-State: AOAM533hFuvE++o1gf/krvIYAd42ydOhc6uLThW3Kr0EXzPeftLjyKNi
 5uCr2qN+6bytYIvX6EXHcZd7Ugc/hEKpH+KxM5Ln1dORyUALhwFPRAcOSQsuMbDYz9J+T45dwQ9
 Ane8yl1vLe0iEZ6tQASgjmxt6v47uptQj2FCBm/Htnw==
X-Received: by 2002:a5d:660f:: with SMTP id n15mr2849633wru.103.1601365837345; 
 Tue, 29 Sep 2020 00:50:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9yDNuK/HRBfrUSRppU/hB6f1n2dAKzHM+mssOZcfIMLGHfW5jc72hMkHH51Lh+uUsHHthwg==
X-Received: by 2002:a5d:660f:: with SMTP id n15mr2849612wru.103.1601365837164; 
 Tue, 29 Sep 2020 00:50:37 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id o15sm4204743wmh.29.2020.09.29.00.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:50:36 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:50:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: last minute fixes
Message-ID: <20200929035034-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eli@mellanox.com, elic@nvidia.com, lingshan.zhu@intel.com
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

Unfortunately there are a couple more reported issues in vhost and vdpa,
but those fixes are still being worked upon, no reason to
delay those that are ready.

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to a127c5bbb6a8eee851cbdec254424c480b8edd75:

  vhost-vdpa: fix backend feature ioctls (2020-09-24 05:54:36 -0400)

----------------------------------------------------------------
virtio: last minute fixes

A couple of last minute fixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (1):
      vhost: Fix documentation

Jason Wang (1):
      vhost-vdpa: fix backend feature ioctls

 drivers/vhost/iotlb.c |  4 ++--
 drivers/vhost/vdpa.c  | 30 ++++++++++++++++--------------
 2 files changed, 18 insertions(+), 16 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
