Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB71C05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 05:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D01160BEE;
	Thu,  2 Feb 2023 05:01:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D01160BEE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KSLjgc2S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k4RU0jaYAWqq; Thu,  2 Feb 2023 05:01:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E50EE610A3;
	Thu,  2 Feb 2023 05:01:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E50EE610A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C06C8C0032;
	Thu,  2 Feb 2023 05:01:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9C49C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 05:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A451B4056F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 05:01:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A451B4056F
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=KSLjgc2S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pL-mydBqrDTZ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 05:01:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07907403E9
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 07907403E9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 05:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jthc8E/IAn3rVTyIO6cQ7b9iQvpRnRwHUjsREBaaO6hl6LqTjJd4AvyECE0wsDkLPumv+jLnR3cXxvLTAvsvObSDeSknyW46dgmOwU/ok/RptGniM2+WPwz+umT0kiDVsPWBhWc9jYHknIFyInpbEFCTNteYAXWTjTmj4bBzCOHj+YQP2C3tBzxvnL3isn2vJTjGdREvxBF+7J4hQXi+tzlltw6B5Lq/+tVrtpuNGFRgpeliufg4hEEW1yS3OYYQVuXY298tR0N4F9s3h3e1YRZbbOlRpvgKoRVZ37U2NxzmQ8YdH4ltuctMQppPtXaBPYoGnwwgB6k6y+3zRNBAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I/diG3QnC7clJPYiRr0UXMWSF6BiaRsvuJPmh+r5m8=;
 b=dRL9xvUb8+qdNnwA7UsecyeyBYbHgZZ+mS6HpvM8BmuO1vTxb8XsZ5GckZdagQ61GVSGWjXuayCKROmy1yH4C5ZXpygBQLINxjCxmuQoksK+qGqIWjXkL/n5b6Nj9m9tqvZEbew9JLtXQZDsn4wlwDyDzySclisQVUmylMCj/G8J/zWvZVbv4Fl54p5Rpif0vs2MtQ13MwIBKfGM48mAFVFw99a0FvLXlT4cv59fNosNInc+A82/b4XAhwxYZjKYnCjA5S5uNM0ELUsqPdrbuZw9XfLtM76PzsOJ0VbCTDalEuQctG9wYK2GfCGF7bQk6JzPdAkR/Uin7Mdzpp7XAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I/diG3QnC7clJPYiRr0UXMWSF6BiaRsvuJPmh+r5m8=;
 b=KSLjgc2S1xhtO6vUALAM+RWGTZbgPMmJ+naV7jBabG9DpE2arIoFkfZV8u5oBXsHJecOvzGN3dXzhc7FMMGT5/EMESuNCMnRoWwawZoDmd6R4dX9QIXj7NSCqR+hXSgEMGMg/Dq0Qbt3j7ch8r/Onmxkz/5mEdSp8wIN5HIV+UMe7tND4gpelLRMYxlaWrGl7OAVwgiHGLQpUd4WZJGh13S8ABByMt47zmXMzquz0d+yn1p8DUYauJ1vq37vrUXdPgFS1Xg0ckza7TjiIoHz1/j3hSrdOAXbZdwIsnru9nKu/ytmHSV01dBOAwnJW7WVr4Xmj4Qd2zPNngdbEKblaQ==
Received: from BN9PR03CA0480.namprd03.prod.outlook.com (2603:10b6:408:139::35)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 05:01:18 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::23) by BN9PR03CA0480.outlook.office365.com
 (2603:10b6:408:139::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25 via Frontend
 Transport; Thu, 2 Feb 2023 05:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 05:01:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 21:00:58 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 21:00:56 -0800
To: <mst@redhat.com>, <jasowang@redhat.com>, <davem@davemloft.net>,
 <kuba@kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH 0/2] virtio-net: close() to follow mirror of open()
Date: Thu, 2 Feb 2023 07:00:36 +0200
Message-ID: <20230202050038.3187-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cee5f3-4e1d-4480-d751-08db04da84db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lP/okB+6Jey7nkxmzQloRQ/0q0eW/rxYqiEUERy8eRLvGhNE3rxnnbNuWW1jqNMFvH0xa9Mw4H3v6DCMzB9+UV736HbJTdgdUElRM9UavhsYqgrGCyn/qKhcp85uqh0fqjOHUdV1k6Obt5pvyfH7VCMpsvhkyBiEI2E2i5peIu4EFP2blYTUKnGW6qbxyJ4W8tJxI0CGfFB6Mrd/d/H5SnG06U2Xk9THu9okxPyKYxqLM+Gvtn6hZHMc04/sr6++u98BhLUzl8zDKqJNNEPoKO8AQHptIzxwWrwXRAXVJxUtFw9hsGgcVL+L4xNaQ79JfUTqto+63dmnp5S6S1pXuZT5WPNC+0cWaR+AkOgsJ1GjzUE213lw8ppfcWAKtAbPNceUGJ9gMI0XKr9SKc6r5PK55cFLAm7RGKWtkSV6UGGD/mHnoDYKiIQhFOyJ72Lmgfuzqdnrba7DrvQ6IIryeHBaqGAnkiNRzXU8SMpMQA8DZO2duayawPgU0M7Tuj52aR4X0IVNhF0zCHf/XjYfedjl+ZiDK872pGb5aDu8zKVJl8+4FjJyVSsOxpP1ix5pS3wyHFdAsAiUmTLvmtVzIgNu5acOuM8/bAtBYPrvibt9xNgg7C1eY5cr3PahsGFOvcuD5qfNWWzDhpD4fY9sYp622CqtMP2Me71gogX8zZIs+TRo65orQwvoW9HbOj2OQBlhySr5UsPxiG9NnyuiQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(5660300002)(4744005)(7416002)(41300700001)(8936002)(478600001)(36860700001)(4326008)(47076005)(70206006)(70586007)(8676002)(107886003)(6666004)(26005)(36756003)(1076003)(16526019)(186003)(83380400001)(336012)(110136005)(2616005)(2906002)(7636003)(82740400003)(40480700001)(40460700003)(86362001)(356005)(54906003)(316002)(426003)(82310400005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 05:01:17.9407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cee5f3-4e1d-4480-d751-08db04da84db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
Cc: hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 bpf@vger.kernel.org, pabeni@redhat.com
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

This two small patches improves ndo_close() callback to follow
the mirror sequence of ndo_open() callback. This improves the code auditing
and also ensure that xdp rxq info is not unregistered while NAPI on
RXQ is ongoing.

Please review.

Patch summary:
patch-1 ensures that xdp rq info is unregistered after rq napi is disabled
patch-2 keeps the mirror sequence for close() be mirror of open()

Parav Pandit (2):
  virtio-net: Keep stop() to follow mirror sequence of open()
  virtio-net: Maintain reverse cleanup order

 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
