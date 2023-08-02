Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9B9C001DF
	for <virtualization@archiver.kernel.org>; Wed,  2 Aug 2023 17:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CB5B8208B;
	Wed,  2 Aug 2023 17:13:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CB5B8208B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n48r0S6i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kLUjGjpIQFTa; Wed,  2 Aug 2023 17:12:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B94618140B;
	Wed,  2 Aug 2023 17:12:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B94618140B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91EE0C0071;
	Wed,  2 Aug 2023 17:12:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F12EC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 17:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28C928176F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 17:12:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28C928176F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aTTpNp3ofp35
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 17:12:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::617])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C80582136
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 17:12:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C80582136
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdeMWv6Oh+cxvPRyWEy3tKivLNTuHV75fPsBHQl245wntz1Cd+rg9d16PRVjwnwuFrzUBWaBJnmddY5byxTVR1SFXdU5m0JymN4fZgOLRIVX9ZDuKkA909Cst5FlSP4itC91ztw8j78ETENm5jrZmM8K/5aKX7P8+du90mTpVZvF69mxbGbxRZUmfshi1XThPcAkSBh8rwWoWUvzK+jMET4Jz78LWyVMu0zgFVRS4DOEAtJlXrSZ+eaxSLk7IzhBxWuXIBOnh5LqUNODuuDJHJIcye1fgJr2v/4A/FSZx1x7ujNRMJqySiKalsloaGfQDl20dwhKhvZnSRGLr5NVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLGNZq4aSRD4xDkXIi5veZzG9OCBnia9Zx3catdaVCM=;
 b=RR8ldGgeHfXGYS8jR/nFGLppXYFXGAvkA61kT7DG90z/vP2HqdcTKLBwGCMIFVG75djQ9aYnR99UtfsylI7XSYZqAPMNGqoVc8VFCkGPZQcB/8PbqJk6qzrP+a8IUrS2y34AwtBtumVGVLnnWvcOtwNPQVFMekJavrvap6EWXoJHKe+sYSJ1pBTOCEJUi8UFVsereZtpD1WlkmHNErFX9ipbqsnKgZzKulSogC5kQTryrXUv9EdFsuP2/9lM/jKNupG9/JCtLohC7/k5hyWYfyaD2/yhLc8Mk8Pf42zvpNZPLCWnlXhKH/zwFC0uWQAMbHdGh4NHpz8cftuP0KY+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLGNZq4aSRD4xDkXIi5veZzG9OCBnia9Zx3catdaVCM=;
 b=n48r0S6iEHXmwsr1hiW85ULbzmlhIeImf0MjM7IpRPSpWqp6xk74AZofxACCZltVP5cMIhS3A2ei2/+oiBZKG01rRA99rLlzYiG1iughPIsAZP1ArOK7a1ky9uaT5inpV02hCaQnueH6sTmK6VVk2b8Te9hFUsitWwmUmx0pcd4XlYnhpIxXavUdb3HxgqeYaFbIdsL7qFWpOsn7agma+cPBH9P21++NrfyjTFtlt3NzSkCugyik6/s2TXnRF7a1JbhmzPD2Wxn11/6wTgGuVbplBq1R0Gv4V+/Y+S1bppjMEiYfXXrBZlW0W1MkFguoVYAv1MQRvtln2S2fi1iFEg==
