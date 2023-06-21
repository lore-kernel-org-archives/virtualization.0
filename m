Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5C1EB64D7
	for <virtualization@archiver.kernel.org>; Wed, 21 Jun 2023 15:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7B4640332;
	Wed, 21 Jun 2023 15:04:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C7B4640332
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R27AZ4iO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hxDAf0_Yip1P; Wed, 21 Jun 2023 15:04:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B5AF40188;
	Wed, 21 Jun 2023 15:04:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B5AF40188
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D753C0037;
	Wed, 21 Jun 2023 15:04:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59189C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 15:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2143640188
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 15:04:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2143640188
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d5taaBuS0BE5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 15:04:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CA57400E8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CA57400E8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687359887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=uMB3ETdHgdD0tMcM81kCwTmy5JB6eW9+tHfNYuJVs80=;
 b=R27AZ4iOLwKkrApOGfBl1IT9vQhadjOM2ZRGp3HWU4g8SLdgSc67kDyxOGB/AAKME49Ifc
 04R9huigr0GOrEJmYylYC4KEGATPmuOKaAs6JfYu6Ckmw+8RNKyflTYPWMS4JOwWgYCnGM
 Lg+pweeWcDb6Te9FBbvURmURR3O6Pqo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-T4QxFSHcPYGFDw2PNJSxOw-1; Wed, 21 Jun 2023 11:04:42 -0400
X-MC-Unique: T4QxFSHcPYGFDw2PNJSxOw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b448b13faaso46362771fa.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 08:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687359881; x=1689951881;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uMB3ETdHgdD0tMcM81kCwTmy5JB6eW9+tHfNYuJVs80=;
 b=iiRzrKvK0ql0278VMPYaIfMmr2s/fsYi5aaZpowwCIL+64KJKbUJrzLPgr/pAFSovj
 DQcVRBQ3AAD5tRaRb6fFMCarJXTLVlAs8Kyku8AvbL387Nbq+iIFT1u1aW96x4HciTq8
 sdgR+kIzB0iAbrfoyHbcYL4aA6nO6gjwlAc7FFQmhJGkx9Ls9q6D9xz+P53IC+YqiLh4
 EbxI39A0kXrSdXHdmcIKLqCoMwKea092TWvc6SI4gonun0LbG0IdO/WlcXRBCR5MK+x1
 eCRpplXCeTLN+etnmUH9HBVtrUXPxx7XYXamryPUXu9o3lAd7zYX0/QWfhb3b3ycbjtt
 Bo6g==
X-Gm-Message-State: AC+VfDyVLAcUhRZNlX9KOsTIuVKqIAGvKYypAOk9zDXIDlVKvFuxDdkS
 JLNxfPx64R/GCOOVu1SWaFJmVsyWEDIlVD+LKi4rE7yj0OsUDFmZtz9rRcT8j1LmF+I44guiQCY
 +UIpaEMKX81memve9OiD5v2v776deaSZeSK9sVf9umA==
X-Received: by 2002:a05:651c:8c:b0:2ad:9783:bca with SMTP id
 12-20020a05651c008c00b002ad97830bcamr9809843ljq.27.1687359880944; 
 Wed, 21 Jun 2023 08:04:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6vuvyyKGk8qVbIbbO2C0uzdA3jUE5LT/K/8MPLqve8CmK2tHPbnZ1hPdf3acB2DVxep5kd3w==
X-Received: by 2002:a05:651c:8c:b0:2ad:9783:bca with SMTP id
 12-20020a05651c008c00b002ad97830bcamr9809823ljq.27.1687359880587; 
 Wed, 21 Jun 2023 08:04:40 -0700 (PDT)
Received: from redhat.com ([2.52.159.126]) by smtp.gmail.com with ESMTPSA id
 e14-20020a50ec8e000000b0051a5c6a50d4sm2743117edr.51.2023.06.21.08.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 08:04:39 -0700 (PDT)
Date: Wed, 21 Jun 2023 11:04:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: last minute revert
Message-ID: <20230621110431-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lkp@intel.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 suwan.kim027@gmail.com, martin.roberts@intel.com, edliaw@google.com
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

The following changes since commit 45a3e24f65e90a047bef86f927ebdc4c710edaa1:

  Linux 6.4-rc7 (2023-06-18 14:06:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to afd384f0dbea2229fd11159efb86a5b41051c4a9:

  Revert "virtio-blk: support completion batching for the IRQ path" (2023-06-21 04:14:28 -0400)

----------------------------------------------------------------
virtio: bugfix

A last minute revert to fix a regression.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      Revert "virtio-blk: support completion batching for the IRQ path"

 drivers/block/virtio_blk.c | 82 +++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
