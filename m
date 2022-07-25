Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE680C43334
	for <virtualization@archiver.kernel.org>; Mon, 25 Jul 2022 16:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36CE384C86;
	Mon, 25 Jul 2022 16:33:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36CE384C86
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256 header.s=selector2 header.b=D73W/bu0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fhSuwSFKJexi; Mon, 25 Jul 2022 16:33:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9A9A984C84;
	Mon, 25 Jul 2022 16:33:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A9A984C84
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 746E4C0035;
	Mon, 25 Jul 2022 16:33:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3CF0C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 16:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A7A141B34
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 16:33:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A7A141B34
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256
 header.s=selector2 header.b=D73W/bu0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eDxbrxb63dfo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 16:33:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D1C141A51
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D1C141A51
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 16:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tno9IrpJxL6C7Y173SGByyp8LEpRsGr4but+qIVnRqhZUDooWfz0P6sJQ72vIEGe+U/EB6LS7QuCVyTmtJlliiBTFdBUMrJWk+5jXPJlVzQbGBu4cwpPrrBEOI9uNVsVvPpQC9pE/MaymavXGmFneVdAbMIn5wnUoZwiQ990ixmovD4bHp6RvuQxacPSZgKBrZeJeTuwTF6X6lRQAmcCz6cTxMf1JEcLv7m3ltCO7GjKL6yZBhnCPxsEGZPsWLvooVtfv3QMumNLmiQupQuOYi8kj5FQEn9KdOABgV3qShp7Q74/bAnGJSV9E2vN5/UZnCpZROWgI2E1UXTYNIgjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiM9y2Udj3bVUJpdjp2RS2ywOn/N7tnAMgv0GqlIMhs=;
 b=UJ7D1AtCehwC8g54OWCGmnjiiMzZLS7mM22odfVOHBBZJm8Y/Uu/jFMCBf7qP1po4NLXpDioTxOSJxoe5QjBjW6wBc07/qDzEaO8TBYiE5y6h0ldhASmbHYs4EMhWjnvWw/jZnbq9YpvEN6czDvAuXWV6GBiVjrFw4z6ZwRsqNz+ochl5caapSoepIsjMNAPoXSQU6q/DScUYWFdx2/VDxrn/RaRGaR+pTt9pihj54dkQDMZ5TkkVYncDAmIrYuepNJUgT6NCynYhjonsoxqw6MhKTLqNa6buH9FApZjqFUH5AhZ7QevPG4Xo6Iizxexsm8A17M3IDOVzex+irRzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiM9y2Udj3bVUJpdjp2RS2ywOn/N7tnAMgv0GqlIMhs=;
 b=D73W/bu0C/IRGi1MLmkgB9fu2ynoFCNAvUhkg7HHC/o1GqqNb/bgG7wAmyJggBnZXy7YZBQ0+EfhZLTNBRpsz2zcbwQ4uWp7KD/+EBDhHvcxbEf5SemOd1TQQD5dzfaVbqk/5uhEJKkiSWm8PpTy8nAzceD7YI/anCPVd4HX2jg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by BYAPR05MB4725.namprd05.prod.outlook.com (2603:10b6:a03:4d::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 25 Jul
 2022 16:32:57 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::959e:de9c:2ea:213a]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::959e:de9c:2ea:213a%5]) with mapi id 15.20.5438.010; Mon, 25 Jul 2022
 16:32:57 +0000
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 gregkh@linuxfoundation.org, pv-drivers@vmware.com, bryantan@vmware.com
Subject: [PATCH] VMCI: Update maintainers for VMCI
Date: Mon, 25 Jul 2022 09:32:46 -0700
Message-Id: <20220725163246.38486-1-vdasa@vmware.com>
X-Mailer: git-send-email 2.35.1
X-ClientProxiedBy: SJ0PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:a03:333::22) To BYAPR05MB3960.namprd05.prod.outlook.com
 (2603:10b6:a02:88::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61e56801-8766-4ff1-1ebb-08da6e5b5495
X-MS-TrafficTypeDiagnostic: BYAPR05MB4725:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpI7OB7nqHpJqFdbwcIEy+S1CP7sgtiOp8m2VIXDVdxEdPjkovrKKZ8cl0aoLrROsSGnUvEMXVz7BNnOJI9PmSQwE5b1Uvq1jQlQTeWOhTqZc/t96erSVdqdfEYNnqAxqvYkWQoT/BHeanKkw3wLcDh8My3t54mLgIno1cVWJ7q1xK5Zg1ilNvtmpbwLqDoB3pIgDDl1RSOYVixiiATA3E4l2ulEgT+XTVaApXdj8r5KAXtXPLdOEfG8g+P2K34PiN9cH2sybmskSP3aTp4k2eXLWCFJ3LkfFltemMkmf/O0nDZwAxmG4wM2n7sOKZb/qb8U6m0jiQ1XY/SRnyOXjrABRnaNGM/qaqkKpiKMM64bWFvO6yrebpyKF7Mbi9rrtZm2jyEGX/QS/ktS1yHoYvfMKUe3IUix00/TdaiAhvWWc4Pl8TEmLpIe5y+w6F1gZVbCzXZMh7aaygH1rWVNysBXfI49Ys+j29GNIrDM6WG8jBc/iWOWn3MEOApPFVhuDImK2YzMjUE+ozI4bQ0R/nC/l1P9qxG/W4U10V+DJgME5IMyXgNeSdGZaSKIBQ55DFGW16+sP23rryMn/Vv7JVvf2x6raxj2mRIr7SV25fkzVbx5d3clvB2NKiKQ+JGvv1b8ayhxt8T4+1XtnZyzTI8pS/xpPGVjVyrmyY7KdR+z4oTqK385GVZg5aVDp7r4PYhfrnyyHYzMLk+BzNwkMwPKBcjPQ6qgnWXfjfzLgyysi58L8EI+7m9Qc8BQbRQ5EyZa/3eZsT++CYm0PCPoCRZ5XAWIclbq2iyTq8rM3Dk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB3960.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(186003)(1076003)(107886003)(83380400001)(66946007)(4326008)(2616005)(66556008)(66476007)(9686003)(52116002)(8676002)(36756003)(6512007)(41300700001)(26005)(6666004)(2906002)(6506007)(38350700002)(8936002)(5660300002)(316002)(4744005)(38100700002)(86362001)(6486002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EwGnlw5ccw9v7RVynrqlu5XBfmXLTUDBAsqnsfKYzMUNc8n5dHY1I38HLFVj?=
 =?us-ascii?Q?Sb97NUe4jeoczXbJidOLaBXUZVYYXp0bHb3EAMiswzc5b84400Mvq2vNXZm+?=
 =?us-ascii?Q?ZXXLYUfBh0eD+rHxve9t0I6Nyq57Wmi9owjff1h9CYya94+qJHQLmGA1AcSQ?=
 =?us-ascii?Q?qBGQuVka66LwlCUSxWnNnsDGmh1ZeNZrYetmFn0r4Ypnq3e8lLxJmfE6a8nh?=
 =?us-ascii?Q?7AccTP1GvpHzsYgZqY6YF4I2PiOjINX/Mr5SJ2inMRXLM3VOEzXKMYjFJtyp?=
 =?us-ascii?Q?k2OwVaNOB5kLhN4v4DCvItBB0ThoVpIG6XLmD3sTD2GJawOTyh6yWMWbH3tJ?=
 =?us-ascii?Q?HLx34DDt+HK15wAcBnQLVpzMkaRot8K69AsS+xf2kb5Cj8nFoK+DqnMGimIP?=
 =?us-ascii?Q?oVy26hmEIGUQvnx4/hlvKFHdnAqmSJQ59ZJ6loEW0ZEDvqy4P87W1/bjEp0z?=
 =?us-ascii?Q?HO2vOrr1qHTBApPkIxzDQXkguta1PdUzcEsbVoKD1i+YE4dH77JaKr9XboFI?=
 =?us-ascii?Q?73hMPgQ6rrCBkzZwGhXLUqhlmUVWpc8KrcnqwLCbCPZ3t2biMzeFo+ri+Qs3?=
 =?us-ascii?Q?VxzzSy5YH4q+BFLlkKuIXnkZDCt1Wc8TQquh3l85pY7X8nWtmk/xerpC4oi5?=
 =?us-ascii?Q?bb5Xe8G+iNQjQk+m0gA0A/YJUAksAZ5YU1z07LOlBsQH2cWvQHhjiKr0afwj?=
 =?us-ascii?Q?Kqb2u+qNPZq6m0Qvqg5c+w/OCP+g0ahdgK5tyvJLYlzAWCDBl2Yy5ysaPbXn?=
 =?us-ascii?Q?GX6iIRBoAYsNXvd0bdqMzzYcbukkZSm/kgto7PAix9Dfv56Jj2PwIEgpYyzj?=
 =?us-ascii?Q?EuPR6hki3LBkiYSYLEOkbyxvjpLJ+Gmq0IYpg/0oUWZfXYKGXN0+VB+FRrNb?=
 =?us-ascii?Q?vcDfHc3GZCHLy3EhBjEK+qf/BK+g1gF+kxuuzxJQ5ZUAfq1s188fja6317r6?=
 =?us-ascii?Q?gbAR46c461cNkz9sqLv3z216uL/KdBV8HDMliou4PvjBeXxoKxVOdk1VMIY7?=
 =?us-ascii?Q?3CGD92vuNQQA/sPTlPQeAv9A6Z94l2K7Y3PBGCOJ/MnBbGYljxbwhquneft+?=
 =?us-ascii?Q?GJ+IL6Rl9O2nEfuxDECxY4zyAzci4Xdy4FUvP3hZE5KV0RaC+DPX90rVlZsG?=
 =?us-ascii?Q?YtE10ldMTJ9XAb1AmFmInzv4YoaL0P6qzACOUSZTfNFc3c+YFezaj2C8GuqP?=
 =?us-ascii?Q?Y3M35KIXbuBTdYcaTCefFVYxkHwypbXcdpFoQpZ1AelNady3NPWoq78SOpP2?=
 =?us-ascii?Q?ccq7D+9YDwkWnGijfTVaRqpVrckHvVTOhLD9ZN3m7vmyWSN7wb+DbqYgB1zc?=
 =?us-ascii?Q?2aCorbvBRM05QzV29lYtwB4BhRV/zMDIv76wbkjHj1K+o9rVBK2g9PdSP0T9?=
 =?us-ascii?Q?Cqc/+BdQ3v1k166lpq3OQ+f6Xec7gV7TPJ8Vq376Q9yHtGCGRCqpjYXaF0FQ?=
 =?us-ascii?Q?X3i/WD7dJa5UE8gkqp1te3nsXMN6LPoeAMGLZRyBh4gm9URFQHhxhGLc7XHp?=
 =?us-ascii?Q?rvfJtpNBKsjDxivrGunH/pCGxfTw89LKiSSLFqR1HY9IpAgN+hCptQQe2Bum?=
 =?us-ascii?Q?1nmelGL86viCPwbuPe4=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e56801-8766-4ff1-1ebb-08da6e5b5495
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 16:32:56.8984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXq4LlqBnlmErFqsvBHyAl1p/wi0D7OmTedEU7W4FC8Hrvp/gpF2gxTHI45PpCazTeZc+xkvVhWBSAd1NvYwvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4725
Cc: Vishnu Dasa <vdasa@vmware.com>
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
From: vdasa--- via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: vdasa@vmware.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Vishnu Dasa <vdasa@vmware.com>

Remove Rajesh as a maintainer for the VMCI driver.

Acked-by: Bryan Tan <bryantan@vmware.com>
Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25a9365e0cca..356fc4014c2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21706,7 +21706,6 @@ F:	drivers/ptp/ptp_vmw.c
 
 VMWARE VMCI DRIVER
 M:	Bryan Tan <bryantan@vmware.com>
-M:	Rajesh Jalisatgi <rjalisatgi@vmware.com>
 M:	Vishnu Dasa <vdasa@vmware.com>
 R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
