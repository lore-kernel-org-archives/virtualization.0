Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A31C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 17:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 54E4240FBB;
	Wed, 23 Mar 2022 17:36:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lVYwsmeXJKsV; Wed, 23 Mar 2022 17:36:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C413E400E2;
	Wed, 23 Mar 2022 17:36:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 956F7C001A;
	Wed, 23 Mar 2022 17:36:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AFF2C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0226241BA4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LdPcus3xTU74
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB83741B5D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648056995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MzwRKwBdRCLittF2Yi0pCWERtTQbkRUJ2eaS0FEovlY=;
 b=dNBZv7ybLJL0439plQb3dMwAMc5FtBiHDjnb6IzGRoJriJSm9TzS+kBQGW6cBxpP3Kh8fV
 OA776t3/1WwaoS1GtrBr+z5ycXiJat6L3lRzbpmSAPUep0DBKkwJC0NPXXHGGk/Ibmd5DM
 KfdJhhAzCsuWQSyVp7kOjhSCt1Q1DJc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-6PRAjdzYNG2UB47j1-zaoA-1; Wed, 23 Mar 2022 13:36:32 -0400
X-MC-Unique: 6PRAjdzYNG2UB47j1-zaoA-1
Received: by mail-qt1-f199.google.com with SMTP id
 g22-20020ac870d6000000b002e20a1508ecso1729671qtp.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 10:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MzwRKwBdRCLittF2Yi0pCWERtTQbkRUJ2eaS0FEovlY=;
 b=XU/CZm+VpTMl3cTEm1gSbDOK+0PS6GxkceSLGm1OyVFx7pG+hn2m0ympOtHdRqnEEN
 uE5sZZ3sUBLGPcivA9b2CKeDwU2qhT24vz9P7FRMjRL8TROXfrllAPYnXImJgkOzlG4e
 LWAAD/M2soAIZgGXXrDbhGuGzaIWyXi6IueDtAqt0H4emY3k+bzBo/prBsI4EegG8yTJ
 I8xQwLG3RstjliDFcZTv5F2I0ML0hGRd04k8njB6QQ4r7Krw+cMo8kN8rnZEzEtiAebA
 RrTQT8t77SP7pvxrkIvCNkTD/GuubRMPXdwWwpmFWgGbKt/wXxvVveqHrg5hz5XyxhcQ
 iQQA==
X-Gm-Message-State: AOAM531Yehep0XDGa2ukQcXFvOqEd8YXPNgfzIilXTceYdT25Z8nwAgH
 nNgj2nL/Z/nyiuw4YxWEmRKj0udLalmKY1JsdJmyHkmlPkamLbv4IOUaH2yeeOW0TlebXqF0+9H
 nQ85D6OqofVOsCC2f51084fqOpd1yiBoQB56idIAVCQ==
X-Received: by 2002:a05:6214:2509:b0:435:7443:2dad with SMTP id
 gf9-20020a056214250900b0043574432dadmr938554qvb.47.1648056991873; 
 Wed, 23 Mar 2022 10:36:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeN8QDcW/nCBes+HF3p4Qa8YtXACGqrPDG30FPUtcA4s5rpDfAh0kaotVknOsyPTvs3/VKmw==
X-Received: by 2002:a05:6214:2509:b0:435:7443:2dad with SMTP id
 gf9-20020a056214250900b0043574432dadmr938508qvb.47.1648056991171; 
 Wed, 23 Mar 2022 10:36:31 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 h14-20020a05622a170e00b002e1a65754d8sm476127qtk.91.2022.03.23.10.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 10:36:30 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net v3 0/3] vsock/virtio: enable VQs early on probe and finish
 the setup before using them
Date: Wed, 23 Mar 2022 18:36:22 +0100
Message-Id: <20220323173625.91119-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Asias He <asias@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Arseny Krasnov <arseny.krasnov@kaspersky.com>
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

The first patch fixes a virtio-spec violation. The other two patches
complete the driver configuration before using the VQs in the probe.

The patch order should simplify backporting in stable branches.

v3:
- re-ordered the patch to improve bisectability [MST]

v2: https://lore.kernel.org/netdev/20220323084954.11769-1-sgarzare@redhat.com/
v1: https://lore.kernel.org/netdev/20220322103823.83411-1-sgarzare@redhat.com/

Stefano Garzarella (3):
  vsock/virtio: initialize vdev->priv before using VQs
  vsock/virtio: read the negotiated features before using VQs
  vsock/virtio: enable VQs early on probe

 net/vmw_vsock/virtio_transport.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
