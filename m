Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BE3C4332F
	for <virtualization@archiver.kernel.org>; Fri, 11 Feb 2022 08:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FAEB415EB;
	Fri, 11 Feb 2022 08:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eLV8axDL1blA; Fri, 11 Feb 2022 08:42:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0BF88408F5;
	Fri, 11 Feb 2022 08:42:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7AAEC001A;
	Fri, 11 Feb 2022 08:42:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4FBAC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1D1260E17
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:42:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OWUDIEDG_WwJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:42:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29EC860C22
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 08:42:43 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id m7so7532784pjk.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 00:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CGAayov/+ln4jw241yuyUW4Ct9nFUZ87co88ghlbBxs=;
 b=JBTQjbSXF3YPniG9xLJNKSrGKXFx1bLPF+uqoUTCBbIf01mDmIvu56ZNTesVGlXjcZ
 o1yVHu32Fa5TOQjqIIKEE6qRYIn9uy9FgF+Hkm1uSdbubJtor7F12mVSIU9IDX57Scgy
 xmGHxw7Dm+YRWla98b2TSZJ9GDCnajM7eXlzn+Sfe1sYow7OEOTT2IyfFgm4C86AsK74
 QHN+zQBUQqcfwtTQBviyN3+UNhBPe9N610Y7CeMlICwpHzcOPGZCCNs9WePO1D5pVzU+
 BThx9BjjfzYmGvpEOnhBYE5PG+HoXwPkigro/bJAfj3E4ioSEgWZOw5gbblsopqgnSm7
 Y/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CGAayov/+ln4jw241yuyUW4Ct9nFUZ87co88ghlbBxs=;
 b=50iSNXwEwQq0pAzQyMII75V23aAhAWQudTVO0Q535qI6e0Q1y9bjT96habRH+1L4/+
 0yoq6nd8zajG+t4mYRiyD/LIor6aVYgE9nDtOGgXzLYoKavAiwcLA7kZYv6lNyMwHlqy
 ZezEkCeVVU6wWYq+SG9M8kqBA0+9aIbn+KznyQ/vzR8p2uLWsjdMAPsIiuG1CoyCGKTl
 fYwVA47p3DRwvWGLEjrB1cnV36zsiQW++qHYk9Uoz46wBmNgz5Mwy3HITxaLHHgKoqXh
 2iN5gy3MtYWqzpA3YKEYcP0PwqA879EpVcYhpD1MTczwLaxFtzwy8pWd79injlPtuJq1
 CBDQ==
X-Gm-Message-State: AOAM530MIUK4TIs9WjhY9nGRuLBaAe88e6gW0SJeq2l3lx4Qx2/xnEcr
 QoDasQNsmIscRA0yQkCK2FZXvQ==
X-Google-Smtp-Source: ABdhPJytPoIyffxZ0megHXcbWD5+PkOjOTyQ9qJOzHAP2lML9ZVoHZrvfB46L3enU00p8a1n8YykHQ==
X-Received: by 2002:a17:90b:3e8e:: with SMTP id
 rj14mr673323pjb.38.1644568962619; 
 Fri, 11 Feb 2022 00:42:42 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.72])
 by smtp.gmail.com with ESMTPSA id p21sm13368481pfo.97.2022.02.11.00.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Feb 2022 00:42:41 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v2 1/3] virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
Date: Fri, 11 Feb 2022 16:41:06 +0800
Message-Id: <20220211084108.1254218-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211084108.1254218-1-pizhenwei@bytedance.com>
References: <20220211084108.1254218-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 herbert@gondor.apana.org.au
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

Reviewed-by: Gonglei <arei.gonglei@huawei.com>
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
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
