Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3A5C001B2
	for <virtualization@archiver.kernel.org>; Thu, 22 Dec 2022 05:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E16BA610DC;
	Thu, 22 Dec 2022 05:01:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E16BA610DC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=amz0S+3f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8VoghJ7tXpXx; Thu, 22 Dec 2022 05:01:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 65BF961080;
	Thu, 22 Dec 2022 05:01:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65BF961080
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DA39C0071;
	Thu, 22 Dec 2022 05:01:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 808E6C0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68F5B40153
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:01:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68F5B40153
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=amz0S+3f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a6ukAup2z0tU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:01:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC48E40141
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC48E40141
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 05:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671685269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9cfksyyN802rhXnNAv/0J7MXVcDFI/OT76q+tAGfEdA=;
 b=amz0S+3fX6h3xA+ouD+2O2C2bMiaBZQvU7vcrvxvInowAVs8fKtXgf79ah169iTX86YxUx
 JN9HNJIr5iXW8xZMvv7YR59SZeLGZFM86VZGvoBvC/NDgvsw1UfBSs8bR35Xn2hOUByqp+
 AUFYDTB+xgIBqdjlpStgVd8x8WPEdP4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-cBFe4bMDPSy0StRvkpFsOg-1; Thu, 22 Dec 2022 00:01:00 -0500
X-MC-Unique: cBFe4bMDPSy0StRvkpFsOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CB6E3C02B74;
 Thu, 22 Dec 2022 05:01:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-15.pek2.redhat.com [10.72.13.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AE3440C2064;
 Thu, 22 Dec 2022 05:00:57 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 0/4] Vendor stats support in vdpasim_net
Date: Thu, 22 Dec 2022 13:00:48 +0800
Message-Id: <20221222050052.20785-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

Hi All:

This series implements vendor stats in vdpasim_net. Please review.

Thanks

Changes since V1:
- typo fixes
- move the duplicated get_vendor_vq_stats() in
  vdpasim_batch_config_ops to vdpa_sim_config_ops
- use -EOPNOTSUPP instead of -EINVAL in vdpasim_get_vq_stats
- introdce a dedicated variable to record the successful cvq request
  and track the number of requests correctly

Jason Wang (4):
  vdpa_sim: switch to use __vdpa_alloc_device()
  vdpasim: customize allocation size
  vdpa_sim: support vendor statistics
  vdpa_sim_net: vendor satistics

 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  33 +++-
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |   4 +
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |   1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 221 ++++++++++++++++++++++++++-
 4 files changed, 248 insertions(+), 11 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
