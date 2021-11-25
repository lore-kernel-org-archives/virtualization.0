Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D10C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 18:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 069016075F;
	Thu, 25 Nov 2021 18:09:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XufMuauwtOXI; Thu, 25 Nov 2021 18:09:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9C1236070F;
	Thu, 25 Nov 2021 18:09:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A33EC001C;
	Thu, 25 Nov 2021 18:09:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94F5FC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 18:09:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DBBE80F44
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 18:09:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XV-mGuvLE4Nk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 18:09:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D78080EE8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 18:09:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpRUEf8CV+cI32ang0Zl4w7yPh40FINIBDeYYiGHcrkxwqD6GHbFVxza7rkEUFmHXdK6YbJvBEthX/b6vGfr4UUJNJiiDezKdEJaC6j1Hmjw5FWofujGxBqPCEhHecmF3AdGPvXMH3xemajoQwToMlKTXiQqItNDB8j8NjlVPsleWBMC1xk7ZcRYOd5NvndM1To9H6+nVIpPEh5JrjjDLa9AjXLnWEJYzSECYxAbLUtjnVjJFMVPteF+pr4Sp2UYwpMuoWl7/WWEn2PItclrzF0QNupwSbsGA/CrmbZDq3R5Tei3RJoq0a+pRsCTkaQde3nVXS6VSgCXoC6D7m8IBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPbO5jokEpnNzFmCmu/Yff4uVFFMSdRIenyqJoKCs9s=;
 b=Z8CfV5u4pKAM2JZtv8x22+Im6Ar8xhJo9/lf1+NZ4lOIlzcRYbLVmUmAGAaO6GQFCfJ3q4lP0Y85rc9YhGGZKV1SjhvIZSTHwbr/qkHW5eyIpyqP+pfQWSqcWGFP6GiKai6yv63oyVQ76X2jjk5EAJDPKYVKXjgqZMJfmnXVToWxjVrux+H46QyGoBm7CogVjcK5yFh4aNqEoUAg9EH94hySUZf2q4S1BxQKm2imQYfiu10dWB+EumElutJSVGYOGNMYCCUaxqsrBvMl7Ou6d8JdWwOzKP0N801rsDIDkq1B8zVFDYcisLvlHErcHsxsOobs9MLvgE2w4SKNE56pew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPbO5jokEpnNzFmCmu/Yff4uVFFMSdRIenyqJoKCs9s=;
 b=EWalMNbVqSNr1+D5hODVKQF9byq72ETJ+mDO94NXnTlIfiu/KI3+CUymGWq8ZPELlB6vbEY7ebbApuJh5AY/DqObsoOpyJToObnYyUmZTy1HLxJv6PCGQAxWs6zRb2gJ/4Ulx7WPHDE8X2T5HbZSDbY8vfeOqEzBpNc3TmuZZAFCrYPj8jMmYGCwmwwbUkclme0ug6GZcqRFW1+6cLCCrXLLl8Vp8sUYL55sTWw3pDh45toPf1UWgw+GXB7hR2x1QPMxYLLyTcztPY7PRrYbZaSOoevFbQc01aF2wWgyLmSHgdcF8CJoRJulW/Ny1AoYeCGMTVYJsrmYmWFF/tsHmA==
Received: from BN7PR02CA0018.namprd02.prod.outlook.com (2603:10b6:408:20::31)
 by CY4PR1201MB2532.namprd12.prod.outlook.com (2603:10b6:903:d8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 18:09:29 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::2f) by BN7PR02CA0018.outlook.office365.com
 (2603:10b6:408:20::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25 via Frontend
 Transport; Thu, 25 Nov 2021 18:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 18:09:29 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 25 Nov 2021 18:09:27 +0000
To: <virtualization@lists.linux-foundation.org>, <mst@redhat.com>,
 <jasowang@redhat.com>
Subject: [PATCH] vdpa: Consider device id larger than 31
Date: Thu, 25 Nov 2021 20:09:15 +0200
Message-ID: <20211125180915.649652-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ae7e1b5-b9ec-465f-e89a-08d9b03eb979
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2532:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25321740CF1C15E5F1936A73DC629@CY4PR1201MB2532.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzU2hqMpEP3omrFfQ0ndPnYwDcMTzltQ2UDzOJjYIzEXr1u+3xPNcH9qzZwgFE/VOnTijGc7tS+ROgPJ4jsMTIB5rGPwDuLBXBzNDFmI21i7uQTT9bwgDcm/QtTdBObYJQcRYGgRQC6SzJBAQrMWbMOwuQX+UOC32pE60BNYIlv7owPzIU27P+Ri9UwaE2xTwYz+XvLyeFnWJxSX7FfaJMgtk9EO/gxlShn0aKQdyEbuSsfnPFlwbfrTdIpcFz1pfZQosjv710Nrn19vGqQ60ms2WcKpSPL4ez8tDJDziokaUawafV47H3gTR7TMQq1X+I3Ht+lLf7exB1qqr4fQM7AVwL6IW/IvYPbo/jgfcHdBvM1GPgS1NG+Dl4uVmfam0uYPYWt/9BJ0y6lJEy1zHx3RPdjLvzRw8fKz/U+S5uGKytPCbNUYzVaZtA8WyJgvkoB6oEAwhfB0o+RfmJipp7Pm06AAomLldijrenjfzI3H9eyhwEJ0pXw1jszAIIShWmDz1QY/1yfp14Yk7SNE40r9lHiAFyuG90+r8QE8gj7nVPuI6voStCW5Y1SaYW2WOK1R+UJvkSMuOlZDTdQ94Og8GyeDjVQ57TKnm16y+jMjZfAdxJsWTxmypOrtfa5oH6YJuV39fe6m0VZEzjncYWdbTx7COpyn/WT3O6Qc8YvBxN2QmsiiA1CZ2VJOJ/XoyDPbZ/lqSum/SJHzuhelZQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(2616005)(8676002)(70586007)(6666004)(5660300002)(110136005)(508600001)(8936002)(47076005)(70206006)(83380400001)(426003)(4326008)(336012)(54906003)(4744005)(36756003)(316002)(86362001)(16526019)(26005)(2906002)(186003)(7636003)(1076003)(356005)(82310400004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 18:09:29.4039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae7e1b5-b9ec-465f-e89a-08d9b03eb979
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2532
Cc: kbuild-all@lists.01.org, lkp@intel.com, kbuild@lists.01.org,
 linux-kernel@vger.kernel.org, edumazet@google.com, elic@nvidia.com,
 Dan Carpenter <dan.carpenter@oracle.com>
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

virtio device id value can be more than 31. Hence, use BIT_ULL in
assignment.

Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a netlink interface")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/vdpa/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 7332a74a4b00..e91c71aeeddf 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -404,7 +404,7 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
 		goto msg_err;
 
 	while (mdev->id_table[i].device) {
-		supported_classes |= BIT(mdev->id_table[i].device);
+		supported_classes |= BIT_ULL(mdev->id_table[i].device);
 		i++;
 	}
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
