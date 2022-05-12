Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A71C433FE
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 11:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC26241706;
	Thu, 12 May 2022 11:33:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pt2e-R59O6uC; Thu, 12 May 2022 11:33:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 142E6416A3;
	Thu, 12 May 2022 11:33:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E039FC0039;
	Thu, 12 May 2022 11:33:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0CD7C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C13126109E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aXEsHACqWt5X
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1F9661094
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:21 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id q130so6096723ljb.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=poaAl/LWMtSjpF9E3ArKo5BaGizAmiyDHMdbPQU58wM=;
 b=L0BFpVLJQqlT0zt4b7FVLFd+SSf6LkTvIZONJ+ldc+OUcKRc4j/x60BAYklyj/+lMc
 CKZM+K1fF2jHLZUKhOEAHrdOVXtJy/71Z6j5BZLP19lHovNzo8VyrLuDe+oRiUerrKJT
 kGkAPi9eO0/bb7UnFYrT4as3ZAfrwqKBIjzfbbLHHUWLww4uTiQ8AUqNkgzgFZZuzDZH
 AVQ13nVULJHMSZYiLGoA6KclaPqR39FmHZvxbid1YuOLOF3AsJ1CIyySOmSNGAI5lm99
 x2Bnz9i/LNHo1qMPg0HGpNqIkDdwOYwXpBHu8XCP/lagjhocE8jHM40QiYnRR842wQo3
 9oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=poaAl/LWMtSjpF9E3ArKo5BaGizAmiyDHMdbPQU58wM=;
 b=Q5dkcfwGuexDTHt2wA8cbtxFVnFw58OBjMKerUqi92+8+xe5DFiMiJowt1YuzI0qzd
 GEu3KjYgyHzQvckdnNMEUIv8nsegHi3uDWt5TYUu7NrwXdctjZ9gYtXeAk5Zv/9BLXuR
 Sh5KXFCRn4gsDDaU8bRYH6dwJ2d+nzlYGq8TJ6/3creYsgvYI+lDSGHQ+B0PbnhDpDsb
 Fv6geQRKDjVpu92JJ2jbG6LmwRbOUk4Pvmbj4razeLsNXIY5u68UYXckA37AJxKHhQY6
 QYs+SVDWYnk1zXQMFwXwni3eGMD3X3PLDCdlZ5AsFKBaTE0dBcn0uXotViGbzcxXjgYO
 4cUA==
X-Gm-Message-State: AOAM532zVBtMcLxiYWsAf7w4b5zHV5NPmJPvok9Zur2bvo1izD9Chx1n
 UQcRpkqja/Z3kQVO5TSmwo2i6g==
X-Google-Smtp-Source: ABdhPJzq5JITT2BfM4tF1muCzbgjceuolUocorvsJ4Bs//pjuR3Cjamjp8cpK5UYGylTqv1LOmTXzw==
X-Received: by 2002:a2e:b712:0:b0:24f:150e:1a71 with SMTP id
 j18-20020a2eb712000000b0024f150e1a71mr20147165ljo.240.1652355199481; 
 Thu, 12 May 2022 04:33:19 -0700 (PDT)
Received: from localhost.localdomain (host-188-190-49-235.la.net.ua.
 [188.190.49.235]) by smtp.gmail.com with ESMTPSA id
 r29-20020ac25a5d000000b0047255d211a6sm741758lfn.213.2022.05.12.04.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 04:33:19 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH v2 1/5] uapi/linux/if_tun.h: Added new offload types for
 USO4/6.
Date: Thu, 12 May 2022 14:23:43 +0300
Message-Id: <20220512112347.18717-2-andrew@daynix.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512112347.18717-1-andrew@daynix.com>
References: <20220512112347.18717-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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

Added 2 additional offlloads for USO(IPv4 & IPv6).
Separate offloads are required for Windows VM guests,
g.e. Windows may set USO rx only for IPv4.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/uapi/linux/if_tun.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 454ae31b93c7..e147dcb46d5c 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -88,6 +88,8 @@
 #define TUN_F_TSO6	0x04	/* I can handle TSO for IPv6 packets */
 #define TUN_F_TSO_ECN	0x08	/* I can handle TSO with ECN bits. */
 #define TUN_F_UFO	0x10	/* I can handle UFO packets */
+#define TUN_F_USO4	0x20	/* I can handle USO for IPv4 packets */
+#define TUN_F_USO6	0x40	/* I can handle USO for IPv6 packets */
 
 /* Protocol info prepended to the packets (when IFF_NO_PI is not set) */
 #define TUN_PKT_STRIP	0x0001
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
