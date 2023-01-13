Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9634EC677F1
	for <virtualization@archiver.kernel.org>; Fri, 13 Jan 2023 22:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F2F161151;
	Fri, 13 Jan 2023 22:37:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F2F161151
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=As0GPXL4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DkH3lMDr1iiW; Fri, 13 Jan 2023 22:37:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 86B21607F6;
	Fri, 13 Jan 2023 22:37:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86B21607F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63CEDC0070;
	Fri, 13 Jan 2023 22:37:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91692C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 22:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5038A6104E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 22:36:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5038A6104E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RG2EESuS8hxQ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 22:36:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87EDC607CA
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87EDC607CA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 22:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbnFDZ6uMYkHjea0JfHeW+gXT1Ask2At0/OoKDkuiIdNYWs8ZiV6z3Iu+v5nTeZDIzj6YHQ+h9Cp4UzgTLXi51M52yQgoL4Itx6+1L6gRX11M/3h3wVaHXWNiWdgAngYNohimDX5W4lTNugQn7Gs0itE8INpscHVgMxQ6rdgHLxXGVFRc8UItolNH0hbVEQnjwwXBOa6Ml1Wim+XhI0zC8b5DQOEjrd7tgXiMe5YR3Sb/HZYG33t5gaVqlsYFltxnjDrhG7t5uD4jADTxiIfk7qgkYA3BAb5WXBUxB1AX+gs92DBkYkM2Xj+FJJzaCoT/Ed9TmR99jwPg/amTGqz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0s46+axoyPywsArOigxYh66dNi0KcHQKFeftt1raxY=;
 b=Mc5eGWZ5Vafwo5J0vwWNiXkeV/1k2nyR+gjeeQjnB0I7J90SUG2wckb8VsWr5f/rZ62BNsR6c/8ChJP7hyZ0d6WxiQd63xbpVSVeT5QnIGT1HT6hgJWv2TonzGxY8vDXlgKpDs5g1PwtM/0PG1KkKFsVKVVzFJDViwTKdE2rils5lBeTYDz0RtGz9KwD0jvN1L50hCT7E7FNrKOqMf6APB1JfhKkV1LRe5/K55mMeXWNlGt5/Wz0tgsED63sQzof148jcRkV6ttsAFjKnvljR5T9jgVM7rb7ZGAWOdv4xGLhPrylczhwUoTaVMjduskUyUZCy2GY4bzZBcS1VYywBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0s46+axoyPywsArOigxYh66dNi0KcHQKFeftt1raxY=;
 b=As0GPXL4iw/43AQo7LIWI9T+sQltaM58dvI/zfWwB79x+oyD+qAo6GQ4p4u4weQJ4tUzXP67FSKaOJ/T1yxa18TAUCaOAux+hC3mSrveMyJNm9Vbg1pRJDMyhndF1Z8TzL3Kjvyhl8qeUHOi5ZbUpvn3TDlKVvLraImSMNSbKTGSzqZwZy8xl1M/y/eocLiOIy+cxZkTFNU0F1dvZ+JbtojPyna8e0X1aeUCFyVeiYnJLsTrdO5UcxqkFEOnsgWSNJwr+5KmXWV7QV+8L1F+7iPOFJK6TmzVcKFpmZDtreQuKmIzggKIZ0mzNFNT2t12kOB1i/V9pfUDiPtW3zVuUA==
Received: from BN0PR04CA0176.namprd04.prod.outlook.com (2603:10b6:408:eb::31)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 22:36:54 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::83) by BN0PR04CA0176.outlook.office365.com
 (2603:10b6:408:eb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 22:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 22:36:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 14:36:40 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 14:36:39 -0800
To: <mst@redhat.com>, <jasowang@redhat.com>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <kuba@kernel.org>
Subject: [PATCH net-next 0/2] Small packet processing handling changes
Date: Sat, 14 Jan 2023 00:36:17 +0200
Message-ID: <20230113223619.162405-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e10f87a-2c76-41c7-edd6-08daf5b6ac20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jkAxF+tWrR1nLy1PqA41Gm2pF04SdmCIJogj3BnZpi5fY3SRgrKrUv/RabEyV/7JSP1d3aEiiHH3CEKoVF8t7U3RCo9ecMQvodS7z2M9iVhTC7f+Knd07FI89I4AKwyTRtdM/sD9kCRJD8cmde/Zia40gfVcNRsjGX2ayvdyUz5c3piK9LN0LPqr417fzf9NN9VploZjRl+zm5c8ZVDNC82swV5mAgLol5+VUsxWDLGnyDUAps+E2YzanGdm+xKlBjrH1mfrir5nvwB/eqYCuJTcK4qD3ssSE6Kv0aTtdVF6/3cpzqmyR2QjG8SkA2/wJDnzi2hvaft321dfmNeSM9R0Aa8kfcLm/TWyV//L0Ddtmi+z79E+AKahckV56mi2vSehO2e2ircxyACwWquiZ2+TnJnaXdNUKiwlVP1iGocVmQ+4qoo2Hj69qnawSSzuUtbAgjCdpOqGrAkS6yuVZG09cpAuCnS8bpBSZOCek66hBKpevUrh+rK9NsFh3u5Y99g0Xrc7kXnmgoo8d1Tk6UdMNVQcC53/VLWWla3YQ6LVeXbcjZjGmQ3Efink2jDGPoF2J862isRSkoeObCONqCJCmxQhy/t0xfcYQtspv/ew/eb3WIQ23SxuSJ/XXci349v8yF9Zz1d3Q1108JkbiIwv7qGZrk9HBkME9FcDcGhfkN0D6dymHTcB0dckRUjK5xs5wSv68+X1gavnBZDuBQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(8936002)(5660300002)(41300700001)(54906003)(4326008)(70206006)(70586007)(316002)(110136005)(8676002)(2906002)(7636003)(356005)(478600001)(82740400003)(36756003)(6666004)(82310400005)(26005)(16526019)(107886003)(186003)(36860700001)(336012)(47076005)(1076003)(4744005)(426003)(40480700001)(40460700003)(86362001)(2616005)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 22:36:54.5163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e10f87a-2c76-41c7-edd6-08daf5b6ac20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184
Cc: edumazet@google.com, pabeni@redhat.com,
 virtualization@lists.linux-foundation.org
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

Hi,

These two changes improve the small packet handling.

Patch summary:
patch-1 fixes the length check by considering Ethernet 60B frame size
patch-2 avoids code duplication by reuses existing buffer free helper

Please review.

Parav Pandit (2):
  virtio_net: Fix short frame length check
  virtio_net: Reuse buffer free function

 drivers/net/virtio_net.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
