Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72636C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 08:50:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04B79612DE;
	Wed, 23 Mar 2022 08:50:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tzgLMJiVW6ZF; Wed, 23 Mar 2022 08:50:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC1B960A99;
	Wed, 23 Mar 2022 08:50:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B225C0012;
	Wed, 23 Mar 2022 08:50:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAE0EC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C73898496D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t40FygPb55sb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93D5784959
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 08:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648025404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C46ALa3Wn3pwhctoVHx8CVmLq4tfYoG9vF9MoJZBSbM=;
 b=OauO7rNhAov2zQKrvBpRNTezlf9HzIVjkUdG4BdtghPPSQ9BXfnX5uzC83xiLwqW3Z65Tf
 1fxfqr9rtqvRbomD7N4BYKYOlbtm0japOEdIy9CbH+D4ZOWjbUyNpEePmQuzIrJ3zc8S2Y
 r8iFMZOKuRdhlCoJW0yQnYXgFEBp3ek=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-OSEhxgJQNlK7DVZRUY2V_w-1; Wed, 23 Mar 2022 04:50:00 -0400
X-MC-Unique: OSEhxgJQNlK7DVZRUY2V_w-1
Received: by mail-qt1-f200.google.com with SMTP id
 x9-20020ac81209000000b002e0659131baso676262qti.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 01:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C46ALa3Wn3pwhctoVHx8CVmLq4tfYoG9vF9MoJZBSbM=;
 b=kJASnVzKjZRLjSobBtC/TyMCTscBzs2+dsG8/KtV/HNLsX5oCLX2mO7lRZdEGUaiDE
 /DFAndyi9Lzv4VCBQc8T7AoMWFa9LT9RdiuVigCWDIn5a0E35DOGsDU/wFBB0gX6UyCP
 X+xVzDF+G7VDQr3IKdDU6QNH2Tc/CDHTXsPkuxbK5QE1Bp3p8TM5gGrEPRZ5uoOhY0TQ
 S48mNldD6gchhn1EG1dUjzsIYo+2W6RoMMwq5+K0/LXzZZCjKMNuthfzvKjPN5NhB8PS
 AP/D2pnzPcUYL3hKaOgOqFs1ioM1du5TSsZK7FpvdG7CBjl4XisIB2qBxO+u72aMndCk
 rHBg==
X-Gm-Message-State: AOAM532XIkh2evnyASbbzkm6+WHrp91tYLMM2WF2++SaAA1Fg03zssKe
 d4Sf1OdJRmXqvM7IrfuF3t1qHK/8aj24hmNedbJ9R5aOk0qMY4yWn8jVC3OuXR7+BEo6FGMETgV
 KV8FZ7VpvAeXoGLIos0STyGOSyo1sgkA6vxKHEe0zOg==
X-Received: by 2002:a05:622a:107:b0:2e1:d655:cc4c with SMTP id
 u7-20020a05622a010700b002e1d655cc4cmr23525896qtw.669.1648025400247; 
 Wed, 23 Mar 2022 01:50:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfE8/OMwCCgqFxQqE3tKOs0mFQYucCfXdxmrRXsheQTGYlj3H8WZkZdUr2Tkkn7dzVMymHwA==
X-Received: by 2002:a05:622a:107:b0:2e1:d655:cc4c with SMTP id
 u7-20020a05622a010700b002e1d655cc4cmr23525876qtw.669.1648025399984; 
 Wed, 23 Mar 2022 01:49:59 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 j188-20020a3755c5000000b0067d1c76a09fsm10640609qkb.74.2022.03.23.01.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 01:49:59 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net v2 0/3] vsock/virtio: enable VQs early on probe and finish
 the setup before using them
Date: Wed, 23 Mar 2022 09:49:51 +0100
Message-Id: <20220323084954.11769-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Asias He <asias@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

v2:
- patch 1 is not changed from v1
- added 2 patches to complete the driver configuration before using the
  VQs in the probe [MST]

v1: https://lore.kernel.org/netdev/20220322103823.83411-1-sgarzare@redhat.com/

Stefano Garzarella (3):
  vsock/virtio: enable VQs early on probe
  vsock/virtio: initialize vdev->priv before using VQs
  vsock/virtio: read the negotiated features before using VQs

 net/vmw_vsock/virtio_transport.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
