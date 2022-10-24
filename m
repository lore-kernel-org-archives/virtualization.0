Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91020C38A2D
	for <virtualization@archiver.kernel.org>; Mon, 24 Oct 2022 13:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 108EB60598;
	Mon, 24 Oct 2022 13:41:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 108EB60598
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=05Tmzxa6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L7t-jPQMauwD; Mon, 24 Oct 2022 13:41:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E107C6006A;
	Mon, 24 Oct 2022 13:41:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E107C6006A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB554C0032;
	Mon, 24 Oct 2022 13:41:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0C74C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 13:41:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA37581392
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 13:41:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA37581392
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=05Tmzxa6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CAWoO1SE0F7v
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 13:41:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 853558138C
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu
 [18.185.115.3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 853558138C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 13:41:06 +0000 (UTC)
Received: from 104.47.18.112_.trendmicro.com (unknown [172.21.205.29])
 by repost01.tmes.trendmicro.eu (Postfix) with SMTP id DEAFD10001789;
 Mon, 24 Oct 2022 13:41:03 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1666618863.214000
X-TM-MAIL-UUID: b0f190fd-d9eb-42e2-b2cc-fdc8da235882
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.112])
 by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id
 346EE10000E35; Mon, 24 Oct 2022 13:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmAjHzIOjCk7vkFLcdP+StSRCeKMCP4gQ9a0DHpHwRXfV2NESGqPWT+dvTH3eneznNPzvfzVDAyLT2RM/pVVnQmluoG3dA7oRK0WkHSTxtYOYuR/OJhzQbyrOPJEHaDCGiBbK3siGLvdnDVLxmI4JLETm6tZaWZm0LQXD7HFcGZk7r6K/+XzIMNRTGJecVW15Q9Ydm0jr3zSWx4hOkV22lElDYp8pKDFcJTw2iKDSkTA2DuOG2iQ+aftnDa/5ryBCPbaCFlQYVKRspGpmJQkCBmQk8wVFiSGUIVRprUotBdzy0CWZk9OtTJPeIIfDylraDMc/M98D/wiirXzwJYAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYKgG0LMSWdFCkFBvpgRCf6xvkpxbpR1Y/IhJK8NIQk=;
 b=KUDmAjpsAKrf/05H0kiQHxB/yMjL3LKhmMghZ/7dTPaffFkCSe5h/BKx1kE+Q9h9eDH5hZFR4UZuHUR8Q+pvsMSv2lkl/UdOeo4Ja9gz8dxpRxp78OlWeBnQNZWfvFlfRnY23FsL8Y0T+xOAhRFyP1tsvjTbEid0NA13HgCoPNMxwL4VVpdSH5oqO35r/Jho+h6j8jotMBcUxGxNapXqSAMX2ZSC9PtaBYNH/suhvdAYlgaJTchgaVolu1dxyPHD6xZCQZCZV/QlhFMHmnJLw1E+q7J0y3Jm0rferFXFUmG4XVT9FTsvP2XnSSt4pdXvYl30o3A5MOYkP0hzveif+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=gmail.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=opensynergy.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Igor Skalkin <Igor.Skalkin@opensynergy.com>
To: virtualization@lists.linux-foundation.org, luiz.dentz@gmail.com,
 mst@redhat.com
