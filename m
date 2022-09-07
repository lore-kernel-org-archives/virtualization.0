Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347E4C38145
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 12:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C384940521;
	Wed,  7 Sep 2022 12:51:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C384940521
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=tc0mdEtn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ri-_FWnoA2zP; Wed,  7 Sep 2022 12:51:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6A53E404FF;
	Wed,  7 Sep 2022 12:51:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A53E404FF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48749C0033;
	Wed,  7 Sep 2022 12:51:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DCC1C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4BB360AFD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A4BB360AFD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=tc0mdEtn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kNDlVjiZHaco
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4CF460AFC
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4CF460AFC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:36 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id bq9so7330970wrb.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=d8usAzUq61FHCkycIEkOgq4s+Z72vQd7Ep2+wzeLNx0=;
 b=tc0mdEtni7/nOq0fIaWQgH+uEG30vyB66b9/WsPVyH+gpue1NXrm7kTQX6pgN44qpZ
 xWjgVI7c8uWhnA8ZQF+pgyRHzV7La780nYJuaDQMjcD901EyChb/dkNRdd/j5D/Yj2IO
 3PZV4/iBDOXKb7/dWHm75vyV1yfH4WYWLKJ6mi1LUMobFHRNNOup1DdYZhwzAgpXWATi
 FDDFX4A0//QRgbyT0kSt91Rx+u7zIEg/B7j0gvI3Secnir2M4KWuebK2vCq0Pp16+9DB
 s3OallXrqWazBet592eeqOHspb5iokojsQO1b99z03rbYc6kghqFqQ733GH+HcGfr3ul
 MEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=d8usAzUq61FHCkycIEkOgq4s+Z72vQd7Ep2+wzeLNx0=;
 b=tnBB/1oMDPnu6y3pp5uDayg8BwmICUSMwfXkQ+rdMosUivzzi0gcfzcASZjwTWO7ub
 aZtiNQe5YWZAKY7wD05+8DmapBi522gQigfl5t0rB2bbdah3KVPHQEpRDcR05L/z341I
 dg/JVf5xpPWZFyG480MkAxnznSj4lZVmGy8Clydsxvehmc9x64xXFZ2J8knIoV7yxPWt
 o/CrhDQyTusgotu6Dtvcjzp83yZqSg6tUD4aoOY875yg17UwNnCjiCQt/cyryv8L5Ln7
 ISXARP+z7nI8IqqCNdmdP0bKv+TttKEccwOHBuktWdEp2/Xu0eloqBah5qO1GcReTvbe
 4unQ==
X-Gm-Message-State: ACgBeo2geRhzCEQDll9L79N2irqB9xO1/IsATnF4473eKflK5B0yfUw6
 7vjQaa9uRomR1CqYPRMLjjXuJUgmp2mAOz2f
X-Google-Smtp-Source: AA6agR59wHMg1sPtOCvnjt0/QqpolL8iqEduFZMHwOY1R/xf2tHBzq16FwMtqjvJ7fJ6vbfLc3TvYQ==
X-Received: by 2002:adf:f6cf:0:b0:228:9b2f:c305 with SMTP id
 y15-20020adff6cf000000b002289b2fc305mr1971325wrp.427.1662555096441; 
 Wed, 07 Sep 2022 05:51:36 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 e27-20020adf9bdb000000b0021f0ff1bc6csm11480001wrc.41.2022.09.07.05.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 05:51:36 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: edumazet@google.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, jasowang@redhat.com, mst@redhat.com,
 pabeni@redhat.com, yoshfuji@linux-ipv6.org, dsahern@kernel.org
Subject: [PATCH v3 4/6] uapi/linux/virtio_net.h: Added USO types.
Date: Wed,  7 Sep 2022 15:50:46 +0300
Message-Id: <20220907125048.396126-5-andrew@daynix.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907125048.396126-1-andrew@daynix.com>
References: <20220907125048.396126-1-andrew@daynix.com>
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

Added new GSO type for USO: VIRTIO_NET_HDR_GSO_UDP_L4.
Feature VIRTIO_NET_F_HOST_USO allows to enable NETIF_F_GSO_UDP_L4.
Separated VIRTIO_NET_F_GUEST_USO4 & VIRTIO_NET_F_GUEST_USO6 features
required for Windows guests.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/uapi/linux/virtio_net.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 29ced55514d4..5156a420564f 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,10 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Guest can handle notifications coalescing */
+#define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
+#define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
+#define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
+
 #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
@@ -130,6 +134,7 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
 #define VIRTIO_NET_HDR_GSO_UDP		3	/* GSO frame, IPv4 UDP (UFO) */
 #define VIRTIO_NET_HDR_GSO_TCPV6	4	/* GSO frame, IPv6 TCP */
+#define VIRTIO_NET_HDR_GSO_UDP_L4	5	/* GSO frame, IPv4& IPv6 UDP (USO) */
 #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
 	__u8 gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
-- 
2.37.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
