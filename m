Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBB9C54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 12:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCD89408DB;
	Wed,  7 Sep 2022 12:51:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCD89408DB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=EagLoc7m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Jn7TuX7VX5S; Wed,  7 Sep 2022 12:51:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 091B0408C0;
	Wed,  7 Sep 2022 12:51:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 091B0408C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D61CFC0033;
	Wed,  7 Sep 2022 12:51:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68234C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4462A813D8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4462A813D8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=EagLoc7m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OicqlweWI4hA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C4DE813E4
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C4DE813E4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:45 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 m3-20020a05600c3b0300b003a5e0557150so750071wms.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 05:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=ywbHx8uPG8BROy2AsLXbenY9pZ4XxIgdV+TM84PqKY0=;
 b=EagLoc7mgqRqmMzrCNlH+G2xp1vLIBxFZpHuINYqAaumHZ5H6eRgyj9jQkR+IweVbV
 39/X7EcIhisZOWCcX99rev3RzuR0Z5HJaj3+wQAUXm535kF0A1RfVKTqAJAiTObxR+Mm
 CDQRl21UIwabggLm4/1v+zNTDMTrgNi05NoyI2fnarXAqnjrBbLJZanxQg3g47AYjuoc
 WMS175FGz90fjq++UTLU5R/HgAlRC0PzyRvwGqiKRjkVBjlLcM+bK28OYzjsRLka9yJH
 XnzKZi+FhkaF6KaKMHiNaCnBOqH4QocSuyaVjY3i+qr40tmxu4lSoms05JVpoT1yViBB
 o1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=ywbHx8uPG8BROy2AsLXbenY9pZ4XxIgdV+TM84PqKY0=;
 b=aRiALww2A3y24zBy5YZL/s2rJcnyhQcOCSYW/Fko3AHoVMcDCahQgMCbGBmiF0h+PT
 PdYjh+iZ+QuRu3gyBi+VIidorKT1aKsEsQ0NYUXVVqBHyby5oYBZt4rVpMI2oI4pxz0b
 ynwQ4QlrI39eNEsddMa4S60uihm3Mo9LnWscUJ2wF1LYdogYLZbpyoYl2zuK2q5Cvmvb
 QRfjLQz43UDFTikmwaiQLDP6AZKbAgMLsUcNEe6b3+z8vZ/M+ogylU79RYKtYO6NHUsF
 ch/pWdrukJPWB2icfO8nkr2ayJZsK4yRrbcAjdsEGno/mnp8Py2OVI5A5YJersvv1ams
 D1Nw==
X-Gm-Message-State: ACgBeo3QVji4Y+52Z5nIhUD8hQcV5iFy7ZAlWgslfiFQ/HGipfHb5GbY
 e7tatOk6JbHCB6QC3ozd7KdoAA==
X-Google-Smtp-Source: AA6agR5TISsCqM1wwAjvQMCYn+H4fwJF0mxPK90BuOZ14oHjdYbfn6F/Q47rCCiVb3TXt5olnSbtVg==
X-Received: by 2002:a7b:c848:0:b0:3a5:41f6:4d37 with SMTP id
 c8-20020a7bc848000000b003a541f64d37mr1987590wml.23.1662555103607; 
 Wed, 07 Sep 2022 05:51:43 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 e27-20020adf9bdb000000b0021f0ff1bc6csm11480001wrc.41.2022.09.07.05.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 05:51:43 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: edumazet@google.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, jasowang@redhat.com, mst@redhat.com,
 pabeni@redhat.com, yoshfuji@linux-ipv6.org, dsahern@kernel.org
Subject: [PATCH v3 6/6] drivers/net/virtio_net.c: Added USO support.
Date: Wed,  7 Sep 2022 15:50:48 +0300
Message-Id: <20220907125048.396126-7-andrew@daynix.com>
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

Now, it possible to enable GSO_UDP_L4("tx-udp-segmentation") for VirtioNet.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/virtio_net.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9cce7dec7366..0f70110957eb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -60,13 +60,17 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO6,
 	VIRTIO_NET_F_GUEST_ECN,
 	VIRTIO_NET_F_GUEST_UFO,
-	VIRTIO_NET_F_GUEST_CSUM
+	VIRTIO_NET_F_GUEST_CSUM,
+	VIRTIO_NET_F_GUEST_USO4,
+	VIRTIO_NET_F_GUEST_USO6
 };
 
 #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
 				(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
 				(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
-				(1ULL << VIRTIO_NET_F_GUEST_UFO))
+				(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
+				(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
+				(1ULL << VIRTIO_NET_F_GUEST_USO6))
 
 struct virtnet_stat_desc {
 	char desc[ETH_GSTRING_LEN];
@@ -3082,7 +3086,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
-		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6))) {
 		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
 		return -EOPNOTSUPP;
 	}
@@ -3734,6 +3740,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 			dev->hw_features |= NETIF_F_TSO6;
 		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ECN))
 			dev->hw_features |= NETIF_F_TSO_ECN;
+		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
+			dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
 		dev->features |= NETIF_F_GSO_ROBUST;
 
@@ -3780,7 +3788,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
-	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
+	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO) ||
+	    (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO4) &&
+	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_USO6)))
 		vi->big_packets = true;
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
@@ -4021,6 +4031,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6, \
 	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
 	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_UFO, \
+	VIRTIO_NET_F_HOST_USO, VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
 	VIRTIO_NET_F_MRG_RXBUF, VIRTIO_NET_F_STATUS, VIRTIO_NET_F_CTRL_VQ, \
 	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
-- 
2.37.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
