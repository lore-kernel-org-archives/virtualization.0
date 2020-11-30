Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B20DC5519F
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 08:50:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD9C2074A
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 08:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVvwVuy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD9C2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 075E0873AF;
	Mon, 30 Nov 2020 08:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jDCaIKw5T407; Mon, 30 Nov 2020 08:50:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7516A873AB;
	Mon, 30 Nov 2020 08:50:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53420C163C;
	Mon, 30 Nov 2020 08:50:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B19A5C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 08:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 01DF1873B1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 08:50:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p4k46qXyOilV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 08:50:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C994A873AF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 08:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606726216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=IfhR367gJyQi+IqH9Qg+155OiV0npyw4vEgjmNlOLaQ=;
 b=OVvwVuy9bV/wZuMiPq/3Bin/8uVuJluUKcpheTlVSE+HnTwlvXAPbSukvfCoXEx4BORlj6
 PhgzwPr/rr91xitYsngH6AcFdQLzE+wtdfhNTaH1hiy9D39ompMG0Vgbku8bUwOGZ1gYrh
 IY4nxy3o7E++vuCK8tW2VYHMnbmHd28=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-ewcnq6ncNSCHe1YI_z6OQw-1; Mon, 30 Nov 2020 03:50:14 -0500
X-MC-Unique: ewcnq6ncNSCHe1YI_z6OQw-1
Received: by mail-wm1-f69.google.com with SMTP id z16so4051478wma.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 00:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=IfhR367gJyQi+IqH9Qg+155OiV0npyw4vEgjmNlOLaQ=;
 b=W3OXSAJyMK3gEzlvAne8ib7SfnArqFMj1+NIMh8gt4AqAiyNTUfACKhRcimRKBdDhO
 7V6xH8f2xYYSl+7bhOpjOO+ExILHdrSyFNagbITm7vFlWLAo9e3CnZn0n92z/wLM2yZV
 sPxYw+Na0/nZtUvP/OdXaZawmcnyOeUs/Yv0B67jMU25hdWeEZxBS5QbpGiyYfDm9T5u
 E8dK3GD1CklEUE65+CoJg+BrrAwWjOmDC+Kdw2zKHIh1Xw/AZX+HxzxgONLGGlQ4D7O/
 Tkk3pIufYrhIidNUMZdAuSeZjg6Wn891qG1g+JV1FDeVDYynLzQhZBh2W4gC7tSzl2UV
 wfwQ==
X-Gm-Message-State: AOAM530kuV5WOX377xtGYp2RQD7WR2jjU6/TPVl34qlgj5Y0i1b4yGkd
 wjba3C54znbCudH5o2d7VwqouCAdZJcH2oVD7Xj1RCPBKBusdjEK86WA2vCpry92OUfkdUHI+ak
 eMZZ1s9ZqCi2hkTO1rzcKKroZ4ZA5HECGMoW5B3C/VQ==
X-Received: by 2002:a1c:9a4d:: with SMTP id c74mr15059099wme.5.1606726213696; 
 Mon, 30 Nov 2020 00:50:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0lcq9LYEeQweeQ1PUtnvowfMkCnfs7A6y+pZ1luBu47l3TNrIhMMTxE9tXFN2kqV6KXqSzQ==
X-Received: by 2002:a1c:9a4d:: with SMTP id c74mr15059071wme.5.1606726213486; 
 Mon, 30 Nov 2020 00:50:13 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id 21sm12930310wme.0.2020.11.30.00.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 00:50:12 -0800 (PST)
Date: Mon, 30 Nov 2020 03:50:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vhost,vdpa: bugfixes
Message-ID: <20201130035010-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, si-wei.liu@oracle.com, michael.christie@oracle.com
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

The following changes since commit 418baf2c28f3473039f2f7377760bd8f6897ae18:

  Linux 5.10-rc5 (2020-11-22 15:36:08 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to ad89653f79f1882d55d9df76c9b2b94f008c4e27:

  vhost-vdpa: fix page pinning leakage in error path (rework) (2020-11-25 04:29:07 -0500)

----------------------------------------------------------------
vhost,vdpa: fixes

A couple of minor fixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Mike Christie (1):
      vhost scsi: fix lun reset completion handling

Si-Wei Liu (1):
      vhost-vdpa: fix page pinning leakage in error path (rework)

Stefano Garzarella (1):
      vringh: fix vringh_iov_push_*() documentation

 drivers/vhost/scsi.c   |  4 ++-
 drivers/vhost/vdpa.c   | 80 ++++++++++++++++++++++++++++++++++++++------------
 drivers/vhost/vringh.c |  6 ++--
 3 files changed, 68 insertions(+), 22 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