Subject: [PATCH v4 1/1] virtio_bt: Fix alignment in configuration struct
Date: Mon, 24 Oct 2022 15:40:33 +0200
Message-Id: <20221024134033.30142-2-Igor.Skalkin@opensynergy.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
References: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
 <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT022:EE_|DB9PR04MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: c75e319a-f447-456e-2f51-08dab5c56392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wA0se/z6o7k6ZL3OJlKvuK0BDNeTJT9ccRZ/Qu9TyzboRfef8em0w+Wz4tKdORuVKS1sWurI+zsjN8UTMAVQTciCR3c4DaLKxG8ZRPjbDKTiyiDH/Q38WOT5nMkkemNBMGKd6OR7a6MYE+B/c1h3fAeWXTkg2WVCjZXbreuNIBf2QpJQkg+nu8vrdjA/f7rmsaLvi+bGxCqW5wOs/2992caERdvm1GavuC0hArs5HFG7c+kbOoimouBFrSXiy0atdFKQkUOmI5sxqIfcnkO2xfsFTK9ue5qZ5BHa5e37x3y2btu8+PQ0I2xfhDfWK04joXx4tG0hv0m3sdJ5frEZuoS8ihnywbP7L4lV5QomLqBWmKKOSLdjsaD8r43sVxT6LD5cRxuCD1yEjUoyH8Juxrz8dUc10FAiwV12FIf26vMzX81GCNORLo16L2YKhLm+4Gx2oHKDaustT/7UrItF3rwISsYWJvGxbjevvT7GOYNx1D4FdNZnIL1w83ppzuujwcALMavnois9kFYxZ8xppEu2yKzQQ4WslzRDdfLccNFKGD90HmAhXH/LZ+OuInPc/kkx9QdU48vQneyf6tXb0iLXBBUBTwXqOgzE+4dHnfAGcnTWFsZyq6xZaY9/ppZti7DU9PG61F/1/CO07dLV+YncRUaHsaM3iOaKS/ogVa4jyzh9xVhkQ+1wDsrXlM6naK2sU0MS0TlqqeBNK5lhiHGJA1/nuHHj3zL6bWV0rfEBtm2H6KP0tN7PXWvNHpE3KqpfyCr6JUKyjtjdNmrAKi4aB71DlQwiPQOeBC9b5HQ=
X-Forefront-Antispam-Report: CIP:217.66.60.4; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SR-MAIL-03.open-synergy.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230022)(376002)(396003)(39840400004)(346002)(136003)(451199015)(46966006)(36840700001)(5660300002)(36756003)(2906002)(478600001)(316002)(42186006)(4326008)(70586007)(70206006)(8676002)(41300700001)(8936002)(966005)(83380400001)(81166007)(40480700001)(36860700001)(107886003)(86362001)(47076005)(1076003)(26005)(336012)(186003)(2616005)(82310400005)(36900700001);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 13:41:00.9118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75e319a-f447-456e-2f51-08dab5c56392
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64; Ip=[217.66.60.4];
 Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT022.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9402
X-TM-AS-ERS: 104.47.18.112-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27220.007
X-TMASE-Result: 10--2.074400-4.000000
X-TMASE-MatchedRID: HLZKLD98mswxZoNWTqFxuUXBhxFdFgcQBXngI6jFvpeueqlDxh8ToXMW
 fmr8UEU8gRXUy3f9jsQW+rN4H33dkdyU5e20qrzVuce7gFxhKa3BOVz0Jwcxl6vCrG0TnfVUilv
 Ab18i4hOxIT6WtCo5I1cnoO4Nx+loO4kcA8kjsz9kiLB9qoJwH0pO/ORUaZ3FmyiLZetSf8m2Ie
 O/ulJw0egL5WVEeE7IO+2BPnSgMUYgBwKKRHe+r/ruL7dkRPghkqsE8rtkLcxTSZ4Q3ZLFG9HYN
 coLyNp5fTcDEEc/mG4=
X-TMASE-XGENCLOUD: f6ff373a-9dcd-4842-ba0d-9f3476168479-0-0-200-0
X-TM-Deliver-Signature: 79B49BEBBC56D98A64CE6F581C975E27
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
 s=TM-DKIM-20210503141657; t=1666618863;
 bh=KtfCxF3VhIYx3CXyDTo5AKzO6JYre2ypx27bbgcYq2k=; l=2894;
 h=From:To:Date;
 b=05Tmzxa60CNLJ3rU94Y7O0bxToQZJTwCTyplR+bJt75UYGHfp/y18c/wRNTOMJ34m
 MMu0uGUzeAbxw1VpvYUqfmPhsLsCAuN78r99FEYARTUij4UDO1d7X0PczxLSaubD9v
 o6A8au7V3pfdB4RVn9IigKwEPyIJ58Rz2Eyq+sqtu3HyqlW4w97oYSYP/1h5SFRMgV
 Qy065aJ31GFl66l63YHtgfkirGgCa1ODcYWODzFPNOfuqfBYdJiDq8Dq8VxmLykek1
 mfiI2FVNshSUaaiJtyI5K5waqNAyzBGy3Kmgywi6QaZuN8ZzjoqCo8WZdIjyt8aYnN
 uYR4XxxhrJZXA==
