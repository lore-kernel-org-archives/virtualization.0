Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C424C4332F
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 05:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 607FE418A3;
	Fri, 23 Dec 2022 05:56:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 607FE418A3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fcvOvMjU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UdMXTjHAkZlS; Fri, 23 Dec 2022 05:56:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BE481416A3;
	Fri, 23 Dec 2022 05:56:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE481416A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B1F8C0071;
	Fri, 23 Dec 2022 05:56:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79E92C0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 405474179D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:56:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 405474179D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bzj8VShfV7no
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:55:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37A30416A3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37A30416A3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 05:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671774957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KBOBd99fUJastenAf++fTvV9fk5DffNPNG/DcWaJa1o=;
 b=fcvOvMjUTroTAL1cmh+AbdhHvK8c+yna53UMdV4lHy6MMbBfLlak6mEI0VeWHXSyyrS3AY
 LxJu2BlDoZGCqJ4h55o6Vov8Qml3wqFlX+qp3D0hEsrMQeNko7yB7dUyUgdS4YzonedZDu
 RB1lQrD9rqwa5a4mAh/WljdkWdiNKPU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-b1s9w8mBPtWMrVK1NJNRow-1; Fri, 23 Dec 2022 00:55:53 -0500
X-MC-Unique: b1s9w8mBPtWMrVK1NJNRow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 855E918811F5;
 Fri, 23 Dec 2022 05:55:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-204.pek2.redhat.com
 [10.72.12.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBE3C40C2064;
 Fri, 23 Dec 2022 05:55:50 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V3 0/4] Vendor stats support in vdpasim_net
Date: Fri, 23 Dec 2022 13:55:44 +0800
Message-Id: <20221223055548.27810-1-jasowang@redhat.com>
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

Changes since V2:

- rebase to Michale's tree (linux-next branch)
- remove unnecessary blank lines
- twaek the error code handling

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

 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  30 +++-
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |   4 +
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |   1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 218 ++++++++++++++++++++++++++-
 4 files changed, 243 insertions(+), 10 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
