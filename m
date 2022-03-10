Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D806C433EF
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 01:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B255041754;
	Thu, 10 Mar 2022 01:35:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s1x8eZo-9vNB; Thu, 10 Mar 2022 01:35:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C3BFB416F7;
	Thu, 10 Mar 2022 01:35:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B19EC0012;
	Thu, 10 Mar 2022 01:35:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 448C3C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 01:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E7B460AD7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 01:35:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GaBosxGDEhy3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 01:35:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9734F60ABA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 01:35:37 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id h10so4524489oia.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 17:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5UzCHhypSkLJprIXAcMJhvJcBDOhuIsnr/TqtkFrZpo=;
 b=5CWfNuQnq3T6VLziyCSzpYLHCjRXHXcRUwrSz57Y2WfpNkXw5VeFlyQrd7ARqDXTQk
 zexFPf/UYIxd3e4xRheUNzv1FxZRsWZSxWT/8wESvYH9pFvC/fxAx5rfUQjCQE44wuch
 0rSM9QVMeLDGoJr4u6gYWDlfX7+U419hq1MTikMZpATS3C82DuFC52yHV0l0n0sCkfse
 NgE3NnYebsCcKL0WzjkrZ46Gpdb+CMcEk3SXkwqOX6L9m//w1g20tnKLRa1mHICDXy2R
 DxL5ZroZrSvWIvxpKPQCE/MUw1UeFLlKs3cSzLaAom5H0w61NqNbxqk79p9BXaqdUg6C
 MNeA==
X-Gm-Message-State: AOAM532Rk8WjdPz47hsJNDGv0a3ORKvFNwDXrmh51CiaEgLmxCY9zvRy
 jMcQJ+eAEK3DrMJwz8rMRg==
X-Google-Smtp-Source: ABdhPJzXxezvZ337NuQsQzgroJveKS/fHqg0+gFbTkvhk/uJ9k69i1LpQrABuKsRN0em6jlNQ/6aSg==
X-Received: by 2002:a05:6808:114d:b0:2d9:c932:d713 with SMTP id
 u13-20020a056808114d00b002d9c932d713mr7802966oiu.210.1646876136599; 
 Wed, 09 Mar 2022 17:35:36 -0800 (PST)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
 by smtp.googlemail.com with ESMTPSA id
 ds3-20020a0568705b0300b000d9c70e5275sm1627152oab.54.2022.03.09.17.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Mar 2022 17:35:35 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] dt-bindings: virtio,
 mmio: Allow setting devices 'dma-coherent'
Date: Wed,  9 Mar 2022 19:35:27 -0600
Message-Id: <20220310013528.549030-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

'virtio,mmio' devices are always coherent within a guest. As Arm DTs
are default non-coherent, the 'dma-coherent' property needs to be set on
the virtio device to mark them as such. This aligns with the QEMU 'virt'
machine DTB.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/virtio/mmio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
index 4b7a0273181c..10c22b5bd16a 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.yaml
+++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
@@ -20,6 +20,8 @@ properties:
   reg:
     maxItems: 1
 
+  dma-coherent: true
+
   interrupts:
     maxItems: 1
 
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
