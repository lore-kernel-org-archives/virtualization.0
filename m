Return-Path: <SRS0=15y9=JX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C7DC433ED
	for <virtualization@archiver.kernel.org>; Mon, 26 Apr 2021 10:20:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A392611CE
	for <virtualization@archiver.kernel.org>; Mon, 26 Apr 2021 10:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A392611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codilime.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFEDA8366E;
	Mon, 26 Apr 2021 10:20:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3UVvW6o9FCP8; Mon, 26 Apr 2021 10:20:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BCF482E0E;
	Mon, 26 Apr 2021 10:20:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30D23C000E;
	Mon, 26 Apr 2021 10:20:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B08EBC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 10:20:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F50C605F0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 10:20:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=codilime.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KND9xRngRmWO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 10:20:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F58B6058C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 10:20:14 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id n138so87604478lfa.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 03:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codilime.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=WxYWwA6mEw0KJTNBuUofOdthE/VY20C4OhSk4uI2arc=;
 b=PO1YmaoDYrmmfBHZ87vyRz1Qp8Mb2BDYvze7Sy/UiziGsAlmDd6UjvnwdZWTIbcFhh
 qjS7DwpuT+e8wHByeFC5SUcA1fbp0gV7GfOqoGcMry3YdzmZcT2lKX79GkYjeaKOjoyM
 vSc0H6+xk1JREdGMjlB9A9vwTKjbZmlEbYunnfJt4XjhWb3vBBCPnha+PbNyuD6m6XdS
 66msNI6pPuaGYJHgHSsXhwT3mwjxV9Ukv5Y0OfLQuZV+jAiknhrEpw3/58Pz1LnCtwsh
 LP1fr2j0RE+fVTozN2wgq3iNMxvCIriOhn5fCz0Ge/bUb1xaBCXPgQu/bzvwkxClrpJP
 lYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=WxYWwA6mEw0KJTNBuUofOdthE/VY20C4OhSk4uI2arc=;
 b=PmiFhQFMCK1F9fWewnYZ1QUEa2MQDcUozkTTjymfIU0WNlqoM/W0RKu9UrKOqih01r
 fpu/6unKQgelDUMElBm5MlBSCHFMOjf/MFAD13tYSDynW9TNtPjHBRIj5QApQ+5zrPLh
 oSP1yqubyCNj2iqIH+10+d0ItW8kh5wQnYjekDHqrvyUDLm9r68f0+kL1yyzqnUJcE1h
 hiWlKw/+6PAjwLbBumRIIzhJQnNsLcDjJV+odQbbfEevhSRxXh8J3VobiH2L1ctIHnMX
 132g52tp8KEGWk16OAiCoZsSJ76Qp27tCHWySSHoKaWBHPaFJw5eR9qWQtw1GwCOBjmw
 avAg==
X-Gm-Message-State: AOAM531hOV+UN6a2swB/o0pRb1Tfrx8avP1x/PzSYt/4x5MqWluiRvI3
 ESjDaZSOZ0yZRhgdQ4SWPl7/ai3273KxnhEvfitwQf68DgrA0C3tRgD+ArKqh2u+mQrOZiYKJ73
 SEo8FZdj6nZWI7lrbrGRcrZIvhey36BWGkOKXcXEGzF4rMPvC
X-Google-Smtp-Source: ABdhPJzyzUuUAFTFnZSJzbsaG/OEH73aHx+UC2ukR4nb0NITIXocB7ghkbMRyrXdJgxZruYnUJoVAQ==
X-Received: by 2002:a05:6512:3b92:: with SMTP id
 g18mr12161689lfv.646.1619432411932; 
 Mon, 26 Apr 2021 03:20:11 -0700 (PDT)
Received: from ak-snic-codilime.intra.codilime.com
 (195191163011.dynamic-2-waw-k-1-3-0.vectranet.pl. [195.191.163.11])
 by smtp.googlemail.com with ESMTPSA id p15sm1408212lft.60.2021.04.26.03.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Apr 2021 03:20:11 -0700 (PDT)
From: Arkadiusz Kudan <arkadiusz.kudan@codilime.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio-net: enable SRIOV
Date: Mon, 26 Apr 2021 12:21:35 +0200
Message-Id: <20210426102135.227802-1-arkadiusz.kudan@codilime.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: netdev@vger.kernel.org,
 Miroslaw Walukiewicz <Miroslaw.Walukiewicz@intel.com>, mst@redhat.com
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

With increasing interest for virtio, NIC have appeared that provide
SRIOV with PF appearing in the host as a virtio network device
and probably more similiar NICs will emerge.
igb_uio of DPDK or pci-pf-stub can be used to provide SRIOV,
however there are hypervisors/VMMs that require VFs, which are
to be PCI passthrued to a VM, to have its PF with network
representation in the kernel. For virtio-net based PFs,
virtio-net could do that by providing both SRIOV interface and
netdev representation.

Enable SRIOV via VIRTIO_F_SR_IOV feature bit if the device
supports it.

Signed-off-by: Arkadiusz Kudan <arkadiusz.kudan@codilime.com>
Signed-off-by: Miroslaw Walukiewicz <Miroslaw.Walukiewicz@intel.com>
---
 drivers/net/virtio_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0824e6999e49..a03aa7e99689 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3249,6 +3249,7 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
+	VIRTIO_F_SR_IOV,
 };
 
 static unsigned int features_legacy[] = {
-- 
2.31.1


-- 


-------------------------------
This document contains material that is 
confidential in CodiLime Sp. z o.o. DO NOT PRINT. DO NOT COPY. DO NOT 
DISTRIBUTE. If you are not the intended recipient of this document, be 
aware that any use, review, retransmission, distribution, reproduction or 
any action taken in reliance upon this message is strictly prohibited. If 
you received this in error, please contact the sender and help@codilime.com 
<mailto:help@codilime.com>. Return the paper copy, delete the material from 
all computers and storage media.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