Received: from MW4PR03CA0064.namprd03.prod.outlook.com (2603:10b6:303:b6::9)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 17:12:52 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::fd) by MW4PR03CA0064.outlook.office365.com
 (2603:10b6:303:b6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 17:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Wed, 2 Aug 2023 17:12:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 10:12:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 10:12:35 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Wed, 2 Aug 2023 10:12:33 -0700
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH 0/2] vdpa/mlx5: Fixes for ASID handling 
Date: Wed, 2 Aug 2023 20:12:16 +0300
Message-ID: <20230802171231.11001-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DM4PR12MB5374:EE_
X-MS-Office365-Filtering-Correlation-Id: 262abb30-4129-4907-b150-08db937bb49c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biI+EvAGhE0rAYume5AMoadn0cejD50/e6+NAr7dczDnGjH9xGgYgt58YrfQxVK4OtOG54QAc7oYuxxEonum7ALjaAsKXeW0K6weWVRygYt7jFYKEMdQ0RC61uuh0f1WwSyevndRY6YDpqqDMJtSaCW3Ysc2+b1J8RpGWMBV5Z17tGdkEU5lUhleAGUKBUKeK0OAWdGE2+T1pZcPkMUYfslfI1GsBY0/RNfmvLU1ijG9IMBgOJ9TXNhoz1nX+83XCbyZDHItjo0gw1FI3A5Ll7OLEs2BA+uHYAfDWNwQDD147o7lLcW7Ir5BBwxjAvrc7JfaBnYXc4MR/EJG7/+QFRxoi5Z/afVCiqJ2kAtWnLHaTPhGzLFnbuaqnMO2nupcwajtNq5sDksfeJ1NN3j/oMNO+u6nEIFw9nowjRIhZJC5YWCK3oRf83pkkQn/EHClmJzr7IwuZb5rYDTq0VGsvN3+cuCp6YcneA+LnNTsubVT+mkzStWK6b6QCbFMj3oZfLoYkdAhOmxWJ9SuLVb/Qnw56CvNNVB5kAVWlXgEa23ICy8c6UvPFgcRAOzKDh8SI7juiA/5pchyMe6RNSm4dYUSuuHZ/FvQmF4SiJlwOJ/9KD+5aN9zsan3kc+krQHIvZLeQQ8QKRGxZpJ0DNkXzaeX07jDJNqwDWw3Gv03R22hxfLjW+lhphu0VauKR1pOWNVl+0unAZuP0Z8aNSV09cN1DIiugZXA+BHS0Pc4v5Tyo+1k1HWgdePAplziavPUm8OIOPmEEYR9Dig4xnbucT9GXIn0G2Y2FNiQ21bhzLo=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(186003)(336012)(4743002)(40460700003)(2616005)(36756003)(966005)(316002)(478600001)(54906003)(7636003)(86362001)(110136005)(6666004)(70206006)(70586007)(4326008)(82740400003)(1076003)(356005)(26005)(41300700001)(8936002)(8676002)(66574015)(4744005)(426003)(47076005)(83380400001)(36860700001)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:12:52.1923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 262abb30-4129-4907-b150-08db937bb49c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

VGhpcyBwYXRjaCBzZXJpZXMgaXMgYmFzZWQgb24gRXVnZW5pbydzIGZpeCBmb3IgaGFuZGxpbmcg
Q1ZRcyBpbgphIGRpZmZlcmVudCBBU0lEIFswXS4KClRoZSBmaXJzdCBwYXRjaCBpcyB0aGUgYWN0
dWFsIGZpeC4KClRoZSBuZXh0IDIgcGF0Y2hlcyBhcmUgZml4aW5nIGEgcG9zc2libGUgaXNzdWUg
dGhhdCBJIGZvdW5kIHdoaWxlCmltcGxlbWVudGluZyBwYXRjaCAxLiBUaGUgcGF0Y2hlcyBhcmUg
b3JkZXJlZCBsaWtlIHRoaXMgZm9yIGNsYXJpdHkuCgpbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC8yMDIzMDExMjE0MjIxOC43MjU2MjItMS1lcGVyZXptYUByZWRoYXQuY29tLwoKRHJh
Z29zIFRhdHVsZWEgKDEpOgogIHZkcGEvbWx4NTogRml4IG1yLT5pbml0aWFsaXplZCBzZW1hbnRp
Y3MKCkV1Z2VuaW8gUMOpcmV6ICgxKToKICB2ZHBhL21seDU6IERlbGV0ZSBjb250cm9sIHZxIGlv
dGxiIGluIGRlc3Ryb3lfbXIgb25seSB3aGVuIG5lY2Vzc2FyeQoKIGRyaXZlcnMvdmRwYS9tbHg1
L2NvcmUvbWx4NV92ZHBhLmggfCAgMiArCiBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgICAg
ICAgIHwgOTcgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCiBkcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMgIHwgIDQgKy0KIDMgZmlsZXMgY2hhbmdlZCwgNzQgaW5zZXJ0aW9u
cygrKSwgMjkgZGVsZXRpb25zKC0pCgotLSAKMi40MS4wCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
