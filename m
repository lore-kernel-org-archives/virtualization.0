Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9DBC433FE
	for <virtualization@archiver.kernel.org>; Fri, 21 Jan 2022 02:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 108C34057D;
	Fri, 21 Jan 2022 02:26:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X0hrt7hKgGG3; Fri, 21 Jan 2022 02:25:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D91504014B;
	Fri, 21 Jan 2022 02:25:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0713C0039;
	Fri, 21 Jan 2022 02:25:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 406E8C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 02:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21F8C60EA3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 02:25:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U4p6iavuTKBW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 02:25:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4502B60BCD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 02:25:54 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id c3so7085196pls.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 18:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H7JmmzsPHQSuzWfJZBXSsb0PJRIcxpIGkWIutdwXFtA=;
 b=g6wmR3YSYiAG6LPeb3AVbb1wA5Qv46BXNPRJkhm1eu9hOAd0vkfA9zIVArLOIDmuBe
 03oia1PpJzgI79TVu/ukcHl6i4FL9UTeSASpS9aBQG/yRqHDEmIfxzMJOEErPZd40TeD
 dlmFX5FyZGVhrCi5MoVkMNkwWEvgptbpJXVZygvtgL/IIN4T2HcUeURcrOh0YW4ST0s6
 wrneQ05e9SxVFiRgboyRg7XapdvXXKO8TvUDlQeF663uqSTLxgQP13jGLztbUaAiM/KT
 1LReyxJ7Xm5gfrEY5Rx3wTEFcr9C60KRx/UAL06uscltGmQFbogoOakiGPTzMr0V5QrN
 u6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H7JmmzsPHQSuzWfJZBXSsb0PJRIcxpIGkWIutdwXFtA=;
 b=DpcPmus06HWf83J+v8u8n7Sz3B3rztww5l1E+jr382xXuoXoVdtOgguKM8qOQraq+/
 wUsL3x/DieyKimPljSChAlk2chuyWqQIoU0i4M4hKS2hlPTecFFRH1f322dwMDVV7aeG
 jzrOfDjN68ODEj6cOY7/77YHKGv5yodJAZVzFqqEKWtkVZkEb5k0l0nFL93P2g/0wv+q
 dAmbYJk0cFmsM8UmgSZ2FR4L556BHtHIlhvl1JRu5ktSPdHTr0Br+cDWSmbUlwKA7YCg
 0xzylMduvx7dD7UAZJZGE4+AwIlEKi5TwsDtNUp3rOQqG0QN76lLiWXhpxMSOjaTu5Ha
 2ugA==
X-Gm-Message-State: AOAM531BDb3i5Ci4Yw0OR9h9DwMl8ke/dTJV51QWooy7tEso8DDxKYu0
 l+AZ2neaxzvy91niu0bqb0y0UsJ87F+ezA==
X-Google-Smtp-Source: ABdhPJwRy1SsjpaeBdGt8J2kb5KCSENFUecVPfqV558TVUh7PJhLtSmTBd0uAVSaqQkHmiA1DmFvWA==
X-Received: by 2002:a17:902:bd87:b0:14a:adaa:87ea with SMTP id
 q7-20020a170902bd8700b0014aadaa87eamr2038644pls.171.1642731954510; 
 Thu, 20 Jan 2022 18:25:54 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.72])
 by smtp.gmail.com with ESMTPSA id h2sm5057577pfv.31.2022.01.20.18.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jan 2022 18:25:54 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: mst@redhat.com,
	arei.gonglei@huawei.com
Subject: [PATCH 1/3] virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
Date: Fri, 21 Jan 2022 10:24:36 +0800
Message-Id: <20220121022438.1042547-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121022438.1042547-1-pizhenwei@bytedance.com>
References: <20220121022438.1042547-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
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

Base on the lastest virtio crypto spec, define VIRTIO_CRYPTO_NOSPC.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/uapi/linux/virtio_crypto.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_crypto.h b/include/uapi/linux/virtio_crypto.h
index a03932f10565..1166a49084b0 100644
--- a/include/uapi/linux/virtio_crypto.h
+++ b/include/uapi/linux/virtio_crypto.h
@@ -408,6 +408,7 @@ struct virtio_crypto_op_data_req {
 #define VIRTIO_CRYPTO_BADMSG    2
 #define VIRTIO_CRYPTO_NOTSUPP   3
 #define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
+#define VIRTIO_CRYPTO_NOSPC     5 /* no free session ID */
 
 /* The accelerator hardware is ready */
 #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
