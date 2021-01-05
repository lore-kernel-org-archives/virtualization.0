Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0A7C433E0
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 12:21:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0827229F0
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 12:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0827229F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 84B6D85AFF;
	Tue,  5 Jan 2021 12:21:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8XVeXiDzi6xm; Tue,  5 Jan 2021 12:21:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 041BB85EA7;
	Tue,  5 Jan 2021 12:21:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3731C088B;
	Tue,  5 Jan 2021 12:21:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55B9DC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3D0D685EBB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TchssmkLW1sl
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:21:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7DD9C85EB8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 12:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609849312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=U39k5ipMHANWOJWrOXSYV59iZX09Ei6dL9ebZb8Ogeg=;
 b=h0lLt4/Tksg6sI88+7rwPMzNQCYPJcQNpokcL+CsnYogR/Knm6EeB1j/rMH0Xv7n/UlUQX
 LlkU39FznW/EwWqgsRi0jFX8bk+O+VXF0sqjFU3xTMPuUBN4p4SuN8NmJrzE+D7PpMZsIo
 x0Aay4OYfwQIX3GQJGqZpcZNh9OuCUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-ya7PpDUHNHC5R9YmjcLjRw-1; Tue, 05 Jan 2021 07:21:50 -0500
X-MC-Unique: ya7PpDUHNHC5R9YmjcLjRw-1
Received: by mail-wm1-f72.google.com with SMTP id k67so1173660wmk.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jan 2021 04:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=U39k5ipMHANWOJWrOXSYV59iZX09Ei6dL9ebZb8Ogeg=;
 b=SvuJVMG1UuPjmPfHuj9yHEUCcEfqkY86fbmPt1ObXopcvRXLnKFC8TTdJJ9nXBGl4z
 hgGbrW1/PO1KhgetmCMiq83T3S06Ao3kh3gi9x3SJKNg5x39SglO/4ZZLO4IK5AEqR+r
 9gxAC3QKAdmppVdeGPlUcNPPGxaAC+6L18cBv41dpMHEr9xUg4j3sr1PNzLHryVSUtJM
 9xUxhpZct0FoXJfH/UAwCJfJl9snKepzR1tiZ/SGkpKJeyoAaFdoHBGgG1RO3WJndYmO
 qmhMx0mbBi17ayBT3UeZYxpYsIHpeq60b3bInuE/aHJe/m38pXx3eiSsQnuukm7ioy1c
 QfiQ==
X-Gm-Message-State: AOAM53034RVhbgV2NpTIlOgzc4ZUKtdguhYkMrslSJ2kSrZC+aEl1i3L
 XVtFPQ8e2szf/0U4HJ4c27mqo67dU5QgpyypHw+PERaWyWEcFY6U9q6mSqK8kMbdT+xTG7pzYLm
 vrCPb1RB9CmrsSrxoEtB7iDlEI65iXMRUiU6ipSU81Q==
X-Received: by 2002:adf:bb0e:: with SMTP id r14mr85949745wrg.159.1609849309293; 
 Tue, 05 Jan 2021 04:21:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRxC04NYGeb6WaL98Uxtwkp2M43zTcBL2qoRpI0IP4stOIB1HKct8R0XtAhgJEy1jrpROFhg==
X-Received: by 2002:adf:bb0e:: with SMTP id r14mr85949711wrg.159.1609849308953; 
 Tue, 05 Jan 2021 04:21:48 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id y7sm3716921wmb.37.2021.01.05.04.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 04:21:48 -0800 (PST)
Date: Tue, 5 Jan 2021 07:21:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vhost: bugfix
Message-ID: <20210105072145-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

The following changes since commit 418eddef050d5f6393c303a94e3173847ab85466:

  vdpa: Use simpler version of ida allocation (2020-12-18 16:14:31 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to e13a6915a03ffc3ce332d28c141a335e25187fa3:

  vhost/vsock: add IOTLB API support (2020-12-27 05:49:01 -0500)

----------------------------------------------------------------
vhost: bugfix

This fixes configs with vhost vsock behind a viommu.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Stefano Garzarella (1):
      vhost/vsock: add IOTLB API support

 drivers/vhost/vsock.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 3 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
