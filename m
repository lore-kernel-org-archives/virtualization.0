Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E517EC43334
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 11:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 53F4140BB6;
	Tue, 21 Jun 2022 11:42:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53F4140BB6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernkonzept.com header.i=@kernkonzept.com header.a=rsa-sha256 header.s=mx1 header.b=gZPlPh4b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3dFrO6GnOn6C; Tue, 21 Jun 2022 11:42:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D890640BAB;
	Tue, 21 Jun 2022 11:42:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D890640BAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 962A7C0032;
	Tue, 21 Jun 2022 11:42:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2694C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 11:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC6A440BB4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 11:42:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC6A440BB4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t-dKhcZgHv8V
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 11:42:37 +0000 (UTC)
X-Greylist: delayed 00:32:24 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B37D740BAB
Received: from mx.kernkonzept.com (serv1.kernkonzept.com
 [IPv6:2a01:4f8:1c1c:b490::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B37D740BAB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 11:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:Message-Id
 :Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D6GD7v0OxoQRiN+PLWPk/I3LPeDqLQnzXNY1W/TtwTQ=; b=gZPlPh4bRTWAWM9vsyz7KyFwPl
 ZU9yrDlz4CFhbD36JLeX5/a659POUAmFVCZe+piXKe6F6j0nsYxdX1Mc2UEUX7XNq6YmTBdaVGRua
 /HgJPpEdArS0HD92yeO0ZYehtWRJxTuZuvqn+YlMQMT133b6PMIat7tVzdXw7ifof9YyxyKPp12K8
 9F7ZAaX/t2aU7m7rTDPXHS7iCPaNODfQlsj8RYYuhSKFH/P0IfNPSbf1Ch4t7/5WCq2IapIZs38zL
 yeozHzaIZIpqEJ3tbIK0uR+AAXn2DUpEEAdGVPtrv1568qARjisNNEPtbfT7KbzHRLOImRXJmjOuL
 6ea98NTA==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
 by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
 id 1o3blo-005hKr-Fd; Tue, 21 Jun 2022 13:10:08 +0200
From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/2] virtio_mmio: Fix suspend to disk (hibernation)
Date: Tue, 21 Jun 2022 13:06:19 +0200
Message-Id: <20220621110621.3638025-1-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
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

At the moment suspend to disk (hibernation) works correctly when using
virtio_pci, but not when using virtio_mmio. This is because virtio_mmio
does not call the freeze/restore callbacks provided by most virtio
drivers.

Fix this by adding the missing PM calls to virtio_mmio and restore
the guest page size for the legacy version of virtio_mmio.

Stephan Gerhold (2):
  virtio_mmio: Add missing PM calls to freeze/restore
  virtio_mmio: Restore guest page size on resume

 drivers/virtio/virtio_mmio.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
