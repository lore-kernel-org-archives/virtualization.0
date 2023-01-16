Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CE8C54EBE
	for <virtualization@archiver.kernel.org>; Mon, 16 Jan 2023 20:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 82C7A405E2;
	Mon, 16 Jan 2023 20:27:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82C7A405E2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QmckkQWQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BD02pfRSQ01A; Mon, 16 Jan 2023 20:27:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B63D4405AC;
	Mon, 16 Jan 2023 20:27:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B63D4405AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CBB3C0032;
	Mon, 16 Jan 2023 20:27:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A66F2C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 20:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DF03405AC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 20:27:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8DF03405AC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ozDG67ntpaFc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 20:27:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 140C4403BE
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 140C4403BE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 20:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkL/fE5xYJxUDk0hoGwswnRLryamahzzIrD8VX+MRiEm8RKUTlKKc+tzNUhLt04WBx7WEpWqyl3rIrvl0cBrJW9GIEc8QLZJ2aKoTQlvdZ5c4bsitJq7gNp82ByPN9SUCTbT+eT4JoyVIuMHj+f95C1XU+kO4rJLGCcuwaNvT/aPDVoO4kMSlyWOC+/7bdTOHjGn9NyLKF9GAaYkc9HF4hFnY1Cy86gX3VXXjmV5gp3zM10iGv2SK/7EcYbwB8qzJZeMg13kn93RzLZ69CeiA3U7KhtxrgO3UeHOkh/ZWVotWHbI5fj+UmhiEQyAjpV2sTW7y7ueCPWntYk0gQw38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VozAJkDLR+vLFobPJ81fpP8lkagAW+SLNTD1UlZd78I=;
 b=KuT5FoNLISP1zuwvkJtrNTt1ix0h9VCRnRYT0yMvi3z9o4REND2ausUcdBz/ZibrYNcAKs5GdKABN55LYGOEwiNNN98aS8r4+fgaQV13c7BDV/CRDSZ8lYAaC9F4NvR69dO7587NZ+DIeZ+zyr0mvVVmuJmWxU3Btu2ycPZqQptMu/ZagwcQdXdQ8ZZBX0VwYDN1FiFKuKFVpMn1luQCO9D2wEONpDeG3iC9ZwPSj/kUtKUmwJTMIv9unAUy5X5G9udpSSQ09pBwTdSyIaSQpLtKVDJhereGIfKbepEj+0RXG5J6JoCf3WFxvMLZBbkE5k+KJ1AnJ/ulRUOVzWBp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VozAJkDLR+vLFobPJ81fpP8lkagAW+SLNTD1UlZd78I=;
 b=QmckkQWQdBeXCTUxt57DsZYR08GrYMpd9+PhRDuqDW+kAu6etB02K7Lg9ZJiGQOwRZ/ffc8pzRBKnPGQ2pCkO8Ls3ns8t6zLMNBKBjZxvAiLpA0E5ilPvPA+qerdh2miq7a+ij8IIC8bKvSdHnW3wkAd1Iykv7B5SJS2MYBPZ1EsmgnA2ePun70+pdQhc5QxYzkQkslKXinjtp6qA9RjrbR0cL09E8qjZ4w2bolF3FhSehPruc9D8ShbNoh0131WhEacNbv0dRMeI3ELxDGiAroZfjTjd3RB8iyXS1+WgZnuGf+bopYXILvAo/syT4341ONHJyPTfHzEKX6Nxt9OXw==
Received: from DM6PR02CA0103.namprd02.prod.outlook.com (2603:10b6:5:1f4::44)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 20:27:25 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::3e) by DM6PR02CA0103.outlook.office365.com
 (2603:10b6:5:1f4::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 20:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 20:27:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 16 Jan
 2023 12:27:20 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 16 Jan 2023 12:27:19 -0800
To: <mst@redhat.com>, <jasowang@redhat.com>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <kuba@kernel.org>
Subject: [PATCH net-next v2] virtio_net: Reuse buffer free function
Date: Mon, 16 Jan 2023 22:27:08 +0200
Message-ID: <20230116202708.276604-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|MN2PR12MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e37f46-7fb8-4ec3-25ac-08daf800149b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMmsCcX2envvjFDO/SyUuw3whx6y7FjkeR1jjXOExLJcIIh4VindqjzlfgKfaQBLIJsz9jg8bxmctH74TUEqpbt1zLydsg7uH7PeWG8TZSZWXZD9gtSBJeSCiZCQKKJqcM/sutu4SBDzd90JvLAhav18o9Fi542iRv/MIN8I3qY4iPi0PIgdGM1bVjPkqx1IkEuKKKQxQZuGqqPR4EB1h68koqb9zAAc8Qi+BvvPYsNeFMUnIGj6aRX27ALDEePwACj0rFxFJ1D2YEo/0M2RROURt+ShWaSBS+g4VrX7W+WUUYbGvMClPBRRjEBu+AQm8vLx00te7Z/67m91a76K4SMA5IQft9g989w0QPbybayNQIMfBeLudqk/UWXYBYUd+UIyIO4mrdufD3ea9+Bhw8CdJF76ECVH2ON/3s3uV8BlAB0LIETnWZJq2hQ/fDthTnyEd+r0iEC79QBhX+SPJNWMLEVArL3ajDTicflU1tyjdzDnIVND7yqpnz7DKGzxInZisQnhTnctddlKXwwFkXsmzdQ128pX1WNMgQaJ2OnUWyyW6XF/55i4j/ElId8ZWr50knyNYCppJpJS+CAZ89nSfAr/PEMLcej+AOdvIoREcmfmR99stHZ39U0EHLDifRGYrLc3x+aZJ9xaVQYiqDa1Tar7h0GpEFodAKEcMX+6ZdvuzoDfX/R01sc4T6XI0DBiQg/6r0x/KduPYK4ftg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(82740400003)(7636003)(83380400001)(2906002)(356005)(86362001)(8936002)(5660300002)(4326008)(7416002)(70586007)(8676002)(70206006)(41300700001)(82310400005)(40480700001)(186003)(16526019)(26005)(2616005)(1076003)(426003)(47076005)(336012)(6666004)(110136005)(54906003)(478600001)(40460700003)(316002)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 20:27:25.4340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e37f46-7fb8-4ec3-25ac-08daf800149b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
Cc: Alexander Duyck <alexanderduyck@fb.com>,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 pabeni@redhat.com
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

virtnet_rq_free_unused_buf() helper function to free the buffer
already exists. Avoid code duplication by reusing existing function.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/net/virtio_net.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7723b2a49d8e..31d037df514f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1251,13 +1251,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
 		dev->stats.rx_length_errors++;
-		if (vi->mergeable_rx_bufs) {
-			put_page(virt_to_head_page(buf));
-		} else if (vi->big_packets) {
-			give_pages(rq, buf);
-		} else {
-			put_page(virt_to_head_page(buf));
-		}
+		virtnet_rq_free_unused_buf(rq->vq, buf);
 		return;
 	}
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
