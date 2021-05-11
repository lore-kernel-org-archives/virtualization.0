Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82832C43470
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 04:43:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221FD61935
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 04:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221FD61935
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C06D60D53;
	Tue, 11 May 2021 04:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rnh-oe5e3_oC; Tue, 11 May 2021 04:43:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4287860D55;
	Tue, 11 May 2021 04:43:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D29BC000D;
	Tue, 11 May 2021 04:43:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5306C0024
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0B5640E4B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CCSZaW2xFk6e
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90FF340508
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:24 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id o127so10309863wmo.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 21:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C9XpXxYtaOMpWOUjJ4wuUSOsoeZftgUi9oWw6L6+6PY=;
 b=i8N263f+uXxe91WLuxJx5RvGTcU+LOlIZILGfgaQzBDs6R/OaZ26o9Jduve+32BvM0
 SBW5jvdKVYeAZmZN2gJYZTbusqcxDTTC15Lpii1SMDeN7urjfzM0n4B6AIEXRELudkAm
 ONRljjTtiItJ/VZma2gKCNrnXZ4b4XK0kHPXfxOYFa5/HwbafB07Xt0fVqX7vfPtpn9d
 fMPog8BUQcwL0WZCqE/LfaVSMRv8ythODRvoqifUAjufxR7YfIiFvybGHoR/pVpoGsAj
 zjKpR1k5AeoLdOJ3xV/+lVo6WQMDN+ca4vpe7dLYnfXjH5BFwWj+7ZyGtcbGLngURzZD
 Vi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C9XpXxYtaOMpWOUjJ4wuUSOsoeZftgUi9oWw6L6+6PY=;
 b=VuBAIANwk3uRvW3mRDf8s0YvWYXP19jA8DtEWrD8QptSAddj7KwPSYZRI6FbxJ5j3O
 K5aXJVOo7ARiG9VmD1P5cVSH3AZqsu683rBGTb3Ja+zrXDCPnh8DFkLnifDBUUwb0lMV
 l+fU3j41usR9Fan4psowLPbmacTM87BLl71lvGlgSh2RemzhcsOWKcB5BmdgGCOn1SaA
 cnhjLlZIcFnPJ3RRxiW+KiVhJ4wBXnuWd440UQdHE3K+lTMhMtXDq7qS3FfiIwXWXgff
 nDxZZm28jvrGOQfRNhedC200KZLaxaPcPDRi9tHEzhzQePvE7t425VTPm5YFT7rZKXIi
 G+6w==
X-Gm-Message-State: AOAM531WdL2IrB6LTKpacu/HObnQVymqMiVhcL+MB1yR9dBq71TFRNHC
 UpgkclzOQtkozBuyUhtw2h3rMQ==
X-Google-Smtp-Source: ABdhPJyQk9PXGY/kEfZFu3FcsyaZ0+l7hvZVvgX/jf5mBiF4QiF5aERcUZgxITkN4JxfM3z5J6nLRg==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr3023530wmh.102.1620708202793; 
 Mon, 10 May 2021 21:43:22 -0700 (PDT)
Received: from f1.Home (bzq-79-180-42-161.red.bezeqint.net. [79.180.42.161])
 by smtp.gmail.com with ESMTPSA id a9sm22360520wmj.1.2021.05.10.21.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 21:43:22 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 2/4] virtio-net: add support of UDP segmentation (USO) on the
 host
Date: Tue, 11 May 2021 07:42:51 +0300
Message-Id: <20210511044253.469034-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210511044253.469034-1-yuri.benditovich@daynix.com>
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Cc: yan@daynix.com
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

Large UDP packet provided by the guest with GSO type set to
VIRTIO_NET_HDR_GSO_UDP_L4 will be divided to several UDP
packets according to the gso_size field.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/linux/virtio_net.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index b465f8f3e554..4ecf9a1ca912 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -51,6 +51,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 			ip_proto = IPPROTO_UDP;
 			thlen = sizeof(struct udphdr);
 			break;
+		case VIRTIO_NET_HDR_GSO_UDP_L4:
+			gso_type = SKB_GSO_UDP_L4;
+			ip_proto = IPPROTO_UDP;
+			thlen = sizeof(struct udphdr);
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.26.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