Cc: johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, marcel@holtmann.org
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

The current version of the configuration structure has unaligned
16-bit fields, but according to the specification [1], access to
the configuration space must be aligned.

Add a second, aligned  version of the configuration structure
and a new feature bit indicating that this version is being used.

[1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf

Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
---
 drivers/bluetooth/virtio_bt.c  | 16 +++++++++++++---
 include/uapi/linux/virtio_bt.h |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 67c21263f9e0..35f8041722c8 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -306,7 +306,12 @@ static int virtbt_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BT_F_VND_HCI)) {
 		__u16 vendor;
 
-		virtio_cread(vdev, struct virtio_bt_config, vendor, &vendor);
+		if (virtio_has_feature(vdev, VIRTIO_BT_F_CONFIG_V2))
+			virtio_cread(vdev, struct virtio_bt_config_v2,
+				     vendor, &vendor);
+		else
+			virtio_cread(vdev, struct virtio_bt_config,
+				     vendor, &vendor);
 
 		switch (vendor) {
 		case VIRTIO_BT_CONFIG_VENDOR_ZEPHYR:
@@ -339,8 +344,12 @@ static int virtbt_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BT_F_MSFT_EXT)) {
 		__u16 msft_opcode;
 
-		virtio_cread(vdev, struct virtio_bt_config,
-			     msft_opcode, &msft_opcode);
+		if (virtio_has_feature(vdev, VIRTIO_BT_F_CONFIG_V2))
+			virtio_cread(vdev, struct virtio_bt_config_v2,
+				     msft_opcode, &msft_opcode);
+		else
+			virtio_cread(vdev, struct virtio_bt_config,
+				     msft_opcode, &msft_opcode);
 
 		hci_set_msft_opcode(hdev, msft_opcode);
 	}
@@ -387,6 +396,7 @@ static const unsigned int virtbt_features[] = {
 	VIRTIO_BT_F_VND_HCI,
 	VIRTIO_BT_F_MSFT_EXT,
 	VIRTIO_BT_F_AOSP_EXT,
+	VIRTIO_BT_F_CONFIG_V2,
 };
 
 static struct virtio_driver virtbt_driver = {
diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
index a7bd48daa9a9..af798f4c9680 100644
--- a/include/uapi/linux/virtio_bt.h
+++ b/include/uapi/linux/virtio_bt.h
@@ -9,6 +9,7 @@
 #define VIRTIO_BT_F_VND_HCI	0	/* Indicates vendor command support */
 #define VIRTIO_BT_F_MSFT_EXT	1	/* Indicates MSFT vendor support */
 #define VIRTIO_BT_F_AOSP_EXT	2	/* Indicates AOSP vendor support */
+#define VIRTIO_BT_F_CONFIG_V2	3	/* Use second version configuration */
 
 enum virtio_bt_config_type {
 	VIRTIO_BT_CONFIG_TYPE_PRIMARY	= 0,
@@ -28,4 +29,11 @@ struct virtio_bt_config {
 	__u16 msft_opcode;
 } __attribute__((packed));
 
+struct virtio_bt_config_v2 {
+	__u8  type;
+	__u8  alignment;
+	__u16 vendor;
+	__u16 msft_opcode;
+};
+
 #endif /* _UAPI_LINUX_VIRTIO_BT_H */
-- 
2.37.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
