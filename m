Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF66C433DB
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 15:45:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A424865093
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 15:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A424865093
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 445F287263;
	Fri,  5 Feb 2021 15:45:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YjwmYEw1tD-j; Fri,  5 Feb 2021 15:45:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9886B87081;
	Fri,  5 Feb 2021 15:45:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B22DC08A1;
	Fri,  5 Feb 2021 15:45:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EB03C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 20E2387263
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:45:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wKCO3sQxCHGH
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:45:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A58AD87081
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612539927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=+vT+jbN1YVSVSpzQpXP9jC5D0CiFueilUGvKuUc6MhE=;
 b=LNKkTD4MPtA0LpN99vxWS+PdyoDlHyesMoDY2iGD/Dx4g/8o1CQFuQUoQ3o3Z/gjbPMJgm
 E7qCj1thGWaWe03vXpDhf/EJWEAVE4epTRZbLm4iEe9JNzS/nGerzg7d/z/X++YQzzlt0D
 NrEkB0kVmoZQW3yd4QSw+rbQ6QQwLp8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-or3XAWumPFyACHqNXbnqBQ-1; Fri, 05 Feb 2021 10:45:26 -0500
X-MC-Unique: or3XAWumPFyACHqNXbnqBQ-1
Received: by mail-ed1-f71.google.com with SMTP id a26so7271612edx.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Feb 2021 07:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=+vT+jbN1YVSVSpzQpXP9jC5D0CiFueilUGvKuUc6MhE=;
 b=cqFSmEwSHCyGlEjGYEpT4VojCnm1xTiL1TSHYCmMdkghutsuAJYtWoM/ycJiUryrkD
 7v0RcC7UdjNHa3Uw+pbkFhmI1UtETZdA9XU0wODZYrVT6UxRNRKg2chRPR/7sWnc6yMn
 fdL2fdq+KcQs+gpkUxLJWvGRbgaFjP0+ZQvrDHLMJoTK9DpofZOHUurzEBxstvsJCzl/
 RUPDVzQ5adzJFzu8c+PhFXUwSbYGmLfUU8eZgrRTvAtyIB8Olqa4zFbBW+zr2S6oi8IP
 egahpdkPhV6/JXY8Rop2FfcYkCzljgPbP5yzaCffDTgscAfK3e8RQrKKbnftqBg43kMQ
 aCLQ==
X-Gm-Message-State: AOAM533eUcSQwgogLLNd+CrUXkSF+bARvqUrhtea3WZmmqwIHChrOcKY
 QKKHa1avuZI3Qrl/DZmRtu9lqKpmbJ02BTdgD+gq855CmEeAET0AqRZ6UXeXdZ2ZdBwnOmMh2Xy
 QQFk4JJCXkuWoOHRevZniNbh9B/Ny5ufw/d4Gjz0PXA==
X-Received: by 2002:a17:906:8292:: with SMTP id
 h18mr4553199ejx.342.1612539924139; 
 Fri, 05 Feb 2021 07:45:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqBUHpbvPYDpBnMWonVBrhZuXG+GwON2f3pVr2d/bLWj6ekzRtN+o9kgto+FKOSFfskxHUQg==
X-Received: by 2002:a17:906:8292:: with SMTP id
 h18mr4553187ejx.342.1612539923963; 
 Fri, 05 Feb 2021 07:45:23 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id y8sm4030809eje.37.2021.02.05.07.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Feb 2021 07:45:23 -0800 (PST)
Date: Fri, 5 Feb 2021 10:45:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vdpa: last minute bugfix
Message-ID: <20210205104520-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com
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

The following changes since commit 710eb8e32d04714452759f2b66884bfa7e97d495:

  vdpa/mlx5: Fix memory key MTT population (2021-01-20 03:47:04 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to b35ccebe3ef76168aa2edaa35809c0232cb3578e:

  vdpa/mlx5: Restore the hardware used index after change map (2021-02-05 10:28:04 -0500)

----------------------------------------------------------------
vdpa: last minute bugfix

A bugfix in the mlx driver I got at the last minute.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (1):
      vdpa/mlx5: Restore the hardware used index after change map

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
