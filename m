Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5D1C433F5
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 08:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E59740494;
	Tue, 25 Jan 2022 08:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8v1vGCsEJq1a; Tue, 25 Jan 2022 08:47:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EA590400FB;
	Tue, 25 Jan 2022 08:47:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDE73C0031;
	Tue, 25 Jan 2022 08:47:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6759C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC7E660B22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vhPkbqfwSAgL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 917E9607F7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:23 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id c15so9928914ljf.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 00:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k43NlouVQB8hM1beYosBs1yb2iePFVYZFONuMP14vSM=;
 b=zp0RDdvCCfDNZfHZsadkx2auxVmRnOOpvABVv9a1MtModBQsy/um51GjHOd7t53C2N
 tA/G2rMzpf9wWg761k/ef2SUVbbzAlVs+mozPmJjymGAUK5aAiwRQfO9lqwGVxuK5otI
 Pl1RMPJRJoo69MW/tkfnBcf3JEn0aqVRkjuYH7BCr0Pg+c0rglS3vio4S6gl7bQ3UGaX
 1nscK/FwgBv2TA0EsI+2kfdGD0JEbkH1eUyfkEWgAx/EtxIiGFnJMBxIBmnpy6KBN84l
 tTtoY8j5IXK9nVZT2/cuCoUN70rFwtLCwgB0kS14UaLp/KVsdxFJ+fsZKbwvjAtdn1Ll
 DoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k43NlouVQB8hM1beYosBs1yb2iePFVYZFONuMP14vSM=;
 b=4xCPkwsb74I6NOtHeUcsGDGO8rW2jiJ4pr6Vd8oOP5MruBtQihrNYPWY7hqRLZ0+oB
 np6ZoRNJmjsApze2IGOEi0L4TUigceMUtaP2ztWflcDWm5UFOkHAu1u40Hl+Zqe0T0ZK
 D7rVXymPS1+ZY8FJH1JBeP3XIwnP4OW7YbVmPPMVABKfsbhd7lubHF7a6q/iaD4HCAnM
 ndd1qVI15yW4rE/dCDo38PFPDCd0TFSMr+aI5SjIIwxmXZHTwR0yUiS2EMNv07wY2iGC
 gJ+vLJTvA9vfgdIVMxdiz2cDLL6gPz6YQ9Vm/70dASKHZtAjDaNlWUOawQwTbz2c9Dyy
 XoCg==
X-Gm-Message-State: AOAM533Kb5feClogAoiobGW3oCk1VTia+AfJX8VwS5zU6MrxgyRa+nOz
 othg5C7wIcwq5kXzon0YhJLTLw==
X-Google-Smtp-Source: ABdhPJyYp87wYisP2/l1MxOBncqSB6zBTz6Bvqiipiw7V7kXabqJmsZ2TUeV3tPNrW20SUDhl6kxAg==
X-Received: by 2002:a2e:b914:: with SMTP id b20mr13735990ljb.6.1643100441653; 
 Tue, 25 Jan 2022 00:47:21 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id q5sm1418944lfe.279.2022.01.25.00.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 00:47:21 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 1/5] uapi/linux/if_tun.h: Added new ioctl for tun/tap.
Date: Tue, 25 Jan 2022 10:46:58 +0200
Message-Id: <20220125084702.3636253-2-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125084702.3636253-1-andrew@daynix.com>
References: <20220125084702.3636253-1-andrew@daynix.com>
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

Added TUNGETSUPPORTEDOFFLOADS that should allow
to get bits of supported offloads.
Added 2 additional offlloads for USO(IPv4 & IPv6).
Separate offloads are required for Windows VM guests,
g.e. Windows may set USO rx only for IPv4.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/uapi/linux/if_tun.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 454ae31b93c7..07680fae6e18 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -61,6 +61,7 @@
 #define TUNSETFILTEREBPF _IOR('T', 225, int)
 #define TUNSETCARRIER _IOW('T', 226, int)
 #define TUNGETDEVNETNS _IO('T', 227)
+#define TUNGETSUPPORTEDOFFLOADS _IOR('T', 228, unsigned int)
 
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
@@ -88,6 +89,8 @@
 #define TUN_F_TSO6	0x04	/* I can handle TSO for IPv6 packets */
 #define TUN_F_TSO_ECN	0x08	/* I can handle TSO with ECN bits. */
 #define TUN_F_UFO	0x10	/* I can handle UFO packets */
+#define TUN_F_USO4	0x20	/* I can handle USO for IPv4 packets */
+#define TUN_F_USO6	0x40	/* I can handle USO for IPv6 packets */
 
 /* Protocol info prepended to the packets (when IFF_NO_PI is not set) */
 #define TUN_PKT_STRIP	0x0001
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
