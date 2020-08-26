Return-Path: <SRS0=/kjp=CE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB018C433DF
	for <virtualization@archiver.kernel.org>; Wed, 26 Aug 2020 13:28:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE67B214F1
	for <virtualization@archiver.kernel.org>; Wed, 26 Aug 2020 13:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4SObXwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE67B214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7FD0B848A0;
	Wed, 26 Aug 2020 13:28:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2jl2Dq5m9cUV; Wed, 26 Aug 2020 13:28:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0C8328484C;
	Wed, 26 Aug 2020 13:28:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA06DC07FF;
	Wed, 26 Aug 2020 13:28:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBB4FC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 13:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AA82F87C11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 13:28:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sxabafoESQMB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 13:28:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EA24687C10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598448502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=i67+aNF8QtmkXbZ+5JSUQwpOse6+0MGUqtdEKnlOGYo=;
 b=Q4SObXwIqXhBVDXo5ddCXC0ao/UUQJinuE+m/FsbGLI3qQ9NO3KPWnr+UxBSYRZFjuvx0K
 CEKj815+pBPfN0ZM0xRZB0cT7U2oACkXsfZPc4ACCZZVagm5/G2ZFYV/XnU1LXotHbzTUZ
 jtfJhKTkM72coH1njWVDRfX95WmHkGg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-skPiHg0DMQ6Qb02lS9BF2A-1; Wed, 26 Aug 2020 09:28:20 -0400
X-MC-Unique: skPiHg0DMQ6Qb02lS9BF2A-1
Received: by mail-wm1-f70.google.com with SMTP id q23so786815wmj.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 06:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=i67+aNF8QtmkXbZ+5JSUQwpOse6+0MGUqtdEKnlOGYo=;
 b=km2mvi4yfwMeaVKE//BTN39xLkGWoPV68cNasKn5jxbNG3rSz9U6P3Jmf2BL0dlktU
 13xzQmjUAAh/hraejBKIsEQ5Q7sirMPleoxq9LVaZ0BSlXBBlQX6fuQ6a+AWLKIhFHQ5
 oZzBeSmVVoBMb2hBJuxVZ9k17YLMkzYoS3d80accitPDqFrZfoguw5ThwwZ72gzwXiDw
 jFXXQYC+4LLQhnsimO0TOVrbHbvYceGVO2JVXXrYWLv0aXbqWXZ8AwEEt0YZdH+4AB0P
 dOB3K23AeJUxYFf1kwyLjwOr9YhemMyAVf5yNfnhS8y6b9AXMN+LrHZ1cp5DsjeNJ6SO
 Ot1A==
X-Gm-Message-State: AOAM533HlUcYEodi9X5Fjv7BiIg9duPuazb++dw+Lg1lNWp1pZhXoYeP
 2ENOdyo9pGwc6Zj6QooQHFSkAP4i46gyYGPmZu+LcjoE4Z5QPS9ytwDOAqEZETIXW4y1Fa01mbX
 wJHNw99r0h9gi7PsNI7wl8iZTue49rWcRg7Q4vKIu+A==
X-Received: by 2002:a1c:105:: with SMTP id 5mr7557739wmb.83.1598448499406;
 Wed, 26 Aug 2020 06:28:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE5CXik9B/yf7SlhoMl9P+rB1tllMpEuE0RJnSmFjwzWrgc4RXpHi+O77/0mfTHMtg2dZEVQ==
X-Received: by 2002:a1c:105:: with SMTP id 5mr7557705wmb.83.1598448499198;
 Wed, 26 Aug 2020 06:28:19 -0700 (PDT)
Received: from redhat.com (bzq-109-67-46-169.red.bezeqint.net. [109.67.46.169])
 by smtp.gmail.com with ESMTPSA id g62sm5158616wmf.33.2020.08.26.06.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 06:28:18 -0700 (PDT)
Date: Wed, 26 Aug 2020 09:27:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: bugfixes
Message-ID: <20200826092731-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, natechancellor@gmail.com,
 maxime.coquelin@redhat.com, elic@nvidia.com, lingshan.zhu@intel.com
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

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to cbb523594eb718944b726ba52bb43a1d66188a17:

  vdpa/mlx5: Avoid warnings about shifts on 32-bit platforms (2020-08-26 08:13:59 -0400)

----------------------------------------------------------------
virtio: bugfixes

A couple vdpa and vhost bugfixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jason Wang (2):
      vdpa: ifcvf: return err when fail to request config irq
      vdpa: ifcvf: free config irq in ifcvf_free_irq()

Nathan Chancellor (1):
      vdpa/mlx5: Avoid warnings about shifts on 32-bit platforms

Stefano Garzarella (1):
      vhost-iotlb: fix vhost_iotlb_itree_next() documentation

 drivers/vdpa/ifcvf/ifcvf_base.h   |  2 +-
 drivers/vdpa/ifcvf/ifcvf_main.c   |  9 +++++--
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 50 +++++++++++++++++++--------------------
 drivers/vhost/iotlb.c             |  4 ++--
 4 files changed, 35 insertions(+), 30 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
