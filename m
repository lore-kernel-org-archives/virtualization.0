Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22274C6377A
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:30:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89B96121F
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89B96121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96FB6608A2;
	Wed, 21 Jul 2021 14:30:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1xfomcPchBRO; Wed, 21 Jul 2021 14:30:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2E60860787;
	Wed, 21 Jul 2021 14:30:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0352FC0010;
	Wed, 21 Jul 2021 14:30:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2290AC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1159160891
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:30:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FKr_wWit-rzN
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:30:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1786360787
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:30:16 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id c12so2437069wrt.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LsCZd4JYUlf4DgBXgVbea7RBOXoDbg1vUKFjYIRULao=;
 b=aRMmcMrQz3DNodcGZGJNIgwPB9ul8Scws6Wh44encugspS+AkIqOs1L5KeTTCR2oCr
 xm3up+Q1gK1r4UgRJfAUz0oWx54v97ib7+QiXJpg427VUpaTcC+kpFi2/kD7Pi2HuD9n
 amhCyXF4Un6rMyMpJ7diOOYjlg1OEoudCOCJAHmUH2+Lk8EDjkFIEdZo6zCvF/+FEnum
 pDNnXX42eNYuz/mqaozaReZ1dbcX5I19N5au4G2LtPAwqeEe/DqaFnJhKhtJjH0Ag/oC
 S9iAWmdAyeBp8wGcibVN1oM45ePOc9cSysgEkLqnvI5ihNEyG+lZ2phdaums+IGcpXAw
 ALBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LsCZd4JYUlf4DgBXgVbea7RBOXoDbg1vUKFjYIRULao=;
 b=A9U5v/XD41fgizR6+sruvpZEQP+CMcXFcQIaGyQRbKkX5UVQBrZS6Wdg9mkLPJcB4W
 W/E5CyESD5HhuOt6p28gZOjkSvWVPLU7/Q0pFZIoGKEMtaLlAPTdCNF1v2GpVMh0y4hK
 +9gBbqSflPagp5xj0uI9pn/QycAeAMcoZ39fY8vz87idOr+sQ3aFS8T3anOx4JJ0xEuf
 321uLdrTiDlPEOWrWmIecElDXVhGXOG7JpxAcIXolVopTWUAYY/QS6JGRky1fbBcFVCi
 6k7ecadsZN+dpuCQpiLszelJoo0t3/s0cR+Z07OVODeSXvk1Ehnu2g7Fr0Q1qdZ375pS
 HQSw==
X-Gm-Message-State: AOAM5319UmjVvdEip7wJTKycVoxfyxL2Ahy79gl/3K+66z1li9nDaq/k
 niAKu8lP6JkdpvlMKUbtarx/rQ==
X-Google-Smtp-Source: ABdhPJy+FE5eryA5W6yWBtAOKXEQABDp/4ZN/cKYH6WivHT4TnZA/3j3HuxrxR7/mHKgfaB1peeREg==
X-Received: by 2002:adf:f149:: with SMTP id y9mr42188978wro.85.1626877814260; 
 Wed, 21 Jul 2021 07:30:14 -0700 (PDT)
Received: from localhost.localdomain ([31.124.24.141])
 by smtp.gmail.com with ESMTPSA id 19sm133900wmj.2.2021.07.21.07.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jul 2021 07:30:13 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 1/1] virtio/vsock: Make vsock virtio packet buff size
 configurable
Date: Wed, 21 Jul 2021 15:30:00 +0100
Message-Id: <20210721143001.182009-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ram Muthiah <rammuthiah@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
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

From: Ram Muthiah <rammuthiah@google.com>

After a virtual device has been running for some time, the SLAB
sustains ever increasing fragmentation. Contributing to this
fragmentation are the virtio packet buffer allocations which
are a drain on 64Kb compound pages. Eventually these can't be
allocated due to fragmentation.

To enable successful allocations for this packet buffer, the
packet buffer's size needs to be reduced.

In order to enable a reduction without impacting current users,
this variable is being exposed as a command line parameter.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Ram Muthiah <rammuthiah@google.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/virtio_vsock.h            | 4 +++-
 net/vmw_vsock/virtio_transport_common.c | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 35d7eedb5e8e4..8c77d60a74d34 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -7,9 +7,11 @@
 #include <net/sock.h>
 #include <net/af_vsock.h>
 
+extern uint virtio_transport_max_vsock_pkt_buf_size;
+
 #define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
 #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
-#define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
+#define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		virtio_transport_max_vsock_pkt_buf_size
 
 enum {
 	VSOCK_VQ_RX     = 0, /* for host to guest data */
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 169ba8b72a630..d0d913afec8b6 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -26,6 +26,10 @@
 /* Threshold for detecting small packets to copy */
 #define GOOD_COPY_LEN  128
 
+uint virtio_transport_max_vsock_pkt_buf_size = 1024 * 64;
+module_param(virtio_transport_max_vsock_pkt_buf_size, uint, 0444);
+EXPORT_SYMBOL_GPL(virtio_transport_max_vsock_pkt_buf_size);
+
 static const struct virtio_transport *
 virtio_transport_get_ops(struct vsock_sock *vsk)
 {
-- 
2.32.0.402.g57bb445576-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
